# Tactile-Shape-perception-Exp-data
The respository included source tactile stimili code, experiment code, experiment source data and data analysis code for 2 behavirol and EEG experiments.

## 1. Project Overview
- Experiment name: Beyond Sensory Gain: Spatial Attention and Semantic Priors Drive a Hierarchical Mechanism in Tactile Integration
- Experiment equipment: 64-channel EEG cap system (EasyCap, GmbH, Germany)
- Vibration equipment: QuaeroSys Pjezostimulator, Germany，two 4 × 5 stimulator matrices, with each matrix containing 20 independent stimulation pins

## 2. Data Structure
- Data structure:
  Experiment code is wirten by Psychotool Box in Matlab, format is .m file.
  Behavior result is exported with .xlsx files.
  EEG data is .vhdr, .vmrk and .eeg files.
  Results are anlyzed by Python, so data analysis code is .ipynb files.
- Data content structure:
  /Tactile Shape perception Exp data
    Exp code
      EXP 1: code for experiment 1 as .m file.
      Behavior: code for experiment 2 as .m file.
      PreEEG: code for experiment 3 PreEEG practice and test as .m file.
      EEG: code for experiment 3 formal test with EEG markers as .m file.
    Exp stimili and code
      EXP1: stimuli codes for experiment 1 as .m files and stimuli picutres as .jpg files.
      EXP 2 and 3: stimuli codes for experiment 2 and 3 as .m files and stimuli picutres as .jpg files.
    Exp result and analysis code
      EXP 1: data analysis code for experiment 1 as .ipynb file
      Exp2Behavior: data analysis code for experiment 2 as .ipynb file
      Exp3Behavior: data analysis code for experiment 3 behavivor results as .ipynb file
      EEGpre: EEG data pre-analysis code as .ipynb file
      EEGGeneral: EEG data analysis code for general PSD, SNR and ERP as .ipynb file
      EEGSSSEP: EEG data analysis code for SSSEP, IM and LCM as .ipynb file
    Exp source data
      EXP1: Source result for experiment 1 behavior as .xlsx files
      EXP2: Source result for experiment 2 behavior as .xlsx files
      EXP3
        Behavoir: Source result for experiment 3 behavior as .xlsx files.
        EEG: Source result for EEG as .vhdr, .vmrk and .eeg files.

## 3. EEG Technical Specifications
- EEG Sampling Rate: 1000 Hz
- Online Filter: 0.01 - 40 Hz
- Triggers/Markers: 
  - S 100: Stimulus Onset
  - S 20/30: Attention cue (20 is left hand, 30 is right hand)
  - S 12/21/14/41/23/32/34/43: Stimuli (8 stimuli pairs in left and right hands)
  - S 40/50: Report cue (40 is left hand, 50 is right hand)
  - S 60: Choice
  - S 70: Key

## 4. Contact
- Author: Qianqian Zhang
- Email: 13921178358@163.com
