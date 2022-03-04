SELECT
	customer as CUSTOMER,
	prod as PRODUCT,
	COALESCE(
		round(
			avg(
				case
					when month between 1
					and 3 then quant
				end
			),
			0
		),
		0
	) as Q1_AVG,
	COALESCE(
		round(
			avg(
				case
					when month between 4
					and 6 then quant
				end
			),
			0
		),
		0
	) as Q2_AVG,
	COALESCE(
		round(
			avg(
				case
					when month between 7
					and 9 then quant
				end
			),
			0
		),
		0
	) as Q3_AVG,
	COALESCE(
		round(
			avg(
				case
					when month between 10
					and 12 then quant
				end
			),
			0
		),
		0
	) as Q4_AVG,
	COALESCE(round(avg(quant), 0), 0) as AVERAGE,
	sum(quant) as TOTAL,
	count(quant) as COUNT
FROM
	sales
GROUP BY
	customer,
	prod