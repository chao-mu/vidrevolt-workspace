width=1280
height=720

--midi = Midi("controllers/fighter_twister.yml")

kb = Keyboard()

print("Loading videos...")
vids = {
   Video("assets/animals/free/underwater/video.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/pexels-taryn-elliott-5548411.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/pexels-taryn-elliott-5548032.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/Pexels Videos 2556513.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/pexels-zlatin-georgiev-5607986.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/production ID_4195131.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/production ID_4491373.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/production ID_5136532.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/Pexels Videos 2556839.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/Pexels Videos 4513.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/Pexels Videos 2558530.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/Pexels Videos 2561846.mp4-SHRINK-REV.mp4"),
   Video("assets/animals/free/underwater/Video (1).mp4-SHRINK-REV.mp4"),
}

print("Videos loaded!")

function shuffle(tbl)
  math.randomseed(os.time())
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end

assert(#vids > 1)

shuffle(vids)

math.randomseed(os.time())
a_idx = math.random(#vids)
b_idx = math.random(#vids)
while a_idx == b_idx do
    b_idx = math.random(#vids)
end

a_vid = vids[a_idx]
b_vid = vids[b_idx]
dest_idx = 1

effects = {}
effects["shaders/pixelate.glsl"] = {"img0", "mix"}
effects["shaders/explode.glsl"] = {"img0", "mix"}
effects["shaders/mix_fade.glsl"] = {"b", "a", "mix"}
effects["shaders/rainbow-band.glsl"] = {"img0", "time", "mix"}
effects["shaders/pass.glsl"] = {"img0"}
effects["shaders/mask.glsl"] = {"img0", "mix", "mask"}
effects["shaders/rgb_to_hsv.glsl"] = {"rgb"}
effects["shaders/fake-3d.glsl"] = {"img0", "scale", "depth"}
effects["shaders/filter-whites.glsl"] = {"img0", "thresh"}
effects["shaders/color_02.glsl"] = {"img0", "mix"}
effects["shaders/color_01.glsl"] = {"img0", "mix"}
effects["shaders/flowing_noise.glsl"] = {"time"}
effects["shaders/white-to-black.glsl"] = {"img0"}
effects["shaders/invert.glsl"] = {"mix", "img0"}
effects["shaders/video-wall.glsl"] = {"img0", "mix", "min_brightness", "boxes"}
effects["shaders/zoom.glsl"] = {"img0", "amount"}
effects["shaders/blur.glsl"] = {"img0", "mix"}
effects["shaders/text-surround.glsl"] = {"text0", "img0", "speed"}
effects["shaders/rotate.glsl"] = {"img0", "speed"}
effects["shaders/band.glsl"] = {"img0", "target", "mix", "bands"}
effects["shaders/brighter.glsl"] = {"img0", "intensity"}
effects["shaders/edges.glsl"] = {"img0", "noise", "thresh", "mix", "negate"}
effects["shaders/negate.glsl"] = {"img0"}
effects["shaders/displace_by_rgb.glsl"] = {"img0", "mix"}
effects["shaders/band_mix.glsl"] = {"reference", "b", "a", "time", "mix", "bands"}
effects["shaders/mix.glsl"] = {"b", "a", "mix_lumin_b", "mix_lumin_a", "mix_fade3", "mix_fade2", "mix_fade", "mix_diff", "mix_bars"}
effects["shaders/displace_by_lum.glsl"] = {"img0", "mix"}
effects["shaders/kscope.glsl"] = {"img0", "center", "tweak_1", "mix"}
effects["shaders/color-tweak.glsl"] = {"img0", "gamma_inc", "gamma_dec", "gamma", "contrast_inc", "contrast_dec", "contrast", "brightness", "split"}
effects["shaders/flip.glsl"] = {"img0", "mix"}
effects["shaders/rgb.glsl"] = {"red", "green", "blue"}
effects["shaders/delay.glsl"] = {"img0", "mix"}
effects["shaders/displace_rgb.glsl"] = {"img0", "mix"}
effects["shaders/hsv_to_rgb.glsl"] = {"hsv"}
effects["shaders/test.glsl"] = {"img0", "blue"}
effects["shaders/flip-vertical.glsl"] = {"img0", "mix"}
effects["shaders/lums.glsl"] = {"img0"}
effects["shaders/magnitude.glsl"] = {"img0"}
effects["shaders/rotate-corners.glsl"] = {"img0"}
effects["shaders/negative.glsl"] = {"img0", "mix"}
effects["shaders/boxin.glsl"] = {"img0", "shrink"}
effects["shaders/knoty.glsl"] = {"img0", "mix"}
effects["shaders/move.glsl"] = {"img0", "offset_y", "offset_x"}
effects["shaders/maskify.glsl"] = {"img0", "lumin_threshold", "negate"}
effects["shaders/daily/00002.glsl"] = {"img0", "mix", "contrast"}
effects["shaders/feedback/explode.glsl"] = {"last_out"}
effects["shaders/daily/00003.glsl"] = {"img0", "time", "mix"}
effects["shaders/feedback/blackbar-exploder.glsl"] = {"last_out", "img0", "vertical"}
effects["shaders/masks/stripes.glsl"] = {"width", "height"}
effects["shaders/daily/00005.glsl"] = {"img0", "time", "mix"}
effects["shaders/daily/00006.glsl"] = {"b", "a", "mix"}
effects["shaders/feedback/implode.glsl"] = {"last_out"}
effects["shaders/masks/spiral.glsl"] = {"speed", "balance"}

shaders = {}
for key, params in pairs(effects) do
    table.insert(shaders, key)
end

function onControl(controller, control, value)
    if value < 0.5 then
        return
    end

    if control == "enter" then
        b_idx = next_index(b_idx, 1, vids)
        b_vid = vids[b_idx]
        print("b -> " .. b_vid)
    elseif control == "right_shift" then
        a_idx = next_index(a_idx, 1, vids)
        a_vid = vids[a_idx]
        print("a -> " .. a_vid)
    elseif control == "space" then
        cm:reseed()
        shuffle(shaders)
    elseif control == "n" then
        dest_idx = next_index(dest_idx, 1, cm.destinations)
    end
end

print("a = " .. a_vid)
print("b = " .. b_vid)

ChaosMonkey = {}
function ChaosMonkey.new()
    self = {}

    self.destinations = {}

    self.rand_stack = {}
    self.rand_index = 1

    self.write_stats = {}
    self.read_stats = {}

    function self:random()
        if self.rand_index > #self.rand_stack then
            table.insert(self.rand_stack, math.random())
        end

        local rand = self.rand_stack[self.rand_index]
        self.rand_index = self.rand_index + 1

        return rand
    end

    function self:random_element(arr)
        return arr[math.floor(#arr * self:random() + 1)]
    end

    function self:delete_dest(k)
        local indices = {}
        for i, v in pairs(self.destinations) do
            if v == k then
                table.insert(indices, i)
            end
        end

        for i, target in pairs(indices) do
            table.remove(self.destinations, target)
            self.write_stats[target] = nil
        end
    end

    function self:new_dest()
        return self:dest("ChaosMonkey:random:" .. self:random())
    end

    function self:dest(k)
        if k == nil then
            k = self:random_element(self.destinations)
        end

        if self.write_stats[k] == nil then
            self.write_stats[k] = 0
            table.insert(self.destinations, k)
        end

        self.write_stats[k] = self.write_stats[k] + 1

        return k
    end

    function self:src()
        local k = self:random_element(self.destinations)

        if self.read_stats[k] == nil then
            self.read_stats[k] = 0
        end

        self.read_stats[k] = self.read_stats[k] + 1

        return k
    end

    function self:start()
--        print("==READ STATS==")
--        for k, v in pairs(self.read_stats) do
--            print(k .. " " .. v)
--        end

        self.rand_index = 1
        self.write_stats = {}
        self.read_stats = {}
        self.destinations = {}
    end

    function self:reseed()
        print("reseed!")
        self.rand_stack = {}
        self.rand_index = 1
    end

    return self
end

print(effects[1])

cm = ChaosMonkey.new()
passes = 0
function render()
    params = getControlValues(kb)

    cm:start()

    copy_into(cm:dest("a"), a_vid)
    copy_into(cm:dest("b"), b_vid)
    copy_into(cm:new_dest(), params.c)
    copy_into(cm:new_dest(), params.c)
    --copy_into(cm:new_dest(), params.c)
    --copy_into(cm:new_dest(), params.c)
    --copy_into(cm:new_dest(), params.c)
    --copy_into(cm:new_dest(), params.c)

    for i=1,1 do
        for i, shader in pairs(shaders) do
            param_names = effects[shader]
            inputs = {}
            for i, param_name in ipairs(param_names) do
                inputs[param_name] = cm:src()
            end

            rend(cm:dest(), shader, inputs)
        end
    end

    copy_into("o", cm.destinations[dest_idx])
end

-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
--function dump(o)
--   if type(o) == 'table' then
--      local s = '{ '
--      for k,v in pairs(o) do
--         if type(k) ~= 'number' then k = '"'..k..'"' end
--         s = s .. '['..k..'] = ' .. dump(v) .. ','
--      end
--      return s .. '} '
--   else
--      return tostring(o)
--   end
--end

time_params = {}
function t(key, speed)
    if time_params[key] ~= nil then
        time_params[key] = time_params[key] + time_delta * speed
    else
        time_params[key] = 0
    end

    return time_params[key]
end

function value(input, amp, shift)
    amp = amp or 1
    input = input or 1
    shift = shift or shift

    return {input=input, amp=amp, shift=shift}
end


function next_index(i, diff, arr)
    local new = i + diff - 1
    if new < 0 then
        new = new + #arr
    end

    new = new % #arr

    return new + 1
end

function copy_into(dest, source)
    rend(dest, "shaders/pass.glsl", { img0=source })
end

