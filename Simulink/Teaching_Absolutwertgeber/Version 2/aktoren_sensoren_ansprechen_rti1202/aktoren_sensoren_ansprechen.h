/*
 * aktoren_sensoren_ansprechen.h
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

#ifndef RTW_HEADER_aktoren_sensoren_ansprechen_h_
#define RTW_HEADER_aktoren_sensoren_ansprechen_h_
#include <string.h>
#ifndef aktoren_sensoren_ansprechen_COMMON_INCLUDES_
# define aktoren_sensoren_ansprechen_COMMON_INCLUDES_
#include <brtenv.h>
#include <rtkernel.h>
#include <rti_assert.h>
#include <rtidefineddatatypes.h>
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#endif                                 /* aktoren_sensoren_ansprechen_COMMON_INCLUDES_ */

#include "aktoren_sensoren_ansprechen_types.h"

/* Shared type includes */
#include "multiword_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  (rtmGetTPtr((rtm))[0])
#endif

/* Block signals (auto storage) */
typedef struct {
  real_T SFunction1;                   /* '<S11>/S-Function1' */
  real_T SFunction1_a;                 /* '<S12>/S-Function1' */
  real_T Schritt1_high;                /* '<S8>/Schritt1_high' */
  real_T Schritt1_low;                 /* '<S8>/Schritt1_low' */
  real_T Sum;                          /* '<S8>/Sum' */
  real_T SFunction1_a1;                /* '<S7>/S-Function1' */
  real_T Clock;                        /* '<S8>/Clock' */
  real_T Add;                          /* '<S8>/Add' */
  real_T Gain;                         /* '<Root>/Gain' */
  real_T SFunction1_o1;                /* '<S5>/S-Function1' */
  real_T SFunction1_o1_m;              /* '<S6>/S-Function1' */
  real_T SFunction1_o1_i;              /* '<S9>/S-Function1' */
  real_T SFunction1_o2;                /* '<S9>/S-Function1' */
  real_T MATLABSystem_o1;              /* '<S8>/MATLAB System' */
  real_T MATLABSystem_o2;              /* '<S8>/MATLAB System' */
  boolean_T SFunction1_o2_p;           /* '<S5>/S-Function1' */
  boolean_T SFunction1_o2_j;           /* '<S6>/S-Function1' */
} B_aktoren_sensoren_ansprechen_T;

/* Block states (auto storage) for system '<Root>' */
typedef struct {
  Motorsteuerung2_aktoren_senso_T obj; /* '<S8>/MATLAB System' */
  struct {
    void *LoggedData;
  } ADC_xStat_PWORK;                   /* '<Root>/ADC_xStat' */

  struct {
    void *LoggedData;
  } ADC_xUout_PWORK;                   /* '<Root>/ADC_xUout' */

  struct {
    void *LoggedData;
  } Scope_Abswertgeber_Set_PWORK;      /* '<Root>/Scope_Abswertgeber_Set' */

  struct {
    void *LoggedData;
  } Scope_n_Motor_PWORK;               /* '<Root>/Scope_n_Motor' */

  struct {
    void *LoggedData;
  } Weg_Rotor_Winkel_PWORK;            /* '<Root>/Weg_Rotor_Winkel' */

  struct {
    void *LoggedData;
  } Scope_diff_resolver_PWORK;         /* '<S8>/Scope_diff_resolver' */

  struct {
    void *LoggedData;
  } Weg_Data_Valid_PWORK;              /* '<Root>/Weg_Data_Valid' */

  struct {
    void *LoggedData;
  } Winkel_Position_PWORK;             /* '<Root>/Winkel_Position' */

  struct {
    void *LoggedData;
  } Winkel_Speed_PWORK;                /* '<Root>/Winkel_Speed' */

  void *MATLABSystem_PWORK;            /* '<S8>/MATLAB System' */
  boolean_T objisempty;                /* '<S8>/MATLAB System' */
} DW_aktoren_sensoren_anspreche_T;

