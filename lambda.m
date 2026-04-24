function[lambda_out] = lambda(t, options)
% this function calculates value of lambda given time, initial value of
% lambda and ramping paramater r

    r = options.r;
    lambda_0 = options.lambda_0;
    
    lambda_out = lambda_0 - r*t;
end