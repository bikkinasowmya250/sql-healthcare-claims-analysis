# SQL Healthcare Claims Denial Analysis

## Business Question
Insurers tend to deny healthcare claims often. This project investigates 
how often denials occur, if resubmitting denied claims is worth it, 
and which denial reasons are worth fighting given the administrative effort involved.

## Dataset
Simulated dataset of synthetic claims (477 claims across all procedures, insurers and providers). 
The generated data mimicks real healthcare claims data. 
There is no public access to real claims data as a result of privacy laws. The dataset includes 
intentionally inconsistent denial reason text to show data quality challenges in the real world.

## Schema
Four tables: Providers, Insurers, Procedures, Claims. The `claims` table 
includes a self-referencing `resubmission_of` column to trace a claim's full 
lifecycle: original denial, resubmission and final outcome.

## Key Findings
1. First-time claims are denied on 35.75% of these claims (143 of 400 original claims).
2. 46% of denied claims are never even resubmitted. On average, the value of 
   claims staff do not pursue is $353, while claims staff do pursue is $608–$652 — 
   indicating lower dollar denials are being written off and not fought.
3. Denial reasons have a wide range of "worth fighting" odds:
   - Missing Authorization: the highest recovery rate at 82% when resubmitted. 
     Yet 49% of these claims are never resubmitted at all.
   - Not Covered: 0% recovery rate — these are policy exclusions, not 
     fixable by resubmission. Staff effort spent trying to fix them is wasted.

## Recommendation
Focus on resubmitting "Missing Authorization" denials in particular — 
the denial category with the highest recovery rate, at 82%, yet nearly 
half are currently abandoned. On the other hand, "Not Covered" denials 
should not continue to be pursued, as resubmission has almost no chance of success.

## Tools
PostgreSQL. Here's a summary of the SQL used: self-referencing joins to 
follow claim lifecycles through the `resubmission_of` link, and CASE WHEN 
with LIKE for text categorisation of inconsistent denial reasons.
