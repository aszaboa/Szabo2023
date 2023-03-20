
# Reused LU factorization as a preconditioner for efficient solution of the Parabolized Stability Equations

> An implementation of the incompressible 2D Parabolized Stability Equations (PSE) that demonstrates the how a single LU factorization can be reused to accelerate the solution of boundary layer-type problems. The code is written in the finite element language FreeFem, which interfaces the PETSc/SLEPc libraries. Although the code was run on a single process in the study, it also work on multiple processes, using a domain-decomposition technique.  

The code can reproduce Fig.14a  from the following [paper:TODO](TODO:doi). If you use this code, please consider citing the paper:
```
TODO: bibtex entry
```

## Code description
### Dependencies
Make sure you have access to a recent [FreeFEM](https://freefem.org/), compiled with the `PETSc` and `PETSc-complex` **(with SLEPc)** plugins. More details about the [PETSc](https://www.mcs.anl.gov/petsc/petsc-current/docs/manual.pdf) and [SLEPc](http://slepc.upv.es/documentation/slepc.pdf) options used in the solvers may be found in their respective manual.
### Running the code
The simulation can be run by the commands specified in the `run_PSE2D.sh` file, which was run under Ubuntu 18.04LTS to obtain the results. Then, the Matlab code `postprocess/run_Postprocess.m` can be run to generate the figure in the paper. 
### Code structure
The file `PSE2D.edp` organizes the simulation. Most of the variable definition are located in the `include/def_input.idp` file, and the functions/macros performing various tasks are declared in `include/macro_function.idp`. Several input variables can be specified via command-line arguments; these are declared by the word `getARGV` in the code. E.g., the number of mesh points in the streamwise direction can be changed by specifying `-Nx 80` when running the code, or the iterative solver can be chosen by setting `-iterSolver 1`.  The single exception is the input of the finite element order: it can be specified by`-DVelFE=P2`, `P3L` and `P4L`  for P2-P1, P3-P2 and P4-P2 Lagrangian finite elements (the latter being unstable). 
In general, the code contains a lot of comments to explain the functionalities. For more information regarding the functionalities, the interested reader is referred to the [FreeFem documentation](https://freefem.org/), [this](https://joliv.et/FreeFem-tutorial/) tutorial, the video tutorials available in the [FreeFem Youtube channel](https://www.youtube.com/@freefem9826), and the [FreeFem forum](https://community.freefem.org/).


