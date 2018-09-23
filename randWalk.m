%{
 Description:   -Take in the old position of a proton inside the BOLD model
                and return the new position after one random walk.

 Parameter:     -op is the 2d/3d position array.
                -lstep is the length of one random walk step in m.
                -lcube is the length of BOLD model cube in m.
                -rcyl is the radius of vessel cylinders in m.
                -cpos is a cell of 2d arrays which stores the coordinates
                of the cylinder centers.

 Updated:       9/22/2018

 Update Details:
%}
function np = randWalk(op, lstep, lcube, rcyl, cpos)

    flag = true;
    
    while flag
        u = -1 + rand*2;
        phi = rand*2*pi;
        step = lstep*[sqrt(1-u^2)*cos(phi); sqrt(1-u^2)*sin(phi); u];

        np = genCoord(op+step, lcube);
        flags = cell2mat(cellfun(@(cp) isTrespass(op, np, cp, rcyl), cpos, 'UniformOutput',false));
        flag = all(flags(:));
    end
end