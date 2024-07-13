CREATE OR REPLACE FUNCTION GetTopEmployees(p_num_employees IN NUMBER)
RETURN SYS_REFCURSOR
IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT personid
    FROM (
        SELECT e.personid, 
               RANK() OVER (ORDER BY (
                   SELECT COUNT(*)
                   FROM System.WorksOn w
                   WHERE w.employeeid = e.personid
               ) DESC) AS rank
        FROM System.Employee e
        WHERE e.seniority > 2
    )
    WHERE rank <= p_num_employees;

    RETURN v_cursor;
END;

