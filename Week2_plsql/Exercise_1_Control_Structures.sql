-- Table Creation

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
); 

-- Value Insertion

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 1000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 1500, SYSDATE);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, SYSDATE, 200, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

-- Scenario 1: Apply a 1% discount to loan interest rates for customers above 60 years old

BEGIN
  FOR rec IN (
    SELECT l.LoanID, l.InterestRate
    FROM Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    WHERE MONTHS_BETWEEN(SYSDATE, c.DOB)/12 > 60
  ) LOOP
    UPDATE Loans
    SET InterestRate = rec.InterestRate - 1
    WHERE LoanID = rec.LoanID;
  END LOOP;

  COMMIT;
END;


-- Add older customer and loan to test:

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (3, 'Elder Joe', TO_DATE('1950-01-01', 'YYYY-MM-DD'), 2000, SYSDATE);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 3, 7000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

-- Sample Output
SELECT * FROM Loans;




-- Scenario 2: Promote customers to VIP status based on balance over $10,000

ALTER TABLE Customers ADD IsVIP VARCHAR2(5);

BEGIN
  FOR rec IN (
    SELECT CustomerID
    FROM Customers
    WHERE Balance > 10000
  ) LOOP
    UPDATE Customers
    SET IsVIP = 'TRUE'
    WHERE CustomerID = rec.CustomerID;
  END LOOP;

  COMMIT;
END;


-- Add VIP-eligible customer:

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (4, 'Rich Person', TO_DATE('1980-02-20', 'YYYY-MM-DD'), 12000, SYSDATE);

-- Sample Output
SELECT * FROM Loans;


-- Scenario 3: Send reminders to customers whose loans are due within the next 30 days

SET SERVEROUTPUT ON;


BEGIN
  FOR rec IN (
    SELECT l.LoanID, c.Name, l.EndDate
    FROM Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    WHERE l.EndDate <= SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Loan ' || rec.LoanID || ' for customer ' || rec.Name ||
                         ' is due on ' || TO_CHAR(rec.EndDate, 'YYYY-MM-DD'));
  END LOOP;
END;

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (7, 'Soon Due', TO_DATE('1975-11-10', 'YYYY-MM-DD'), 8000, SYSDATE);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (4, 7, 6000, 5, SYSDATE, SYSDATE + 20);