/* Parameters (auto storage) */
struct P_aktoren_sensoren_ansprechen_T_ {
  real_T Constant_Value;               /* Expression: 0
                                        * Referenced by: '<Root>/Constant'
                                        */
  real_T Schritt1_high_Time;           /* Expression: 30
                                        * Referenced by: '<S8>/Schritt1_high'
                                        */
  real_T Schritt1_high_Y0;             /* Expression: 0
                                        * Referenced by: '<S8>/Schritt1_high'
                                        */
  real_T Schritt1_high_YFinal;         /* Expression: 1
                                        * Referenced by: '<S8>/Schritt1_high'
                                        */
  real_T Schritt1_low_Time;            /* Expression: 47
                                        * Referenced by: '<S8>/Schritt1_low'
                                        */
  real_T Schritt1_low_Y0;              /* Expression: 0
                                        * Referenced by: '<S8>/Schritt1_low'
                                        */
  real_T Schritt1_low_YFinal;          /* Expression: -1
                                        * Referenced by: '<S8>/Schritt1_low'
                                        */
  real_T Gain_Gain;                    /* Expression: 1
                                        * Referenced by: '<Root>/Gain'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_aktoren_sensoren_ansp_T {
  const char_T *errorStatus;
  RTWSolverInfo solverInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    uint32_T clockTick1;
    uint32_T clockTickH1;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *t;
    time_T tArray[2];
  } Timing;
};

/* Block parameters (auto storage) */
extern P_aktoren_sensoren_ansprechen_T aktoren_sensoren_ansprechen_P;

/* Block signals (auto storage) */
extern B_aktoren_sensoren_ansprechen_T aktoren_sensoren_ansprechen_B;

/* Block states (auto storage) */
extern DW_aktoren_sensoren_anspreche_T aktoren_sensoren_ansprechen_DW;

/* Model entry point functions */
extern void aktoren_sensoren_ansprechen_initialize(void);
extern void aktoren_sensoren_ansprechen_output(void);
extern void aktoren_sensoren_ansprechen_update(void);
extern void aktoren_sensoren_ansprechen_terminate(void);

/* Real-time Model object */
extern RT_MODEL_aktoren_sensoren_ans_T *const aktoren_sensoren_ansprechen_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'aktoren_sensoren_ansprechen'
 * '<S1>'   : 'aktoren_sensoren_ansprechen/DAC_Hub_Ansteuerung'
 * '<S2>'   : 'aktoren_sensoren_ansprechen/DAC_Weg_Ansteuerung'
 * '<S3>'   : 'aktoren_sensoren_ansprechen/DAC_xSet'
 * '<S4>'   : 'aktoren_sensoren_ansprechen/RTI Data'
 * '<S5>'   : 'aktoren_sensoren_ansprechen/Resolver_HUB'
 * '<S6>'   : 'aktoren_sensoren_ansprechen/Resolver_WEG'
 * '<S7>'   : 'aktoren_sensoren_ansprechen/Schiene'
 * '<S8>'   : 'aktoren_sensoren_ansprechen/Subsystem'
 * '<S9>'   : 'aktoren_sensoren_ansprechen/Winkel'
 * '<S10>'  : 'aktoren_sensoren_ansprechen/Winkelsensor_Supply'
 * '<S11>'  : 'aktoren_sensoren_ansprechen/xStat'
 * '<S12>'  : 'aktoren_sensoren_ansprechen/xUout'
 * '<S13>'  : 'aktoren_sensoren_ansprechen/RTI Data/RTI Data Store'
 * '<S14>'  : 'aktoren_sensoren_ansprechen/RTI Data/RTI Data Store/RTI Data Store'
 * '<S15>'  : 'aktoren_sensoren_ansprechen/RTI Data/RTI Data Store/RTI Data Store/RTI Data Store'
 */
#endif                                 /* RTW_HEADER_aktoren_sensoren_ansprechen_h_ */
