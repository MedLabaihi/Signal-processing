% Function for modular exponentiation (efficient exponentiation by squaring)
function result = modExp(base, exp, modulus)
    result = 1;
    base = mod(base, modulus);
    while exp > 0
        if mod(exp, 2) == 1
            result = mod(result * base, modulus);
        end
        exp = floor(exp / 2);
        base = mod(base * base, modulus);
    end
end