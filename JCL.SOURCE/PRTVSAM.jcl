//PRTVSAM JOB (ACCT),'PRINT VSAM',CLASS=A,MSGCLASS=H,NOTIFY=&SYSUID
//******************************************************************
//*  JCL: PRTVSAM                                                  *
//*  DESCRIPCION: Lectura del archivo VSAM de libros               *
//*  AUTOR: Z70681 (CAMILA NOELI ABUIN)                            *
//******************************************************************
//*
//***************************************************************
//* PASO 1 - COMPILACION Y LINKEDIT DEL PROGRAMA PRTVSAM        *
//***************************************************************
//COMPILE  EXEC IGYWCLG
//COBOL.SYSLIB   DD DSN=&SYSUID..COBOL.COPYLIB,DISP=SHR
//COBOL.SYSIN    DD DSN=&SYSUID..COBOL.SOURCE(PRTVSAM),DISP=SHR
//COBOL.SYSPRINT DD SYSOUT=*
//COBOL.SYSTERM  DD SYSOUT=*
//LKED.SYSLMOD   DD DSN=&SYSUID..LOAD.LIBRARY(PRTVSAM),DISP=SHR
//LKED.SYSLIB    DD DSN=CEE.SCEELKED,DISP=SHR
//LKED.SYSPRINT  DD SYSOUT=*
//LKED.SYSTERM   DD SYSOUT=*

//***************************************************************
//* PASO 2 - EJECUCION DEL PROGRAMA PRTVSAM                     *
//***************************************************************
//GO.STEPLIB  DD DSN=&SYSUID..LOAD.LIBRARY,DISP=SHR
//GO.MAESTRO  DD DSN=&SYSUID..VSAM.LIBROS,DISP=SHR
//GO.SYSOUT   DD SYSOUT=*
//GO.SYSPRINT DD SYSOUT=*
//GO.SYSUDUMP DD SYSOUT=*
