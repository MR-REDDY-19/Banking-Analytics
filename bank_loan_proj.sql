create database bank_loan_broject;
use bank_loan_broject;

select count(*) from finance_2;
select count(*) from finance_1;

select * from finance_2;
select * from finance_1;

/* KPI 1 Year wise loan amount Stats*/
select month(issue_d) as issue_year, sum(loan_amnt) as total_loan_amount
from finance_1
group by issue_year
order by issue_year;

/* KPI 2 Grade and sub grade wise revol_bal*/
select grade, sub_grade, sum(revol_bal) as total_revol_bal from 
finance_1 f1 inner join finance_2 f2
on (f1.id = f2.id)
group by grade, sub_grade
order by grade, sub_grade;

/*KPI 3 (Total Payment for Verified Status Vs Total Payment for Non Verified Status)*/
select verification_status, round(sum(total_pymnt),2) as Total_payment from
finance_1 f1 inner join finance_2 f2
on (f1.id = f2.id)
where verification_status in('Verified', 'Not Verified')
group by verification_status;


 /*KPI 4 (State wise and last_credit_pull_d wise loan status) */
select addr_state, last_credit_pull_d ,loan_status from
finance_1 f1 inner join finance_2 f2
on (f1.id = f2.id)
group by addr_state, last_credit_pull_d, loan_status
order by last_credit_pull_d;

/* kpi 5 month wise loan status*/
SELECT 
    MONTH(issue_d) AS month,
    YEAR(issue_d) AS year,
    SUM(CASE WHEN loan_status = 'charged off' THEN 1 ELSE 0 END) AS charged_off,
    SUM(CASE WHEN loan_status = 'fully paid' THEN 1 ELSE 0 END) AS fully_paid,
    SUM(CASE WHEN loan_status = 'current' THEN 1 ELSE 0 END) AS current
FROM 
    finance_1
GROUP BY 
    YEAR(issue_d), MONTH(issue_d)
ORDER BY 
    year, month;



/*KPI 6 (Home ownership Vs last payment date stats)*/
select home_ownership, 
last_pymnt_d as last_payment_date, 
round(sum(last_pymnt_amnt),2) as total_payment
from finance_1 f1 inner join finance_2 f2
on (f1.id = f2.id)
group by  last_pymnt_d,home_ownership
order by  last_pymnt_d desc ,home_ownership desc;