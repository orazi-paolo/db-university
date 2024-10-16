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

-- todo Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT `departments`.`name` AS `departments`, COUNT(`degrees`.id) as `total_degrees` 
FROM `departments`
JOIN `degrees`
ON `departments`.`id` = `degrees`.`department_id`
GROUP BY `departments`.`name`;

---------------------------------------------------------------------------------------------------------

--! QUERY CON JOIN

-- todo Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name` AS `name_degree`
FROM `students`
JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia";

---------------------------------------------------------------------------------------------------------

-- todo Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT `degrees`.`name` AS `degrees_master_course`, `departments`.`name` AS `department` 
FROM `departments`
JOIN `degrees`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `degrees`.`name` LIKE "Corso di Laurea Magistrale%"
AND `departments`.`name` LIKE "Dipartimento di Neuroscienze%";

---------------------------------------------------------------------------------------------------------

-- todo Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `courses`.`name`, `courses`.`description`, `courses`.`period`, `courses`.`year`, `courses`.`cfu`
FROM `teachers`
JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
WHERE `teachers`.`id` = 44;

---------------------------------------------------------------------------------------------------------

-- todo Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT `students`.`surname`, `students`.`name`, `degrees`.`name` AS `degree_name`, `degrees`.`level`, `departments`.`name` AS `department_name`  
FROM `students` 
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`  
ORDER BY `students`.`surname` ASC, `students`.`name` ASC;

---------------------------------------------------------------------------------------------------------

-- todo Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name` AS `degree_name`, `courses`.`name` AS `courses_name`, `teachers`.`name` AS `teachers_name`, `teachers`.`surname` AS `teachers_surname` 
FROM `degrees`
JOIN `courses`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
ORDER BY `degree_name` ASC, `teachers_name` ASC, `teachers_surname` ASC;

---------------------------------------------------------------------------------------------------------

-- todo  Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT `teachers`.`id`, `teachers`.`name`, `teachers`.`surname`, `departments`.`name` AS `department_name` 
FROM `teachers`
JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = "Dipartimento di Matematica"
ORDER BY `name` ASC, `surname` ASC;

---------------------------------------------------------------------------------------------------------

-- todo BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.

SELECT `students`.`name` AS `students_name`, `students`.`surname` AS `students_surname`, `courses`.`name` AS `courses_name`, COUNT(`courses`.name) AS `courses_count`, MAX(`exam_student`.`vote`) AS `best_vote`
FROM `students`
JOIN `exam_student`
ON `students`.`id` = `exam_student`.`student_id`
JOIN `exams`
ON `exams`.`id` = `exam_student`.`exam_id`
JOIN `courses`
ON `courses`.`id` = `exams`.`course_id`
GROUP BY `students_name`, `students_surname`, `courses_name`
HAVING `best_vote`> 18
ORDER BY `students_name`;