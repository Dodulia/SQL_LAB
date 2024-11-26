/*Відобразити інформацію про товари (ідентифікатор товару, назву товару, категорію). Перелік полів: Ідентифікатор
"Product ID" повинен формуватися з ідентифікатора співробітника з додаванням "0" довжиною 4 символи. Назва
товару як "Назва товару" повинна містити назву виробника, не містити номер моделі (без крапки після "/" в полі
product_name), формат: [виробник] :: [назва_продукту]. Категорія в полі "Категорія" повинна мати формат:
[тип_продукту] - [категорія] у верхньому регістрі. Будь ласка, відсортуйте дані за виробником. */
SELECT 
LPAD(product_id, 4, "0") AS 'Product ID',
CONCAT(manufacture, " :: ",  product_name) AS 'Product Name', 
CONCAT(UPPER(product_type), " - ", UPPER(category)) AS 'Category'
FROM  
 product
WHERE product_name NOT LIKE '%/%'
ORDER BY 
 manufacture;

/*Відобразити інформацію про пропродажі по місячно. Місяць "Month" повинен формуватися з місяця в якому
здійснювалися транзакції з додаванням "0" довжиною 2 символи. Загальна виручка as 'Total revenue' повинна
містити загальну суму продажей за кожен місяць. Квартал продажів as 'Sales Period' повинен містити порядковий
номер кварталу в році і відповідний рік, формат: 'Quater ' [квартал] - [рік]. Будь ласка, відсортуйте дані за датою
продажу.*/
SELECT 
LPAD(MONTH(transaction_moment), 2 , "0") AS 'Month',
FORMAT(SUM(o.quantity * p.price),2) AS 'Total revenue', 
CONCAT('Quarter', " ", QUARTER(transaction_moment), " - ", YEAR(transaction_moment)) AS 'Quarter'
FROM 
 orders o 
JOIN
 product p ON o.product_id = p.product_id
JOIN
 invoice i ON o.invoice_id = i.invoice_id
GROUP BY `Month`, `Quarter`
ORDER BY `Quarter`;


/*Відображення аналітичної інформації про продажі. 1) Відображення списку товарів, які принесли найбільший
дохід (більше 50000).*/
SELECT 
 p.product_id AS 'Product ID',
 p.product_name AS 'Product name', 
 p.price AS 'Product Price',
SUM(o.quantity) AS 'Product Quantity',
FORMAT(SUM(p.price * o.quantity),2) AS 'Total Amount' 
FROM 
 orders o
JOIN 
 product p ON o.product_id = p.product_id
GROUP BY `Product ID`
HAVING SUM(p.price * o.quantity) > 50000
ORDER BY `Product ID` ASC;


/*Відображення аналітичної інформації про продажі. 2) Відображення ТОП-10 покупців, які принесли найбільший дохід. Будь ласка, відсортуйте
дані по спаданні суми. */
SELECT 
LPAD(c.customer_id, 3, "0") AS 'Customer ID',
 last_name AS 'Customer last name',
 first_name AS 'Customer first name', 
FORMAT(SUM((price-discount) * quantity),2) AS 'Total Amount'
FROM 
 customer c
JOIN 
 invoice i ON i.customer_id = c.customer_id
JOIN 
 orders o ON o.invoice_id = i.invoice_id
JOIN
 product p ON o.product_id = p.product_id 
GROUP BY c.customer_id, last_name, first_name
ORDER BY SUM((price-discount) * quantity) DESC
LIMIT 10;


