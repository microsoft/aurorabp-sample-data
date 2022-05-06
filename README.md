# Aurora-BP Study Data

Here, you can access the de-identified Aurora-BP datasets used in the associated publication: "[A Comparison of Wearable Tonometry, Photoplethysmography, and Electrocardiography for Cuffless Measurement of Blood Pressure in an Ambulatory Setting.](https://ieeexplore.ieee.org/document/9721156)"

The publishing of these datasets as well as the characterization of multiple feature groups across a broad population and multiple settings are intended to aid future cardiovascular research. These datasets include de-identified participant information, as well as aligned and featurized sensor data. See publication for more information. Below are details describing the published dataset and access information.

---

## Data Access

### Data Access Committee

Requests for [data access](docs/README.md) are reviewed by the Data Access Committee. During review, submitting investigator and primary investigator may be contacted for verification. For further information regarding data access, contact: aurorabp@microsoft.com

---

## Data File Descriptions

<!-- TODO: include JSON files with type information for each file type -->

### Participant information file

A single file named `participants.tsv` containing study participant information including device sizes, number of included measurements, basic demographics and relevant cardiovascular health history. Each row represents a study participant.

| Column header | Data type | Description |
|:-------------------- |:-------------------- |:-------------------- |
| pid | string | participant ID, prefixed with 'a' for participants in the auscultatory protocol and 'o' for participants in the oscillometric protocol |
| n_meas_inlab | int | number of in-lab measurements from participant available in measurements file |
| n_meas_ambulatory | int | number of ambulatory measurements from participant available in measurements file (applicable to oscillometric protocol only) |
| aurora_size | categorical | tonometric device size, S=small M=medium L=large |
| fitzpatrick_scale | int | Fitzpatrick scale skin color value, standard values 1-7 |
| bp_cuff_arm | categorical | arm wearing BP brachial cuff, L=left arm R=right arm |
| in_feature_table | boolean | denotes whether participant measurements were featurized and available in features.tsv |
| age* | float | age, in years |
| height* | float | height, in inches |
| weight* | float | weight, in pounds |
| gender* | categorical | gender, M=identify male F=identify female |
| self_report_htn* | categorical | participant self-reported hypertensive status: 'norm'= normal or unknown hypertensive status, 'managed'= managed hypertension, 'unmanaged'= unmanaged hypertension |
| high_blood_pressure* | boolean | history of high blood pressure |
| coronary_artery_disease* | boolean | history of coronary artery disease |
| diabetes* | boolean | history of diabetes |
| arrythmia* | boolean | history of arrythmia |
| previous_heart_attack* | boolean | history of previous heart attack |
| previous_stroke* | boolean | history of previous stroke |
| heart_failure* | boolean | history of heart failure |
| aortic_stenosis* | boolean | history of aortic stenosis |
| valvular_heart_disease* | boolean | history of valvular heart disease |
| other_cv_diseases* | boolean | history of other, unlisted cardiovascular disease |
| cvd_meds* | boolean | currently taking any medications for cardiovascular diseases, including high blood pressure |

Notes:

- \* Participant self-reported information
- For boolean values 1=yes, 0=no

### Measurement-level data files

There are two files containing high-level measurement-level data, one for each protocol: `measurements_auscultatory.tsv` and `measurements_oscillometric.tsv`. These files detail basic measurement information including protocol phase, measurement type, measurement characteristics, and file path of the associated waveform files. Each row represents one measurement.

