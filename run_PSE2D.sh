#!/bin/bash 
# 
resFolder="results"
mkdir -p ${resFolder}  
caseVec=("directSolver" "iterSolver")
optionSTR=("" "-iterSolver 1")
nMeshPoints=(60 80 100 120 160 200 240 280 320 360 400 440 480)
nMeshPointsP3=(38 50 63 75 100 125 150 175 200 225 250 275 300)
for i in ${!caseVec[@]}; 
  do
    for j in ${!nMeshPoints[@]};
      do 
        for k in {0..4}
          do 
            fName_base=${resFolder}/${caseVec[$i]}_${j}_${k}
            ff-mpirun -np 1 PSE2D.edp -log_view -runName ${fName_base}  ${optionSTR[$i]} -npMesh ${nMeshPoints[$j]} -v 0 > ${fName_base}.out
            ff-mpirun -np 1 PSE2D.edp -log_view -runName ${fName_base}_P3 ${optionSTR[$i]} -npMesh ${nMeshPointsP3[$j]}  -DVelFE=P3L -v 0 > ${fName_base}_P3.out
          done 
      done 
  done 
  