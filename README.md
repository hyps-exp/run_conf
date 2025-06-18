# Make data base and analyzer_configuration files

## run_conf.json
Database linked to the run number and parameter files  
example:  
"02305": {  
     "BGOCALIB": "../BGOCALIB/BGOEnergyCalib.txt.08082",  
     "BGOTEMP": "../BGOTEMP/run08082.txt",  
     "BH2FLT": "../BH2FLT/BH2Filter_20180603",  
     "CATCHPID": "../CATCHPID/CATCHPid.txt.08291",  
     "CFTPED": "../CFTPED/pedestalCorOut2.txt.250117",  
     "CFTPOS": "../CFTPOS/CftPosParam_hyps_20250312",  
     "CMAP": "../CMAP/channel_map_hyps_20250516.xml",  
     "DCDRFT": "../DCDRFT/DCDriftParam_hyps_run01413",  
     "DCGEO": "../DCGEO/DCGeomParam_hyps_20250414",  
     "DCTDC": "../DCTDC/DCTdcCalib_hyps_run01413",  
     "DIGIT": "../DIGIT/digit_data_hyps_20250419.xml",  
     "EVSELECT": "../EVSELECT/event_dummy.txt",  
     "FLDCALC": "1.",  
     "FLDMAP": "../fieldmap/lepsSD53_std_v12_K18style_extend.dat",  
     "FLDNMR": "1.",  
     "HDPHC": "../HDPHC/HodoPHCParam_hyps_20250429",  
     "HDPRM": "../HDPRM/HodoParam_hyps_20250416",  
     "K18TM": "../K18TM/K18MatrixParamD2U_0",  
     "MATRIX2D1": "../MATRIX/mtx2d1_e42_GEANT4_Normal.txt",  
     "MATRIX2D2": "../MATRIX/mtx2d1_e42_GEANT4_tight.txt",  
     "MATRIX3D": "../MATRIX/mtx3d_e42_GEANT4.txt",  
     "PK18": "1.8",  
     "TAGPLMTH": "../TAGPLMTH/TAGPLMatchParam_hyps_0",  
     "UNPACK": "../UNPACK/unpacker_online.xml",  
     "USER": "../USER/UserParam_hyps_20250517.txt"  
 }  

## How to add or update the database
```
$ make
$ ./bin/param_db_tool add [run_number] [KEY=FILENAME]
```

## print the database
```
$ ./bin/param_db_tool print [run_number]
```

## remove the database
```
$ ./bin/param_db_tool remove [run_number]
```

### Macro for updating a database of many runs
```
$ ./set_conf.sh [run_min] [run_max]
```

### How to make a analyzer configuration file
```
$ ./make_conf.py [run_number]
```
OUTPUT: conf/analyzer_hyps_[run_number].conf

