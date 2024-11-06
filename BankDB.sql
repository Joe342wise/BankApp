-- CREATE DATABASE dbBank;
-- USE dbBank-- 


CREATE TABLE tblCustomers (
    custId INT AUTO_INCREMENT PRIMARY KEY,
    custName VARCHAR(100) NOT NULL,
    custEmail VARCHAR(100) UNIQUE NOT NULL,
    custPhone VARCHAR(15) UNIQUE NOT NULL,
    custAddress TEXT,
    custDOB DATE,
    custCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    custUpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE tblAccounts (
    acntId INT AUTO_INCREMENT PRIMARY KEY,
    custId INT NOT NULL,
    acntType ENUM('Savings', 'Checking') NOT NULL,
    acntBalance DECIMAL(15, 2) DEFAULT 0.00,
    acntStatus ENUM('Active', 'Closed') DEFAULT 'Active',
    acntCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    acntUpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (custId) REFERENCES tblCustomers(custId) ON DELETE CASCADE
);

CREATE TABLE tblTransactions (
    transId INT AUTO_INCREMENT PRIMARY KEY,
    acntId INT NOT NULL,
    transType ENUM('Deposit', 'Withdrawal', 'Transfer') NOT NULL,
    transAmount DECIMAL(15, 2) NOT NULL,
    transBalanceAfter DECIMAL(15, 2),
    transDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    transDescription TEXT,
    FOREIGN KEY (acntId) REFERENCES tblAccounts(acntId) ON DELETE CASCADE
);

CREATE TABLE tblCards (
    cardId INT AUTO_INCREMENT PRIMARY KEY,
    acntId INT NOT NULL,
    cardNumber VARCHAR(16) UNIQUE NOT NULL,
    cardExpiryDate DATE NOT NULL,
    cardType ENUM('Debit', 'Credit') NOT NULL,
    cardStatus ENUM('Active', 'Blocked') DEFAULT 'Active',
    cardCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cardUpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (acntId) REFERENCES tblAccounts(acntId) ON DELETE CASCADE
);

CREATE TABLE tblLoans (
    loanId INT AUTO_INCREMENT PRIMARY KEY,
    custId INT NOT NULL,
    loanAmount DECIMAL(15, 2) NOT NULL,
    loanType ENUM('Personal', 'Mortgage') NOT NULL,
    loanInterestRate DECIMAL(5, 2) NOT NULL,
    loanDueDate DATE,
    loanStatus ENUM('Active', 'Paid') DEFAULT 'Active',
    loanCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (custId) REFERENCES tblCustomers(custId) ON DELETE CASCADE
);

CREATE TABLE tblUserAuthentications (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    custId INT NOT NULL,
    userName VARCHAR(50) UNIQUE NOT NULL,
    userPasswordHash VARCHAR(255) NOT NULL,
    userLastLogin TIMESTAMP NULL,
    userIsActive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (custId) REFERENCES tblCustomers(custId) ON DELETE CASCADE
);

CREATE TABLE tblBranches (
    branchId INT AUTO_INCREMENT PRIMARY KEY,
    branchName VARCHAR(100) NOT NULL,
    branchAddress TEXT NOT NULL,
    branchPhone VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE tblAuditLogs (
    auditLogId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    auditAction TEXT NOT NULL,
    auditTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    auditIpAddress VARCHAR(45),
    FOREIGN KEY (userId) REFERENCES tblUserAuthentications(userId) ON DELETE CASCADE
);
