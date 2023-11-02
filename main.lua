local mod = RegisterMod( "Faster Placenta" , 1 );

local game = Game()
local room = game:GetRoom()
local placentaItem = Isaac.GetItemIdByName("Placenta")
local sound = SFXManager()

function gameUpdate()
    local numPlayers = game:GetNumPlayers()
	for i = 0, numPlayers - 1 do
		local player = Isaac.GetPlayer(i)
		frame = game:GetFrameCount()
		if player:HasCollectible(placentaItem) then
			--occasional regen at 10-second intervals
			if room:IsClear() and frame % 600 == 0 then
				local rand = math.random(100)
				if rand > 50 then
					currentHearts = player:GetHearts()
					maxHearts = player:GetMaxHearts()
					if currentHearts ~= maxHearts then
						player:AddHearts(1, false)
						sound:Play(SoundEffect.SOUND_VAMP_GULP, 1, 0, false, 1)
						heartPos = Vector(player.Position.X, player.Position.Y - 38)
						local heartEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, heartPos, Vector(0, 0), player)
						heartEffect.DepthOffset = 100
					end
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, gameUpdate)
