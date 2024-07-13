CREATE OR REPLACE FUNCTION GetTopEmployees(p_num_employees IN NUMBER)
RETURN SYS_REFCURSOR
IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT personid
    FROM (
        SELECT e.personid,
               GetEmployeeEventCount(e.personid) AS event_count,
               RANK() OVER (ORDER BY GetEmployeeEventCount(e.personid) DESC) AS rank
        FROM System.Employee e
        WHERE e.seniority > 2
    )
    WHERE rank <= p_num_employees;

    RETURN v_cursor;
END;


