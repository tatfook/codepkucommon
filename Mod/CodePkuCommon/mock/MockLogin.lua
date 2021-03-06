local MockLogin = NPL.export()

local ApiService = commonlib.gettable("Mod.CodePkuCommon.ApiService");


function MockLogin:login()
    if System.User.codepkuToken then
        return true;
    end
    local codepkuMobile = ParaEngine.GetAppCommandLineByParam("codepkuuser", nil)
    local codepkuPasswd = ParaEngine.GetAppCommandLineByParam("codepkupasswd", nil)
    if type(codepkuMobile) ~= 'string' or type(codepkuPasswd) ~= 'string' then
        return true;
    end

    ApiService.Login(codepkuMobile,codepkuPasswd):next(function (response)

        if type(response.data) ~= "table" or type(response.data.data) ~= "table" then            
            GameLogic.AddBBS(nil, L"Codepku自动登录-服务器连接失败", 3000, "255 0 0", 21)
            return false
        end

        local token = response.data.data.token or System.User.codepkuToken
        local userId = response.data.data.id or 0
        local nickname = response.data.data.nickname or ""
        local mobile = response.data.data.mobile or ""

        commonlib.setfield("System.User.codepkuToken", token)
        commonlib.setfield("System.User.mobile", mobile)
        commonlib.setfield("System.User.username", mobile)
        commonlib.setfield('System.User.id', userId)            
        commonlib.setfield("System.User.nickName", nickname)

        GameLogic.AddBBS(nil, L"Codepku自动登录成功，当前账号" .. codepkuMobile, 3000, "0 255 0", 21)
    end):catch(function (error)
        local errMsg = error.message or "用户名或密码错误"
        GameLogic.AddBBS(nil, L"Codepku自动登录-" .. errMsg, 3000, "255 0 0", 21)
    end);
end