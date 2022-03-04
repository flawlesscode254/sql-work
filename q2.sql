with base as (
	SELECT
		prod,
		month,
		sum(quant) as sum_q
	FROM
		sales
	GROUP BY
		prod,
		month
),
MAX_MIN as (
	SELECT
		max(sum_q) as MOST_POP_TOTAL_Q,
		min(sum_q) as LEAST_POP_TOTAL_Q,
		month
	FROM
		base
	GROUP BY
		month
),
MAX as(
	SELECT
		MAX_MIN.month,
		MAX_MIN.MOST_POP_TOTAL_Q,
		MAX_MIN.LEAST_POP_TOTAL_Q,
		base.prod as MOST_POPULAR_PROD
	FROM
		MAX_MIN,
		base
	WHERE
		MAX_MIN.month = base.month
		and base.sum_q = MAX_MIN.MOST_POP_TOTAL_Q
)
SELECT
	MAX.month,
	MAX.MOST_POPULAR_PROD,
	MAX.MOST_POP_TOTAL_Q,
	base.prod as LEAST_POPULAR_PROD,
	MAX.LEAST_POP_TOTAL_Q
FROM
	MAX,
	base
WHERE
	MAX.month = base.month
	and MAX.LEAST_POP_TOTAL_Q = base.sum_q
ORDER BY
	MAX.month