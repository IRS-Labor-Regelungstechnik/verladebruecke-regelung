/*
 * aktoren_sensoren_ansprechen.c
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

#include "aktoren_sensoren_ansprechen_trc_ptr.h"
#include "aktoren_sensoren_ansprechen.h"
#include "aktoren_sensoren_ansprechen_private.h"

/* Block signals (auto storage) */
B_aktoren_sensoren_ansprechen_T aktoren_sensoren_ansprechen_B;

/* Block states (auto storage) */
DW_aktoren_sensoren_anspreche_T aktoren_sensoren_ansprechen_DW;

/* Real-time model */
RT_MODEL_aktoren_sensoren_ans_T aktoren_sensoren_ansprechen_M_;
RT_MODEL_aktoren_sensoren_ans_T *const aktoren_sensoren_ansprechen_M =
  &aktoren_sensoren_ansprechen_M_;

/* Forward declaration for local functions */
static void aktor_Motorsteuerung2_resetImpl(Motorsteuerung2_aktoren_senso_T *obj);
static void aktor_Motorsteuerung2_resetImpl(Motorsteuerung2_aktoren_senso_T *obj)
{
  /* Start for MATLABSystem: '<S8>/MATLAB System' */
  /*  Initialize / reset discrete-state properties */
  obj->time1 = 0.0;
  obj->time2 = 0.0;
  obj->time_set1 = 0.0;
  obj->time_set2 = 0.0;
  obj->Schritt2 = 0.0;
  obj->Schritt3 = 0.0;
  obj->Schritt4 = 0.0;
  obj->Schritt5 = 0.0;
  obj->prop_n_Motor = 0.0;
  obj->prop_Abswertgeber_Set = 0.0;
  obj->schiene_zaehler = 0.0;
  obj->schiene_zaehler_set = 0.0;
  obj->schiene_zaehler_sleep = 0.0;
}

