/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

SELECT f1.title FROM film f1
JOIN film_category fc USING (film_id)
JOIN film_category fc2 ON fc.category_id = fc2.category_id
JOIN film f2 ON fc2.film_id = f2.film_id
WHERE f2.title = 'AMERICAN CIRCUS'
GROUP BY f1.title
HAVING count(DISTINCT fc.category_id) >= 2

INTERSECT

SELECT f3.title FROM film f3
JOIN film_actor fa USING (film_id)
WHERE fa.actor_id IN (
    SELECT actor_id FROM film_actor
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
)

ORDER BY 1;
