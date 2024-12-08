#"Only 3 in 20"#
# This is the script to run a pre and post treatment test to evaluate the impact
# of "Solo 3 de 20" intervention to curtail fare evasion in Bogota's public trans
#portation system, TM.
# This is the script to run a pre and post treatment test to evaluate the impact
# of "Solo 3 de 20" intervention to curtail fare evasion in Bogota's public trans
#portation system, TM.

# Load required libraries
library(DeclareDesign)
library(estimatr)
library(fabricatr)

# ======================
# PARAMETERS
# ======================

# Total estimated daily passengers for treatment stations in Troncal 26 (Treatment Group)
N_station_treat <- 10000 + 6000 + 6000 + 6000  # Total: 28,000
# - Portal El Dorado: 10,000 (major station)
# - Normandía: 6,000 (intermediate station)
# - CAN: 6,000 (intermediate station)
# - Ciudad Universitaria: 6,000 (intermediate station)

# Total estimated daily passengers for control stations (Troncal 80 - Control Group)
N_station_control <- 12000 + 7000 + 5000 + 5000  # Total: 29,000
# - Cabecera Calle 80: 12,000 (major station)
# - Minuto de Dios: 7,000 (intermediate station)
# - Carrera 47: 5,000 (intermediate station)
# - Carrera 53: 5,000 (intermediate station)

# Expected effect of the intervention (average treatment effect)
ate <- 0.02  # 2% reduction in fare evasion due to the informational campaign

# Variability of fare evasion rates
sd_1 <- 0.05  # Standard deviation of fare evasion rates at pre-test
sd_2 <- 0.05  # Standard deviation of fare evasion rates at post-test

# Correlation between pre-test and post-test rates
rho <- 0.7   # Fare evasion should be consistent in time, therefore, high corre
#lation expected.

# Missing data proportion
attrition_rate <- 0  # No attrition expected since observation is passive (no missing data)

# ======================
# DESIGN
# ======================

# 1. POPULATION: Pre-test and post-test fare evasion rates
population <- declare_population(
  station = rep(c("Treatment", "Control"), c(N_station_treat, N_station_control)),
  # Baseline rates for each group
  baseline_rate = ifelse(station == "Treatment", 0.1458, 0.1304),  # Treatment: 14.58%, Control: 13.04%
  
  # Variability for pre-test and post-test
  u_t1 = rnorm(N_station_treat + N_station_control) * sd_1,  # Pre-test individual variability
  u_t2 = rnorm(N_station_treat + N_station_control, rho * scale(u_t1), sqrt(1 - rho^2)) * sd_2,
  
  # Pre-treatment outcome: baseline rate + random variability
  Y_t1 = baseline_rate + u_t1
)

# 2. POTENTIAL OUTCOMES: Post-test fare evasion rates
potential_outcomes <- declare_potential_outcomes(
  Y_t2 ~ Y_t1 + ate * (station == "Treatment") + u_t2
  # Post-test = Pre-test + Treatment effect (if treated) + variability
)

# 3. INQUIRY: Average Treatment Effect (ATE)
estimand <- declare_inquiry(
  ATE = mean(Y_t2_Z_1 - Y_t2_Z_0)
)

# 4. REVEAL OUTCOMES: Observed post-test rates
reveal_outcomes <- declare_reveal(Y_t2, Z)

# 5. MANUAL ASSIGNMENT: Treatment vs Control
manual_assignment <- declare_step(
  handler = fabricate,
  Z = ifelse(station == "Treatment", 1, 0)  # Assign 1 for treatment group and 0 for control
)

# 6. MANIPULATION: Change score (Post-test - Pre-test)
manipulation <- declare_step(
  difference = (Y_t2 - Y_t1), 
  handler = fabricate
)

# ======================
# ESTIMATORS
# ======================

# 1. CHANGE SCORE ESTIMATOR
change_score <- declare_estimator(
  difference ~ Z,
  model = lm_robust,
  label = "Change score"
)

# 2. POST-TEST OUTCOME ONLY
posttest_only <- declare_estimator(
  Y_t2 ~ Z,
  model = lm_robust,
  label = "Post-test only"
)

# ======================
# FINAL DESIGN
# ======================

fare_evasion_design <- population + 
  manual_assignment + 
  potential_outcomes + 
  reveal_outcomes + 
  manipulation + 
  change_score + 
  posttest_only

# ======================
# SIMULATE OUTCOMES
# ======================

# Simulate a single dataset
set.seed(123)
data <- draw_data(fare_evasion_design)
print(head(data))

# Diagnose the design
diagnosis <- diagnose_design(fare_evasion_design, sims = 100)
print(diagnosis)
