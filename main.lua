-- the destination folder. note escaping the file path.
dst = "D:\\V\\Watched"

function move_to()
  local filepath = mp.get_property('path')
  local cmd = string.format('move "%s" "%s"', filepath, dst)
  mp.msg.info("the file is moved successfully, or not")
  os.execute(cmd)
end

mp.add_key_binding('ctrl+m', "move-file", move_to)
