--[[                                     ]]--
--                                         -
--      z1lt0id Awesome WM 3.5.+ config    --
--           github.com/z1lt0id            --
--    					   --
--      Varation of  github.com/copycat    --
--                                         -
--[[                                     ]]--


-- Required Libraries
--bashets		= require("bashets")
gears 	        = require("gears")
awful           = require("awful")
awful.rules     = require("awful.rules")
awful.autofocus = require("awful.autofocus")
wibox           = require("wibox")
beautiful       = require("beautiful")
naughty         = require("naughty")
vicious         = require("vicious")
scratch         = require("scratch")

-- layouts
layouts         = require("layouts")

--bashets.set_script_path( "/home/moho/bin" )
--bashets.set_temporary_path( "/tmp" )

-- Conky
function get_conky()
    local clients = client.get()
    local conky = nil
    local i = 1
    while clients[i]
    do
        if clients[i].class == "Conky"
        then
            conky = clients[i]
        end
        i = i + 1
    end
    return conky
end
function raise_conky()
    local conky = get_conky()
    if conky
    then
        conky.ontop = true
    end
end
function lower_conky()
    local conky = get_conky()
    if conky
    then
        conky.ontop = false
    end
end
function toggle_conky()
    local conky = get_conky()
    if conky
    then
        if conky.ontop
        then
            conky.ontop = false
        else
            conky.ontop = true
        end
    end
end


-- Run once function

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
 end
run_once("compton --backend glx --paint-on-overlay --vsync opengl-swc --unredir-if-possible --shadow-exclude n:a:Conky --blur-background-exclude n:a:Conky -b&")
run_once("/home/moho/02Sys/radix2/startconky.sh")
-- run_once("nm-applet")
-- run_once("/opt/dropbox/dropboxd")
run_once("mpd")
-- run_once("conky ~/.conkyrc")
run_once("unclutter -idle 10")
run_once("xautolock -time 5 -locker \"sflock -f '-*-fixed-*-r-*-*-*-420-*-*-*-*-*-*'\"")
--run_once("/home/moho/02Sys/radix/start.sh")


-- Localization

os.setlocale("en_US.UTF-8")

-- Error Handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end


-- Variable Definitions

home = os.getenv("HOME")
confdir = home .. "/.config/awesome"
scriptdir = confdir .. "/script/"
themes = confdir .. "/themes"
active_theme = themes .. "/blackburn"

beautiful.init(active_theme .. "/theme.lua")

terminal = "urxvt"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor
gui_editor = "sublime"
browser = "dwb"
browser2 = "dwb"
mail = terminal .. " -g 130x30 -e mutt "
tasks = terminal .. " -e htop "
musicplr = terminal .. " -g 130x34-320+16 -e ncmpcpp "

modkey = "Mod4"
altkey = "Mod1"


-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    layouts.uselesstile,
    layouts.termfair,
    layouts.browse,
    layouts.uselessfair,
    layouts.centerwork,
}
-- }}}


-- Wallpaper

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- Tags

tags = {
       names = { " :) ", " :/ ", " :P ", " X) ", " ;) "},
       layout = { layouts[1], layouts[4], layouts[5], layouts[3], layouts[2] }
       }
