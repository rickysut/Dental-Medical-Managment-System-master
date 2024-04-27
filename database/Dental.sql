/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : Dental

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 27/04/2024 20:41:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounting_equations
-- ----------------------------
DROP TABLE IF EXISTS `accounting_equations`;
CREATE TABLE `accounting_equations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_by` int NOT NULL,
  `active_tab` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
  `_who_added` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accounting_equations__who_added_foreign` (`_who_added`),
  CONSTRAINT `accounting_equations__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of accounting_equations
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for allergies
-- ----------------------------
DROP TABLE IF EXISTS `allergies`;
CREATE TABLE `allergies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `drug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body_reaction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `patient_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `allergies_patient_id_foreign` (`patient_id`),
  KEY `allergies__who_added_foreign` (`_who_added`),
  CONSTRAINT `allergies__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `allergies_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of allergies
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for appointment_histories
-- ----------------------------
DROP TABLE IF EXISTS `appointment_histories`;
CREATE TABLE `appointment_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Created','Rescheduled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Created',
  `message` longtext COLLATE utf8mb4_unicode_ci,
  `appointment_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointment_histories_appointment_id_foreign` (`appointment_id`),
  CONSTRAINT `appointment_histories_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of appointment_histories
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for appointments
-- ----------------------------
DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `appointment_no` bigint DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci,
  `status` enum('Waiting','Treatment Complete','Treatment Incomplete','Rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Waiting',
  `visit_information` enum('Single Treatment','Review Treatment') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `doctor_id` bigint unsigned DEFAULT NULL,
  `patient_id` bigint unsigned NOT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appointments_appointment_no_unique` (`appointment_no`),
  KEY `appointments_doctor_id_foreign` (`doctor_id`),
  KEY `appointments_patient_id_foreign` (`patient_id`),
  KEY `appointments__who_added_foreign` (`_who_added`),
  KEY `appointments_branch_id_foreign` (`branch_id`),
  CONSTRAINT `appointments__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `appointments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  CONSTRAINT `appointments_doctor_id_foreign` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`id`),
  CONSTRAINT `appointments_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of appointments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for audits
-- ----------------------------
DROP TABLE IF EXISTS `audits`;
CREATE TABLE `audits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `event` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_id` bigint unsigned NOT NULL,
  `old_values` text COLLATE utf8mb4_unicode_ci,
  `new_values` text COLLATE utf8mb4_unicode_ci,
  `url` text COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(1023) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audits_auditable_type_auditable_id_index` (`auditable_type`,`auditable_id`),
  KEY `audits_user_id_user_type_index` (`user_id`,`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of audits
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for billing_email_notifications
-- ----------------------------
DROP TABLE IF EXISTS `billing_email_notifications`;
CREATE TABLE `billing_email_notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message` longtext COLLATE utf8mb4_unicode_ci,
  `item_id` double DEFAULT NULL,
  `notification_type` enum('Invoice','Quotation','Self Account') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('sent','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sent',
  `_who_added` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_email_notifications__who_added_foreign` (`_who_added`),
  CONSTRAINT `billing_email_notifications__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of billing_email_notifications
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for birth_day_messages
-- ----------------------------
DROP TABLE IF EXISTS `birth_day_messages`;
CREATE TABLE `birth_day_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message` longtext COLLATE utf8mb4_unicode_ci,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `birth_day_messages__who_added_foreign` (`_who_added`),
  CONSTRAINT `birth_day_messages__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of birth_day_messages
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for book_appointments
-- ----------------------------
DROP TABLE IF EXISTS `book_appointments`;
CREATE TABLE `book_appointments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of book_appointments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for branches
-- ----------------------------
DROP TABLE IF EXISTS `branches`;
CREATE TABLE `branches` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` enum('true','false') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'true',
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `branches_name_unique` (`name`),
  KEY `branches__who_added_foreign` (`_who_added`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of branches
-- ----------------------------
BEGIN;
INSERT INTO `branches` (`id`, `name`, `is_active`, `_who_added`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, 'HO', 'true', 1, '2024-04-27 20:23:24', '2024-04-27 20:23:26', NULL);
COMMIT;

-- ----------------------------
-- Table structure for chart_of_account_categories
-- ----------------------------
DROP TABLE IF EXISTS `chart_of_account_categories`;
CREATE TABLE `chart_of_account_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `accounting_equation_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chart_of_account_categories_accounting_equation_id_foreign` (`accounting_equation_id`),
  KEY `chart_of_account_categories__who_added_foreign` (`_who_added`),
  CONSTRAINT `chart_of_account_categories__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `chart_of_account_categories_accounting_equation_id_foreign` FOREIGN KEY (`accounting_equation_id`) REFERENCES `accounting_equations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of chart_of_account_categories
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chart_of_account_items
-- ----------------------------
DROP TABLE IF EXISTS `chart_of_account_items`;
CREATE TABLE `chart_of_account_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `chart_of_account_category_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chart_of_account_items_chart_of_account_category_id_foreign` (`chart_of_account_category_id`),
  KEY `chart_of_account_items__who_added_foreign` (`_who_added`),
  CONSTRAINT `chart_of_account_items__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `chart_of_account_items_chart_of_account_category_id_foreign` FOREIGN KEY (`chart_of_account_category_id`) REFERENCES `chart_of_account_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of chart_of_account_items
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chronic_diseases
-- ----------------------------
DROP TABLE IF EXISTS `chronic_diseases`;
CREATE TABLE `chronic_diseases` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `disease` longtext COLLATE utf8mb4_unicode_ci,
  `status` enum('Active','Treated') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `patient_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chronic_diseases_patient_id_foreign` (`patient_id`),
  KEY `chronic_diseases__who_added_foreign` (`_who_added`),
  CONSTRAINT `chronic_diseases__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `chronic_diseases_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of chronic_diseases
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for claim_rates
-- ----------------------------
DROP TABLE IF EXISTS `claim_rates`;
CREATE TABLE `claim_rates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cash_rate` double NOT NULL,
  `insurance_rate` double NOT NULL,
  `status` enum('active','deactivated') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `doctor_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `claim_rates_doctor_id_foreign` (`doctor_id`),
  KEY `claim_rates__who_added_foreign` (`_who_added`),
  CONSTRAINT `claim_rates__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `claim_rates_doctor_id_foreign` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of claim_rates
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for dental_charts
-- ----------------------------
DROP TABLE IF EXISTS `dental_charts`;
CREATE TABLE `dental_charts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `treatment` enum('Fracture','Restoration','Extraction') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tooth` double DEFAULT NULL,
  `section` double DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appointment_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dental_charts_appointment_id_foreign` (`appointment_id`),
  KEY `dental_charts__who_added_foreign` (`_who_added`),
  CONSTRAINT `dental_charts__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `dental_charts_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of dental_charts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for doctor_claim_payments
-- ----------------------------
DROP TABLE IF EXISTS `doctor_claim_payments`;
CREATE TABLE `doctor_claim_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `payment_date` date NOT NULL,
  `doctor_claim_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_claim_payments_doctor_claim_id_foreign` (`doctor_claim_id`),
  KEY `doctor_claim_payments__who_added_foreign` (`_who_added`),
  CONSTRAINT `doctor_claim_payments__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `doctor_claim_payments_doctor_claim_id_foreign` FOREIGN KEY (`doctor_claim_id`) REFERENCES `doctor_claims` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of doctor_claim_payments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for doctor_claims
-- ----------------------------
DROP TABLE IF EXISTS `doctor_claims`;
CREATE TABLE `doctor_claims` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `claim_amount` double NOT NULL,
  `insurance_amount` double NOT NULL DEFAULT '0',
  `cash_amount` double NOT NULL DEFAULT '0',
  `status` enum('Pending','Approved') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `claim_rate_id` bigint unsigned NOT NULL,
  `appointment_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_claims_claim_rate_id_foreign` (`claim_rate_id`),
  KEY `doctor_claims_appointment_id_foreign` (`appointment_id`),
  KEY `doctor_claims__who_added_foreign` (`_who_added`),
  KEY `doctor_claims_approved_by_foreign` (`approved_by`),
  CONSTRAINT `doctor_claims__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `doctor_claims_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`),
  CONSTRAINT `doctor_claims_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  CONSTRAINT `doctor_claims_claim_rate_id_foreign` FOREIGN KEY (`claim_rate_id`) REFERENCES `claim_rates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of doctor_claims
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for employee_contracts
-- ----------------------------
DROP TABLE IF EXISTS `employee_contracts`;
CREATE TABLE `employee_contracts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `years` int NOT NULL,
  `basic_salary` double NOT NULL,
  `employee_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `status` enum('Active','Expired') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_contracts_employee_id_foreign` (`employee_id`),
  KEY `employee_contracts__who_added_foreign` (`_who_added`),
  CONSTRAINT `employee_contracts__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `employee_contracts_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of employee_contracts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for expense_categories
-- ----------------------------
DROP TABLE IF EXISTS `expense_categories`;
CREATE TABLE `expense_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chart_of_account_item_id` bigint unsigned DEFAULT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expense_categories__who_added_foreign` (`_who_added`),
  KEY `expense_categories_chart_of_account_item_id_foreign` (`chart_of_account_item_id`),
  CONSTRAINT `expense_categories__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `expense_categories_chart_of_account_item_id_foreign` FOREIGN KEY (`chart_of_account_item_id`) REFERENCES `chart_of_account_items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of expense_categories
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for expense_items
-- ----------------------------
DROP TABLE IF EXISTS `expense_items`;
CREATE TABLE `expense_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expense_category_id` bigint unsigned DEFAULT NULL,
  `qty` double NOT NULL,
  `price` double NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expense_items__who_added_foreign` (`_who_added`),
  KEY `expense_items_expense_category_id_foreign` (`expense_category_id`),
  CONSTRAINT `expense_items__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `expense_items_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of expense_items
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for expense_payments
-- ----------------------------
DROP TABLE IF EXISTS `expense_payments`;
CREATE TABLE `expense_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_date` date NOT NULL,
  `amount` double NOT NULL,
  `payment_method` enum('Cash','Mobile Money','Cheque','Online Wallet') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_account_id` bigint unsigned DEFAULT NULL,
  `expense_id` bigint unsigned DEFAULT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expense_payments_expense_id_foreign` (`expense_id`),
  KEY `expense_payments__who_added_foreign` (`_who_added`),
  KEY `expense_payments_payment_account_id_foreign` (`payment_account_id`),
  CONSTRAINT `expense_payments__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `expense_payments_expense_id_foreign` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`),
  CONSTRAINT `expense_payments_payment_account_id_foreign` FOREIGN KEY (`payment_account_id`) REFERENCES `chart_of_account_items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of expense_payments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for expenses
-- ----------------------------
DROP TABLE IF EXISTS `expenses`;
CREATE TABLE `expenses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `purchase_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_id` bigint unsigned DEFAULT NULL,
  `supplier` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_date` date NOT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses__who_added_foreign` (`_who_added`),
  KEY `expenses_supplier_id_foreign` (`supplier_id`),
  KEY `expenses_branch_id_foreign` (`branch_id`),
  CONSTRAINT `expenses__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `expenses_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  CONSTRAINT `expenses_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of expenses
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for holidays
-- ----------------------------
DROP TABLE IF EXISTS `holidays`;
CREATE TABLE `holidays` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `holiday_date` date DEFAULT NULL,
  `repeat_date` enum('Yes','No') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `holidays_name_unique` (`name`),
  KEY `holidays__who_added_foreign` (`_who_added`),
  CONSTRAINT `holidays__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of holidays
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for insurance_companies
-- ----------------------------
DROP TABLE IF EXISTS `insurance_companies`;
CREATE TABLE `insurance_companies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `insurance_companies__who_added_foreign` (`_who_added`),
  CONSTRAINT `insurance_companies__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of insurance_companies
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for invoice_items
-- ----------------------------
DROP TABLE IF EXISTS `invoice_items`;
CREATE TABLE `invoice_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `qty` double DEFAULT NULL,
  `amount` double NOT NULL,
  `invoice_id` bigint unsigned NOT NULL,
  `medical_service_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `tooth_no` int unsigned NOT NULL,
  `doctor_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_items_invoice_id_foreign` (`invoice_id`),
  KEY `invoice_items_medical_service_id_foreign` (`medical_service_id`),
  KEY `invoice_items__who_added_foreign` (`_who_added`),
  KEY `invoice_items_doctor_id_foreign` (`doctor_id`),
  CONSTRAINT `invoice_items__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `invoice_items_doctor_id_foreign` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`id`),
  CONSTRAINT `invoice_items_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `invoice_items_medical_service_id_foreign` FOREIGN KEY (`medical_service_id`) REFERENCES `medical_services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of invoice_items
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for invoice_payments
-- ----------------------------
DROP TABLE IF EXISTS `invoice_payments`;
CREATE TABLE `invoice_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_method` enum('Cash','Online Wallet','Insurance','Mobile Money','Cheque') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'if the client make a payment with a cheque',
  `account_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'cheque account holder',
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name of the bank ',
  `invoice_id` bigint unsigned NOT NULL,
  `insurance_company_id` bigint unsigned DEFAULT NULL,
  `self_account_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_payments_invoice_id_foreign` (`invoice_id`),
  KEY `invoice_payments_insurance_company_id_foreign` (`insurance_company_id`),
  KEY `invoice_payments__who_added_foreign` (`_who_added`),
  KEY `invoice_payments_branch_id_foreign` (`branch_id`),
  CONSTRAINT `invoice_payments__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `invoice_payments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  CONSTRAINT `invoice_payments_insurance_company_id_foreign` FOREIGN KEY (`insurance_company_id`) REFERENCES `insurance_companies` (`id`),
  CONSTRAINT `invoice_payments_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of invoice_payments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for invoices
