  /*********************** dSPACE target specific file *************************

   Header file aktoren_sensoren_ansprechen_trc_ptr.h:

   Declaration of function that initializes the global TRC pointers

   RTI1202 7.7 (02-Nov-2016)
   Fri Nov 27 12:55:48 2020

   Copyright 2020, dSPACE GmbH. All rights reserved.

  *****************************************************************************/
  #ifndef RTI_HEADER_aktoren_sensoren_ansprechen_trc_ptr_h_
  #define RTI_HEADER_aktoren_sensoren_ansprechen_trc_ptr_h_
  /* Include the model header file. */
  #include "aktoren_sensoren_ansprechen.h"
  #include "aktoren_sensoren_ansprechen_private.h"

  #ifdef EXTERN_C
  #undef EXTERN_C
  #endif

  #ifdef __cplusplus
  #define EXTERN_C                       extern "C"
  #else
  #define EXTERN_C                       extern
  #endif

  /*
   *  Declare the global TRC pointers
   */
              EXTERN_C volatile  real_T *p_0_aktoren_sensoren_ansprechen_real_T_0;
              EXTERN_C volatile  boolean_T *p_0_aktoren_sensoren_ansprechen_boolean_T_1;
              EXTERN_C volatile  real_T *p_1_aktoren_sensoren_ansprechen_real_T_0;
              EXTERN_C volatile  boolean_T *p_2_aktoren_sensoren_ansprechen_boolean_T_2;

  /*
   *  Declare the general function for TRC pointer initialization
   */
  EXTERN_C void aktoren_sensoren_ansprechen_rti_init_trc_pointers(void);
   #endif                       /* RTI_HEADER_aktoren_sensoren_ansprechen_trc_ptr_h_ */
