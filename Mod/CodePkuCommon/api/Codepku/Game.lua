--[[
Title: Questions Api Service
Author(s): John Mai
Date: 2020-06-22 17:57:10
Desc: Questions Api Service
Example:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePkuCommon/api/Game.lua");
local service = commonlib.gettable("Mod.CodePkuCommon.Service");
service.getQuestions(1):next(funciton(response)
    -- handle response
end);
-------------------------------------------------------
]]
NPL.load("(gl)script/ide/System/Encoding/md5.lua");
NPL.load("(gl)Mod/CodePku/cellar/Common/CommonFunc/CommonFunc.lua")
local request = NPL.load("../BaseRequest.lua");
local ApiService = commonlib.gettable("Mod.CodePkuCommon.ApiService");
local CommonFunc = commonlib.gettable("Mod.CodePku.Common.CommonFunc");
local Encoding = commonlib.gettable("System.Encoding");

function ApiService.addExperience(courseware_id,experience,type)
    data = {        
        game_id = courseware_id,        
        exp=experience,
        exp_type = type
    }
    return request:post('/users/exps/' ,data,{sync = true});
end

function ApiService.saveScore(courseware_id,gscore)
    -- 触发任务系统计数
    local updateTask = {
        type = "game",
        courseware_id = courseware_id
    }
    local GameLogic = commonlib.gettable("MyCompany.Aries.Game.GameLogic")
    GameLogic.GetFilters():apply_filters("TaskSystemList", updateTask);

    -- 加密
    local secret = CommonFunc.ConfigCodingKeys[1]  -- secretKey
    local data = {
        game_id = courseware_id,
        score = gscore,
        timestamp = os.time(),
    }
    --组合字符串
    local sortData = {}
    for k,v in pairs(data) do
        table.insert(sortData, {key=k,val=v})
    end
    table.sort(sortData,function (a, b) return a.key < b.key end)
    local signString = ''
    for k,v in pairs(sortData) do
        signString = signString..string.format('%s=%s&',v.key,v.val)
    end
    signString = signString..string.format('secret=%s',secret)

    local sign = Encoding.md5(signString)
    sign = sign:upper()

    data['sign'] = sign

    return request:post('/game-scores/' ,data,{sync = true});
end

function ApiService.awardUser(id,s)

    data = {
        courseware_id = id,
        sort = s
    }

    return request:post('/user-awards/' ,data,{sync = true});
end

function ApiService.getMaxScore(courseware_id,syncs)
    return request:get('/game-scores/max/' .. courseware_id,nil,{sync = syncs});
end

function ApiService.pickProperty (id,num)

    data = {
        prop_id = id,
        prop_num = num
    }

    return request:post('/user-props/pick/' ,data,{sync = true});
end

function ApiService.getSubjectsDataSTE(callbackFunc)
    request:get('/custom-questions/show'):next(function(response)
        callbackFunc(response)
    end)
end

function ApiService.getMaxRoundSTE(callbackFunc)
    request:get('/custom-questions/get-user-rounds'):next(function(response)
        callbackFunc(response)
    end)
end

function ApiService.saveMaxRoundSTE(max_round, date, question_round, callbackFunc)
    -- 站到最后，触发任务系统计数
    if max_round < 10 then
        local updateTask = {
            type = "game",
        }
        local GameLogic = commonlib.gettable("MyCompany.Aries.Game.GameLogic")
        GameLogic.GetFilters():apply_filters("TaskSystemList", updateTask);
    end
    local data = {
        rounds = max_round,
        date = date,
        question_round = question_round
    }
    request:post('/custom-questions/save-user-rounds', data):next(function(response)
        callbackFunc(response)
    end)
end

function ApiService.signUpSTE(callbackFunc)
    request:get('/custom-questions/user-sign-up'):next(function(response)
        callbackFunc(response)
    end)
end