for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- Menu
myaccessories = {
   { "ranger", terminal .. " -depth 16 -g 130x30 -e ranger"},
   { "editor", gui_editor },
   { "sublime", "sublime" }
}
myinternet = {
    { "chromium", "chromium" },
    { "weechat", terminal .. " -g 130x30 -e weechat-curses" },
    { "sabnzbd" , "dwb http://localhost:9090" },
    { "transmission", terminal .. " -g 130x30 -e transmission-remote-cli -c localhost:9091" },
    { "transmission-web", "dwb localhost:9091" },
--    { "sickbeard", "dwb http://localhost:8081" },
--    { "couchpotato", "dwb http://localhost:5050"}
}
mymedia = {
--    { "volume", "pavucontrol"},
    { "ncmpcpp", musicplr },
    { "smplayer", "smplayer"},
--    { "vlc", terminal .. " -e vlc -I ncurses" },
--    { "cdw", terminal .. " -g 130x30 -e cdw"},
--    { "devede", "devede"},
--    { "ghb" , "ghb"}
}
mygames = {
--    { "playonlinux", "playonlinux"},
--    { "dosbox" , "dosbox"},
--    { "desura", "desura"},
    { "steam", "steam" },
    
}
mygraphics = {
    { "gimp" , "gimp" },
    { "feh" , "feh" }
}
myoffice = {
    { "libreoffice" , "libreoffice" }
    
}
mysystem = {
    { "htop" , tasks },
    { "lxappearance", "lxappearance" },
    { "SpaceFM", "spacefm" }
}
mymainmenu = awful.menu({ items = {
				    { "accessories" , myaccessories },
				    { "internet" , myinternet },
                                    { "media" , mymedia },
				    { "games" , mygames },
				    { "system" , mysystem },
                                    { "win8", "start8" },
            }
            })
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Colours
coldef  = "</span>"
colwhi  = "<span color='#b2b2b2'>"
colbwhi = "<span color='#ffffff'>"
blue = "<span color='#7493d2'>"
yellow = "<span color='#e0da37'>"
grey = "<span color='#636060'>"
purple = "<span color='#e33a6e'>"
lightpurple = "<span color='#eca4c4'>"
azure = "<span color='#80d9d8'>"
green = "<span color='#87af5f'>"
lightgreen = "<span color='#62b786'>"
red = "<span color='#bd0707'>"
orange = "<span color='#ff7100'>"
brown = "<span color='#db842f'>"
fuchsia = "<span color='#800080'>"
gold = "<span color='#e7b400'>"
lightblue="<span color='#3eae9e'>"
lightblue2="<span color='#266c76'>"
lightblue3="<span color='#285666'>"
lightblue4="<span color='#257c85'>"
lightblue5="<span color='#223d5a'>"
lightblue6="<span color='#235369'>"

offyellow="<span color='#857b52'>"
bottomgrey="<span color='#999999'>"

-- {{{ Wibox

-- {{{{ Temp

tempicon = wibox.widget.imagebox()
tempicon:set_image(beautiful.widget_temp)
tempwidget = wibox.widget.textbox()
vicious.register(tempwidget, vicious.widgets.thermal, bottomgrey .. "  Temp: $1°C" .. coldef, 15, "thermal_zone0")


-- }}}
 
-- {{{ Kernel Info
 
sysicon = wibox.widget.imagebox()
sysicon:set_image(beautiful.widget_arch)
syswidget = wibox.widget.textbox()
vicious.register( syswidget, vicious.widgets.os, bottomgrey .. "  Kernel: $2" .. coldef)
 
-- }}}
 
-- {{{ Uptime
 
uptimeicon = wibox.widget.imagebox()
uptimeicon:set_image(beautiful.widget_uptime)
uptimewidget = wibox.widget.textbox()
vicious.register( uptimewidget, vicious.widgets.uptime, bottomgrey .. "  Uptime: $1d $2h $3m" .. coldef)
 
-- }}}
 
-- {{{ Cpu
 
-- CPU widget
--cpuicon = wibox.widget.imagebox()
--cpuicon:set_image(beautiful.widget_cpu)
--cpuwidget = wibox.widget.textbox()
--vicious.register(cpuwidget, vicious.widgets.cpu, bottomgrey .. "  CPU: $1%" .. coldef, 15)
--cpuicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(tasks, false) end)))
 
-- }}}

 
-- {{{ Ram
 
-- Memory widget
--memicon = wibox.widget.imagebox()
--memicon:set_image(beautiful.widget_mem)
--memwidget = wibox.widget.textbox()
--vicious.register(memwidget, vicious.widgets.mem, bottomgrey .. "  Memory: $2MB" .. coldef, 15)
 
-- }}}
 
-- {{{ Mpd
 
mpdwidget = wibox.widget.textbox()
-- Register widget
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then
            return " - "
        else
            return bottomgrey .. args["{Artist}"] .. '</span>' .. colwhi .. ' - </span>' .. bottomgrey .. args["{Title}"] .. '</span>'
        end
    end, 10)
 
-- }}}
 
-- {{{ Net
-- Net widget
netdownicon = wibox.widget.imagebox()
netdownicon:set_image(beautiful.widget_netdown)
netdownicon.align = "middle"
netdowninfo = wibox.widget.textbox()
vicious.register(netdowninfo, vicious.widgets.net, green .. "${enp0s25 down_kb}" .. coldef, 1)
netupicon = wibox.widget.imagebox()
netupicon:set_image(beautiful.widget_netup)
netupicon.align = "middle"
netupinfo = wibox.widget.textbox()
vicious.register(netupinfo, vicious.widgets.net, red .. "${enp0s25 up_kb}" .. coldef, 1)
 
 
ethdowninfo = wibox.widget.textbox()
vicious.register(ethdowninfo, vicious.widgets.net, "<span color=\"#d3c6d7\">${enp0s25 down_kb}</span>", 1)
 
ethupinfo = wibox.widget.textbox()
vicious.register(ethupinfo, vicious.widgets.net, "<span color=\"#d3c6d7\">${enp0s25 up_kb}</span>", 1)
 
-- }}}
 
