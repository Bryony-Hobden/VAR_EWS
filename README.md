# VAR_EWS
Code associated with 'Early warnings of critical transitions through vector autoregression: lessons from multiscale systems' publication

Create 3 folders in the same directory:
- Code 
- Figures
- Data

Save code files into the code folder.

Parameters.m contains the parameters used for the fold, subcritical and singular Hopf systems for the VAR eigenvalue estimation.

Parameteres_pp{Fold, Hopf, SingHopf}.m contains the parameters used to generate the trajectories used for phase portraits (ramping parameter r=0 in the frozen systems). All Parameter files can be edited.

Run DoSimulations.pp.m to produce data to plot all phase portraits.
Run DoSimulations.m to produce data for the VAR plots.

Run DoFigures to produce and save figures for the VAR estimation for the three systems.
Run DoPhaseportraits_{Fold, Hopf, SingHopf}.m to produce phase portraits for the three systems (ramping parameter r=0 in the frozen systems).

make_analysis_fig.m is a function that outputs the figures for the variable, VAR estimate, and AR1 comparison.

The remaining functions are used in the integration of the systems, using a Heun integrator.
