--Monitor Controls
local monitor = peripheral.find("monitor")
term.redirect(monitor)
monitor.setTextScale(.5)
--start of reactor definitions
local modem = peripheral.find("modem") or error("No modem attached", 0)

local reactor = peripheral.find("fissionReactorLogicAdapter")
local rstatus = reactor.getStatus()
local rFuelRaw = reactor.getFuelFilledPercentage()
local rFuelPer = string.format("%.2f%%", rFuelRaw * 100)
local rTemp = reactor.getTemperature()
local rTempF = string.format("%.2f", rTemp)

function tempcheck()
	rTemp = reactor.getTemperature()
	rTempF = string.format("%.2f", rTemp)
	rstatus = reactor.getStatus()
	if rTemp > 696.9 then
	term.setTextColour(colors.red)
	print(rTempF.. " Kelvin")
	modem.transmit(69, 1,rTempF.. " Kelvin" )
	term.setTextColour(colors.white)
	elseif (rTemp > 599 and rTemp < 696.8) then
	term.setTextColour(colors.orange)
	print(rTempF.." Kelvin")
	modem.transmit(69, 1,rTempF.." Kelvin" )
	term.setTextColour(colors.white)
	elseif rTemp < 598 then
	term.setTextColour(colors.green)
	print(rTempF.." Kelvin")
	modem.transmit(69, 1,rTempF.." Kelvin" )
	term.setTextColour(colors.white)	
	end
	if (rTemp > 696.6 and rstatus == true) then
		reactor.scram()
	end
end

function fCheck()
	rFuelRaw = reactor.getFuelFilledPercentage()
	rFuelPer = string.format("%.2f%%", rFuelRaw * 100)
	if rFuelRaw > .75 then
		term.setTextColour(colors.green)
		print("Fuel is ".. rFuelPer.." full!")
		modem.transmit(69, 1,"Fuel is ".. rFuelPer.." full!" )
		term.setTextColour(colors.white)
	elseif (rFuelRaw < .75 and rFuelRaw > .45) then
		term.setTextColour(colors.orange)
		print("Fuel is ".. rFuelPer.." full!")
		modem.transmit(69, 1,"Fuel is ".. rFuelPer.." full!" )
		term.setTextColour(colors.white)
	elseif (rFuelRaw < .45 and rFuelRaw > .1 )then
		term.setTextColour(colors.red)
		print("Fuel is ".. rFuelPer.." full!")
		modem.transmit(69, 1,"Fuel is ".. rFuelPer.." full!" )
		term.setTextColour(colors.white)
	elseif rFuelRaw < .1 then 
		term.setTextColour(colors.red)
		print("Make fuel! ".. rFuelPer.." fuel and dropping")
		modem.transmit(69, 1,"Make fuel! ".. rFuelPer.." fuel and dropping")
		term.setTextColour(colors.white)
	end
end

function StatusCheck()
	if rstatus == false then
	term.setTextColour(colors.red)
	print("Reactor Offline!")
	modem.transmit(69, 1,"Reactor Offline!" )
	term.setTextColour(colors.white)
	else
	term.setTextColour(colors.green)
	print("Reactor Active!")
	modem.transmit(69, 1,"Reactor Active!" )
	term.setTextColour(colors.white)
	end
end





repeat
	i = 1
	parallel.waitForAll(StatusCheck, fCheck, tempcheck)
	os.sleep(1)
	monitor.clear()
until i == 2
