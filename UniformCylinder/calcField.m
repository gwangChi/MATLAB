%{
 Description:   -Take in the position of a proton inside the BOLD model and
                returns the dipolar field in units of rads-1.

 Parameter:     -pos is the 2d/3d position array.
                -cpos is a 2d array which stores the coordinate a single
                cylinder center.
                -theta is the angle between BOLD model and the main field.
                -chi is the the susceptibility difference between entirely 
                deoxygenated blood and entirely oxygenated blood.
                -y is the degree of oxygenation of blood.
                -w0 is the strength of the main field in units of rads-1.
                -rcyl is the radius of vessel cylinders in m.
                
 Updated:       9/22/2018

 Update Details:-Removed sqrt and other redundant sqr functions.
%}
function dw = calcField(pos, cpos, theta, chi, y, w0, r_cyl)

    rsq = (pos(1)-cpos(1))^2 + (pos(2)-cpos(2))^2;
    
    if r < r_cyl
        dw = 2*pi*chi*(1-y)*w0*(cos(theta)^2-1/3);
    else
        dw = 2*pi*chi*(1-y)*w0*sin(theta)^2*r_cyl^2/rsq*((pos(1)-cpos(1))^2-(pos(2)-cpos(2))^2)/rsq;
    end
end