/* Model output function */
void aktoren_sensoren_ansprechen_output(void)
{
  real_T currentTime;
  real_T u1;
  real_T u2;
  Motorsteuerung2_aktoren_senso_T *obj;

  /* S-Function (rti_commonblock): '<S11>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* --- aktoren_sensoren_ansprechen/xStat --- */
  /* --- [RTI120X, ADC C1] - Channel: 3 --- */
  {
    UInt32 readStateFlag[] = { 1 };

    /* define variable required for adc cl1 realtime functions */
    UInt32 IsNew = 0;

    /* wait until conversion result is available */
    while (IsNew == 0) {
      AdcCl1AnalogIn_isDataReady(pRTIAdcC1AnalogIn_Ch_3, &IsNew);
    }

    /* read conversion result from hardware */
    AdcCl1AnalogIn_read(pRTIAdcC1AnalogIn_Ch_3);

    /* retrieve conversion result */
    AdcCl1AnalogIn_getSingleValue(pRTIAdcC1AnalogIn_Ch_3, readStateFlag, (real_T*)
      &aktoren_sensoren_ansprechen_B.SFunction1);
  }

  /* S-Function (rti_commonblock): '<S12>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* --- aktoren_sensoren_ansprechen/xUout --- */
  /* --- [RTI120X, ADC C1] - Channel: 1 --- */
  {
    UInt32 readStateFlag[] = { 1 };

    /* define variable required for adc cl1 realtime functions */
    UInt32 IsNew = 0;

    /* wait until conversion result is available */
    while (IsNew == 0) {
      AdcCl1AnalogIn_isDataReady(pRTIAdcC1AnalogIn_Ch_1, &IsNew);
    }

    /* read conversion result from hardware */
    AdcCl1AnalogIn_read(pRTIAdcC1AnalogIn_Ch_1);

    /* retrieve conversion result */
    AdcCl1AnalogIn_getSingleValue(pRTIAdcC1AnalogIn_Ch_1, readStateFlag, (real_T*)
      &aktoren_sensoren_ansprechen_B.SFunction1_a);
  }

  /* S-Function (rti_commonblock): '<S1>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* --- aktoren_sensoren_ansprechen/DAC_Hub_Ansteuerung --- */
  /* --- [RTI120X, DAC C1] - Channel: 2 --- */
  {
    /* define variables required for DAC realtime functions */
    Float64 inportDacData= 0.0;
    inportDacData = (real_T) aktoren_sensoren_ansprechen_P.Constant_Value;

    /* write value of CL1 DAC for output channel 2 */
    DacCl1AnalogOut_setOutputValue(pRTIDacC1AnalogOut_Ch_2, DAC_CLASS1_CHANNEL_2,
      inportDacData);
    DacCl1AnalogOut_write(pRTIDacC1AnalogOut_Ch_2);
  }

  /* Step: '<S8>/Schritt1_high' */
  currentTime = aktoren_sensoren_ansprechen_M->Timing.t[0];
  if (currentTime < aktoren_sensoren_ansprechen_P.Schritt1_high_Time) {
    aktoren_sensoren_ansprechen_B.Schritt1_high =
      aktoren_sensoren_ansprechen_P.Schritt1_high_Y0;
  } else {
    aktoren_sensoren_ansprechen_B.Schritt1_high =
      aktoren_sensoren_ansprechen_P.Schritt1_high_YFinal;
  }

  /* End of Step: '<S8>/Schritt1_high' */

  /* Step: '<S8>/Schritt1_low' */
  currentTime = aktoren_sensoren_ansprechen_M->Timing.t[0];
  if (currentTime < aktoren_sensoren_ansprechen_P.Schritt1_low_Time) {
    aktoren_sensoren_ansprechen_B.Schritt1_low =
      aktoren_sensoren_ansprechen_P.Schritt1_low_Y0;
  } else {
    aktoren_sensoren_ansprechen_B.Schritt1_low =
      aktoren_sensoren_ansprechen_P.Schritt1_low_YFinal;
  }

  /* End of Step: '<S8>/Schritt1_low' */

  /* Sum: '<S8>/Sum' */
  aktoren_sensoren_ansprechen_B.Sum =
    aktoren_sensoren_ansprechen_B.Schritt1_high +
    aktoren_sensoren_ansprechen_B.Schritt1_low;

  /* S-Function (rti_commonblock): '<S7>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* --- aktoren_sensoren_ansprechen/Schiene --- */
  /* --- [RTI120X, ADC C1] - Channel: 10 --- */
  {
    UInt32 readStateFlag[] = { 1 };

    /* define variable required for adc cl1 realtime functions */
    UInt32 IsNew = 0;

    /* wait until conversion result is available */
    while (IsNew == 0) {
      AdcCl1AnalogIn_isDataReady(pRTIAdcC1AnalogIn_Ch_10, &IsNew);
    }

    /* read conversion result from hardware */
    AdcCl1AnalogIn_read(pRTIAdcC1AnalogIn_Ch_10);

    /* retrieve conversion result */
    AdcCl1AnalogIn_getSingleValue(pRTIAdcC1AnalogIn_Ch_10, readStateFlag,
      (real_T*) &aktoren_sensoren_ansprechen_B.SFunction1_a1);
  }

  /* Clock: '<S8>/Clock' */
  aktoren_sensoren_ansprechen_B.Clock = aktoren_sensoren_ansprechen_M->Timing.t
    [0];

  /* MATLABSystem: '<S8>/MATLAB System' */
  currentTime = aktoren_sensoren_ansprechen_B.Sum;
  u1 = aktoren_sensoren_ansprechen_B.SFunction1_a1;
  u2 = aktoren_sensoren_ansprechen_B.Clock;

  /* Start for MATLABSystem: '<S8>/MATLAB System' incorporates:
   *  MATLABSystem: '<S8>/MATLAB System'
   */
  obj = &aktoren_sensoren_ansprechen_DW.obj;

  /*  Implement algorithm. Calculate y as a function of input u and */
  /*  discrete states. */
  if ((u1 > 0.35) && (obj->schiene_zaehler_set == 0.0) && (u2 -
       obj->schiene_zaehler_sleep > 1.0)) {
    obj->schiene_zaehler++;
    obj->schiene_zaehler_set = 1.0;
    obj->schiene_zaehler_sleep = u2;
  }

  if (u1 < 0.35) {
    obj->schiene_zaehler_set = 0.0;
  }

  if ((currentTime == 0.0) && (u2 > 37.0) && (obj->Schritt2 == 0.0)) {
    /*  starte Motor */
    obj->prop_n_Motor = -0.05;
    obj->Schritt2 = 1.0;

    /*  Einstellungen für Schritt 2 abgeschlossen */
  }

  /*  hier eventuell kritisch falls nicht sofort eine Veränderung */
  /*  des Resolverwinkels eintritt -> 6.5 -> halbe sekunde Zeit */
  if ((obj->schiene_zaehler == 2.0) && (u2 > 36.5) && (obj->Schritt2 == 1.0) &&
      (obj->Schritt3 == 0.0)) {
    /*  Ende erreicht */
    obj->prop_n_Motor = 0.0;

    /*  stoppe Motor */
    obj->prop_Abswertgeber_Set = 1.0;

    /*  setze Abswertgeber_Set auf 1 (siehe Schritt 3) */
    if (obj->time_set1 == 0.0) {
      obj->time_set1 = 1.0;
      obj->time1 = u2;
    }

    if (u2 - obj->time1 >= 2.0) {
      /*  geändert */
      obj->prop_Abswertgeber_Set = 0.0;

      /*  setze Setausgang nach 1s wieder auf 0 */
      obj->Schritt3 = 1.0;
    }
  }

  /*  In Schritt 3 erst 1s HIGH dann 3s warten -> 4s */
  if ((u2 - obj->time1 >= 6.0) && (obj->Schritt3 == 1.0) && (obj->Schritt4 ==
       0.0)) {
    /*  geändert */
    obj->prop_n_Motor = 0.05;
    obj->Schritt4 = 1.0;

    /*  Einstellungen für Schritt 4 abgeschlossen */
  }

  /*  4.5: mind. 0.5s nach Start der Motoren */
  if ((obj->schiene_zaehler == 4.0) && (u2 - obj->time1 >= 4.5) &&
      (obj->Schritt4 == 1.0) && (obj->Schritt5 == 0.0)) {
    obj->prop_n_Motor = 0.0;

    /*  stoppe Motor */
    obj->prop_Abswertgeber_Set = 1.0;
    if (obj->time_set2 == 0.0) {
      obj->time_set2 = 1.0;
      obj->time2 = u2;
    }

    if (u2 - obj->time2 >= 2.0) {
      /*  geändert */
      obj->prop_Abswertgeber_Set = 0.0;
      obj->Schritt5 = 1.0;

      /*  Schritt 5 abgeschlossen, Teaching abgeschlossen */
    }
  }

  currentTime = obj->prop_Abswertgeber_Set;
  u1 = obj->prop_n_Motor;

  /* End of Start for MATLABSystem: '<S8>/MATLAB System' */

  /* MATLABSystem: '<S8>/MATLAB System' */
  aktoren_sensoren_ansprechen_B.MATLABSystem_o1 = u1;
  aktoren_sensoren_ansprechen_B.MATLABSystem_o2 = currentTime;

  /* S-Function (rti_commonblock): '<S2>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* --- aktoren_sensoren_ansprechen/DAC_Weg_Ansteuerung --- */
  /* --- [RTI120X, DAC C1] - Channel: 1 --- */
  {
    /* define variables required for DAC realtime functions */
    Float64 inportDacData= 0.0;
    inportDacData = (real_T) aktoren_sensoren_ansprechen_B.MATLABSystem_o1;

    /* write value of CL1 DAC for output channel 1 */
    DacCl1AnalogOut_setOutputValue(pRTIDacC1AnalogOut_Ch_1, DAC_CLASS1_CHANNEL_1,
      inportDacData);
    DacCl1AnalogOut_write(pRTIDacC1AnalogOut_Ch_1);
  }

  /* Sum: '<S8>/Add' */
  aktoren_sensoren_ansprechen_B.Add = aktoren_sensoren_ansprechen_B.Sum +
    aktoren_sensoren_ansprechen_B.MATLABSystem_o2;

  /* Gain: '<Root>/Gain' */
  aktoren_sensoren_ansprechen_B.Gain = aktoren_sensoren_ansprechen_P.Gain_Gain *
    aktoren_sensoren_ansprechen_B.Add;

  /* S-Function (rti_commonblock): '<S3>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* --- aktoren_sensoren_ansprechen/DAC_xSet --- */
  /* --- [RTI120X, DAC C1] - Channel: 4 --- */
  {
    /* define variables required for DAC realtime functions */
    Float64 inportDacData= 0.0;
    inportDacData = (real_T) aktoren_sensoren_ansprechen_B.Gain;

    /* write value of CL1 DAC for output channel 4 */
    DacCl1AnalogOut_setOutputValue(pRTIDacC1AnalogOut_Ch_4, DAC_CLASS1_CHANNEL_4,
      inportDacData);
    DacCl1AnalogOut_write(pRTIDacC1AnalogOut_Ch_4);
  }

  /* S-Function (rti_commonblock): '<S5>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* S-Function (rti_commonblock): '<S6>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* S-Function (rti_commonblock): '<S9>/S-Function1' */
  /* This comment workarounds a code generation problem */

  /* S-Function (rti_commonblock): '<S10>/S-Function1' */
  /* This comment workarounds a code generation problem */
}

