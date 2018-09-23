%{
 Description:   -Take in the old position of a proton inside the BOLD model
                and the new position after a random walk and return true if
                no cylinders are trespassed.

 Parameter:     -op is the 2d/3d old position array.
                -np is the 2d/3d new position array.
                -cp is a 2d array which stores the coordinate a single
                cylinder center.
                -rcyl is the radius of vessel cylinders in m.

 Updated:       9/22/2018

 Update Details:
%}
function flag = isTrespass(op, np, cp, rcyl)

    od = sqrt((op(1)-cp(1))^2+(op(2)-cp(2))^2);
    nd = sqrt((np(1)-cp(1))^2+(np(2)-cp(2))^2);

    flag = not((od > rcyl && nd <= rcyl) || (od <= rcyl && nd > rcyl));
end