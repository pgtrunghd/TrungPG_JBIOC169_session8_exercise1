CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price NUMERIC
);

INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES 
(1, 'Laptop', 1, 15000000),
(1, 'Chuột không dây', 2, 250000),
(1, 'Bàn phím cơ', 1, 1200000),
(2, 'Màn hình', 1, 3500000);

CREATE
OR REPLACE PROCEDURE calculate_order_total(order_id_input INT, OUT total NUMERIC) LANGUAGE plpgsql AS $$ BEGIN
SELECT
    SUM(quantity * unit_price) INTO total
FROM
    order_detail
WHERE
    order_id = order_id_input;
IF total IS NULL THEN total := 0;
END IF;
END;
$$;

DO $$
DECLARE
    result_total NUMERIC;
BEGIN
    CALL calculate_order_total(1, result_total);
    RAISE NOTICE 'Tổng giá trị đơn hàng là: %', result_total;
END;
$$;