/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

SELECT f2.title
FROM film f1
JOIN film_actor fa1 ON (f1.film_id = fa1.film_id)
JOIN actor ON (fa1.actor_id = actor.actor_id)
JOIN film_actor fa2 ON (actor.actor_id = fa2.actor_id)
JOIN film f2 ON (fa2.film_id = f2.film_id)
WHERE f1.title = 'AMERICAN CIRCUS'
OR f1.title = 'ACADEMY DINOSAUR'
OR f1.title = 'AGENT TRUMAN'
GROUP BY f2.title
HAVING count(*) > 2
ORDER BY f2.title;
