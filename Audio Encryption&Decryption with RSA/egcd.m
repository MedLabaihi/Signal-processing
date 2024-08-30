% Extended Euclidean Algorithm function to compute modular inverse
function [x, y] = egcd(a, b)
    if a == 0
        x = 0;
        y = 1;
        return;
    end
    [x1, y1] = egcd(mod(b, a), a);
    x = y1 - floor(b / a) * x1;
    y = x1;
end