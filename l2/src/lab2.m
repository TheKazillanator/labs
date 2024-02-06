clear all
close all
clc

time_start = 0;
 time_final = 1;
 t_step = 5000;
 R = 5.1e3;
 C = 3.3e-6;
 k = 1/(R*C);
 
 %t = sym('t');


 %% Base

vin_t = linspace(time_start,time_final,t_step);
vin =  heaviside(vin_t - .00000001);
Tspan = [time_start time_final];

theor_vin = (1 - exp((- vin_t) / (R * C) ));

IC = 0;

options=odeset('RelTol',1e-4);

[vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);
%% experimental data construction
file = "../res/scope_0.csv";
opts = detectImportOptions(file);

data = readmatrix(file, opts);

t_ex = data(:, 4) - .314;

vin_ex = data(:, 5);

vout_ex = data(:, 6);
%preview(file,opts);


%% plot 
figure(1)

hold on

title("Voltage v. Time for Simulation and Theory")
xlabel('Time (Seconds)')
ylabel('Voltage (Volts)')
xlim([-.1 .8])
ylim([ -.1 1.2])


%%% Simulation
ps = plot(vout_t, vout,"-.",'LineWidth',3);


%%% Theoretical

pt = plot(vin_t, theor_vin, ":",'LineWidth',3);

%% plot 
figure(2)

hold on

title("Simulation and Theory Compared to Experimental Results")
xlabel('Time (Seconds)')
ylabel('Voltage (Volts)')
xlim([-.1 .8])
ylim([ -.1 1.2])


%%% Simulation
ps = plot(vout_t, vout,"-.",'LineWidth',3);


%%% Theoretical

pt = plot(vin_t, theor_vin, ":",'LineWidth',3);



%%% Experimental in

p_ex_in = plot(t_ex, vin_ex, "-",'LineWidth',1);



%%% Experimental out'

p_ex_out = plot(t_ex, vout_ex, "--", 'LineWidth', 3);


legend('Simulation', 'Theoretical', 'Experimental In', 'Experimental Out');


hold off


