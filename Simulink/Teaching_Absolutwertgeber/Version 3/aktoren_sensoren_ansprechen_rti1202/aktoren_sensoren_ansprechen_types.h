/*
 * aktoren_sensoren_ansprechen_types.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "aktoren_sensoren_ansprechen".
 *
 * Model version              : 1.16
 * Simulink Coder version : 8.11 (R2016b) 25-Aug-2016
 * C source code generated on : Fri Nov 27 12:55:48 2020
 *
 * Target selection: rti1202.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Custom Processor->Custom
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_aktoren_sensoren_ansprechen_types_h_
#define RTW_HEADER_aktoren_sensoren_ansprechen_types_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#ifndef DEFINED_TYPEDEF_FOR_struct_isB4Cw3Ovpp8VfzP6RUqbD_
#define DEFINED_TYPEDEF_FOR_struct_isB4Cw3Ovpp8VfzP6RUqbD_

typedef struct {
  int32_T OutputPortsWidth;
} struct_isB4Cw3Ovpp8VfzP6RUqbD;

#endif

#ifndef struct_tag_skdo9V17t1NVcGTcNjO2SaF
#define struct_tag_skdo9V17t1NVcGTcNjO2SaF

struct tag_skdo9V17t1NVcGTcNjO2SaF
{
  int32_T isInitialized;
  real_T time1;
  real_T time2;
  real_T time_set1;
  real_T time_set2;
  real_T Schritt2;
  real_T Schritt3;
  real_T Schritt4;
  real_T Schritt5;
  real_T prop_n_Motor;
  real_T prop_Abswertgeber_Set;
  real_T schiene_zaehler;
  real_T schiene_zaehler_set;
  real_T schiene_zaehler_sleep;
};

#endif                                 /*struct_tag_skdo9V17t1NVcGTcNjO2SaF*/

#ifndef typedef_Motorsteuerung2_aktoren_senso_T
#define typedef_Motorsteuerung2_aktoren_senso_T

typedef struct tag_skdo9V17t1NVcGTcNjO2SaF Motorsteuerung2_aktoren_senso_T;

#endif                                 /*typedef_Motorsteuerung2_aktoren_senso_T*/

#ifndef typedef_struct_T_aktoren_sensoren_ans_T
#define typedef_struct_T_aktoren_sensoren_ans_T

typedef struct {
  real_T f0[2];
  real_T f1[2];
  real_T f2[2];
} struct_T_aktoren_sensoren_ans_T;

#endif                                 /*typedef_struct_T_aktoren_sensoren_ans_T*/

/* Parameters (auto storage) */
typedef struct P_aktoren_sensoren_ansprechen_T_ P_aktoren_sensoren_ansprechen_T;

/* Forward declaration for rtModel */
typedef struct tag_RTM_aktoren_sensoren_ansp_T RT_MODEL_aktoren_sensoren_ans_T;

#endif                                 /* RTW_HEADER_aktoren_sensoren_ansprechen_types_h_ */
