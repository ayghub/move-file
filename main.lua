dst = [[D:\V\watched]]

function log(level,string,secs)
  secs = secs or 2.5
  mp.msg.log(level,string)
  mp.osd_message(string,secs)
end

function check_file() 
  local filepath = mp.get_property('path')
  local _, _, proto = filepath:find("^(%a+)://")
  if proto then
    log("warn",string.format("Cannot move a streaming file", proto))
    return nil
  end
  return filepath
end

function move_to()
  local filepath = check_file()
  if filepath then
    local cmd = string.format('move "%s" "%s"', filepath, dst)
    log("info",string.format("moving %s to %s", filepath,dst))
    os.execute(cmd)
  end 
end

mp.add_key_binding('ctrl+m', "move-file", move_to)
