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

SELECT * FROM retirement_titles;

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
ORDER BY COUNT DESC;

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
ORDER BY emp_no, to_date DESC;

SELECT * FROM mentorship_eligibilty;

-- Additional Query 1 for Total Employees Retiring
SELECT SUM(count) From retiring_titles;

-- Additional Query 2 for Mentorship Eligibility
SELECT Count(emp_no) From mentorship_eligibilty;

-- Additional Query 3 for Mentorship Eligibility EXPANDED
SELECT DISTINCT ON (emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
INTO mentorship_eligibilty_expanded
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
INNER JOIN debt_emp AS de
ON (e.emp_no = de.emp_no)
WHERE de.to_date = ('9999-01-01')
AND (birth_date BETWEEN '1960-01-01' AND '1965-12-31')
ORDER BY emp_no, to_date DESC;

SELECT Count(emp_no) From mentorship_eligibilty_expanded;

DROP TABLE mentorship_eligibilty_expanded;

-- Additional Query 4 for Engineering;

SELECT DISTINCT ON (emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
INTO engineers
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
INNER JOIN debt_emp AS de
ON (e.emp_no = de.emp_no)
WHERE t.title = ('Engineer') OR t.title = ('Senior Engineer')
ORDER BY emp_no, to_date DESC;

SELECT * FROM engineers;

SELECT Count(emp_no), title From engineers
GROUP BY title;

SELECT Count(emp_no) From engineers;