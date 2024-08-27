-- Create the database
CREATE DATABASE DataTraining_day1;

-- Create the employee_source table
CREATE TABLE employee_source (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    CreatedDate DATETIME
);

-- Create the employee_destination table
CREATE TABLE employee_destination (
    EmployeeHistoryID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    CreatedDate DATETIME,
    IsDeleted BIT DEFAULT 0
);

-- Add default constraint for CreatedDate in employee_destination
ALTER TABLE employee_destination
ADD CONSTRAINT DF_employee_destination_CreatedDate
DEFAULT GETDATE() FOR CreatedDate;

-- Trigger to handle inserts from employee_source to employee_destination
CREATE TRIGGER trg_employee_source_insert
ON employee_source
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO employee_destination (EmployeeID, Name, Department, CreatedDate)
    SELECT EmployeeID, Name, Department, CreatedDate
    FROM inserted;
END;

-- Trigger to handle updates from employee_source to employee_destination
CREATE TRIGGER trg_employee_source_update
ON employee_source
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO employee_destination (EmployeeID, Name, Department, CreatedDate)
    SELECT i.EmployeeID, i.Name, i.Department, GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.EmployeeID = d.EmployeeID
    WHERE i.Name <> d.Name OR i.Department <> d.Department;
END;

-- Trigger to handle deletes from employee_source to employee_destination
CREATE TRIGGER trg_employee_source_delete
ON employee_source
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE employee_destination
    SET IsDeleted = 1
    WHERE EmployeeID IN (SELECT EmployeeID FROM deleted);
END;

-- Sample operations
SELECT * FROM employee_source;
SELECT * FROM employee_destination;

INSERT INTO employee_source (Name, Department)
VALUES ('Shangu', 'AI');

UPDATE employee_source
SET Name = 'Shangu updated', Department = 'DS'
WHERE EmployeeID = 4;

DELETE FROM employee_source WHERE EmployeeID = 4;

-- Stored procedure to get employee data based on debug flag
CREATE PROCEDURE sp_get_employee_data
    @debugflag INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @debugflag = 1
    BEGIN
        SELECT * FROM employee_destination;
    END
    ELSE
    BEGIN
        SELECT * FROM employee_source;
    END;
END;

-- Execute the stored procedure with debug flag
EXEC sp_get_employee_data 1;
