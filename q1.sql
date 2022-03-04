with min_q as(
	with base as(
		SELECT
			customer,
			min(quant) as MIN_Q,
			max(quant) as MAX_Q,
			round (avg(quant), 0) as AVG_Q
		FROM
			sales
		GROUP BY
			customer
	)
	SELECT
		base.customer,
		base.MIN_Q,
		sales.prod as MIN_PROD,
		sales.month as MIN_MONTH,
		sales.day as MIN_DAY,
		sales.year as MIN_YEAR,
		sales.state as MIN_ST,
		base.MAX_Q,
		base.AVG_Q
	FROM
		sales,
		base
	WHERE
		sales.customer = base.customer
		and sales.quant = base.MIN_Q
)
SELECT
	min_q.customer,
	min_q.MIN_Q,
	min_q.MIN_PROD,
	min_q.MIN_MONTH,
	min_q.MIN_DAY,
	min_q.MIN_YEAR,
	min_q.MIN_ST,
	min_q.MAX_Q,
	sales.prod as MAX_PROD,
	sales.month as MAX_MONTH,
	sales.day as MAX_DAY,
	sales.year as MAX_YEAR,
	sales.state as MAX_ST,
	min_q.AVG_Q
FROM
	sales,
	min_q
WHERE
	sales.customer = min_q.customer
	and sales.quant = min_q.MAX_Q