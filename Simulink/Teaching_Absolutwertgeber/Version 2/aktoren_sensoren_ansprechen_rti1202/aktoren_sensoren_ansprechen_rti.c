/*********************** dSPACE target specific file *************************

   Include file aktoren_sensoren_ansprechen_rti.c:

   Definition of functions and variables for the system I/O and for
   the hardware and software interrupts used.

   RTI1202 7.7 (02-Nov-2016)
   Fri Nov 27 12:55:48 2020

   Copyright 2020, dSPACE GmbH. All rights reserved.

 *****************************************************************************/

#if !(defined(__RTI_SIMENGINE__) || defined(RTIMP_FRAME))
# error This file may be included only by the RTI(-MP) simulation engine.
#endif

/* Include the model header file. */
#include "aktoren_sensoren_ansprechen.h"
#include "aktoren_sensoren_ansprechen_private.h"

/* Defines for block output and parameter structure existence */
#define RTI_rtB_STRUCTURE_EXISTS       1
#define RTI_rtP_STRUCTURE_EXISTS       1
#define RTB_STRUCTURE_NAME             aktoren_sensoren_ansprechen_B
#define RTP_STRUCTURE_NAME             aktoren_sensoren_ansprechen_P

/* dSPACE generated includes for header files */
#include <brtenv.h>
#include <rtkernel.h>
#include <rti_assert.h>
#include <rtidefineddatatypes.h>
#ifndef dsRtmGetNumSampleTimes
# define dsRtmGetNumSampleTimes(rtm)   2
#endif

#ifndef dsRtmGetTPtr
# define dsRtmGetTPtr(rtm)             ((rtm)->Timing.t)
#endif

#ifndef dsRtmSetTaskTime
# define dsRtmSetTaskTime(rtm, sti, val) (dsRtmGetTPtr((rtm))[sti] = (val))
#endif

/****** Definitions: task functions for timer tasks *********************/

/* Timer Task 1. (Base rate). */
static void rti_TIMERA(rtk_p_task_control_block task)
{
  /* Task entry code BEGIN */
  /* -- None. -- */
  /* Task entry code END */

  /* Task code. */
  baseRateService(task);

  /* Task exit code BEGIN */
  /* -- None. -- */
  /* Task exit code END */
}

/* ===== Declarations of RTI blocks ======================================== */
AdcCl1AnalogInSDrvObject *pRTIAdcC1AnalogIn_Ch_3;
AdcCl1AnalogInSDrvObject *pRTIAdcC1AnalogIn_Ch_1;
DacCl1AnalogOutSDrvObject *pRTIDacC1AnalogOut_Ch_2;
AdcCl1AnalogInSDrvObject *pRTIAdcC1AnalogIn_Ch_10;
DacCl1AnalogOutSDrvObject *pRTIDacC1AnalogOut_Ch_1;
DacCl1AnalogOutSDrvObject *pRTIDacC1AnalogOut_Ch_4;
ResolverInSDrvObject *pRTIEmcResolver_Unit_2;
ResolverInSDrvObject *pRTIEmcResolver_Unit_1;
DioCl2EncoderInSDrvObject *pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1;
SensorSupplySDrvObject *pRTI_Sensor_Supply;

/* ===== Definition of interface functions for simulation engine =========== */
#if GRTINTERFACE == 1
#ifdef MULTITASKING
# define dsIsSampleHit(RTM,sti)        rtmGetSampleHitPtr(RTM)[sti]
#else
# define dsIsSampleHit(RTM,sti)        rtmIsSampleHit(RTM,sti,0)
#endif

#else
#ifndef rtmStepTask
# define rtmStepTask(rtm, idx)         ((rtm)->Timing.TaskCounters.TID[(idx)] == 0)
#endif

# define dsIsSampleHit(RTM,sti)        rtmStepTask(RTM, sti)
#endif

#undef __INLINE
#if defined(_INLINE)
# define __INLINE                      static inline
#else
# define __INLINE                      static
#endif

/*Define additional variables*/
static time_T dsTFinal = -1.0;

#define dsGetTFinal(rtm)               (dsTFinal)

static time_T dsStepSize = 0.001;

# define dsGetStepSize(rtm)            (dsStepSize)

static void rti_mdl_initialize_host_services(void)
{
  DsDaq_Init(0, 32, 1);
}

