local frame = CreateFrame('FRAME', 'KCEmoteFrame');

local KC_EMOTES = {
    ["энтеринг комбат"] = "Interface\\AddOns\\KC_Emote\\emotes\\entering_combat_2.mp3",
    ["сколько можно"] = "Interface\\AddOns\\KC_Emote\\emotes\\that_enough.mp3"
}

function isPlayerLeader(playerName)
    local isLeader = false
    if UnitInRaid("player") ~= nil then
        for i=1,40 do
            local raidN = GetUnitName("raid"..i)
            if raidN == playerName and UnitIsPartyLeader("raid"..i) == 1 then
                isLeader = true
                break
            end
        end
    else
        if GetUnitName("player") == playerName and GetPartyLeaderIndex() == 0 then
		    isLeader = true
		else
			for i=1,4 do
				local partyN = GetUnitName("party"..i)
				if partyN == playerName and UnitIsPartyLeader("party"..i) == 1 then
					isLeader = true
					break
				end
			end
		end
    end
    return isLeader
end

frame:SetScript('OnEvent', function()
	this[event]()
end)

frame:SetScript("OnUpdate", function()
end)

function frame:CHAT_MSG_EMOTE()
    local event = event
    local message = arg1
    local pl = arg2
    
    if KC_EMOTES[message] ~= nil then
        if isPlayerLeader(pl) then
		    PlaySoundFile(KC_EMOTES[message])
		else
		    print("KC_Emote: "..pl.." is not leader")
		end
	end
end


function frame:ADDON_LOADED()
end


frame:RegisterEvent("CHAT_MSG_EMOTE")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript('OnEvent', function()
	this[event]()
end)

