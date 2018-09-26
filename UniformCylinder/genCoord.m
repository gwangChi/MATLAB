%{
 Description:   -Take in the position of a proton inside and return a new
                one that satisfies the periodic boundary condition.

 Parameter:     -op is the 2d/3d position array.
                -lcube is the length of BOLD model cube in m.

 Updated:       9/22/2018

 Update Details:
%}
function np = genCoord(op, lcube)

    np = op;

    for i = 1:3
        
        if np(i) > lcube/2
            np(i) = np(i) - lcube;
        end
        if np(i) < -lcube/2
            np(i) = np(i) + lcube;
        end
        
    end

end






