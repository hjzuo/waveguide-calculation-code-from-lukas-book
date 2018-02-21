% wg_EIM_profile.m - Effective Index Method - mode profile
% Lukas Chrostowski, 2012
% usage, e.g.:
% wg_EIM_profile (1.55e-6, 0.22e-6, 0.5e-6, 90e-9, 3.47, 1, 1.44, 100, 2)
function wg_EIM_profile (lambda, t, w, t_slab, n_core, n_clad, n_oxide, pts, M)
% find TE (TM) modes of slab waveguide (waveguide core and slab portions):
[nTE,nTM]=wg_1D_analytic (lambda, t, n_oxide, n_core, n_clad);
if t_slab>0
[nTE_slab,nTM_slab]=wg_1D_analytic (lambda, t_slab, n_oxide, n_core, n_clad);
else
nTE_slab=n_clad; nTM_slab=n_clad;
end
[xslab,TE_Eslab,TE_Hslab,TM_Eslab,TM_Hslab]=wg_1D_mode_profile (lambda, t, n_oxide,n_core, n_clad, pts, M);
figure(1); clf; subplot (2,2,2); Fontsize=9;
plot(TE_Eslab/max(max(TE_Eslab)),xslab*1e9,'LineWidth',2);hold all;
ylabel('Height [nm]','FontSize',Fontsize);
xlabel('E-field (TE)','FontSize',Fontsize);
set(gca,'XTick',[]);
axis tight; a=axis; axis ([a(1)*1.1, a(2)*1.1, a(3), a(4)]);
Ax1 = gca; Ax2 = axes('Position',get(Ax1,'Position'));
get(Ax1,'Position');
nx=[n_oxide*ones(pts,1); n_core*ones(pts,1); n_clad*ones(pts,1)]';
plot (nx, xslab*1e9, 'LineWidth',0.5,'LineStyle','--','parent',Ax2);
a2=axis; axis ([a2(1), a2(2), a(3), a(4)]);
set(Ax2,'Color','none','XAxisLocation','top', 'YTick',[],'TickDir','in');
set(gca,'YAxisLocation','right'); box off;
xlabel('Material Index','FontSize',Fontsize);
set(gca,'FontSize',Fontsize);
% TE-like modes of the etched waveguide (for fundamental slab mode)
% solve for the "TM" modes:
[nTE,nTM]=wg_1D_analytic (lambda, w, nTE_slab(1), nTE(1), nTE_slab(1));
neff_TEwg=nTM;
[xwg,TE_E_TEwg,TE_H_TEwg,TM_E_TEwg,TM_H_TEwg]=wg_1D_mode_profile (lambda, w, nTE_slab(1),nTE(1), nTE_slab(1), pts, M);
subplot (2,2,3);
plot (xwg*1e9, TM_E_TEwg/max(max(TM_E_TEwg)), 'LineWidth',2,'LineStyle','-');
xlabel('Position [nm]','FontSize',Fontsize);
ylabel('E-field (TM, TE-like mode)','FontSize',Fontsize);
set(gca,'FontSize',Fontsize,'YTick',[]);
axis tight; a=axis; axis ([a(1), a(2), a(3)*1.1, a(4)*1.1]);
Ax1 = gca; Ax2 = axes('Position',get(Ax1,'Position'));
nx=[nTE_slab(1)*ones(pts,1); nTE(1)*ones(pts,1); nTE_slab(1)*ones(pts,1)]';
plot (xwg*1e9, nx, 'LineWidth',0.5,'LineStyle','--','parent',Ax2);
set(Ax2,'Color','none','YAxisLocation','right'); box off;
a2=axis; axis ([a(1), a(2), a2(3), a2(4)]);
ylabel('Slab Effective Index','FontSize',Fontsize);
set(gca,'FontSize',Fontsize);
% Plot the product of the two fields
% subplot (2,2,1); Exy=TM_E_TEwg(:,1)*(TE_Eslab(1,:));
% contourf(xwg*1e9,xslab*1e9,abs(Exy)/max(max(Exy))');
% xlabel ('X (nm)','FontSize',Fontsize);
% ylabel ('Y (nm)','FontSize',Fontsize);
% set (gca, 'FontSize',Fontsize);
% A=axis; axis([A(1)+0.4, A(2)-0.4, A(3)+.2, A(4)-0.2]);
% title('Effective Index Method');
% Draw the waveguide:
rectangle ('Position',[-w/2,-t/2,w,t]*1e9, 'LineWidth',1, 'EdgeColor','white')
if t_slab>0
rectangle ('Position',[-M*w,-t/2,(M-0.5)*w, t_slab]*1e9, 'LineWidth',1,'EdgeColor','white')
rectangle ('Position',[w/2,-t/2,(M-0.5),t_slab]*1e9, 'LineWidth',1,'EdgeColor','white')
end

function draw_WG_vertical(M)
pP=get(gca,'Position');pPw=pP(3);
pPc=pP(3)/2+pP(1); pP2=pPw/4/M;
annotation ('line',[pPc-pP2,pPc-pP2], [pP(2),pP(4)+pP(2)],'LineStyle','--');
annotation ('line',[pPc+pP2,pPc+pP2], [pP(2),pP(4)+pP(2)],'LineStyle','--');
axis tight; a=axis; axis ([a(1), a(2), a(3)*1.1, a(4)*1.1]);
function draw_WG_horiz(M)
pP=get(gca,'Position');pPw=pP(4);
pPc=pP(4)/2+pP(2); pP2=pPw/4/M;
annotation ('line',[pP(1),pP(3)+pP(1)], [pPc-pP2,pPc-pP2],'LineStyle','--');
annotation ('line',[pP(1),pP(3)+pP(1)], [pPc+pP2,pPc+pP2],'LineStyle','--');
axis tight; a=axis; axis ([a(1)*1.1, a(2)*1.1, a(3), a(4)]);
