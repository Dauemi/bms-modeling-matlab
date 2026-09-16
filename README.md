# Battery Design and Management System (BMS) Modeling

[![MATLAB](https://img.shields.io/badge/MATLAB-R2022b%2B-0076A8?logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
[![Simulink](https://img.shields.io/badge/Simulink-Simulation-orange?logo=mathworks&logoColor=white)](https://www.mathworks.com/products/simulink.html)
[![Simscape](https://img.shields.io/badge/Simscape-Physical_Modeling-blue?logo=mathworks&logoColor=white)](https://www.mathworks.com/products/simscape.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An end-to-end simulation and modeling suite for Battery Energy Storage Systems (BESS) and Battery Management Systems (BMS), developed in MATLAB, Simulink, and Simscape.

---

## Overview

This repository covers the complete engineering workflow for lithium-ion battery systems, from experimental laboratory data processing to pack-level deployment:
* **Cell Characterization:** Extracting open-circuit voltage curves and impedance behavior from laboratory pulse-discharge testing.
* **Equivalent Circuit Modeling (ECM):** Parameterizing 1-RC and 2-RC electrical network representations with temperature dependence.
* **State Estimation:** Deploying Coulomb counting and Kalman filtering (EKF/UKF) under realistic, dynamic driving cycles.
* **Pack Scaling & Thermal Management:** Simulating multi-cell architectures with active electro-thermal feedback and safety limit logic.

---

## Repository Architecture

```text
bms-modeling-matlab/
├── M1/                           # Cell Characterization & Pulse Testing
│   ├── pulse_discharge_test.mat  # Raw laboratory voltage/current telemetry
│   └── cell_ocv_fit.mlx          # OCV-SOC non-linear curve fitting script
├── M2/                           # Equivalent Circuit Model (ECM)
│   ├── ecm_parameter_extract.mlx # Automated extraction of R0, R1, C1 vs SOC
│   └── battery_cell_model.slx    # 1-RC / 2-RC Simscape cell block model
├── M3/                           # State of Charge (SOC) Estimation
│   ├── socDischargeProfile.mat   # Dynamic drive-cycle test current profile
│   ├── socEstimation_params.mlx  # Parameter initialization and filter gains
│   └── socEstimationEScooter.slx # Complete E-Scooter SOC estimation model
├── M4/                           # Pack Scaling & Thermal BMS
│   ├── pack_scaling_config.m     # Series/parallel cell matrix definition
│   └── pack_thermal_network.slx  # Coupled electro-thermal pack simulation
├── .gitattributes                # Git line endings & LFS rules
├── .gitignore                    # Build cache and temporary file filters
├── LICENSE                       # MIT open-source license
└── README.md                     # Project documentation