-- ----------------------------
DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('unpaid','paid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `appointment_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoices_appointment_id_foreign` (`appointment_id`),
  KEY `invoices__who_added_foreign` (`_who_added`),
  CONSTRAINT `invoices__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `invoices_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of invoices
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for leave_requests
-- ----------------------------
DROP TABLE IF EXISTS `leave_requests`;
CREATE TABLE `leave_requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `start_date` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` double DEFAULT NULL,
  `status` enum('Pending Approval','Rejected','Approved') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending Approval',
  `action_date` date DEFAULT NULL,
  `leave_type_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `_approved_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `leave_requests_start_date_unique` (`start_date`),
  KEY `leave_requests_leave_type_id_foreign` (`leave_type_id`),
  KEY `leave_requests__who_added_foreign` (`_who_added`),
  KEY `leave_requests__approved_by_foreign` (`_approved_by`),
  CONSTRAINT `leave_requests__approved_by_foreign` FOREIGN KEY (`_approved_by`) REFERENCES `users` (`id`),
  CONSTRAINT `leave_requests__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `leave_requests_leave_type_id_foreign` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of leave_requests
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for leave_types
-- ----------------------------
DROP TABLE IF EXISTS `leave_types`;
CREATE TABLE `leave_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_days` double DEFAULT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `leave_types_name_unique` (`name`),
  KEY `leave_types__who_added_foreign` (`_who_added`),
  CONSTRAINT `leave_types__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of leave_types
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for medical_card_items
-- ----------------------------
DROP TABLE IF EXISTS `medical_card_items`;
CREATE TABLE `medical_card_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `card_photo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `medical_card_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medical_card_items_medical_card_id_foreign` (`medical_card_id`),
  KEY `medical_card_items__who_added_foreign` (`_who_added`),
  CONSTRAINT `medical_card_items__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `medical_card_items_medical_card_id_foreign` FOREIGN KEY (`medical_card_id`) REFERENCES `medical_cards` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of medical_card_items
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for medical_cards
-- ----------------------------
DROP TABLE IF EXISTS `medical_cards`;
CREATE TABLE `medical_cards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `card_type` enum('X-ray','Medical Card') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `patient_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medical_cards_patient_id_foreign` (`patient_id`),
  KEY `medical_cards__who_added_foreign` (`_who_added`),
  CONSTRAINT `medical_cards__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `medical_cards_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of medical_cards
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for medical_services
-- ----------------------------
DROP TABLE IF EXISTS `medical_services`;
CREATE TABLE `medical_services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medical_services__who_added_foreign` (`_who_added`),
  CONSTRAINT `medical_services__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of medical_services
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (3, '2019_02_25_231036_create_scheduled_notifications_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (4, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (5, '2019_10_27_160606_create_roles_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (6, '2019_10_27_161946_add_role_to_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (7, '2019_10_28_122703_create_insurance_companies_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (8, '2019_10_28_125700_create_patients_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (9, '2019_10_28_154258_create_appointments_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (10, '2019_10_28_225131_create_surgeries_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (11, '2019_10_29_151556_create_chronic_diseases_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (12, '2019_10_29_164438_create_allergies_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (13, '2019_10_29_174820_create_medical_services_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (14, '2019_10_29_200205_create_invoices_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (16, '2019_10_29_201840_create_invoice_payments_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (17, '2019_10_29_231003_create_treatments_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (18, '2019_10_30_081126_create_prescriptions_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (19, '2019_11_03_193738_create_expense_categories_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (21, '2019_11_04_183522_create_medical_cards_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (22, '2019_11_10_220556_create_expenses_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (23, '2019_11_10_223628_add_expense_id_to_expense_items_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (24, '2019_11_10_224334_create_expense_payments_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (25, '2019_11_21_113401_create_medical_card_items_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (26, '2019_11_23_221029_create_dental_charts_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (27, '2019_12_17_095011_create_claim_rates_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (28, '2019_12_17_121104_create_doctor_claims_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (29, '2019_12_17_161804_create_doctor_claim_payments_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (30, '2020_01_19_113535_create_suppliers_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (31, '2020_01_19_113852_add_supplier_to_expenses_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (32, '2020_01_28_110739_create_employee_contracts_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (33, '2020_01_28_184750_create_salary_advances_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (34, '2020_01_28_201940_create_salary_allowances_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (35, '2020_01_28_202557_create_salary_deductions_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (36, '2020_01_28_205515_create_pay_slips_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (37, '2020_01_28_210116_add_payslip_id_to_salary_allowances_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (38, '2020_01_28_210313_add_payslip_id_to_salary_deductions_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (39, '2020_02_07_024909_create_self_accounts_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (40, '2020_02_20_093141_create_self_account_deposits_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (41, '2020_03_06_113320_add_self_account_id_to_invoice_payments_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (42, '2020_06_04_125051_create_branches_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (43, '2020_06_06_142909_add_branch_id_to_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (44, '2020_06_07_162118_create_book_appointments_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (45, '2020_06_08_100328_add_branch_id_to_appointments_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (46, '2020_06_12_215547_add_branch_id_to_invoice_payments_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (47, '2020_06_13_215639_add_branch_id_to_expenses_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (48, '2019_11_03_193906_create_expense_items_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (49, '2020_06_13_224629_add_expense_category_id_to_expense_items_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (50, '2020_06_17_222311_create_holidays_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (51, '2020_06_17_225134_create_leave_types_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (52, '2020_06_17_232540_create_leave_requests_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (53, '2020_06_25_124514_create_audits_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (54, '2020_06_26_120412_create_quotations_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (55, '2020_06_26_120622_create_quotation_items_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (56, '2020_06_26_231318_create_appointment_histories_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (57, '2020_06_27_140310_create_sms_loggings_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (58, '2020_06_27_140804_create_sms_transactions_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (59, '2020_06_27_211826_create_jobs_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (60, '2020_06_28_085044_create_accounting_equations_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (61, '2020_06_28_085852_create_chart_of_account_categories_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (62, '2020_06_28_090713_create_chart_of_account_items_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (63, '2020_07_04_134159_create_online_bookings_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (64, '2020_07_08_180946_add_chart_of_account_id_to_expense_categories_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (65, '2020_07_09_202024_add_chart_of_account_item_id_to_expense_payments_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (66, '2020_07_19_130108_create_birth_day_messages_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (67, '2020_07_22_155001_create_notifications_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (68, '2019_10_29_201456_create_invoice_items_table', 4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (69, '2020_08_02_195018_add_changes_to_invoice_items_table', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (70, '2020_08_02_213753_add_changes_to_quotation_items_table', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (71, '2020_10_02_012823_create_billing_email_notifications_table', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (72, '2021_09_10_130000_add_meta_to_scheduled_notifications', 5);
COMMIT;

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of notifications
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for online_bookings
-- ----------------------------
DROP TABLE IF EXISTS `online_bookings`;
CREATE TABLE `online_bookings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci,
  `visit_history` enum('Yes','No') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `status` enum('Accepted','Rejected','Waiting') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Waiting',
  `insurance_company_id` bigint unsigned DEFAULT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  `sort_by` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `online_bookings_insurance_company_id_foreign` (`insurance_company_id`),
  KEY `online_bookings_branch_id_foreign` (`branch_id`),
  CONSTRAINT `online_bookings_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  CONSTRAINT `online_bookings_insurance_company_id_foreign` FOREIGN KEY (`insurance_company_id`) REFERENCES `insurance_companies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of online_bookings
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for patients
-- ----------------------------
DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `surname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `othername` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('Male','Female') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternative_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nin` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profession` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_of_kin` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_of_kin_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_of_kin_address` text COLLATE utf8mb4_unicode_ci,
  `has_insurance` enum('Yes','No') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `insurance_company_id` bigint unsigned DEFAULT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patients_insurance_company_id_foreign` (`insurance_company_id`),
  KEY `patients__who_added_foreign` (`_who_added`),
  CONSTRAINT `patients__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `patients_insurance_company_id_foreign` FOREIGN KEY (`insurance_company_id`) REFERENCES `insurance_companies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of patients
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pay_slips
-- ----------------------------
DROP TABLE IF EXISTS `pay_slips`;
CREATE TABLE `pay_slips` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payslip_month` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` bigint unsigned NOT NULL,
  `employee_contract_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pay_slips_employee_id_foreign` (`employee_id`),
  KEY `pay_slips_employee_contract_id_foreign` (`employee_contract_id`),
  KEY `pay_slips__who_added_foreign` (`_who_added`),
  CONSTRAINT `pay_slips__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `pay_slips_employee_contract_id_foreign` FOREIGN KEY (`employee_contract_id`) REFERENCES `employee_contracts` (`id`),
  CONSTRAINT `pay_slips_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of pay_slips
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for prescriptions
-- ----------------------------
DROP TABLE IF EXISTS `prescriptions`;
CREATE TABLE `prescriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `drug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `directions` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `appointment_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prescriptions_appointment_id_foreign` (`appointment_id`),
  KEY `prescriptions__who_added_foreign` (`_who_added`),
  CONSTRAINT `prescriptions__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `prescriptions_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of prescriptions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for quotation_items
-- ----------------------------
DROP TABLE IF EXISTS `quotation_items`;
CREATE TABLE `quotation_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `qty` double DEFAULT NULL,
  `amount` double NOT NULL,
  `quotation_id` bigint unsigned NOT NULL,
  `medical_service_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quotation_items_quotation_id_foreign` (`quotation_id`),
  KEY `quotation_items_medical_service_id_foreign` (`medical_service_id`),
  KEY `quotation_items__who_added_foreign` (`_who_added`),
  CONSTRAINT `quotation_items__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `quotation_items_medical_service_id_foreign` FOREIGN KEY (`medical_service_id`) REFERENCES `medical_services` (`id`),
  CONSTRAINT `quotation_items_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of quotation_items
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for quotations
-- ----------------------------
DROP TABLE IF EXISTS `quotations`;
CREATE TABLE `quotations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quotation_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `patient_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quotations_patient_id_foreign` (`patient_id`),
  KEY `quotations__who_added_foreign` (`_who_added`),
  CONSTRAINT `quotations__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `quotations_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of quotations
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 'Super Administrator', '2024-04-27 20:21:27', '2024-04-27 20:21:29', NULL);
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, 'Doctor', '2024-04-27 20:21:40', '2024-04-27 20:21:43', NULL);
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, 'Nurse', '2024-04-27 20:21:52', '2024-04-27 20:21:55', NULL);
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, 'patient', '2024-04-27 20:22:48', '2024-04-27 20:22:50', NULL);
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, 'Receptionist', '2024-04-27 20:33:13', '2024-04-27 20:33:15', NULL);
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, 'Administrator', '2024-04-27 20:33:31', '2024-04-27 20:33:33', NULL);
COMMIT;

