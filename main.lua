local utils = require "mp.utils"
dst = [[/dstpath]] --change me

function log(level,string,secs)
	secs = secs or 2.5
	mp.msg.log(level,string)
	mp.osd_message(string,secs)
end

function check_dir() 
	if not utils.file_info(dst) then
		os.execute("mkdir "..dst)
		print("created folder "..dst)
	end
end

function check_file(path) 
	local filepath = mp.get_property('path')
	local _, _, proto = filepath:find("^(%a+)://")
	if proto then
		log("warn",string.format("Cannot move a streaming file", proto))
		return nil
	end
	return filepath
end

function platform()
    return package.config:sub(1,1) == "\\" and "win" or "unix"
end

function move(filepath)
	local cmd
	if platform() == "win" then
		cmd = string.format('move "%s" "%s"', filepath, dst)
	else
		cmd = string.format('mv "%s" "%s"', filepath, dst)

	end
	log("info",string.format("moving %s to %s", filepath,dst))
	os.execute(cmd)

end

function move_to()
	local filepath = check_file()
	if filepath then
		check_dir()
		move(filepath)
	end
end

mp.add_key_binding('ctrl+m', "move-file", move_to)
