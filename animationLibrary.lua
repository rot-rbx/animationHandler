local library = {}

local animationData = require(game.ReplicatedStorage.Data.animationData)

function library.playAnimation(humanoid, animationName)
	assert(animationData[animationName], 'invalid animation name')

	local animation = Instance.new('Animation')
	animation.AnimationId = "rbxassetid://"..animationData[animationName].animationId

	local animationTrack = humanoid:LoadAnimation(animation)

	if animationData.animationSpeed then
		animationTrack:AdjustSpeed(animationData.animationSpeed)
	end

	animationTrack:Play()
end

function library.runAnimations(humanoid, func)
    table.foreach(humanoid:GetPlayingAnimationTracks(), func)
end

function library.stopAllAnimations(humanoid)
    	library.runAnimations(humanoid, function(_, animationTrack)
		animationTrack:stop()
	end)
end

function library.changeDefaultAnimation(character, animationName, animationType)
	for _,animation in pairs(character.Animate[animationType]:GetChildren()) do
		animation.AnimationId = "rbxassetid://"..animationData[animationName].animationId
	end
end

function library.requestAnimationId(animationName)
	return animationData[animationName].animationId
end

function library.stopAnimation(humanoid, animationName)
   local targetId = animationData[animationName].animationId

   library.runAnimations(humanoid, function(_, animationTrack)
      if animationTrack.Animation.AnimationId == "rbxassetid://"..targetId then
	  animationTrack:Stop()
	  end
   end)
end


return library