static void rti_mdl_initialize_io_boards(void)
{
  /* Registering of RTI products and modules at VCM */
  {
    vcm_module_register(VCM_MID_RTI1202, (void *) 0,
                        VCM_TXT_RTI1202, 7, 7, 0,
                        VCM_VERSION_RELEASE, 0, 0, 0, VCM_CTRL_NO_ST);

    {
      vcm_module_descriptor_type* msg_mod_ptr;
      msg_mod_ptr = vcm_module_register(VCM_MID_MATLAB, (void *) 0,
        VCM_TXT_MATLAB, 9, 1, 0,
        VCM_VERSION_RELEASE, 0, 0, 0, VCM_CTRL_NO_ST);
      vcm_module_register(VCM_MID_SIMULINK, msg_mod_ptr,
                          VCM_TXT_SIMULINK, 8, 8, 0,
                          VCM_VERSION_RELEASE, 0, 0, 0, VCM_CTRL_NO_ST);
      vcm_module_register(VCM_MID_RTW, msg_mod_ptr,
                          VCM_TXT_RTW, 8, 11, 0,
                          VCM_VERSION_RELEASE, 0, 0, 0, VCM_CTRL_NO_ST);
    }
  }

  /* dSPACE I/O Board DS120XSTDADCC1 #0 */
  /* --- aktoren_sensoren_ansprechen/xStat --- */
  /* --- [RTI120X, ADC C1] - Channel: 3 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Init ADC CL1 AnalogIn driver object pRTIAdcC1AnalogIn_Ch_3 */
    ioErrorCode = AdcCl1AnalogIn_create(&pRTIAdcC1AnalogIn_Ch_3,
      ADC_CLASS1_CHANNEL_3);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Set parameters for ADC CL1 AnalogIn driver object pRTIAdcC1AnalogIn_Ch_3 */
    ioErrorCode = AdcCl1AnalogIn_setConversionMode(pRTIAdcC1AnalogIn_Ch_3,
      ADC_CLASS1_SINGLE_CONV_MODE);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = AdcCl1AnalogIn_setConversTrigger(pRTIAdcC1AnalogIn_Ch_3,
      ADC_CLASS1_TRIGGER_SW);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/xUout --- */
  /* --- [RTI120X, ADC C1] - Channel: 1 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Init ADC CL1 AnalogIn driver object pRTIAdcC1AnalogIn_Ch_1 */
    ioErrorCode = AdcCl1AnalogIn_create(&pRTIAdcC1AnalogIn_Ch_1,
      ADC_CLASS1_CHANNEL_1);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Set parameters for ADC CL1 AnalogIn driver object pRTIAdcC1AnalogIn_Ch_1 */
    ioErrorCode = AdcCl1AnalogIn_setConversionMode(pRTIAdcC1AnalogIn_Ch_1,
      ADC_CLASS1_SINGLE_CONV_MODE);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = AdcCl1AnalogIn_setConversTrigger(pRTIAdcC1AnalogIn_Ch_1,
      ADC_CLASS1_TRIGGER_SW);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/Schiene --- */
  /* --- [RTI120X, ADC C1] - Channel: 10 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Init ADC CL1 AnalogIn driver object pRTIAdcC1AnalogIn_Ch_10 */
    ioErrorCode = AdcCl1AnalogIn_create(&pRTIAdcC1AnalogIn_Ch_10,
      ADC_CLASS1_CHANNEL_10);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Set parameters for ADC CL1 AnalogIn driver object pRTIAdcC1AnalogIn_Ch_10 */
    ioErrorCode = AdcCl1AnalogIn_setConversionMode(pRTIAdcC1AnalogIn_Ch_10,
      ADC_CLASS1_SINGLE_CONV_MODE);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = AdcCl1AnalogIn_setConversTrigger(pRTIAdcC1AnalogIn_Ch_10,
      ADC_CLASS1_TRIGGER_SW);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* dSPACE I/O Board DS120XSTDADCC1 #0 Unit:ADCC1 */

  /* dSPACE I/O Board DS120XSTDADCC1 #0 Unit:ADCC1 Group:ADC */
  /* --- aktoren_sensoren_ansprechen/xStat --- */
  /* --- [RTI120X, ADC C1] - Channel: 3 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Apply- and Start-Fcn for pRTIAdcC1AnalogIn_Ch_3 */
    ioErrorCode = AdcCl1AnalogIn_apply(pRTIAdcC1AnalogIn_Ch_3);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = AdcCl1AnalogIn_start(pRTIAdcC1AnalogIn_Ch_3);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/xUout --- */
  /* --- [RTI120X, ADC C1] - Channel: 1 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Apply- and Start-Fcn for pRTIAdcC1AnalogIn_Ch_1 */
    ioErrorCode = AdcCl1AnalogIn_apply(pRTIAdcC1AnalogIn_Ch_1);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = AdcCl1AnalogIn_start(pRTIAdcC1AnalogIn_Ch_1);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/Schiene --- */
  /* --- [RTI120X, ADC C1] - Channel: 10 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Apply- and Start-Fcn for pRTIAdcC1AnalogIn_Ch_10 */
    ioErrorCode = AdcCl1AnalogIn_apply(pRTIAdcC1AnalogIn_Ch_10);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = AdcCl1AnalogIn_start(pRTIAdcC1AnalogIn_Ch_10);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/DAC_Hub_Ansteuerung --- */
  /* --- [RTI120X, DAC C1] - Channel: 2 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Init DAC CL1 AnalogOut driver object pRTIDacC1AnalogOut_Ch_2 */
    ioErrorCode = DacCl1AnalogOut_create(&pRTIDacC1AnalogOut_Ch_2,
      DAC_CLASS1_MASK_CH_2);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Apply all parameter settings. Finalize the construction of the AnalogOut driver object */
    ioErrorCode = DacCl1AnalogOut_apply(pRTIDacC1AnalogOut_Ch_2);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/DAC_Weg_Ansteuerung --- */
  /* --- [RTI120X, DAC C1] - Channel: 1 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Init DAC CL1 AnalogOut driver object pRTIDacC1AnalogOut_Ch_1 */
    ioErrorCode = DacCl1AnalogOut_create(&pRTIDacC1AnalogOut_Ch_1,
      DAC_CLASS1_MASK_CH_1);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Apply all parameter settings. Finalize the construction of the AnalogOut driver object */
    ioErrorCode = DacCl1AnalogOut_apply(pRTIDacC1AnalogOut_Ch_1);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/DAC_xSet --- */
  /* --- [RTI120X, DAC C1] - Channel: 4 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Init DAC CL1 AnalogOut driver object pRTIDacC1AnalogOut_Ch_4 */
    ioErrorCode = DacCl1AnalogOut_create(&pRTIDacC1AnalogOut_Ch_4,
      DAC_CLASS1_MASK_CH_4);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Apply all parameter settings. Finalize the construction of the AnalogOut driver object */
    ioErrorCode = DacCl1AnalogOut_apply(pRTIDacC1AnalogOut_Ch_4);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/Resolver_HUB --- */
  /* --- [RTIEMC, Resolver] - Unit: 2 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorRetValue = IOLIB_NO_ERROR;

    /* Create EMC Resolver driver object pRTIEmcResolver_Unit_2 */
    ioErrorRetValue = ResolverIn_create(&pRTIEmcResolver_Unit_2, 2);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets frequency used for generating excitation output signal of resolver interface */
    ioErrorRetValue = ResolverIn_setExcitationFreq(pRTIEmcResolver_Unit_2,
      (Float64) 7000);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets voltage level used for generating excitation output signal of resolver interface */
    ioErrorRetValue = ResolverIn_setExcitationVoltRms(pRTIEmcResolver_Unit_2,
      RESOLVER_EXCITATION_7_0_V_RMS);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets voltage level used for sine / cosine signal inputs of resolver interface */
    ioErrorRetValue = ResolverIn_setSineCosineVoltRms(pRTIEmcResolver_Unit_2,
      RESOLVER_SINE_COSINE_1_5_V_RMS);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets maximum rotational speed to be measured by the resolver interface */
    ioErrorRetValue = ResolverIn_setMaximumSpeed(pRTIEmcResolver_Unit_2,
      RESOLVER_MAX_SPEED_7500_RPM);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Configures if the rotational direction is to be reversed in the resolver interface */
    ioErrorRetValue = ResolverIn_setReverseDirection(pRTIEmcResolver_Unit_2,
      RESOLVER_REVERSE_INACTIVE);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Set position offset added to resolver result to get shifted position */
    ioErrorRetValue = ResolverIn_setPositionOffset(pRTIEmcResolver_Unit_2,
      (Float64) 0);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Apply all parameter settings. Finalize the construction of the resolver Obj driver object */
    ioErrorRetValue = ResolverIn_apply(pRTIEmcResolver_Unit_2);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/Resolver_WEG --- */
  /* --- [RTIEMC, Resolver] - Unit: 1 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorRetValue = IOLIB_NO_ERROR;

    /* Create EMC Resolver driver object pRTIEmcResolver_Unit_1 */
    ioErrorRetValue = ResolverIn_create(&pRTIEmcResolver_Unit_1, 1);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets frequency used for generating excitation output signal of resolver interface */
    ioErrorRetValue = ResolverIn_setExcitationFreq(pRTIEmcResolver_Unit_1,
      (Float64) 7000);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets voltage level used for generating excitation output signal of resolver interface */
    ioErrorRetValue = ResolverIn_setExcitationVoltRms(pRTIEmcResolver_Unit_1,
      RESOLVER_EXCITATION_7_0_V_RMS);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets voltage level used for sine / cosine signal inputs of resolver interface */
    ioErrorRetValue = ResolverIn_setSineCosineVoltRms(pRTIEmcResolver_Unit_1,
      RESOLVER_SINE_COSINE_1_5_V_RMS);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets maximum rotational speed to be measured by the resolver interface */
    ioErrorRetValue = ResolverIn_setMaximumSpeed(pRTIEmcResolver_Unit_1,
      RESOLVER_MAX_SPEED_7500_RPM);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Configures if the rotational direction is to be reversed in the resolver interface */
    ioErrorRetValue = ResolverIn_setReverseDirection(pRTIEmcResolver_Unit_1,
      RESOLVER_REVERSE_INACTIVE);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Set position offset added to resolver result to get shifted position */
    ioErrorRetValue = ResolverIn_setPositionOffset(pRTIEmcResolver_Unit_1,
      (Float64) 0);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Apply all parameter settings. Finalize the construction of the resolver Obj driver object */
    ioErrorRetValue = ResolverIn_apply(pRTIEmcResolver_Unit_1);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/Winkel --- */
  /* --- [RTIEMC, Encoder] - DIO class: 2 - Unit: 1 - Port: 1 - Channel: 1 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorRetValue = IOLIB_NO_ERROR;

    /* Create EMC Encoder driver object pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1 */
    ioErrorRetValue = DioCl2EncoderIn_create
      (&pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1, DIO_CLASS2_CHANNEL_1,
       DIO_ENC_INSTANCE_1,DIO_ENC_IUSAGE_DISABLED);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* -- Angle measurement enabled -- */

    /* Sets number of encoder lines for the selected incremental Encoder */
    ioErrorRetValue = DioCl2EncoderIn_setEncoderLines
      (pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1, (UInt32) 1024U);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets minimum position for the selected incremental Encoder (in lines) */
    ioErrorRetValue = DioCl2EncoderIn_setMinPosition
      (pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1, (Float64) 0.0);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets maximum position for the selected incremental Encoder (in lines) */
    ioErrorRetValue = DioCl2EncoderIn_setMaxPosition
      (pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1, (Float64) 1023.75);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets index signal usage mode for the selected incremental Encoder */
    ioErrorRetValue = DioCl2EncoderIn_setIndexMode
      (pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1, (Float64)
       DIO_ENC_IMODE_DISABLED);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Sets gated mode for the selected incremental Encoder */
    ioErrorRetValue = DioCl2EncoderIn_setGatedMode
      (pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1, DIO_ENC_GMODE_DISABLED);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorRetValue = DioCl2EncoderIn_setMeasurementInterval
      (pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1, 1);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Apply all parameter settings. Finalize the construction of the Encoder Obj driver object */
    ioErrorRetValue = DioCl2EncoderIn_apply
      (pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/Winkelsensor_Supply --- */
  /* --- [RTI120X, Sensor Supply] --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* Init Sensor Supply driver object pRTI_Sensor_Supply */
    ioErrorCode = SensorSupply_create(&pRTI_Sensor_Supply, SENSOR_SUPPLY_NO_2);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = SensorSupply_setVoltage(pRTI_Sensor_Supply, 5);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = SensorSupply_setSensorState(pRTI_Sensor_Supply,
      SENSOR_STATE_ENABLE);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = SensorSupply_apply(pRTI_Sensor_Supply);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    ioErrorCode = SensorSupply_start(pRTI_Sensor_Supply);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }
}

