/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT DISTINCT concat_ws(' ', a.first_name, a.last_name) AS "Actor Name"
FROM actor a
WHERE a.actor_id IN (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film_actor fa2 ON fa.film_id = fa2.film_id
    WHERE fa2.actor_id IN (
        SELECT DISTINCT a2.actor_id
        FROM actor a2
        JOIN film_actor fa3 USING (actor_id)
        JOIN film_actor fa4 ON fa3.film_id = fa4.film_id
        JOIN actor a3 ON fa4.actor_id = a3.actor_id
        WHERE a3.first_name = 'RUSSELL' AND a3.last_name = 'BACALL'
        AND NOT (a2.first_name = 'RUSSELL' AND a2.last_name = 'BACALL')
    )
)
AND NOT (a.first_name = 'RUSSELL' AND a.last_name = 'BACALL')
AND a.actor_id NOT IN (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film_actor fa2 ON fa.film_id = fa2.film_id
    JOIN actor a2 ON fa2.actor_id = a2.actor_id
    WHERE a2.first_name = 'RUSSELL' AND a2.last_name = 'BACALL'
)
ORDER BY "Actor Name";
