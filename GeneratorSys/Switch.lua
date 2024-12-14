local BB = script.Parent.Parent.Vector.BB -- BillboardGui
local PNeon = workspace.Casa1.Luz.Parteneon -- Light 1 Material ¨ON¨
local PNeon2 = workspace.Casa1.Luz2.Parteneon -- Light 2 Material ¨ON¨
local Neon = Enum.Material.Neon -- Material Neon (ON)
local Basalt = Enum.Material.Basalt -- Material Basalt (OFF)
local VcL1 = workspace.Casa1.Luz.LVector.Vector.BillboardGui -- Light 1 Vector
local VcL2 = workspace.Casa1.Luz2.LVector.Vector.BillboardGui -- Light 2 Vector
local currentMaterial = Basalt -- Current Material (Default = OFF)
local intervaloGasolina = 20 -- Fuel Consume time in seconds
local LD = script.Parent.On

local function atualizarGasolina() -- Update fuel value in BillboardGui
	BB.Number.Text = "Combustivel: " .. script.Parent.G.Value
end

local function verificarGasolina() -- Verify if has fuel
	if script.Parent.G.Value == 0 then
		LD.Value = false
		script.Parent.Parent.Engine:Stop()
		currentMaterial = Basalt
		PNeon.Material = currentMaterial
		PNeon2.Material = currentMaterial
		workspace.Casa1.Luz.Light.PointLight.Enabled = false
		workspace.Casa1.Luz2.Light.PointLight.Enabled = false
		VcL1.Enabled = false
		VcL2.Enabled = false
		script.Parent.Parent.Smoke.Enabled = false
	end
end

script.Parent.G:GetPropertyChangedSignal("Value"):Connect(function()
	atualizarGasolina()
end)

script.Parent.Triggered:Connect(function()
	script.Parent.Parent.Switche:Play()
	wait(0.2)
	if script.Parent.Parent.Engine.Playing and script.Parent.G.Value > 0 and LD.Value == true then
		LD.Value = false
		script.Parent.Parent.Engine:Stop()
		currentMaterial = Basalt
		PNeon.Material = currentMaterial
		PNeon2.Material = currentMaterial
		workspace.Casa1.Luz.Light.PointLight.Enabled = false
		workspace.Casa1.Luz2.Light.PointLight.Enabled = false
		VcL1.Enabled = false
		VcL2.Enabled = false
		script.Parent.Parent.Smoke.Enabled = false
		atualizarGasolina()
	elseif script.Parent.G.Value == 0 then
		LD.Value = false
		script.Parent.Parent.Engine:Stop()
		currentMaterial = Basalt
		PNeon.Material = currentMaterial
		PNeon2.Material = currentMaterial
		workspace.Casa1.Luz.Light.PointLight.Enabled = false
		workspace.Casa1.Luz2.Light.PointLight.Enabled = false
		VcL1.Enabled = false
		VcL2.Enabled = false
		script.Parent.Parent.Smoke.Enabled = false
		atualizarGasolina()
	else
		LD.Value = true
		script.Parent.Parent.Engine:Play()
		currentMaterial = Neon
		PNeon.Material = currentMaterial
		PNeon2.Material = currentMaterial
		workspace.Casa1.Luz.Light.PointLight.Enabled = true
		workspace.Casa1.Luz2.Light.PointLight.Enabled = true
		VcL1.Enabled = true
		VcL2.Enabled = true
		script.Parent.Parent.Smoke.Enabled = true
		script.Parent.Parent.Smoke.Enabled = true
		atualizarGasolina()
		while script.Parent.Parent.Engine.Playing and script.Parent.G.Value > 0 and LD.Value == true do
			script.Parent.G.Value = script.Parent.G.Value - 1
			verificarGasolina()
			atualizarGasolina()
			wait(intervaloGasolina)
		end
	end
end)

atualizarGasolina()