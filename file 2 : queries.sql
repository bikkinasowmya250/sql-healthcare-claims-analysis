-- Denial rate on first submission (original claims only, excludes resubmissions)
SELECT status, COUNT(*)
FROM claims
WHERE resubmission_of IS NULL
GROUP BY status;

-- Outcome breakdown of originally denied claims (Paid / Denied again / Not resubmitted)
SELECT final_outcome, COUNT(*) 
FROM claims 
WHERE status = 'Denied' AND resubmission_of IS NULL 
GROUP BY final_outcome;

-- Average claim value by outcome — checks whether low-value claims get abandoned
SELECT final_outcome, AVG(claim_amount)
FROM claims 
WHERE status = 'Denied' AND resubmission_of IS NULL 
GROUP BY final_outcome;

-- Denial category breakdown, using CASE WHEN to group inconsistent denial reason text
-- into consistent categories, then checking recovery rate per category
SELECT 
    CASE 
        WHEN denial_reason LIKE '%auth%' THEN 'Missing Authorization'
        WHEN denial_reason LIKE '%covered%' OR denial_reason LIKE '%excluded%' THEN 'Not Covered'
        WHEN denial_reason LIKE '%code%' OR denial_reason LIKE '%coding%' THEN 'Coding Error'
        WHEN denial_reason LIKE '%duplicate%' OR denial_reason LIKE '%already submitted%' THEN 'Duplicate'
        WHEN denial_reason LIKE '%medical necessity%' OR denial_reason LIKE '%documentation%' THEN 'Medical Necessity'
        WHEN denial_reason LIKE '%eligible%' OR denial_reason LIKE '%coverage lapsed%' THEN 'Patient Ineligible'
        ELSE 'Other'
    END AS denial_category,
    final_outcome,
    COUNT(*)
FROM claims
WHERE status = 'Denied' AND resubmission_of IS NULL
GROUP BY denial_category, final_outcome
ORDER BY denial_category;
