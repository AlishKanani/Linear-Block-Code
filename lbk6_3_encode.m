function y = lbk6_3_encode(x)
    % Parameter
    n = length(x);
    G = [1 0 0 1 1 1; 0 1 0 1 1 0; 0 0 1 1 0 1];
    y = zeros(1,2*n);

    for i = 0:((n/3)-1)
        y(6*i+1:6*i+6) = x(3*i+1:3*i+3)*G;
    end
    y = rem(y, 2);
end