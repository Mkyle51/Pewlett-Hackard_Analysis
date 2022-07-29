-- Retirement Query for Employees with Titles
SELECT 	e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;



-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

-- Count number of retiring employees by title
SELECT COUNT(title),
title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;

--Query for Mentorship Eligibility 
SELECT DISTINCT ON (emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
INNER JOIN debt_emp AS de
ON (e.emp_no = de.emp_no)
WHERE de.to_date = ('9999-01-01')
AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp.no;