--[[
Title: 声网接入
Author(s): 冯梦棋
Date: 2020-12-24 
Desc: 与Android或者iOS层sdk进行通讯
Example:
------------------------------------------------------------
    local Agora = NPL.load("(gl)Mod/CodePkuCommon/util/Agora.lua");
-- 初始化AgoraEngine
-- 加入聊天组
-- 离开聊天组
-- 摧毁AgoraEngine
-- 音量调节
-- 扩音
-- 听筒
-- 开启静音
-- 取消静音
-- 翻转摄像头
-- 打开摄像头
-- 关闭摄像头
-- 显示视频窗口
-- 隐藏视频窗口
-------------------------------------------------------
]]

local Agora = commonlib.inherit(nil, NPL.export());
local platform = System.os.GetPlatform();
local isAndroid = platform == "android";
local isIOS = platform == "ios";

Agora.callbacks = {}

NPL.this(function()
    local spltPos = string.find(msg, "_");
    if spltPos then
        local params = string.sub(msg, spltPos + 1)
        local method = string.sub(msg, 1, spltPos - 1);
        if Agora.callbacks and Agora.callbacks[method] then
            Agora.callbacks[method](params);
        end
    end
end);

function Agora:videoChat(agoraType, options, callback)

    Agora.callbacks = callback;

    if isAndroid then
		if LuaJavaBridge == nil then
            NPL.call("LuaJavaBridge.cpp", {});
        end
        if LuaJavaBridge then
            if agoraType == "videoWindowCoordinates"  then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "videoWindowCoordinates", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V", options);
            elseif agoraType == "initializeAgoraEngine"  then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "initializeAgoraEngine", "(Ljava/lang/String;)V", options);
            elseif agoraType == "joinVideoChat"  then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "joinVideoChat", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V", options);
            elseif agoraType == "leaveVideoChat" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "leaveVideoChat", "()V",{});
            elseif agoraType == "destroyAgoraEngine" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "destroyAgoraEngine", "()V",{});
            elseif agoraType == "adjustSignalVolume"  then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "adjustSignalVolume", "(Ljava/lang/String;)V", options);
            elseif agoraType == "openSpeakerphone" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "openSpeakerphone", "()V",{});
            elseif agoraType == "cancelSpeakerphone" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "cancelSpeakerphone", "()V",{});
            elseif agoraType == "openMuteAudio" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "openMuteAudio", "()V",{});
            elseif agoraType == "cancelMuteAudio" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "cancelMuteAudio", "()V",{});
            elseif agoraType == "onSwitchCamera" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "onSwitchCamera", "()V",{});
            elseif agoraType == "enableVideoChat" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "enableVideoChat", "()V",{});
            elseif agoraType == "disableVideoChat" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "disableVideoChat", "()V",{});
            elseif agoraType == "showEasyFloat" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "showEasyFloat", "()V",{});
            elseif agoraType == "hideEasyFloat" then
                LuaJavaBridge.callJavaStaticMethod("plugin.agora.AgoraVideo", "hideEasyFloat", "()V",{});
            end
        end
	elseif isIOS then
        if LuaObjcBridge == nil then
            NPL.call("LuaObjcBridge.cpp", {});
        end
        if LuaObjcBridge then

            local args = { luaPath = "(gl)Mod/CodePkuCommon/util/Agora.lua" };
            local ok, ret = LuaObjcBridge.callStaticMethod("AgoraVideo", "registerLuaCall", args);

            if agoraType == "videoWindowCoordinates"  then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "videoWindowCoordinates", options);
            elseif agoraType == "initializeAgoraEngine"  then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "initializeAgoraEngine", options);
            elseif agoraType == "joinVideoChat"  then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "joinVideoChat", options);
            elseif agoraType == "leaveVideoChat" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "leaveVideoChat", {});
            elseif agoraType == "destroyAgoraEngine" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "destroyAgoraEngine", {});
            elseif agoraType == "adjustSignalVolume"  then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "adjustSignalVolume", options);
            elseif agoraType == "openSpeakerphone" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "openSpeakerphone", {});
            elseif agoraType == "cancelSpeakerphone" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "cancelSpeakerphone", {});
            elseif agoraType == "openMuteAudio" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "openMuteAudio", {});
            elseif agoraType == "cancelMuteAudio" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "cancelMuteAudio", {});
            elseif agoraType == "onSwitchCamera" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "onSwitchCamera", {});
            elseif agoraType == "enableVideoChat" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "enableVideoChat", {});
            elseif agoraType == "disableVideoChat" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "disableVideoChat", {});
            elseif agoraType == "showEasyFloat" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "showEasyFloat", {});
            elseif agoraType == "hideEasyFloat" then
                LuaObjcBridge.callStaticMethod("AgoraVideo", "hideEasyFloat", {});
            end

        end
	end
end

