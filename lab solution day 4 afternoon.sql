USE sakila;

-- 1) Write a query to display for each store its store ID, city, and country. --

SELECT s.store_id AS 'Store ID', c.city AS City, co.country AS Country FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country co
ON c.country_id = co.country_id;

-- 2) Write a query to display how much business, in dollars, each store brought in. -- 

SELECT s.store_id AS 'Store ID', SUM(p.amount) AS 'Business in dollars' FROM store s
JOIN staff st
ON s.store_id = st.store_id
JOIN payment p
ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- 3) Which film categories are longest? --

SELECT ca.name, SUM(f.length) AS 'Movie Length' FROM category ca
JOIN film_category fca
ON ca.category_id = fca.category_id
JOIN film f
ON fca.film_id = f.film_id
GROUP BY ca.name
ORDER BY SUM(f.length) DESC;

-- 4) Display the most frequently rented movies in descending order. --

SELECT f.title, COUNT(f.title) FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY (COUNT(f.title)) DESC;

-- 5) List the top five genres in gross revenue in descending order. -- 

SELECT cat.name as category, SUM(p.amount) as revenue from category cat 
JOIN film_category fc
ON cat.category_id = fc.category_id
JOIN inventory i
ON fc.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY cat.name
ORDER BY cat.name DESC;

-- 6) Is "Academy Dinosaur" available for rent from Store 1? I think so? Not sure about this one--

SELECT f.film_id, f.title, s.store_id, i.inventory_id FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN store s
ON i.store_id = s.store_id
JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE f.title = 'Academy Dinosaur' and s.store_id = 1
GROUP BY s.store_id;

-- 7) Get all pairs of actors that worked together. --
SELECT f1.film_id, f1.actor_id as actor_1, f2.actor_id as actor_2 FROM sakila.film_actor as f1
join sakila.film_actor as f2
on f1.actor_id < f2.actor_id
order by actor_1 asc;


-- 8) Get all pairs of customers that have rented the same film more than 3 times.

SELECT
    concat(c.first_name, " ", c.last_name), count(r.rental_id) as "Number of Rentals"
FROM
    customer c, rental r
WHERE 
    c.customer_id = r.customer_id
GROUP BY
    c.customer_id
HAVING count(r.rental_id) >= 3;


-- 9) For each film, list actor that has acted in more films. -- 

SELECT a.last_name, f.title, COUNT(a.last_name) AS 'Number of movies' FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
GROUP BY a.last_name
ORDER BY title; 






    