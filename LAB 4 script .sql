/*1. Дізнайтеся, які клієнти були зареєстровані в нашій компанії (показати всі доступні поля). Відсортуйте
список за Прізвищем.*/
SELECT 
  *
FROM 
  customer
ORDER BY
  last_name ASC;

/*2.Вивести унікальні назви виробників (manufacture ) з таблиці продуктів в одному запиті, впорядкованому
за алфавітом.*/
SELECT DISTINCT 
  manufacture 
FROM 
  product
ORDER BY 
  manufacture ASC;

/*3.Отримати коротку інформацію про продукти (назва_продукту, виробник, категорія, тип_продукту, ціна),
вироблені компанією 'DELL', з таблиці продуктів в одному запиті, впорядкованому за назвою продукту в
алфавітному порядку.*/
SELECT 
  product_name,
  manufacture, 
  product_type,
  price 
FROM 
  product
WHERE 
  manufacture = 'DELL'
ORDER BY 
  product_name ASC;

/*4.Отримати інформацію про клієнтів-жінок 1990-2000 років народження (ім'я, прізвище, стать, дата
народження, номер телефону) з таблиці customer в одному запиті, відсортовану за прізвищем в
алфавітному порядку.*/
SELECT 
  first_name, 
  last_name, 
  gender, 
  birth_date,
  phone_number 
FROM 
  customer 
WHERE 
   gender = 'f'
AND 
  birth_date 
BETWEEN 
'1990-01-01'
AND 
'2000-12-31'
ORDER BY 
  last_name ASC; 

/*5.Отримати інформацію з таблиці товарів про наявні на складі ноутбуки, які оснащені дисковими
накопичувачами об'ємом 512 ГБ.*/
SELECT 
  * 
FROM 
  product 
WHERE
  category = 'NOTEBOOK' 
AND
  product_description 
LIKE 
'%512GB%'
ORDER BY 
  product_name ASC; 

/*6.Отримати інформацію з таблиці товарів про наявні на складі ноутбуки або настільні комп'ютери, які
оснащені дисковими накопичувачами 512 ГБ або 1 ТБ.*/
SELECT 
  * 
FROM 
  product 
WHERE 
  (category = 'NOTEBOOK'
AND 
  product_description 
LIKE 
'%512GB SSD%'
OR
'%1TB SSD%')
OR 
  (category LIKE 'D%'
AND 
  product_description 
LIKE 
'%512GB SSD%'
OR
'%1TB SSD%')
ORDER BY 
  category ASC; 

/*7.Отримати інформацію з таблиці рахунків-фактур (invoice ) про всі покупки, зроблені неавторизованими
покупцями (customer_id NULL).*/
SELECT 
  * 
FROM 
  invoice 
WHERE 
  customer_id 
IS NULL; 













