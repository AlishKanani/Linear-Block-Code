clear; clc; close;

% Parameters %
N = 90000; %number of random bits
Eb_N0 = 0:1:10; % Eb/N0 with step size of 1dB
Eb_N0lin = 10.^(Eb_N0/10); % Linear Eb/No
x = randi([0,1],1,N); % transmitted information bits initialization
y_u = zeros(1,N);

% Channel coding %
l = lbk6_3_encode(x); %linear block coding with given (6,3) code
u = x; % uncoded

% BPSK modulation, s: symbols %
s_l = 2*l - 1;
s_u = 2*u - 1;

for j = 1:length(Eb_N0)
    % AWGN channel %
    
    a_l = awgn(s_l,(Eb_N0(j)+10*log10(2)),'measured');
    a_u = awgn(s_u,(Eb_N0(j)+10*log10(2)),'measured');
    
    % Channel decoder %
    y_l = lbk6_3_decode(a_l);
    y_u = uncoded_decode(a_u);

    % BER calculation simlated %
    ber_l(j) = sum(xor(x,y_l))/N;
    ber_u(j) = sum(xor(x,y_u))/N;

    % BER calculation theoretical %
    bert_u(j) = qfunc(sqrt(2*Eb_N0lin(j)));

end

semilogy(Eb_N0,ber_u,'go-');
hold on
semilogy(Eb_N0,bert_u,'r');
semilogy(Eb_N0,ber_l,'b');
title('BPSK over AWGN Simulation');xlabel('SNR in dB');ylabel('BER');
legend('BER(Simulated)','BER(Theoritical)')
grid