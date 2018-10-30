%{
 Description:   -

 Parameter:     -

 Updated:       10/18/2018

 Update Details:
%}
function dmdt = blochSolver(t, m, tstep, n, w, wr)
    m = reshape(m,[3 n]);
    m_ = mean(m,2);

    %if mod(floor(t/(2e-3)), 2) == 0
        currw = w(:, :, 1+floor(t/tstep)) + repmat(wr*[-m_(2); m_(1); 0], 1, n);
    %else
    %    currw = w(:, :, 1+floor(t/tstep)) + repmat(wr*[m_(2); -m_(1); 0], 1, n);
    %end

    dmdt = cross(m, currw);
    dmdt = dmdt(:);
end

%     if (t-2e-3)/4e-3 == floor((t-2e-3)/4e-3)
%         
%     end