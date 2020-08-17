function y = lbk6_3_hard_decode(x)
    y_demod = uncoded_decode(x);
    n = length(x);
    h_dist = zeros(1,8);
    G = [1 0 0 1 1 1; 0 1 0 1 1 0; 0 0 1 1 0 1];
    sample = [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1];
    code_book = sample*G;
    code_book = rem(code_book,2);

    for i = 1:(n/6)
        for j = 1:8
            h_dist(j) = sum(xor(code_book(j,:),y_demod((i-1)*6+1:(i-1)*6+6)));
        end
        [~, ind] = min(h_dist);
        y((i-1)*3+1:(i-1)*3+3) = code_book(ind,1:3);
    end
end