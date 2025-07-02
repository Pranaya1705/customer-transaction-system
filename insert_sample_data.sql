-- insert_sample_data.sql

-- Insert into customers
INSERT INTO customers (customer_id, customer_name, email) VALUES (1, 'Rohit Sharma', 'rohit@example.com');
INSERT INTO customers (customer_id, customer_name, email) VALUES (2, 'Anjali Verma', 'anjali@example.com');
INSERT INTO customers (customer_id, customer_name, email) VALUES (3, 'Amit Das', 'amit@example.com');

-- Insert into accounts
INSERT INTO accounts (account_id, customer_id, balance, status) VALUES (101, 1, 15000.00, 'ACTIVE');
INSERT INTO accounts (account_id, customer_id, balance, status) VALUES (102, 2, 10000.00, 'ACTIVE');
INSERT INTO accounts (account_id, customer_id, balance, status) VALUES (103, 3, 20000.00, 'INACTIVE');
