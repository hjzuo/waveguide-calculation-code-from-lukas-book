%single waveguide structure calculation 2017-11-2 13:33:44
clear all;
index_clad = 1.523;%1.523;
index_core=1.540;%index_core = 1.542;
delta_index=index_core-index_clad;

w=0.5:0.05:5; %waveguide with
eff_index_te=zeros(length(w));
eff_index_tm=zeros(length(w));
for i=1:length(w)
    [n_te, n_tm] = wg_1D_analytic (0.85e-6, w(i)*1e-6, 1.523,1.542, 1.523);
    for j=1:length(n_te)
        eff_index_te(i,j)=n_te(j);

    end
      for k=1:length(n_tm)
  
        eff_index_tm(i,k)=n_tm(k);
    end
%     eff_index_te(:,i)=[n_te  eff_index_te(:,i) ];
%     eff_index_tm(:,i)=[n_tm eff_index_tm(:,i) ];

end

plot(w, eff_index_te,'d');hold on; plot(w, eff_index_tm,'o');
axis([w(1) max(w)  index_clad index_core]); 
xlabel('waveguide width/height')
ylabel('effectie index')
