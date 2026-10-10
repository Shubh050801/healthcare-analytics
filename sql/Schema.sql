CREATE TABLE admissions_raw (
  Name                TEXT,
  Age                 INTEGER,
  Gender              TEXT,
  Blood_Type          TEXT,
  `Medical Condition`   TEXT,
  `Date of Admission`   DATE,
  Doctor              TEXT,
  Hospital            TEXT,
  `Insurance Provider`  TEXT,
  `Billing Amount`      REAL,
  `Room Number`         INTEGER,
  `Admission Type`      TEXT,
  `Discharge Date`     DATE,
  Medication          TEXT,
  `Test Results`        TEXT
);

select * from admissions_raw