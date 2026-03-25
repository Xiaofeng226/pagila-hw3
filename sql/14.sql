/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */



SELECT c.name, f.title, f.rentals AS "total rentals"
FROM category c
JOIN LATERAL (
    SELECT f.title, f.film_id, count(r.rental_id) AS rentals,
           rank() OVER (ORDER BY count(r.rental_id) DESC, f.film_id DESC) AS rank
    FROM film_category fc
    JOIN film f USING (film_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
    WHERE fc.category_id = c.category_id
    GROUP BY f.film_id, f.title
) AS f ON f.rank <= 5
ORDER BY c.name, f.rentals DESC, f.film_id ASC;
