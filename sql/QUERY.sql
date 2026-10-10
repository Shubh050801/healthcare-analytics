# condition breakdown
SELECT `Medical Condition`,
       COUNT(*) AS Patients,
       ROUND(AVG(`Billing Amount`), 2) AS `Avg billing`,
       ROUND(AVG(`Length of Stay`), 2) AS `Avg LOS`
FROM admissions_clean
GROUP BY `Medical Condition`
ORDER BY patients DESC;

# Test-result rate by condition, without a PIVOT clause

SELECT `Medical Condition`,
  ROUND(100.0 * SUM(CASE WHEN `Test Results`='Normal' THEN 1 ELSE 0 END) / COUNT(*), 1) AS `pct normal`,
  ROUND(100.0 * SUM(CASE WHEN `Test Results`='Abnormal' THEN 1 ELSE 0 END) / COUNT(*), 1) AS `pct abnormal`,
  ROUND(100.0 * SUM(CASE WHEN `Test Results`='Inconclusive' THEN 1 ELSE 0 END) / COUNT(*), 1) AS `pct inconclusive`
FROM admissions_clean
GROUP BY `Medical Condition`;

# Verified result
# Every condition lands within 32.5%–34.3% for every outcome. 
# This is the moment SQL alone tips you off that Test_Results doesn't track diagnosis in this dataset — worth flagging here, before you've written a line of Python.
SELECT date_format(`Date of Admission`,'%Y-%m') AS month, COUNT(*) AS admissions
FROM admissions_clean GROUP BY month ORDER BY month;
# SQL — RANK() window function
SELECT `Medical Condition`,
  ROUND(AVG(`Billing Amount`), 2) AS `Avg billing`,
  RANK() OVER (ORDER BY AVG(`Billing Amount`) DESC) AS `Billing rank`
FROM admissions_clean
GROUP BY `Medical Condition`;

# Use the ranking query specifically to demonstrate a window function in your repo — it's one of the most commonly screened-for SQL skills,
# here it also visibly shows the ranks are nearly a coin flip: Obesity edges out Cancer by about $650 on average bills of roughly $25,500 (~2.5%), not a meaningful gap.