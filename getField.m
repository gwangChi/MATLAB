%{
 Description:   -Take in the position of a proton inside the BOLD model and
                returns the dipolar field in units of rads-1.

 Parameter:     -pos is the 2d/3d position array.
                -theta is the angle between BOLD model and the main field.
                -chi is the the susceptibility difference between entirely 
                deoxygenated blood and entirely oxygenated blood.
                -y is the degree of oxygenation of blood.
                -w0 is the strength of the main field in units of rads-1.
                -rcyl is the radius of vessel cylinders in m.
                -cpos is a cell of 2d arrays which stores the coordinates
                of the cylinder centers.

 Updated:       9/22/2018

 Update Details:
%}
function dw = getField(pos, theta, chi, y, w0, rcyl, cpos)
    W = cell2mat(cellfun(@(cp) calcField(pos, cp, theta, chi, y, w0, rcyl), cpos, 'UniformOutput',false));
    dw = sum(W(:));
end