-- {{{ Volume
 
-- Volume widget
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)
volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume, bottomgrey .. "  Volume: $1%" .. coldef,  1, "PCM")
 
-- }}}

 
-- {{{ Clock
 
-- Textclock widget
clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.widget_clock)
mytextclock = awful.widget.textclock(bottomgrey .. "%A %d %B</span> " .. colwhi .. "</span><span color=\"#ffffff\">></span> <span color='#999999'>%H:%M</span>")
 
-- }}}
 
-- {{{ Spacers
space = wibox.widget.textbox()
space:set_text('    ')

-- {{{ Seperator
openb = wibox.widget.textbox(lightblue6 .. "[" .. coldef)
closeb = wibox.widget.textbox(lightblue6 .. "]" .. coldef)
 
-- }}}
 
-- Create a wibox for each screen and add it
mywibox = {}
--mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))
 
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
 
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
 
    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    --mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(space)
    left_layout:add(mypromptbox[s])
 
    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
--    right_layout:add(space)
--    right_layout:add(volicon)
--    right_layout:add(volumewidget)
    right_layout:add(space)
    -- right_layout:add(mylayoutbox[s])
 
    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytaglist[s])
    layout:set_right(right_layout)
 
    mywibox[s]:set_widget(layout)

--    local bl_layout = wibox.layout.fixed.horizontal()
--    bl_layout:add(openb)
--    bl_layout:add(mytextclock)
--    bl_layout:add(closeb)

--    local bm_layout = wibox.layout.fixed.horizontal()
--    bm_layout:add(space)
--    bm_layout:add(mytasklist[s])
--    bm_layout:add(space)

--    local br_layout = wibox.layout.fixed.horizontal()
--    br_layout:add(space)

--    local bottom_layout = wibox.layout.align.horizontal()
--    bottom_layout:set_left(bl_layout)
--    bottom_layout:set_middle(bm_layout)
--    bottom_layout:set_right(br_layout)
--    mybottomwibox[s]:set_widget(bottom_layout)
end
-- }}}

-- {{{ Start widget updates
--bashets.start()
-- }}}

-- Mouse Bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))


-- Key bindings
globalkeys = awful.util.table.join(

    -- Capture a screenshot
    awful.key({ altkey }, "p", function() awful.util.spawn("screenshot",false) end),

    

    -- Move clients
    awful.key({ altkey }, "Next",  function () awful.client.moveresize( 1,  1, -2, -2) end),
    awful.key({ altkey }, "Prior", function () awful.client.moveresize(-1, -1,  2,  2) end),
    --awful.key({ altkey }, "Down",  function () awful.client.moveresize(  0,  1,   0,   0) end),
    --awful.key({ altkey }, "Up",    function () awful.client.moveresize(  0, -1,   0,   0) end),
    --awful.key({ altkey }, "Left",  function () awful.client.moveresize(-1,   0,   0,   0) end),
    --awful.key({ altkey }, "Right", function () awful.client.moveresize( 1,   0,   0,   0) end),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
    mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    --mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    end),

    -- Application Switcher
     awful.key({ "Mod1" }, "Tab", function ()
     -- If you want to always position the menu on the same place set coordinates
     awful.menu.menu_keys.down = { "Down", "Alt_L" }
     local cmenu = awful.menu.clients({width=245}, { keygrabber=true, coords={x=525, y=330} })
 end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)     end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)          end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)          end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1)  end),
    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Dropdown terminal
    awful.key({ modkey,	          }, "z",     function () scratch.drop(terminal) end),

    -- Widgets popups

    -- Volume control
    awful.key({ "Control" }, "Up", function ()
                                       awful.util.spawn("amixer set PCM playback 1%+", false )
                                       vicious.force({ volumewidget })
                                   end),
    awful.key({ "Control" }, "Down", function ()
                                       awful.util.spawn("amixer set PCM playback 1%-", false )
                                       vicious.force({ volumewidget })
                                     end),
    awful.key({ "Control" }, "m", function ()
                                       awful.util.spawn("amixer set PCM playback mute", false )
                                       vicious.force({ volumewidget })
                                     end),
