create view base as
SELECT
	prod,
	sum(quant) as SUM_Q,
	month
FROM
	sales
GROUP BY
	prod,
	month
ORDER BY
	MONTH,
	prod;

create view MAX_MIN as
SELECT
	max(SUM_Q) as MAX_Q,
	min(SUM_Q) as MIN_Q,
	prod
FROM
	base
GROUP BY
	prod;

with MAX_Q as(
	SELECT
		base.prod,
		MAX_MIN.MAX_Q,
		base.month as MOST_FAV_MO,
		MAX_MIN.MIN_Q
	FROM
		base,
		MAX_MIN
	WHERE
		base.prod = MAX_MIN.prod
		and base.SUM_Q = MAX_MIN.MAX_Q
)
SELECT
	MAX_Q.prod,
	MAX_Q.max_q,
	MAX_Q.MOST_FAV_MO,
	MAX_Q.MIN_Q,
	base.month as LEAST_FAV_MO
FROM
	base,
	MAX_Q
WHERE
	base.prod = MAX_Q.prod
	and base.SUM_Q = MAX_Q.MIN_Q