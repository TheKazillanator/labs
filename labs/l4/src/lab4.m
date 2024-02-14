clear
%% Noise input (1) and Response (2) data construction
file1 = "../input-data/scope_14.csv";

opts1 = detectImportOptions(file1);

data1 = readmatrix(file1, opts1);
% @param_1 tells matlab the range to sample from the excel, where the
% numbers are the rows
% @param_2 tells matlab what excel column to pick from
%  you likely will need to adjust the data differently on either excel or
%  matlab which could cause the sample range, cols, and biases to change.
% I did most of the leg work in excel by finding the minimum of each column
% and normalizing based off that .
t_N = data1(508:1253, 4);

noise_in = data1(508:1253, 5);

noise_out = (data1(508:1253, 6));

%% Step input (1) and Response (2) data construction 503:1248

file2 = "../input-data/scope_15.csv";

opts2 = detectImportOptions(file2);

data2 = readmatrix(file2,opts2);
%508 is max
t_step = data2(508:1253, 4);

% the .0101 may change based on the grpah of the step response
step_out = ((data2(508:1253, 5) - .0101 ).* 100 ); % 10.1 /2);
% len = length(step_out);
% diff = length(1500:1752);
% for i=0: diff
%     step_out(len - i) = 0;
% end


DeltaT = .0002; % if using 10ks/sec = 10000 samples/sec sampling rate
ConvData = conv(step_out, noise_in) .* DeltaT;
Time = DeltaT .*(0:(length(noise_in)-1));
figure(1)
hold on
pl_conv = plot(Time, ConvData(1:(length(noise_in)) ), 'r' );
pl_expect = plot(Time, noise_out, 'b');
hold off
figure(3)
pl_step_out = plot(Time, step_out);

figure(4)
pl_noise_in = plot(Time, noise_in);
