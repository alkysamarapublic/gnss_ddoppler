%test_single_orbit;
close all;

max_index = 50;

data_X = fus/gnss_u_delta*gnss_dt;
data_X = data_X(1:max_index);
data_Y_original = dopp(1:max_index);

ind1 = round(max_index*0.2);
ind2 = round(max_index*0.7);

data_Y_dashed = data_Y_original;
data_Y_dashed(ind1 : ind2) = data_Y_original(ind1);

data_Y_dashed2 = data_Y_original;
k = data_Y_original(ind1)-data_Y_original(ind1-1);
data_Y_dashed2(ind1:ind2) = k*((ind1:ind2)-ind1)+data_Y_original(ind1);

figure(1);
subplot(1,2,1);
plot(data_X, data_Y_original, 'b-', data_X, data_Y_dashed, 'r--');
grid on

subplot(1,2,2);
plot(data_X, data_Y_original, 'b-', data_X, data_Y_dashed2, 'r--');
grid on
set(gcf,'Color','w');