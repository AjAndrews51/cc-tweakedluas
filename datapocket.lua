local modem = peripheral.find("modem") or error("No Modem Detected!", 0)
modem.open(69)
local oChan = modem.isOpen(69)
--local monitor = peripheral.find("monitor")

--term.redirect(monitor)
--term.setTextScale(.5)
term.clear()
function cCheck()
	oChan = modem.isOpen(69)
	if oChan == true then
	print("Channel is open")
	else 
	print("Channel is not Open") 
	end
end


function DataRecieve()
	i = 0
	repeat
		
	event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
	print(tostring(message))
	i = i + 1
until i == 7

os.sleep(10)
term.clear()
end

function DataClear()
--	monitor = peripheral.find("monitor")
--	monitor.clear()
end




cCheck()

repeat
	x = 1
	DataRecieve()
until x == 2
