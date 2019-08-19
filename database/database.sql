-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Фев 06 2019 г., 04:25
-- Версия сервера: 5.7.21-20-beget-5.7.21-20-1-log
-- Версия PHP: 5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `c911161l_tele`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Official_telephone`
--
-- Создание: Янв 31 2019 г., 10:59
--

DROP TABLE IF EXISTS `Official_telephone`;
CREATE TABLE `Official_telephone` (
  `id` int(100) NOT NULL,
  `id_substructr` int(100) NOT NULL,
  `number` varchar(120) NOT NULL,
  `type` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `Place`
--
-- Создание: Фев 05 2019 г., 15:55
--

DROP TABLE IF EXISTS `Place`;
CREATE TABLE `Place` (
  `id` int(100) NOT NULL,
  `name` varchar(120) NOT NULL,
  `type` varchar(120) NOT NULL,
  `endpoint` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `Structur`
--
-- Создание: Янв 29 2019 г., 11:30
--

DROP TABLE IF EXISTS `Structur`;
CREATE TABLE `Structur` (
  `id` int(100) NOT NULL,
  `id_place` int(100) NOT NULL,
  `name` varchar(120) NOT NULL,
  `adress` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `Substructur`
--
-- Создание: Янв 29 2019 г., 11:41
--

DROP TABLE IF EXISTS `Substructur`;
CREATE TABLE `Substructur` (
  `id` int(100) NOT NULL,
  `id_structur` int(100) NOT NULL,
  `name` varchar(120) NOT NULL,
  `type` varchar(120) NOT NULL,
  `adress` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `Telephone`
--
-- Создание: Янв 15 2019 г., 11:44
--

DROP TABLE IF EXISTS `Telephone`;
CREATE TABLE `Telephone` (
  `id` int(100) NOT NULL,
  `surname` varchar(120) NOT NULL,
  `name` varchar(120) NOT NULL,
  `middle_name` varchar(120) NOT NULL,
  `id_place` int(100) NOT NULL,
  `address` varchar(120) NOT NULL,
  `number_telephone` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `view_Structur`
-- (См. Ниже фактическое представление)
--
DROP VIEW IF EXISTS `view_Structur`;
CREATE TABLE `view_Structur` (
`id` int(100)
,`name` varchar(120)
,`adress` varchar(120)
,`place` varchar(120)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `view_Substructur`
-- (См. Ниже фактическое представление)
--
DROP VIEW IF EXISTS `view_Substructur`;
CREATE TABLE `view_Substructur` (
`id` int(100)
,`id_structur` int(100)
,`name` varchar(120)
,`type` varchar(120)
,`adress` varchar(120)
,`number` varchar(258)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `view_Telephone`
-- (См. Ниже фактическое представление)
--
DROP VIEW IF EXISTS `view_Telephone`;
CREATE TABLE `view_Telephone` (
`id` int(100)
,`surname` varchar(120)
,`name` varchar(120)
,`middle_name` varchar(120)
,`address` varchar(120)
,`number_telephone` varchar(120)
,`place` varchar(120)
);

-- --------------------------------------------------------

--
-- Структура для представления `view_Structur`
--
DROP TABLE IF EXISTS `view_Structur`;

CREATE ALGORITHM=UNDEFINED DEFINER=`c911161l_tele`@`localhost` SQL SECURITY DEFINER VIEW `view_Structur`  AS  select `S`.`id` AS `id`,`S`.`name` AS `name`,`S`.`adress` AS `adress`,`P`.`name` AS `place` from (`Structur` `S` join `Place` `P` on((`S`.`id_place` = `P`.`id`))) ;

-- --------------------------------------------------------

--
-- Структура для представления `view_Substructur`
--
DROP TABLE IF EXISTS `view_Substructur`;

CREATE ALGORITHM=UNDEFINED DEFINER=`c911161l_tele`@`localhost` SQL SECURITY DEFINER VIEW `view_Substructur`  AS  select `S`.`id` AS `id`,`S`.`id_structur` AS `id_structur`,`S`.`name` AS `name`,`S`.`type` AS `type`,`S`.`adress` AS `adress`,concat('[',group_concat(distinct (select if((`T`.`number` is not null),json_object(`T`.`type`,`T`.`number`),NULL)) order by `T`.`type` ASC separator ','),']') AS `number` from (`Substructur` `S` left join `Official_telephone` `T` on((`T`.`id_substructr` = `S`.`id`))) group by `S`.`id` ;

-- --------------------------------------------------------

--
-- Структура для представления `view_Telephone`
--
DROP TABLE IF EXISTS `view_Telephone`;

CREATE ALGORITHM=UNDEFINED DEFINER=`c911161l_tele`@`localhost` SQL SECURITY DEFINER VIEW `view_Telephone`  AS  select `T`.`id` AS `id`,`T`.`surname` AS `surname`,`T`.`name` AS `name`,`T`.`middle_name` AS `middle_name`,`T`.`address` AS `address`,`T`.`number_telephone` AS `number_telephone`,`P`.`name` AS `place` from (`Telephone` `T` join `Place` `P` on((`T`.`id_place` = `P`.`id`))) ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Official_telephone`
--
ALTER TABLE `Official_telephone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_department` (`id_substructr`);

--
-- Индексы таблицы `Place`
--
ALTER TABLE `Place`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Structur`
--
ALTER TABLE `Structur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_place` (`id_place`);

--
-- Индексы таблицы `Substructur`
--
ALTER TABLE `Substructur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_structur` (`id_structur`);

--
-- Индексы таблицы `Telephone`
--
ALTER TABLE `Telephone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_place` (`id_place`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Official_telephone`
--
ALTER TABLE `Official_telephone`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `Place`
--
ALTER TABLE `Place`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `Structur`
--
ALTER TABLE `Structur`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT для таблицы `Substructur`
--
ALTER TABLE `Substructur`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `Telephone`
--
ALTER TABLE `Telephone`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Official_telephone`
--
ALTER TABLE `Official_telephone`
  ADD CONSTRAINT `Official_telephone_ibfk_1` FOREIGN KEY (`id_substructr`) REFERENCES `Substructur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Structur`
--
ALTER TABLE `Structur`
  ADD CONSTRAINT `Structur_ibfk_1` FOREIGN KEY (`id_place`) REFERENCES `Place` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Substructur`
--
ALTER TABLE `Substructur`
  ADD CONSTRAINT `Substructur_ibfk_1` FOREIGN KEY (`id_structur`) REFERENCES `Structur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Telephone`
--
ALTER TABLE `Telephone`
  ADD CONSTRAINT `Telephone_ibfk_1` FOREIGN KEY (`id_place`) REFERENCES `Place` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
