-- ! QUERY CON GROUP BY

-- todo Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(`enrolment_date`) AS `year`, COUNT(*) AS `subscribe_year` 
FROM `students` 
GROUP BY YEAR(`enrolment_date`) 
ORDER BY `year`;

---------------------------------------------------------------------------------------------------------

-- todo Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT `office_address` AS `office`, COUNT(*) AS `teachers_in_same_office` 
FROM `teachers` 
GROUP BY `office_address`;

---------------------------------------------------------------------------------------------------------

-- todo Calcolare la media dei voti di ogni appello d'esame
SELECT `exams`.`date`, AVG(`exam_student`.`vote`) as `avarage_vote`
FROM `exams`
JOIN `exam_student`
ON `exams`.`id` = `exam_student`.`exam_id`
GROUP BY `exams`.`date`
ORDER BY `exams`.`date` ASC;

---------------------------------------------------------------------------------------------------------