-- crow firmware updater
-- INTERNET REQUIRED
--
-- OPEN MAIDEN FIRST
-- for more detailed progress

running = false
note = "> k3 to begin"

function go()
	notify("> checking install")
	os.execute("sudo apt-get -y install python3-pip")
	os.execute("sudo pip3 install pyusb usb")
	notify("> get firmware url")
	norns.system_cmd([[ curl -s \
			https://raw.githubusercontent.com/monome/crow/main/version.txt \
			]], ver)
end

function ver(result)
	url = result:match("h.*")
	url = url:sub(1,-2)
	notify("> downloading firmware")
  	local cmd = "sudo wget -T 180 -q -P /home/we/dust/code/fledge/ " .. url
	print(cmd)
	norns.system_cmd(cmd, flash)
end

function flash(result)
	notify("> activate booloader mode")
	crow.send("^^b")
	os.execute("sleep 1")
	notify("> flash")
	os.execute("sudo python /home/we/dust/code/fledge/pydfu.py -u /home/we/dust/code/fledge/crow.dfu")
	notify("> done")
end

function notify(text)
	print(text)
	note = text
	redraw()
end

function redraw()
	screen.clear()
	screen.move(0,24)
	screen.level(15)
	screen.text(note)
	screen.update()
end

function key(n,z)
	if(n==3 and z==1 and running==false) then
		running=true
		go()
	end
end