/* Model update function */
void aktoren_sensoren_ansprechen_update(void)
{
  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++aktoren_sensoren_ansprechen_M->Timing.clockTick0)) {
    ++aktoren_sensoren_ansprechen_M->Timing.clockTickH0;
  }

  aktoren_sensoren_ansprechen_M->Timing.t[0] =
    aktoren_sensoren_ansprechen_M->Timing.clockTick0 *
    aktoren_sensoren_ansprechen_M->Timing.stepSize0 +
    aktoren_sensoren_ansprechen_M->Timing.clockTickH0 *
    aktoren_sensoren_ansprechen_M->Timing.stepSize0 * 4294967296.0;

  {
    /* Update absolute timer for sample time: [0.001s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The resolution of this integer timer is 0.001, which is the step size
     * of the task. Size of "clockTick1" ensures timer will not overflow during the
     * application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    aktoren_sensoren_ansprechen_M->Timing.clockTick1++;
    if (!aktoren_sensoren_ansprechen_M->Timing.clockTick1) {
      aktoren_sensoren_ansprechen_M->Timing.clockTickH1++;
    }
  }
}

/* Model initialize function */
void aktoren_sensoren_ansprechen_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)aktoren_sensoren_ansprechen_M, 0,
                sizeof(RT_MODEL_aktoren_sensoren_ans_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&aktoren_sensoren_ansprechen_M->solverInfo,
                          &aktoren_sensoren_ansprechen_M->Timing.simTimeStep);
    rtsiSetTPtr(&aktoren_sensoren_ansprechen_M->solverInfo, &rtmGetTPtr
                (aktoren_sensoren_ansprechen_M));
    rtsiSetStepSizePtr(&aktoren_sensoren_ansprechen_M->solverInfo,
                       &aktoren_sensoren_ansprechen_M->Timing.stepSize0);
    rtsiSetErrorStatusPtr(&aktoren_sensoren_ansprechen_M->solverInfo,
                          (&rtmGetErrorStatus(aktoren_sensoren_ansprechen_M)));
    rtsiSetRTModelPtr(&aktoren_sensoren_ansprechen_M->solverInfo,
                      aktoren_sensoren_ansprechen_M);
  }

  rtsiSetSimTimeStep(&aktoren_sensoren_ansprechen_M->solverInfo, MAJOR_TIME_STEP);
  rtsiSetSolverName(&aktoren_sensoren_ansprechen_M->solverInfo,
                    "FixedStepDiscrete");
  rtmSetTPtr(aktoren_sensoren_ansprechen_M,
             &aktoren_sensoren_ansprechen_M->Timing.tArray[0]);
  aktoren_sensoren_ansprechen_M->Timing.stepSize0 = 0.001;

  /* block I/O */
  (void) memset(((void *) &aktoren_sensoren_ansprechen_B), 0,
                sizeof(B_aktoren_sensoren_ansprechen_T));

  /* states (dwork) */
  (void) memset((void *)&aktoren_sensoren_ansprechen_DW, 0,
                sizeof(DW_aktoren_sensoren_anspreche_T));

  {
    /* user code (registration function declaration) */
    /*Initialize global TRC pointers. */
    aktoren_sensoren_ansprechen_rti_init_trc_pointers();
  }

  {
    Motorsteuerung2_aktoren_senso_T *obj;

    /* Start for MATLABSystem: '<S8>/MATLAB System' */
    obj = &aktoren_sensoren_ansprechen_DW.obj;
    obj->isInitialized = 0;
    aktoren_sensoren_ansprechen_DW.objisempty = true;
    obj = &aktoren_sensoren_ansprechen_DW.obj;
    obj->isInitialized = 1;

    /*  Motorsteuerung2 Skript zum automatisierten Teaching der Absolutwertdrehgeber */
    /*  */
    /*  Laufkatze bzw. Greifer muss sich zum Start ungefähr in der Mitte befinden */
    /*  Public, tunable properties */
    /*  Pre-computed constants */
    /*  Perform one-time calculations, such as computing constants */
    obj->time1 = 0.0;
    obj->time2 = 0.0;
    obj->time_set1 = 0.0;
    obj->time_set2 = 0.0;
    obj->Schritt2 = 0.0;
    obj->Schritt3 = 0.0;
    obj->Schritt4 = 0.0;
    obj->Schritt5 = 0.0;
    obj->prop_n_Motor = 0.0;
    obj->prop_Abswertgeber_Set = 0.0;
    obj->schiene_zaehler = 0.0;
    obj->schiene_zaehler_set = 0.0;
    obj->schiene_zaehler_sleep = 0.0;
  }

  {
    boolean_T flag;
    Motorsteuerung2_aktoren_senso_T *obj;

    /* Start for MATLABSystem: '<S8>/MATLAB System' incorporates:
     *  InitializeConditions for MATLABSystem: '<S8>/MATLAB System'
     */
    obj = &aktoren_sensoren_ansprechen_DW.obj;
    flag = (obj->isInitialized == 1);
    if (flag) {
      obj = &aktoren_sensoren_ansprechen_DW.obj;
      if (obj->isInitialized == 1) {
        aktor_Motorsteuerung2_resetImpl(obj);
      }
    }

    /* End of Start for MATLABSystem: '<S8>/MATLAB System' */
  }
}

