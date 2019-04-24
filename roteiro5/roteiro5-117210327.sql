--Q1
SELECT COUNT(sex) FROM employee WHERE sex = 'F';

--Q2
SELECT AVG(salary) FROM employee WHERE address LIKE '%, TX' AND sex = 'M';

--Q3
SELECT m.ssn as ssn_supervisor, COUNT(*) AS qtd_supervisionados 
FROM (employee AS m RIGHT OUTER JOIN employee AS e ON (m.ssn = e.superssn))
GROUP BY m.ssn
ORDER BY COUNT(*) ASC;

--Q4
SELECT m.fname as nome_supervisor, COUNT(*) AS qtd_supervisionados 
FROM (employee AS m JOIN employee AS e ON m.ssn = e.superssn)
GROUP BY m.ssn
ORDER BY COUNT(*) ASC;

--Q5
SELECT m.fname as nome_supervisor, COUNT(*) AS qtd_supervisionados 
FROM (employee AS m RIGHT OUTER JOIN employee AS e ON m.ssn = e.superssn)
GROUP BY m.ssn
ORDER BY COUNT(*) ASC;

--Q6
SELECT MIN(count) AS qtd
FROM (
    SELECT COUNT(*)
    FROM works_on
    GROUP BY pno
    ) AS res;

--Q7
SELECT pno as num_projeto, qtd as qtd_func
FROM (
    (SELECT pno, COUNT(*)
    FROM works_on
    GROUP BY pno) as pnc
    
    JOIN
    
    (SELECT MIN(count) AS qtd
    FROM (
        SELECT COUNT(*)
        FROM works_on
        GROUP BY pno
    ) t ) AS minumum

    ON pnc.count = minumum.qtd
);

--Q8
SELECT w.pno AS num_projeto, AVG(e.salary) AS media_sal
FROM works_on as w JOIN employee as e ON (w.essn = e.ssn)
GROUP BY w.pno;

--Q9
SELECT w.pno AS proj_num, p.pname as proj_nome, AVG(e.salary) AS media_sal
FROM project as p JOIN (works_on as w JOIN employee as e ON (w.essn = e.ssn)) ON (p.pnumber = w.pno)
GROUP BY w.pno, p.pname
ORDER BY AVG(e.salary) ASC;

--Q10 NAO FINALIZADO
SELECT e.fname, e.salary
FROM works_on as w JOIN employee AS e ON (w.essn = e.ssn AND w.pno = 92);

--Q11
SELECT e.ssn, COUNT(w.pno)
FROM employee as e LEFT OUTER JOIN works_on as w ON (e.ssn = w.essn)
GROUP BY e.ssn
ORDER BY COUNT(w.pno) ASC;

--Q12
SELECT pno as num_proj, count as qtd_func
FROM (
    SELECT pno, COUNT(*)
    FROM employee AS e LEFT OUTER JOIN works_on AS w ON (w.essn = e.ssn) 
    GROUP BY pno
) as sel
WHERE sel.count < 5;

--Q13
SELECT fname
FROM (
    SELECT eS.ssn
    FROM (
        SELECT e.ssn
        FROM (
            SELECT w.essn
            FROM (
                SELECT p.pnumber as pnumb
                FROM project as p
                WHERE p.plocation = 'Sugarland'
            ) AS proj, works_on as w
            WHERE w.pno = proj.pnumb
        ) AS sW, employee as e
        WHERE sW.essn = e.ssn
    ) AS eS, dependent AS d
    WHERE eS.ssn = d.essn
    GROUP BY eS.ssn
) AS fin, employee as e
WHERE fin.ssn = e.ssn; 

--Q14
SELECT d.dname
FROM (NOT EXISTS (department AND project))