--    awful.key({ "Control" }, "u", function () 
--                                      awful.util.spawn("amixer set PCM playback unmute", false )
--                                       vicious.force({ volumewidget })
--                                  end),
    awful.key({ altkey, "Control" }, "m", function () 
                                              awful.util.spawn("amixer set PCM playback unmute", false )
                                              vicious.force({ volumewidget })
                                          end),

    -- Music control
    awful.key({ altkey, "Control" }, "Up", function () 
                                              awful.util.spawn( "mpc toggle", false ) 
                                              vicious.force({ mpdwidget } )
                                           end),
    awful.key({ altkey, "Control" }, "Down", function () 
                                                awful.util.spawn( "mpc stop", false ) 
                                                vicious.force({ mpdwidget } )
                                             end ),
    awful.key({ altkey, "Control" }, "Left", function ()
                                                awful.util.spawn( "mpc prev", false )
                                                vicious.force({ mpdwidget } )
                                             end ),
    awful.key({ altkey, "Control" }, "Right", function () 
                                                awful.util.spawn( "mpc next", false )
                                                vicious.force({ mpdwidget } )
                                              end ),

    -- Copy to clipboard
    awful.key({ modkey,        }, "c",      function () os.execute("xsel -p -o | xsel -i -b") end),

    -- User programs
    awful.key({ modkey,        }, "x",      function () awful.util.spawn( terminal, false ) end ),
    awful.key({ modkey, "Shift"}, "x",      function () awful.util.spawn( "terminator", false ) end ),
    awful.key({ modkey, "Control"}, "x",      function () awful.util.spawn( "terminator -l MuseDev", false ) end ),
    awful.key({ modkey,        }, "q",      function () awful.util.spawn( "dwb", false ) end),
    awful.key({ modkey, "Control" }, "m",       function () awful.util.spawn( terminal .. " -g 130x30 -e mutt", false ) end),

    awful.key({ modkey,        }, "s",      function () awful.util.spawn(gui_editor) end),
    awful.key({ modkey, "Control" }, "f", 	    function () awful.util.spawn( terminal .. " -depth 16 -g 130x30 -e ranger", false ) end),
    awful.key({ modkey, "Control" }, "v",           function () awful.util.spawn( "/usr/local/bin/video", false) end),
    -- awful.key({ modkey,        }, "d", 	    function () awful.util.spawn( "spacefm", false ) end),

    -- Conky

    -- Prompt
    awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey, "Control" }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9

keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


-- Set keys
root.keys(globalkeys)


-- Rules

awful.rules.rules = {
     -- All clients will match this rule.
     { rule = { },
       properties = { border_width = beautiful.border_width,
                      border_color = beautiful.border_normal,
                      focus = true,
                      keys = clientkeys,
                      buttons = clientbuttons,
	                  size_hints_honor = false
                     }
    },

    { rule = { class = "MPlayer" },
      properties = { floating = true } },

    { rule = { name = "PlayOnLinux" },
          properties = { tag = tags[1][1] } },

--    { rule = { instance = "urxvt", class = "URxvt" },
--          properties = { tag = tags[1][2] } },

    { rule = { class = "Chromium" },
          properties = { tag = tags[1][2] } },
    { rule = { class = "Sublime_text" },
          properties = { tag = tags[1][4] } },
    { rule = { instance = "urxvt", class = "URxvt", name = "sabcurses.py"},
          properties = { tag = tags[1][5] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "ranger"},
          properties = { tag = tags[1][1] } },      

    { rule = { instance = "urxvt", class = "URxvt", name = "weechat"},
          properties = { tag = tags[1][3] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "mutt" },
          properties = { tag = tags[1][3] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "htop" },
          properties = { tag = tags[1][1] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "cdw" },
          properties = { tag = tags[1][2] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "transmission-remote-cli"},
          properties = { tag = tags[1][3] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "vlc"},
          properties = { tag = tags[1][4] } },

    { rule = { class = "Conky" },
          properties = {
          floating = true,
          sticky = true,
          ontop = false,
	  border_width = 0,
          focusable = false,
          size_hints = {"program_position", "program_size"}
    } },
      
	  { rule = { class = "Ghb" },
        properties = { tag = tags[1][1] } },    

    { rule = { class = "Devede" },
        properties = { tag = tags[1][1] } },

    { rule = { name = "LibreOffice"},
        properties = { tag = tags[1][4] } },

    { rule = { class = "Gimp" },
          properties = { tag = tags[1][1],
          floating = true } },
    { rule = { class = "qemu-system-x86_64" },
          properties = {
              tag = tags[1][5],
              switchtotag = true,
              ontop = true,
          },
          callback = function(c) c.fullscreen = true end
    },

}


-- Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
