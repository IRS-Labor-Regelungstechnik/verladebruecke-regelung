/***************************************************************************

   Source file aktoren_sensoren_ansprechen_trc_ptr.c:

   Definition of function that initializes the global TRC pointers

   RTI1202 7.7 (02-Nov-2016)
   Fri Nov 27 12:55:48 2020

   Copyright 2020, dSPACE GmbH. All rights reserved.

 *****************************************************************************/

/* Include header file. */
#include "aktoren_sensoren_ansprechen_trc_ptr.h"
#include "aktoren_sensoren_ansprechen.h"
#include "aktoren_sensoren_ansprechen_private.h"

/* Compiler options to turn off optimization. */
#if !defined(DS_OPTIMIZE_INIT_TRC_POINTERS)
#ifdef _MCCPPC

#pragma options -nOt -nOr -nOi -nOx

#endif

#ifdef __GNUC__

#pragma GCC optimize ("O0")

#endif

#ifdef _MSC_VER

#pragma optimize ("", off)

#endif
#endif

/* Definition of Global pointers to data type transitions (for TRC-file access) */
volatile real_T *p_0_aktoren_sensoren_ansprechen_real_T_0 = NULL;
volatile boolean_T *p_0_aktoren_sensoren_ansprechen_boolean_T_1 = NULL;
volatile real_T *p_1_aktoren_sensoren_ansprechen_real_T_0 = NULL;
volatile boolean_T *p_2_aktoren_sensoren_ansprechen_boolean_T_2 = NULL;

/*
 *  Declare the functions, that initially assign TRC pointers
 */
static void rti_init_trc_pointers_0(void);

/* Global pointers to data type transitions are separated in different functions to avoid overloading */
static void rti_init_trc_pointers_0(void)
{
  p_0_aktoren_sensoren_ansprechen_real_T_0 =
    &aktoren_sensoren_ansprechen_B.SFunction1;
  p_0_aktoren_sensoren_ansprechen_boolean_T_1 =
    &aktoren_sensoren_ansprechen_B.SFunction1_o2_p;
  p_1_aktoren_sensoren_ansprechen_real_T_0 =
    &aktoren_sensoren_ansprechen_P.Constant_Value;
  p_2_aktoren_sensoren_ansprechen_boolean_T_2 =
    &aktoren_sensoren_ansprechen_DW.objisempty;
}

void aktoren_sensoren_ansprechen_rti_init_trc_pointers(void)
{
  rti_init_trc_pointers_0();
}