-- ----------------------------
-- Table structure for salary_advances
-- ----------------------------
DROP TABLE IF EXISTS `salary_advances`;
CREATE TABLE `salary_advances` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_classification` enum('Salary','Advance') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `advance_amount` double NOT NULL,
  `advance_month` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_date` date NOT NULL,
  `payment_method` enum('Cash','Bank Transfer','Cheque','Mobile Money','Online Wallet') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `salary_advances_employee_id_foreign` (`employee_id`),
  KEY `salary_advances__who_added_foreign` (`_who_added`),
  CONSTRAINT `salary_advances__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `salary_advances_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of salary_advances
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for salary_allowances
-- ----------------------------
DROP TABLE IF EXISTS `salary_allowances`;
CREATE TABLE `salary_allowances` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `allowance` enum('House Rent Allowance','Medical Allowance','Bonus','Dearness Allowance','Travelling Allowance') COLLATE utf8mb4_unicode_ci NOT NULL,
  `allowance_amount` double NOT NULL,
  `pay_slip_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `salary_allowances__who_added_foreign` (`_who_added`),
  KEY `salary_allowances_pay_slip_id_foreign` (`pay_slip_id`),
  CONSTRAINT `salary_allowances__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `salary_allowances_pay_slip_id_foreign` FOREIGN KEY (`pay_slip_id`) REFERENCES `pay_slips` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of salary_allowances
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for salary_deductions
-- ----------------------------
DROP TABLE IF EXISTS `salary_deductions`;
CREATE TABLE `salary_deductions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `deduction` enum('Payee','NSSF') COLLATE utf8mb4_unicode_ci NOT NULL,
  `deduction_amount` double NOT NULL,
  `pay_slip_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `salary_deductions__who_added_foreign` (`_who_added`),
  KEY `salary_deductions_pay_slip_id_foreign` (`pay_slip_id`),
  CONSTRAINT `salary_deductions__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `salary_deductions_pay_slip_id_foreign` FOREIGN KEY (`pay_slip_id`) REFERENCES `pay_slips` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of salary_deductions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for scheduled_notifications
-- ----------------------------
DROP TABLE IF EXISTS `scheduled_notifications`;
CREATE TABLE `scheduled_notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `target_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_at` datetime NOT NULL,
  `sent_at` datetime DEFAULT NULL,
  `rescheduled_at` datetime DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `meta` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of scheduled_notifications
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for self_account_deposits
-- ----------------------------
DROP TABLE IF EXISTS `self_account_deposits`;
CREATE TABLE `self_account_deposits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `payment_method` enum('Cash','Mobile Money','Cheque') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `self_account_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `self_account_deposits_self_account_id_foreign` (`self_account_id`),
  KEY `self_account_deposits__who_added_foreign` (`_who_added`),
  CONSTRAINT `self_account_deposits__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `self_account_deposits_self_account_id_foreign` FOREIGN KEY (`self_account_id`) REFERENCES `self_accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of self_account_deposits
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for self_accounts
-- ----------------------------
DROP TABLE IF EXISTS `self_accounts`;
CREATE TABLE `self_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_holder` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `holder_phone_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holder_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holder_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` enum('true','false') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'true',
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `self_accounts_account_no_unique` (`account_no`),
  KEY `self_accounts__who_added_foreign` (`_who_added`),
  CONSTRAINT `self_accounts__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of self_accounts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sms_loggings
-- ----------------------------
DROP TABLE IF EXISTS `sms_loggings`;
CREATE TABLE `sms_loggings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `cost` double NOT NULL,
  `status` enum('success','failed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `patient_id` bigint unsigned DEFAULT NULL,
  `_who_added` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_loggings_patient_id_foreign` (`patient_id`),
  KEY `sms_loggings__who_added_foreign` (`_who_added`),
  CONSTRAINT `sms_loggings__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `sms_loggings_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of sms_loggings
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sms_transactions
-- ----------------------------
DROP TABLE IF EXISTS `sms_transactions`;
CREATE TABLE `sms_transactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `type` enum('topup','sms','airtime','mobile money') COLLATE utf8mb4_unicode_ci NOT NULL,
  `_who_added` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_transactions__who_added_foreign` (`_who_added`),
  CONSTRAINT `sms_transactions__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of sms_transactions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for suppliers
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `suppliers__who_added_foreign` (`_who_added`),
  CONSTRAINT `suppliers__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for surgeries
-- ----------------------------
DROP TABLE IF EXISTS `surgeries`;
CREATE TABLE `surgeries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `surgery` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surgery_date` date NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `patient_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `surgeries_patient_id_foreign` (`patient_id`),
  KEY `surgeries__who_added_foreign` (`_who_added`),
  CONSTRAINT `surgeries__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `surgeries_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of surgeries
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for treatments
-- ----------------------------
DROP TABLE IF EXISTS `treatments`;
CREATE TABLE `treatments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `clinical_notes` longtext COLLATE utf8mb4_unicode_ci,
  `treatment` longtext COLLATE utf8mb4_unicode_ci,
  `appointment_id` bigint unsigned NOT NULL,
  `_who_added` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `treatments_appointment_id_foreign` (`appointment_id`),
  KEY `treatments__who_added_foreign` (`_who_added`),
  CONSTRAINT `treatments__who_added_foreign` FOREIGN KEY (`_who_added`) REFERENCES `users` (`id`),
  CONSTRAINT `treatments_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of treatments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `surname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `othername` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alternative_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nin` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_seen` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `role_id` bigint unsigned NOT NULL,
  `branch_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  KEY `users_branch_id_foreign` (`branch_id`),
  CONSTRAINT `users_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `surname`, `othername`, `email`, `phone_no`, `alternative_no`, `photo`, `nin`, `email_verified_at`, `password`, `last_seen`, `remember_token`, `created_at`, `updated_at`, `deleted_at`, `role_id`, `branch_id`) VALUES (4, 'Admin', 'admin system', 'admin@admin.com', '8121062380', NULL, NULL, NULL, '2024-04-27 20:20:41', '$2y$10$5TJlYk0WgRdCKO3RuscsBeS3MQYRumQB116vnu.AXeH021ta1wX.a', '2024-04-27 20:20:49', NULL, '2024-04-27 20:20:52', '2024-04-27 16:27:47', NULL, 1, 4);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
