--[[
Title: 指令管理 
Author(s): John Mai
Date: 2020-06-18 11:53:57
Desc: 指令操作管理类
Example:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePkuCommon/code/blockly/BlocklyManager.lua");
local BlocklyManager = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.BlocklyManager");
BlocklyManager:init();
-------------------------------------------------------
]]
NPL.load("(gl)Mod/CodePkuCommon/code/blockly/Codepku.lua")
local BlocklyManager = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.BlocklyManager")
local Log = NPL.load("(gl)Mod/CodePkuCommon/util/Log.lua")
local Table = NPL.load("(gl)Mod/CodePkuCommon/util/Table.lua")

NPL.load("(gl)Mod/CodePkuCommon/code/blockly/api/Codepku.lua")
local CodeApi = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.CodeApi")
BlocklyManager.categoriesinited = false
function BlocklyManager:init()
    GameLogic.GetFilters():add_filter(
        "ParacraftCodeBlocklyAppendDefinitions",
        function(ParacraftCodeBlockly)
            local isEmployee = System.User and System.User.info and System.User.info.is_employee;
			if not (isEmployee and tonumber(isEmployee) == 1) then
				return
			end
            if (ParacraftCodeBlockly) then
                NPL.load("(gl)Mod/CodePkuCommon/code/blockly/Codepku.lua")
                local Codepku = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Codepku")
                ParacraftCodeBlockly.AppendDefinitions(Codepku.GetCmds())
            end
        end
    )

    GameLogic.GetFilters():add_filter(
        "ParacraftCodeBlocklyCategories",
        function(categories)
            local isEmployee = System.User and System.User.info and System.User.info.is_employee;
			if not (isEmployee and tonumber(isEmployee) == 1) then
				return categories
			end
            if not BlocklyManager.categoriesinited then
                BlocklyManager.categoriesinited = true
                categories[#categories + 1] = {name = "Codepku", text = L "定制", colour = "#459197"}
            end
            return categories
        end
    )

    -- 注入指令函数api
    GameLogic.GetFilters():add_filter(
        "CodeAPIInstallMethods",
        function(CodeEnv)
            for k, v in pairs(CodeApi) do
                CodeEnv[k] = function(...)
                    return CodeApi[k](...)
                end
            end
        end
    )
end
