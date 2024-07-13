create or replace function GetEmployeeEventCount (p_employee_id IN NUMBER) return number is
    v_event_count NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_event_count
    FROM System.WorksOn
    WHERE employeeid = p_employee_id;

    RETURN v_event_count;
end GetEmployeeEventCount ;


