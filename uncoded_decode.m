function y = uncoded_decode(a)
y = zeros(1,length(a));    
    for i = 1:length(a)
        if (a(i))> 0
            y(i) = 1;
        else
            y(i) = 0;
        end
    end
end