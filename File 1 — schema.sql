CREATE TABLE providers (
    provider_id INT PRIMARY KEY,
    provider_name VARCHAR(100),
    specialty VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE insurers (
    insurer_id INT PRIMARY KEY,
    insurer_name VARCHAR(100),
    plan_type VARCHAR(50)
);

CREATE TABLE procedures (
    procedure_code VARCHAR(10) PRIMARY KEY,
    procedure_name VARCHAR(100),
    standard_cost DECIMAL(10,2)
);

CREATE TABLE claims (
    claim_id INT PRIMARY KEY,
    provider_id INT REFERENCES providers(provider_id),
    insurer_id INT REFERENCES insurers(insurer_id),
    procedure_code VARCHAR(10) REFERENCES procedures(procedure_code),
    patient_id INT,
    claim_date DATE,
    claim_amount DECIMAL(10,2),
    status VARCHAR(20),
    denial_reason VARCHAR(100),
    resubmission_of INT REFERENCES claims(claim_id),
    final_outcome VARCHAR(20)
);
