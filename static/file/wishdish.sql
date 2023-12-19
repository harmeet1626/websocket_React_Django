-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 22, 2023 at 04:00 PM
-- Server version: 5.7.34-0ubuntu0.18.04.1
-- PHP Version: 7.1.33-3+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wishdish`
--

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_category`
--

CREATE TABLE `adminuser_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `categoryImage` varchar(100) DEFAULT NULL,
  `description` longtext,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser_category`
--

INSERT INTO `adminuser_category` (`id`, `name`, `categoryImage`, `description`, `is_active`) VALUES
(1, 'Beef', 'https://www.themealdb.com/images/category/beef.png', NULL, 1),
(2, 'Chicken', 'https://www.themealdb.com/images/category/chicken.png', NULL, 1),
(4, 'Lamb', 'https://www.themealdb.com/images/category/lamb.png', NULL, 1),
(6, 'Pasta', 'https://www.themealdb.com/images/category/pasta.png', NULL, 1),
(7, 'Pork', 'https://www.themealdb.com/images/category/pork.png', NULL, 1),
(9, 'Side', 'https://www.themealdb.com/images/category/side.png', NULL, 1),
(10, 'Starter', 'https://www.themealdb.com/images/category/starter.png', NULL, 1),
(11, 'Vegan', 'https://www.themealdb.com/images/category/vegan.png', NULL, 1),
(12, 'Vegetarian', 'https://www.themealdb.com/images/category/vegetarian.png', NULL, 1),
(13, 'Breakfast', 'static/category/pngimg.com_-_breakfast_PNG24.png', NULL, 1),
(14, 'Goat', 'static/category/pngwing.com_1.png', NULL, 1),
(15, 'Dessert', 'https://www.themealdb.com/images/category/dessert.png', NULL, 1),
(16, 'Miscellaneous', 'https://www.themealdb.com/images/category/miscellaneous.png', NULL, 1),
(17, 'Seafood', 'https://www.themealdb.com/images/category/seafood.png', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_comments`
--

CREATE TABLE `adminuser_comments` (
  `id` bigint(20) NOT NULL,
  `comment` varchar(3500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `likes` int(11) NOT NULL,
  `dislikes` int(11) NOT NULL,
  `creation_date` date NOT NULL,
  `recipe_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adminuser_comments`
--

INSERT INTO `adminuser_comments` (`id`, `comment`, `likes`, `dislikes`, `creation_date`, `recipe_id`, `user_id`) VALUES
(1, 'nice recipe ??', 0, 0, '2023-08-16', 18, 2);

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_commentsdislike`
--

CREATE TABLE `adminuser_commentsdislike` (
  `id` bigint(20) NOT NULL,
  `dislike` tinyint(1) NOT NULL,
  `comments_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_commentslike`
--

CREATE TABLE `adminuser_commentslike` (
  `id` bigint(20) NOT NULL,
  `like` tinyint(1) NOT NULL,
  `comments_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_favourites`
--

CREATE TABLE `adminuser_favourites` (
  `id` bigint(20) NOT NULL,
  `recipe_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser_favourites`
--

INSERT INTO `adminuser_favourites` (`id`, `recipe_id`, `user_id`) VALUES
(1, 26, 2),
(2, 17, 3),
(4, 92, 7),
(5, 103, 8);

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_ingredient`
--

CREATE TABLE `adminuser_ingredient` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `id_ingrediant` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser_ingredient`
--

INSERT INTO `adminuser_ingredient` (`id`, `name`, `image`, `id_ingrediant`, `is_active`) VALUES
(1, 'Chicken', 'http://www.themealdb.com/images/ingredients/Chicken.png', '1', 1),
(2, 'Salmon', 'http://www.themealdb.com/images/ingredients/Salmon.png', '2', 1),
(3, 'Beef', 'http://www.themealdb.com/images/ingredients/Beef.png', '3', 1),
(4, 'Pork', 'http://www.themealdb.com/images/ingredients/Pork.png', '4', 1),
(5, 'Avocado', 'http://www.themealdb.com/images/ingredients/Avocado.png', '5', 1),
(6, 'Apple Cider Vinegar', 'http://www.themealdb.com/images/ingredients/Apple Cider Vinegar.png', '9', 1),
(7, 'Asparagus', 'http://www.themealdb.com/images/ingredients/Asparagus.png', '10', 1),
(8, 'Aubergine', 'http://www.themealdb.com/images/ingredients/Aubergine.png', '11', 1),
(9, 'Baby Plum Tomatoes', 'http://www.themealdb.com/images/ingredients/Baby Plum Tomatoes.png', '13', 1),
(10, 'Bacon', 'http://www.themealdb.com/images/ingredients/Bacon.png', '14', 1),
(11, 'Baking Powder', 'http://www.themealdb.com/images/ingredients/Baking Powder.png', '15', 1),
(12, 'Balsamic Vinegar', 'http://www.themealdb.com/images/ingredients/Balsamic Vinegar.png', '16', 1),
(13, 'Basil', 'http://www.themealdb.com/images/ingredients/Basil.png', '17', 1),
(14, 'Basil Leaves', 'http://www.themealdb.com/images/ingredients/Basil Leaves.png', '18', 1),
(15, 'Basmati Rice', 'http://www.themealdb.com/images/ingredients/Basmati Rice.png', '19', 1),
(16, 'Bay Leaf', 'http://www.themealdb.com/images/ingredients/Bay Leaf.png', '20', 1),
(17, 'Bay Leaves', 'http://www.themealdb.com/images/ingredients/Bay Leaves.png', '21', 1),
(18, 'Beef Brisket', 'http://www.themealdb.com/images/ingredients/Beef Brisket.png', '23', 1),
(19, 'Beef Fillet', 'http://www.themealdb.com/images/ingredients/Beef Fillet.png', '24', 1),
(20, 'Beef Gravy', 'http://www.themealdb.com/images/ingredients/Beef Gravy.png', '25', 1),
(21, 'Beef Stock', 'http://www.themealdb.com/images/ingredients/Beef Stock.png', '26', 1),
(22, 'Bicarbonate Of Soda', 'http://www.themealdb.com/images/ingredients/Bicarbonate Of Soda.png', '27', 1),
(23, 'Biryani Masala', 'http://www.themealdb.com/images/ingredients/Biryani Masala.png', '28', 1),
(24, 'Black Pepper', 'http://www.themealdb.com/images/ingredients/Black Pepper.png', '29', 1),
(25, 'Black Treacle', 'http://www.themealdb.com/images/ingredients/Black Treacle.png', '30', 1),
(26, 'Borlotti Beans', 'http://www.themealdb.com/images/ingredients/Borlotti Beans.png', '31', 1),
(27, 'Bowtie Pasta', 'http://www.themealdb.com/images/ingredients/Bowtie Pasta.png', '32', 1),
(28, 'Bramley Apples', 'http://www.themealdb.com/images/ingredients/Bramley Apples.png', '33', 1),
(29, 'Brandy', 'http://www.themealdb.com/images/ingredients/Brandy.png', '34', 1),
(30, 'Bread', 'http://www.themealdb.com/images/ingredients/Bread.png', '35', 1),
(31, 'Breadcrumbs', 'http://www.themealdb.com/images/ingredients/Breadcrumbs.png', '36', 1),
(32, 'Broccoli', 'http://www.themealdb.com/images/ingredients/Broccoli.png', '37', 1),
(33, 'Brown Lentils', 'http://www.themealdb.com/images/ingredients/Brown Lentils.png', '38', 1),
(34, 'Brown Rice', 'http://www.themealdb.com/images/ingredients/Brown Rice.png', '39', 1),
(35, 'Brown Sugar', 'http://www.themealdb.com/images/ingredients/Brown Sugar.png', '40', 1),
(36, 'Butter', 'http://www.themealdb.com/images/ingredients/Butter.png', '41', 1),
(37, 'Cacao', 'http://www.themealdb.com/images/ingredients/Cacao.png', '43', 1),
(38, 'Cajun', 'http://www.themealdb.com/images/ingredients/Cajun.png', '44', 1),
(39, 'Canned Tomatoes', 'http://www.themealdb.com/images/ingredients/Canned Tomatoes.png', '45', 1),
(40, 'Cannellini Beans', 'http://www.themealdb.com/images/ingredients/Cannellini Beans.png', '46', 1),
(41, 'Cardamom', 'http://www.themealdb.com/images/ingredients/Cardamom.png', '47', 1),
(42, 'Carrots', 'http://www.themealdb.com/images/ingredients/Carrots.png', '49', 1),
(43, 'Cashew Nuts', 'http://www.themealdb.com/images/ingredients/Cashew Nuts.png', '50', 1),
(44, 'Cashews', 'http://www.themealdb.com/images/ingredients/Cashews.png', '51', 1),
(45, 'Caster Sugar', 'http://www.themealdb.com/images/ingredients/Caster Sugar.png', '52', 1),
(46, 'Cayenne Pepper', 'http://www.themealdb.com/images/ingredients/Cayenne Pepper.png', '53', 1),
(47, 'Celeriac', 'http://www.themealdb.com/images/ingredients/Celeriac.png', '54', 1),
(48, 'Celery', 'http://www.themealdb.com/images/ingredients/Celery.png', '55', 1),
(49, 'Celery Salt', 'http://www.themealdb.com/images/ingredients/Celery Salt.png', '56', 1),
(50, 'Challots', 'http://www.themealdb.com/images/ingredients/Challots.png', '57', 1),
(51, 'Charlotte Potatoes', 'http://www.themealdb.com/images/ingredients/Charlotte Potatoes.png', '58', 1),
(52, 'Cheddar Cheese', 'http://www.themealdb.com/images/ingredients/Cheddar Cheese.png', '59', 1),
(53, 'Cheese', 'http://www.themealdb.com/images/ingredients/Cheese.png', '60', 1),
(54, 'Cheese Curds', 'http://www.themealdb.com/images/ingredients/Cheese Curds.png', '61', 1),
(55, 'Cherry Tomatoes', 'http://www.themealdb.com/images/ingredients/Cherry Tomatoes.png', '62', 1),
(56, 'Chestnut Mushroom', 'http://www.themealdb.com/images/ingredients/Chestnut Mushroom.png', '63', 1),
(57, 'Chicken Breast', 'http://www.themealdb.com/images/ingredients/Chicken Breast.png', '65', 1),
(58, 'Chicken Breasts', 'http://www.themealdb.com/images/ingredients/Chicken Breasts.png', '66', 1),
(59, 'Chicken Legs', 'http://www.themealdb.com/images/ingredients/Chicken Legs.png', '67', 1),
(60, 'Chicken Stock', 'http://www.themealdb.com/images/ingredients/Chicken Stock.png', '68', 1),
(61, 'Chicken Thighs', 'http://www.themealdb.com/images/ingredients/Chicken Thighs.png', '70', 1),
(62, 'Chickpeas', 'http://www.themealdb.com/images/ingredients/Chickpeas.png', '71', 1),
(63, 'Chili Powder', 'http://www.themealdb.com/images/ingredients/Chili Powder.png', '72', 1),
(64, 'Chilled Butter', 'http://www.themealdb.com/images/ingredients/Chilled Butter.png', '73', 1),
(65, 'Chilli', 'http://www.themealdb.com/images/ingredients/Chilli.png', '74', 1),
(66, 'Chilli Powder', 'http://www.themealdb.com/images/ingredients/Chilli Powder.png', '75', 1),
(67, 'Chinese Broccoli', 'http://www.themealdb.com/images/ingredients/Chinese Broccoli.png', '76', 1),
(68, 'Chocolate Chips', 'http://www.themealdb.com/images/ingredients/Chocolate Chips.png', '77', 1),
(69, 'Chopped Onion', 'http://www.themealdb.com/images/ingredients/Chopped Onion.png', '78', 1),
(70, 'Chopped Parsley', 'http://www.themealdb.com/images/ingredients/Chopped Parsley.png', '79', 1),
(71, 'Chopped Tomatoes', 'http://www.themealdb.com/images/ingredients/Chopped Tomatoes.png', '80', 1),
(72, 'Chorizo', 'http://www.themealdb.com/images/ingredients/Chorizo.png', '81', 1),
(73, 'Christmas Pudding', 'http://www.themealdb.com/images/ingredients/Christmas Pudding.png', '82', 1),
(74, 'Cilantro', 'http://www.themealdb.com/images/ingredients/Cilantro.png', '83', 1),
(75, 'Cinnamon', 'http://www.themealdb.com/images/ingredients/Cinnamon.png', '84', 1),
(76, 'Cinnamon Stick', 'http://www.themealdb.com/images/ingredients/Cinnamon Stick.png', '85', 1),
(77, 'Cloves', 'http://www.themealdb.com/images/ingredients/Cloves.png', '87', 1),
(78, 'Coco Sugar', 'http://www.themealdb.com/images/ingredients/Coco Sugar.png', '88', 1),
(79, 'Cocoa', 'http://www.themealdb.com/images/ingredients/Cocoa.png', '89', 1),
(80, 'Coconut Cream', 'http://www.themealdb.com/images/ingredients/Coconut Cream.png', '90', 1),
(81, 'Coconut Milk', 'http://www.themealdb.com/images/ingredients/Coconut Milk.png', '91', 1),
(82, 'Colby Jack Cheese', 'http://www.themealdb.com/images/ingredients/Colby Jack Cheese.png', '92', 1),
(83, 'Cold Water', 'http://www.themealdb.com/images/ingredients/Cold Water.png', '93', 1),
(84, 'Condensed Milk', 'http://www.themealdb.com/images/ingredients/Condensed Milk.png', '94', 1),
(85, 'Coriander', 'http://www.themealdb.com/images/ingredients/Coriander.png', '95', 1),
(86, 'Coriander Leaves', 'http://www.themealdb.com/images/ingredients/Coriander Leaves.png', '96', 1),
(87, 'Coriander Seeds', 'http://www.themealdb.com/images/ingredients/Coriander Seeds.png', '97', 1),
(88, 'Corn Tortillas', 'http://www.themealdb.com/images/ingredients/Corn Tortillas.png', '98', 1),
(89, 'Cornstarch', 'http://www.themealdb.com/images/ingredients/Cornstarch.png', '99', 1),
(90, 'Cream', 'http://www.themealdb.com/images/ingredients/Cream.png', '100', 1),
(91, 'Creme Fraiche', 'http://www.themealdb.com/images/ingredients/Creme Fraiche.png', '101', 1),
(92, 'Cubed Feta Cheese', 'http://www.themealdb.com/images/ingredients/Cubed Feta Cheese.png', '102', 1),
(93, 'Cucumber', 'http://www.themealdb.com/images/ingredients/Cucumber.png', '103', 1),
(94, 'Cumin', 'http://www.themealdb.com/images/ingredients/Cumin.png', '104', 1),
(95, 'Cumin Seeds', 'http://www.themealdb.com/images/ingredients/Cumin Seeds.png', '105', 1),
(96, 'Curry Powder', 'http://www.themealdb.com/images/ingredients/Curry Powder.png', '106', 1),
(97, 'Dark Brown Sugar', 'http://www.themealdb.com/images/ingredients/Dark Brown Sugar.png', '107', 1),
(98, 'Dark Soft Brown Sugar', 'http://www.themealdb.com/images/ingredients/Dark Soft Brown Sugar.png', '108', 1),
(99, 'Dark Soy Sauce', 'http://www.themealdb.com/images/ingredients/Dark Soy Sauce.png', '109', 1),
(100, 'Demerara Sugar', 'http://www.themealdb.com/images/ingredients/Demerara Sugar.png', '110', 1),
(101, 'Diced Tomatoes', 'http://www.themealdb.com/images/ingredients/Diced Tomatoes.png', '111', 1),
(102, 'Digestive Biscuits', 'http://www.themealdb.com/images/ingredients/Digestive Biscuits.png', '112', 1),
(103, 'Dill', 'http://www.themealdb.com/images/ingredients/Dill.png', '113', 1),
(104, 'Doner Meat', 'http://www.themealdb.com/images/ingredients/Doner Meat.png', '114', 1),
(105, 'Double Cream', 'http://www.themealdb.com/images/ingredients/Double Cream.png', '115', 1),
(106, 'Dried Oregano', 'http://www.themealdb.com/images/ingredients/Dried Oregano.png', '116', 1),
(107, 'Dry White Wine', 'http://www.themealdb.com/images/ingredients/Dry White Wine.png', '117', 1),
(108, 'Egg Plants', 'http://www.themealdb.com/images/ingredients/Egg Plants.png', '119', 1),
(109, 'Egg Rolls', 'http://www.themealdb.com/images/ingredients/Egg Rolls.png', '120', 1),
(110, 'Egg White', 'http://www.themealdb.com/images/ingredients/Egg White.png', '121', 1),
(111, 'Egg Yolks', 'http://www.themealdb.com/images/ingredients/Egg Yolks.png', '122', 1),
(112, 'Eggs', 'http://www.themealdb.com/images/ingredients/Eggs.png', '123', 1),
(113, 'Enchilada Sauce', 'http://www.themealdb.com/images/ingredients/Enchilada Sauce.png', '124', 1),
(114, 'English Mustard', 'http://www.themealdb.com/images/ingredients/English Mustard.png', '125', 1),
(115, 'Extra Virgin Olive Oil', 'http://www.themealdb.com/images/ingredients/Extra Virgin Olive Oil.png', '126', 1),
(116, 'Fajita Seasoning', 'http://www.themealdb.com/images/ingredients/Fajita Seasoning.png', '127', 1),
(117, 'Farfalle', 'http://www.themealdb.com/images/ingredients/Farfalle.png', '128', 1),
(118, 'Fennel Bulb', 'http://www.themealdb.com/images/ingredients/Fennel Bulb.png', '130', 1),
(119, 'Fennel Seeds', 'http://www.themealdb.com/images/ingredients/Fennel Seeds.png', '131', 1),
(120, 'Fenugreek', 'http://www.themealdb.com/images/ingredients/Fenugreek.png', '132', 1),
(121, 'Feta', 'http://www.themealdb.com/images/ingredients/Feta.png', '133', 1),
(122, 'Fish Sauce', 'http://www.themealdb.com/images/ingredients/Fish Sauce.png', '134', 1),
(123, 'Flaked Almonds', 'http://www.themealdb.com/images/ingredients/Flaked Almonds.png', '135', 1),
(124, 'Flax Eggs', 'http://www.themealdb.com/images/ingredients/Flax Eggs.png', '136', 1),
(125, 'Flour', 'http://www.themealdb.com/images/ingredients/Flour.png', '137', 1),
(126, 'Flour Tortilla', 'http://www.themealdb.com/images/ingredients/Flour Tortilla.png', '138', 1),
(127, 'Floury Potatoes', 'http://www.themealdb.com/images/ingredients/Floury Potatoes.png', '139', 1),
(128, 'Free-range Egg, Beaten', 'http://www.themealdb.com/images/ingredients/Free-range Egg, Beaten.png', '140', 1),
(129, 'Free-range Eggs, Beaten', 'http://www.themealdb.com/images/ingredients/Free-range Eggs, Beaten.png', '141', 1),
(130, 'French Lentils', 'http://www.themealdb.com/images/ingredients/French Lentils.png', '142', 1),
(131, 'Fresh Basil', 'http://www.themealdb.com/images/ingredients/Fresh Basil.png', '143', 1),
(132, 'Fresh Thyme', 'http://www.themealdb.com/images/ingredients/Fresh Thyme.png', '144', 1),
(133, 'Freshly Chopped Parsley', 'http://www.themealdb.com/images/ingredients/Freshly Chopped Parsley.png', '145', 1),
(134, 'Fries', 'http://www.themealdb.com/images/ingredients/Fries.png', '146', 1),
(135, 'Full Fat Yogurt', 'http://www.themealdb.com/images/ingredients/Full Fat Yogurt.png', '147', 1),
(136, 'Garam Masala', 'http://www.themealdb.com/images/ingredients/Garam Masala.png', '148', 1),
(137, 'Garlic', 'http://www.themealdb.com/images/ingredients/Garlic.png', '149', 1),
(138, 'Garlic Clove', 'http://www.themealdb.com/images/ingredients/Garlic Clove.png', '150', 1),
(139, 'Garlic Powder', 'http://www.themealdb.com/images/ingredients/Garlic Powder.png', '151', 1),
(140, 'Garlic Sauce', 'http://www.themealdb.com/images/ingredients/Garlic Sauce.png', '152', 1),
(141, 'Ghee', 'http://www.themealdb.com/images/ingredients/Ghee.png', '153', 1),
(142, 'Ginger', 'http://www.themealdb.com/images/ingredients/Ginger.png', '154', 1),
(143, 'Ginger Cordial', 'http://www.themealdb.com/images/ingredients/Ginger Cordial.png', '155', 1),
(144, 'Ginger Garlic Paste', 'http://www.themealdb.com/images/ingredients/Ginger Garlic Paste.png', '156', 1),
(145, 'Ginger Paste', 'http://www.themealdb.com/images/ingredients/Ginger Paste.png', '157', 1),
(146, 'Golden Syrup', 'http://www.themealdb.com/images/ingredients/Golden Syrup.png', '158', 1),
(147, 'Gouda Cheese', 'http://www.themealdb.com/images/ingredients/Gouda Cheese.png', '159', 1),
(148, 'Granulated Sugar', 'http://www.themealdb.com/images/ingredients/Granulated Sugar.png', '160', 1),
(149, 'Grape Tomatoes', 'http://www.themealdb.com/images/ingredients/Grape Tomatoes.png', '161', 1),
(150, 'Greek Yogurt', 'http://www.themealdb.com/images/ingredients/Greek Yogurt.png', '162', 1),
(151, 'Green Beans', 'http://www.themealdb.com/images/ingredients/Green Beans.png', '163', 1),
(152, 'Green Chilli', 'http://www.themealdb.com/images/ingredients/Green Chilli.png', '165', 1),
(153, 'Green Olives', 'http://www.themealdb.com/images/ingredients/Green Olives.png', '166', 1),
(154, 'Green Red Lentils', 'http://www.themealdb.com/images/ingredients/Green Red Lentils.png', '167', 1),
(155, 'Green Salsa', 'http://www.themealdb.com/images/ingredients/Green Salsa.png', '168', 1),
(156, 'Ground Almonds', 'http://www.themealdb.com/images/ingredients/Ground Almonds.png', '169', 1),
(157, 'Ground Cumin', 'http://www.themealdb.com/images/ingredients/Ground Cumin.png', '170', 1),
(158, 'Ground Ginger', 'http://www.themealdb.com/images/ingredients/Ground Ginger.png', '171', 1),
(159, 'Gruyère', 'http://www.themealdb.com/images/ingredients/Gruyère.png', '172', 1),
(160, 'Hard Taco Shells', 'http://www.themealdb.com/images/ingredients/Hard Taco Shells.png', '173', 1),
(161, 'Harissa Spice', 'http://www.themealdb.com/images/ingredients/Harissa Spice.png', '175', 1),
(162, 'Heavy Cream', 'http://www.themealdb.com/images/ingredients/Heavy Cream.png', '176', 1),
(163, 'Honey', 'http://www.themealdb.com/images/ingredients/Honey.png', '177', 1),
(164, 'Horseradish', 'http://www.themealdb.com/images/ingredients/Horseradish.png', '178', 1),
(165, 'Hot Beef Stock', 'http://www.themealdb.com/images/ingredients/Hot Beef Stock.png', '179', 1),
(166, 'Hotsauce', 'http://www.themealdb.com/images/ingredients/Hotsauce.png', '180', 1),
(167, 'Ice Cream', 'http://www.themealdb.com/images/ingredients/Ice Cream.png', '181', 1),
(168, 'Italian Fennel Sausages', 'http://www.themealdb.com/images/ingredients/Italian Fennel Sausages.png', '182', 1),
(169, 'Italian Seasoning', 'http://www.themealdb.com/images/ingredients/Italian Seasoning.png', '183', 1),
(170, 'Jalapeno', 'http://www.themealdb.com/images/ingredients/Jalapeno.png', '184', 1),
(171, 'Jasmine Rice', 'http://www.themealdb.com/images/ingredients/Jasmine Rice.png', '185', 1),
(172, 'Jerusalem Artichokes', 'http://www.themealdb.com/images/ingredients/Jerusalem Artichokes.png', '186', 1),
(173, 'Kale', 'http://www.themealdb.com/images/ingredients/Kale.png', '187', 1),
(174, 'Khus Khus', 'http://www.themealdb.com/images/ingredients/Khus Khus.png', '188', 1),
(175, 'King Prawns', 'http://www.themealdb.com/images/ingredients/King Prawns.png', '189', 1),
(176, 'Kosher Salt', 'http://www.themealdb.com/images/ingredients/Kosher Salt.png', '190', 1),
(177, 'Lamb', 'http://www.themealdb.com/images/ingredients/Lamb.png', '191', 1),
(178, 'Lamb Loin Chops', 'http://www.themealdb.com/images/ingredients/Lamb Loin Chops.png', '192', 1),
(179, 'Lamb Mince', 'http://www.themealdb.com/images/ingredients/Lamb Mince.png', '193', 1),
(180, 'Lasagne Sheets', 'http://www.themealdb.com/images/ingredients/Lasagne Sheets.png', '194', 1),
(181, 'Lean Minced Beef', 'http://www.themealdb.com/images/ingredients/Lean Minced Beef.png', '195', 1),
(182, 'Leek', 'http://www.themealdb.com/images/ingredients/Leek.png', '196', 1),
(183, 'Lemon', 'http://www.themealdb.com/images/ingredients/Lemon.png', '197', 1),
(184, 'Lemon Juice', 'http://www.themealdb.com/images/ingredients/Lemon Juice.png', '198', 1),
(185, 'Lemon Zest', 'http://www.themealdb.com/images/ingredients/Lemon Zest.png', '199', 1),
(186, 'Lemons', 'http://www.themealdb.com/images/ingredients/Lemons.png', '200', 1),
(187, 'Lettuce', 'http://www.themealdb.com/images/ingredients/Lettuce.png', '201', 1),
(188, 'Lime', 'http://www.themealdb.com/images/ingredients/Lime.png', '202', 1),
(189, 'Little Gem Lettuce', 'http://www.themealdb.com/images/ingredients/Little Gem Lettuce.png', '203', 1),
(190, 'Macaroni', 'http://www.themealdb.com/images/ingredients/Macaroni.png', '204', 1),
(191, 'Mackerel', 'http://www.themealdb.com/images/ingredients/Mackerel.png', '205', 1),
(192, 'Madras Paste', 'http://www.themealdb.com/images/ingredients/Madras Paste.png', '206', 1),
(193, 'Marjoram', 'http://www.themealdb.com/images/ingredients/Marjoram.png', '207', 1),
(194, 'Massaman Curry Paste', 'http://www.themealdb.com/images/ingredients/Massaman Curry Paste.png', '208', 1),
(195, 'Medjool Dates', 'http://www.themealdb.com/images/ingredients/Medjool Dates.png', '209', 1),
(196, 'Meringue Nests', 'http://www.themealdb.com/images/ingredients/Meringue Nests.png', '210', 1),
(197, 'Milk', 'http://www.themealdb.com/images/ingredients/Milk.png', '211', 1),
(198, 'Minced Garlic', 'http://www.themealdb.com/images/ingredients/Minced Garlic.png', '212', 1),
(199, 'Miniature Marshmallows', 'http://www.themealdb.com/images/ingredients/Miniature Marshmallows.png', '213', 1),
(200, 'Mint', 'http://www.themealdb.com/images/ingredients/Mint.png', '214', 1),
(201, 'Monterey Jack Cheese', 'http://www.themealdb.com/images/ingredients/Monterey Jack Cheese.png', '215', 1),
(202, 'Mozzarella Balls', 'http://www.themealdb.com/images/ingredients/Mozzarella Balls.png', '216', 1),
(203, 'Muscovado Sugar', 'http://www.themealdb.com/images/ingredients/Muscovado Sugar.png', '217', 1),
(204, 'Mushrooms', 'http://www.themealdb.com/images/ingredients/Mushrooms.png', '218', 1),
(205, 'Mustard', 'http://www.themealdb.com/images/ingredients/Mustard.png', '219', 1),
(206, 'Mustard Powder', 'http://www.themealdb.com/images/ingredients/Mustard Powder.png', '220', 1),
(207, 'Mustard Seeds', 'http://www.themealdb.com/images/ingredients/Mustard Seeds.png', '221', 1),
(208, 'Nutmeg', 'http://www.themealdb.com/images/ingredients/Nutmeg.png', '222', 1),
(209, 'Oil', 'http://www.themealdb.com/images/ingredients/Oil.png', '223', 1),
(210, 'Olive Oil', 'http://www.themealdb.com/images/ingredients/Olive Oil.png', '224', 1),
(211, 'Onion Salt', 'http://www.themealdb.com/images/ingredients/Onion Salt.png', '226', 1),
(212, 'Onions', 'http://www.themealdb.com/images/ingredients/Onions.png', '227', 1),
(213, 'Orange', 'http://www.themealdb.com/images/ingredients/Orange.png', '228', 1),
(214, 'Orange Zest', 'http://www.themealdb.com/images/ingredients/Orange Zest.png', '229', 1),
(215, 'Oregano', 'http://www.themealdb.com/images/ingredients/Oregano.png', '230', 1),
(216, 'Oyster Sauce', 'http://www.themealdb.com/images/ingredients/Oyster Sauce.png', '231', 1),
(217, 'Paprika', 'http://www.themealdb.com/images/ingredients/Paprika.png', '232', 1),
(218, 'Parma Ham', 'http://www.themealdb.com/images/ingredients/Parma Ham.png', '233', 1),
(219, 'Parmesan', 'http://www.themealdb.com/images/ingredients/Parmesan.png', '234', 1),
(220, 'Parmesan Cheese', 'http://www.themealdb.com/images/ingredients/Parmesan Cheese.png', '235', 1),
(221, 'Parmigiano-reggiano', 'http://www.themealdb.com/images/ingredients/Parmigiano-reggiano.png', '236', 1),
(222, 'Parsley', 'http://www.themealdb.com/images/ingredients/Parsley.png', '237', 1),
(223, 'Peanut Butter', 'http://www.themealdb.com/images/ingredients/Peanut Butter.png', '238', 1),
(224, 'Peanut Oil', 'http://www.themealdb.com/images/ingredients/Peanut Oil.png', '239', 1),
(225, 'Peanuts', 'http://www.themealdb.com/images/ingredients/Peanuts.png', '240', 1),
(226, 'Peas', 'http://www.themealdb.com/images/ingredients/Peas.png', '241', 1),
(227, 'Pecorino', 'http://www.themealdb.com/images/ingredients/Pecorino.png', '242', 1),
(228, 'Penne Rigate', 'http://www.themealdb.com/images/ingredients/Penne Rigate.png', '243', 1),
(229, 'Pepper', 'http://www.themealdb.com/images/ingredients/Pepper.png', '244', 1),
(230, 'Pine Nuts', 'http://www.themealdb.com/images/ingredients/Pine Nuts.png', '245', 1),
(231, 'Pitted Black Olives', 'http://www.themealdb.com/images/ingredients/Pitted Black Olives.png', '246', 1),
(232, 'Plain Chocolate', 'http://www.themealdb.com/images/ingredients/Plain Chocolate.png', '247', 1),
(233, 'Plain Flour', 'http://www.themealdb.com/images/ingredients/Plain Flour.png', '248', 1),
(234, 'Plum Tomatoes', 'http://www.themealdb.com/images/ingredients/Plum Tomatoes.png', '249', 1),
(235, 'Potato Starch', 'http://www.themealdb.com/images/ingredients/Potato Starch.png', '252', 1),
(236, 'Potatoes', 'http://www.themealdb.com/images/ingredients/Potatoes.png', '253', 1),
(237, 'Prawns', 'http://www.themealdb.com/images/ingredients/Prawns.png', '254', 1),
(238, 'Puff Pastry', 'http://www.themealdb.com/images/ingredients/Puff Pastry.png', '255', 1),
(239, 'Raspberry Jam', 'http://www.themealdb.com/images/ingredients/Raspberry Jam.png', '256', 1),
(240, 'Raw King Prawns', 'http://www.themealdb.com/images/ingredients/Raw King Prawns.png', '257', 1),
(241, 'Red Chile Flakes', 'http://www.themealdb.com/images/ingredients/Red Chile Flakes.png', '258', 1),
(242, 'Red Chilli', 'http://www.themealdb.com/images/ingredients/Red Chilli.png', '259', 1),
(243, 'Red Chilli Powder', 'http://www.themealdb.com/images/ingredients/Red Chilli Powder.png', '261', 1),
(244, 'Red Onions', 'http://www.themealdb.com/images/ingredients/Red Onions.png', '263', 1),
(245, 'Red Pepper', 'http://www.themealdb.com/images/ingredients/Red Pepper.png', '264', 1),
(246, 'Red Pepper Flakes', 'http://www.themealdb.com/images/ingredients/Red Pepper Flakes.png', '265', 1),
(247, 'Red Wine', 'http://www.themealdb.com/images/ingredients/Red Wine.png', '266', 1),
(248, 'Refried Beans', 'http://www.themealdb.com/images/ingredients/Refried Beans.png', '267', 1),
(249, 'Rice', 'http://www.themealdb.com/images/ingredients/Rice.png', '268', 1),
(250, 'Rice Noodles', 'http://www.themealdb.com/images/ingredients/Rice Noodles.png', '269', 1),
(251, 'Rice Stick Noodles', 'http://www.themealdb.com/images/ingredients/Rice Stick Noodles.png', '270', 1),
(252, 'Rice Vermicelli', 'http://www.themealdb.com/images/ingredients/Rice Vermicelli.png', '271', 1),
(253, 'Rigatoni', 'http://www.themealdb.com/images/ingredients/Rigatoni.png', '272', 1),
(254, 'Rocket', 'http://www.themealdb.com/images/ingredients/Rocket.png', '273', 1),
(255, 'Rolled Oats', 'http://www.themealdb.com/images/ingredients/Rolled Oats.png', '274', 1),
(256, 'Saffron', 'http://www.themealdb.com/images/ingredients/Saffron.png', '276', 1),
(257, 'Sage', 'http://www.themealdb.com/images/ingredients/Sage.png', '277', 1),
(258, 'Sake', 'http://www.themealdb.com/images/ingredients/Sake.png', '278', 1),
(259, 'Salsa', 'http://www.themealdb.com/images/ingredients/Salsa.png', '280', 1),
(260, 'Salt', 'http://www.themealdb.com/images/ingredients/Salt.png', '281', 1),
(261, 'Salted Butter', 'http://www.themealdb.com/images/ingredients/Salted Butter.png', '282', 1),
(262, 'Sausages', 'http://www.themealdb.com/images/ingredients/Sausages.png', '283', 1),
(263, 'Sea Salt', 'http://www.themealdb.com/images/ingredients/Sea Salt.png', '284', 1),
(264, 'Self-raising Flour', 'http://www.themealdb.com/images/ingredients/Self-raising Flour.png', '286', 1),
(265, 'Semi-skimmed Milk', 'http://www.themealdb.com/images/ingredients/Semi-skimmed Milk.png', '287', 1),
(266, 'Sesame Seed', 'http://www.themealdb.com/images/ingredients/Sesame Seed.png', '288', 1),
(267, 'Shallots', 'http://www.themealdb.com/images/ingredients/Shallots.png', '289', 1),
(268, 'Shredded Mexican Cheese', 'http://www.themealdb.com/images/ingredients/Shredded Mexican Cheese.png', '290', 1),
(269, 'Shredded Monterey Jack Cheese', 'http://www.themealdb.com/images/ingredients/Shredded Monterey Jack Cheese.png', '291', 1),
(270, 'Small Potatoes', 'http://www.themealdb.com/images/ingredients/Small Potatoes.png', '292', 1),
(271, 'Smoked Paprika', 'http://www.themealdb.com/images/ingredients/Smoked Paprika.png', '293', 1),
(272, 'Smoky Paprika', 'http://www.themealdb.com/images/ingredients/Smoky Paprika.png', '294', 1),
(273, 'Sour Cream', 'http://www.themealdb.com/images/ingredients/Sour Cream.png', '295', 1),
(274, 'Soy Sauce', 'http://www.themealdb.com/images/ingredients/Soy Sauce.png', '296', 1),
(275, 'Soya Milk', 'http://www.themealdb.com/images/ingredients/Soya Milk.png', '297', 1),
(276, 'Spaghetti', 'http://www.themealdb.com/images/ingredients/Spaghetti.png', '298', 1),
(277, 'Spinach', 'http://www.themealdb.com/images/ingredients/Spinach.png', '299', 1),
(278, 'Spring Onions', 'http://www.themealdb.com/images/ingredients/Spring Onions.png', '301', 1),
(279, 'Squash', 'http://www.themealdb.com/images/ingredients/Squash.png', '302', 1),
(280, 'Stir-fry Vegetables', 'http://www.themealdb.com/images/ingredients/Stir-fry Vegetables.png', '303', 1),
(281, 'Strawberries', 'http://www.themealdb.com/images/ingredients/Strawberries.png', '304', 1),
(282, 'Sugar', 'http://www.themealdb.com/images/ingredients/Sugar.png', '305', 1),
(283, 'Sultanas', 'http://www.themealdb.com/images/ingredients/Sultanas.png', '306', 1),
(284, 'Sunflower Oil', 'http://www.themealdb.com/images/ingredients/Sunflower Oil.png', '307', 1),
(285, 'Tamarind Ball', 'http://www.themealdb.com/images/ingredients/Tamarind Ball.png', '308', 1),
(286, 'Tamarind Paste', 'http://www.themealdb.com/images/ingredients/Tamarind Paste.png', '309', 1),
(287, 'Thai Fish Sauce', 'http://www.themealdb.com/images/ingredients/Thai Fish Sauce.png', '310', 1),
(288, 'Thai Green Curry Paste', 'http://www.themealdb.com/images/ingredients/Thai Green Curry Paste.png', '311', 1),
(289, 'Thai Red Curry Paste', 'http://www.themealdb.com/images/ingredients/Thai Red Curry Paste.png', '312', 1),
(290, 'Thyme', 'http://www.themealdb.com/images/ingredients/Thyme.png', '313', 1),
(291, 'Tomato Ketchup', 'http://www.themealdb.com/images/ingredients/Tomato Ketchup.png', '315', 1),
(292, 'Tomato Puree', 'http://www.themealdb.com/images/ingredients/Tomato Puree.png', '316', 1),
(293, 'Tomatoes', 'http://www.themealdb.com/images/ingredients/Tomatoes.png', '317', 1),
(294, 'Toor Dal', 'http://www.themealdb.com/images/ingredients/Toor Dal.png', '318', 1),
(295, 'Tuna', 'http://www.themealdb.com/images/ingredients/Tuna.png', '319', 1),
(296, 'Turmeric', 'http://www.themealdb.com/images/ingredients/Turmeric.png', '320', 1),
(297, 'Turmeric Powder', 'http://www.themealdb.com/images/ingredients/Turmeric Powder.png', '321', 1),
(298, 'Turnips', 'http://www.themealdb.com/images/ingredients/Turnips.png', '322', 1),
(299, 'Vanilla', 'http://www.themealdb.com/images/ingredients/Vanilla.png', '323', 1),
(300, 'Vanilla Extract', 'http://www.themealdb.com/images/ingredients/Vanilla Extract.png', '324', 1),
(301, 'Veal', 'http://www.themealdb.com/images/ingredients/Veal.png', '325', 1),
(302, 'Vegan Butter', 'http://www.themealdb.com/images/ingredients/Vegan Butter.png', '326', 1),
(303, 'Vegetable Oil', 'http://www.themealdb.com/images/ingredients/Vegetable Oil.png', '327', 1),
(304, 'Vegetable Stock', 'http://www.themealdb.com/images/ingredients/Vegetable Stock.png', '328', 1),
(305, 'Vegetable Stock Cube', 'http://www.themealdb.com/images/ingredients/Vegetable Stock Cube.png', '329', 1),
(306, 'Vinaigrette Dressing', 'http://www.themealdb.com/images/ingredients/Vinaigrette Dressing.png', '330', 1),
(307, 'Vine Leaves', 'http://www.themealdb.com/images/ingredients/Vine Leaves.png', '331', 1),
(308, 'Vinegar', 'http://www.themealdb.com/images/ingredients/Vinegar.png', '332', 1),
(309, 'Water', 'http://www.themealdb.com/images/ingredients/Water.png', '333', 1),
(310, 'White Chocolate Chips', 'http://www.themealdb.com/images/ingredients/White Chocolate Chips.png', '334', 1),
(311, 'White Fish', 'http://www.themealdb.com/images/ingredients/White Fish.png', '335', 1),
(312, 'White Fish Fillets', 'http://www.themealdb.com/images/ingredients/White Fish Fillets.png', '336', 1),
(313, 'White Vinegar', 'http://www.themealdb.com/images/ingredients/White Vinegar.png', '337', 1),
(314, 'White Wine', 'http://www.themealdb.com/images/ingredients/White Wine.png', '338', 1),
(315, 'Whole Milk', 'http://www.themealdb.com/images/ingredients/Whole Milk.png', '339', 1),
(316, 'Whole Wheat', 'http://www.themealdb.com/images/ingredients/Whole Wheat.png', '340', 1),
(317, 'Wholegrain Bread', 'http://www.themealdb.com/images/ingredients/Wholegrain Bread.png', '341', 1),
(318, 'Worcestershire Sauce', 'http://www.themealdb.com/images/ingredients/Worcestershire Sauce.png', '342', 1),
(319, 'Yogurt', 'http://www.themealdb.com/images/ingredients/Yogurt.png', '343', 1),
(320, 'Zucchini', 'http://www.themealdb.com/images/ingredients/Zucchini.png', '344', 1),
(321, 'Pretzels', 'http://www.themealdb.com/images/ingredients/Pretzels.png', '345', 1),
(322, 'Cream Cheese', 'http://www.themealdb.com/images/ingredients/Cream Cheese.png', '346', 1),
(323, 'Icing Sugar', 'http://www.themealdb.com/images/ingredients/Icing Sugar.png', '347', 1),
(324, 'Toffee Popcorn', 'http://www.themealdb.com/images/ingredients/Toffee Popcorn.png', '348', 1),
(325, 'Caramel', 'http://www.themealdb.com/images/ingredients/Caramel.png', '349', 1),
(326, 'Caramel Sauce', 'http://www.themealdb.com/images/ingredients/Caramel Sauce.png', '350', 1),
(327, 'Tagliatelle', 'http://www.themealdb.com/images/ingredients/Tagliatelle.png', '351', 1),
(328, 'Fettuccine', 'http://www.themealdb.com/images/ingredients/Fettuccine.png', '352', 1),
(329, 'Clotted Cream', 'http://www.themealdb.com/images/ingredients/Clotted Cream.png', '353', 1),
(330, 'Corn Flour', 'http://www.themealdb.com/images/ingredients/Corn Flour.png', '354', 1),
(331, 'Mussels', 'http://www.themealdb.com/images/ingredients/Mussels.png', '355', 1),
(332, 'Fideo', 'http://www.themealdb.com/images/ingredients/Fideo.png', '356', 1),
(333, 'Monkfish', 'http://www.themealdb.com/images/ingredients/Monkfish.png', '357', 1),
(334, 'Vermicelli Pasta', 'http://www.themealdb.com/images/ingredients/Vermicelli Pasta.png', '358', 1),
(335, 'Baby Squid', 'http://www.themealdb.com/images/ingredients/Baby Squid.png', '359', 1),
(336, 'Squid', 'http://www.themealdb.com/images/ingredients/Squid.png', '360', 1),
(337, 'Fish Stock', 'http://www.themealdb.com/images/ingredients/Fish Stock.png', '361', 1),
(338, 'Pilchards', 'http://www.themealdb.com/images/ingredients/Pilchards.png', '362', 1),
(339, 'Black Olives', 'http://www.themealdb.com/images/ingredients/Black Olives.png', '363', 1),
(340, 'Onion', 'http://www.themealdb.com/images/ingredients/Onion.png', '364', 1),
(341, 'Tomato', 'http://www.themealdb.com/images/ingredients/Tomato.png', '365', 1),
(342, 'Duck', 'http://www.themealdb.com/images/ingredients/Duck.png', '366', 1),
(343, 'Duck Legs', 'http://www.themealdb.com/images/ingredients/Duck Legs.png', '367', 1),
(344, 'Chicken Stock Cube', 'http://www.themealdb.com/images/ingredients/Chicken Stock Cube.png', '368', 1),
(345, 'Pappardelle Pasta', 'http://www.themealdb.com/images/ingredients/Pappardelle Pasta.png', '369', 1),
(346, 'Paccheri Pasta', 'http://www.themealdb.com/images/ingredients/Paccheri Pasta.png', '370', 1),
(347, 'Linguine Pasta', 'http://www.themealdb.com/images/ingredients/Linguine Pasta.png', '371', 1),
(348, 'Sugar Snap Peas', 'http://www.themealdb.com/images/ingredients/Sugar Snap Peas.png', '373', 1),
(349, 'Crusty Bread', 'http://www.themealdb.com/images/ingredients/Crusty Bread.png', '374', 1),
(350, 'Fromage Frais', 'http://www.themealdb.com/images/ingredients/Fromage Frais.png', '375', 1),
(351, 'Clams', 'http://www.themealdb.com/images/ingredients/Clams.png', '376', 1),
(352, 'Passata', 'http://www.themealdb.com/images/ingredients/Passata.png', '377', 1),
(353, 'Rapeseed Oil', 'http://www.themealdb.com/images/ingredients/Rapeseed Oil.png', '378', 1),
(354, 'Stilton Cheese', 'http://www.themealdb.com/images/ingredients/Stilton Cheese.png', '379', 1),
(355, 'Lamb Leg', 'http://www.themealdb.com/images/ingredients/Lamb Leg.png', '380', 1),
(356, 'Lamb Shoulder', 'http://www.themealdb.com/images/ingredients/Lamb Shoulder.png', '381', 1),
(357, 'Apricot', 'http://www.themealdb.com/images/ingredients/Apricot.png', '382', 1),
(358, 'Butternut Squash', 'http://www.themealdb.com/images/ingredients/Butternut Squash.png', '383', 1),
(359, 'Couscous', 'http://www.themealdb.com/images/ingredients/Couscous.png', '384', 1),
(360, 'Minced Beef', 'http://www.themealdb.com/images/ingredients/Minced Beef.png', '387', 1),
(361, 'Turkey Mince', 'http://www.themealdb.com/images/ingredients/Turkey Mince.png', '388', 1),
(362, 'Barbeque Sauce', 'http://www.themealdb.com/images/ingredients/Barbeque Sauce.png', '389', 1),
(363, 'Sweetcorn', 'http://www.themealdb.com/images/ingredients/Sweetcorn.png', '390', 1),
(364, 'Goose Fat', 'http://www.themealdb.com/images/ingredients/Goose Fat.png', '391', 1),
(365, 'Duck Fat', 'http://www.themealdb.com/images/ingredients/Duck Fat.png', '392', 1),
(366, 'Fennel', 'http://www.themealdb.com/images/ingredients/Fennel.png', '393', 1),
(367, 'Red Wine Vinegar', 'http://www.themealdb.com/images/ingredients/Red Wine Vinegar.png', '394', 1),
(368, 'Haricot Beans', 'http://www.themealdb.com/images/ingredients/Haricot Beans.png', '395', 1),
(369, 'Rosemary', 'http://www.themealdb.com/images/ingredients/Rosemary.png', '396', 1),
(370, 'Butter Beans', 'http://www.themealdb.com/images/ingredients/Butter Beans.png', '397', 1),
(371, 'Pinto Beans', 'http://www.themealdb.com/images/ingredients/Pinto Beans.png', '398', 1),
(372, 'Tomato Sauce', 'http://www.themealdb.com/images/ingredients/Tomato Sauce.png', '399', 1),
(373, 'Mascarpone', 'http://www.themealdb.com/images/ingredients/Mascarpone.png', '401', 1),
(374, 'Mozzarella', 'http://www.themealdb.com/images/ingredients/Mozzarella.png', '402', 1),
(375, 'Ricotta', 'http://www.themealdb.com/images/ingredients/Ricotta.png', '403', 1),
(376, 'Dried Apricots', 'http://www.themealdb.com/images/ingredients/Dried Apricots.png', '405', 1),
(377, 'Capers', 'http://www.themealdb.com/images/ingredients/Capers.png', '406', 1),
(378, 'Banana', 'http://www.themealdb.com/images/ingredients/Banana.png', '407', 1),
(379, 'Raspberries', 'http://www.themealdb.com/images/ingredients/Raspberries.png', '408', 1),
(380, 'Blueberries', 'http://www.themealdb.com/images/ingredients/Blueberries.png', '409', 1),
(381, 'Walnuts', 'http://www.themealdb.com/images/ingredients/Walnuts.png', '410', 1),
(382, 'Pecan Nuts', 'http://www.themealdb.com/images/ingredients/Pecan Nuts.png', '411', 1),
(383, 'Maple Syrup', 'http://www.themealdb.com/images/ingredients/Maple Syrup.png', '412', 1),
(384, 'Light Brown Soft Sugar', 'http://www.themealdb.com/images/ingredients/Light Brown Soft Sugar.png', '413', 1),
(385, 'Dark Brown Soft Sugar', 'http://www.themealdb.com/images/ingredients/Dark Brown Soft Sugar.png', '414', 1),
(386, 'Dark Chocolate Chips', 'http://www.themealdb.com/images/ingredients/Dark Chocolate Chips.png', '415', 1),
(387, 'Milk Chocolate', 'http://www.themealdb.com/images/ingredients/Milk Chocolate.png', '416', 1),
(388, 'Dark Chocolate', 'http://www.themealdb.com/images/ingredients/Dark Chocolate.png', '417', 1),
(389, 'Pumpkin', 'http://www.themealdb.com/images/ingredients/Pumpkin.png', '418', 1),
(390, 'Shortcrust Pastry', 'http://www.themealdb.com/images/ingredients/Shortcrust Pastry.png', '419', 1),
(391, 'Peanut Cookies', 'http://www.themealdb.com/images/ingredients/Peanut Cookies.png', '420', 1),
(392, 'Gelatine Leafs', 'http://www.themealdb.com/images/ingredients/Gelatine Leafs.png', '421', 1),
(393, 'Peanut Brittle', 'http://www.themealdb.com/images/ingredients/Peanut Brittle.png', '422', 1),
(394, 'Peaches', 'http://www.themealdb.com/images/ingredients/Peaches.png', '423', 1),
(395, 'Yellow Pepper', 'http://www.themealdb.com/images/ingredients/Yellow Pepper.png', '424', 1),
(396, 'Green Pepper', 'http://www.themealdb.com/images/ingredients/Green Pepper.png', '425', 1),
(397, 'Courgettes', 'http://www.themealdb.com/images/ingredients/Courgettes.png', '426', 1),
(398, 'Tinned Tomatos', 'http://www.themealdb.com/images/ingredients/Tinned Tomatos.png', '427', 1),
(399, 'Chestnuts', 'http://www.themealdb.com/images/ingredients/Chestnuts.png', '428', 1),
(400, 'Wild Mushrooms', 'http://www.themealdb.com/images/ingredients/Wild Mushrooms.png', '429', 1),
(401, 'Truffle Oil', 'http://www.themealdb.com/images/ingredients/Truffle Oil.png', '430', 1),
(402, 'Paneer', 'http://www.themealdb.com/images/ingredients/Paneer.png', '431', 1),
(403, 'Naan Bread', 'http://www.themealdb.com/images/ingredients/Naan Bread.png', '432', 1),
(404, 'Lentils', 'http://www.themealdb.com/images/ingredients/Lentils.png', '433', 1),
(405, 'Roasted Vegetables', 'http://www.themealdb.com/images/ingredients/Roasted Vegetables.png', '434', 1),
(406, 'Kidney Beans', 'http://www.themealdb.com/images/ingredients/Kidney Beans.png', '435', 1),
(407, 'Mixed Grain', 'http://www.themealdb.com/images/ingredients/Mixed Grain.png', '436', 1),
(408, 'Tahini', 'http://www.themealdb.com/images/ingredients/Tahini.png', '437', 1),
(409, 'Tortillas', 'http://www.themealdb.com/images/ingredients/Tortillas.png', '438', 1),
(410, 'Udon Noodles', 'http://www.themealdb.com/images/ingredients/Udon Noodles.png', '439', 1),
(411, 'Cabbage', 'http://www.themealdb.com/images/ingredients/Cabbage.png', '440', 1),
(412, 'Shiitake Mushrooms', 'http://www.themealdb.com/images/ingredients/Shiitake Mushrooms.png', '441', 1),
(413, 'Mirin', 'http://www.themealdb.com/images/ingredients/Mirin.png', '442', 1),
(414, 'Sesame Seed Oil', 'http://www.themealdb.com/images/ingredients/Sesame Seed Oil.png', '443', 1),
(415, 'Baguette', 'http://www.themealdb.com/images/ingredients/Baguette.png', '444', 1),
(416, 'Vine Tomatoes', 'http://www.themealdb.com/images/ingredients/Vine Tomatoes.png', '445', 1),
(417, 'Suet', 'http://www.themealdb.com/images/ingredients/Suet.png', '446', 1),
(418, 'Swede', 'http://www.themealdb.com/images/ingredients/Swede.png', '447', 1),
(419, 'Ham', 'http://www.themealdb.com/images/ingredients/Ham.png', '448', 1),
(420, 'Oysters', 'http://www.themealdb.com/images/ingredients/Oysters.png', '449', 1),
(421, 'Stout', 'http://www.themealdb.com/images/ingredients/Stout.png', '450', 1),
(422, 'Lard', 'http://www.themealdb.com/images/ingredients/Lard.png', '451', 1),
(423, 'Lamb Kidney', 'http://www.themealdb.com/images/ingredients/Lamb Kidney.png', '452', 1),
(424, 'Beef Kidney', 'http://www.themealdb.com/images/ingredients/Beef Kidney.png', '453', 1),
(425, 'Haddock', 'http://www.themealdb.com/images/ingredients/Haddock.png', '454', 1),
(426, 'Smoked Haddock', 'http://www.themealdb.com/images/ingredients/Smoked Haddock.png', '455', 1),
(427, 'Brussels Sprouts', 'http://www.themealdb.com/images/ingredients/Brussels Sprouts.png', '456', 1),
(428, 'Raisins', 'http://www.themealdb.com/images/ingredients/Raisins.png', '457', 1),
(429, 'Currants', 'http://www.themealdb.com/images/ingredients/Currants.png', '458', 1),
(430, 'Custard', 'http://www.themealdb.com/images/ingredients/Custard.png', '459', 1),
(431, 'Mixed Peel', 'http://www.themealdb.com/images/ingredients/Mixed Peel.png', '460', 1),
(432, 'Redcurrants', 'http://www.themealdb.com/images/ingredients/Redcurrants.png', '461', 1),
(433, 'Blackberries', 'http://www.themealdb.com/images/ingredients/Blackberries.png', '462', 1),
(434, 'Hazlenuts', 'http://www.themealdb.com/images/ingredients/Hazlenuts.png', '463', 1),
(435, 'Braeburn Apples', 'http://www.themealdb.com/images/ingredients/Braeburn Apples.png', '464', 1),
(436, 'Red Food Colouring', 'http://www.themealdb.com/images/ingredients/Red Food Colouring.png', '465', 1),
(437, 'Pink Food Colouring', 'http://www.themealdb.com/images/ingredients/Pink Food Colouring.png', '466', 1),
(438, 'Blue Food Colouring', 'http://www.themealdb.com/images/ingredients/Blue Food Colouring.png', '467', 1),
(439, 'Yellow Food Colouring', 'http://www.themealdb.com/images/ingredients/Yellow Food Colouring.png', '468', 1),
(440, 'Apricot Jam', 'http://www.themealdb.com/images/ingredients/Apricot Jam.png', '469', 1),
(441, 'Marzipan', 'http://www.themealdb.com/images/ingredients/Marzipan.png', '470', 1),
(442, 'Almonds', 'http://www.themealdb.com/images/ingredients/Almonds.png', '471', 1),
(443, 'Black Pudding', 'http://www.themealdb.com/images/ingredients/Black Pudding.png', '472', 1),
(444, 'Baked Beans', 'http://www.themealdb.com/images/ingredients/Baked Beans.png', '473', 1),
(445, 'White Flour', 'http://www.themealdb.com/images/ingredients/White Flour.png', '474', 1),
(446, 'Yeast', 'http://www.themealdb.com/images/ingredients/Yeast.png', '475', 1),
(447, 'Fruit Mix', 'http://www.themealdb.com/images/ingredients/Fruit Mix.png', '476', 1),
(448, 'Dried Fruit', 'http://www.themealdb.com/images/ingredients/Dried Fruit.png', '477', 1),
(449, 'Cherry', 'http://www.themealdb.com/images/ingredients/Cherry.png', '478', 1),
(450, 'Glace Cherry', 'http://www.themealdb.com/images/ingredients/Glace Cherry.png', '479', 1),
(451, 'Treacle', 'http://www.themealdb.com/images/ingredients/Treacle.png', '480', 1),
(452, 'Oatmeal', 'http://www.themealdb.com/images/ingredients/Oatmeal.png', '481', 1),
(453, 'Oats', 'http://www.themealdb.com/images/ingredients/Oats.png', '482', 1),
(454, 'Egg', 'http://www.themealdb.com/images/ingredients/Egg.png', '483', 1),
(455, 'Beef Shin', 'http://www.themealdb.com/images/ingredients/Beef Shin.png', '484', 1),
(456, 'Bouquet Garni', 'http://www.themealdb.com/images/ingredients/Bouquet Garni.png', '485', 1),
(457, 'Single Cream', 'http://www.themealdb.com/images/ingredients/Single Cream.png', '486', 1),
(458, 'Red Wine Jelly', 'http://www.themealdb.com/images/ingredients/Red Wine Jelly.png', '487', 1),
(459, 'Apples', 'http://www.themealdb.com/images/ingredients/Apples.png', '488', 1),
(460, 'Goats Cheese', 'http://www.themealdb.com/images/ingredients/Goats Cheese.png', '489', 1),
(461, 'Prosciutto', 'http://www.themealdb.com/images/ingredients/Prosciutto.png', '490', 1),
(462, 'Unsalted Butter', 'http://www.themealdb.com/images/ingredients/Unsalted Butter.png', '491', 1),
(463, 'Brie', 'http://www.themealdb.com/images/ingredients/Brie.png', '492', 1),
(464, 'Tarragon Leaves', 'http://www.themealdb.com/images/ingredients/Tarragon Leaves.png', '493', 1),
(465, 'Chives', 'http://www.themealdb.com/images/ingredients/Chives.png', '494', 1),
(466, 'Pears', 'http://www.themealdb.com/images/ingredients/Pears.png', '495', 1),
(467, 'White Chocolate', 'http://www.themealdb.com/images/ingredients/White Chocolate.png', '496', 1),
(468, 'Star Anise', 'http://www.themealdb.com/images/ingredients/Star Anise.png', '497', 1),
(469, 'Tiger Prawns', 'http://www.themealdb.com/images/ingredients/Tiger Prawns.png', '498', 1),
(470, 'Custard Powder', 'http://www.themealdb.com/images/ingredients/Custard Powder.png', '499', 1),
(471, 'Desiccated Coconut', 'http://www.themealdb.com/images/ingredients/Desiccated Coconut.png', '500', 1),
(472, 'Frozen Peas', 'http://www.themealdb.com/images/ingredients/Frozen Peas.png', '501', 1),
(473, 'Minced Pork', 'http://www.themealdb.com/images/ingredients/Minced Pork.png', '502', 1),
(474, 'Creamed Corn', 'http://www.themealdb.com/images/ingredients/Creamed Corn.png', '503', 1),
(475, 'Sun-Dried Tomatoes', 'http://www.themealdb.com/images/ingredients/Sun-Dried Tomatoes.png', '504', 1),
(476, 'Dijon Mustard', 'http://www.themealdb.com/images/ingredients/Dijon Mustard.png', '505', 1),
(477, 'Tabasco Sauce', 'http://www.themealdb.com/images/ingredients/Tabasco Sauce.png', '506', 1),
(478, 'Canola Oil', 'http://www.themealdb.com/images/ingredients/Canola Oil.png', '507', 1),
(479, 'Cod', 'http://www.themealdb.com/images/ingredients/Cod.png', '508', 1),
(480, 'Salt Cod', 'http://www.themealdb.com/images/ingredients/Salt Cod.png', '509', 1),
(481, 'Ackee', 'http://www.themealdb.com/images/ingredients/Ackee.png', '510', 1),
(482, 'Jerk', 'http://www.themealdb.com/images/ingredients/Jerk.png', '511', 1),
(483, 'Ground Beef', 'http://www.themealdb.com/images/ingredients/Ground Beef.png', '512', 1),
(484, 'Baby Aubergine', 'http://www.themealdb.com/images/ingredients/Baby Aubergine.png', '513', 1),
(485, 'Paella Rice', 'http://www.themealdb.com/images/ingredients/Paella Rice.png', '514', 1),
(486, 'Scotch Bonnet', 'http://www.themealdb.com/images/ingredients/Scotch Bonnet.png', '515', 1),
(487, 'Oxtail', 'http://www.themealdb.com/images/ingredients/Oxtail.png', '516', 1),
(488, 'Broad Beans', 'http://www.themealdb.com/images/ingredients/Broad Beans.png', '517', 1),
(489, 'Red Snapper', 'http://www.themealdb.com/images/ingredients/Red Snapper.png', '518', 1),
(490, 'Malt Vinegar', 'http://www.themealdb.com/images/ingredients/Malt Vinegar.png', '519', 1),
(491, 'Rice Vinegar', 'http://www.themealdb.com/images/ingredients/Rice Vinegar.png', '520', 1),
(492, 'Water Chestnut', 'http://www.themealdb.com/images/ingredients/Water Chestnut.png', '521', 1),
(493, 'Tofu', 'http://www.themealdb.com/images/ingredients/Tofu.png', '522', 1),
(494, 'Doubanjiang', 'http://www.themealdb.com/images/ingredients/Doubanjiang.png', '523', 1),
(495, 'Fermented Black Beans', 'http://www.themealdb.com/images/ingredients/Fermented Black Beans.png', '524', 1),
(496, 'Scallions', 'http://www.themealdb.com/images/ingredients/Scallions.png', '525', 1),
(497, 'Sichuan Pepper', 'http://www.themealdb.com/images/ingredients/Sichuan Pepper.png', '526', 1),
(498, 'Wonton Skin', 'http://www.themealdb.com/images/ingredients/Wonton Skin.png', '527', 1),
(499, 'Starch', 'http://www.themealdb.com/images/ingredients/Starch.png', '528', 1),
(500, 'Rice wine', 'http://www.themealdb.com/images/ingredients/Rice wine.png', '529', 1),
(501, 'Cooking wine', 'http://www.themealdb.com/images/ingredients/Cooking wine.png', '530', 1),
(502, 'Duck Sauce', 'http://www.themealdb.com/images/ingredients/Duck Sauce.png', '531', 1),
(503, 'Gochujang', 'http://www.themealdb.com/images/ingredients/Gochujang.png', '532', 1),
(504, 'Bean Sprouts', 'http://www.themealdb.com/images/ingredients/Bean Sprouts.png', '533', 1),
(505, 'Noodles', 'http://www.themealdb.com/images/ingredients/Noodles.png', '534', 1),
(506, 'Wood Ear Mushrooms', 'http://www.themealdb.com/images/ingredients/Wood Ear Mushrooms.png', '535', 1),
(507, 'Dark Rum', 'http://www.themealdb.com/images/ingredients/Dark Rum.png', '536', 1),
(508, 'Light Rum', 'http://www.themealdb.com/images/ingredients/Light Rum.png', '537', 1),
(509, 'Rum', 'http://www.themealdb.com/images/ingredients/Rum.png', '538', 1),
(510, 'English Muffins', 'http://www.themealdb.com/images/ingredients/English Muffins.png', '539', 1),
(511, 'Muffins', 'http://www.themealdb.com/images/ingredients/Muffins.png', '540', 1),
(512, 'White Wine Vinegar', 'http://www.themealdb.com/images/ingredients/White Wine Vinegar.png', '541', 1),
(513, 'Smoked Salmon', 'http://www.themealdb.com/images/ingredients/Smoked Salmon.png', '542', 1),
(514, 'Mars Bar', 'http://www.themealdb.com/images/ingredients/Mars Bar.png', '543', 1),
(515, 'Rice Krispies', 'http://www.themealdb.com/images/ingredients/Rice Krispies.png', '544', 1),
(516, 'Ancho Chillies', 'http://www.themealdb.com/images/ingredients/Ancho Chillies.png', '545', 1),
(517, 'Almond Milk', 'http://www.themealdb.com/images/ingredients/Almond Milk.png', '546', 1),
(518, 'Allspice', 'http://www.themealdb.com/images/ingredients/Allspice.png', '548', 1),
(519, 'Almond Extract', 'http://www.themealdb.com/images/ingredients/Almond Extract.png', '550', 1),
(520, 'Tripe', 'http://www.themealdb.com/images/ingredients/Tripe.png', '552', 1),
(521, 'Goat Meat', 'http://www.themealdb.com/images/ingredients/Goat Meat.png', '553', 1),
(522, 'Black Beans', 'http://www.themealdb.com/images/ingredients/Black Beans.png', '554', 1),
(523, 'Anchovy Fillet', 'http://www.themealdb.com/images/ingredients/Anchovy Fillet.png', '555', 1),
(524, 'Ras el hanout', 'http://www.themealdb.com/images/ingredients/Ras el hanout.png', '556', 1),
(525, 'Filo Pastry', 'http://www.themealdb.com/images/ingredients/Filo Pastry.png', '557', 1),
(526, 'Orange Blossom Water', 'http://www.themealdb.com/images/ingredients/Orange Blossom Water.png', '558', 1),
(527, 'Candied Peel', 'http://www.themealdb.com/images/ingredients/Candied Peel.png', '559', 1),
(528, 'Grand Marnier', 'http://www.themealdb.com/images/ingredients/Grand Marnier.png', '560', 1),
(529, 'Sherry', 'http://www.themealdb.com/images/ingredients/Sherry.png', '561', 1),
(530, 'Rose water', 'http://www.themealdb.com/images/ingredients/Rose water.png', '562', 1),
(531, 'Mixed Spice', 'http://www.themealdb.com/images/ingredients/Mixed Spice.png', '563', 1),
(532, 'Mincemeat', 'http://www.themealdb.com/images/ingredients/Mincemeat.png', '564', 1),
(533, 'Sweet Potatoes', 'http://www.themealdb.com/images/ingredients/Sweet Potatoes.png', '565', 1),
(534, 'Bread Rolls', 'http://www.themealdb.com/images/ingredients/Bread Rolls.png', '566', 1),
(535, 'Bun', 'http://www.themealdb.com/images/ingredients/Bun.png', '567', 1),
(536, 'Potatoe Buns', 'http://www.themealdb.com/images/ingredients/Potatoe Buns.png', '568', 1),
(537, 'Ground Pork', 'http://www.themealdb.com/images/ingredients/Ground Pork.png', '569', 1);
INSERT INTO `adminuser_ingredient` (`id`, `name`, `image`, `id_ingrediant`, `is_active`) VALUES
(538, 'Pork Chops', 'http://www.themealdb.com/images/ingredients/Pork Chops.png', '570', 1),
(539, 'Yukon Gold Potatoes', 'http://www.themealdb.com/images/ingredients/Yukon Gold Potatoes.png', '571', 1),
(540, 'Yellow Onion', 'http://www.themealdb.com/images/ingredients/Yellow Onion.png', '572', 1),
(541, 'Beef Stock Concentrate', 'http://www.themealdb.com/images/ingredients/Beef Stock Concentrate.png', '573', 1),
(542, 'Chicken Stock Concentrate', 'http://www.themealdb.com/images/ingredients/Chicken Stock Concentrate.png', '574', 1),
(543, 'Persian Cucumber', 'http://www.themealdb.com/images/ingredients/Persian Cucumber.png', '575', 1),
(544, 'Mayonnaise', 'http://www.themealdb.com/images/ingredients/Mayonnaise.png', '576', 1),
(545, 'Sriracha', 'http://www.themealdb.com/images/ingredients/Sriracha.png', '577', 1),
(546, 'Rhubarb', 'http://www.themealdb.com/images/ingredients/Rhubarb.png', '578', 1),
(547, 'Pita Bread', 'http://www.themealdb.com/images/ingredients/Pita Bread.png', '579', 1),
(548, 'Bulgur Wheat', 'http://www.themealdb.com/images/ingredients/Bulgur Wheat.png', '580', 1),
(549, 'Quinoa', 'http://www.themealdb.com/images/ingredients/Quinoa.png', '581', 1),
(550, 'Dill Pickles', 'http://www.themealdb.com/images/ingredients/Dill Pickles.png', '582', 1),
(551, 'Sesame Seed Burger Buns', 'http://www.themealdb.com/images/ingredients/Sesame Seed Burger Buns.png', '583', 1),
(552, 'Buns', 'http://www.themealdb.com/images/ingredients/Buns.png', '585', 1),
(553, 'Iceberg Lettuce', 'http://www.themealdb.com/images/ingredients/Iceberg Lettuce.png', '586', 1),
(554, 'Gherkin Relish', 'http://www.themealdb.com/images/ingredients/Gherkin Relish.png', '587', 1),
(555, 'Cheese Slices', 'http://www.themealdb.com/images/ingredients/Cheese Slices.png', '588', 1),
(556, 'Shortening', 'http://www.themealdb.com/images/ingredients/Shortening.png', '589', 1),
(557, 'Warm Water', 'http://www.themealdb.com/images/ingredients/Warm Water.png', '590', 1),
(558, 'Boiling Water', 'http://www.themealdb.com/images/ingredients/Boiling Water.png', '591', 1),
(559, 'Pickle Juice', 'http://www.themealdb.com/images/ingredients/Pickle Juice.png', '592', 1),
(560, 'Powdered Sugar', 'http://www.themealdb.com/images/ingredients/Powdered Sugar.png', '593', 1),
(561, 'Kielbasa', 'http://www.themealdb.com/images/ingredients/Kielbasa.png', '594', 1),
(562, 'Polish Sausage', 'http://www.themealdb.com/images/ingredients/Polish Sausage.png', '595', 1),
(563, 'Sauerkraut', 'http://www.themealdb.com/images/ingredients/Sauerkraut.png', '596', 1),
(564, 'Caraway Seed', 'http://www.themealdb.com/images/ingredients/Caraway Seed.png', '597', 1),
(565, 'Herring', 'http://www.themealdb.com/images/ingredients/Herring.png', '598', 1),
(566, 'Jam', 'http://www.themealdb.com/images/ingredients/Jam.png', '599', 1),
(567, 'Mulukhiyah', 'http://www.themealdb.com/images/ingredients/Mulukhiyah.png', '600', 1),
(568, 'Sushi Rice', 'http://www.themealdb.com/images/ingredients/Sushi Rice.png', '601', 1),
(569, 'Figs', 'http://www.themealdb.com/images/ingredients/Figs.png', '602', 1),
(570, 'Cider', 'http://www.themealdb.com/images/ingredients/Cider.png', '603', 1),
(571, 'Beetroot', 'http://www.themealdb.com/images/ingredients/Beetroot.png', '604', 1),
(572, 'Sardines', 'http://www.themealdb.com/images/ingredients/Sardines.png', '605', 1),
(573, 'Ciabatta', 'http://www.themealdb.com/images/ingredients/Ciabatta.png', '606', 1),
(574, 'Buckwheat', 'http://www.themealdb.com/images/ingredients/Buckwheat.png', '607', 1),
(575, 'dfhrty', '', NULL, 1),
(576, 'jkdh', '', NULL, 1),
(577, 'fdg', '', NULL, 1),
(578, 'minced onion', '', NULL, 1),
(579, 'cumin powder', '', NULL, 1),
(580, 'coriander powder', '', NULL, 1),
(581, 'fghfgh', '', NULL, 1),
(582, 'dfghfghj', '', NULL, 1),
(583, 'ghjfgh', '', NULL, 1),
(584, 'ghdfh', '', NULL, 1),
(585, 'dfgs', '', NULL, 1),
(586, 'sdfgs', '', NULL, 1),
(587, 'dfgsfg', '', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_payments`
--

CREATE TABLE `adminuser_payments` (
  `id` bigint(20) NOT NULL,
  `Amount` int(11) NOT NULL,
  `date` date NOT NULL,
  `payment_intent` varchar(3500) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser_payments`
--

INSERT INTO `adminuser_payments` (`id`, `Amount`, `date`, `payment_intent`, `user_id`) VALUES
(1, 100, '2023-08-14', 'pi_3NexPFSFsSlbXURk0WFiakvZ', 2),
(2, 100, '2023-08-16', 'pi_3NfcXaSFsSlbXURk0pGawcaZ', 2),
(3, 100, '2023-08-16', 'pi_3NfcuPSFsSlbXURk0ogM33Wc', 2),
(4, 100, '2023-08-17', 'pi_3NfybHSFsSlbXURk1LvsYnZB', 2),
(5, 100, '2023-08-18', 'pi_3NgKqRSFsSlbXURk19WntZLv', 3),
(6, 50, '2023-08-23', 'pi_3NiA2tSFsSlbXURk0rPFuGr3', 7),
(7, 999999, '2023-08-23', 'pi_3NiA4dSFsSlbXURk14m7Uy0l', 7),
(8, 1, '2023-08-23', 'pi_3NiAugSFsSlbXURk0ANx2ltb', 3),
(9, 100, '2023-08-23', 'pi_3NiHF7SFsSlbXURk1RaPcF3D', 3),
(10, 100, '2023-08-23', 'pi_3NiHFMSFsSlbXURk0MbJCHZo', 3),
(11, 1000, '2023-08-26', 'pi_3NjOVHSFsSlbXURk0H7RIAJ4', 8),
(12, 50, '2023-08-28', 'pi_3NjxVBSFsSlbXURk0SAYr6uX', 2),
(13, 50, '2023-08-28', 'pi_3NjyEkSFsSlbXURk1QcVS4DX', 2),
(14, 100, '2023-10-12', 'pi_3O0K9xSFsSlbXURk0j9XmtAC', 2);

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_rating`
--

CREATE TABLE `adminuser_rating` (
  `id` bigint(20) NOT NULL,
  `rating` int(11) NOT NULL,
  `recipe_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser_rating`
--

INSERT INTO `adminuser_rating` (`id`, `rating`, `recipe_id`, `user_id`) VALUES
(1, 1, 26, 2),
(2, 3, 24, 3),
(3, 5, 53, 1),
(4, 5, 114, 2),
(5, 5, 85, 2),
(6, 1, 53, 2),
(7, 5, 39, 2),
(8, 5, 92, 7),
(9, 5, 61, 2),
(10, 5, 114, 3),
(11, 4, 103, 8),
(12, 4, 100, 2);

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_recipe`
--

CREATE TABLE `adminuser_recipe` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `thumbnail` varchar(100) NOT NULL,
  `idMeal` varchar(255) DEFAULT NULL,
  `calculated_rating` double NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `description` longtext NOT NULL,
  `youtube_link` varchar(255) DEFAULT NULL,
  `dateModified` date NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser_recipe`
--

INSERT INTO `adminuser_recipe` (`id`, `name`, `thumbnail`, `idMeal`, `calculated_rating`, `is_approved`, `description`, `youtube_link`, `dateModified`, `is_active`, `category_id`, `user_id`) VALUES
(1, 'Brown Stew Chicken', 'https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg', '52940', 0, 1, 'Squeeze lime over chicken and rub well. Drain off excess lime juice.\r\nCombine tomato, scallion, onion, garlic, pepper, thyme, pimento and soy sauce in a large bowl with the chicken pieces. Cover and marinate at least one hour.\r\nHeat oil in a dutch pot or large saucepan. Shake off the seasonings as you remove each piece of chicken from the marinade. Reserve the marinade for sauce.\r\nLightly brown the chicken a few pieces at a time in very hot oil. Place browned chicken pieces on a plate to rest while you brown the remaining pieces.\r\nDrain off excess oil and return the chicken to the pan. Pour the marinade over the chicken and add the carrots. Stir and cook over medium heat for 10 minutes.\r\nMix flour and coconut milk and add to stew, stirring constantly. Turn heat down to minimum and cook another 20 minutes or until tender.', 'https://www.youtube.com/watch?v=_gFB1fkNhXs', '2023-08-14', 1, 2, 3),
(2, 'Chicken Handi', 'https://www.themealdb.com/images/media/meals/wyxwsp1486979827.jpg', '52795', 0, 1, 'Take a large pot or wok, big enough to cook all the chicken, and heat the oil in it. Once the oil is hot, add sliced onion and fry them until deep golden brown. Then take them out on a plate and set aside.\r\nTo the same pot, add the chopped garlic and sauté for a minute. Then add the chopped tomatoes and cook until tomatoes turn soft. This would take about 5 minutes.\r\nThen return the fried onion to the pot and stir. Add ginger paste and sauté well.\r\nNow add the cumin seeds, half of the coriander seeds and chopped green chillies. Give them a quick stir.\r\nNext goes in the spices – turmeric powder and red chilli powder. Sauté the spices well for couple of minutes.\r\nAdd the chicken pieces to the wok, season it with salt to taste and cook the chicken covered on medium-low heat until the chicken is almost cooked through. This would take about 15 minutes. Slowly sautéing the chicken will enhance the flavor, so do not expedite this step by putting it on high heat.\r\nWhen the oil separates from the spices, add the beaten yogurt keeping the heat on lowest so that the yogurt doesn’t split. Sprinkle the remaining coriander seeds and add half of the dried fenugreek leaves. Mix well.\r\nFinally add the cream and give a final mix to combine everything well.\r\nSprinkle the remaining kasuri methi and garam masala and serve the chicken handi hot with naan or rotis. Enjoy!', 'https://www.youtube.com/watch?v=IO0issT0Rmc', '2023-08-14', 1, 2, 3),
(3, 'Chicken Congee', 'https://www.themealdb.com/images/media/meals/1529446352.jpg', '52956', 0, 1, 'STEP 1 - MARINATING THE CHICKEN\r\nIn a bowl, add chicken, salt, white pepper, ginger juice and then mix it together well.\r\nSet the chicken aside.\r\nSTEP 2 - RINSE THE WHITE RICE\r\nRinse the rice in a metal bowl or pot a couple times and then drain the water.\r\nSTEP 2 - BOILING THE WHITE RICE\r\nNext add 8 cups of water and then set the stove on high heat until it is boiling. Once rice porridge starts to boil, set the stove on low heat and then stir it once every 8-10 minutes for around 20-25 minutes.\r\nAfter 25 minutes, this is optional but you can add a little bit more water to make rice porridge to make it less thick or to your preference.\r\nNext add the marinated chicken to the rice porridge and leave the stove on low heat for another 10 minutes.\r\nAfter an additional 10 minutes add the green onions, sliced ginger, 1 pinch of salt, 1 pinch of white pepper and stir for 10 seconds.\r\nServe the rice porridge in a bowl\r\nOptional: add Coriander on top of the rice porridge.', 'https://www.youtube.com/watch?v=kqEfk801E94', '2023-08-16', 1, 2, 3),
(4, 'Chicken Karaage', 'https://www.themealdb.com/images/media/meals/tyywsw1505930373.jpg', '52831', 0, 1, 'Add the ginger, garlic, soy sauce, sake and sugar to a bowl and whisk to combine. Add the chicken, then stir to coat evenly. Cover and refrigerate for at least 1 hour.\r\n\r\nAdd 1 inch of vegetable oil to a heavy bottomed pot and heat until the oil reaches 360 degrees F. Line a wire rack with 2 sheets of paper towels and get your tongs out. Put the potato starch in a bowl\r\n\r\nAdd a handful of chicken to the potato starch and toss to coat each piece evenly.\r\n\r\nFry the karaage in batches until the exterior is a medium brown and the chicken is cooked through. Transfer the fried chicken to the paper towel lined rack. If you want the karaage to stay crispy longer, you can fry the chicken a second time, until it\'s a darker color after it\'s cooled off once. Serve with lemon wedges.', 'https://www.youtube.com/watch?v=XivddFddthc', '2023-08-16', 1, 2, 3),
(5, 'Chicken Marengo', 'https://www.themealdb.com/images/media/meals/qpxvuq1511798906.jpg', '52920', 0, 1, 'Heat the oil in a large flameproof casserole dish and stir-fry the mushrooms until they start to soften. Add the chicken legs and cook briefly on each side to colour them a little.\r\nPour in the passata, crumble in the stock cube and stir in the olives. Season with black pepper – you shouldn’t need salt. Cover and simmer for 40 mins until the chicken is tender. Sprinkle with parsley and serve with pasta and a salad, or mash and green veg, if you like.', 'https://www.youtube.com/watch?v=U33HYUr-0Fw', '2023-08-16', 1, 2, 3),
(6, 'Tandoori chicken', 'https://www.themealdb.com/images/media/meals/qptpvt1487339892.jpg', '52806', 0, 1, 'Mix the lemon juice with the paprika and red onions in a large shallow dish. Slash each chicken thigh three times, then turn them in the juice and set aside for 10 mins.\r\nMix all of the marinade ingredients together and pour over the chicken. Give everything a good mix, then cover and chill for at least 1 hr. This can be done up to a day in advance.\r\nHeat the grill. Lift the chicken pieces onto a rack over a baking tray. Brush over a little oil and grill for 8 mins on each side or until lightly charred and completely cooked through.', 'https://www.youtube.com/watch?v=-CKvt1KNU74', '2023-08-16', 1, 2, 3),
(7, 'Kung Pao Chicken', 'https://www.themealdb.com/images/media/meals/1525872624.jpg', '52945', 0, 1, 'Combine the sake or rice wine, soy sauce, sesame oil and cornflour dissolved in water. Divide mixture in half.\r\nIn a glass dish or bowl, combine half of the sake mixture with the chicken pieces and toss to coat. Cover dish and place in refrigerator for about 30 minutes.\r\nIn a medium frying pan, combine remaining sake mixture, chillies, vinegar and sugar. Mix together and add spring onion, garlic, water chestnuts and peanuts. Heat sauce slowly over medium heat until aromatic.\r\nMeanwhile, remove chicken from marinade and sauté in a large frying pan until juices run clear. When sauce is aromatic, add sautéed chicken and let simmer together until sauce thickens.', 'https://www.youtube.com/watch?v=QqdcCHQlOe0', '2023-08-16', 1, 2, 3),
(8, 'Mediterranean Pasta Salad', 'https://www.themealdb.com/images/media/meals/wvqpwt1468339226.jpg', '52777', 0, 1, 'Bring a large saucepan of salted water to the boil\r\nAdd the pasta, stir once and cook for about 10 minutes or as directed on the packet.\r\nMeanwhile, wash the tomatoes and cut into quarters. Slice the olives. Wash the basil.\r\nPut the tomatoes into a salad bowl and tear the basil leaves over them. Add a tablespoon of olive oil and mix.\r\nWhen the pasta is ready, drain into a colander and run cold water over it to cool it quickly.\r\nToss the pasta into the salad bowl with the tomatoes and basil.\r\nAdd the sliced olives, drained mozzarella balls, and chunks of tuna. Mix well and let the salad rest for at least half an hour to allow the flavours to mingle.\r\nSprinkle the pasta with a generous grind of black pepper and drizzle with the remaining olive oil just before serving.', 'https://www.youtube.com/watch?v=e52IL8zYmaE', '2023-08-16', 1, 17, 3),
(9, 'Tonkatsu pork', 'https://www.themealdb.com/images/media/meals/lwsnkl1604181187.jpg', '53032', 0, 1, 'STEP 1\r\nRemove the large piece of fat on the edge of each pork loin, then bash each of the loins between two pieces of baking parchment until around 1cm in thickness – you can do this using a meat tenderiser or a rolling pin. Once bashed, use your hands to reshape the meat to its original shape and thickness – this step will ensure the meat is as succulent as possible.\r\n\r\nSTEP 2\r\nPut the flour, eggs and panko breadcrumbs into three separate wide-rimmed bowls. Season the meat, then dip first in the flour, followed by the eggs, then the breadcrumbs.\r\n\r\nSTEP 3\r\nIn a large frying or saute? pan, add enough oil to come 2cm up the side of the pan. Heat the oil to 180C – if you don’t have a thermometer, drop a bit of panko into the oil and if it sinks a little then starts to fry, the oil is ready. Add two pork chops and cook for 1 min 30 secs on each side, then remove and leave to rest on a wire rack for 5 mins. Repeat with the remaining pork chops.\r\n\r\nSTEP 4\r\nWhile the pork is resting, make the sauce by whisking the ingredients together, adding a splash of water if it’s particularly thick. Slice the tonkatsu and serve drizzled with the sauce.', 'https://www.youtube.com/watch?v=aASr5x0d3Ys', '2023-08-16', 1, 7, 3),
(10, 'BBQ Pork Sloppy Joes', 'https://www.themealdb.com/images/media/meals/atd5sh1583188467.jpg', '52995', 0, 1, '1\r\n\r\nPreheat oven to 450 degrees. Wash and dry all produce. Cut sweet potatoes into ½-inch-thick wedges. Toss on a baking sheet with a drizzle of oil, salt, and pepper. Roast until browned and tender, 20-25 minutes.\r\n\r\n2\r\n\r\nMeanwhile, halve and peel onion. Slice as thinly as possible until you have ¼ cup (½ cup for 4 servings); finely chop remaining onion. Peel and finely chop garlic. Halve lime; squeeze juice into a small bowl. Halve buns. Add 1 TBSP butter (2 TBSP for 4) to a separate small microwave-safe bowl; microwave until melted, 30 seconds. Brush onto cut sides of buns.\r\n\r\n3\r\n\r\nTo bowl with lime juice, add sliced onion, ¼ tsp sugar (½ tsp for 4 servings), and a pinch of salt. Stir to combine; set aside to quick-pickle.\r\n\r\n4\r\n\r\nHeat a drizzle of oil in a large pan over medium-high heat. Add chopped onion and season with salt and pepper. Cook, stirring, until softened, 4-5 minutes. Add garlic and cook until fragrant, 30 seconds more. Add pork and season with salt and pepper. Cook, breaking up meat into pieces, until browned and cooked through, 4-6 minutes.\r\n\r\n5\r\n\r\nWhile pork cooks, in a third small bowl, combine BBQ sauce, pickling liquid from onion, 3 TBSP ketchup (6 TBSP for 4 servings), ½ tsp sugar (1 tsp for 4), and ¼ cup water (? cup for 4). Once pork is cooked through, add BBQ sauce mixture to pan. Cook, stirring, until sauce is thickened, 2-3 minutes. Taste and season with salt and pepper.\r\n\r\n6\r\n\r\nMeanwhile, toast buns in oven or toaster oven until golden, 3-5 minutes. Divide toasted buns between plates and fill with as much BBQ pork as you’d like. Top with pickled onion and hot sauce. Serve with sweet potato wedges on the side.', '', '2023-08-16', 1, 7, 3),
(11, ' Bubble & Squeak', 'https://www.themealdb.com/images/media/meals/xusqvw1511638311.jpg', '52885', 0, 1, 'Melt the fat in a non-stick pan, allow it to get nice and hot, then add the bacon. As it begins to brown, add the onion and garlic. Next, add the sliced sprouts or cabbage and let it colour slightly. All this will take 5-6 mins.\r\nNext, add the potato. Work everything together in the pan and push it down so that the mixture covers the base of the pan – allow the mixture to catch slightly on the base of the pan before turning it over and doing the same again. It’s the bits of potato that catch in the pan that define the term ‘bubble and squeak’, so be brave and let the mixture colour. Cut into wedges and serve.', 'https://www.youtube.com/watch?v=etbJ9ssgsWY', '2023-08-16', 1, 7, 3),
(12, 'Apple & Blackberry Crumble', 'https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg', '52893', 0, 1, 'Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. Add the butter, then rub into the flour using your fingertips to make a light breadcrumb texture. Do not overwork it or the crumble will become heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins or until lightly coloured.\r\nMeanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put the butter and sugar in a medium saucepan and melt together over a medium heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to continue cooking in the warmth of the pan.\r\nTo serve, spoon the warm fruit into an ovenproof gratin dish, top with the crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice cream.', 'https://www.youtube.com/watch?v=4vhcOwVBDO4', '2023-08-16', 1, 15, 3),
(13, 'Baingan Bharta', 'https://www.themealdb.com/images/media/meals/urtpqw1487341253.jpg', '52807', 0, 1, 'Rinse the baingan (eggplant or aubergine) in water. Pat dry with a kitchen napkin. Apply some oil all over and\r\nkeep it for roasting on an open flame. You can also grill the baingan or roast in the oven. But then you won\'t get\r\nthe smoky flavor of the baingan. Keep the eggplant turning after a 2 to 3 minutes on the flame, so that its evenly\r\ncooked. You could also embed some garlic cloves in the baingan and then roast it.\r\n2. Roast the aubergine till its completely cooked and tender. With a knife check the doneness. The knife should slid\r\neasily in aubergines without any resistance. Remove the baingan and immerse in a bowl of water till it cools\r\ndown.\r\n3. You can also do the dhungar technique of infusing charcoal smoky flavor in the baingan. This is an optional step.\r\nUse natural charcoal for this method. Heat a small piece of charcoal on flame till it becomes smoking hot and red.\r\n4. Make small cuts on the baingan with a knife. Place the red hot charcoal in the same plate where the roasted\r\naubergine is kept. Add a few drops of oil on the charcoal. The charcoal would begin to smoke.\r\n5. As soon as smoke begins to release from the charcoal, cover the entire plate tightly with a large bowl. Allow the\r\ncharcoal smoke to get infused for 1 to 2 minutes. The more you do, the more smoky the baingan bharta will\r\nbecome. I just keep for a minute. Alternatively, you can also do this dhungar method once the baingan bharta is\r\ncooked, just like the way we do for Dal Tadka.\r\n6. Peel the skin from the roasted and smoked eggplant.\r\n7. Chop the cooked eggplant finely or you can even mash it.\r\n8. In a kadai or pan, heat oil. Then add finely chopped onions and garlic.\r\n9. Saute the onions till translucent. Don\'t brown them.\r\n10. Add chopped green chilies and saute for a minute.\r\n11. Add the chopped tomatoes and mix it well.\r\n12. Bhuno (saute) the tomatoes till the oil starts separating from the mixture.\r\n13. Now add the red chili powder. Stir and mix well.\r\n14. Add the chopped cooked baingan.\r\n15. Stir and mix the chopped baingan very well with the onion­tomato masala mixture.\r\n16. Season with salt. Stir and saute for some more 4 to 5 minutes more.\r\n17. Finally stir in the coriander leaves with the baingan bharta or garnish it with them. Serve Baingan Bharta with\r\nphulkas, rotis or chapatis. It goes well even with bread, toasted or grilled bread and plain rice or jeera rice.', 'https://www.youtube.com/watch?v=-84Zz2EP4h4', '2023-08-16', 1, 12, 3),
(14, 'Vietnamese Grilled Pork (bun-thit-nuong)', 'https://www.themealdb.com/images/media/meals/qqwypw1504642429.jpg', '52828', 0, 1, 'Slice the uncooked pork thinly, about ?\". It helps to slightly freeze it (optional).\r\nMince garlic and shallots. Mix in a bowl with sugar, fish sauce, thick soy sauce, pepper, and oil until sugar dissolves.\r\nMarinate the meat for 1 hour, or overnight for better results.\r\nBake the pork at 375F for 10-15 minutes or until about 80% cooked. Finish cooking by broiling in the oven until a nice golden brown color develops, flipping the pieces midway.\r\nAssemble your bowl with veggies, noodles, and garnish. Many like to mix the whole bowl up and pour the fish sauce on top, but I like to make individual bites and sauce it slowly.', 'https://www.youtube.com/watch?v=Q3qcQcENzbU', '2023-08-16', 1, 7, 3),
(15, 'Pork Cassoulet', 'https://www.themealdb.com/images/media/meals/wxuvuv1511299147.jpg', '52847', 0, 1, 'Heat oven to 140C/120C fan/gas 1. Put a large ovenproof pan (with a tight-fitting lid) on a high heat. Add your fat and diced meat, cook for a few mins to seal the edges, giving it a quick stir to cook evenly. Reduce the heat to low, add the sliced onion, whole garlic cloves, carrot and fennel seeds, and cook gently to soften the veg for a few mins.\r\nPour over the red wine vinegar, scraping any meaty bits off the bottom of the pan. Add the stock, tomato purée, and half the rosemary and parsley. Bring to the boil and simmer for 10 mins, then season, cover with a lid and put into the oven for 2 hrs, removing the lid for the final hour of cooking. Stir occasionally and add the beans with 30 mins to go.\r\nRemove the pan from the oven and heat the grill. Scatter the top with the remaining herbs and breadcrumbs, drizzle a little oil over the top, and return to the oven for 5-10 mins, until the breadcrumbs are golden. Serve with crusty bread and green veg.', 'https://www.youtube.com/watch?v=MEdHMTD0VCA', '2023-08-16', 1, 7, 3),
(16, 'Sweet and Sour Pork', 'https://www.themealdb.com/images/media/meals/1529442316.jpg', '52949', 0, 1, 'Preparation\r\n1. Crack the egg into a bowl. Separate the egg white and yolk.\r\n\r\nSweet and Sour Pork\r\n2. Slice the pork tenderloin into strips.\r\n\r\n3. Prepare the marinade using a pinch of salt, one teaspoon of starch, two teaspoons of light soy sauce, and an egg white.\r\n\r\n4. Marinade the pork strips for about 20 minutes.\r\n\r\n5. Put the remaining starch in a bowl. Add some water and vinegar to make a starchy sauce.\r\n\r\nSweet and Sour Pork\r\nCooking Instructions\r\n1. Pour the cooking oil into a wok and heat to 190°C (375°F). Add the marinated pork strips and fry them until they turn brown. Remove the cooked pork from the wok and place on a plate.\r\n\r\n2. Leave some oil in the wok. Put the tomato sauce and white sugar into the wok, and heat until the oil and sauce are fully combined.\r\n\r\n3. Add some water to the wok and thoroughly heat the sweet and sour sauce before adding the pork strips to it.\r\n\r\n4. Pour in the starchy sauce. Stir-fry all the ingredients until the pork and sauce are thoroughly mixed together.\r\n\r\n5. Serve on a plate and add some coriander for decoration.', 'https://www.youtube.com/watch?v=mdaBIhgEAMo', '2023-08-16', 1, 7, 3),
(17, 'Coddled pork with cider', 'https://www.themealdb.com/images/media/meals/7vpsfp1608588991.jpg', '53037', 0, 1, 'STEP 1\r\nHeat the butter in a casserole dish until sizzling, then fry the pork for 2-3 mins on each side until browned. Remove from the pan.\r\n\r\nSTEP 2\r\nTip the bacon, carrot, potatoes and swede into the pan, then gently fry until slightly coloured. Stir in the cabbage, sit the chops back on top, add the bay leaf, then pour over the cider and stock. Cover the pan, then leave everything to gently simmer for 20 mins until the pork is cooked through and the vegetables are tender.\r\n\r\nSTEP 3\r\nServe at the table spooned straight from the dish.', 'https://www.youtube.com/watch?v=ftn_4mc-65o', '2023-08-16', 1, 7, 3),
(18, 'Skillet Apple Pork Chops with Roasted Sweet Potatoes & Zucchini', 'https://www.themealdb.com/images/media/meals/h3ijwo1581013377.jpg', '52994', 0, 1, '\r\nServes 2\r\n\r\n\r\n1. \r\n\r\nAdjust racks to top and middle positions and preheat oven to 450 degrees. Wash and dry all produce. Dice sweet potatoes into 1/2-inch pieces. Toss on a baking sheet with a drizzle of oil, salt, and pepper. Roast on top rack for 12 minutes (we\'ll roast the zucchini then). \r\n\r\n\r\n2. \r\n\r\nMeanwhile, halve and core apple; thinly slice into half-moons. Peel and finely chop garlic. Quarter lemon. Trim and halve zucchini lengthwise; cut crosswise into 1/2-inch-thick half-moons. Toss on a second baking sheet with a drizzle of oil and a pinch of salt and pepper. Set aside. \r\n\r\n\r\n3. \r\n\r\nPat pork dry with paper towels and season all over with salt and pepper. Heat a drizzle of oil in a large pan over medium-high heat. Add pork and cook until browned and cooked through, 4-5 minutes per side. Turn off heat; transfer to a plate. \r\n\r\n\r\n4. \r\n\r\nOnce sweet potatoes have roasted 12 minutes, transfer baking sheet with zucchini to middle rack and continue roasting until both veggies are browned and softened, 12-15 minutes more. \r\n\r\n\r\n5. \r\n\r\nMeanwhile, melt 1 TBSP butter (2 TBSP for 4 servings) in pan used for pork over medium-high heat. Add apple and season with salt and pepper. Cook, scraping up any browned bits from bottom of pan, until apple is slightly softened, 2-3 minutes. Add garlic; cook until fragrant, 30 seconds. Add 1/z cup water (3/4 cup for 4), stock concentrate, and 11/2 tsp sugar (3 tsp for 4). Cook, stirring, until sauce has thickened and apple is very tender, 3-5 minutes. Season with salt and pepper. \r\n\r\n\r\n6. \r\n\r\nRemove pan with apple from heat; stir in 1 TBSP butter (2 TBSP for 4 servings) and a squeeze of lemon juice. Divide pork, zucchini, and sweet potatoes between plates. Top pork with glazed apple sauce. Top zucchini with a squeeze of lemon juice. ', '', '2023-08-16', 1, 7, 3),
(19, 'Portuguese barbecued pork (Febras assadas)', 'https://www.themealdb.com/images/media/meals/cybyue1614349443.jpg', '53044', 0, 1, 'STEP 1\r\n\r\nCut the tenderloins into 5 equal-size pieces leaving the tail ends a little longer. Take a clear plastic bag and slip one of the pieces in. Bash it into an escalope the size of a side-plate with a rolling pin and repeat with the remaining pieces.\r\n\r\nSTEP 2\r\n\r\nPut the wine, paprika, some salt and pepper and the juice of ½ a lemon in a bowl and add the pork. Leave to marinate for 20-30 minutes, while you get your barbecue to the stage where the coals are glowing but there are no flames.\r\n\r\nSTEP 3\r\n\r\nTo make the chips, fill a basin with cool water and cut the potatoes into 3cm-thick chips. Soak them in the water for 5 minutes and then change the water. Leave for 5 more minutes. Drain and then pat dry on a towel or with kitchen paper.\r\n\r\nSTEP 4\r\n\r\nHeat the oil in a deep fryer or a deep heavy-based pan with a lid to 130C and lower the chips into the oil (in batches). Blanch for 8-10 minutes. Remove from the oil and drain well. Place on a tray to cool. Reheat the oil to 180C (make sure it’s hot or your chips will be soggy) and lower the basket of chips into the oil (again, do this in batches). Leave to cook for 2 minutes and then give them a little shake. Cook for another minute or so until they are well coloured and crisp to the touch. Drain well for a few minutes, tip into a bowl and sprinkle with sea salt.\r\n\r\nSTEP 5\r\n\r\nThe pork will cook quickly so do it in 2 batches. Take the pieces out of the marinade, rub them with oil, and drop them onto the barbecue (you could also use a chargrill). Cook for 1 minute on each side – they may flare up as you do so. This should really be enough time as they will keep on cooking. Take them off the barbecue and pile onto a plate. Repeat with the remaining batch.\r\n\r\nSTEP 6\r\n\r\nServe by piling a plate with chips, drop the pork on top of each pile and pouring the juices from the plate over so the chips take up the flavours. Top with a spoon of mayonnaise and a wedge of lemon.', 'https://www.youtube.com/watch?v=tVpsZaejyYU', '2023-08-16', 1, 7, 3),
(20, 'Bigos (Hunters Stew)', 'https://www.themealdb.com/images/media/meals/md8w601593348504.jpg', '53018', 0, 1, 'Preheat the oven to 350 degrees F (175 degrees C).\r\n\r\nHeat a large pot over medium heat. Add the bacon and kielbasa; cook and stir until the bacon has rendered its fat and sausage is lightly browned. Use a slotted spoon to remove the meat and transfer to a large casserole or Dutch oven.\r\n\r\nCoat the cubes of pork lightly with flour and fry them in the bacon drippings over medium-high heat until golden brown. Use a slotted spoon to transfer the pork to the casserole. Add the garlic, onion, carrots, fresh mushrooms, cabbage and sauerkraut. Reduce heat to medium; cook and stir until the carrots are soft, about 10 minutes. Do not let the vegetables brown.\r\n\r\nDeglaze the pan by pouring in the red wine and stirring to loosen all of the bits of food and flour that are stuck to the bottom. Season with the bay leaf, basil, marjoram, paprika, salt, pepper, caraway seeds and cayenne pepper; cook for 1 minute.\r\n\r\nMix in the dried mushrooms, hot pepper sauce, Worcestershire sauce, beef stock, tomato paste and tomatoes. Heat through just until boiling. Pour the vegetables and all of the liquid into the casserole dish with the meat. Cover with a lid.\r\n\r\nBake in the preheated oven for 2 1/2 to 3 hours, until meat is very tender.', 'https://www.youtube.com/watch?v=Oqg_cO4s8ik', '2023-08-16', 1, 7, 3),
(21, 'Hot and Sour Soup', 'https://www.themealdb.com/images/media/meals/1529445893.jpg', '52954', 0, 1, 'STEP 1 - MAKING THE SOUP\r\nIn a wok add chicken broth and wait for it to boil.\r\nNext add salt, sugar, sesame seed oil, white pepper, hot pepper sauce, vinegar and soy sauce and stir for few seconds.\r\nAdd Tofu, mushrooms, black wood ear mushrooms to the wok.\r\nTo thicken the sauce, whisk together 1 Tablespoon of cornstarch and 2 Tablespoon of water in a bowl and slowly add to your soup until it\'s the right thickness.\r\nNext add 1 egg slightly beaten with a knife or fork and add it to the soup and stir for 8 seconds\r\nServe the soup in a bowl and add the bbq pork and sliced green onions on top.', 'https://www.youtube.com/watch?v=KgV9Zq3aSTo', '2023-08-16', 1, 7, 3),
(22, 'Japanese Katsudon', 'https://www.themealdb.com/images/media/meals/d8f6qx1604182128.jpg', '53034', 0, 1, 'STEP 1\r\nHeat the oil in a pan, fry the sliced onion until golden brown, then add the tonkatsu (see recipe here), placing it in the middle of the pan. Mix the dashi, soy, mirin and sugar together and tip three-quarters of the mixture around the tonkatsu. Sizzle for a couple of mins so the sauce thickens a little and the tonkatsu reheats.\r\n\r\nSTEP 2\r\nTip the beaten eggs around the tonkatsu and cook for 2-3 mins until the egg is cooked through but still a little runny. Divide the rice between two bowls, then top each with half the egg and tonkatsu mix, sprinkle over the chives and serve immediately, drizzling with a little more soy if you want an extra umami kick.', 'https://www.youtube.com/watch?v=voE-MBJqBVk', '2023-08-16', 1, 7, 3),
(23, 'Beef Asado', 'https://www.themealdb.com/images/media/meals/pkopc31683207947.jpg', '53071', 0, 1, '0.	Combine beef, crushed peppercorn, soy sauce, vinegar, dried bay leaves, lemon, and tomato sauce. Mix well. Marinate beef for at least 30 minutes.\r\n1.	Put the marinated beef in a cooking pot along with remaining marinade. Add water. Let boil.\r\n2.	Add Knorr Beef Cube. Stir. Cover the pot and cook for 40 minutes in low heat.\r\n3.	Turn the beef over. Add tomato paste. Continue cooking until beef tenderizes. Set aside.\r\n4.	Heat oil in a pan. Fry the potato until it browns. Turn over and continue frying the opposite side. Remove from the pan and place on a clean plate. Do the same with the carrots.\r\n5.	Save 3 tablespoons of cooking oil from the pan where the potato was fried. Saute onion and garlic until onion softens.\r\n6.	Pour-in the sauce from the beef stew. Let boil. Add the beef. Cook for 2 minutes.\r\n7.	Add butter and let it melt. Continue cooking until the sauce reduces to half.', 'https://www.youtube.com/watch?v=lNlK8DVhXXA', '2023-08-16', 1, 1, 3),
(24, 'Beef Lo Mein', 'https://www.themealdb.com/images/media/meals/1529444830.jpg', '52952', 3, 1, 'STEP 1 - MARINATING THE BEEF\r\nIn a bowl, add the beef, salt, 1 pinch white pepper, 1 Teaspoon sesame seed oil, 1/2 egg, corn starch,1 Tablespoon of oil and mix together.\r\nSTEP 2 - BOILING THE THE NOODLES\r\nIn a 6 qt pot add your noodles to boiling water until the noodles are submerged and boil on high heat for 10 seconds. After your noodles is done boiling strain and cool with cold water.\r\nSTEP 3 - STIR FRY\r\nAdd 2 Tablespoons of oil, beef and cook on high heat untill beef is medium cooked.\r\nSet the cooked beef aside\r\nIn a wok add 2 Tablespoon of oil, onions, minced garlic, minced ginger, bean sprouts, mushrooms, peapods and 1.5 cups of water or until the vegetables are submerged in water.\r\nAdd the noodles to wok\r\nTo make the sauce, add oyster sauce, 1 pinch white pepper, 1 teaspoon sesame seed oil, sugar, and 1 Teaspoon of soy sauce.\r\nNext add the beef to wok and stir-fry', 'https://www.youtube.com/watch?v=ZT9LSsNXXe0', '2023-08-16', 1, 1, 3),
(25, 'Beef Rendang', 'https://www.themealdb.com/images/media/meals/bc8v651619789840.jpg', '53053', 0, 1, 'Chop the spice paste ingredients and then blend it in a food processor until fine.\r\nHeat the oil in a stew pot, add the spice paste, cinnamon, cloves, star anise, and cardamom and stir-fry until aromatic. Add the beef and the pounded lemongrass and stir for 1 minute. Add the coconut milk, tamarind juice, water, and simmer on medium heat, stirring frequently until the meat is almost cooked. Add the kaffir lime leaves, kerisik (toasted coconut), sugar or palm sugar, stirring to blend well with the meat.\r\nLower the heat to low, cover the lid, and simmer for 1 to 1 1/2 hours or until the meat is really tender and the gravy has dried up. Add more salt and sugar to taste. Serve immediately with steamed rice and save some for overnight.', 'https://www.youtube.com/watch?v=Ot-dmfBaZrA', '2023-08-16', 1, 1, 3),
(26, 'Beef Mechado', 'https://www.themealdb.com/images/media/meals/cgl60b1683206581.jpg', '53068', 1, 1, '0.	Make the beef tenderloin marinade by combining soy sauce, vinegar, ginger, garlic, sesame oil, olive oil, sugar, salt, and ground black pepper in a large bowl. Mix well.\r\n1.	Add the cubed beef tenderloin to the bowl with the beef tenderloin marinade. Gently toss to coat the beef. Let it stay for 1 hour.\r\n2.	Using a metal or bamboo skewer, assemble the beef kebob by skewering the vegetables and marinated beef tenderloin.\r\n3.	Heat-up the grill and start grilling the beef kebobs for 3 minutes per side. This will give you a medium beef that is juicy and tender on the inside. Add more time if you want your beef well done, but it will be less tender.\r\n4.	Transfer to a serving plate. Serve with Saffron rice.\r\n5.	Share and enjoy!\r\n', 'https://www.youtube.com/watch?v=jxW3Lj8VjyE', '2023-08-16', 1, 1, 3),
(27, 'Szechuan Beef', 'https://www.themealdb.com/images/media/meals/1529443236.jpg', '52950', 0, 1, 'STEP 1 - MARINATING THE BEEF\r\nIn a bowl, add the beef, salt, sesame seed oil, white pepper, egg white, 2 Tablespoon of corn starch and 1 Tablespoon of oil.\r\nSTEP 2 - STIR FRY\r\nFirst Cook the beef by adding 2 Tablespoon of oil until the beef is golden brown.\r\nSet the beef aside\r\nIn a wok add 1 Tablespoon of oil, minced ginger, minced garlic and stir-fry for few seconds.\r\nNext add all of the vegetables and then add sherry cooking wine and 1 cup of water.\r\nTo make the sauce add oyster sauce, hot pepper sauce, and sugar.\r\nadd the cooked beef and 1 spoon of soy sauce\r\nTo thicken the sauce, whisk together 1 Tablespoon of cornstarch and 2 Tablespoon of water in a bowl and slowly add to your stir-fry until it\'s the right thickness.', 'https://www.youtube.com/watch?v=SQGZqZYz7Ms', '2023-08-16', 1, 1, 3),
(28, 'Beef Caldereta', 'https://www.themealdb.com/images/media/meals/41cxjh1683207682.jpg', '53070', 0, 1, '0.	Heat oil in a cooking pot. Saute onion and garlic until onion softens\r\n1.	Add beef. Saute until the outer part turns light brown.\r\n2.	Add soy sauce. Pour tomato sauce and water. Let boil.\r\n3.	Add Knorr Beef Cube. Cover the pressure cooker. Cook for 30 minutes.\r\n4.	Pan-fry carrot and potato until it browns. Set aside.\r\n5.	Add chili pepper, liver spread and peanut butter. Stir.\r\n6.	Add bell peppers, fried potato and carrot. Cover the pot. Continue cooking for 5 to 7 minutes.\r\n7.	Season with salt and ground black pepper. Serve.\r\n', 'https://www.youtube.com/watch?v=yI7hTz0ft5k', '2023-08-16', 1, 1, 3),
(29, 'Lamb Tagine', 'https://www.themealdb.com/images/media/meals/yuwtuu1511295751.jpg', '52843', 0, 1, 'Heat the olive oil in a heavy-based pan and add the onion and carrot. Cook for 3- 4 mins until softened.\r\n\r\nAdd the diced lamb and brown all over. Stir in the garlic and all the spices and cook for a few mins more or until the aromas are released.\r\n\r\nAdd the honey and apricots, crumble in the stock cube and pour over roughly 500ml boiling water or enough to cover the meat. Give it a good stir and bring to the boil. Turn down to a simmer, put the lid on and cook for 1 hour.\r\n\r\nRemove the lid and cook for a further 30 mins, then stir in the squash. Cook for 20 – 30 mins more until the squash is soft and the lamb is tender. Serve alongside rice or couscous and sprinkle with parsley and pine nuts, if using.', 'https://www.youtube.com/watch?v=bR5Cqu84S_k', '2023-08-16', 1, 4, 3),
(30, 'Tunisian Lamb Soup', 'https://www.themealdb.com/images/media/meals/t8mn9g1560460231.jpg', '52972', 0, 1, 'Add the lamb to a casserole and cook over high heat. When browned, remove from the heat and set aside.\r\nKeep a tablespoon of fat in the casserole and discard the rest. Reduce to medium heat then add the garlic, onion and spinach and cook until the onion is translucent and the spinach wilted or about 5 minutes.\r\nReturn the lamb to the casserole with the onion-spinach mixture, add the tomato puree, cumin, harissa, chicken, chickpeas, lemon juice, salt and pepper in the pan. Simmer over low heat for about 20 minutes.\r\nAdd the pasta and cook for 15 minutes or until pasta is cooked.', 'https://www.youtube.com/watch?v=w1qgTQmLRe4', '2023-08-16', 1, 4, 3),
(31, 'Lamb Rogan josh', 'https://www.themealdb.com/images/media/meals/vvstvq1487342592.jpg', '52808', 0, 1, '\r\nPut the onions in a food processor and whizz until very finely chopped. Heat the oil in a large heavy-based pan, then fry the onion with the lid on, stirring every now and then, until it is really golden and soft. Add the garlic and ginger, then fry for 5 mins more.\r\nTip the curry paste, all the spices and the bay leaves into the pan, with the tomato purée. Stir well over the heat for about 30 secs, then add the meat and 300ml water. Stir to mix, turn down the heat, then add the yogurt.\r\nCover the pan, then gently simmer for 40-60 mins until the meat is tender and the sauce nice and thick. Serve scattered with coriander, with plain basmati or pilau rice.', 'https://www.youtube.com/watch?v=NZVo32n7iS8', '2023-08-16', 1, 4, 3),
(32, 'Croatian lamb peka', 'https://www.themealdb.com/images/media/meals/pn59o51628769837.jpg', '53056', 0, 1, 'Preheat oven to 200°C fan / 220°C / 425°F / Gas mark 7\r\nIf you have not bought diced lamb, cut your lamb shoulder or leg into large chunks and place to one side.\r\nChunks of chopped lamb of a red chopping board\r\nMake oil marinade -\r\nMix 80ml of olive oil in a bowl with garlic puree, sundried tomato puree ,black pepper and salt.\r\nolive oil, gia sundried tomato puree and gia garlic puree and black pepper mixed together in a silver bowl to make Croatian peka\r\nAdd potatoes and vegetables into a large lidded casserole dish.\r\nChopped up vegetables which consist of chopped up red onion, courgette, potatoes red peppers in a cast iron pan\r\nPlace diced lamb on top of the vegetables, pour the marinade and wine over the top.\r\nChunks of lamb covered in in a sundried tomato oil sauce which is on top of chopped red onion, aubergine, courgette and potatoes in a cast iron pan\r\nAdd the rosemary, thyme and sage, trying to keep the herbs on top.\r\nSo you can easily remove the herb stalks once cooked.\r\nChunks of lamb coated in a sundried tomato oil sauce and covered with thyme, rosemary and sage which is on top of chopped red onion, aubergine, courgette and potatoes in a cast iron pan\r\nPlace lid on the casserole dish and cook for 1hr 30 minute\r\nIf you do not have a lid cover very well with kitchen foil\r\nCast iron dish with lid on in the oven\r\nTake the lid off, remove any thick herb stems. Stir in 2 tbsp of olive oil.\r\nCook for a further 20-30 mins.\r\nCooked Croatian Lamb Peka in a cast iron pan in the oven\r\nServe with fresh homemade bread to dip into the juices.', 'https://www.youtube.com/watch?v=K0ipnz4fwJI', '2023-08-16', 1, 1, 3),
(33, 'Lamb and Potato pie', 'https://www.themealdb.com/images/media/meals/sxrpws1511555907.jpg', '52877', 0, 1, 'Dust the meat with flour to lightly coat.\r\nHeat enough vegetable oil in a large saucepan to fill the base, and fry the onion and meat until lightly browned. Season with salt and pepper.\r\nAdd the carrots, stock and more seasoning to taste.\r\nBring to the boil, cover and reduce the heat to a simmer. Simmer for at least an hour or until the meat is tender. Take your time cooking the meat, the longer you leave it to cook, the better the flavour will be.\r\nPreheat the oven to 180C/350F/Gas 4.\r\nAdd the drained potato cubes to the lamb.\r\nTurn the mixture into a pie dish or casserole and cover with the shortcrust pastry. Make three slits in the top of the pastry to release any steam while cooking.\r\nBrush with beaten egg and bake for about 40 minutes, until the pastry is golden brown.\r\nServe.', 'https://www.youtube.com/watch?v=NCyPaaUNYUk', '2023-08-16', 1, 4, 3),
(34, 'Stuffed Lamb Tomatoes', 'https://www.themealdb.com/images/media/meals/u55lbp1585564013.jpg', '53008', 0, 1, 'Heat oven to 180C/160C fan/gas 4. Slice the tops off the tomatoes and reserve. Scoop out most of the pulp with a teaspoon, being careful not to break the skin. Finely chop the pulp, and keep any juices. Sprinkle the insides of the tomatoes with a little sugar to take away the acidity, then place them on a baking tray.\r\n\r\nHeat 2 tbsp olive oil in a large frying pan, add the onion and garlic, then gently cook for about 10 mins until soft but not coloured. Add the lamb, cinnamon and tomato purée, turn up the heat, then fry until the meat is browned. Add the tomato pulp and juice, the rice and the stock. Season generously. Bring to the boil, then simmer for 15 mins or until the rice is tender and the liquid has been absorbed. Set aside to cool a little, then stir in the herbs.\r\n\r\nStuff the tomatoes up to the brim, top tomatoes with their lids, drizzle with 2 tbsp more olive oil, sprinkle 3 tbsp water into the tray, then bake for 35 mins. Serve with salad and crusty bread, hot or cold.', 'https://www.youtube.com/watch?v=KfJp-QfrCz4', '2023-08-16', 1, 4, 3),
(35, 'Lamb Biryani', 'https://www.themealdb.com/images/media/meals/xrttsx1487339558.jpg', '52805', 0, 1, 'Grind the cashew, poppy seeds and cumin seeds into a smooth paste, using as little water as possible. Set aside. \r\n\r\nDeep fry the sliced onions when it is hot. Don’t overcrowd the oil. When the onions turn light brown, remove from oil and drain on paper towel. The fried onion will crisp up as it drains. Also fry the cashewnuts till golden brown. Set aside.\r\n\r\nWash the rice and soak in water for twenty minutes.\r\nMeanwhile, take a big wide pan, add oil in medium heat, add the sliced onions, add the blended paste, to it add the green chillies, ginger garlic paste and garlic and fry for a minute.\r\nThen add the tomatoes and sauté them well till they are cooked and not mushy.\r\n\r\nThen to it add the red chilli powder, biryani powder, mint, coriander leaves and sauté them well.\r\nAdd the yogurt and mix well. I always move the skillet away from the heat when adding yogurt which prevents it from curdling.\r\n\r\nNow after returning the skillet back to the stove, add the washed lamb and salt and ½ cup water and mix well. Cook for 1 hour and cook it covered in medium low heat or put it in a pressure cooker for 6 whistles. If the water is not drained totally, heat it by keeping it open.\r\n\r\nTake another big pan, add thrice the cup of rice you use, and boil it. When it is boiling high, add the rice, salt and jeera and mix well. After 7 minutes exact or when the rice is 80% done. Switch off and drain the rice.\r\n\r\nNow, the layering starts. To the lamb, pat and level it. Add the drained hot rice on the top of it. Garnish with fried onions, ghee, mint, coriander leaves and saffron dissolved in milk.\r\n\r\nCover the dish and bake in a 350f oven for 15 minutes or till the cooked but not mushy. Or cook in the stove medium heat for 12 minutes and lowest heat for 5 minutes. And switch off. Mix and serve hot!\r\nNotes\r\n1. If you are cooking in oven, do make sure to cook in a big oven safe pan and cover it tight and then keep in oven for the final step.\r\n2. You can skip biryani masala if you don’t have and add just garam masala (1 tsp and red chilli powder – 3 tsp instead of 1 tsp)\r\n3. If it is spicy in the end, squeeze some lemon, it will reduce the heat and enhance the flavors also.', 'https://www.youtube.com/watch?v=r7SYVSG5nxo', '2023-08-16', 1, 4, 3),
(36, 'Lamb Tzatziki Burgers', 'https://www.themealdb.com/images/media/meals/k420tj1585565244.jpg', '53010', 0, 1, 'Tip the bulghar into a pan, cover with water and boil for 10 mins. Drain really well in a sieve, pressing out any excess water.\r\n\r\nTo make the tzatziki, squeeze and discard the juice from the cucumber, then mix into the yogurt with the chopped mint and a little salt.\r\n\r\nWork the bulghar into the lamb with the spices, garlic (if using) and seasoning, then shape into 4 burgers. Brush with a little oil and fry or barbecue for about 5 mins each side until cooked all the way through. Serve in the buns (toasted if you like) with the tzatziki, tomatoes, onion and a few mint leaves.', 'https://www.youtube.com/watch?v=s7_TF4ZHjPc', '2023-08-16', 1, 4, 3),
(37, 'Lamb and Lemon Souvlaki', 'https://www.themealdb.com/images/media/meals/rjhf741585564676.jpg', '53009', 0, 1, 'Pound the garlic with sea salt in a pestle and mortar (or use a small food processor), until the garlic forms a paste. Whisk together the oil, lemon juice, zest, dill and garlic. Mix in the lamb and combine well. Cover and marinate for at least 2 hrs or overnight in the fridge. If you’re going to use bamboo skewers, soak them in cold water.\r\n\r\nIf you’ve prepared the lamb the previous day, take it out of the fridge 30 mins before cooking. Thread the meat onto the soaked or metal skewers. Heat the grill to high or have a hot griddle pan or barbecue ready. Cook the skewers for 2-3 mins on each side, basting with the remaining marinade. Heat the pitta or flatbreads briefly, then stuff with the souvlaki. Add Greek salad (see \'Goes well with\', right) and Tzatziki (below), if you like.', 'https://www.youtube.com/watch?v=krR4rhjR75Y', '2023-08-16', 1, 4, 3),
(38, 'Vegan Chocolate Cake', 'https://www.themealdb.com/images/media/meals/qxutws1486978099.jpg', '52794', 0, 1, 'Simply mix all dry ingredients with wet ingredients and blend altogether. Bake for 45 min on 180 degrees. Decorate with some melted vegan chocolate ', 'https://www.youtube.com/watch?v=C3pAgB7pync', '2023-08-16', 1, 11, 3),
(39, 'Vegan Lasagna', 'https://www.themealdb.com/images/media/meals/rvxxuy1468312893.jpg', '52775', 5, 1, '1) Preheat oven to 180 degrees celcius. \r\n2) Boil vegetables for 5-7 minutes, until soft. Add lentils and bring to a gentle simmer, adding a stock cube if desired. Continue cooking and stirring until the lentils are soft, which should take about 20 minutes. \r\n3) Blanch spinach leaves for a few minutes in a pan, before removing and setting aside. \r\n4) Top up the pan with water and cook the lasagne sheets. When cooked, drain and set aside.\r\n5) To make the sauce, melt the butter and add the flour, then gradually add the soya milk along with the mustard and the vinegar. Cook and stir until smooth and then assemble the lasagne as desired in a baking dish. \r\n6) Bake in the preheated oven for about 25 minutes.', 'https://www.youtube.com/watch?v=VU8cXvlGbvc', '2023-08-16', 1, 11, 3),
(40, 'Vegetarian Chilli', 'https://www.themealdb.com/images/media/meals/wqurxy1511453156.jpg', '52867', 0, 1, 'Heat oven to 200C/180C fan/ gas 6. Cook the vegetables in a casserole dish for 15 mins. Tip in the beans and tomatoes, season, and cook for another 10-15 mins until piping hot. Heat the pouch in the microwave on High for 1 min and serve with the chilli.', 'https://www.youtube.com/watch?v=D0bFRVH_EqU', '2023-08-16', 1, 12, 3),
(41, 'Vegetarian Casserole', 'https://www.themealdb.com/images/media/meals/vptwyt1511450962.jpg', '52863', 0, 1, 'Heat the oil in a large, heavy-based pan. Add the onions and cook gently for 5 – 10 mins until softened.\r\nAdd the garlic, spices, dried thyme, carrots, celery and peppers and cook for 5 minutes.\r\nAdd the tomatoes, stock, courgettes and fresh thyme and cook for 20 - 25 minutes.\r\nTake out the thyme sprigs. Stir in the lentils and bring back to a simmer. Serve with wild and white basmati rice, mash or quinoa.', 'https://www.youtube.com/watch?v=oHmKE9mWtWM', '2023-08-16', 1, 12, 3),
(42, 'Boxty Breakfast', 'https://www.themealdb.com/images/media/meals/naqyel1608588563.jpg', '53036', 0, 1, 'STEP 1\r\nBefore you start, put your oven on its lowest setting, ready to keep things warm. Peel the potatoes, grate 2 of them, then set aside. Cut the other 2 into large chunks, then boil for 10-15 mins or until tender. Meanwhile, squeeze as much of the liquid from the grated potatoes as you can using a clean tea towel. Mash the boiled potatoes, then mix with the grated potato, spring onions and flour.\r\n\r\nSTEP 2\r\nWhisk the egg white in a large bowl until it holds soft peaks. Fold in the buttermilk, then add the bicarbonate of soda. Fold into the potato mix.\r\n\r\nSTEP 3\r\nHeat a large non-stick frying pan over a medium heat, then add 1 tbsp butter and some of the oil. Drop 3-4 spoonfuls of the potato mixture into the pan, then gently cook for 3-5 mins on each side until golden and crusty. Keep warm on a plate in the oven while you cook the next batch, adding more butter and oil to the pan before you do so. You will get 16 crumpet-size boxty from the mix. Can be made the day ahead, drained on kitchen paper, then reheated in a low oven for 20 mins.\r\n\r\nSTEP 4\r\nHeat the grill to medium and put the tomatoes in a heavy-based pan. Add a good knob of butter and a little oil, then fry for about 5 mins until softened. Grill the bacon, then pile onto a plate and keep warm. Stack up the boxty, bacon and egg, and serve the tomatoes on the side.', 'https://www.youtube.com/watch?v=80W0mCFDIP0', '2023-08-16', 1, 7, 3);
INSERT INTO `adminuser_recipe` (`id`, `name`, `thumbnail`, `idMeal`, `calculated_rating`, `is_approved`, `description`, `youtube_link`, `dateModified`, `is_active`, `category_id`, `user_id`) VALUES
(43, 'English Breakfast', 'https://www.themealdb.com/images/media/meals/utxryw1511721587.jpg', '52895', 0, 1, 'Heat the flat grill plate over a low heat, on top of 2 rings/flames if it fits, and brush sparingly with light olive oil.\r\nCook the sausages first. Add the sausages to the hot grill plate/the coolest part if there is one and allow to cook slowly for about 15-20 minutes, turning occasionally, until golden. After the first 10 minutes, increase the heat to medium before beginning to cook the other ingredients. If you are struggling for space, completely cook the sausages and keep hot on a plate in the oven.\r\nSnip a few small cuts into the fatty edge of the bacon. Place the bacon straight on to the grill plate and fry for 2-4 minutes each side or until your preferred crispiness is reached. Like the sausages, the cooked bacon can be kept hot on a plate in the oven.\r\nFor the mushrooms, brush away any dirt using a pastry brush and trim the stalk level with the mushroom top. Season with salt and pepper and drizzle over a little olive oil. Place stalk-side up on the grill plate and cook for 1-2 minutes before turning and cooking for a further 3-4 minutes. Avoid moving the mushrooms too much while cooking, as this releases the natural juices, making them soggy.\r\nFor the tomatoes, cut the tomatoes across the centre/or in half lengthways if using plum tomatoes , and with a small, sharp knife remove the green \'eye\'. Season with salt and pepper and drizzle with a little olive oil. Place cut-side down on the grill plate and cook without moving for 2 minutes. Gently turn over and season again. Cook for a further 2-3 minutes until tender but still holding their shape.\r\nFor the black pudding, cut the black pudding into 3-4 slices and remove the skin. Place on the grill plate and cook for 1½-2 minutes each side until slightly crispy.\r\nFor \'proper\' fried bread it\'s best to cook it in a separate pan. Ideally, use bread that is a couple of days old. Heat a frying pan to a medium heat and cover the base with oil. Add the bread and cook for 2-3 minutes each side until crispy and golden. If the pan becomes too dry, add a little more oil. For a richer flavour, add a knob of butter after you turn the slice.\r\nFor the fried eggs, break the egg straight into the pan with the fried bread and leave for 30 seconds. Add a good knob of butter and lightly splash/baste the egg with the butter when melted. Cook to your preferred stage, season and gently remove with a fish slice.\r\nOnce all the ingredients are cooked, serve on warm plates and enjoy straight away with a good squeeze of tomato ketchup or brown sauce.', 'https://www.youtube.com/watch?v=FXjYU2Ensck', '2023-08-16', 1, 13, 3),
(44, 'Breakfast Potatoes', 'https://www.themealdb.com/images/media/meals/1550441882.jpg', '52965', 0, 1, 'Before you do anything, freeze your bacon slices that way when you\'re ready to prep, it\'ll be so much easier to chop!\r\nWash the potatoes and cut medium dice into square pieces. To prevent any browning, place the already cut potatoes in a bowl filled with water.\r\nIn the meantime, heat 1-2 tablespoons of oil in a large skillet over medium-high heat. Tilt the skillet so the oil spreads evenly.\r\nOnce the oil is hot, drain the potatoes and add to the skillet. Season with salt, pepper, and Old Bay as needed.\r\nCook for 10 minutes, stirring the potatoes often, until brown. If needed, add a tablespoon more of oil.\r\nChop up the bacon and add to the potatoes. The bacon will start to render and the fat will begin to further cook the potatoes. Toss it up a bit! The bacon will take 5-6 minutes to crisp.\r\nOnce the bacon is cooked, reduce the heat to medium-low, add the minced garlic and toss. Season once more. Add dried or fresh parsley. Control heat as needed.\r\nLet the garlic cook until fragrant, about one minute.\r\nJust before serving, drizzle over the maple syrup and toss. Let that cook another minute, giving the potatoes a caramelized effect.\r\nServe in a warm bowl with a sunny side up egg!', 'https://www.youtube.com/watch?v=BoD0TIO9nE4', '2023-08-16', 1, 13, 3),
(45, 'Full English Breakfast', 'https://www.themealdb.com/images/media/meals/sqrtwu1511721265.jpg', '52896', 0, 1, 'Heat the flat grill plate over a low heat, on top of 2 rings/flames if it fits, and brush sparingly with light olive oil.\r\nCook the sausages first. Add the sausages to the hot grill plate/the coolest part if there is one and allow to cook slowly for about 15-20 minutes, turning occasionally, until golden. After the first 10 minutes, increase the heat to medium before beginning to cook the other ingredients. If you are struggling for space, completely cook the sausages and keep hot on a plate in the oven.\r\nSnip a few small cuts into the fatty edge of the bacon. Place the bacon straight on to the grill plate and fry for 2-4 minutes each side or until your preferred crispiness is reached. Like the sausages, the cooked bacon can be kept hot on a plate in the oven.\r\nFor the mushrooms, brush away any dirt using a pastry brush and trim the stalk level with the mushroom top. Season with salt and pepper and drizzle over a little olive oil. Place stalk-side up on the grill plate and cook for 1-2 minutes before turning and cooking for a further 3-4 minutes. Avoid moving the mushrooms too much while cooking, as this releases the natural juices, making them soggy.\r\nFor the tomatoes, cut the tomatoes across the centre/or in half lengthways if using plum tomatoes , and with a small, sharp knife remove the green \'eye\'. Season with salt and pepper and drizzle with a little olive oil. Place cut-side down on the grill plate and cook without moving for 2 minutes. Gently turn over and season again. Cook for a further 2-3 minutes until tender but still holding their shape.\r\nFor the black pudding, cut the black pudding into 3-4 slices and remove the skin. Place on the grill plate and cook for 1½-2 minutes each side until slightly crispy.\r\nFor \'proper\' fried bread it\'s best to cook it in a separate pan. Ideally, use bread that is a couple of days old. Heat a frying pan to a medium heat and cover the base with oil. Add the bread and cook for 2-3 minutes each side until crispy and golden. If the pan becomes too dry, add a little more oil. For a richer flavour, add a knob of butter after you turn the slice.\r\nFor the fried eggs, break the egg straight into the pan with the fried bread and leave for 30 seconds. Add a good knob of butter and lightly splash/baste the egg with the butter when melted. Cook to your preferred stage, season and gently remove with a fish slice.\r\nOnce all the ingredients are cooked, serve on warm plates and enjoy straight away with a good squeeze of tomato ketchup or brown sauce.', 'https://www.youtube.com/watch?v=FXjYU2Ensck', '2023-08-16', 1, 13, 3),
(46, 'Fruit and Cream Cheese Breakfast Pastries', 'https://www.themealdb.com/images/media/meals/1543774956.jpg', '52957', 0, 1, 'Preheat oven to 400ºF (200ºC), and prepare two cookie sheets with parchment paper. In a bowl, mix cream cheese, sugar, and vanilla until fully combined. Lightly flour the surface and roll out puff pastry on top to flatten. Cut each sheet of puff pastry into 9 equal squares. On the top right and bottom left of the pastry, cut an L shape approximately ½ inch (1 cm) from the edge.\r\nNOTE: This L shape should reach all the way down and across the square, however both L shapes should not meet at the ends. Your pastry should look like a picture frame with two corners still intact.\r\nTake the upper right corner and fold down towards the inner bottom corner. You will now have a diamond shape.\r\nPlace 1 to 2 teaspoons of the cream cheese filling in the middle, then place berries on top.\r\nRepeat with the remaining pastry squares and place them onto the parchment covered baking sheet.\r\nBake for 15-20 minutes or until pastry is golden brown and puffed.\r\nEnjoy!\r\n', '', '2023-08-16', 1, 13, 3),
(47, 'Mbuzi Choma (Roasted Goat)', 'https://www.themealdb.com/images/media/meals/cuio7s1555492979.jpg', '52968', 0, 1, '1. Steps for the Meat: \r\n Roast meat over medium heat for 50 minutes and salt it as you turn it.\r\n\r\n2. Steps for Ugali:\r\nBring the water and salt to a boil in a heavy-bottomed saucepan. Stir in the cornmeal slowly, letting it fall through the fingers of your hand.\r\n\r\n3. Reduce heat to medium-low and continue stirring regularly, smashing any lumps with a spoon, until the mush pulls away from the sides of the pot and becomes very thick, about 10 minutes.\r\n\r\n4.Remove from heat and allow to cool.\r\n\r\n5. Place the ugali into a large serving bowl. Wet your hands with water, form a ball and serve.\r\n\r\n6. Steps for Kachumbari: Mix the tomatoes, onions, chili and coriander leaves in a bowl.\r\n\r\n7. Serve and enjoy!\r\n\r\n', '', '2023-08-16', 1, 14, 3),
(48, 'Seafood fideuà', 'https://www.themealdb.com/images/media/meals/wqqvyq1511179730.jpg', '52836', 0, 1, 'Boil the kettle. Empty the mussels into a colander and run under cold water. Throw away any with broken shells. Pick through the shells, tapping each one on the side of the sink – they should be closed or should slowly close when tapped – if they stay open, throw them away. If any of the shells still have barnacles or stringy beards attached, pull them off with a cutlery knife and rinse the shells well. Keep in the colander, covered with a cold, damp cloth, until you’re ready to cook. Peel the prawn shells on the body section only – leave the heads and tails intact. Score down the backs and pull out any gritty entrails. Chill until you’re ready to cook.\r\nPut the saffron in a small cup, cover with 50ml kettle-hot water and set aside for 10 mins. If using vermicelli, put in a bowl and crush to little pieces (about 1cm long) with your hands.\r\nHeat the oil in a large frying pan with at least a 3cm lip, or a 40cm paella pan. Add the onion and stir around the pan for 5 mins until soft. Add the garlic and cook for 1 min more, then tip in the vermicelli and cook for 5 mins, stirring from time to time, until the vermicelli is toasted brown. Stir in the paprika.\r\nKeeping the heat moderate, stir through the monkfish, squid and saffron with its water, seasoning well. Spread the ingredients out in an even layer, then pour over the hot stock and scatter the tomatoes on top. Bring to a simmer, then cover the whole dish with a tight-fitting lid (or foil). Turn the heat to medium and cook for 6 mins.\r\nUncover and stir to incorporate the dry top layer of pasta. Push the mussels into the pasta so the hinges are buried in the bottom of the dish, and they stand straight up. Arrange the prawns on top, cover tightly and cook for another 6 mins or until the mussels are open, the prawns are pink and the pasta is cooked through. Leave to simmer for another 2-3 mins to cook off most of the remaining liquid (leave a little in the pan to prevent the pasta from sticking together). Allow to sit for 2-3 mins, then squeeze over the lemon juice and arrange the wedges on top. Scatter with parsley before serving.', 'https://www.youtube.com/watch?v=itsFEc8W468', '2023-08-16', 1, 17, 3),
(49, 'Corba', 'https://www.themealdb.com/images/media/meals/58oia61564916529.jpg', '52977', 0, 1, 'Pick through your lentils for any foreign debris, rinse them 2 or 3 times, drain, and set aside.  Fair warning, this will probably turn your lentils into a solid block that you’ll have to break up later\r\nIn a large pot over medium-high heat, sauté the olive oil and the onion with a pinch of salt for about 3 minutes, then add the carrots and cook for another 3 minutes.\r\nAdd the tomato paste and stir it around for around 1 minute. Now add the cumin, paprika, mint, thyme, black pepper, and red pepper as quickly as you can and stir for 10 seconds to bloom the spices. Congratulate yourself on how amazing your house now smells.\r\nImmediately add the lentils, water, broth, and salt. Bring the soup to a (gentle) boil.\r\nAfter it has come to a boil, reduce heat to medium-low, cover the pot halfway, and cook for 15-20 minutes or until the lentils have fallen apart and the carrots are completely cooked.\r\nAfter the soup has cooked and the lentils are tender, blend the soup either in a blender or simply use a hand blender to reach the consistency you desire. Taste for seasoning and add more salt if necessary.\r\nServe with crushed-up crackers, torn up bread, or something else to add some extra thickness.  You could also use a traditional thickener (like cornstarch or flour), but I prefer to add crackers for some texture and saltiness.  Makes great leftovers, stays good in the fridge for about a week.', 'https://www.youtube.com/watch?v=VVnZd8A84z4', '2023-08-18', 1, 9, 3),
(50, 'Burek', 'https://www.themealdb.com/images/media/meals/tkxquw1628771028.jpg', '53060', 0, 1, 'Fry the finely chopped onions and minced meat in oil. Add the salt and pepper. Grease a round baking tray and put a layer of pastry in it. Cover with a thin layer of filling and cover this with another layer of filo pastry which must be well coated in oil. Put another layer of filling and cover with pastry. When you have five or six layers, cover with filo pastry, bake at 200ºC/392ºF for half an hour and cut in quarters and serve.', 'https://www.youtube.com/watch?v=YsJXZwE5pdY', '2023-08-18', 1, 9, 3),
(51, 'Sushi', 'https://www.themealdb.com/images/media/meals/g046bb1663960946.jpg', '53065', 0, 1, 'STEP 1\r\nTO MAKE SUSHI ROLLS: Pat out some rice. Lay a nori sheet on the mat, shiny-side down. Dip your hands in the vinegared water, then pat handfuls of rice on top in a 1cm thick layer, leaving the furthest edge from you clear.\r\n\r\nSTEP 2\r\nSpread over some Japanese mayonnaise. Use a spoon to spread out a thin layer of mayonnaise down the middle of the rice.\r\n\r\nSTEP 3\r\nAdd the filling. Get your child to top the mayonnaise with a line of their favourite fillings – here we’ve used tuna and cucumber.\r\n\r\nSTEP 4\r\nRoll it up. Lift the edge of the mat over the rice, applying a little pressure to keep everything in a tight roll.\r\n\r\nSTEP 5\r\nStick down the sides like a stamp. When you get to the edge without any rice, brush with a little water and continue to roll into a tight roll.\r\n\r\nSTEP 6\r\nWrap in cling film. Remove the mat and roll tightly in cling film before a grown-up cuts the sushi into thick slices, then unravel the cling film.\r\n\r\nSTEP 7\r\nTO MAKE PRESSED SUSHI: Layer over some smoked salmon. Line a loaf tin with cling film, then place a thin layer of smoked salmon inside on top of the cling film.\r\n\r\nSTEP 8\r\nCover with rice and press down. Press about 3cm of rice over the fish, fold the cling film over and press down as much as you can, using another tin if you have one.\r\n\r\nSTEP 9\r\nTip it out like a sandcastle. Turn block of sushi onto a chopping board. Get a grown-up to cut into fingers, then remove the cling film.\r\n\r\nSTEP 10\r\nTO MAKE SUSHI BALLS: Choose your topping. Get a small square of cling film and place a topping, like half a prawn or a small piece of smoked salmon, on it. Use damp hands to roll walnut-sized balls of rice and place on the topping.\r\n\r\nSTEP 11\r\nMake into tight balls. Bring the corners of the cling film together and tighten into balls by twisting it up, then unwrap and serve.', 'https://www.youtube.com/watch?v=ub68OxEypaY', '2023-08-18', 1, 17, 3),
(52, 'Kumpir', 'https://www.themealdb.com/images/media/meals/mlchx21564916997.jpg', '52978', 0, 1, 'If you order kumpir in Turkey, the standard filling is first, lots of butter mashed into the potato, followed by cheese. There’s then a row of other toppings that you can just point at to your heart’s content – sweetcorn, olives, salami, coleslaw, Russian salad, allsorts – and you walk away with an over-stuffed potato because you got ever-excited by the choices on offer.\r\n\r\nGrate (roughly – you can use as much as you like) 150g of cheese.\r\nFinely chop one onion and one sweet red pepper.\r\nPut these ingredients into a large bowl with a good sprinkling of salt and pepper, chilli flakes (optional).', 'https://www.youtube.com/watch?v=IEDEtZ4UVtI', '2023-08-18', 1, 9, 3),
(53, 'Bistek', 'https://www.themealdb.com/images/media/meals/4pqimk1683207418.jpg', '53069', 3, 1, '0.	Marinate beef in soy sauce, lemon (or calamansi), and ground black pepper for at least 1 hour. Note: marinate overnight for best result\r\n1.	Heat the cooking oil in a pan then pan-fry half of the onions until the texture becomes soft. Set aside\r\n2.	Drain the marinade from the beef. Set it aside. Pan-fry the beef on the same pan where the onions were fried for 1 minute per side. Remove from the pan. Set aside\r\n3.	Add more oil if needed. Saute garlic and remaining raw onions until onion softens.\r\n4.	Pour the remaining marinade and water. Bring to a boil.\r\n5.	Add beef. Cover the pan and simmer until the meat is tender. Note: Add water as needed.\r\n6.	Season with ground black pepper and salt as needed. Top with pan-fried onions.\r\n7.	Transfer to a serving plate. Serve hot. Share and Enjoy!\r\n', 'https://www.youtube.com/watch?v=xOQON5_S7as', '2023-08-18', 1, 1, 3),
(54, 'Tamiya', 'https://www.themealdb.com/images/media/meals/n3xxd91598732796.jpg', '53026', 0, 1, 'oak the beans in water to cover overnight.Drain. If skinless beans are unavailable, rub to loosen the skins, then discard the skins. Pat the beans dry with a towel.\r\nGrind the beans in a food mill or meat grinder.If neither appliance is available, process them in a food processor but only until the beans form a paste. (If blended too smoothly, the batter tends to fall apart during cooking.) Add the scallions, garlic, cilantro, cumin, baking powder, cayenne, salt, pepper, and coriander, if using.  Refrigerate for at least 30 minutes.\r\nShape the bean mixture into 1-inch balls.Flatten slightly and coat with flour.\r\nHeat at least 1½-inches of oil over medium heat to 365 degrees.\r\nFry the patties in batches, turning once, until golden brown on all sides, about 5 minutes.Remove with a wire mesh skimmer or slotted spoon. Serve as part of a meze or in pita bread with tomato-cucumber salad and tahina sauce.', 'https://www.youtube.com/watch?v=mulqW-J3Yy4', '2023-08-18', 1, 12, 3),
(55, 'Kafteji', 'https://www.themealdb.com/images/media/meals/1bsv1q1560459826.jpg', '52971', 0, 1, 'Peel potatoes and cut into 5cm cubes.\r\nPour 1-2 cm of olive oil into a large pan and heat up very hot. Fry potatoes until golden brown for 20 minutes, turning from time to time. Place on kitchen paper to drain.\r\nCut the peppers in half and remove seeds. Rub a little olive oil on them and place the cut side down on a baking tray. Place them under the grill. Grill until the skin is dark and bubbly. While the peppers are still hot, put them into a plastic sandwich bag and seal it. Take them out after 15 minutes and remove skins.\r\nIn the meantime, heat more olive oil another pan. Peel the onions and cut into thin rings. Fry for 15 minutes until golden brown, turning them often. Add the Ras el hanout at the end.\r\nCut the pumpkin into 5cm cubes and fry in the same pan you used for the potatoes for 10-15 minutes until it is soft and slightly browned. Place on kitchen paper.\r\nPour the remaining olive oil out of the pan and put all the cooked vegetables into the pan and mix. Whisk eggs and pour them over the vegetables. Put the lid on the pan so that the eggs cook. Put the contents of the pan onto a large chopping board, add salt and pepper and chopped and mix everything with a big knife.', 'https://www.youtube.com/watch?v=-TFf-Zu-xQU', '2023-08-18', 1, 12, 3),
(56, 'Lasagne', 'https://www.themealdb.com/images/media/meals/wtsvxx1511296896.jpg', '52844', 0, 1, 'Heat the oil in a large saucepan. Use kitchen scissors to snip the bacon into small pieces, or use a sharp knife to chop it on a chopping board. Add the bacon to the pan and cook for just a few mins until starting to turn golden. Add the onion, celery and carrot, and cook over a medium heat for 5 mins, stirring occasionally, until softened.\r\nAdd the garlic and cook for 1 min, then tip in the mince and cook, stirring and breaking it up with a wooden spoon, for about 6 mins until browned all over.\r\nStir in the tomato purée and cook for 1 min, mixing in well with the beef and vegetables. Tip in the chopped tomatoes. Fill each can half full with water to rinse out any tomatoes left in the can, and add to the pan. Add the honey and season to taste. Simmer for 20 mins.\r\nHeat oven to 200C/180C fan/gas 6. To assemble the lasagne, ladle a little of the ragu sauce into the bottom of the roasting tin or casserole dish, spreading the sauce all over the base. Place 2 sheets of lasagne on top of the sauce overlapping to make it fit, then repeat with more sauce and another layer of pasta. Repeat with a further 2 layers of sauce and pasta, finishing with a layer of pasta.\r\nPut the crème fraîche in a bowl and mix with 2 tbsp water to loosen it and make a smooth pourable sauce. Pour this over the top of the pasta, then top with the mozzarella. Sprinkle Parmesan over the top and bake for 25–30 mins until golden and bubbling. Serve scattered with basil, if you like.', 'https://www.youtube.com/watch?v=gfhfsBPt46s', '2023-08-18', 1, 6, 3),
(57, 'Dal fry', 'https://www.themealdb.com/images/media/meals/wuxrtu1483564410.jpg', '52785', 0, 1, 'Wash and soak toor dal in approx. 3 cups of water, for at least one hours. Dal will be double in volume after soaking. Drain the water.\r\nCook dal with 2-1/2 cups water and add salt, turmeric, on medium high heat, until soft in texture (approximately 30 mins) it should be like thick soup.\r\nIn a frying pan, heat the ghee. Add cumin seeds, and mustard seeds. After the seeds crack, add bay leaves, green chili, ginger and chili powder. Stir for a few seconds.\r\nAdd tomatoes, salt and sugar stir and cook until tomatoes are tender and mushy.\r\nAdd cilantro and garam masala cook for about one minute.\r\nPour the seasoning over dal mix it well and cook for another minute.\r\nServe with Naan.', 'https://www.youtube.com/watch?v=J4D855Q9-jg', '2023-08-18', 1, 12, 3),
(58, 'Wontons', 'https://www.themealdb.com/images/media/meals/1525876468.jpg', '52948', 0, 1, 'Combine pork, garlic, ginger, soy sauce, sesame oil, and vegetables in a bowl.\r\nSeparate wonton skins.\r\nPlace a heaping teaspoon of filling in the center of the wonton.\r\nBrush water on 2 borders of the skin, covering 1/4 inch from the edge.\r\nFold skin over to form a triangle, sealing edges.\r\nPinch the two long outside points together.\r\nHeat oil to 450 degrees and fry 4 to 5 at a time until golden.\r\nDrain and serve with sauce.', 'https://www.youtube.com/watch?v=9h9No18ZyCI', '2023-08-18', 1, 7, 3),
(59, 'Timbits', 'https://www.themealdb.com/images/media/meals/txsupu1511815755.jpg', '52929', 0, 1, 'Sift together dry ingredients.\r\nMix together wet ingredients and incorporate into dry. Stir until smooth.\r\nDrop by teaspoonfuls(no bigger) into hot oil (365 degrees, no hotter), turning after a few moments until golden brown on all sides.\r\nRemove and drain.\r\nRoll in cinnamon sugar while still warm and serve.', 'https://www.youtube.com/watch?v=fFLn1h80AGQ', '2023-08-18', 1, 15, 3),
(60, 'Poutine', 'https://www.themealdb.com/images/media/meals/uuyrrx1487327597.jpg', '52804', 0, 1, 'Heat oil in a deep fryer or deep heavy skillet to 365°F (185°C).\r\nWarm gravy in saucepan or microwave.\r\nPlace the fries into the hot oil, and cook until light brown, about 5 minutes.\r\nRemove to a paper towel lined plate to drain.\r\nPlace the fries on a serving platter, and sprinkle the cheese over them.\r\nLadle gravy over the fries and cheese, and serve immediately.', 'https://www.youtube.com/watch?v=UVAMAoA2_WU', '2023-08-18', 1, 16, 3),
(61, 'Koshari', 'https://www.themealdb.com/images/media/meals/4er7mj1598733193.jpg', '53027', 5, 1, 'Cook the lentils. Bring lentils and 4 cups of water to a boil in a medium pot or saucepan over high heat. Reduce the heat to low and cook until lentils are just tender (15-17 minutes). Drain from water and season with a little salt. (Note: when the lentils are ready, they should not be fully cooked. They should be only par-cooked and still have a bite to them as they need to finish cooking with the rice).\r\nNow, for the rice. Drain the rice from its soaking water. Combine the par-cooked lentils and the rice in the saucepan over medium-high heat with 1 tbsp cooking oil, salt, pepper, and coriander. Cook for 3 minutes, stirring regularly. Add warm water to cover the rice and lentil mixture by about 1 1/2 inches (you’ll probably use about 3 cups of water here). Bring to a boil; the water should reduce a bit. Now cover and cook until all the liquid has been absorbed and both the rice and lentils are well cooked through (about 20 minutes).  Keep covered and undisturbed for 5 minutes or so.\r\nNow make the pasta. While the rice and lentils are cooking, make the pasta according to package instructions by adding the elbow pasta to boiling water with a dash of salt and a little oil. Cook until the pasta is al dente. Drain.\r\nCover the chickpeas and warm in the microwave briefly before serving.\r\n\r\nMake the crispy onion topping. \r\n\r\nSprinkle the onion rings with salt, then toss them in the flour to coat. Shake off excess flour.\r\nIn a large skillet, heat the cooking oil over medium-high heat, cook the onion rings, stirring often, until they turn a nice caramelized brown. Onions must be crispy, but not burned (15-20 minutes).', 'https://www.youtube.com/watch?v=y0d2ZMZBW4Y', '2023-08-18', 1, 12, 3),
(62, 'Big Mac', 'https://www.themealdb.com/images/media/meals/urzj1d1587670726.jpg', '53013', 0, 1, 'For the Big Mac sauce, combine all the ingredients in a bowl, season with salt and chill until ready to use.\r\n2. To make the patties, season the mince with salt and pepper and form into 4 balls using about 1/3 cup mince each. Place each onto a square of baking paper and flatten to form into four x 15cm circles. Heat oil in a large frypan over high heat. In 2 batches, cook beef patties for 1-2 minutes each side until lightly charred and cooked through. Remove from heat and keep warm. Repeat with remaining two patties.\r\n3. Carefully slice each burger bun into three acrossways, then lightly toast.\r\n4. To assemble the burgers, spread a little Big Mac sauce over the bottom base. Top with some chopped onion, shredded lettuce, slice of cheese, beef patty and some pickle slices. Top with the middle bun layer, and spread with more Big Mac sauce, onion, lettuce, pickles, beef patty and then finish with more sauce. Top with burger lid to serve.\r\n5. After waiting half an hour for your food to settle, go for a jog.', 'https://www.youtube.com/watch?v=C5J39YnnPsg', '2023-08-18', 1, 1, 3),
(63, 'Shawarma', 'https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg', '53028', 0, 1, 'Combine the marinade ingredients in a large ziplock bag (or bowl).\r\nAdd the chicken and use your hands to make sure each piece is coated. If using a ziplock bag, I find it convenient to close the bag then massage the bag to disperse the rub all over each chicken piece.\r\nMarinate overnight or up to 24 hours.\r\nCombine the Yoghurt Sauce ingredients in a bowl and mix. Cover and put in the fridge until required (it will last for 3 days in the fridge).\r\nHeat grill/BBQ (or large heavy based pan on stove) on medium high. You should not need to oil it because the marinade has oil in it and also thigh fillets have fat. But if you are worried then oil your hotplate/grill. (See notes for baking)\r\nPlace chicken on the grill and cook the first side for 4 to 5 minutes until nicely charred, then turn and cook the other side for 3 to 4 minutes (the 2nd side takes less time).\r\nRemove chicken from the grill and cover loosely with foil. Set aside to rest for 5 minutes.\r\nTO SERVE\r\nSlice chicken and pile onto platter alongside flatbreads, Salad and the Yoghurt Sauce.\r\nTo make a wrap, get a piece of flatbread and smear with Yoghurt Sauce. Top with a bit of lettuce and tomato and Chicken Shawarma. Roll up and enjoy!', 'https://www.youtube.com/watch?v=3lxUIeKDgic', '2023-08-18', 1, 2, 3),
(64, 'Stamppot', 'https://www.themealdb.com/images/media/meals/hyarod1565090529.jpg', '52980', 0, 1, '\r\nWash and peel the potatoes and cut into similarly sized pieces for even cooking.\r\n\r\nIn a large soup pot, boil the potatoes and the bay leaves in salted water for 20 minutes. Discard the bay leaves.\r\n\r\nIf you\'re not using a bag of ready-cut curly kale, wash the bunches thoroughly under cool running water to get rid of all soil—you wouldn\'t want that gritty texture in your finished dish. Trim any coarse stems and discard any brown leaves. With a sharp knife, cut the curly kale into thin strips.\r\n\r\nPeel and chop the shallots.\r\n\r\nIn a frying pan or skillet, melt 1 tbsp. of butter and saute the shallots for a few minutes before adding the curly kale and 2 tbsp. of water. Season and cook for about 10 minutes, or until tender.\r\n\r\nWarm the milk on the stove or in the microwave.\r\n\r\nDrain, shake and dry the potatoes with kitchen towels before mashing with a potato masher or ricer. Working quickly, add the warm milk and the remaining butter. Season to taste with nutmeg, salt, and pepper. \r\n\r\nMix the cooked curly kale through the cooked mashed potato mixture.\r\n\r\nTop with slices of the smoked sausage and serve hot with your favorite mustard or gravy.\r\n\r\nServe and enjoy!', 'https://www.youtube.com/watch?v=hTrSXryX31A', '2023-08-18', 1, 7, 3),
(65, 'White chocolate creme brulee', 'https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg', '52917', 0, 1, 'Heat the cream, chocolate and vanilla pod in a pan until the chocolate has melted. Take off the heat and allow to infuse for 10 mins, scraping the pod seeds into the cream. If using the vanilla extract, add straight away. Heat oven to 160C/fan 140C/gas 3.\r\nBeat yolks and sugar until pale. stir in the chocolate cream. Strain into a jug and pour into ramekins. Place in a deep roasting tray and pour boiling water halfway up the sides. Bake for 15-20 mins until just set with a wobbly centre. Chill in the fridge for at least 4 hrs.\r\nTo serve, sprinkle some sugar on top of the brûlées and caramelise with a blowtorch or briefly under a hot grill. Leave caramel to harden, then serve.', 'https://www.youtube.com/watch?v=LmJ0lsPLHDc', '2023-08-18', 1, 15, 3),
(66, 'Yaki Udon', 'https://www.themealdb.com/images/media/meals/wrustq1511475474.jpg', '52871', 0, 1, 'Boil some water in a large saucepan. Add 250ml cold water and the udon noodles. (As they are so thick, adding cold water helps them to cook a little bit slower so the middle cooks through). If using frozen or fresh noodles, cook for 2 mins or until al dente; dried will take longer, about 5-6 mins. Drain and leave in the colander.\r\nHeat 1 tbsp of the oil, add the onion and cabbage and sauté for 5 mins until softened. Add the mushrooms and some spring onions, and sauté for 1 more min. Pour in the remaining sesame oil and the noodles. If using cold noodles, let them heat through before adding the ingredients for the sauce – otherwise tip in straight away and keep stir-frying until sticky and piping hot. Sprinkle with the remaining spring onions.', 'https://www.youtube.com/watch?v=5Iy0MCowSvA', '2023-08-18', 1, 12, 3),
(67, 'Tortang Talong', 'https://www.themealdb.com/images/media/meals/va668f1683209318.jpg', '53075', 0, 1, '0.	Grill the eggplant until the color of skin turns almost black\r\n1.	Let the eggplant cool for a while then peel off the skin. Set aside.\r\n2.	Crack the eggs and place in a bowl\r\n3.	Add salt and beat\r\n4.	Place the eggplant on a flat surface and flatten using a fork.\r\n5.	Dip the flattened eggplant in the beaten egg mixture\r\n6.	Heat the pan and pour the cooking oil\r\n7.	Fry the eggplant (that was dipped in the beaten mixture). Make sure that both sides are cooked. Frying time will take you about 3 to 4 minutes per side on medium heat. \r\n', 'https://www.youtube.com/watch?v=eLl8ekOu1MM', '2023-08-18', 1, 12, 3),
(68, 'Treacle Tart', 'https://www.themealdb.com/images/media/meals/wprvrw1511641295.jpg', '52892', 0, 1, 'First make the short crust pastry: measure the flour into a large bowl and rub in the butter with your fingertips until the mixture resembles fine breadcrumbs (alternatively, this can be done in a food processor). Add about three tablespoons of cold water and mix to a firm dough, wrap in cling film and chill in the fridge for about 20 minutes.\r\nPreheat the oven to 200C/400F/Gas 6 and put a heavy baking tray in the oven to heat up. Grease a deep 18cm/7in loose-bottomed fluted flan tin with butter.\r\nRemove about 150g/5½oz of pastry from the main ball and set aside for the lattice top.\r\nRoll the rest of the pastry out thinly on a lightly floured work surface and line the prepared flan tin with the pastry.\r\nPrick the base with a fork, to stop the base rising up during baking.\r\nPlace the reserved pastry for the lattice top on cling film and roll out thinly. Egg wash the pastry and set aside to chill in the fridge (the cling film makes it easier to move about). Do not cut into strips at this stage. Do not egg wash the strips once they are on the tart as it will drip into the treacle mixture.\r\nTo make the filling, heat the syrup gently in a large pan but do not boil.\r\nOnce melted, add the breadcrumbs, lemon juice and zest to the syrup. (You can add less lemon if you would prefer less citrus taste.) If the mixture looks runny, add a few more breadcrumbs.\r\nPour the syrup mixture into the lined tin and level the surface.\r\nRemove the reserved pastry from the fridge and cut into long strips, 1cm/½in wide. Make sure they are all longer than the edges of the tart tin.\r\nEgg wash the edge of the pastry in the tin, and start to make the woven laying lattice pattern over the mixture, leave the strips hanging over the edge of the tin.\r\nOnce the lattice is in place, use the tin edge to cut off the strips by pressing down with your hands, creating a neat finish.\r\nBake on the pre-heated baking tray in the hot oven for about 10 minutes until the pastry has started to colour, and then reduce the oven temperature to 180C/350F/Gas 4. If at this stage the lattice seems to be getting too dark brown, cover the tart with tin foil.\r\nBake for a further 25-30 minutes until the pastry is golden-brown and the filling set.\r\nRemove the tart from the oven and leave to firm up in the tin. Serve warm or cold.', 'https://www.youtube.com/watch?v=YMmgKCNcqwI', '2023-08-18', 1, 15, 3),
(69, 'Tuna Nicoise', 'https://www.themealdb.com/images/media/meals/yypwwq1511304979.jpg', '52852', 0, 1, 'Heat oven to 200C/fan 180C/gas 6. Toss the potatoes with 2 tsp oil and some seasoning. Tip onto a large baking tray, then roast for 20 mins, stirring halfway, until crisp, golden and cooked through.\r\nMeanwhile, put eggs in a small pan of water, bring to the boil, then simmer for 8-10 mins, depending on how you like them cooked. Plunge into a bowl of cold water to cool for a few mins. Peel away the shells, then cut into halves.\r\nIn a large salad bowl, whisk together the remaining oil, red wine vinegar, capers and chopped tomatoes. Season, tip in the onion, spinach, tuna and potatoes, then gently toss together. Top with the eggs, then serve straight away.', 'https://www.youtube.com/watch?v=3_UAxkx0u6U', '2023-08-18', 1, 17, 3),
(70, 'Tunisian Orange Cake', 'https://www.themealdb.com/images/media/meals/y4jpgq1560459207.jpg', '52970', 0, 1, 'Preheat oven to 190 C / Gas 5. Grease a 23cm round springform tin.\r\nCut off the hard bits from the top and bottom of the orange. Slice the orange and remove all seeds. Puree the orange with its peel in a food processor. Add one third of the sugar and the olive oil and continue to mix until well combined.\r\nSieve together flour and baking powder.\r\nBeat the eggs and the remaining sugar with an electric hand mixer for at least five minutes until very fluffy. Fold in half of the flour mixture, then the orange and the vanilla, then fold in the remaining flour. Mix well but not for too long.\r\nPour cake mixture into prepared tin and smooth out. Bake in preheated oven for 20 minutes. Reduce the oven temperature to 160 C / Gas 2 and bake again for 30 minutes Bake until the cake is golden brown and a skewer comes out clean. Cool on a wire cake rack.', 'https://www.youtube.com/watch?v=rCUxg866Ea4', '2023-08-18', 1, 15, 3),
(71, 'Teriyaki Chicken Casserole', 'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg', '52772', 0, 1, 'Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!', 'https://www.youtube.com/watch?v=4aZr5hZXP_s', '2023-08-18', 1, 2, 3),
(72, 'Toad In The Hole', 'https://www.themealdb.com/images/media/meals/ytuvwr1503070420.jpg', '52822', 0, 1, 'Preheat the oven to 200°C/fan180°C/gas 6. fry sausages in a non-stick pan until browned.\r\nDrizzle vegetable oil in a 30cm x 25cm x 6cm deep roasting tray and heat in the oven for 5 minutes.\r\nPut the plain flour in a bowl, crack in the medium free-range eggs, then stir in the grated horseradish. Gradually beat in the semi-skimmed milk. Season.\r\nPut the sausages into the hot roasting tray and pour over the batter. Top with cherry tomatoes on the vine and cook for 30 minutes until puffed and golden.', 'https://www.youtube.com/watch?v=t1dWkDrC330', '2023-08-18', 1, 7, 3),
(73, 'Tahini Lentils', 'https://www.themealdb.com/images/media/meals/vpxyqt1511464175.jpg', '52869', 0, 1, 'In a jug, mix the tahini with the zest and juice of the lemon and 50ml of cold water to make a runny dressing. Season to taste, then set aside.\r\nHeat the oil in a wok or large frying pan over a medium-high heat. Add the red onion, along with a pinch of salt, and fry for 2 mins until starting to soften and colour. Add the garlic, pepper, green beans and courgette and fry for 5 min, stirring frequently.\r\nTip in the kale, lentils and the tahini dressing. Keep the pan on the heat for a couple of mins, stirring everything together until the kale is wilted and it’s all coated in the creamy dressing.', 'https://www.youtube.com/watch?v=8kRlmz8pW0I', '2023-08-18', 1, 12, 3),
(74, 'Tarte Tatin', 'https://www.themealdb.com/images/media/meals/ryspuw1511786688.jpg', '52909', 0, 1, 'Roll the pastry to a 3mm-thick round on a lightly floured surface and cut a 24cm circle, using a plate as a guide. Lightly prick all over with a fork, wrap in cling film on a baking sheet and freeze while preparing the apples.\r\nHeat oven to 180C/160C fan/gas 4. Peel, quarter and core the apples. Put the sugar in a flameproof 20cm ceramic Tatin dish or a 20cm ovenproof heavy-based frying pan and place over a medium-high heat. Cook the sugar for 5-7 mins to a dark amber caramel syrup that’s starting to smoke, then turn off the heat and stir in the 60g diced chilled butter.\r\nTo assemble the Tarte Tatin, arrange the apple quarters very tightly in a circle around the edge of the dish first, rounded-side down, then fill in the middle in a similar fashion. Gently press with your hands to ensure there are no gaps. Brush the fruit with the melted butter.\r\nBake in the oven for 30 mins, then remove and place the disc of frozen puff pastry on top – it will quickly defrost. Tuck the edges down the inside of the dish and, with a knife, prick a few holes in the pastry to allow steam to escape. Bake for a further 40-45 mins until the pastry is golden brown and crisp.\r\nAllow to cool to room temperature for 1 hr before running a knife around the edge of the dish and inverting it onto a large serving plate that is deep enough to contain the juices. Serve with crème fraîche or vanilla ice cream.', 'https://www.youtube.com/watch?v=8xDM8U6h9Pw', '2023-08-18', 1, 15, 3),
(75, 'Sugar Pie', 'https://www.themealdb.com/images/media/meals/yrstur1511816601.jpg', '52931', 0, 1, 'Preheat oven to 350 degrees F (175 degrees C). Grease a 9-inch pie dish.\r\nPlace the brown sugar and butter in a mixing bowl, and beat them together with an electric mixer until creamy and very well combined, without lumps. Beat in eggs, one at a time, incorporating the first egg before adding the next one. Add the vanilla extract and salt; beat the flour in, a little at a time, and then the milk, making a creamy batter. Pour the batter into the prepared pie dish.\r\nBake in the preheated oven for 35 minutes; remove pie, and cover the rim with aluminum foil to prevent burning. Return to oven, and bake until the middle sets and the top forms a crusty layer, about 15 more minutes. Let the pie cool to room temperature, then refrigerate for at least 1 hour before serving.', 'https://www.youtube.com/watch?v=uVQ66jiL-Dc', '2023-08-18', 1, 15, 3),
(76, 'Summer Pistou', 'https://www.themealdb.com/images/media/meals/rqtxvr1511792990.jpg', '52911', 0, 1, 'Heat the oil in a large pan and fry the leeks and courgette for 5 mins to soften. Pour in the stock, add three-quarters of the haricot beans with the green beans, half the tomatoes, and simmer for 5-8 mins until the vegetables are tender.\r\nMeanwhile, blitz the remaining beans and tomatoes, the garlic and basil in a food processor (or in a bowl with a stick blender) until smooth, then stir in the Parmesan. Stir the sauce into the soup, cook for 1 min, then ladle half into bowls or pour into a flask for a packed lunch. Chill the remainder. Will keep for a couple of days.', 'https://www.youtube.com/watch?v=fyeqZJKEXp0', '2023-08-18', 1, 12, 3),
(77, 'Summer Pudding', 'https://www.themealdb.com/images/media/meals/rsqwus1511640214.jpg', '52889', 0, 1, 'Bring out the juices: Wash fruit and gently dry on kitchen paper – keep strawberries separate. Put sugar and 3 tbsp water into a large pan. Gently heat until sugar dissolves – stir a few times. Bring to a boil for 1 min, then tip in the fruit (not strawberries). Cook for 3 mins over a low heat, stirring 2-3 times. The fruit will be softened, mostly intact and surrounded by dark red juice. Put a sieve over a bowl and tip in the fruit and juice.\r\nLine the bowl with cling film and prepare the bread: Line the 1.25-litre basin with cling film as this will help you to turn out the pudding. Overlap two pieces of cling film in the middle of the bowl as it’s easier than trying to get one sheet to stick to all of the curves. Let the edges overhang by about 15cm. Cut the crusts off the bread. Cut 4 pieces of bread in half, a little on an angle, to give 2 lopsided rectangles per piece. Cut 2 slices into 4 triangles each and leave the final piece whole.\r\nBuild the pud: Dip the whole piece of bread into the juice for a few secs just to coat. Push this into the bottom of the basin. Now dip the wonky rectangular pieces one at a time and press around the basin’s sides so that they fit together neatly, alternately placing wide and narrow ends up. If you can’t quite fit the last piece of bread in it doesn’t matter, just trim into a triangle, dip in juice and slot in. Now spoon in the softened fruit, adding the strawberries here and there as you go.\r\nLet flavours mingle then serve: Dip the bread triangles in juice and place on top – trim off overhang with scissors. Keep leftover juice for later. Bring cling film up and loosely seal. Put a side plate on top and weight down with cans. Chill for 6 hrs or overnight. To serve, open out cling film then put a serving plate upside-down on top and flip over. serve with leftover juice, any extra berries and cream.', 'https://www.youtube.com/watch?v=akJIO6UhXtA', '2023-08-18', 1, 15, 3),
(78, 'Stovetop Eggplant With Harissa, Chickpeas, and Cumin Yogurt', 'https://www.themealdb.com/images/media/meals/yqwtvu1487426027.jpg', '52817', 0, 1, 'Heat the oil in a 12-inch skillet over high heat until shimmering. Add the eggplants and lower the heat to medium. Season with salt and pepper as you rotate the eggplants, browning them on all sides. Continue to cook, turning regularly, until a fork inserted into the eggplant meets no resistance (you may have to stand them up on their fat end to finish cooking the thickest parts), about 20 minutes, lowering the heat and sprinkling water into the pan as necessary if the eggplants threaten to burn or smoke excessively.\r\n\r\n2.\r\nMix the harissa, chickpeas and tomatoes together, then add to the eggplants. Cook until the tomatoes have blistered and broken down, about 5 minutes more. Season with salt and pepper and add water as necessary to thin to a saucy consistency. Meanwhile, combine the yogurt and cumin in a serving bowl. Season with salt and pepper.\r\n\r\n3.\r\nTop the eggplant mixture with the parsley, drizzle with more extra virgin olive oil, and serve with the yogurt on the side.', 'https://www.youtube.com/watch?v=uYB-1xJp4lg', '2023-08-18', 1, 12, 3),
(79, 'Squash linguine', 'https://www.themealdb.com/images/media/meals/wxswxy1511452625.jpg', '52866', 0, 1, 'Heat oven to 200C/180C fan/gas 6. Put the squash and garlic on a baking tray and drizzle with the olive oil. Roast for 35-40 mins until soft. Season.\r\nCook the pasta according to pack instructions. Drain, reserving the water. Use a stick blender to whizz the squash with 400ml cooking water. Heat some oil in a frying pan, fry the sage until crisp, then drain on kitchen paper. Tip the pasta and sauce into the pan and warm through. Scatter with sage.', 'https://www.youtube.com/watch?v=xHZ-PoGwTLQ', '2023-08-18', 1, 12, 3),
(80, 'Spring onion and prawn empanadas', 'https://www.themealdb.com/images/media/meals/1c5oso1614347493.jpg', '53040', 0, 1, 'STEP 1\r\n\r\nTo make the dough, rub the butter into the flour and then add the egg white and half the yolk (keep the rest), vinegar, a pinch of salt and enough cold water to make a soft dough. Knead on a floured surface until smooth and then wrap and rest for 30 minutes.\r\n\r\nSTEP 2\r\n\r\nHeat the oven to 180c/fan 160c/gas 4. Trim the green ends of the spring onions and then finely slice the rest. Heat a little oil in a pan and fry them gently until soft but not browned. Add the chilli and garlic, stir and then add the prawns and cook until they are opaque. Season well. Scoop out the prawns and bubble the juices until they thicken, then add back the prawns.\r\n\r\nSTEP 3\r\n\r\nDivide the empanada dough into eight balls and roll out to thin circles on a floured surface. Put some filling on one half of the dough, sprinkle the feta on top and fold the other half over. Trim the edge and then fold and crimp the dough together so the empanada is tightly sealed, put it on an oiled baking sheet either on its side or sitting on its un-crimped edge like a cornish pasty. Repeat with the remaining dough and mixture. Mix the leftover egg yolk with a splash of water and brush the top of the empanadas.\r\n\r\nSTEP 4\r\n\r\nBake for 30 minutes or until golden and slightly crisp around the edges.', 'https://www.youtube.com/watch?v=Q24haJU-1dI', '2023-08-18', 1, 17, 3),
(81, 'Spanish Tortilla', 'https://www.themealdb.com/images/media/meals/quuxsx1511476154.jpg', '52872', 0, 1, 'Put a large non-stick frying pan on a low heat. Cook the onion slowly in the oil and butter until soft but not brown – this should take about 15 mins. Add the potatoes, cover the pan and cook for a further 15-20 mins, stirring occasionally to make sure they fry evenly.\r\nWhen the potatoes are soft and the onion is shiny, crush 2 garlic cloves and stir in, followed by the beaten eggs.\r\nPut the lid back on the pan and leave the tortilla to cook gently. After 20 mins, the edges and base should be golden, the top set but the middle still a little wobbly. To turn it over, slide it onto a plate and put another plate on top, turn the whole thing over and slide it back into the pan to finish cooking. Once cooked, transfer to a plate and serve the tortilla warm or cold, scattered with the chopped parsley.\r\nTo accompany, take slices of warmed baguette, stab all over with a fork and rub with the remaining garlic, pile on grated tomatoes and season with sea salt and a drizzle of olive oil.', 'https://www.youtube.com/watch?v=JceGMNG7rpU', '2023-08-18', 1, 12, 3);
INSERT INTO `adminuser_recipe` (`id`, `name`, `thumbnail`, `idMeal`, `calculated_rating`, `is_approved`, `description`, `youtube_link`, `dateModified`, `is_active`, `category_id`, `user_id`) VALUES
(82, 'Spicy Arrabiata Penne', 'https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg', '52771', 0, 1, 'Bring a large pot of water to a boil. Add kosher salt to the boiling water, then add the pasta. Cook according to the package instructions, about 9 minutes.\r\nIn a large skillet over medium-high heat, add the olive oil and heat until the oil starts to shimmer. Add the garlic and cook, stirring, until fragrant, 1 to 2 minutes. Add the chopped tomatoes, red chile flakes, Italian seasoning and salt and pepper to taste. Bring to a boil and cook for 5 minutes. Remove from the heat and add the chopped basil.\r\nDrain the pasta and add it to the sauce. Garnish with Parmigiano-Reggiano flakes and more basil and serve warm.', 'https://www.youtube.com/watch?v=1IszT_guI08', '2023-08-18', 1, 12, 3),
(83, 'Split Pea Soup', 'https://www.themealdb.com/images/media/meals/xxtsvx1511814083.jpg', '52925', 0, 1, 'Put the gammon in a very large pan with 2 litres water and bring to the boil. Remove from the heat and drain off the water – this helps to get rid of some of the saltiness. Recover with 2 litres cold water and bring to the boil again. Put everything but the frozen peas into the pan and bring to the boil. Reduce to a simmer and cook for 1½-2½ hrs, topping up the water as and when you need to, to a similar level it started at. As the ham cooks and softens, you can halve it if you want, so it is all submerged under the liquid. When the ham is tender enough to pull into shreds, it is ready.\r\nLift out the ham, peel off and discard the skin. While it is still hot (wear a clean pair of rubber gloves), shred the meat. Remove bay from the soup and stir in the frozen peas. Simmer for 1 min, then blend until smooth. Add a splash of water if too thick, and return to the pan to heat through if it has cooled, or if you are making ahead.\r\nWhen you are ready to serve, mix the hot soup with most of the ham – gently reheat if made ahead. Serve in bowls with the remaining ham scattered on top, and eat with crusty bread and butter.', 'https://www.youtube.com/watch?v=qdhWz7qAaCU', '2023-08-18', 1, 9, 3),
(84, 'Spotted Dick', 'https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg', '52886', 0, 1, 'Put the flour and salt in a bowl. Add the suet, currants, sugar, lemon and orange zest.\r\nPour in 150ml milk and mix to a firm but moist dough, adding the extra milk if necessary.\r\nShape into a fat roll about 20cm long. Place on a large rectangle of baking parchment. Wrap loosely to allow for the pudding to rise and tie the ends with string like a Christmas cracker.\r\nPlace a steamer over a large pan of boiling water, add the pudding to the steamer, cover and steam for 1 1/2 hours. Top up the pan with water from time to time.\r\nRemove from the steamer and allow to cool slightly before unwrapping. Serve sliced with custard.', 'https://www.youtube.com/watch?v=fu15XOF-ros', '2023-08-18', 1, 15, 3),
(85, 'Shakshuka', 'https://www.themealdb.com/images/media/meals/g373701551450225.jpg', '52963', 5, 1, 'Heat the oil in a frying pan that has a lid, then soften the onions, chilli, garlic and coriander stalks for 5 mins until soft. Stir in the tomatoes and sugar, then bubble for 8-10 mins until thick. Can be frozen for 1 month.\r\n\r\nUsing the back of a large spoon, make 4 dips in the sauce, then crack an egg into each one. Put a lid on the pan, then cook over a low heat for 6-8 mins, until the eggs are done to your liking. Scatter with the coriander leaves and serve with crusty bread.', 'https://www.youtube.com/watch?v=C-3_jYrfdBU', '2023-08-18', 1, 12, 3),
(86, 'Sledz w Oleju (Polish Herrings)', 'https://www.themealdb.com/images/media/meals/7ttta31593350374.jpg', '53023', 0, 1, 'Soak herring in cold water for at least 1 hour. If very salty, repeat, changing the water each time.\r\n\r\nDrain thoroughly and slice herring into bite-size pieces.\r\n\r\nPlace in a jar large enough to accommodate the pieces and cover with oil, allspice, peppercorns, and bay leaf. Close the jar.\r\n\r\nRefrigerate for 2 to 3 days before eating. This will keep refrigerated up to 2 weeks.\r\n\r\nServe with finely chopped onion or onion slices, lemon, and parsley or dill.', 'https://www.youtube.com/watch?v=v6I3GZlBkOM', '2023-08-18', 1, 17, 3),
(87, 'Spaghetti alla Carbonara', 'https://www.themealdb.com/images/media/meals/llcbn01574260722.jpg', '52982', 0, 1, 'STEP 1\r\nPut a large saucepan of water on to boil.\r\n\r\nSTEP 2\r\nFinely chop the 100g pancetta, having first removed any rind. Finely grate 50g pecorino cheese and 50g parmesan and mix them together.\r\n\r\nSTEP 3\r\nBeat the 3 large eggs in a medium bowl and season with a little freshly grated black pepper. Set everything aside.\r\n\r\nSTEP 4\r\nAdd 1 tsp salt to the boiling water, add 350g spaghetti and when the water comes back to the boil, cook at a constant simmer, covered, for 10 minutes or until al dente (just cooked).\r\n\r\nSTEP 5\r\nSquash 2 peeled plump garlic cloves with the blade of a knife, just to bruise it.\r\n\r\nSTEP 6\r\nWhile the spaghetti is cooking, fry the pancetta with the garlic. Drop 50g unsalted butter into a large frying pan or wok and, as soon as the butter has melted, tip in the pancetta and garlic.\r\n\r\nSTEP 7\r\nLeave to cook on a medium heat for about 5 minutes, stirring often, until the pancetta is golden and crisp. The garlic has now imparted its flavour, so take it out with a slotted spoon and discard.\r\n\r\nSTEP 8\r\nKeep the heat under the pancetta on low. When the pasta is ready, lift it from the water with a pasta fork or tongs and put it in the frying pan with the pancetta. Don’t worry if a little water drops in the pan as well (you want this to happen) and don’t throw the pasta water away yet.\r\n\r\nSTEP 9\r\nMix most of the cheese in with the eggs, keeping a small handful back for sprinkling over later.\r\n\r\nSTEP 10\r\nTake the pan of spaghetti and pancetta off the heat. Now quickly pour in the eggs and cheese. Using the tongs or a long fork, lift up the spaghetti so it mixes easily with the egg mixture, which thickens but doesn’t scramble, and everything is coated.\r\n\r\nSTEP 11\r\nAdd extra pasta cooking water to keep it saucy (several tablespoons should do it). You don’t want it wet, just moist. Season with a little salt, if needed.\r\n\r\nSTEP 12\r\nUse a long-pronged fork to twist the pasta on to the serving plate or bowl. Serve immediately with a little sprinkling of the remaining cheese and a grating of black pepper. If the dish does get a little dry before serving, splash in some more hot pasta water and the glossy sauciness will be revived.', 'https://www.youtube.com/watch?v=_T6jkRvhlkk', '2023-08-18', 1, 6, 3),
(88, 'Seri muka kuih', 'https://www.themealdb.com/images/media/meals/6ut2og1619790195.jpg', '53054', 0, 1, 'Soak glutinous rice with water for at least 1 ½ hours prior to using. Drain.\r\nPrepare a 9-inch round or square cake pan and spray with cooking spray or line with plastic wrap.\r\nMix coconut milk, water, salt and the rice. Pour it into cake pan, topped with the pandan knots.\r\nSteam for 30 minutes.\r\nAfter 30 minutes, fluff up the rice and remove pandan knots. Then, using a greased spatula, flatten the steamed rice. Make sure there are no holes/air bubbles and gaps in the rice, especially the sides.\r\nSteam for another 10 minutes.\r\n\r\nCombine pandan juice, coconut milk, all purpose flour, cornflour, and sugar. Mix well.\r\nAdd eggs and whisk well then strain into a medium sized metal bowl or pot.\r\nPlace pandan mixture over simmering water (double boiler or bain-marie)\r\nStir continuously and cook till custard starts to thicken. (15 minutes)\r\nPour pandan custard into glutinous rice layer, give it a little tap (for air bubbles) and continue to steam for 30 minutes.\r\nRemove kuih seri muka from the steamer and allow to cool completely before cutting into rectangles or diamond shapes.', 'https://www.youtube.com/watch?v=_NJtCfqgaBo', '2023-08-18', 1, 15, 3),
(89, 'Salmon Eggs Eggs Benedict', 'https://www.themealdb.com/images/media/meals/1550440197.jpg', '52962', 0, 1, 'First make the Hollandaise sauce. Put the lemon juice and vinegar in a small bowl, add the egg yolks and whisk with a balloon whisk until light and frothy. Place the bowl over a pan of simmering water and whisk until mixture thickens. Gradually add the butter, whisking constantly until thick – if it looks like it might be splitting, then whisk off the heat for a few mins. Season and keep warm.\r\n\r\nTo poach the eggs, bring a large pan of water to the boil and add the vinegar. Lower the heat so that the water is simmering gently. Stir the water so you have a slight whirlpool, then slide in the eggs one by one. Cook each for about 4 mins, then remove with a slotted spoon.\r\n\r\nLightly toast and butter the muffins, then put a couple of slices of salmon on each half. Top each with an egg, spoon over some Hollandaise and garnish with chopped chives.', 'https://www.youtube.com/watch?v=Woiiet4vQ58', '2023-08-18', 1, 13, 3),
(90, 'Salmon Avocado Salad', 'https://www.themealdb.com/images/media/meals/1549542994.jpg', '52960', 0, 1, 'Season the salmon, then rub with oil. Mix the dressing ingredients together. Halve, stone, peel and slice the avocados. Halve and quarter the cucumber lengthways, then cut into slices. Divide salad, avocado and cucumber between four plates, then drizzle with half the dressing.\r\n\r\nHeat a non-stick pan. Add the salmon and fry for 3-4 mins on each side until crisp but still moist inside. Put a salmon fillet on top of each salad and drizzle over the remaining dressing. Serve warm.', 'https://www.youtube.com/watch?v=FJiu2S0Xap0', '2023-08-18', 1, 17, 3),
(91, 'Roti john', 'https://www.themealdb.com/images/media/meals/hx335q1619789561.jpg', '53052', 0, 1, 'Mix all the ingredients in a bowl.\r\nHeat a pan or griddle with a little vegetable oil.\r\nPour the mixture onto the pan and place a piece of open-faced baguette on top.\r\nPress on the bread with a spatula and grill for 2 minutes.\r\nTurn the bread over to make it a little crispy.\r\nRemove from pan and cut the bread into small portions.\r\nAdd mayonnaise and/or Sambal before cutting the sandwich (optional).', 'https://www.youtube.com/watch?v=cl4YH8wblRs', '2023-08-18', 1, 1, 3),
(92, 'Ratatouille', 'https://www.themealdb.com/images/media/meals/wrpwuu1511786491.jpg', '52908', 5, 1, 'Cut the aubergines in half lengthways. Place them on the board, cut side down, slice in half lengthways again and then across into 1.5cm chunks. Cut off the courgettes ends, then across into 1.5cm slices. Peel the peppers from stalk to bottom. Hold upright, cut around the stalk, then cut into 3 pieces. Cut away any membrane, then chop into bite-size chunks.\r\nScore a small cross on the base of each tomato, then put them into a heatproof bowl. Pour boiling water over the tomatoes, leave for 20 secs, then remove. Pour the water away, replace the tomatoes and cover with cold water. Leave to cool, then peel the skin away. Quarter the tomatoes, scrape away the seeds with a spoon, then roughly chop the flesh.\r\nSet a sauté pan over medium heat and when hot, pour in 2 tbsp olive oil. Brown the aubergines for 5 mins on each side until the pieces are soft. Set them aside and fry the courgettes in another tbsp oil for 5 mins, until golden on both sides. Repeat with the peppers. Don’t overcook the vegetables at this stage, as they have some more cooking left in the next step.\r\nTear up the basil leaves and set aside. Cook the onion in the pan for 5 mins. Add the garlic and fry for a further min. Stir in the vinegar and sugar, then tip in the tomatoes and half the basil. Return the vegetables to the pan with some salt and pepper and cook for 5 mins. Serve with basil.', 'https://www.youtube.com/watch?v=BFdQUgAFtGU', '2023-08-18', 1, 12, 3),
(93, 'Rock Cakes', 'https://www.themealdb.com/images/media/meals/tqrrsq1511723764.jpg', '52901', 0, 1, 'Preheat oven to 180C/350F/Gas 4 and line a baking tray with baking parchment.\r\nMix the flour, sugar and baking powder in a bowl and rub in the cubed butter until the mixture looks like breadcrumbs, then mix in the dried fruit.\r\nIn a clean bowl, beat the egg and milk together with the vanilla extract.\r\nAdd the egg mixture to the dry ingredients and stir with a spoon until the mixture just comes together as a thick, lumpy dough. Add a teaspoon more milk if you really need it to make the mixture stick together.\r\nPlace golfball-sized spoons of the mixture onto the prepared baking tray. Leave space between them as they will flatten and spread out to double their size during baking.\r\nBake for 15-20 minutes, until golden-brown. Remove from the oven, allow to cool for a couple of minutes then turn them out onto a wire rack to cool.', 'https://www.youtube.com/watch?v=tY3taZO3Aro', '2023-08-18', 1, 15, 3),
(94, 'Rocky Road Fudge', 'https://www.themealdb.com/images/media/meals/vtxyxv1483567157.jpg', '52786', 0, 1, 'Line an 8-inch-square baking pan with wax paper or foil, and coat with non-stick spray.\r\nPour ½ cup of the miniature marshmallows into the bottom of the lined baking dish.\r\nIn a microwave-safe bowl, combine the chocolate chips and peanut butter. Microwave the chocolate mixture in 20-second intervals, stirring in between each interval, until the chocolate is melted.\r\nAdd the vanilla extract and stir well, until smooth.\r\nReserve 2 tablespoons of the chopped almonds or peanuts, and set aside.\r\nFold 1 ½ cups of the miniature marshmallows and the remaining chopped nuts into the chocolate mixture.\r\nTransfer the chocolate mixture into the prepared pan and spread into an even layer. Immediately top with the reserved chopped nuts and the mallow bits or additional miniature marshmallows, if using.\r\nRefrigerate for 4 hours, or until set.\r\nRemove the fudge and wax paper from the pan. Carefully peel all of wax paper from the fudge.\r\nCut the fudge into bite-sized pieces and serve.', 'https://www.youtube.com/watch?v=N1aJ3nEYXyg', '2023-08-18', 1, 15, 3),
(95, 'Rappie Pie', 'https://www.themealdb.com/images/media/meals/ruwpww1511817242.jpg', '52933', 0, 1, 'Preheat oven to 400 degrees F (200 degrees C). Grease a 10x14x2-inch baking pan.\r\nHeat margarine in a skillet over medium heat; stir in onion. Cook and stir until onion has softened and turned translucent, about 5 minutes. Reduce heat to low and continue to cook and stir until onion is very tender and dark brown, about 40 minutes more.\r\nBring chicken broth to a boil in a large pot; stir in chicken breasts, reduce heat, and simmer until chicken is no longer pink at the center, about 20 minutes. Remove from heat. Remove chicken breasts to a plate using a slotted spoon; reserve broth.\r\nJuice potatoes with an electric juicer; place dry potato flesh into a bowl and discard juice. Stir salt and pepper into potatoes; stir in enough reserved broth to make the mixture the consistency of oatmeal. Set remaining broth aside.\r\nSpread half of potato mixture evenly into the prepared pan. Lay cooked chicken breast evenly over potatoes; scatter caramelized onion evenly over chicken. Spread remaining potato mixture over onions and chicken to cover.\r\nBake in the preheated oven until golden brown, about 1 hour. Reheat chicken broth; pour over individual servings as desired.', 'https://www.youtube.com/watch?v=Ys2kZnTVXAM', '2023-08-18', 1, 2, 3),
(96, 'Rogaliki (Polish Croissant Cookies)', 'https://www.themealdb.com/images/media/meals/7mxnzz1593350801.jpg', '53024', 0, 1, 'In a medium bowl mix egg yolks, philly cheese and baking powder using a hand held mixer. Carefully start adding the flour. When the mixture will not be mixing well, and will look like wood chips, put away the blending mixer and using your hands knead the dough.\r\nCreate a roll and cover in foil and freeze for 15 minutes. At this time preheat the oven to 375.\r\nTake the dough out and separate into two. Roll and cut out 3 inch trangles.\r\nMake as many as you can and on centre of each put a small spoon of jam. Roll them into a croissant shape.\r\nPlace the croissants onto a greased cookie sheet, and bake for 10-12 minutes or until golden.\r\nRepeat with the rest of the dough.\r\nWhen you take them out, put aside and sprinkle with powdered sugar on top.\r\nThis makes about 3 batches of 20 cookies each.\r\nTotal count about 60 cookies.', 'https://www.youtube.com/watch?v=VAR10T9mfhU', '2023-08-18', 1, 15, 3),
(97, 'Potato Gratin with Chicken', 'https://www.themealdb.com/images/media/meals/qwrtut1468418027.jpg', '52780', 0, 1, '15 minute potato gratin with chicken and bacon greens: a gratin always seems more effort and more indulgent than ordinary boiled or roasts, but it doesn\'t have to take 45mins, it\'s nice for a change and you can control the calorie content by going with full fat to low fat creme fraiche. (It\'s always tastes better full fat though obviously!) to serve 4: use 800g of potatoes, finely slice and boil in a pan for about 5-8 mins till firmish, not soft. Finely slice 3 onions and place in an oven dish with 2 tblsp of olive oil and 100ml of chicken stock. Cook till the onions are soft then drain the potatoes and pour onto the onions. Season and spoon over cream or creme fraiche till all is covered but not swimming. Grate Parmesan over the top then finish under the grill till nicely golden. serve with chicken and bacon, peas and spinach.', 'https://www.youtube.com/watch?v=p3u8eiy3yHI', '2023-08-18', 1, 2, 3),
(98, 'Peanut Butter Cookies', 'https://www.themealdb.com/images/media/meals/1544384070.jpg', '52958', 0, 1, 'Preheat oven to 350ºF (180ºC).\r\nIn a large bowl, mix together the peanut butter, sugar, and egg.\r\nScoop out a spoonful of dough and roll it into a ball. Place the cookie balls onto a nonstick baking sheet.\r\nFor extra decoration and to make them cook more evenly, flatten the cookie balls by pressing a fork down on top of them, then press it down again at a 90º angle to make a criss-cross pattern.\r\nBake for 8-10 minutes or until the bottom of the cookies are golden brown.\r\nRemove from baking sheet and cool.\r\nEnjoy!', '', '2023-08-18', 1, 15, 3),
(99, 'Pear Tarte Tatin', 'https://www.themealdb.com/images/media/meals/rxvxrr1511797671.jpg', '52916', 0, 1, 'Core the pears, then peel as neatly as possible and halve. If you like, they can be prepared up to a day ahead and kept in the fridge, uncovered, so that they dry out.\r\nTip the sugar, butter, star anise, cardamom and cinnamon into an ovenproof frying pan, about 20cm wide, and place over a high heat until bubbling. Shake the pan and stir the buttery sauce until it separates and the sugar caramelises to a toffee colour.\r\nLay the pears in the pan, then cook in the sauce for 10-12 mins, tossing occasionally, until completely caramelised. Don’t worry about them burning – they won’t – but you want to caramelise them as much as possible. Splash in the brandy and let it flambé, then set the pears aside.\r\nHeat oven to 200C/fan 180C/gas 6. Roll the pastry out to the thickness of a £1 coin. Using a plate slightly larger than the top of the pan, cut out a circle, then press the edges of the circle of pastry to thin them out.\r\nWhen the pears have cooled slightly, arrange them in the pan, cut side up, in a floral shape, with the pears around the edge pointing inwards. Rest the cinnamon stick on the top in the centre, with the cardamom pods scattered around.\r\nDrape the pastry over the pears, then tuck the edges down the pan sides and under the fruit (see Gordon’s guide). Pierce the pastry a few times, then bake for 15 mins. If a lot of juice bubbles up the side of the pan, pour it off at this stage (see guide). Reduce oven to 180C/fan 160C/gas 4 and bake for 15 mins more until the pastry is golden. Leave the tart to stand for 10 mins, then invert it carefully onto a serving dish.', 'https://www.youtube.com/watch?v=8U1tKWKDeWA', '2023-08-18', 1, 15, 3),
(100, 'Pilchard puttanesca', 'https://www.themealdb.com/images/media/meals/vvtvtr1511180578.jpg', '52837', 4, 1, 'Cook the pasta following pack instructions. Heat the oil in a non-stick frying pan and cook the onion, garlic and chilli for 3-4 mins to soften. Stir in the tomato purée and cook for 1 min, then add the pilchards with their sauce. Cook, breaking up the fish with a wooden spoon, then add the olives and continue to cook for a few more mins.\r\n\r\nDrain the pasta and add to the pan with 2-3 tbsp of the cooking water. Toss everything together well, then divide between plates and serve, scattered with Parmesan.', 'https://www.youtube.com/watch?v=wqZzLAPmr9k', '2023-08-18', 1, 6, 3),
(101, 'Peanut Butter Cheesecake', 'https://www.themealdb.com/images/media/meals/qtuuys1511387068.jpg', '52861', 0, 1, 'Oil and line a 20cm round loose- bottomed cake tin with cling film, making it as smooth as possible. Melt the butter in a pan. Crush the biscuits by bashing them in a bag with a rolling pin, then stir them into the butter until very well coated. Press the mixture firmly into the base of the tin and chill.\r\nSoak the gelatine in water while you make the filling. Tip the ricotta into a bowl, then beat in the peanut butter and syrup. Ricotta has a slightly grainy texture so blitz until smooth with a stick blender for a smoother texture if you prefer.\r\nTake the soaked gelatine from the water and squeeze dry. Put it into a pan with the milk and heat very gently until the gelatine dissolves. Beat into the peanut mixture, then tip onto the biscuit base. Chill until set.\r\nTo freeze, leave in the tin and as soon as it is solid, cover the surface with cling film, then wrap the tin with cling film and foil.\r\nTo defrost, thaw in the fridge overnight.\r\nTo serve, carefully remove from the tin. Whisk the cream with the sugar until it holds its shape, then spread on top of the cheesecake and scatter with the peanut brittle.', 'https://www.youtube.com/watch?v=QSTsturcyL0', '2023-08-18', 1, 15, 3),
(102, 'Pate Chinois', 'https://www.themealdb.com/images/media/meals/yyrrxr1511816289.jpg', '52930', 0, 1, 'In a large pot of salted water, cook the potatoes until they are very tender. Drain.\r\nWith a masher, coarsely crush the potatoes with at least 30 ml (2 tablespoons) of butter. With an electric mixer, purée with the milk. Season with salt and pepper. Set aside.\r\nWith the rack in the middle position, preheat the oven to 190 °C (375 °F).\r\nIn a large skillet, brown the onion in the remaining butter. Add the meat and cook until golden brown. Season with salt and pepper. Remove from the heat.\r\nLightly press the meat at the bottom of a 20-cm (8-inch) square baking dish. Cover with the corn and the mashed potatoes. Sprinkle with paprika and parsley.\r\nBake for about 30 minutes. Finish cooking under the broiler. Let cool for 10 minutes.', 'https://www.youtube.com/watch?v=QRFqnLkEv3I', '2023-08-18', 1, 1, 3),
(103, 'Parkin Cake', 'https://www.themealdb.com/images/media/meals/qxuqtt1511724269.jpg', '52902', 4, 1, 'Heat oven to 160C/140C fan/gas 3. Grease a deep 22cm/9in square cake tin and line with baking parchment. Beat the egg and milk together with a fork.\r\n\r\nGently melt the syrup, treacle, sugar and butter together in a large pan until the sugar has dissolved. Remove from the heat. Mix together the oatmeal, flour and ginger and stir into the syrup mixture, followed by the egg and milk.\r\n\r\nPour the mixture into the tin and bake for 50 mins - 1 hr until the cake feels firm and a little crusty on top. Cool in the tin then wrap in more parchment and foil and keep for 3-5 days before eating if you can – it’ll become softer and stickier the longer you leave it, up to 2 weeks.\r\n', 'https://www.youtube.com/watch?v=k1lG4vk2MQA', '2023-08-18', 1, 15, 3),
(104, 'Pancakes', 'https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg', '52854', 0, 1, 'Put the flour, eggs, milk, 1 tbsp oil and a pinch of salt into a bowl or large jug, then whisk to a smooth batter. Set aside for 30 mins to rest if you have time, or start cooking straight away.\r\nSet a medium frying pan or crêpe pan over a medium heat and carefully wipe it with some oiled kitchen paper. When hot, cook your pancakes for 1 min on each side until golden, keeping them warm in a low oven as you go.\r\nServe with lemon wedges and sugar, or your favourite filling. Once cold, you can layer the pancakes between baking parchment, then wrap in cling film and freeze for up to 2 months.', 'https://www.youtube.com/watch?v=LWuuCndtJr0', '2023-08-18', 1, 15, 3),
(105, 'Mulukhiyah', 'https://www.themealdb.com/images/media/meals/x372ug1598733932.jpg', '53029', 0, 1, 'Saute the onions in the 3-4 tablespoons olive oil\r\nAdd the beef cubes or the chicken cutlets, sear for 3-4 min on each side\r\nAdd 1 liter of water or just enough to cover the meat\r\nCook over medium heat until the meat is done (I usually do this in the pressure cooker and press them for 5 min)\r\n\r\nAdd the frozen mulukhyia and stir until it thaws completely and then comes to a boil\r\n\r\nIn another pan add the 1/4 to 1/2 cup of olive oil and the cloves of garlic and cook over medium low heat until you can smell the garlic (don’t brown it, it will become bitter)\r\n\r\nAdd the oil and garlic to the mulukhyia and lower the heat and simmer for 5-10 minutes\r\nAdd salt to taste\r\n\r\nServe with a generous amount of lemon juice.\r\n\r\nYou can serve it with some short grain rice or some pita bread', 'https://www.youtube.com/watch?v=vWc5JzgAkIQ', '2023-08-18', 1, 1, 3),
(106, 'Mushroom soup with buckwheat', 'https://www.themealdb.com/images/media/meals/1ngcbf1628770793.jpg', '53059', 0, 1, 'Chop the onion and garlic, slice the mushrooms and wash the buckwheat. Heat the oil and lightly sauté the onion. Add the mushrooms and the garlic and continue to sauté. Add the salt, vegetable seasoning, buckwheat and the bay leaf and cover with water. Simmer gently and just before it is completely cooked, add pepper, sour cream mixed with flour, the chopped parsley and vinegar to taste.', 'https://www.youtube.com/watch?v=M1ok7mG9-Qc', '2023-08-18', 1, 9, 3),
(107, 'Mustard champ', 'https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg', '53038', 0, 1, 'STEP 1\r\nBoil the potatoes for 15 mins or until tender. Drain, then mash.\r\n\r\nSTEP 2\r\nHeat the milk and half the butter in the corner of the pan, then beat into the mash, along with the wholegrain mustard.\r\n\r\nSTEP 3\r\nGently fry the spring onions in the remaining butter for 2 mins until just soft but still a perky green. Fold into the mash and serve. Great with gammon or to top a fish pie.', 'https://www.youtube.com/watch?v=_iKllHSC978', '2023-08-18', 1, 9, 3),
(108, 'Nutty Chicken Curry', 'https://www.themealdb.com/images/media/meals/yxsurp1511304301.jpg', '52851', 0, 1, 'Finely slice a quarter of the chilli, then put the rest in a food processor with the ginger, garlic, coriander stalks and one-third of the leaves. Whizz to a rough paste with a splash of water if needed.\r\nHeat the oil in a frying pan, then quickly brown the chicken chunks for 1 min. Stir in the paste for another min, then add the peanut butter, stock and yogurt. When the sauce is gently bubbling, cook for 10 mins until the chicken is just cooked through and sauce thickened. Stir in most of the remaining coriander, then scatter the rest on top with the chilli, if using. Eat with rice or mashed sweet potato.', 'https://www.youtube.com/watch?v=nSQNfZxOdeU', '2023-08-18', 1, 2, 3),
(109, 'Moussaka', 'https://www.themealdb.com/images/media/meals/ctg8jd1585563097.jpg', '53006', 0, 1, 'Heat the grill to high. Brown the beef in a deep ovenproof frying pan over a high heat for 5 mins. Meanwhile, prick the aubergine with a fork, then microwave on High for 3-5 mins until soft. Mix the yogurt, egg and parmesan together, then add a little seasoning.\r\n\r\nStir the tomatoes, purée and potatoes in with the beef with some seasoning and heat through. Smooth the surface of the beef mixture with the back of a spoon, then slice the cooked aubergine and arrange on top. Pour the yogurt mixture over the aubergines, smooth out evenly, then grill until the topping has set and turned golden.', 'https://www.youtube.com/watch?v=8U_29i9Qp5U', '2023-08-18', 1, 1, 3),
(110, 'Moroccan Carrot Soup', 'https://www.themealdb.com/images/media/meals/jcr46d1614763831.jpg', '53047', 0, 1, 'Step 1\r\nPreheat oven to 180° C.\r\nStep 2\r\nCombine carrots, onion, garlic, cumin seeds, coriander seeds, salt and olive oil in a bowl and mix well. Transfer on a baking tray.\r\nStep 3\r\nPut the baking tray in preheated oven and roast for 10-12 minutes or till carrots soften. Remove from heat and cool.\r\nStep 4\r\nGrind the baked carrot mixture along with some water to make a smooth paste and strain in a bowl.\r\nStep 5\r\nHeat the carrot mixture in a non-stick pan. Add two cups of water and bring to a boil. Add garam masala powder and mix. Add salt and mix well.\r\nStep 6\r\nRemove from heat, add lemon juice and mix well.\r\nStep 7\r\nServe hot.', 'https://www.youtube.com/watch?v=7tDWOpnIhok', '2023-08-18', 1, 12, 3),
(111, 'Minced Beef Pie', 'https://www.themealdb.com/images/media/meals/xwutvy1511555540.jpg', '52876', 0, 1, 'Preheat the oven to 200C/400F/Gas 6.\r\nHeat the oil in a deep frying pan and fry the beef mince for 4-5 minutes, breaking it up with a wooden spoon as it browns.\r\nAdd the onion and cook for 2-3 minutes, then stir in the tomato purée and cook for 2-3 more minutes. Stir in the flour and cook for a further minute, then add the chopped mushrooms, the stout or beef stock and a couple of dashes of Worcestershire sauce. Bring to the boil, then reduce the heat, cover the pan with a lid and leave to simmer for 20 minutes. Set aside and leave to cool, then turn the meat mixture into a one litre pie dish.\r\nRoll out the pastry on a floured work surface until it is slightly larger than the pie dish. Gently drape the pastry over the dish, pressing firmly onto the edges. Trim, then shape the edges into a fluted shape.\r\nCut some leaf shapes out of the pastry trimmings and decorate the top of the pie, sticking them to the pastry with the beaten egg yolk.\r\nMake three or four slits in the pastry to allow the steam to escape, then brush the pie with the rest of the beaten egg yolk and bake in the oven for 20-25 minutes, or until golden-brown.\r\nTo serve, slice into wedges.', 'https://www.youtube.com/watch?v=QY47h-uqq5g', '2023-08-18', 1, 1, 3),
(114, 'Matar Paneer', 'static/thumbnails/paneer.jpg', NULL, 5, 1, 'Step 1 Saute the spices and cook onion until translucent\r\nTo prepare this mouth-watering paneer recipe, heat oil in a frying pan. Once the oil is hot enough, add the asafoetida, cumin seeds, mace powder, minced onions and green chillies. Saute the onion until translucent and then add the ginger-garlic paste in it and saute again for 2-3 minutes. If you like the smoky flavour of garlic, stir fry it for some more time and add fresh tomato puree to it.\r\nStep 2 Cook the peas first and then add paneer in the masala\r\nStir well and add in the dry masalas except for the garam masala and salt. Mix and saute till the oil start separating from the sides. Next, add peas and paneer. Mix it gently and add water. Adjust the spices and salt to taste. If you want to make the gravy aromatic, add the garam masala in the last step of cooking this recipe. Put the lid on the pan and let it cook.\r\nStep 3 Add fresh cream and cook for 2-3 minutes\r\nOnce the gravy starts boiling, add fresh cream. Now add garam masala and stir well\r\nStep 4 Garnish and serve\r\nGarnish with fresh coriander leaves and serve hot with Chapati, Butter/Tandoori Roti, Jeera rice or Veg pulao! Do try this easy recipe, rate it and leave your comments in the section below.', NULL, '2023-08-22', 1, 12, 2),
(119, 'Kedgeree', 'https://www.themealdb.com/images/media/meals/utxqpt1511639216.jpg', '52887', 0, 1, 'For the rice, heat the oil in a large, lidded pan, add the onion, then gently fry for 5 mins until softened but not coloured. Add the spices, season with salt, then continue to fry until the mix start to go brown and fragrant; about 3 mins.\r\nAdd the rice and stir in well. Add 600ml water, stir, then bring to the boil. Reduce to a simmer, then cover for 10 mins. Take off the heat and leave to stand, covered, for 10-15 mins more. The rice will be perfectly cooked if you do not lift the lid before the end of the cooking.\r\nMeanwhile, put the haddock and bay leaves in a frying pan, cover with the milk, then poach for 10 mins until the flesh flakes. Remove from the milk, peel away the skin, then flake the flesh into thumbsize pieces. Place the eggs in a pan, cover with water, bring to the boil, then reduce to a simmer. Leave for 4½-5 mins, plunge into cold water, then peel and cut the eggs into quarters. Gently mix the fish, eggs, parsley, coriander and rice together in the pan. Serve hot, sprinkled with a few extra herbs.', 'https://www.youtube.com/watch?v=_Pw1I1-SItE', '2023-08-23', 1, 17, 3);

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_recipe_ingredient`
--

CREATE TABLE `adminuser_recipe_ingredient` (
  `id` bigint(20) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `ingredient_id` bigint(20) DEFAULT NULL,
  `recipe_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser_recipe_ingredient`
--

INSERT INTO `adminuser_recipe_ingredient` (`id`, `quantity`, `ingredient_id`, `recipe_id`) VALUES
(1, '1 whole', 1, 1),
(2, '1 chopped', 341, 1),
(3, '2 chopped', 212, 1),
(4, '2 chopped', 138, 1),
(5, '1 chopped', 245, 1),
(6, '1 chopped', 42, 1),
(7, '1', 188, 1),
(8, '2 tsp', 290, 1),
(9, '1 tsp ', 518, 1),
(10, '2 tbs', 274, 1),
(11, '2 tsp', 89, 1),
(12, '2 cups ', 81, 1),
(13, '1 tbs', 303, 1),
(14, '1.2 kg', 1, 2),
(15, '5 thinly sliced', 340, 2),
(16, '2 finely chopped', 293, 2),
(17, '8 cloves chopped', 137, 2),
(18, '1 tbsp', 145, 2),
(19, '¼ cup', 303, 2),
(20, '2 tsp', 95, 2),
(21, '3 tsp', 87, 2),
(22, '1 tsp', 297, 2),
(23, '1 tsp', 66, 2),
(24, '2', 152, 2),
(25, '1 cup', 319, 2),
(26, '¾ cup', 90, 2),
(27, '3 tsp Dried', 120, 2),
(28, '1 tsp', 136, 2),
(29, 'To taste', 260, 2),
(30, '8 oz ', 1, 3),
(31, 'pinch', 260, 3),
(32, 'pinch', 229, 3),
(33, '1 tsp ', 143, 3),
(34, '1 tsp ', 142, 3),
(35, '1 tbs', 278, 3),
(36, '1/2 cup ', 249, 3),
(37, '8 cups ', 309, 3),
(38, '2 oz ', 85, 3),
(39, '1 tbs', 210, 5),
(40, '300g', 204, 5),
(41, '4', 59, 5),
(42, '500g', 352, 5),
(43, '1', 344, 5),
(44, '100g ', 339, 5),
(45, 'Chopped', 222, 5),
(46, '2 Juice', 186, 6),
(47, '4 tsp', 217, 6),
(48, '2 finely chopped', 244, 6),
(49, '16 skinnless', 61, 6),
(50, 'For brushing', 303, 6),
(51, '300ml ', 150, 6),
(52, 'large piece', 142, 6),
(53, '4', 138, 6),
(54, '¾ tsp', 136, 6),
(55, '¾ tsp', 157, 6),
(56, '½ tsp', 66, 6),
(57, '¼ tsp', 296, 6),
(58, '2 tbs', 258, 7),
(59, '2 tbs', 274, 7),
(60, '2 tbs', 414, 7),
(61, '2 tbs', 330, 7),
(62, '2 tbs', 309, 7),
(63, '500g', 1, 7),
(64, '1 tbs', 66, 7),
(65, '1 tsp ', 491, 7),
(66, '1 tbs', 35, 7),
(67, '4 Chopped', 278, 7),
(68, '6 cloves', 138, 7),
(69, '220g', 492, 7),
(70, '100g ', 225, 7),
(71, '200 g', 202, 8),
(72, '250 g', 9, 8),
(73, '1  bunch', 131, 8),
(74, '350 g', 117, 8),
(75, '3  tablespoons', 115, 8),
(76, '40 g', 153, 8),
(77, '200 g', 295, 8),
(78, 'to taste', 260, 8),
(79, 'to taste', 229, 8),
(80, '4', 538, 9),
(81, '100g ', 125, 9),
(82, '2 Beaten ', 112, 9),
(83, '100g ', 31, 9),
(84, 'Fry', 303, 9),
(85, '2 tbs', 291, 9),
(86, '2 tbs', 318, 9),
(87, '1 tbs', 216, 9),
(88, '2 tblsp ', 45, 9),
(89, '2', 236, 10),
(90, '1', 244, 10),
(91, '2 cloves', 137, 10),
(92, '1', 188, 10),
(93, '2', 30, 10),
(94, '1 lb', 4, 10),
(95, ' ', 362, 10),
(96, ' ', 166, 10),
(97, ' ', 291, 10),
(98, ' ', 282, 10),
(99, ' ', 303, 10),
(100, ' ', 260, 10),
(101, ' ', 229, 10),
(102, '1 tbs', 36, 11),
(103, '4', 10, 11),
(104, '1 finely sliced', 340, 11),
(105, '1 chopped', 138, 11),
(106, '20', 427, 11),
(107, '400g', 236, 11),
(108, '120g', 233, 12),
(109, '60g', 45, 12),
(110, '60g', 36, 12),
(111, '300g', 435, 12),
(112, '30g', 36, 12),
(113, '30g', 100, 12),
(114, '1 large', 8, 13),
(115, '½ cup ', 340, 13),
(116, '1 cup', 293, 13),
(117, '6 cloves', 137, 13),
(118, '1.5 pounds sliced', 4, 14),
(119, '1 package thin', 252, 14),
(120, '4-6', 109, 14),
(121, '3 tablespoons minced', 50, 14),
(122, '1.5 tablespoons minced garlic', 137, 14),
(123, '¼ cup', 282, 14),
(124, '1 tablespoon', 122, 14),
(125, '½ tablespoon thick', 274, 14),
(126, '½ tablespoon', 229, 14),
(127, '3 tablespoons', 210, 14),
(128, 'Sliced', 93, 14),
(129, 'Leaves', 200, 14),
(130, 'Crushed', 225, 14),
(131, '4 tbsp', 364, 15),
(132, '350g', 4, 15),
(133, '1 large', 340, 15),
(134, '10', 137, 15),
(135, '1 thinly sliced', 42, 15),
(136, '1 tsp ', 119, 15),
(137, '2 tblsp ', 367, 15),
(138, '600ml', 304, 15),
(139, '1 tblsp ', 292, 15),
(140, '2 sticks', 369, 15),
(141, 'Handful', 222, 15),
(142, '400g', 368, 15),
(143, '2 tblsp ', 31, 15),
(144, 'drizzle', 209, 15),
(145, 'to serve', 30, 15),
(146, 'to serve', 32, 15),
(147, '200g', 4, 16),
(148, '1', 454, 16),
(149, 'Dash', 309, 16),
(150, '1/2 tsp', 260, 16),
(151, '1 tsp ', 282, 16),
(152, '10g', 274, 16),
(153, '10g', 499, 16),
(154, '30g', 292, 16),
(155, '10g', 308, 16),
(156, 'Dash', 85, 16),
(157, 'Knob', 36, 17),
(158, '2', 538, 17),
(159, '4', 10, 17),
(160, '2', 236, 17),
(161, '1', 42, 17),
(162, '1/2 ', 418, 17),
(163, '1/2 ', 411, 17),
(164, '1', 16, 17),
(165, '100ml', 570, 17),
(166, '100g ', 60, 17),
(167, '2', 236, 18),
(168, '1', 459, 18),
(169, '2 cloves', 137, 18),
(170, '1', 183, 18),
(171, '2', 4, 18),
(172, '1', 320, 18),
(173, '1', 60, 18),
(174, '1 tbsp', 303, 18),
(175, '1 1/2 tsp ', 282, 18),
(176, '2 tbsp', 36, 18),
(177, '2', 4, 19),
(178, '200ml', 314, 19),
(179, '1/2 tsp', 217, 19),
(180, '2', 183, 19),
(181, '1/2 ', 184, 19),
(182, 'Dash', 210, 19),
(183, 'To serve', 544, 19),
(184, '1 kg', 236, 19),
(185, 'For frying', 303, 19),
(186, '2 sliced', 10, 20),
(187, '1 lb', 561, 20),
(188, '1 lb', 4, 20),
(189, '1/4 cup', 125, 20),
(190, '3 chopped', 137, 20),
(191, '1 Diced', 340, 20),
(192, '1 1/2 cup ', 204, 20),
(193, '4 cups ', 411, 20),
(194, '1 Jar', 563, 20),
(195, '1/4 cup', 247, 20),
(196, '1', 16, 20),
(197, '1 tsp ', 13, 20),
(198, '1 tsp ', 193, 20),
(199, '1 tbs', 217, 20),
(200, '1/8 teaspoon', 564, 20),
(201, '1 dash', 166, 20),
(202, '5 Cups', 21, 20),
(203, '2 tbs', 292, 20),
(204, '1 cup ', 101, 20),
(205, '1 dash', 318, 20),
(206, '1/3 cup', 204, 21),
(207, '1/3 cup', 506, 21),
(208, '2/3 Cup', 493, 21),
(209, '1/2 cup ', 4, 21),
(210, '2-1/2 cups', 60, 21),
(211, '1/2 tsp', 260, 21),
(212, '1/4 tsp', 282, 21),
(213, '1 tsp ', 414, 21),
(214, '1/4 tsp', 229, 21),
(215, '1/2 tsp', 166, 21),
(216, '1-½ cups', 308, 21),
(217, '1 tsp ', 274, 21),
(218, '1 tbs', 89, 21),
(219, '2 tbs', 309, 21),
(220, '1/4 cup', 278, 21),
(221, '1 tbs', 303, 22),
(222, '1 large', 340, 22),
(223, '1 chopped', 4, 22),
(224, '150ml', 304, 22),
(225, '1 tbs', 274, 22),
(226, '1 tsp ', 413, 22),
(227, '1 tsp ', 282, 22),
(228, '2 Beaten ', 112, 22),
(229, '200g', 568, 22),
(230, 'Chopped', 465, 22),
(231, '1.5kg', 3, 23),
(232, '1', 541, 23),
(233, '8 ounces', 292, 23),
(234, '3 cups ', 309, 23),
(235, '6 tablespoons', 274, 23),
(236, '1 tbs', 512, 23),
(237, '2 tbs', 229, 23),
(238, '4', 16, 23),
(239, '1/2 ', 183, 23),
(240, '2 tbs', 372, 23),
(241, '3 tbs', 36, 23),
(242, '1/2 cup ', 210, 23),
(243, '1 chopped', 340, 23),
(244, '4 cloves', 137, 23),
(245, '1/2 lb', 3, 24),
(246, 'pinch', 260, 24),
(247, 'pinch', 229, 24),
(248, '2 tsp', 414, 24),
(249, '1/2 ', 454, 24),
(250, '3 tbs', 499, 24),
(251, '5 tbs', 209, 24),
(252, '1/4 lb', 505, 24),
(253, '1/2 cup ', 340, 24),
(254, '1 tsp ', 198, 24),
(255, '1 tsp ', 142, 24),
(256, '1 cup ', 504, 24),
(257, '1 cup ', 204, 24),
(258, '1 cup ', 309, 24),
(259, '1 tbs', 216, 24),
(260, '1 tsp ', 282, 24),
(261, '1 tsp ', 274, 24),
(262, '1lb', 3, 25),
(263, '5 tbs', 303, 25),
(264, '1', 76, 25),
(265, '3', 77, 25),
(266, '3', 468, 25),
(267, '3', 41, 25),
(268, '1 cup ', 80, 25),
(269, '1 cup ', 309, 25),
(270, '2 tbs', 286, 25),
(271, '6', 188, 25),
(272, '1 tbs', 282, 25),
(273, '5', 50, 25),
(274, '3 cloves', 137, 26),
(275, '1 sliced', 340, 26),
(276, '2 Lbs', 3, 26),
(277, '8 ounces', 292, 26),
(278, '1 cup ', 309, 26),
(279, '3 tbs', 210, 26),
(280, '1 Slice', 183, 26),
(281, '1 large', 236, 26),
(282, '1/4 cup', 274, 26),
(283, '1/2 tsp', 24, 26),
(284, '2', 17, 26),
(285, 'To taste', 260, 26),
(286, '1/2 lb', 3, 27),
(287, '1/2 tsp', 260, 27),
(288, '1 tsp ', 414, 27),
(289, '1 pinch', 229, 27),
(290, '1', 110, 27),
(291, '3 tbs', 499, 27),
(292, '4 tbs', 209, 27),
(293, '1 tsp ', 142, 27),
(294, '1 tsp ', 137, 27),
(295, '3/4 cup ', 340, 27),
(296, '1/2 cup ', 42, 27),
(297, '3/4 cup ', 396, 27),
(298, '1 cup ', 48, 27),
(299, '1 cup ', 204, 27),
(300, '1 tbs', 501, 27),
(301, '1 cup ', 309, 27),
(302, '1 tbs', 216, 27),
(303, '1/2 tsp', 166, 27),
(304, '1 tsp ', 282, 27),
(305, '1 tbs', 274, 27),
(306, '2kg cut cubes', 3, 28),
(307, '1', 21, 28),
(308, '1 tbs', 274, 28),
(309, '2 cups ', 309, 28),
(310, '1 sliced', 396, 28),
(311, '1 sliced', 245, 28),
(312, '1 sliced', 236, 28),
(313, '1 sliced', 42, 28),
(314, '8 ounces', 292, 28),
(315, '3  tablespoons', 223, 28),
(316, '5', 66, 28),
(317, '1 chopped', 340, 28),
(318, '5 cloves', 137, 28),
(319, '3 tbs', 210, 28),
(320, '2 tblsp ', 210, 29),
(321, '1 finely sliced', 340, 29),
(322, '2 chopped', 42, 29),
(323, '500g', 355, 29),
(324, '2 cloves minced', 137, 29),
(325, '½ tsp', 94, 29),
(326, '½ tsp', 142, 29),
(327, '¼ tsp', 256, 29),
(328, '1 tsp ', 75, 29),
(329, '1 tblsp ', 163, 29),
(330, '100g ', 357, 29),
(331, '1', 305, 29),
(332, '1 medium chopped', 358, 29),
(333, 'Steamed', 359, 29),
(334, 'Chopped', 222, 29),
(335, '500g', 179, 30),
(336, '2 cloves minced', 137, 30),
(337, '1', 340, 30),
(338, '300g', 277, 30),
(339, '3 tbs', 292, 30),
(340, '1 tbs', 94, 30),
(341, '1 Litre', 60, 30),
(342, '3 tsp', 161, 30),
(343, '400g', 62, 30),
(344, '1/2 ', 184, 30),
(345, '150g', 190, 30),
(346, 'Pinch', 260, 30),
(347, 'Pinch', 229, 30),
(348, '2 quartered', 340, 31),
(349, '4 tbsp', 284, 31),
(350, '4 cloves', 137, 31),
(351, 'Thumb sized peeled and very finely grated', 142, 31),
(352, '2 tbsp', 192, 31),
(353, '2 tsp', 217, 31),
(354, '1', 76, 31),
(355, '6 bashed to break shells', 41, 31),
(356, '600g', 236, 32),
(357, '1 chopped', 397, 32),
(358, '1 chopped', 42, 32),
(359, '1 chopped', 396, 32),
(360, '1 small', 8, 32),
(361, '1 Large Chopped', 340, 32),
(362, '800g', 356, 32),
(363, '1 tbs', 140, 32),
(364, '1 tbs', 292, 32),
(365, '80 ml ', 210, 32),
(366, 'Sprinking', 290, 32),
(367, '250ml', 314, 32),
(368, 'Pinch', 229, 32),
(369, '500g', 356, 33),
(370, '1 tbls', 125, 33),
(371, 'Dash', 303, 33),
(372, '1 sliced', 340, 33),
(373, '2 sliced', 42, 33),
(374, '350ml/12fl', 304, 33),
(375, '500g', 236, 33),
(376, '450g', 390, 33),
(377, 'To Glaze', 112, 33),
(378, '4 large', 293, 34),
(379, 'Pinch', 282, 34),
(380, '4 tbs', 210, 34),
(381, '1 chopped', 340, 34),
(382, '2 finely chopped', 138, 34),
(383, '200g', 177, 34),
(384, '1 tbs', 75, 34),
(385, '2 tbs chopped', 292, 34),
(386, '50g', 249, 34),
(387, '100ml', 60, 34),
(388, '4 tbs', 103, 34),
(389, '2 tbs', 70, 34),
(390, '1 tbs', 200, 34),
(391, '12', 43, 35),
(392, '½ tbsp', 174, 35),
(393, '½ tbsp', 95, 35),
(394, '3 sliced thinly', 212, 35),
(395, '2 tsp', 144, 35),
(396, '4 whole', 137, 35),
(397, 'Leaves', 200, 35),
(398, 'Leaves', 74, 35),
(399, '½ tsp dissolved in ½ cup warm milk', 256, 35),
(400, '2 tbsp', 141, 35),
(401, '2 Cups', 15, 35),
(402, '½ cup', 135, 35),
(403, '1 tbsp', 95, 35),
(404, '½', 16, 35),
(405, '1 thin piece', 75, 35),
(406, '3', 77, 35),
(407, '2', 41, 35),
(408, '1 lb', 177, 35),
(409, '1 tsp', 243, 35),
(410, '1 tbsp', 23, 35),
(411, '25g', 548, 36),
(412, '500g', 179, 36),
(413, '1 tsp ', 94, 36),
(414, '1 tsp ', 85, 36),
(415, '1 tsp ', 217, 36),
(416, '1 clove finely chopped', 137, 36),
(417, 'For frying', 210, 36),
(418, '4', 535, 36),
(419, 'Grated', 93, 36),
(420, '200g', 150, 36),
(421, '2 tbs', 200, 36),
(422, '2 cloves', 137, 37),
(423, '2 tsp', 263, 37),
(424, '4 tbs', 210, 37),
(425, 'Zest and juice of 1', 183, 37),
(426, '1 tbs', 103, 37),
(427, '750g', 355, 37),
(428, 'To serve', 547, 37),
(429, '1 cups', 154, 39),
(430, '400g', 405, 40),
(431, '1 can ', 406, 40),
(432, '1 can ', 71, 40),
(433, '1 Packet', 407, 40),
(434, '1', 353, 41),
(435, '1', 340, 41),
(436, '3 cloves', 137, 41),
(437, '1 tsp ', 217, 41),
(438, '½ tsp', 94, 41),
(439, '1 tblsp ', 290, 41),
(440, '3 Medium', 42, 41),
(441, '2 small stalks', 48, 41),
(442, '1', 245, 41),
(443, '1', 395, 41),
(444, '2 x 400g tins', 341, 41),
(445, '250ml', 305, 41),
(446, '2 sliced', 397, 41),
(447, '2 sprigs', 290, 41),
(448, '250g', 404, 41),
(449, '4 large', 236, 42),
(450, '1  bunch', 278, 42),
(451, '100g ', 233, 42),
(452, '1', 110, 42),
(453, '150ml', 197, 42),
(454, '1 tsp ', 22, 42),
(455, '3 tbs', 36, 42),
(456, '2 tbs', 303, 42),
(457, '6', 55, 42),
(458, '12', 10, 42),
(459, '6', 454, 42),
(460, '2', 262, 43),
(461, '3', 10, 43),
(462, '2', 204, 43),
(463, '2', 293, 43),
(464, '1 Slice', 443, 43),
(465, '2', 112, 43),
(466, '1 Slice', 30, 43),
(467, '3 Medium', 236, 44),
(468, '1 tbs', 210, 44),
(469, '2 strips', 10, 44),
(470, 'Minced', 138, 44),
(471, '1 tbs', 383, 44),
(472, 'Garnish', 222, 44),
(473, 'Pinch', 260, 44),
(474, 'Pinch', 229, 44),
(475, 'To taste', 518, 44),
(476, '4', 262, 45),
(477, '4', 10, 45),
(478, '4', 204, 45),
(479, '3', 293, 45),
(480, '2 sliced', 443, 45),
(481, '2', 112, 45),
(482, '1 Slice', 30, 45),
(483, '100g ', 444, 45),
(484, '1 1/4 oz ', 322, 46),
(485, '1 1/4 cup', 282, 46),
(486, '1 teaspoon', 300, 46),
(487, '2', 238, 46),
(488, '1 kg', 521, 47),
(489, '1 kg', 330, 47),
(490, '2', 293, 47),
(491, 'Pinch', 260, 47),
(492, '1', 340, 47),
(493, '1', 152, 47),
(494, '1  bunch', 86, 47),
(495, '400g', 331, 48),
(496, '8', 237, 48),
(497, '2 pinches', 256, 48),
(498, '1 cup ', 404, 49),
(499, '1 large', 340, 49),
(500, '1 large', 42, 49),
(501, '1 tbs', 292, 49),
(502, '2 tsp', 94, 49),
(503, '1 tsp ', 217, 49),
(504, '1/2 tsp', 200, 49),
(505, '1/2 tsp', 290, 49),
(506, '1/4 tsp', 24, 49),
(507, '1/4 tsp', 246, 49),
(508, '4 cups ', 304, 49),
(509, '1 cup ', 309, 49),
(510, 'Pinch', 263, 49),
(511, '1 Packet', 525, 50),
(512, '150g', 360, 50),
(513, '150g', 340, 50),
(514, '40g', 209, 50),
(515, 'Dash', 260, 50),
(516, 'Dash', 229, 50),
(517, '300ml ', 568, 51),
(518, '100ml', 500, 51),
(519, '2 tbs', 45, 51),
(520, '3 tbs', 544, 51),
(521, '1 tbs', 500, 51),
(522, '1 tbs', 274, 51),
(523, '1', 93, 51),
(524, '2 large', 236, 52),
(525, '2 tbs', 36, 52),
(526, '150g', 53, 52),
(527, '1 large', 340, 52),
(528, '1 large', 245, 52),
(529, 'Pinch', 241, 52),
(530, '1 lb', 3, 53),
(531, '5 tablespoons', 274, 53),
(532, '1', 183, 53),
(533, '3 cloves', 137, 53),
(534, '3 parts ', 340, 53),
(535, '4 tbs', 210, 53),
(536, '1 cup ', 309, 53),
(537, '1 pinch', 260, 53),
(538, '3 cups ', 488, 54),
(539, '6', 278, 54),
(540, '4', 138, 54),
(541, '1/4 cup', 222, 54),
(542, '2 tsp', 94, 54),
(543, '1 tsp ', 11, 54),
(544, '1/2 tsp', 46, 54),
(545, 'Spinkling', 125, 54),
(546, 'As required', 303, 54),
(547, '5 Large', 236, 55),
(548, '2 tbs', 210, 55),
(549, '1', 396, 55),
(550, '5', 212, 55),
(551, '1 tbs', 524, 55),
(552, '500g', 389, 55),
(553, '24 Skinned', 112, 55),
(554, 'Pinch', 260, 55),
(555, 'Pinch', 229, 55),
(556, '1 tblsp ', 210, 56),
(557, '2', 10, 56),
(558, '1 finely chopped ', 340, 56),
(559, '1 Stick', 48, 56),
(560, '1 medium', 42, 56),
(561, '2 cloves chopped', 137, 56),
(562, '500g', 360, 56),
(563, '1 tbls', 292, 56),
(564, '800g', 71, 56),
(565, '1 tblsp ', 163, 56),
(566, '500g', 180, 56),
(567, '400ml', 91, 56),
(568, '125g', 202, 56),
(569, '50g', 220, 56),
(570, 'Topping', 14, 56),
(571, '1 cup', 294, 57),
(572, '2-1/2 cups', 309, 57),
(573, '1 tsp', 260, 57),
(574, '1/4 tsp', 296, 57),
(575, '3 tbs', 141, 57),
(576, '1 cup', 71, 57),
(577, '1/2 tsp', 95, 57),
(578, '1/2 tsp', 207, 57),
(579, '2', 16, 57),
(580, '1lb', 4, 58),
(581, '3 chopped', 138, 58),
(582, '1 tsp ', 142, 58),
(583, '1 tbs', 274, 58),
(584, '1 tsp ', 414, 58),
(585, '3 finely chopped', 42, 58),
(586, '3 finely chopped', 48, 58),
(587, '6 chopped', 278, 58),
(588, '1 Packet', 498, 58),
(589, 'Fry', 209, 58),
(590, 'Bottle', 309, 58),
(591, '2 cups ', 125, 59),
(592, '1/3 cup', 282, 59),
(593, 'Dash', 303, 60),
(594, '3 tsp', 11, 59),
(595, '½ tsp', 260, 59),
(596, '1 beaten', 454, 59),
(597, '¾ cup', 197, 59),
(598, '3 tbs', 209, 59),
(599, 'for frying', 209, 59),
(600, 'garnish', 323, 59),
(601, '1 Can', 20, 60),
(602, '5 thin cut', 236, 60),
(603, '2 cups', 54, 60),
(604, '1 1/2 cups ', 33, 61),
(605, '1 1/2 cups ', 249, 61),
(606, '1/2 tsp', 85, 61),
(607, '2 cups ', 190, 61),
(608, 'Can', 62, 61),
(609, '1 large', 340, 61),
(610, 'Sprinking', 260, 61),
(611, '1/2 cup ', 303, 61),
(612, '400g', 360, 62),
(613, '2 tbs', 210, 62),
(614, '2', 551, 62),
(615, 'Chopped', 340, 62),
(616, '1/4 ', 553, 62),
(617, '2 sliced', 53, 62),
(618, '2 large', 550, 62),
(619, '1 cup ', 544, 62),
(620, '2 tsp', 512, 62),
(621, 'Pinch', 229, 62),
(622, '2 tsp', 205, 62),
(623, '1 1/2 tsp ', 211, 62),
(624, '1 1/2 tsp ', 139, 62),
(625, '1/2 tsp', 217, 62),
(626, '1 kg', 61, 63),
(627, '1 tbs', 85, 63),
(628, '1 tbs', 94, 63),
(629, '1 tbs', 41, 63),
(630, '1 tsp ', 46, 63),
(631, '2 tsp', 217, 63),
(632, '2 tbs', 184, 63),
(633, '3 tbs', 210, 63),
(634, '1 cup ', 150, 63),
(635, '1', 138, 63),
(636, '1 tsp ', 94, 63),
(637, 'Splash', 184, 63),
(638, 'Sliced', 187, 63),
(639, 'Sliced', 341, 63),
(640, '6', 547, 63),
(641, '1.5kg', 236, 64),
(642, '2 leaves', 16, 64),
(643, '2', 267, 64),
(644, '3 tbs', 36, 64),
(645, '750g', 173, 64),
(646, '2', 262, 64),
(647, '500ml', 197, 64),
(648, 'Grated', 208, 64),
(649, 'Pinch', 260, 64),
(650, 'Pinch', 229, 64),
(651, '568ml', 105, 65),
(652, '100g ', 310, 65),
(653, 'Pod of', 299, 65),
(654, '6', 111, 65),
(655, '2 tbs', 45, 65),
(656, 'Top', 45, 65),
(657, '250g', 410, 66),
(658, '2 tbs', 414, 66),
(659, '1 sliced', 340, 66),
(660, '0.25', 411, 66),
(661, '10', 412, 66),
(662, '4', 278, 66),
(663, '4 tbsp', 413, 66),
(664, '2 tbs', 274, 66),
(665, '1 tblsp ', 45, 66),
(666, '1 tblsp ', 318, 66),
(667, '4', 108, 67),
(668, '2', 112, 67),
(669, '1 tsp ', 260, 67),
(670, '4 tsp', 210, 67),
(671, '250g', 233, 68),
(672, '135g', 36, 68),
(673, '400g', 146, 68),
(674, '150g', 31, 68),
(675, 'Zest of 2', 186, 68),
(676, '1 beaten', 112, 68),
(677, '450g', 236, 69),
(678, '2 tblsp ', 210, 69),
(679, '4', 112, 69),
(680, '1 tbls', 367, 69),
(681, '2 tblsp ', 377, 69),
(682, '50g', 284, 69),
(683, '½', 244, 69),
(684, '100g ', 277, 69),
(685, '400g', 295, 69),
(686, '1 large', 213, 70),
(687, '300g', 45, 70),
(688, '75 ml ', 210, 70),
(689, '280g', 125, 70),
(690, '1 tbs', 11, 70),
(691, '4 large', 112, 70),
(692, '2 tsp', 300, 70),
(693, '3/4 cup', 274, 71),
(694, '1/2 cup', 309, 71),
(695, '1/4 cup', 35, 71),
(696, '1/2 teaspoon', 158, 71),
(697, '1/2 teaspoon', 198, 71),
(698, '4 Tablespoons', 89, 71),
(699, '2', 58, 71),
(700, '1 (12 oz.)', 280, 71),
(701, '3 cups', 34, 71),
(702, '8', 262, 72),
(703, '3 tbsp', 303, 72),
(704, '100g', 233, 72),
(705, '2 medium', 112, 72),
(706, '1 tbsp grated', 164, 72),
(707, '225ml', 197, 72),
(708, '200g', 55, 72),
(709, '50g', 408, 73),
(710, 'zest and juice of 1', 183, 73),
(711, '2 tblsp ', 210, 73),
(712, '1 chopped', 244, 73),
(713, '1 clove peeled crushed', 137, 73),
(714, '1 thinly sliced', 395, 73),
(715, '200g', 151, 73),
(716, '1 sliced', 397, 73),
(717, '100g shredded', 173, 73),
(718, '250g pack', 404, 73),
(719, '300g', 238, 74),
(720, 'Dusting', 233, 74),
(721, '6', 435, 74),
(722, '100g ', 45, 74),
(723, '85g', 36, 74),
(724, 'to serve', 91, 74),
(725, '2 cups ', 35, 75),
(726, '¼ cup', 36, 75),
(727, '2', 112, 75),
(728, '1 tsp ', 300, 75),
(729, '1 tsp ', 260, 75),
(730, '½ cup ', 233, 75),
(731, '1 1/2 cups ', 197, 75),
(732, '1 tbs', 353, 76),
(733, '2 finely chopped', 182, 76),
(734, '1 large', 397, 76),
(735, '1L', 304, 76),
(736, '400g', 40, 76),
(737, '200g', 151, 76),
(738, '3 chopped', 293, 76),
(739, '3 chopped', 138, 76),
(740, 'Small pack', 13, 76),
(741, '40g', 219, 76),
(742, '300g', 281, 77),
(743, '250g', 433, 77),
(744, '100g ', 432, 77),
(745, '500g', 379, 77),
(746, '175g', 45, 77),
(747, '7 Slices', 30, 77),
(748, '4 tablespoons', 210, 78),
(749, '6 small', 108, 78),
(750, '350g', 358, 79),
(751, '3 parts ', 137, 79),
(752, '3 tbs', 210, 79),
(753, '350g', 347, 79),
(754, 'Small bunch', 257, 79),
(755, '1  bunch', 278, 80),
(756, 'Dash', 210, 80),
(757, '1 finely sliced', 242, 80),
(758, '1 clove', 137, 80),
(759, '350g', 237, 80),
(760, '75g', 121, 80),
(761, '15g', 36, 80),
(762, '250g', 233, 80),
(763, '1 Seperated', 454, 80),
(764, '1/2 tsp', 512, 80),
(765, '1 sliced', 340, 81),
(766, '4 tbsp', 210, 81),
(767, '25g', 36, 81),
(768, '400g', 236, 81),
(769, '6 cloves', 137, 81),
(770, '8', 112, 81),
(771, 'Handful', 222, 81),
(772, '1', 415, 81),
(773, '4', 416, 81),
(774, 'drizzle', 210, 81),
(775, '1 pound', 228, 82),
(776, '1/4 cup', 210, 82),
(777, '3 cloves', 137, 82),
(778, '1 tin ', 71, 82),
(779, '1/2 teaspoon', 241, 82),
(780, '1/2 teaspoon', 169, 82),
(781, '6 leaves', 13, 82),
(782, 'spinkling', 221, 82),
(783, '1kg', 419, 83),
(784, '200g (soaked overnight)', 226, 83),
(785, '2 chopped', 212, 83),
(786, '2 chopped', 42, 83),
(787, '2', 17, 83),
(788, '1 chopped', 48, 83),
(789, '300g', 472, 83),
(790, 'to serve', 30, 83),
(791, '250g', 264, 84),
(792, 'pinch', 260, 84),
(793, '125g', 417, 84),
(794, '175g', 429, 84),
(795, '80g', 45, 84),
(796, 'Zest of 1', 183, 84),
(797, 'Zest of 1', 213, 84),
(798, '150ml', 197, 84),
(799, 'to serve', 430, 84),
(800, '1 tbs', 210, 85),
(801, '2 chopped', 244, 85),
(802, '1 finely chopped ', 242, 85),
(803, '1 clove', 137, 85),
(804, 'Chopped', 85, 85),
(805, '800g', 55, 85),
(806, '1 tbs', 45, 85),
(807, '4', 112, 85),
(808, 'Spinkling', 121, 85),
(809, '8', 565, 86),
(810, '1 sliced', 340, 86),
(811, '1/2 cup ', 210, 86),
(812, '1 tsp ', 518, 86),
(813, '1 tsp ', 229, 86),
(814, '1', 16, 86),
(815, '320g', 276, 87),
(816, '6', 111, 87),
(817, 'As required', 260, 87),
(818, '150g', 10, 87),
(819, '50g', 227, 87),
(820, 'As required', 24, 87),
(821, '400g', 249, 88),
(822, '150ml', 81, 88),
(823, '100ml', 309, 88),
(824, '1 tsp ', 260, 88),
(825, '5 tbs', 330, 88),
(826, '3 tbs', 125, 88),
(827, '3', 112, 88),
(828, '200ml', 80, 88),
(829, '140g', 282, 88),
(830, '4', 112, 89),
(831, '2 tbs', 512, 89),
(832, '2', 510, 89),
(833, 'To serve', 36, 89),
(834, '8 slices', 513, 89),
(835, '2 tsp', 184, 89),
(836, '2 tsp', 512, 89),
(837, '3 Yolkes', 454, 89),
(838, '125g', 462, 89),
(839, '400g', 2, 90),
(840, '3', 5, 90),
(841, '1', 93, 90),
(842, '400g', 277, 90),
(843, '4 tbs', 200, 90),
(844, 'zest and juice of 1', 188, 90),
(845, '2 tsp', 163, 90),
(846, '3 tbs', 210, 90),
(847, '1/4 lb', 360, 91),
(848, '1', 340, 91),
(849, '3', 112, 91),
(850, '1 tbs', 65, 91),
(851, '1/2 ', 415, 91),
(852, 'To taste', 260, 91),
(853, 'To taste', 229, 91),
(854, 'Top', 544, 91),
(855, '2 large', 8, 92),
(856, '4', 397, 92),
(857, '2', 395, 92),
(858, '4 large', 341, 92),
(859, '5 tbs', 210, 92),
(860, 'Bunch', 13, 92),
(861, '1 medium', 340, 92),
(862, '3 finely chopped', 138, 92),
(863, '1 tsp ', 367, 92),
(864, '1 tsp ', 282, 92),
(865, '225g', 264, 93),
(866, '75g', 45, 93),
(867, '1 tsp ', 11, 93),
(868, '125g', 36, 93),
(869, '150g', 448, 93),
(870, '1', 112, 93),
(871, '1 tbs', 197, 93),
(872, '2 tsp', 300, 93),
(873, '2 cups', 199, 94),
(874, '3 cups', 68, 94),
(875, '½ cup', 223, 94),
(876, '1 tsp', 300, 94),
(877, '1 ¼ cups', 225, 94),
(878, '2 tbs', 36, 95),
(879, '2 chopped', 212, 95),
(880, '4 qt ', 60, 95),
(881, '1.5kg', 57, 95),
(882, '4kg', 236, 95),
(883, '2 tbs', 260, 95),
(884, '1tbsp', 24, 95),
(885, '1 cup ', 36, 96),
(886, '3', 111, 96),
(887, '8 oz ', 322, 96),
(888, '1 tsp ', 11, 96),
(889, '3 cups ', 125, 96),
(890, '1 Jar', 566, 96),
(891, '800g', 236, 97),
(892, '3', 212, 97),
(893, '2 tblsp', 210, 97),
(894, '100ml', 60, 97),
(895, '1 pot', 91, 97),
(896, 'Topping', 219, 97),
(897, '4', 58, 97),
(898, '4', 10, 97),
(899, 'Topping', 277, 97),
(900, 'Topping', 226, 97),
(901, '1 cup ', 223, 98),
(902, '1/2 cup ', 282, 98),
(903, '1', 454, 98),
(904, '8', 466, 99),
(905, '100g ', 45, 99),
(906, '100g ', 36, 99),
(907, '2', 468, 99),
(908, '3 Pods', 41, 99),
(909, '1 large', 75, 99),
(910, '2 tbs', 29, 99),
(911, '500g', 238, 99),
(912, '300g', 276, 100),
(913, '1 tbls', 210, 100),
(914, '1 finely chopped ', 340, 100),
(915, '2 cloves minced', 137, 100),
(916, '1', 242, 100),
(917, '1 tbls', 292, 100),
(918, '425g', 338, 100),
(919, '70g', 339, 100),
(920, 'Shaved', 219, 100),
(921, '50g', 36, 101),
(922, '175g', 391, 101),
(923, '5', 392, 101),
(924, '500g', 375, 101),
(925, '175g', 223, 101),
(926, '175g', 146, 101),
(927, '150ml', 197, 101),
(928, '275ml', 105, 101),
(929, '2 tblsp ', 384, 101),
(930, 'Crushed', 393, 101),
(931, '4 cups ', 236, 102),
(932, '60ml', 36, 102),
(933, '½ cup ', 197, 102),
(934, '450g', 360, 102),
(935, '1 finely chopped ', 340, 102),
(936, '500ml', 474, 102),
(937, 'to taste', 217, 102),
(938, 'to taste', 222, 102),
(939, 'Dash', 260, 102),
(940, 'Dash', 229, 102),
(941, '200g', 36, 103),
(942, '1 large', 454, 103),
(943, '4 tbs', 197, 103),
(944, '200g', 146, 103),
(945, '85g', 25, 103),
(946, '85g', 35, 103),
(947, '100g ', 452, 103),
(948, '250g', 264, 103),
(949, '1 tbs', 158, 103),
(950, '100g ', 125, 104),
(951, '2 large', 112, 104),
(952, '300ml ', 197, 104),
(953, '1 tbls', 284, 104),
(954, 'to serve', 282, 104),
(955, 'to serve', 379, 104),
(956, 'to serve', 380, 104),
(957, '800g', 567, 105),
(958, '1 chopped', 340, 105),
(959, '300g', 3, 105),
(960, '1 tsp ', 260, 105),
(961, '1 Litre', 309, 105),
(962, '1', 138, 105),
(963, '1/2 cup ', 210, 105),
(964, '150g', 204, 106),
(965, '50g', 574, 106),
(966, '4 tbs', 303, 106),
(967, '40g', 340, 106),
(968, '2 cloves', 137, 106),
(969, '1', 16, 106),
(970, '1tbsp', 305, 106),
(971, '50 ml ', 273, 106),
(972, 'Dash', 512, 106),
(973, 'Top', 222, 106),
(974, '1kg', 236, 107),
(975, '200ml', 197, 107),
(976, '50g', 36, 107),
(977, '2 tbs', 205, 107),
(978, 'Bunch', 278, 107),
(979, 'Bunch', 278, 107),
(980, '1 large', 242, 108),
(981, '0.5', 142, 108),
(982, '1 large', 137, 108),
(983, 'Bunch', 85, 108),
(984, '1 tbsp', 284, 108),
(985, '4', 58, 108),
(986, '5 tblsp ', 223, 108),
(987, '150ml', 60, 108),
(988, '200g', 150, 108),
(989, '500g', 3, 109),
(990, '1 large', 8, 109),
(991, '150g', 150, 109),
(992, '1 beaten', 454, 109),
(993, '3 tbs', 219, 109),
(994, '400g', 341, 109),
(995, '4 tbs', 292, 109),
(996, '350g', 236, 109),
(997, '6 chopped', 42, 110),
(998, '1 sliced', 340, 110),
(999, '4', 138, 110),
(1000, '1 tsp ', 94, 110),
(1001, '1/2 tsp', 85, 110),
(1002, '1 tbs', 210, 110),
(1003, '1/4 tsp', 136, 110),
(1004, '1 tsp ', 184, 110),
(1005, '2 tbs', 303, 111),
(1006, '500g', 360, 111),
(1007, '1 chopped', 340, 111),
(1008, '1 tbls', 292, 111),
(1009, '1 ½ tbsp', 233, 111),
(1010, '75g', 204, 111),
(1011, '250ml', 21, 111),
(1012, 'Dash', 318, 111),
(1013, '400g', 390, 111),
(1014, '1', 111, 111),
(1018, '250 gm ', 402, 114),
(1019, '2 large ', 578, 114),
(1020, '1 teaspoon', 145, 114),
(1021, '1 teaspoon ', 579, 114),
(1022, '1 tablespoon ', 580, 114),
(1023, '1/2 teaspoon ', 296, 114),
(1024, '1 cup ', 309, 114),
(1025, 'as required', 260, 114),
(1026, '1 cup ', 226, 114),
(1027, '1 cup ', 292, 114),
(1035, '300g', 426, 119),
(1036, '2', 17, 119),
(1037, '300ml ', 197, 119),
(1038, '4', 112, 119),
(1039, 'Handful', 222, 119),
(1040, 'Handful', 85, 119),
(1041, '2 tbs', 303, 119),
(1042, '1 chopped', 340, 119),
(1043, '1 tsp ', 85, 119),
(1044, '2 tsp', 96, 119),
(1045, '300g', 249, 119);

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_reports`
--

CREATE TABLE `adminuser_reports` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `creation_date` date NOT NULL,
  `recipe_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser_reports`
--

INSERT INTO `adminuser_reports` (`id`, `description`, `status`, `creation_date`, `recipe_id`, `user_id`) VALUES
(1, 'hello tehre', 'Approve', '2023-08-17', 26, 2),
(2, 'This recipe needs to be updated', 'Pending', '2023-08-23', 92, 7);

-- --------------------------------------------------------

--
-- Table structure for table `adminuser_request`
--

CREATE TABLE `adminuser_request` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `creation_date` date NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminuser_request`
--

INSERT INTO `adminuser_request` (`id`, `name`, `description`, `status`, `creation_date`, `user_id`) VALUES
(1, 'Coffee', 'Please add the recipe for coffee.\r\nThank you', 'Reject', '2023-08-16', 2),
(2, 'pizza', 'Please add the recipe of pizza.', 'Reject', '2023-08-16', 2),
(3, 'Manchurian', 'Manchurian kaise bnana hai iska tutorial daalo ??', 'Pending', '2023-08-16', 2),
(4, 'matar gobhi', 'please add this', 'Pending', '2023-08-21', 3),
(5, 'matar gobhi', 'please add this', 'Pending', '2023-08-21', 3),
(6, 'asd', 'add kro', 'Pending', '2023-08-21', 3),
(7, '', 'hgj', 'Pending', '2023-08-21', 3),
(8, 'shahi paneer', 'Please add this recipe as soon as possible', 'Pending', '2023-08-23', 7);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_user'),
(22, 'Can change user', 6, 'change_user'),
(23, 'Can delete user', 6, 'delete_user'),
(24, 'Can view user', 6, 'view_user'),
(25, 'Can add roles', 7, 'add_roles'),
(26, 'Can change roles', 7, 'change_roles'),
(27, 'Can delete roles', 7, 'delete_roles'),
(28, 'Can view roles', 7, 'view_roles'),
(29, 'Can add user profile', 8, 'add_userprofile'),
(30, 'Can change user profile', 8, 'change_userprofile'),
(31, 'Can delete user profile', 8, 'delete_userprofile'),
(32, 'Can view user profile', 8, 'view_userprofile'),
(33, 'Can add category', 9, 'add_category'),
(34, 'Can change category', 9, 'change_category'),
(35, 'Can delete category', 9, 'delete_category'),
(36, 'Can view category', 9, 'view_category'),
(37, 'Can add comments', 10, 'add_comments'),
(38, 'Can change comments', 10, 'change_comments'),
(39, 'Can delete comments', 10, 'delete_comments'),
(40, 'Can view comments', 10, 'view_comments'),
(41, 'Can add comments dislike', 11, 'add_commentsdislike'),
(42, 'Can change comments dislike', 11, 'change_commentsdislike'),
(43, 'Can delete comments dislike', 11, 'delete_commentsdislike'),
(44, 'Can view comments dislike', 11, 'view_commentsdislike'),
(45, 'Can add comments like', 12, 'add_commentslike'),
(46, 'Can change comments like', 12, 'change_commentslike'),
(47, 'Can delete comments like', 12, 'delete_commentslike'),
(48, 'Can view comments like', 12, 'view_commentslike'),
(49, 'Can add favourites', 13, 'add_favourites'),
(50, 'Can change favourites', 13, 'change_favourites'),
(51, 'Can delete favourites', 13, 'delete_favourites'),
(52, 'Can view favourites', 13, 'view_favourites'),
(53, 'Can add ingredient', 14, 'add_ingredient'),
(54, 'Can change ingredient', 14, 'change_ingredient'),
(55, 'Can delete ingredient', 14, 'delete_ingredient'),
(56, 'Can view ingredient', 14, 'view_ingredient'),
(57, 'Can add payments', 15, 'add_payments'),
(58, 'Can change payments', 15, 'change_payments'),
(59, 'Can delete payments', 15, 'delete_payments'),
(60, 'Can view payments', 15, 'view_payments'),
(61, 'Can add rating', 16, 'add_rating'),
(62, 'Can change rating', 16, 'change_rating'),
(63, 'Can delete rating', 16, 'delete_rating'),
(64, 'Can view rating', 16, 'view_rating'),
(65, 'Can add recipe', 17, 'add_recipe'),
(66, 'Can change recipe', 17, 'change_recipe'),
(67, 'Can delete recipe', 17, 'delete_recipe'),
(68, 'Can view recipe', 17, 'view_recipe'),
(69, 'Can add recipe_ ingredient', 18, 'add_recipe_ingredient'),
(70, 'Can change recipe_ ingredient', 18, 'change_recipe_ingredient'),
(71, 'Can delete recipe_ ingredient', 18, 'delete_recipe_ingredient'),
(72, 'Can view recipe_ ingredient', 18, 'view_recipe_ingredient'),
(73, 'Can add reports', 19, 'add_reports'),
(74, 'Can change reports', 19, 'change_reports'),
(75, 'Can delete reports', 19, 'delete_reports'),
(76, 'Can view reports', 19, 'view_reports'),
(77, 'Can add request', 20, 'add_request'),
(78, 'Can change request', 20, 'change_request'),
(79, 'Can delete request', 20, 'delete_request'),
(80, 'Can view request', 20, 'view_request');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(9, 'adminuser', 'category'),
(10, 'adminuser', 'comments'),
(11, 'adminuser', 'commentsdislike'),
(12, 'adminuser', 'commentslike'),
(13, 'adminuser', 'favourites'),
(14, 'adminuser', 'ingredient'),
(15, 'adminuser', 'payments'),
(16, 'adminuser', 'rating'),
(17, 'adminuser', 'recipe'),
(18, 'adminuser', 'recipe_ingredient'),
(19, 'adminuser', 'reports'),
(20, 'adminuser', 'request'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session'),
(7, 'users', 'roles'),
(6, 'users', 'user'),
(8, 'users', 'userprofile');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-08-14 09:33:39.512475'),
(2, 'contenttypes', '0002_remove_content_type_name', '2023-08-14 09:33:39.720528'),
(3, 'auth', '0001_initial', '2023-08-14 09:33:40.402217'),
(4, 'auth', '0002_alter_permission_name_max_length', '2023-08-14 09:33:40.424099'),
(5, 'auth', '0003_alter_user_email_max_length', '2023-08-14 09:33:40.436564'),
(6, 'auth', '0004_alter_user_username_opts', '2023-08-14 09:33:40.449224'),
(7, 'auth', '0005_alter_user_last_login_null', '2023-08-14 09:33:40.461716'),
(8, 'auth', '0006_require_contenttypes_0002', '2023-08-14 09:33:40.464376'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2023-08-14 09:33:40.477771'),
(10, 'auth', '0008_alter_user_username_max_length', '2023-08-14 09:33:40.489989'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2023-08-14 09:33:40.501957'),
(12, 'auth', '0010_alter_group_name_max_length', '2023-08-14 09:33:40.515106'),
(13, 'auth', '0011_update_proxy_permissions', '2023-08-14 09:33:40.526786'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2023-08-14 09:33:40.537970'),
(15, 'users', '0001_initial', '2023-08-14 09:33:41.636091'),
(16, 'admin', '0001_initial', '2023-08-14 09:33:41.978495'),
(17, 'admin', '0002_logentry_remove_auto_add', '2023-08-14 09:33:41.998114'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2023-08-14 09:33:42.021538'),
(19, 'adminuser', '0001_initial', '2023-08-14 09:33:42.652611'),
(20, 'adminuser', '0002_initial', '2023-08-14 09:33:45.221601'),
(21, 'sessions', '0001_initial', '2023-08-14 09:33:45.334949'),
(22, 'users', '0002_alter_roles_name', '2023-08-14 09:33:45.347903'),
(23, 'users', '0003_alter_roles_name', '2023-08-14 09:33:45.360770'),
(24, 'users', '0004_alter_roles_name', '2023-08-14 09:33:45.373670'),
(25, 'users', '0005_alter_roles_name', '2023-08-14 09:33:45.386868');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('2mlb2ohml8eo6hqpgieimr477c1c79gq', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYRIZ:e7N-V5qWoGgNKLqXOyAWEWkFI_-68avjW4ZrSfI6BsU', '2023-09-05 13:19:55.921574'),
('3zl7n4x9stlwglstrudi7tn0uibndgmm', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYR05:1woJ0OT9mec9yUe22Khv_rR6VhZRSKWZgVc2LSNG1sY', '2023-09-05 13:00:49.719890'),
('5r7mzkeklir3lcbl4i6wyfuy9j2msow7', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qYR05:RsxKoZIVeeNvMLXF8gzq3IcBqcJPdofFn1JnmrQl1MI', '2023-09-05 13:00:49.724246'),
('60m1biy90mbl7awxv6umq07rui7iv7ph', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYROJ:TVmkMN4BzYqkEo4voXFQkTyx528-gjqeKXttYl53Qxo', '2023-09-05 13:25:51.018714'),
('9n7s891wkcebpomsgp6io2adlvdq04dw', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qaUGY:RdzpyeKChBRYuGCa08wOPUvBw66S3c5_iFOO7AAM3-c', '2023-09-11 04:54:18.210038'),
('ba875nzcsxkz0pwqackeldes21yiuxul', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qWdRC:fFYy3JMSJUsnXLrGa46xbJxoNpj-ZLWjcTMLbp0Kjes', '2023-08-31 13:53:22.884171'),
('bl6xu6ha83i8ijyh0a50cmky1zp5n5zr', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYRFZ:qSfV3GnC5fa3L0oOi3rPffgQtb-IozRdb79LyiHPkpk', '2023-09-05 13:16:49.776364'),
('d00vhamuf9lv6pgdtxz7z5q3sm9cymrk', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1r5fnM:bW0icqUhPlfsfOAs7i4qvMdSPNPN0rm3Z4ubcqpPdX4', '2023-12-06 05:29:04.682164'),
('d1yh00f2xj4xqd3hukcml276a16041xx', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYREk:7GXExhClsS2jmfTtuYjgDRyV4O39_3Kzmy24VVUZe3g', '2023-09-05 13:15:58.987424'),
('defsm8zefdruelribc52s02ogqivh7mf', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qqqm5:PdR6jAZPMEvdjHR3ItBaANczQa0BzDxq8EAg3oM5rk8', '2023-10-26 08:10:29.108795'),
('dgu10aysvy6zh4ofsd967ugocmz8o7uy', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYRIX:0DyfXoAWj0zvWwLlq90PvBAJO99nWTnBMkgU8CJaLRE', '2023-09-05 13:19:53.240475'),
('doz3wh2pmh0ldtmixpfe9jcr8q0fvd6h', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qYn6v:LPeW6rR2EQJkSzMBUf7ukLgnACQRhouSn3SUTMB6koA', '2023-09-06 12:37:21.193004'),
('es9da21zp8fx7c1h0h5k80v315tkqhhl', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qZ1yF:N75RKsGGygCgW2QPFRMBKHboJSZ_ZMLoXsvHOT3b1pI', '2023-09-07 04:29:23.365314'),
('hnygz7k5h019l999ssp7k4rwpvxtu145', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qWdRC:4FWH0luj9tVuquRgMZTHQZhXGHuNPpXTftyh6UX4MaE', '2023-08-31 13:53:22.482457'),
('i613lp0thqth0y058zy2v5vyl5x5bd5t', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYRFZ:qSfV3GnC5fa3L0oOi3rPffgQtb-IozRdb79LyiHPkpk', '2023-09-05 13:16:49.778600'),
('n1sf6w6261230cd7uv8rzv33ujgl25c5', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qYhwR:OxkEKj61MvCDEBl7tDwGs3b8vJU6MFPy4RG7lGVZv7U', '2023-09-06 07:06:11.501520'),
('ncbqeamw9q0b8nn80enhi394od3xy942', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYQyy:Rdz8gcuVhYT5WJvQx2h07-fRjT-Gyb2d7OtqsO_SPRg', '2023-09-05 12:59:40.562231'),
('o5ir9i8f8zrau5w704ifl1bqiyzzxxr9', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qWxRE:tG6nCM2ihxAuwJ-DfY-VMp-RxzGfVYRc_eBHuoaRmN0', '2023-09-01 11:14:44.756632'),
('onv9srcnwzqfs7oj6lxnedjn30xutumc', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qWdOy:PE28nfN1Qcy0gzpcrdCytvR1d90AcdApZoM2ScROHPg', '2023-08-31 13:51:04.989935'),
('oorclqq3a95sxs7yenfqn01de8fk4bgh', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qWBSJ:ofH9ZyzpUC8YlSwQf3RSiv3LVHS8YI1-hNqaXWioQi0', '2023-08-30 08:00:39.639246'),
('px6yqyblpip8whe09axeo8tqk7gqgu9x', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYRIa:YtLKOdcCccfBwvK8FYpGWaD3wteLTxH3j4zsqHNrE6c', '2023-09-05 13:19:56.124134'),
('pzg1w0ugf4lterj99jvj1pqeeng4my9m', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qaTVg:CvoPEoJ6tfr-pWIYqZ9-xe_yKN9xI7HkhO9UlHw7wgI', '2023-09-11 04:05:52.423597'),
('r5ng6i3w5tpdz26y34rqr0l1gk19gfzo', '.eJxVjLEOAiEQRP-F2hCQWyCW9n4D2YVFTg0kx11l_He55AptpnjzZt4i4LaWsHVewpzERWhx-mWE8cl1L9ID673J2Oq6zCR3RR5tl7eW-HU93L-Dgr2M9eQmj8kliMaCykahJlJsHVjLzhoE5aLPmYnNyLPGjDSoAVA-JxCfL-ZWOF8:1qYKru:MGyCRD9Sj2YlCAO9igdsmtdhhzfUDnFGFUY56mwfY4s', '2023-09-05 06:27:58.837079'),
('rko8472idhp1shr3p7hnvvb2w0bs657d', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qYMHo:BiFg-Wdl8fdpEqqZQHLypg9j-WzU46xWXbwMLPE5wjk', '2023-09-05 07:58:48.312967'),
('u0o0rxnrkb1i9pw07vzx88frfj8299gk', '.eJxVjMEOwiAQRP-FsyGrUAoevfcbyC67SNXQpLQn47_bJj3oaZJ5b-atIq5LiWuTOY6srsqr029HmJ5Sd8APrPdJp6ku80h6V_RBmx4mltftcP8OCrayrV1PAYECeE8IvbFy8TmDhWSEBclt2UkwNqGw6dilnMNZMkAmIE7q8wX-0zlO:1qZvIS:NRl7xg14mFhHXqsD0WstNAE_beF3y-71Dlgkkb7P8qw', '2023-09-09 15:33:56.232988'),
('v0zhat8zizh0kwrk2baurtjv4c30r8xq', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qWdPn:_ROk65PXB9ZtbwFByrl_Lc_WvU_o30supc-oS-2ExFM', '2023-08-31 13:51:55.993862'),
('w87egszf74wze8jmo4ialh1dkt5afjuf', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qWBUP:NEyvUapNqPgKYCfID3wlC2ELlFR1aDCRHwcAHY3J0J8', '2023-08-30 08:02:49.998344'),
('wh3izvyu4pv5m78hh58xpcae5r7nrhx5', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qWAMh:LilSTWC-1HfUHOu-SQYD56x7qBs66Z9B3iECVnBdjbU', '2023-08-30 06:50:47.274019'),
('wjm1a7uz22mjgyxwvrjg4m7h3dxtgg1l', '.eJxVjEsOAiEQBe_C2hBokI9L93MGQneDjJohmc_KeHedZBa6fVX1XiLlbW1pW8qcRhYXAeL0u2GmR5l2wPc83bqkPq3ziHJX5EEXOXQuz-vh_h20vLRvHWIlxqitRqjaWuMdQwjVm-qQQBly56x9UICkAnhPUCOU4JAVMUTx_gDUhDd7:1qaTVD:2FLC6IE_YewkOl7PNLBAebl4ei9WO7cxyqAvMVer7Kg', '2023-09-11 04:05:23.767058'),
('zn75rh8wldphcdp0xhlttb1qlys6l2es', '.eJxVjMsOwiAQRf-FtSHlUR4u3fsNZAYGqRpISrsy_ruSdKHbc869LxZg30rYO61hSezMDDv9MoT4oDpEukO9NR5b3dYF-Uj4YTu_tkTPy9H-HRTo5btWTiXt5CwSGdAAXiFO1mTIOPlssvaEqCJKKQd3xoIlD5iFUXomwd4f8jE4NQ:1qWabk:VWDT39Bw8R1xcb55CpShcoOtahL-hHzo7LezI98Rfss', '2023-08-31 10:52:04.467311'),
('zsah2i7lj2nm0r2w5ih9y1kksb9uhfbn', '.eJxVjL0OwjAQg98lM4ouv2oY2XmG6HK5kgJKpaadKt6dVOoA8mR_tncRcVtL3BovccriKoy4_GYJ6cX1APmJ9TFLmuu6TEkeFXnSJu9z5vft7P4dFGylr50h7z1DhoBGuTwaHsDpEXnoAmMRg6ZOSJEG6LanaFUKZJlVEJ8v3rI35w:1qWdRD:lok6_5LyJpu7HuHgSWriYp3H4VycbcMZlZftZNedjIM', '2023-08-31 13:53:23.083467');

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE `users_roles` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`id`, `name`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `users_user`
--

CREATE TABLE `users_user` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `roles_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_user`
--

INSERT INTO `users_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `roles_id`) VALUES
(1, 'pbkdf2_sha256$390000$kTarJiKDPYGLm90kRL6gqq$FPxcQqmCN9bcT4vu+GbJGZcmct8gyZoAQbe1tAAriVM=', '2023-08-22 06:27:58.793525', 0, 'ajays.softprodigy@gmail.com', 'ajay', 'sihag', '', 0, 1, '2023-08-14 09:41:54.413198', 2),
(2, 'pbkdf2_sha256$390000$g2nNIARB67P3zQOxF8hwFS$1JjlQc5mEiBp3iMpdZ91CbERd/t/OcFJWamuKdhmICI=', '2023-11-22 05:29:33.905378', 0, 'ajaysihag.00@gmail.com', 'Ajay', 'sihag', '', 0, 1, '2023-08-14 09:46:02.897368', 2),
(3, 'pbkdf2_sha256$390000$g6Mp376wlA86dVEE9KqhZq$Gf83JGI4ckvM0FMkvvBUwa4pOqWSjo9k5b9+6M+somg=', '2023-08-28 04:54:18.205962', 1, 'riteshp.softprodigy@gmail.com', 'Ritesh', 'Raj', '', 1, 1, '2023-08-14 09:47:47.848186', 1),
(4, 'root', NULL, 1, 'root@gmail.com', '', '', '', 1, 1, '0000-00-00 00:00:00.000000', 2),
(6, 'pbkdf2_sha256$390000$fshQ705yPrI7DRL3EwwvU8$finwO3gIThoUTbkhTtmLzw0rRMwb7YNTYvBKVXUh80o=', '2023-08-17 10:50:41.526053', 0, 'triumpco@yopmail.com', 'Triumpco', 'Sharma', '', 0, 1, '2023-08-17 10:15:23.238623', 2),
(7, 'pbkdf2_sha256$390000$tJFyHzK7kqok3I40a3hrlf$xJ/tzv01zOQJryiXWi586uSTlMNvHsXFbqGlL9DXxMY=', '2023-08-23 05:41:32.616093', 0, 'sarthak@yopmail.com', 'sarthak', 'shrivastav', '', 0, 1, '2023-08-23 05:40:35.965079', 2),
(8, 'pbkdf2_sha256$390000$5A8AgABVd38EkcYBTdrO1e$RapB2Mnbx0V8qwp8DanRaoekDC8l6XbCX73xxvN7doU=', '2023-08-26 15:33:56.217044', 0, 'garghimanshu372@gmail.com', 'Himanshu', 'Aggarwal', '', 0, 1, '2023-08-26 15:29:17.620182', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users_userprofile`
--

CREATE TABLE `users_userprofile` (
  `id` bigint(20) NOT NULL,
  `profession` varchar(255) DEFAULT NULL,
  `profilePic` varchar(100) DEFAULT NULL,
  `verification_code` varchar(100) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `about` varchar(555) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` longtext,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_userprofile`
--

INSERT INTO `users_userprofile` (`id`, `profession`, `profilePic`, `verification_code`, `phone`, `about`, `address`, `city`, `state`, `zip`, `user_id`) VALUES
(1, 'student', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(2, 'Software Engineer', 'static/profilepic/levi_white_jean.jpg', NULL, 8965874123, 'None', 'haryana bhiwani', 'bhiwani', 'Haryana', '127028', 2),
(3, 'Software Engineer', 'static/profilepic/profile_t6NgEmD.jpeg', NULL, 9876543210, 'I could talk food all day.', 'phullanwal', 'Ludhiana', 'punjab', '141013', 3),
(4, 'Intern', 'static/profilepic/File_17.jpg', NULL, 9874563258, 'None', 'None', 'None', 'None', '', 6),
(5, 'Intern', 'static/profilepic/default_profile.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7),
(6, '.', 'static/profilepic/default_profile.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8);

-- --------------------------------------------------------

--
-- Table structure for table `users_user_groups`
--

CREATE TABLE `users_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users_user_user_permissions`
--

CREATE TABLE `users_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adminuser_category`
--
ALTER TABLE `adminuser_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `adminuser_comments`
--
ALTER TABLE `adminuser_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_comments_recipe_id_cae225f4_fk_adminuser_recipe_id` (`recipe_id`),
  ADD KEY `adminuser_comments_user_id_5c4b672a_fk_users_user_id` (`user_id`);

--
-- Indexes for table `adminuser_commentsdislike`
--
ALTER TABLE `adminuser_commentsdislike`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_commentsdi_comments_id_ce203f45_fk_adminuser` (`comments_id`),
  ADD KEY `adminuser_commentsdislike_user_id_aeaaced5_fk_users_user_id` (`user_id`);

--
-- Indexes for table `adminuser_commentslike`
--
ALTER TABLE `adminuser_commentslike`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_commentsli_comments_id_15c2ef33_fk_adminuser` (`comments_id`),
  ADD KEY `adminuser_commentslike_user_id_0dafb9c4_fk_users_user_id` (`user_id`);

--
-- Indexes for table `adminuser_favourites`
--
ALTER TABLE `adminuser_favourites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_favourites_recipe_id_aa27feee_fk_adminuser_recipe_id` (`recipe_id`),
  ADD KEY `adminuser_favourites_user_id_9326fdd4_fk_users_user_id` (`user_id`);

--
-- Indexes for table `adminuser_ingredient`
--
ALTER TABLE `adminuser_ingredient`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `adminuser_payments`
--
ALTER TABLE `adminuser_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_payments_user_id_e90831e9_fk_users_user_id` (`user_id`);

--
-- Indexes for table `adminuser_rating`
--
ALTER TABLE `adminuser_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_rating_recipe_id_95ee792a_fk_adminuser_recipe_id` (`recipe_id`),
  ADD KEY `adminuser_rating_user_id_27d7a225_fk_users_user_id` (`user_id`);

--
-- Indexes for table `adminuser_recipe`
--
ALTER TABLE `adminuser_recipe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_recipe_category_id_6808c761_fk_adminuser_category_id` (`category_id`),
  ADD KEY `adminuser_recipe_user_id_cdba12c9_fk_users_user_id` (`user_id`);

--
-- Indexes for table `adminuser_recipe_ingredient`
--
ALTER TABLE `adminuser_recipe_ingredient`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_recipe_ing_ingredient_id_41d831d4_fk_adminuser` (`ingredient_id`),
  ADD KEY `adminuser_recipe_ing_recipe_id_a50417f9_fk_adminuser` (`recipe_id`);

--
-- Indexes for table `adminuser_reports`
--
ALTER TABLE `adminuser_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_reports_recipe_id_db7c1d0d_fk_adminuser_recipe_id` (`recipe_id`),
  ADD KEY `adminuser_reports_user_id_07d559de_fk_users_user_id` (`user_id`);

--
-- Indexes for table `adminuser_request`
--
ALTER TABLE `adminuser_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminuser_request_user_id_4eb43230_fk_users_user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_users_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_user`
--
ALTER TABLE `users_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `users_user_roles_id_e0e6a902_fk_users_roles_id` (`roles_id`);

--
-- Indexes for table `users_userprofile`
--
ALTER TABLE `users_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `users_user_groups`
--
ALTER TABLE `users_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_user_groups_user_id_group_id_b88eab82_uniq` (`user_id`,`group_id`),
  ADD KEY `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `users_user_user_permissions`
--
ALTER TABLE `users_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_user_user_permissions_user_id_permission_id_43338c45_uniq` (`user_id`,`permission_id`),
  ADD KEY `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` (`permission_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adminuser_category`
--
ALTER TABLE `adminuser_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `adminuser_comments`
--
ALTER TABLE `adminuser_comments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `adminuser_commentsdislike`
--
ALTER TABLE `adminuser_commentsdislike`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `adminuser_commentslike`
--
ALTER TABLE `adminuser_commentslike`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `adminuser_favourites`
--
ALTER TABLE `adminuser_favourites`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `adminuser_ingredient`
--
ALTER TABLE `adminuser_ingredient`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=588;
--
-- AUTO_INCREMENT for table `adminuser_payments`
--
ALTER TABLE `adminuser_payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `adminuser_rating`
--
ALTER TABLE `adminuser_rating`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `adminuser_recipe`
--
ALTER TABLE `adminuser_recipe`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;
--
-- AUTO_INCREMENT for table `adminuser_recipe_ingredient`
--
ALTER TABLE `adminuser_recipe_ingredient`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1046;
--
-- AUTO_INCREMENT for table `adminuser_reports`
--
ALTER TABLE `adminuser_reports`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `adminuser_request`
--
ALTER TABLE `adminuser_request`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;
--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `users_roles`
--
ALTER TABLE `users_roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users_user`
--
ALTER TABLE `users_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `users_userprofile`
--
ALTER TABLE `users_userprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `users_user_groups`
--
ALTER TABLE `users_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users_user_user_permissions`
--
ALTER TABLE `users_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `adminuser_comments`
--
ALTER TABLE `adminuser_comments`
  ADD CONSTRAINT `adminuser_comments_recipe_id_cae225f4_fk_adminuser_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `adminuser_recipe` (`id`),
  ADD CONSTRAINT `adminuser_comments_user_id_5c4b672a_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `adminuser_commentsdislike`
--
ALTER TABLE `adminuser_commentsdislike`
  ADD CONSTRAINT `adminuser_commentsdi_comments_id_ce203f45_fk_adminuser` FOREIGN KEY (`comments_id`) REFERENCES `adminuser_comments` (`id`),
  ADD CONSTRAINT `adminuser_commentsdislike_user_id_aeaaced5_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `adminuser_commentslike`
--
ALTER TABLE `adminuser_commentslike`
  ADD CONSTRAINT `adminuser_commentsli_comments_id_15c2ef33_fk_adminuser` FOREIGN KEY (`comments_id`) REFERENCES `adminuser_comments` (`id`),
  ADD CONSTRAINT `adminuser_commentslike_user_id_0dafb9c4_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `adminuser_favourites`
--
ALTER TABLE `adminuser_favourites`
  ADD CONSTRAINT `adminuser_favourites_recipe_id_aa27feee_fk_adminuser_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `adminuser_recipe` (`id`),
  ADD CONSTRAINT `adminuser_favourites_user_id_9326fdd4_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `adminuser_payments`
--
ALTER TABLE `adminuser_payments`
  ADD CONSTRAINT `adminuser_payments_user_id_e90831e9_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `adminuser_rating`
--
ALTER TABLE `adminuser_rating`
  ADD CONSTRAINT `adminuser_rating_recipe_id_95ee792a_fk_adminuser_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `adminuser_recipe` (`id`),
  ADD CONSTRAINT `adminuser_rating_user_id_27d7a225_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `adminuser_recipe`
--
ALTER TABLE `adminuser_recipe`
  ADD CONSTRAINT `adminuser_recipe_category_id_6808c761_fk_adminuser_category_id` FOREIGN KEY (`category_id`) REFERENCES `adminuser_category` (`id`),
  ADD CONSTRAINT `adminuser_recipe_user_id_cdba12c9_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `adminuser_recipe_ingredient`
--
ALTER TABLE `adminuser_recipe_ingredient`
  ADD CONSTRAINT `adminuser_recipe_ing_ingredient_id_41d831d4_fk_adminuser` FOREIGN KEY (`ingredient_id`) REFERENCES `adminuser_ingredient` (`id`),
  ADD CONSTRAINT `adminuser_recipe_ing_recipe_id_a50417f9_fk_adminuser` FOREIGN KEY (`recipe_id`) REFERENCES `adminuser_recipe` (`id`);

--
-- Constraints for table `adminuser_reports`
--
ALTER TABLE `adminuser_reports`
  ADD CONSTRAINT `adminuser_reports_recipe_id_db7c1d0d_fk_adminuser_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `adminuser_recipe` (`id`),
  ADD CONSTRAINT `adminuser_reports_user_id_07d559de_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `adminuser_request`
--
ALTER TABLE `adminuser_request`
  ADD CONSTRAINT `adminuser_request_user_id_4eb43230_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `users_user`
--
ALTER TABLE `users_user`
  ADD CONSTRAINT `users_user_roles_id_e0e6a902_fk_users_roles_id` FOREIGN KEY (`roles_id`) REFERENCES `users_roles` (`id`);

--
-- Constraints for table `users_userprofile`
--
ALTER TABLE `users_userprofile`
  ADD CONSTRAINT `users_userprofile_user_id_87251ef1_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `users_user_groups`
--
ALTER TABLE `users_user_groups`
  ADD CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

--
-- Constraints for table `users_user_user_permissions`
--
ALTER TABLE `users_user_user_permissions`
  ADD CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `users_user_user_permissions_user_id_20aca447_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
