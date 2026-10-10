CREATE VIEW admissions AS
WITH ranked AS (
  SELECT *, ROW_NUMBER() OVER (
    PARTITION BY Name, Age, Gender, `Blood Type`, `Medical Condition`,`Date of Admission`,
                 Doctor, Hospital, `Insurance Provider`, `Billing Amount`, `Room Number`,
                 `Admission Type`, `Discharge Date`, `Medication`, `Test Results`
    ORDER BY Name
  ) AS rn
  FROM health.admissions_raw
)
SELECT
  TRIM(Name)                AS Name,
  Age, Gender, `Blood Type`, `Medical Condition`,
  DATE(`Date of Admission`)   AS `Date of Admission`,
  Doctor, Hospital, `Insurance Provider`, `Billing Amount`, `Room Number`,
  `Admission Type`,
  DATE(`Discharge Date`)      AS `Discharge Date`,
  Medication, `Test Results`,
 DATEDIFF(`Discharge Date`, `Date of Admission`) AS `Length of Stay`
FROM ranked
WHERE rn = 1;
