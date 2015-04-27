local utils = {}

-- lengthdir_x give you the length depending of the direction
-- direction in degree
-- speed (float or int)
function utils.lengthdir_x(direction, speed)
    local x = speed * math.cos(math.rad(direction))
    return x
end

-- lengthdir_y give you the length depending of the direction
-- direction in degree
-- speed (float or int)
function utils.lengthdir_y(direction, speed)
    local y = speed * math.sin(math.rad(direction))
    return y
end

-- retrieve direction from vector
function utils.point_direction(x, y, x2, y2)
    local direction = math.deg(math.atan2((y2 - y), (x2 - x)))
    return direction
end

function utils.point_distance(x, y, x2, y2)
    local distance = math.sqrt(((x2 - x) * (x2 - x)) + ((y2 - y) * (y2 - y)))
    return distance
end

function utils.circles_collision(x, y, r, x2, y2, r2)
    local delta = (x - x2) * (x - x2) + (y - y2) * (y  - y2)
    local rDelta  = (r + r2) * (r + r2)
    return (delta < rDelta)
end

-- Methode pour dump les table
-- le parametre est la table a dump
function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end



return utils
