/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title, f.rank, f.revenue
FROM actor a
JOIN LATERAL (
    SELECT f.film_id, f.title, sum(p.amount) AS revenue,
           rank() OVER (ORDER BY sum(p.amount) DESC, f.film_id) AS rank
    FROM film_actor fa
    JOIN film f USING (film_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
    JOIN payment p USING (rental_id)
    WHERE fa.actor_id = a.actor_id
    GROUP BY f.film_id, f.title
) AS f ON f.rank <= 3
ORDER BY a.actor_id, f.revenue DESC;
