clc;
clear all;
close all;

% Define prime numbers
p = 487; % Example prime number
q = 509; % Example prime number

% Compute n and phi(n)
n = p * q;
phi_n = (p - 1) * (q - 1);

% Choose a public exponent e
% Common choices: 3, 17, 65537
e_candidates = [3, 17, 65537];
e = 0;

% Find a suitable e that is coprime with phi_n
for i = 1:length(e_candidates)
    if gcd(e_candidates(i), phi_n) == 1
        e = e_candidates(i);
        break;
    end
end

if e == 0
    error('No suitable e found. Adjust the e_candidates array or check the prime numbers.');
end

% Compute the private exponent d
d = 0;
rem = 0;
while rem ~= 1
    d = d + 1;
    rem = mod((e * d), phi_n);
end

% Compute CRT parameters
dp = mod(d, (p - 1));
dq = mod(d, (q - 1));

% Compute qinv using the extended Euclidean algorithm
[qinv, ~] = egcd(q, p);

% Helper function for extended Euclidean algorithm
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

% Display results
fprintf('Public exponent e: %d\n', e);
fprintf('Private exponent d: %d\n', d);
fprintf('dp: %d\n', dp);
fprintf('dq: %d\n', dq);
fprintf('qinv: %d\n', qinv);
