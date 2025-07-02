-- transaction_proc.sql

CREATE OR REPLACE PROCEDURE process_transaction (
    p_account_id IN accounts.account_id%TYPE,
    p_txn_type   IN VARCHAR2,
    p_amount     IN NUMBER
)
IS
    v_balance        accounts.balance%TYPE;
    v_status         accounts.status%TYPE;
    v_error_message  VARCHAR2(4000);
BEGIN
    -- Get account status and balance
    SELECT balance, status
    INTO v_balance, v_status
    FROM accounts
    WHERE account_id = p_account_id;

    -- Check account status
    IF v_status != 'ACTIVE' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Account is not active');
    END IF;

    -- Process transaction
    IF p_txn_type = 'DEPOSIT' THEN
        UPDATE accounts
        SET balance = balance + p_amount
        WHERE account_id = p_account_id;

    ELSIF p_txn_type = 'WITHDRAWAL' THEN
        IF v_balance < p_amount THEN
            RAISE_APPLICATION_ERROR(-20002, 'Insufficient balance');
        END IF;

        UPDATE accounts
        SET balance = balance - p_amount
        WHERE account_id = p_account_id;

    ELSE
        RAISE_APPLICATION_ERROR(-20003, 'Invalid transaction type');
    END IF;

    -- Log the transaction
    INSERT INTO transactions (transaction_id, account_id, txn_type, amount, txn_date)
    VALUES (transactions_seq.NEXTVAL, p_account_id, p_txn_type, p_amount, SYSDATE);

EXCEPTION
    WHEN OTHERS THEN
        v_error_message := SQLERRM;
        INSERT INTO error_log (error_message, procedure_name)
        VALUES (v_error_message, 'process_transaction');
        RAISE;
END;
/
