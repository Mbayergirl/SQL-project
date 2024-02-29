/*
ASSIGNMENT
1. Find the name of merchants having total transaction amount of more than 2000

2. Find the names of customers with total transaction amount greater than 2000

3. Find the average of transactions grouped by month.

4. Find the customer transactions that occurred at the merchant named Baker Inc.

5. Find the name of card holder(s) that performed transactions with card starting with ‘486’.

DUE DATE - 5th August, 2023 at 12:00noon.
*/


SELECT * FROM customer_transaction;
SELECT * FROM merchant;
SELECT * FROM merchant_category;
SELECT * FROM credit_card;
SELECT * FROM card_holder;


--- Find the name of merchants having total transaction amount of more than 2000

SELECT merchant_name, SUM(ct.amount) AS total_amount
FROM customer_transaction AS ct
INNER JOIN merchant AS mt
ON ct.id_merchant = mt.id
GROUP BY merchant_name
HAVING SUM (ct.amount) >= 2000;

---  Find the names of customers with total transaction amount greater than 2000

SELECT ch.card_holder_name AS customer, SUM(ct.amount) AS total_amount
FROM card_holder AS ch
INNER JOIN credit_card AS cc
ON ch.id =cc.id_card_holder
INNER JOIN customer_transaction AS ct
ON ct.card = cc.card
GROUP BY card_holder_name
HAVING SUM(ct.amount) > 2000
ORDER BY SUM(ct.amount) DESC;

---Find the average of transactions grouped by month
	   
SELECT 
EXTRACT(MONTH FROM date) AS transaction_month,
AVG(amount) AS average_amount
FROM customer_transaction
GROUP BY transaction_month
ORDER BY transaction_month ASC;

--- Find the customer transactions that occurred at the merchant named Baker Inc.

SELECT ct.id, ct.date, ct.amount, ct.card, mt.merchant_name, mc.merchant_category_name
FROM customer_transaction ct
JOIN merchant mt
ON ct.id_merchant = mt.id
JOIN merchant_category mc
ON mt.id_merchant_category = mc.id
WHERE mt.merchant_name = 'Baker Inc';

---Find the name of card holder(s) that performed transactions with card starting with ‘486’.

SELECT ch.card_holder_name, cc.card, cc.id_card_holder, ct.amount, date 
FROM customer_transaction ct
JOIN credit_card cc
ON ct.card = cc.card
JOIN card_holder ch
ON ch.id = cc.id_card_holder
WHERE ct.card LIKE '486%';