A [file containing waveform-level data](#measurement-waveform-level-data-files) is also available for each measurement, and is referenced using the `waveform_file_path` column.

| Column header | Data type | Description |
|:-------------------- |:-------------------- |:-------------------- |
| pid | string | participant ID, prefixed with 'a' for participants in the auscultatory protocol and 'o' for participants in the oscillometric protocol |
| phase | string | protocol phase for measurement: 'initial' for initial visit, 'ambulatory' for the ambulatory portion of oscillometric protocol, 'return' for return visit', and 'synthetic' for synthetic harmonization of initial visit data for use as a baseline measurement |
| measurement | string | measurement identifier unique within a single pid/phase combination |
| date_time | string | date/time formatted as "%y-%m-%d %H:%M:%S" per the [Python datetime Data Type](https://docs.python.org/3/library/datetime.html) (absolute date information was removed during de-identification, but date relative to the initial visit has been preserved) |
| sbp | float | systolic blood pressure (average of primary and secondary observer determinations in auscultatory protocol, automated device determination value in the oscillometric protocol) |
| dbp | float | diastolic blood pressure (average of primary and secondary observer determinations in auscultatory protocol, automated device determination value in the oscillometric protocol) |
| duration | float | measurement duration, in seconds |
| pressure_quality | float | tonometric quality, 0 to 1 scale |
| optical_quality | float | optical quality, 0 to 1 scale |
| waveform_file_path | string | measurement waveform file path |
| waveforms_generated | boolean | specifies if waveforms were generated from the measurement, 1=yes, 0=no |
| primary_systolic&dagger; | float | primary observer systolic blood pressure determination, in mmHg |
| primary_diastolic&dagger; | float | secondary observer systolic blood pressure determination, in mmHg |
| secondary_systolic&dagger; | float | primary observer diastolic blood pressure determination, in mmHg |
| secondary_diastolic&dagger; | float | secondary observer systolic blood pressure determination, in mmHg |
| consensus_systolic_error&dagger; | float | delta between primary and secondary observer systolic blood pressure determinations, in mmHg |
| consensus_diastolic_error&dagger; | float | delta between primary and secondary observer diastolic blood pressure determinations, in mmHg |

Notes:

- &dagger; Auscultatory protocol only

### Measurement waveform-level data files

Time-aligned sensor waveform data from multiple sensors are provided in individual files for each measurement. These are organized in directories first by protocol and then by participant ID (`pid`). Within these directories, each measurement will have a TSV file named `<pid>.<phase>.<measurement>.tsv`, in which `<pid>`, `<phase>`, and `<measurement>` correspond to the column values from the [meaurement-level data files](#measurement-level-data-files).

For example, the waveforms associated with participant "a1234" from the auscultatory protocol would be in the `measurements_auscultatory/a1234/` directory. The waveforms associated with the "Calibration start 1" measurement from the initial visit would be located in the `measurements_auscultatory/a1234/a1234.initial.Calibration_start_1.tsv` file.

Within these waveform files, each row represents a sample (point in time). Multiple sensor streams are present in each file, and all sensor streams have been resampled to a common timebase of 500 samples per second.

| Column header | Data type | Description |
|:-------------------- |:-------------------- |:-------------------- |
| t | float | time (sec) relative to the date_time metadata value |
| ekg | float | ECG signal amplitude, in millivolts (mV) |
| optical | float | optical signal amplitude, in arbitrary amplifier units |
| pressure | float | tonometric signal amplitude, in millibars (mbar) |
| accel_x | float | acceleration in the X-axis (tonometer band lengthwise plane), in [g-force](https://en.wikipedia.org/wiki/G-force) |
| accel_y | float | acceleration in the Y-axis (tonometer band widthwise plane), in [g-force](https://en.wikipedia.org/wiki/G-force) |
| accel_z | float | acceleration in the Z-axis (perpendicular to tonometer band), in [g-force](https://en.wikipedia.org/wiki/G-force) |

### Measurement features data file

A single file named `features.tsv` containing all derived/calculated features as columns for each featurized measurement. Each row represents one measurement.

| Column header | Data type | Description | Source feature is derived from |
|:-------------------- |:-------------------- |:-------------------- |:-------------------- |
| pid | string | participant ID, prefixed with 'a' for participants in the auscultatory protocol and 'o' for participants in the oscillometric protocol | NA |
| phase | string | protocol phase for measurement: 'initial' for initial visit, 'ambulatory' for the ambulatory portion of oscillometric protocol, 'return' for return visit', and 'synthetic' for synthetic harmonization of initial visit data for use as a baseline measurement | NA |
| measurement | string | measurement identifier unique within a single pid/phase combination | NA |
| date_time | datetime | date/time formatted as "%y-%m-%d %H:%M:%S" per the [Python datetime Data Type](https://docs.python.org/3/library/datetime.html) (absolute date information was removed during de-identification, but date relative to the initial visit has been preserved) | NA |
| sbp | float | systolic blood pressure (average of primary and secondary observer determinations in auscultatory protocol, automated device determination value in the oscillometric protocol) | BP device |
| dbp | float | diastolic blood pressure (average of primary and secondary observer determinations in auscultatory protocol, automated device determination value in the oscillometric protocol) | BP device |
| baseline_sbp | float | baseline systolic blood pressure (calculated as synthetic-Calibration average values), in mmHg  | BP device |
| baseline_dbp | float | baseline diastolic blood pressure (calculated as synthetic-Calibration average values), in mmHg  | BP device |
| delta_sbp | float | delta between sbp and baseline_sbp, in mmHg  | BP device |
| delta_dbp | float | delta between dbp and baseline_dbp, in mmHg  | BP device |
| arm_angle | float | arm angle, in degrees relative to earth's gravity  | accelerometer |
| motion_level | float | motion level  | accelerometer |
| steps_last_five_mins | float | number of steps in the last 5 minutes  | accelerometer |
| steps_last_thirty_mins | float | number of steps in the last 30 minutes  | accelerometer |
| beat_length_ekg | float | heart beat length, in seconds  | ECG |
| hr_ekg | float | heart rate, in bpm  | ECG |
| hrv_ekg | float | heart rate variability, in bpm  | ECG |
| dpdt_optical | float | time derivative of PPG signal  | PPG |
| hr_optical | float | heart rate, in bpm  | PPG |
| quality_optical | float | optical quality, ranges between 0 and 1 (inclusion threshold of .65 was used for prediction experiments in the Aurora-BP study) | PPG |
| invpat_optical | float | inverse rPAT, in 1/seconds  | PPG + ECG |
| rpat_optical | float | rPAT, in seconds  | PPG + ECG |
| aix_pressure | float | augmentation index  | tonometer |
| dicrotic_notch_height_pressure | float | dicrotic notch height, in mbar | tonometer |
| dpdt_pressure | float | time derivative of pressure signal, in mbar/s  | tonometer |
| ejection_duration_fraction_pressure | float | ejection duration fraction  | tonometer |
| ejection_duration_pressure | float | ejection duration, in seconds  | tonometer |
| hr_pressure | float | heart rate, in bpm  | tonometer |
| quality_pressure | float | tonometric quality, ranges between 0 and 1 (inclusion threshold of .65 was used for prediction experiments in the Aurora-BP study) | tonometer |
| rwat_pressure | float | reflected wave arrival time, in seconds  | tonometer |
| sysrise_pressure | float | systolic rise time, in seconds  | tonometer |
| invpat_pressure | float | inverse rPAT, in 1/seconds  | tonometer + ECG |
| rpat_pressure | float | rPAT, in seconds  | tonometer + ECG |
| delta_arm_angle | float | delta between measurement arm angle value and baseline&Dagger; value, in degrees relative to gravity | accelerometer |
| delta_beat_length_ekg | float | delta between measurement heart beat length value and baseline&Dagger; value, in seconds | ECG |
| delta_hr_ekg | float | delta between measurement heart rate value and baseline&Dagger; value, in bpm | ECG |
| delta_hrv_ekg | float | delta between measurement heart rate variability value and baseline&Dagger; value, in bpm | ECG |
| delta_dpdt_optical | float | delta between measurement dP/dt value and baseline&Dagger; value | PPG |
| delta_hr_optical | float | delta between measurement heart rate value and baseline&Dagger; value, in bpm | PPG |
| delta_quality_optical | float | delta between measurement optical quality and baseline&Dagger; value | PPG |
| delta_invpat_optical | float | delta between measurement inverse rPAT value and baseline&Dagger; valu, in secondse | PPG + ECG |
| delta_rpat_optical | float | delta between measurement rPAT value and baseline&Dagger; value, in seconds | PPG + ECG |
| delta_aix_pressure | float | delta between measurement augmentation index and baseline&Dagger; value | tonometer |
| delta_dicrotic_notch_height_pressure | float | delta between measurement dicrotic notch height value and baseline&Dagger; value, in mbar | tonometer |
| delta_dpdt_pressure | float | delta between measurement dP/dt value and baseline&Dagger; value, in mbar/s | tonometer |
| delta_ejection_duration_fraction_pressure | float | delta between measurement ejection duration fraction value and baseline&Dagger; value | tonometer |
| delta_ejection_duration_pressure | float | delta between measurement ejection duration value and baseline&Dagger; value, in seconds | tonometer |
| delta_hr_pressure | float | delta between measurement heart rate value and baseline&Dagger; value, in bpm | tonometer |
| delta_quality_pressure | float | delta between measurement tonometric quality and baseline&Dagger; value | tonometer |
| delta_rwat_pressure | float | delta between measurement reflected wave arrival time value and baseline&Dagger; value, in seconds | tonometer |
| delta_sysrise_pressure | float | delta between measurement systolic rise time and baseline&Dagger; value, in seconds | tonometer |
| delta_invpat_pressure | float | delta between measurement inverse rPAT value and baseline&Dagger; value, in 1/seconds | tonometer + ECG |
| delta_rpat_pressure | float | delta between measurement rPAT value and baseline&Dagger; value, in seconds | tonometer + ECG |

Notes:

- &Dagger; *Calibration average values* feature row of specified participant
- See original publication for discussion on feature derivation methods

---

## Synthetic Measurements

In order to standardize analysis across auscultatory and oscillometric protocols as well as within participant sets, a series of harmonized “synthetic” phase measurements were derived from initial visit data. These synthetic measurements only appear in the `features.tsv` file, and do not have any associated waveform files or associated rows in the measurements TSV files. The two types of harmonization performed were (1) to optimize for a consistent BP value baseline, and (2) to optimize for a baseline with the most available tonometric signal.

These were calculated for initial supine measurements and, when available, initial seated measurements. Initial calibration measurements were averaged to create the "Calibration average values" baseline reported in "baseline_sbp" and "baseline_dbp"; these baselines were used in calculating "delta_" features for each participant.
