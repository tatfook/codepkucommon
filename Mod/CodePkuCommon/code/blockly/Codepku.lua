--[[
Title: 编玩边学定制指令
Author(s): John Mai
Date: 2020-06-18 11:53:57
Desc: 编玩边学定制指令
Example:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePkuCommon/code/blockly/Codepku.lua");
local Codepku = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Codepku")
local cmds = Codepku.GetCmds();
-------------------------------------------------------
]]
local Codepku = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Codepku")

local cmds = {
    --    获取课件id
    {
        type = "getCoursewareID",
        message0 = L "获取课件id",
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getCoursewareID",
        func_description = "getCoursewareID()",
        ToNPL = function(self)
            return string.format("getCoursewareID()\n")
        end,
        examples = {
            {
                desc = L "获取课件id",
                canRun = false,
                code = [[
local courseware_id = getCoursewareID()
]]
            }
        }
    },
    --    加载题目
    {
        type = "loadQuestion",
        message0 = L "加载题目 %1",
        arg0 = {
            {
                name = "id",
                type = "input_value",
                shadow = {type = "math_number"},
                text = 1
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "loadQuestion",
        func_description = "loadQuestion(%d)",
        ToNPL = function(self)
            return string.format("loadQuestion(%d)\n", self:getFieldValue("id"))
        end,
        examples = {
            {
                desc = L "加载显示指定id的题目",
                canRun = false,
                code = [[
data = loadQuestion(12)
type = data.type -- 题目类型essay表示问答题，choice表示单选题或者多选题，404表示找不到题目
question = data.question -- 题目描述
answer = data.answer -- 问答题或者填空题的参考答案
options= data.options -- 单选题或者多选题的所有选项，如果type为问答题，此处为一个空表{}
if type == 'choice' then
    annserA = options[1][1] -- 第一个选项的内容
    isA = options[1][2] -- 第一个选项是否为正确答案，正确为true，错误为false
end
answer_analysis =data.answer_analysis -- 题目分析
answer_tips = data.answer_tips -- 题目提示
knowledge = data.knowledge -- 涉及的知识点
]]
            }
        }
    },
    --      答案选项
    {
        type = "answerType",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    {L "正确", "true"},
                    {L "错误", "false"}
                }
            }
        },
        hide_in_toolbox = true,
        category = "Codepku",
        output = {type = "null"},
        helpUrl = "",
        canRun = false,
        func_description = '"%s"',
        ToNPL = function(self)
            return self:getFieldAsString("value")
        end,
        examples = {
            {
                desc = "",
                canRun = true,
                code = [[
    ]]
            }
        }
    },
    --    提交答案
    {
        type = "submitAnswer",
        message0 = L "提交题目 %1 答案 %2 ",
        message1 = L "时间 %1 题序 %2 是否合作题 %3",
        arg0 = {
            {
                name = "question_id",
                type = "input_value",
                shadow = {type = "math_number", value = 1},
                text = 1
            },
            {
                name = "answer",
                type = "input_value",
                shadow = {type = "answerType", value = "true"},
                text = "true"
            }
        },
        arg1 = {
            {
                name = "answer_time",
                type = "input_value",
                shadow = {type = "math_number", value = 10},
                text = 10
            },
            {
                name = "node",
                type = "input_value",
                shadow = {type = "math_number", value = 1},
                text = 1
            },
            {
                name = "is_team",
                type = "input_value",
                shadow = {type = "math_number", value = 0},
                text = 0
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "submitAnswer",
        func_description = "submitAnswer(%d,%s,%d,%d,%d)",
        ToNPL = function(self)
            return string.format(
                "submitAnswer(%d,%s,%d,%d,%d)\n",
                self:getFieldValue("question_id"),
                self:getFieldValue("answer"),
                self:getFieldValue("answer_time"),
                self:getFieldValue("node"),
                self:getFieldValue("is_team")
            )
        end,
        examples = {
            {
                desc = L "提交题目1 答案true 时间10 题序1 是否合作题0",
                canRun = false,
                code = [[
-- 是否合作题: 0不是, 1是
-- 题目id 答案 时间 题序 是否合作题
submitAnswer(1,true,10,1,0)
  ]]
            }
        }
    },
    -- 进度类型
    {
        type = "progressType",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    {L "起始", "1"},
                    {L "结束", "2"},
                    {L "学习", "3"},
                    {L "练习", "4"},
                    {L "闯关", "5"}
                }
            }
        },
        hide_in_toolbox = true,
        category = "Codepku",
        output = {type = "null"},
        helpUrl = "",
        canRun = false,
        func_description = '"%s"',
        ToNPL = function(self)
            return self:getFieldAsString("value")
        end,
        examples = {
            {
                desc = "",
                canRun = true,
                code = [[
    ]]
            }
        }
    },
    --     --    进度设置
    --     {
    --         type = "setProgress",
    --         message0 = L "总进度%1 当前进度%2 类型%3",
    --         arg0 = {
    --             {
    --                 name = "total",
    --                 type = "input_value",
    --                 shadow = { type = "math_number", value = 2 },
    --                 text = 2,
    --             },
    --             {
    --                 name = "current",
    --                 type = "input_value",
    --                 shadow = { type = "math_number", value = 1 },
    --                 text = 1,
    --             },
    --             {
    --                 name = "type",
    --                 type = "input_value",
    --                 shadow = { type = "progressType", value = 'start' },
    --                 text = "start",
    --             },
    --         },
    --         category = "Codepku",
    --         helpUrl = "",
    --         canRun = false,
    --         previousStatement = true,
    --         nextStatement = true,
    --         funcName = "setProgress",
    --         func_description = 'setProgress(%d,%d,%s)',
    --         ToNPL = function(self)
    --             return string.format('setProgress(%d,%d,"%s")\n', self:getFieldValue('total'), self:getFieldValue('current'), self:getFieldAsString('type'));
    --         end,
    --         examples = {
    --             {
    --                 desc = L "记录总进度，当前进度，进度类型",
    --                 canRun = false,
    --                 code = [[
    --                     setProgress(4,2,"start")
    -- ]]
    --             }
    --         },
    --     },

    --    获取课件信息
    {
        type = "getCourseware",
        message0 = L "获取课件数据",
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getCourseware",
        func_description = "getCourseware()",
        ToNPL = function(self)
            return string.format("getCourseware()\n")
        end,
        examples = {
            {
                desc = L "获取课件数据",
                canRun = false,
                code = [[
-- 如果课件不存在 data = '课件不存在'
data = getCourseware()
description = data.description
name = data.name
course_unit = data.course_unit
course_id = data.course_id
course_unit_id = data.course_unit_id

]]
            }
        }
    },
    -- 进度类型
    {
        type = "shareType",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    {L "文本", "text"},
                    {L "图片", "image"}
                }
            }
        },
        hide_in_toolbox = true,
        category = "Codepku",
        output = {type = "null"},
        helpUrl = "",
        canRun = false,
        func_description = '"%s"',
        ToNPL = function(self)
            return self:getFieldAsString("value")
        end,
        examples = {
            {
                desc = "",
                canRun = true,
                code = [[
    ]]
            }
        }
    },
    --    分享功能
    {
        type = "share",
        message0 = L "分享 %1 %2",
        arg0 = {
            {
                name = "shareType",
                type = "input_value",
                shadow = {type = "shareType", value = "text"},
                text = "text"
            },
            {
                name = "options",
                type = "input_value",
                shadow = {type = "text", value = "text"},
                text = "text"
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "share",
        func_description = "share(%s,%s)",
        ToNPL = function(self)
            return string.format('share("%s","%s")\n', self:getFieldValue("shareType"), self:getFieldValue("options"))
        end,
        examples = {
            {
                desc = L "分享功能",
                canRun = false,
                code = [[
share("text","分享内容")
]]
            }
        }
    },
    --    获取用户上一次学习
    {
        type = "getLearnRecords",
        message0 = L "加载上次学习进度",
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getLearnRecords",
        func_description = "getLearnRecords()",
        ToNPL = function(self)
            return string.format("getLearnRecords()\n")
        end,
        examples = {
            {
                desc = L "加载上次学习进度",
                canRun = false,
                code = [[
data = getLearnRecords()
category = data.category
pos= data.world_position
current_node = data.current_node
total_node = data.total_node
]]
            }
        }
    },
    --    提交用户学习进度
    {
        -- courseware_id,category,current_node,total_node
        type = "setLearnRecords",
        message0 = L "上传学习进度 类别 %1 当前节点 %2/总结点 %3",
        arg0 = {
            {
                name = "category",
                type = "input_value",
                shadow = {type = "progressType", value = 1},
                text = 1
            },
            {
                name = "current_node",
                type = "input_value",
                shadow = {type = "math_number", value = 1},
                text = 1
            },
            {
                name = "total_node",
                type = "input_value",
                shadow = {type = "math_number", value = 1},
                text = 1
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "setLearnRecords",
        func_description = "setLearnRecords(%d)",
        ToNPL = function(self)
            return string.format(
                "setLearnRecords(%d,%d,%d)\n",
                self:getFieldValue("category"),
                self:getFieldValue("current_node"),
                self:getFieldValue("total_node")
            )
        end,
        examples = {
            {
                desc = L "上传学习进度",
                canRun = false,
                code = [[
-- 返回是否提交成功
data = setLearnRecords(1,3,4)
]]
            }
        }
    },
    {
        type = "behavior_action_type",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    {L "开始", "1"},
                    {L "结束", "2"},
                    {L "分享", "3"}
                }
            }
        },
        hide_in_toolbox = true,
        category = "Codepku",
        output = {type = "null"},
        helpUrl = "",
        canRun = false,
        func_description = '"%s"',
        ToNPL = function(self)
            return self:getFieldAsString("value")
        end,
        examples = {
            {
                desc = "",
                canRun = true,
                code = [[
    ]]
            }
        }
    },
    {
        type = "behavior_type1",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    {L "动画", "1"},
                    {L "位置", "2"},
                    {L "答题", "3"},
                    {L "微信", "4"},
                    {L "QQ", "5"}
                }
            }
        },
        hide_in_toolbox = true,
        category = "Codepku",
        output = {type = "null"},
        helpUrl = "",
        canRun = false,
        func_description = '"%s"',
        ToNPL = function(self)
            return self:getFieldAsString("value")
        end,
        examples = {
            {
                desc = "",
                canRun = true,
                code = [[
    ]]
            }
        }
    },
    --    提交用户行为
    {
        -- courseware_id,category,current_node,total_node
        type = "setBehaviors",
        message0 = L "行为 %1 行为类别 %2",
        arg0 = {
            {
                name = "behavior_action",
                type = "input_value",
                shadow = {type = "behavior_action_type", value = 1},
                text = 1
            },
            {
                name = "behavior_type",
                type = "input_value",
                shadow = {type = "behavior_type1", value = 1},
                text = 1
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "setBehaviors",
        func_description = "setBehaviors(%d)",
        ToNPL = function(self)
            return string.format(
                "setBehaviors(%d,%d)\n",
                self:getFieldValue("behavior_action"),
                self:getFieldValue("behavior_type")
            )
        end,
        examples = {
            {
                desc = L "上传用户行为返回是否上传成功",
                canRun = false,
                code = [[
setBehaviors(2,3)
]]
            }
        }
    },
    -- 给用户增加经验值
    {
        type = "addExperience",
        message0 = L "给用户增加经验值 %1,经验类型 %2",
        arg0 = {
            {
                name = "exp",
                type = "input_value",
                shadow = {type = "math_number"},
                text = 99
            },
            {
                name = "exp_type",
                type = "input_value",
                shadow = {type = "math_number"},
                text = 11
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "addExperience",
        func_description = "addExperience(%d,%d)",
        ToNPL = function(self)
            return string.format("addExperience(%d,%d)\n", self:getFieldValue("exp"), self:getFieldValue("exp_type"))
        end,
        examples = {
            {
                desc = L "给用户增加经验值",
                canRun = false,
                code = [[
response = addExperience(99,11)
]]
            }
        }
    },
    -- 保存游戏得分
    {
        type = "saveScore",
        message0 = L "保存游戏得分 %1",
        arg0 = {
            {
                name = "score",
                type = "input_value",
                shadow = {type = "math_number"},
                text = 99
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "saveScore",
        func_description = "saveScore(%d)",
        ToNPL = function(self)
            return string.format("saveScore(%d)\n", self:getFieldValue("score"))
        end,
        examples = {
            {
                desc = L "保存游戏得分",
                canRun = false,
                code = [[
response = saveScore(99)
]]
            }
        }
    },
    --    创建角色
    {
        type = "createUser",
        message0 = L "创建角色%1，性别 %2",
        arg0 = {
            {
                name = "nickname",
                type = "input_value",
                shadow = {type = "input_value", value = "9号机器人"},
                text = "9号机器人"
            },
            {
                name = "gender",
                type = "input_value",
                shadow = {type = "math_number", value = 1},
                text = 1
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "createUser",
        func_description = "createUser(%s,%d)",
        ToNPL = function(self)
            return string.format('createUser("%s",%d)\n', self:getFieldValue("nickname"), self:getFieldValue("gender"))
        end,
        examples = {
            {
                desc = L "创建角色,0保密,1男,2女",
                canRun = false,
                code = [[
response = createUser("9号机器人",1)
]]
            }
        }
    },
    --    以权重w奖励用户经验/学科经验/道具
    {
        type = "awardUser",
        message0 = L "设置奖励点%1",
        arg0 = {
            {
                name = "order",
                type = "input_value",
                shadow = {type = "math_number", value = 1},
                text = 1
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "awardUser",
        func_description = "awardUser(%d)",
        ToNPL = function(self)
            return string.format("awardUser(%d)\n", self:getFieldValue("order"))
        end,
        examples = {
            {
                desc = L "设置奖励点1",
                canRun = false,
                code = [[
response_data = awardUser(1)
total_exp = response_data.total_exp -- 所有经验值，-1表示请求出错
subject_exp = response_data.subject_exp -- 学科经验值，-1表示请求出错

print(total_exp,subject_exp)

if total_exp ~= -1 then
    for i =1,#response_data.props do
            prop_id = response_data.props[i]['prop_id'] -- 道具id
            prop_num = response_data.props[i]['prop_num'] -- 道具名称
            prop_name = response_data.props[i]['prop_name'] -- 道具数量  
            print(prop_id, prop_num, prop_name)        
    end    
end
]]
            }
        }
    },
    -- 获得用户最大游戏得分
    {
        type = "getMaxScore",
        message0 = L "获得用户最大游戏得分",
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getMaxScore",
        func_description = "getMaxScore()",
        ToNPL = function(self)
            return string.format("getMaxScore()\n")
        end,
        examples = {
            {
                desc = L "获得用户最大游戏得分",
                canRun = false,
                code = [[
score = getMaxScore() -- score等于-1表示获取失败
]]
            }
        }
    },
    --    拾取道具
    {
        type = "pickProperty",
        message0 = L "拾取%1个编号%2的道具",
        arg0 = {
            {
                name = "prop_num",
                type = "input_value",
                shadow = {type = "math_number", value = 1},
                text = 1
            },
            {
                name = "prop_id",
                type = "input_value",
                shadow = {type = "math_number", value = 2001},
                text = 2001
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "pickProperty",
        func_description = "pickProperty(%d,%d)",
        ToNPL = function(self)
            return string.format("pickProperty(%d,%d)\n", self:getFieldValue("prop_num"), self:getFieldValue("prop_id"))
        end,
        examples = {
            {
                desc = L "拾取1个编号2001的道具",
                canRun = false,
                code = [[
response = pickProperty(1,2001)
]]
            }
        }
    },
    -- 获取<站到最后>相关函数
    {
        type = "getFunsSTE",
        message0 = L "获取<站到最后>相关函数",
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getFunsSTE",
        func_description = "getFunsSTE()",
        ToNPL = function(self)
            return string.format("getFunsSTE()\n")
        end,
        examples = {
            {
                desc = L "获取<站到最后>相关函数",
                canRun = false,
                code = [[
funsSTE = getFunsSTE()
--都是异步获取,最终返回的数据为传入的接收table的key为data的值, 如subjectsDataSTE.data
--获取<站到最后>题目信息
subjectsDataSTE = {}
funsSTE.getSubjectsDataSTE(subjectsDataSTE)
--保存<站到最后>最高关卡数(关卡数，日期，场次)
saveMaxRoundSTE = {}
funsSTE.saveMaxRoundSTE(0,"2020-11-16",65,saveMaxRoundSTE)
--获取<站到最后>最高关卡数
maxRoundDataSTE = {}
funsSTE.getMaxRoundSTE(maxRoundDataSTE)
--<站到最后>报名
signUpDataSTE = {}
funsSTE.signUpSTE(signUpDataSTE)
]]
            }
        }
    },
    -- 沉浸式课堂-同组成员传送
    {
        type = "groupTransmit",
        message0 = L "同组成员传送到 %1 [指定 %2 组]",
        arg0 = {
            {
                name = "position",
                type = "input_value",
                shadow = {type = "text", value = '"~1,~0,~0"'},
                text = '"~1,~0,~0"'
            },
            {
                name = "group",
                type = "input_value",
                shadow = {type = "math_number", value = 1},
                text = 1
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "groupTransmit",
        func_description = "groupTransmit(%s,%s)",
        ToNPL = function(self)
            return string.format("groupTransmit(%s, %s)\n", self:getFieldValue("position"), self:getFieldValue("group"))
        end,
        examples = {
            {
                desc = L "沉浸式课堂-同组成员传送",
                canRun = false,
                code = [[
--可以用绝对位置/相对位置
--参数为字符串,用英文逗号连接xyz三个坐标
-- group小组id, 不传则是调用者用户所在的小组, 传入则是指定的小组
groupTransmit("~1,~0,~0", 1)
--groupTransmit("19140,17,19214", 1)
]]
            }
        }
    },
    -- 沉浸式课堂-提交闯关成功数据
    {
        type = "submitPassData",
        message0 = L "提交闯关成功数据",
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "submitPassData",
        func_description = "submitPassData()",
        ToNPL = function(self)
            return string.format("submitPassData()\n")
        end,
        examples = {
            {
                desc = L "沉浸式课堂-提交闯关成功数据",
                canRun = false,
                code = [[
-- 某用户闯关成功,提交闯关成功数据
local response = submitPassData()
]]
            }
        }
    },
    -- 沉浸式课堂-获取小组闯关排名
    {
        type = "getGroupRanking",
        message0 = L "获取[指定 %1 ]小组闯关排名",
        arg0 = {
            {
                name = "group",
                type = "input_value",
                shadow = {type = "math_number", value = 1},
                text = 1
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getGroupRanking",
        func_description = "getGroupRanking(%s)",
        ToNPL = function(self)
            return string.format("getGroupRanking(%s)\n", self:getFieldValue("group"))
        end,
        examples = {
            {
                desc = L "沉浸式课堂-获取小组闯关排名",
                canRun = false,
                code = [[
-- 获取当前用户所在小组的排名
-- group小组id, 不传则是调用者用户所在的小组, 传入则是指定的小组
local ranking = getGroupRanking(group)
]]
            }
        }
    },
    -- 世界留资
    {
        type = "retained",
        message0 = L "上传留资数据(手机:%1 年龄:%2 名字:%3)",
        arg0 = {
            {
                name = "mobile",
                type = "input_value",
                shadow = {type = "text", value = '"13200132000"'},
                text = '"13200132000"'
            },
            {
                name = "age",
                type = "input_value",
                shadow = {type = "math_number", value = 0},
                text = 0
            },
            {
                name = "username",
                type = "input_value",
                shadow = {type = "text", value = '"测试名字"'},
                text = '"测试名字"'
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "retained",
        func_description = "retained(%s,%s,%s)",
        ToNPL = function(self)
            return string.format("retained(%s,%s,%s)\n", self:getFieldValue("mobile"), self:getFieldValue("age"), self:getFieldValue("username"))
        end,
        examples = {
            {
                desc = L "上传留资数据",
                canRun = false,
                code = [[
-- 上传留资数据
-- 手机号为必填项
-- result为true表示上传成功
local result = retained("13200132000",0,"测试名字")
]]
            }
        }
    }
}
function Codepku.GetCmds()
    return cmds
end
