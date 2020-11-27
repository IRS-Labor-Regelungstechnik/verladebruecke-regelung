/*
 * aktoren_sensoren_ansprechen_private.h
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

#ifndef RTW_HEADER_aktoren_sensoren_ansprechen_private_h_
#define RTW_HEADER_aktoren_sensoren_ansprechen_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"

/* Private macros used by the generated code to access rtModel */
#ifndef rtmIsMajorTimeStep
# define rtmIsMajorTimeStep(rtm)       (((rtm)->Timing.simTimeStep) == MAJOR_TIME_STEP)
#endif

#ifndef rtmIsMinorTimeStep
# define rtmIsMinorTimeStep(rtm)       (((rtm)->Timing.simTimeStep) == MINOR_TIME_STEP)
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               ((rtm)->Timing.t)
#endif

#ifndef rtmSetTPtr
# define rtmSetTPtr(rtm, val)          ((rtm)->Timing.t = (val))
#endif

extern AdcCl1AnalogInSDrvObject *pRTIAdcC1AnalogIn_Ch_3;
extern AdcCl1AnalogInSDrvObject *pRTIAdcC1AnalogIn_Ch_1;
extern DacCl1AnalogOutSDrvObject *pRTIDacC1AnalogOut_Ch_2;
extern AdcCl1AnalogInSDrvObject *pRTIAdcC1AnalogIn_Ch_10;
extern DacCl1AnalogOutSDrvObject *pRTIDacC1AnalogOut_Ch_1;
extern DacCl1AnalogOutSDrvObject *pRTIDacC1AnalogOut_Ch_4;
extern ResolverInSDrvObject *pRTIEmcResolver_Unit_2;
extern ResolverInSDrvObject *pRTIEmcResolver_Unit_1;
extern DioCl2EncoderInSDrvObject *pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1;
extern SensorSupplySDrvObject *pRTI_Sensor_Supply;

#endif                                 /* RTW_HEADER_aktoren_sensoren_ansprechen_private_h_ */
