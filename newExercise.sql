-- ! QUERY CON GROUP BY

-- todo Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(`enrolment_date`) AS `year`, COUNT(*) AS `subscribe_year` 
FROM `students` 
GROUP BY YEAR(`enrolment_date`) 
ORDER BY `year`;

---------------------------------------------------------------------------------------------------------

-- todo Contare gli insegnanti che hanno l'ufficio nello stesso edificio