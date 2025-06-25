-- Scenario 1: The bank needs to process monthly interest for all savings accounts


CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
  FOR acc IN (
    SELECT AccountID, Balance
    FROM Accounts
    WHERE AccountType = 'Savings'
  ) LOOP
    UPDATE Accounts
    SET Balance = acc.Balance * 1.01,
        LastModified = SYSDATE
    WHERE AccountID = acc.AccountID;
  END LOOP;

  COMMIT;
END;


EXEC ProcessMonthlyInterest;

SELECT AccountID, AccountType, Balance FROM Accounts;


-- Scenario 2: Implement a bonus scheme for employees based on their performance

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
  p_Department IN VARCHAR2,
  p_BonusPercent IN NUMBER
) IS
BEGIN
  FOR emp IN (
    SELECT EmployeeID, Salary
    FROM Employees
    WHERE Department = p_Department
  ) LOOP
    UPDATE Employees
    SET Salary = emp.Salary * (1 + p_BonusPercent / 100)
    WHERE EmployeeID = emp.EmployeeID;
  END LOOP;

  COMMIT;
END;


EXEC UpdateEmployeeBonus('IT', 10);

SELECT Name, Department, Salary FROM Employees;



-- Scenario 3: Transfer funds between accounts

CREATE OR REPLACE PROCEDURE TransferFunds (
  p_FromAccountID IN NUMBER,
  p_ToAccountID IN NUMBER,
  p_Amount IN NUMBER
) IS
  v_FromBalance NUMBER;
BEGIN
  -- Check balance
  SELECT Balance INTO v_FromBalance
  FROM Accounts
  WHERE AccountID = p_FromAccountID;

  IF v_FromBalance >= p_Amount THEN
    -- Deduct from source
    UPDATE Accounts
    SET Balance = Balance - p_Amount,
        LastModified = SYSDATE
    WHERE AccountID = p_FromAccountID;

    -- Add to destination
    UPDATE Accounts
    SET Balance = Balance + p_Amount,
        LastModified = SYSDATE
    WHERE AccountID = p_ToAccountID;

    COMMIT;
  ELSE
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in source account.');
  END IF;
END;

EXEC TransferFunds(1, 2, 200);

SELECT AccountID, Balance FROM Accounts;