/* Function rti_mdl_slave_load() is empty */
#define rti_mdl_slave_load()

/* Function rti_mdl_rtk_initialize() is empty */
#define rti_mdl_rtk_initialize()

static void rti_mdl_initialize_io_units(void)
{
  /* --- aktoren_sensoren_ansprechen/DAC_Hub_Ansteuerung --- */
  /* --- [RTI120X, DAC C1] - Channel: 2 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* All channel outputs are released from high impedance state */
    DacCl1AnalogOut_setOutputHighZ(pRTIDacC1AnalogOut_Ch_2,
      DAC_CLASS1_HIGH_Z_OFF);

    /* write initial value of CL1 DAC for output channel 2 */
    ioErrorCode = DacCl1AnalogOut_setOutputValue(pRTIDacC1AnalogOut_Ch_2,
      DAC_CLASS1_CHANNEL_2, (Float64) 0.0);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Activates AnalogOut functionality */
    ioErrorCode = DacCl1AnalogOut_start(pRTIDacC1AnalogOut_Ch_2);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/DAC_Weg_Ansteuerung --- */
  /* --- [RTI120X, DAC C1] - Channel: 1 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* All channel outputs are released from high impedance state */
    DacCl1AnalogOut_setOutputHighZ(pRTIDacC1AnalogOut_Ch_1,
      DAC_CLASS1_HIGH_Z_OFF);

    /* write initial value of CL1 DAC for output channel 1 */
    ioErrorCode = DacCl1AnalogOut_setOutputValue(pRTIDacC1AnalogOut_Ch_1,
      DAC_CLASS1_CHANNEL_1, (Float64) 0.0);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Activates AnalogOut functionality */
    ioErrorCode = DacCl1AnalogOut_start(pRTIDacC1AnalogOut_Ch_1);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/DAC_xSet --- */
  /* --- [RTI120X, DAC C1] - Channel: 4 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorCode = IOLIB_NO_ERROR;

    /* All channel outputs are released from high impedance state */
    DacCl1AnalogOut_setOutputHighZ(pRTIDacC1AnalogOut_Ch_4,
      DAC_CLASS1_HIGH_Z_OFF);

    /* write initial value of CL1 DAC for output channel 4 */
    ioErrorCode = DacCl1AnalogOut_setOutputValue(pRTIDacC1AnalogOut_Ch_4,
      DAC_CLASS1_CHANNEL_4, (Float64) 0.0);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Activates AnalogOut functionality */
    ioErrorCode = DacCl1AnalogOut_start(pRTIDacC1AnalogOut_Ch_4);
    if (ioErrorCode > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/Resolver_HUB --- */
  /* --- [RTIEMC, Resolver] - Unit: 2 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorRetValue = IOLIB_NO_ERROR;

    /* Activate resolver interface functionality */
    ioErrorRetValue = ResolverIn_start(pRTIEmcResolver_Unit_2);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/Resolver_WEG --- */
  /* --- [RTIEMC, Resolver] - Unit: 1 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorRetValue = IOLIB_NO_ERROR;

    /* Activate resolver interface functionality */
    ioErrorRetValue = ResolverIn_start(pRTIEmcResolver_Unit_1);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }

  /* --- aktoren_sensoren_ansprechen/Winkel --- */
  /* --- [RTIEMC, Encoder] - DIO class: 2 - Unit: 1 - Port: 1 - Channel: 1 --- */
  {
    /* define a variable for IO error handling */
    UInt32 ioErrorRetValue = IOLIB_NO_ERROR;

    /* Resets start (initial) position for the selected incremental Encoder (in lines) */
    ioErrorRetValue = DioCl2EncoderIn_setEncPosition
      (pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1, (Float64) 0.0);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }

    /* Activate Encoder signals read */
    ioErrorRetValue = DioCl2EncoderIn_start
      (pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1);
    if (ioErrorRetValue > IOLIB_NO_ERROR) {
      RTLIB_EXIT(1);
    }
  }
}

