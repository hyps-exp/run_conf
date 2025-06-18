#!/bin/zsh
# Usage: ./set_conf.sh [min_run] [max_run]

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <min_run> <max_run>"
  exit 1
fi

MIN_RUN=$1
MAX_RUN=$2

if ! [[ "$MIN_RUN" =~ ^[0-9]+$ ]] || ! [[ "$MAX_RUN" =~ ^[0-9]+$ ]]; then
    echo "Error: Run numbers must be integers."
    exit 1
fi

if [ "$MAX_RUN" -lt "$MIN_RUN" ]; then
    echo "Error: max_run ($MAX_RUN) must be greater than or equal to min_run ($MIN_RUN)."
    exit 1
fi

PARAMS=(
  "UNPACK=../UNPACK/unpacker_online.xml"
  "DIGIT=../DIGIT/digit_data_hyps_20250419.xml"
  "CMAP=../CMAP/channel_map_hyps_20250516.xml"
  "BH2FLT=../BH2FLT/BH2Filter_20180603"
  "TAGPLMTH=../TAGPLMTH/TAGPLMatchParam_hyps_0"
  "DCGEO=../DCGEO/DCGeomParam_hyps_20250414"
  "DCDRFT=../DCDRFT/DCDriftParam_hyps_run01413"
  "DCTDC=../DCTDC/DCTdcCalib_hyps_run01413"
  "HDPRM=../HDPRM/HodoParam_hyps_20250416"
  "HDPHC=../HDPHC/HodoPHCParam_hyps_20250429"
  "FLDMAP=../fieldmap/lepsSD53_std_v12_K18style_extend.dat"
  "FLDNMR=1."
  "FLDCALC=1."
  "PK18=1.8"
  "K18TM=../K18TM/K18MatrixParamD2U_0"
  "MATRIX2D1=../MATRIX/mtx2d1_e42_GEANT4_Normal.txt"
  "MATRIX2D2=../MATRIX/mtx2d1_e42_GEANT4_tight.txt"
  "MATRIX3D=../MATRIX/mtx3d_e42_GEANT4.txt"
  "USER=../USER/UserParam_hyps_20250517.txt"
  "CFTPED=../CFTPED/pedestalCorOut2.txt.250117"
  "CFTPOS=../CFTPOS/CftPosParam_hyps_20250312"
  "BGOTEMP=../BGOTEMP/run08082.txt"
  "BGOCALIB=../BGOCALIB/BGOEnergyCalib.txt.08082"
  "EVSELECT=../EVSELECT/event_dummy.txt"
  "CATCHPID=../CATCHPID/CATCHPid.txt.08291"
)

for (( RUN=MIN_RUN; RUN<=MAX_RUN; RUN++ )); do
  echo "Updating run $RUN ..."
  ./bin/param_db_tool add "$RUN" "${PARAMS[@]}"
done

echo "All done."
