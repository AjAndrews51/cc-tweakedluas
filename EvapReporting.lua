--[[ Water evap plant locals
local wPlant = peripheral.wrap("right")--("thermalEvaporationController" right side (water))
local WfPerRaw = wPlant.getInputFilledPercentage()
local WfPer = string.format("%.2f%%", WfPerRaw * 100)
local WtempRaw = wPlant.getTemperature()
local WtempF = string.format("%.2f", WtempRaw)
]]-- end water evap locals

--[[brine Evap plant locals
local bPlant = peripheral.wrap("left")
local BfPerRaw = bPlant.getInputFilledPercentage()
local BfPer = string.format("%.2f%%", BfPerRaw * 100)
local BtempRaw = bPlant.getTemperature()
local BtempF = string.format("%.2f", BtempRaw)
]]-- end water plant

--[[ print tests
print(fPerRaw.. " Raw Fill Percentage")
print(fPer.. " Fill Percentage Formated")
print(tempRaw.. " Raw Temp")
print(tempF.. " Temp Formated")
]]--end Testing data

--Monitor Control/set
local monitor = peripheral.find("monitor")
term.redirect(monitor)
monitor.setTextScale(.5)
local modem = peripheral.find("modem")
repeat 
	local i = 1
local wPlant = peripheral.wrap("right")--("thermalEvaporationController" right side (water))
local WfPerRaw = wPlant.getInputFilledPercentage()
local WfPer = string.format("%.2f%%", WfPerRaw * 100)
local WtempRaw = wPlant.getTemperature()
local WtempF = string.format("%.2f", WtempRaw)
local bPlant = peripheral.wrap("left")
local BfPerRaw = bPlant.getInputFilledPercentage()
local BfPer = string.format("%.2f%%", BfPerRaw * 100)
local BtempRaw = bPlant.getTemperature()
local BtempF = string.format("%.2f", BtempRaw)
	monitor.clear()
	monitor.setCursorPos(1,1)
	print("Thermal Evaporation water tank is: ".. WfPer .. "full.")
	modem.transmit(69, 1,"Thermal Evaporation water tank is: ".. WfPer .. "full." )
	print("Water Evaporation plant is at ".. WtempF.." Kelvin." )	
	modem.transmit(69, 1,"Water Evaporation plant is at ".. WtempF.." Kelvin." )
	print("Thermal Evaporation Brine tank is: ".. BfPer .. "full.")
	modem.transmit(69, 1,"Thermal Evaporation Brine tank is: ".. BfPer .. "full.")
	print("Brine Evaporation plant is at ".. BtempF.." Kelvin." )
	modem.transmit(69, 1,"Brine Evaporation plant is at ".. BtempF.." Kelvin." )
	os.sleep(1)
	monitor.clear()

until i == 999999
