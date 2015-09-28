-- Codename Hybrid
-- Innovation starts here.
-- All code in one file
-- Hybrid OS

--[ INIT ]--

function center(y,str)
  local w,h = term.getSize()
  local x = term.getCursorPos()
  x = math.floor(math.max((w / 2) - (#str / 2)),0)
  term.setCursorPos(x,y)
  print(str)
end

function centerSP(y,str)
  local w,h = term.getSize()
  local x = term.getCursorPos()
  x = math.floor(math.max((w / 2) - (#str / 2)),0)
  term.setCursorPos(x,y)
  textutils.slowPrint(str)
end

function centerW(y,str)
  local w,h = term.getSize()
  local x = term.getCursorPos()
  x = math.floor(math.max((w / 2) - (#str / 2)),0)
  term.setCursorPos(x,y)
  term.write(str)
end

function clearScr()
  term.clear()
  term.setCursorPos(1,1)
end

function bg(c)
  term.setBackgroundColor(c)
  clearScr()
end

function fadeIn()
  bg(colors.black)
  sleep(0.1)
  bg(colors.gray)
  sleep(0.1)
  bg(colors.lightGray)
  sleep(0.1)
  bg(colors.white)
end

a = [[
49999
99999
99999
99999
ddddd
]]
f = fs.open("/.img","w")
f.writeLine(a)
f.close()
f = nil
img = paintutils.loadImage("/.img")
f = fs.open("/.version","r")
ver = f.readAll()
f.close()
f = nil
function wip()
  bg(colors.red)
  term.setTextColor(colors.white)
  centerSP(10,"Work in progress!")
  centerSP(12,"Either not working, buggy or")
  centerSP(13,"not done yet!")
  center(15,"You can help contribute!")
  center(16,"Go to github.com/MCFunRide/Codename-Hybrid")
  center(17,"If you wish to fix bits of code!")
  sleep(3)
  desktop()
end
function bios()
  print(":)")
end
function shellProg()
  term.clear()
  term.setCursorPos(1,1)
  function os.version()
    return "Codename Hybrid Shell 1.0"
  end
  shell.run("multishell")
end
function fileMan()
  m = 0
  local w,h = term.getSize()
  curDir = "/"
  function drawMenu(filename)
    m = 1
    term.setCursorPos(25,3)
    term.setBackgroundColor(colors.orange)
    print(" "..filename.." ")
    term.setCursorPos(25,4)
    print(" Delete    ")
    term.setCursorPos(25,5)
    print(" Rename    ")
    term.setCursorPos(25,6)
    print(" Edit      ")
  end
    
  function drawDir()
    l = fs.list(curDir)
    bg(colors.white)
    paintutils.drawLine(1,1,w,1,colors.gray)
    term.setCursorPos(1,1)
    term.setTextColor(colors.white)
    print("File Manager")
    term.setBackgroundColor(colors.white)
    if m == 1 then
      drawMenu(l[y2])
    end
    for i,v in pairs(l) do
      if fs.isDir(v) then
        term.setTextColor(colors.green)
        print(v)
        term.setTextColor(colors.black)
      elseif v == ".img" then
      elseif v == ".version" then
      else
        term.setTextColor(colors.black)
        print(v)
      end
    end
  end
  drawDir()
  m = 0
  function code()
    while true do
      e2,b2,x2,y2 = os.pullEvent("mouse_click")
      if l[y2] then
        term.setCursorPos(1,10)
        print("Event grabbed. File exists in table")
        if fs.exists(l[y2]) then
          print("File exists")
            print("Pos works")
            if fs.isDir(l[y2]) then
              print("Dir")
              curDir = "/"..l[y2]
              drawDir()
            else
              print("File")
              drawMenu(l[y2])
            end
          end
        
      elseif x == 51 and y == 1 then
        desktop()
      elseif x >= 25 and x <= 37 and y == 4 and m == 1 then
        if curDir == "/" then
          fs.delete(l[y2])
        else
          fs.delete(curDir.."/"..l[y2])
        end
      elseif x >= 25 and x <= 37 and y == 5 and m == 1 then
        term.setCursorPos(25,7)
        write("New Name: ")
        new = read()
        if curDir == "/" then
          fs.rename(l[y2],new)
        else
          fs.rename(curDir.."/"..l[y2])
        end
      elseif x >= 25 and x <= 37 and y == 5 and m == 1 then
        if curDir == "/" then
          shell.run("edit "..l[y2])
        else
          shell.run("edit "..curDir.."/"..l[y2])
        end
      end
    end
  end
  code()
end


  
  
function desktop()
  local w,h = term.getSize()
  function drawDesk()
    bg(colors.white)
    local w,h = term.getSize()
    paintutils.drawLine(1,h,w,h,colors.gray)
    paintutils.drawLine(1,h,5,19,colors.green)
    term.setCursorPos(1,h)
    term.setTextColor(colors.white)
    write("Start")
    term.setCursorPos(w-8,19)
    term.setBackgroundColor(colors.gray)
    write(textutils.formatTime(os.time(),false))
    if menu == 1 then
      pList()
    end
  end
  function pList()
    term.setCursorPos(1,h-1)
    print("          ")
    term.setCursorPos(1,h-2)
    print(" Shutdown ")
    term.setCursorPos(1,h-3)
    print("          ")
    term.setCursorPos(1,h-4)
    print(" File Man ")
    term.setCursorPos(1,h-5)
    print("          ")
    term.setCursorPos(1,h-6)
    print(" Shell    ")
    term.setCursorPos(1,h-7)
    print("          ")
    term.setCursorPos(1,h-8)
    print(" About    ")
    term.setCursorPos(1,h-9)
    print("          ")
  end
  menu = 0
  a = false
  drawDesk()
  repeat
    t = os.startTimer(1)
    e,b,x,y = os.pullEvent()
    if e == "mouse_click" then
      if x >= 1 and x <= 11 and y == h-2  and menu == 1 then
        os.shutdown()
      elseif x >= 1 and x <= 6 and y == 19 and menu == 0 then
        menu = 1
        drawDesk()
      elseif x >= 1 and x <= 6 and y == 19 and menu == 1 then
        menu = 0
        drawDesk()
      elseif x >= 1 and x <= 11 and y == h-4 and menu == 1 then
        wip()
        a = true
      elseif x >= 1 and x <= 11 and y == h-6 and menu == 1 then
        shellProg()
        a = true
      elseif x >= 1 and x <= 11 and y == h-8 and menu == 1 then
        about()
        a = true
      end
    elseif e == "timer" and b == t then
      drawDesk()                             
      end
    until a 
  end

--[ Beginning ]--

fadeIn()
paintutils.drawImage(img,23,5)
term.setBackgroundColor(colors.white)
term.setTextColor(colors.gray)
center(11,"Codename Hybrid")
center(12,"All in one.")

term.setTextColor(colors.blue)
centerW(19,"Press ALT for system setup.")
local t = os.startTimer(3)
b = false
repeat
e = {os.pullEvent()}
if e[1] == "timer" and e[2] == t then
  b = true
  desktop()
elseif e[1] == "key" and e[2] == 56 then
  b = true
  bios()
end
until b
