repeat
    wait()
until game:GetService("Players")

repeat
    wait()
until game:GetService("Players").LocalPlayer

local GC = getconnections or get_signal_cons
if GC then
	for i,v in pairs(GC(game:GetService("Players").LocalPlayer.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
end