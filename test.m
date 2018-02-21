
t=0.22e-6;
[nTE, nTM] = wg_1D_analytic (1.55e-6, t, 1.444, 3.47, 1.444)

[x, TE_E, TE_H, TM_E, TM_H] = wg_1D_mode_profile (1.55e-6, t, 1.444, 3.47, 1.444,100, 4);
bar(TE_E);
