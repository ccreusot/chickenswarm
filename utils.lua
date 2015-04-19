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

return utils