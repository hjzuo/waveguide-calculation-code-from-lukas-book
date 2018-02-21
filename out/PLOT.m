
% load('2um_Ormoclad_3um_TOX_bending_loss_for_computation_area_of_8_8um.mat');
% coupling_loss=1-power_coupling;
% plot(radii,LossPerBend,"d");title("Loss per bend");
% 
% %plot(radii,coupling_loss,"o");title("coupling loss");
% plot(radii,TM0_modeoverlap,"d");
load('Only_3um_TOX_bending_loss_for_computation_area_of_8_8um.mat')
%radiation loss per cm
semilogy(radii,TM0_PLOSS,"d");xlabel("Bending Radius");ylabel("Rdiation Loss db/cm");title("Radiation Loss vs. Bending Radius")
grid on;

%%
%Rdiation Loss per bend
for i=1:length(radii)
    TM0_PLOSS_per_bend(i)=TM0_PLOSS(i)*radii(i)*2*pi/4/1000;
end
semilogy(radii,TM0_PLOSS_per_bend,"d",radii,TM0_PLOSS,"o");xlabel("Bending Radius/um");ylabel("Rdiation Loss");title("Radiation Loss vs. Bending Radius")
legend("Radiation Loss dB/cm","Radiation Loss dB/Bend")
grid on;
%% Mode overlap loss
TM0_overlap_loss=-pow2db(TM0_modeoverlap.^2);
plot(radii,TM0_overlap_loss,"d");xlabel("Bending Radius/um");ylabel("Mode Mismatch Loss");title("Mode Mismatch Loss vs. Bending Radius")
grid on;

%% total loss
semilogy(radii,TM0_PLOSS_per_bend,"--d",radii,TM0_PLOSS,"--o", radii, TM0_overlap_loss,"--*");xlabel("Bending Radius/um");ylabel("Rdiation Loss");title("Radiation Loss vs. Bending Radius")
legend("Radiation Loss dB/cm","Radiation Loss dB/Bend","Mode Mismatch Loss");

grid on;


