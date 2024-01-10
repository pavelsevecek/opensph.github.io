require("math")

-- Name of this object. This will be the label of the button added to 'Custom objects'.
objectName = "Color cloud";

-- Table of object parameters that will be shown in the UI.
parameters = {}

parameters.radius = Constants.R_Earth;
parameters.density = 10000;
parameters.spinRate = 0.0004;
parameters.particleScale = 0.01;

-- Returns the total volume of the object. This function is used to determine 
-- how many particles are assigned to the object.
function getVolume()
    return 0.02 * math.pi * math.pow(parameters.radius, 3);
end

-- Returns the total mass of the object.
function getTotalMass()
    return getVolume() * parameters.density;
end

math.randomseed(os.time())

-- Main entry point of the script. The function will create a table containing 
-- all particle data of the object.
function generate(n)
    state = {}
    state.position = {};
    state.velocity = {};
    state.mass = {};
    state.density = {};
    state.radius = {};
    state.color = {};

    phi = 2 * math.pi / n;
    for i=1,n
    do
        r = math.pow(math.random(), 0.66) * parameters.radius;
        v = r * parameters.spinRate;
        state.position[i] = { r * math.cos(phi * i),
                              r * math.sin(phi * i),
                              0.01 * parameters.radius * (math.random(-1, 1)) };
        state.velocity[i] = { v * math.sin(phi * i),
                              -v * math.cos(phi * i),
                              0 };
        state.radius[i] = parameters.particleScale * Constants.R_Earth;
        state.density[i] = parameters.density;
        state.mass[i] = parameters.density * 4.0/3.0 * math.pi * math.pow(state.radius[i], 3);
        state.color[i] = { state.position[i][1] / r,
                           0.5,
                           state.position[i][2] / r };
    end
    
    return state;
end