/* Function rti_mdl_acknowledge_interrupts() is empty */
#define rti_mdl_acknowledge_interrupts()

/* Function rti_mdl_timetables_register() is empty */
#define rti_mdl_timetables_register()

/* Function rti_mdl_timesync_simstate() is empty */
#define rti_mdl_timesync_simstate()

/* Function rti_mdl_timesync_baserate() is empty */
#define rti_mdl_timesync_baserate()

static void rti_mdl_background(void)
{
  /* DsDaq background call */
  DsDaq_Background(0);
}

__INLINE void rti_mdl_sample_input(void)
{
  /* Calls for base sample time: [0.001, 0] */
  /* dSPACE I/O Board DS120XSTDADCC1 #0 Unit:ADCC1 */

  /* dSPACE I/O Board DS120XSTDADCC1 #0 Unit:ADCC1 Group:ADC */
  /* fire burst- or conversion trigger for analog input channel. Called by ADC C1 block pRTIAdcC1AnalogIn_Ch_3 */
  AdcCl1AnalogIn_setConversSwTrigger(pRTIAdcC1AnalogIn_Ch_3);
  AdcCl1AnalogIn_write(pRTIAdcC1AnalogIn_Ch_3);

  /* fire burst- or conversion trigger for analog input channel. Called by ADC C1 block pRTIAdcC1AnalogIn_Ch_1 */
  AdcCl1AnalogIn_setConversSwTrigger(pRTIAdcC1AnalogIn_Ch_1);
  AdcCl1AnalogIn_write(pRTIAdcC1AnalogIn_Ch_1);

  /* fire burst- or conversion trigger for analog input channel. Called by ADC C1 block pRTIAdcC1AnalogIn_Ch_10 */
  AdcCl1AnalogIn_setConversSwTrigger(pRTIAdcC1AnalogIn_Ch_10);
  AdcCl1AnalogIn_write(pRTIAdcC1AnalogIn_Ch_10);

  /* --- aktoren_sensoren_ansprechen/Resolver_HUB --- */
  /* --- [RTIEMC, Resolver] - Unit: 2 --- */
  {
    /* define variables required for resolver sensor realtime functions */
    Float64 position= 0.0;
    UInt32 isDataValid= 0;
    UInt32 faultStatus;

    /* Reads complete measuring data of resolver interface (update data from hardware) */
    ResolverIn_read(pRTIEmcResolver_Unit_2);

    /* Gets the electrical position determined by the resolver interface (deg) */
    ResolverIn_getPosition(pRTIEmcResolver_Unit_2, &position);

    /* Gets information if data delivered by resolver interface is valid */
    ResolverIn_getIsDataValid(pRTIEmcResolver_Unit_2, &isDataValid);
    aktoren_sensoren_ansprechen_B.SFunction1_o1 = (real_T) position;
    aktoren_sensoren_ansprechen_B.SFunction1_o2_p = (boolean_T) isDataValid;
  }

  /* --- aktoren_sensoren_ansprechen/Resolver_WEG --- */
  /* --- [RTIEMC, Resolver] - Unit: 1 --- */
  {
    /* define variables required for resolver sensor realtime functions */
    Float64 position= 0.0;
    UInt32 isDataValid= 0;
    UInt32 faultStatus;

    /* Reads complete measuring data of resolver interface (update data from hardware) */
    ResolverIn_read(pRTIEmcResolver_Unit_1);

    /* Gets the electrical position determined by the resolver interface (deg) */
    ResolverIn_getPosition(pRTIEmcResolver_Unit_1, &position);

    /* Gets information if data delivered by resolver interface is valid */
    ResolverIn_getIsDataValid(pRTIEmcResolver_Unit_1, &isDataValid);
    aktoren_sensoren_ansprechen_B.SFunction1_o1_m = (real_T) position;
    aktoren_sensoren_ansprechen_B.SFunction1_o2_j = (boolean_T) isDataValid;
  }

  /* --- aktoren_sensoren_ansprechen/Winkel --- */
  /* --- [RTIEMC, Encoder] - DIO class: 2 - Unit: 1 - Port: 1 - Channel: 1 --- */
  {
    /* define variables required for encoder sensor realtime functions */
    Float64 positionOrAngle= 0.0, speedOrAngVelocity= 0.0;
    UInt32 isIndexRaised= 0;

    /* Reads complete input data from selected encoder input channels (update data from hardware) */
    DioCl2EncoderIn_read(pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1);

    /* Gets encoder angle position (degree) */
    DioCl2EncoderIn_getMechPosition(pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1,
      &positionOrAngle);

    /* Gets encoder angular velocity (revolutions/minute) */
    DioCl2EncoderIn_getMechVelocity(pRTIEmcEncoder_Unit_1_DioCl_2_Port_1_Ch1,
      &speedOrAngVelocity);
    aktoren_sensoren_ansprechen_B.SFunction1_o1_i = (real_T) positionOrAngle;
    aktoren_sensoren_ansprechen_B.SFunction1_o2 = (real_T) speedOrAngVelocity;
  }
}

static void rti_mdl_daq_service()
{
  /* dSPACE Host Service */
  DsDaq_Service(0, 0, 1, (DsDaqSTimestampStruct *)
                rtk_current_task_absolute_time_ptr_get());
}

#undef __INLINE

/****** [EOF] ****************************************************************/
