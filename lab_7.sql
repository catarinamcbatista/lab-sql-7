# Lab | SQL Queries 7

USE sakila;

# Which last names are not repeated?
SELECT last_name, count(last_name) AS last_total FROM sakila.actor GROUP BY last_name HAVING last_total = 1;

# Which last names appear more than once?
SELECT last_name, count(last_name) AS last_total FROM sakila.actor GROUP BY last_name HAVING last_total > 1;

# Rentals by employee.
SELECT staff_id, count(rental_id) AS total_rental from sakila.rental group by staff_id;

# Films by year.
SELECT release_year, count(title) AS films_year from sakila.film group by release_year;

# Films by rating.
SELECT rating, count(title) as films_rating from sakila.film group by rating;

# Mean length by rating.
SELECT rating, avg(length) as avg_length from sakila.film group by rating;

# Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, avg(length) as avg_length from sakila.film group by rating having avg_length > 120;

# List movies and add information of average duration for their rating and original language.
SELECT title, rating, original_language_id, avg(length) over(partition by rating) as avg_rating, 
avg(length) over(partition by original_language_id) as avg_language, 
avg(length) over(partition by title) as avg_title FROM sakila.film;

# Which rentals are longer than expected?
SELECT rental_id, DATEDIFF(return_date, rental_date) AS 'total_rental', 
AVG(DATEDIFF(return_date, rental_date)) OVER (PARTITION BY rental_id) AS 'avg_rental' 
FROM sakila.rental 
WHERE 'total_rental'>'avg_rental';

#after felipe explanation
select * from (select inventory_id, rental_id, datediff(return_date, rental_date) rental_duration, avg(datediff(return_date, rental_date)) 
over (partition by inventory_id) average from rental) as smth where rental_duration > average;



