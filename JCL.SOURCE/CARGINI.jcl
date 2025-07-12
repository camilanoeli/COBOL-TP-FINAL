//CARGINI JOB (ACCT),'CARGA INICIAL',CLASS=A,MSGCLASS=H,NOTIFY=&SYSUID
//******************************************************************
//*  JCL: CARGINI                                                  *
//*  DESCRIPCION: Carga inicial de libros                          *
//*  AUTOR: Z70681 (CAMILA NOELI ABUIN)                            *
//*  PASOS:                                                        *
//*    1 - Borra y redefine el cluster VSAM                        *
//*    2 - Compila y link-edita el programa COBOL (CARGINI)        *
//*    3 - Ejecuta el programa cargando datos y generando reporte  *
//******************************************************************
//*
//**************************************************************
//*  PASO 1 - BORRA Y DEFINE EL CLUSTER VSAM DE LIBROS         *
//**************************************************************
//VSAMDEF  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DELETE Z70681.VSAM.LIBROS PURGE
  SET MAXCC = 0
  DEFINE CLUSTER (NAME(Z70681.VSAM.LIBROS) -
    RECSZ(250 250) KEYS(10 0) CYLINDERS(10 3) -
    INDEXED SHAREOPTIONS(2 3)) -
    DATA (NAME(Z70681.VSAM.LIBROS.DATA)) -
    INDEX (NAME(Z70681.VSAM.LIBROS.INDEX))
/*
//***************************************************************
//*  PASO 2 - COMPILACION Y LINKEDIT DEL PROGRAMA CARGINI       *
//***************************************************************
//COMPILA  EXEC IGYWCLG,COND=(0,GT)
//*
//******* COPYBOOKS ********************************************
//COBOL.SYSLIB   DD DSN=&SYSUID..COBOL.COPYLIB,DISP=SHR
//*
//******* FUENTE ***********************************************
//COBOL.SYSIN    DD DSN=&SYSUID..COBOL.SOURCE(CARGINI),DISP=SHR
//*
//******* SALIDAS DEL COMPILADOR *******************************
//COBOL.SYSPRINT DD SYSOUT=*
//COBOL.SYSTERM  DD SYSOUT=*
//*
//******* CARGA DEL MODULO COMPILADO ***************************
//LKED.SYSLMOD   DD DSN=&SYSUID..LOAD.LIBRARY(CARGINI),DISP=SHR
//LKED.SYSLIB    DD DSN=CEE.SCEELKED,DISP=SHR
//LKED.SYSPRINT  DD SYSOUT=*
//LKED.SYSTERM   DD SYSOUT=*

//***************************************************************
//*  PASO 3 - EJECUCION DEL PROGRAMA CARGINI                    *
//***************************************************************
//*
//******* LIBRERIAS DE CARGA ************************************
//GO.STEPLIB    DD DSN=&SYSUID..LOAD.LIBRARY,DISP=SHR
//           DD DSN=CEE.SCEERUN,DISP=SHR
//*
//******* ARCHIVO DE ENTRADA SECUENCIAL *************************
//GO.ENTRADA    DD DSN=&SYSUID..DATA.LIBROS,DISP=SHR
//*
//******* ARCHIVO MAESTRO VSAM DE LIBROS ************************
//GO.MAESTRO    DD DSN=&SYSUID..VSAM.LIBROS,DISP=SHR
//*
//******* ARCHIVO DE REPORTE ************************************
//GO.REPORTE    DD DSN=&SYSUID..REPORTES.GENERAL,DISP=SHR
//*
//******* SALIDAS DEL PROGRAMA **********************************
//GO.SYSPRINT   DD SYSOUT=*
//GO.SYSOUT     DD SYSOUT=*
//GO.SYSUDUMP   DD SYSOUT=*

//GO.STEPLIB   DD DSN=&SYSUID..LOAD.LIBRARY,DISP=SHR
//GO.ENTRADA   DD DSN=&SYSUID..DATA.LIBROS,DISP=SHR
//GO.MAESTRO   DD DSN=&SYSUID..VSAM.LIBROS,DISP=SHR
//GO.REPORTE   DD DSN=&SYSUID..REPORTES.GENERAL,DISP=SHR
//GO.SYSOUT    DD SYSOUT=*