/* Model terminate function */
void aktoren_sensoren_ansprechen_terminate(void)
{
  boolean_T flag;
  Motorsteuerung2_aktoren_senso_T *obj;

  /* Terminate for S-Function (rti_commonblock): '<S1>/S-Function1' */

  /* --- aktoren_sensoren_ansprechen/DAC_Hub_Ansteuerung --- */
  /* --- [RTI120X, DAC C1] - Channel: 2 --- */

  /* All channel outputs are set to high impedance state */
  DacCl1AnalogOut_setOutputHighZ(pRTIDacC1AnalogOut_Ch_2, DAC_CLASS1_HIGH_Z_ON);

  /* Deactivates AnalogOut functionality */
  DacCl1AnalogOut_stop(pRTIDacC1AnalogOut_Ch_2);

  /* Start for MATLABSystem: '<S8>/MATLAB System' incorporates:
   *  Terminate for MATLABSystem: '<S8>/MATLAB System'
   */
  obj = &aktoren_sensoren_ansprechen_DW.obj;
  flag = (obj->isInitialized == 1);
  if (flag) {
    obj = &aktoren_sensoren_ansprechen_DW.obj;
    if (obj->isInitialized == 1) {
      obj->isInitialized = 2;
    }
  }

  /* End of Start for MATLABSystem: '<S8>/MATLAB System' */
  /* Terminate for S-Function (rti_commonblock): '<S2>/S-Function1' */

  /* --- aktoren_sensoren_ansprechen/DAC_Weg_Ansteuerung --- */
  /* --- [RTI120X, DAC C1] - Channel: 1 --- */

  /* All channel outputs are set to high impedance state */
  DacCl1AnalogOut_setOutputHighZ(pRTIDacC1AnalogOut_Ch_1, DAC_CLASS1_HIGH_Z_ON);

  /* Deactivates AnalogOut functionality */
  DacCl1AnalogOut_stop(pRTIDacC1AnalogOut_Ch_1);

  /* Terminate for S-Function (rti_commonblock): '<S3>/S-Function1' */

  /* --- aktoren_sensoren_ansprechen/DAC_xSet --- */
  /* --- [RTI120X, DAC C1] - Channel: 4 --- */

  /* All channel outputs are set to high impedance state */
  DacCl1AnalogOut_setOutputHighZ(pRTIDacC1AnalogOut_Ch_4, DAC_CLASS1_HIGH_Z_ON);

  /* Deactivates AnalogOut functionality */
  DacCl1AnalogOut_stop(pRTIDacC1AnalogOut_Ch_4);

  /* Terminate for S-Function (rti_commonblock): '<S5>/S-Function1' */

  /* --- aktoren_sensoren_ansprechen/Resolver_HUB --- */
  /* --- [RTIEMC, Resolver] - Unit: 2 --- */
  {
    /* Deactivates resolver interface functionality */
    ResolverIn_stop(pRTIEmcResolver_Unit_2);
  }

  /* Terminate for S-Function (rti_commonblock): '<S6>/S-Function1' */

  /* --- aktoren_sensoren_ansprechen/Resolver_WEG --- */
  /* --- [RTIEMC, Resolver] - Unit: 1 --- */
  {
    /* Deactivates resolver interface functionality */
    ResolverIn_stop(pRTIEmcResolver_Unit_1);
  }

  /* Terminate for S-Function (rti_commonblock): '<S9>/S-Function1' */

  /* --- aktoren_sensoren_ansprechen/Winkel --- */
  /* --- [RTIEMC, Encoder] - DIO class: 2 - Unit: 1 - Port: 1 - Channel: 1 --- */
  {
    /* Deactivates encoder interface functionality */
    DioCl2EncoderIn_stop(pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1);
  }
}
