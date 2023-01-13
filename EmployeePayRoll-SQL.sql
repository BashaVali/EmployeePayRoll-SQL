--UC1 Creating Database
CREATE DATABASE PAYROLL_SERVICESS
USE PAYROLL_SERVICE;

--UC2-Creating Table 
CREATE TABLE Employee_PayrollS(Id int PRIMARY KEY IDENTITY(1,1),Name varchar(30) NOT NULL,Salary BIGINT NOT NULL,Start DATE NOT NULL);

--UC3-Inserting values into Table
INSERT INTO Employee_PayrollS(Name,Salary,Start)VALUES('Basha',45000,'2023-03-02'),('Vali',55000,'2017-04-21'),('Shaik',20000,'2020-06-17');

--UC4-Retrieve All Data from table
SELECT * FROM Employee_PayrollS

--UC5-Retrieve salary data for particular employee as well as all employees who joined particular data range
SELECT Salary FROM Employee_PayrollS WHERE Name='Basha';
SELECT * FROM Employee_PayrollS WHERE START BETWEEN CAST('2020-06-17' As DATE) AND GETDATE();

--UC6-Add Gender Column and Update the Rows to reflect the correct Employee Gender
ALTER TABLE Employee_PayrollS ADD Gender varchar(10);
UPDATE Employee_PayrollS SET Gender='M' WHERE Name='Basha';
UPDATE Employee_PayrollS SET Gender='M' WHERE Name='Vali';
UPDATE Employee_PayrollS SET Gender='M' WHERE Name='Shaik';
UPDATE Employee_PayrollS SET Salary=45000 WHERE Name='Shaik';

--UC7-Find sum,average, min, max and number of male and female employees
SELECT AVG(Salary) FROM Employee_PayrollS WHERE Gender='M' GROUP BY Gender;
SELECT SUM(Salary) FROM Employee_PayrollS WHERE Gender='M' GROUP BY Gender;
SELECT MAX(Salary) FROM Employee_PayrollS WHERE Gender='M' GROUP BY Gender;
SELECT MIN(Salary) FROM Employee_PayrollS WHERE Gender='M' GROUP BY Gender;
SELECT COUNT(Salary) FROM Employee_PayrollS WHERE Gender='M' GROUP BY Gender;
SELECT COUNT(Salary) FROM Employee_PayrollS WHERE Gender='F' GROUP BY Gender;

--UC8 Adding Employee Additional Information
USE PAYROLL_SERVICE;
ALTER TABLE Employee_PayrollS ADD PhoneNo BIGINT;
ALTER TABLE Employee_PayrollS ADD EmpAddress VARCHAR(100) NOT NULL DEFAULT 'INDIA';
ALTER TABLE Employee_PayrollS ADD Department VARCHAR(20) NOT NULL DEFAULT 'Research';
UPDATE Employee_PayrollS SET PhoneNo=9966576672 WHERE Id=1;
UPDATE Employee_PayrollS SET PhoneNo=987654321 WHERE Id=2;
UPDATE Employee_PayrollS SET PhoneNo=987456321 WHERE Id=3;
SELECT * FROM Employee_PayrollS

--UC9 Adding Pays Columns further to te table
--ALTER TABLE Employee_Payroll RENAME COLUMN 'Salary' TO 'Basic_Pay';
EXEC SP_RENAME 'Employee_PayrollS.Salary', 'BasicPay', 'COLUMN';
ALTER TABLE Employee_PayrollS ADD Deductions FLOAT NOT NULL DEFAULT 0.00;
ALTER TABLE Employee_PayrollS ADD TaxablePay FLOAT NOT NULL DEFAULT 0.00;
ALTER TABLE Employee_PayrollS ADD IncomeTax FLOAT NOT NULL DEFAULT 0.00;
ALTER TABLE Employee_PayrollS ADD NetPay FLOAT NOT NULL DEFAULT 0.00;

UPDATE Employee_PayrollS SET NetPay = (BasicPay - Deductions - TaxablePay - IncomeTax);
UPDATE Employee_PayrollS SET Deductions=4000 WHERE Id IN (1,3);
UPDATE Employee_PayrollS SET Deductions=6000 WHERE Id=2;
UPDATE Employee_PayrollS SET Deductions=2000 WHERE Id=4;

--UC10- Adding Department oF Sales & Marketing Both
UPDATE Employee_PayrollS SET Department='Sales' WHERE Name='Ravi';
INSERT INTO Employee_PayrollS VALUES('Ravi',30000,'2019-06-07','M',9966576672,'Kumar','Marketing',0.0,0.0,0.0,30000);



