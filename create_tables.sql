-- create_tables.sql

CREATE TABLE customers (
    customer_id      NUMBER PRIMARY KEY,
    customer_name    VARCHAR2(100),
    email            VARCHAR2(100)
);

CREATE TABLE accounts (
    account_id       NUMBER PRIMARY KEY,
    customer_id      NUMBER,
    balance          NUMBER(12, 2),
    status           VARCHAR2(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
    transaction_id   NUMBER PRIMARY KEY,
    account_id       NUMBER,
    txn_type         VARCHAR2(20), -- 'DEPOSIT' or 'WITHDRAWAL'
    amount           NUMBER(10, 2),
    txn_date         DATE DEFAULT SYSDATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE error_log (
    error_id         NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    error_message    VARCHAR2(4000),
    error_time       DATE DEFAULT SYSDATE,
    procedure_name   VARCHAR2(100)
);
