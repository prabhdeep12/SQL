USE sakila;
#1a
SELECT first_name, last_name
FROM actor;
#1b
SELECT UPPER(CONCAT(first_name, '', last_name)) AS 'Actor Name' 
FROM actor;
#2a
SELECT actor_id, first_name, last_name 
FROM actor WHERE first_name = 'Joe';  
#2b
SELECT * 
FROM actor 
WHERE last_name LIKE '%GEN%';
#2c
SELECT * 
FROM actor WHERE last_name LIKE '%LI%' 
ORDER BY last_name, first_name;
#2d
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan' , 'Bangladesh', 'China');
#3a
ALTER TABLE actor 
ADD COLUMN description BLOB;
#3b
ALTER TABLE actor 
DROP COLUMN description;
#4a
SELECT DISTINCT last_name, COUNT(last_name) AS 'Shared_Lastname_Count'
FROM actor
GROUP BY last_name;
#4b
SELECT DISTINCT last_name, COUNT(last_name) AS 'Shared_Lastname_Count'
FROM actor
GROUP BY last_name 
HAVING Shared_Lastname_Count >= 2 ;
#4c
UPDATE actor 
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
SELECT * FROM actor
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';
#4d
UPDATE actor
SET first_name = IF(first_name='HARPO', 'GROUCHO', 'MUCHO GROUCHO')
WHERE actor_id = 172;
#5a
SHOW CREATE TABLE address;
#6a
SELECT s.first_name, s.last_name, a.address, c.city, co.country
FROM staff AS s
LEFT JOIN address AS a
ON s.address_id = a.address_id
LEFT JOIN city AS c
ON a.city_id = c.city_id
LEFT JOIN country as co
ON c.country_id = co.country_id;
#6b
SELECT s.first_name, s.last_name, SUM(p.amount) AS 'Payment Received'
FROM staff s
INNER JOIN payment p
ON s.staff_id = p.staff_id
WHERE p.payment_date BETWEEN '20050801' AND '20050901'
GROUP BY s.staff_id;

SELECT title, COUNT(actor_id) AS 'Number of Actors'
FROM film f
INNER JOIN film_actor fa 
ON f.film_id = fa.film_id
GROUP BY title;
#6d
SELECT f.title, COUNT(f.title) AS num FROM film AS f
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';
GROUP BY f.title;
#6e
SELECT first_name, last_name, SUM(amount) AS 'Total Amount Paid'
FROM customer c
INNER JOIN payment p
ON c.Customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY last_name ASC;
#7a
SELECT title 
FROM film
WHERE language_id IN
(
    SELECT language_id 
    FROM language
    WHERE name = 'English'
    AND ((title LIKE 'K%') OR (title LIKE 'Q%'))
);
#7b
SELECT first_name, last_name
FROM actor a
WHERE actor_id IN
(SELECT actor_id FROM film_actor
 WHERE film_id IN 
    (SELECT film_id FROM film
     WHERE title = 'Alone Trip')
);
#7c
SELECT c.first_name, c.last_name, c.email
FROM customer c
INNER JOIN customer_list cl
ON c.customer_id = cl.ID
WHERE cl.country = 'Canada';
#8a
CREATE VIEW top5_genre_gross_revenue AS
SELECT c.name, SUM(p.amount) AS gross_revenue
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN inventory AS i
    ON fc.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
INNER JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY name
ORDER BY gross_revenue DESC
LIMIT 5;
#8b
SELECT * 
FROM top_five_genres;
#8c
DROP VIEW top_five_genres

