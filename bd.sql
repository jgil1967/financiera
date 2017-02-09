/*
 Navicat Premium Data Transfer

 Source Server         : documentacion
 Source Server Type    : PostgreSQL
 Source Server Version : 90600
 Source Host           : localhost
 Source Database       : financiera
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 90600
 File Encoding         : utf-8

 Date: 02/09/2017 08:10:18 AM
*/

-- ----------------------------
--  Sequence structure for clientAdressesRelations_id_seq
-- ----------------------------
CREATE SEQUENCE "clientAdressesRelations_id_seq" INCREMENT 1 START 1 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;

-- ----------------------------
--  Sequence structure for clientsRelationships_id_seq
-- ----------------------------
CREATE SEQUENCE "clientsRelationships_id_seq" INCREMENT 1 START 1 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;

-- ----------------------------
--  Sequence structure for duePayments_id_seq
-- ----------------------------
CREATE SEQUENCE "duePayments_id_seq" INCREMENT 1 START 1 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;

-- ----------------------------
--  Sequence structure for object_id_seq
-- ----------------------------
CREATE SEQUENCE "object_id_seq" INCREMENT 1 START 1 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;

-- ----------------------------
--  Sequence structure for phoneNumbers_id_seq
-- ----------------------------
CREATE SEQUENCE "phoneNumbers_id_seq" INCREMENT 1 START 1 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;

-- ----------------------------
--  Sequence structure for transactions_id_seq
-- ----------------------------
CREATE SEQUENCE "transactions_id_seq" INCREMENT 1 START 1 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;

-- ----------------------------
--  Table structure for kinds
-- ----------------------------
CREATE TABLE "kinds" (
	"id" int4 NOT NULL,
	"name" varchar COLLATE "default"
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for municipality
-- ----------------------------
CREATE TABLE "municipality" (
	"id" int4,
	"idFederalEntity" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for transactionObjectRelations
-- ----------------------------
CREATE TABLE "transactionObjectRelations" (
	"id" int4 NOT NULL,
	"idObject" int4,
	"idTransaction" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for object
-- ----------------------------
CREATE TABLE "object" (
	"id" int4 NOT NULL DEFAULT nextval('object_id_seq'::regclass),
	"name" varchar COLLATE "default",
	"idKind" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for federalEntity
-- ----------------------------
CREATE TABLE "federalEntity" (
	"id" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for location
-- ----------------------------
CREATE TABLE "location" (
	"id" int4,
	"idMunicipality" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for plans
-- ----------------------------
CREATE TABLE "plans" (
	"id" int4 NOT NULL,
	"numberOfDays" int4,
	"minimalInterestEarned" float8,
	"numberOfPayments" int4,
	"interestEarnedPerReferral" float8,
	"minimalInvestment" float8
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for clientsRelationships
-- ----------------------------
CREATE TABLE "clientsRelationships" (
	"id" int4 NOT NULL DEFAULT nextval('"clientsRelationships_id_seq"'::regclass),
	"idClientParent" int4 NOT NULL,
	"idClientChild" int4 NOT NULL,
	"idProgram" int4,
	"investment" float8
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for clients
-- ----------------------------
CREATE TABLE "clients" (
	"id" int4 NOT NULL,
	"lastName" varchar NOT NULL COLLATE "default",
	"idLocation" int4,
	"dateOfBirth" date
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for programs
-- ----------------------------
CREATE TABLE "programs" (
	"id" int4 NOT NULL,
	"idPlan" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for addresses
-- ----------------------------
CREATE TABLE "addresses" (
	"id" int4,
	"idSuburb" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for duePayments
-- ----------------------------
CREATE TABLE "duePayments" (
	"dueDate" date,
	"done" bool,
	"id" int4 NOT NULL DEFAULT nextval('"duePayments_id_seq"'::regclass),
	"idClient" int4,
	"idProgram" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for phoneNumbers
-- ----------------------------
CREATE TABLE "phoneNumbers" (
	"id" int4 NOT NULL DEFAULT nextval('"phoneNumbers_id_seq"'::regclass),
	"phoneNumber" int4,
	"idClient" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for transactions
-- ----------------------------
CREATE TABLE "transactions" (
	"transactionDate" timestamp(6) NULL DEFAULT now(),
	"idTransactionType" int4,
	"id" int4 NOT NULL DEFAULT nextval('transactions_id_seq'::regclass)
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for clientAdressesRelations
-- ----------------------------
CREATE TABLE "clientAdressesRelations" (
	"id" int4 NOT NULL DEFAULT nextval('"clientAdressesRelations_id_seq"'::regclass),
	"idClient" int4,
	"idAdress" int4
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Table structure for suburb
-- ----------------------------
CREATE TABLE "suburb" (
	"id" int4,
	"idLocation" int4
)
WITH (OIDS=FALSE);


-- ----------------------------
--  Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "clientAdressesRelations_id_seq" RESTART 2 OWNED BY "clientAdressesRelations"."id";
ALTER SEQUENCE "clientsRelationships_id_seq" RESTART 2 OWNED BY "clientsRelationships"."id";
ALTER SEQUENCE "duePayments_id_seq" RESTART 2 OWNED BY "duePayments"."id";
ALTER SEQUENCE "object_id_seq" RESTART 2 OWNED BY "object"."id";
ALTER SEQUENCE "phoneNumbers_id_seq" RESTART 2 OWNED BY "phoneNumbers"."id";
ALTER SEQUENCE "transactions_id_seq" RESTART 2 OWNED BY "transactions"."id";
-- ----------------------------
--  Primary key structure for table kinds
-- ----------------------------
ALTER TABLE "kinds" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table kinds
-- ----------------------------
CREATE UNIQUE INDEX  "kinds_id_key" ON "kinds" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Indexes structure for table municipality
-- ----------------------------
CREATE UNIQUE INDEX  "municipality_id_key" ON "municipality" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table transactionObjectRelations
-- ----------------------------
ALTER TABLE "transactionObjectRelations" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table object
-- ----------------------------
ALTER TABLE "object" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table object
-- ----------------------------
CREATE UNIQUE INDEX  "object_id_key" ON "object" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Indexes structure for table federalEntity
-- ----------------------------
CREATE UNIQUE INDEX  "federalEntity_id_key" ON "federalEntity" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Indexes structure for table location
-- ----------------------------
CREATE INDEX  "fk_location" ON "location" USING btree("idMunicipality" "pg_catalog"."int4_ops" ASC NULLS LAST);
CREATE UNIQUE INDEX  "location_id_key" ON "location" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table plans
-- ----------------------------
ALTER TABLE "plans" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table plans
-- ----------------------------
CREATE UNIQUE INDEX  "plans_id_key" ON "plans" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table clientsRelationships
-- ----------------------------
ALTER TABLE "clientsRelationships" ADD PRIMARY KEY ("id", "idClientParent", "idClientChild") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table clients
-- ----------------------------
ALTER TABLE "clients" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table clients
-- ----------------------------
CREATE UNIQUE INDEX  "clients_id_key" ON "clients" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table programs
-- ----------------------------
ALTER TABLE "programs" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table programs
-- ----------------------------
CREATE UNIQUE INDEX  "programs_id_key" ON "programs" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Indexes structure for table addresses
-- ----------------------------
CREATE UNIQUE INDEX  "addresses_id_key" ON "addresses" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table duePayments
-- ----------------------------
ALTER TABLE "duePayments" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table phoneNumbers
-- ----------------------------
ALTER TABLE "phoneNumbers" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table transactions
-- ----------------------------
ALTER TABLE "transactions" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Primary key structure for table clientAdressesRelations
-- ----------------------------
ALTER TABLE "clientAdressesRelations" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table suburb
-- ----------------------------
CREATE UNIQUE INDEX  "suburb_id_key" ON "suburb" USING btree("id" "pg_catalog"."int4_ops" ASC NULLS LAST);

-- ----------------------------
--  Foreign keys structure for table municipality
-- ----------------------------
ALTER TABLE "municipality" ADD CONSTRAINT "municipality_idFederalEntity_fkey" FOREIGN KEY ("idFederalEntity") REFERENCES "federalEntity" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "municipality" ADD CONSTRAINT "municipality_id_fkey" FOREIGN KEY ("id") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table transactionObjectRelations
-- ----------------------------
ALTER TABLE "transactionObjectRelations" ADD CONSTRAINT "transactionObjectRelationships_idObject_fkey" FOREIGN KEY ("idObject") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table object
-- ----------------------------
ALTER TABLE "object" ADD CONSTRAINT "object_idKind_fkey" FOREIGN KEY ("idKind") REFERENCES "kinds" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table federalEntity
-- ----------------------------
ALTER TABLE "federalEntity" ADD CONSTRAINT "federalEntity_id_fkey" FOREIGN KEY ("id") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table location
-- ----------------------------
ALTER TABLE "location" ADD CONSTRAINT "location_idMunicipality_fkey" FOREIGN KEY ("idMunicipality") REFERENCES "municipality" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "location" ADD CONSTRAINT "location_id_fkey" FOREIGN KEY ("id") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table plans
-- ----------------------------
ALTER TABLE "plans" ADD CONSTRAINT "plans_id_fkey" FOREIGN KEY ("id") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table clientsRelationships
-- ----------------------------
ALTER TABLE "clientsRelationships" ADD CONSTRAINT "clientsRelationships_idClientParent_fkey" FOREIGN KEY ("idClientParent") REFERENCES "clients" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "clientsRelationships" ADD CONSTRAINT "clientsRelationships_idClientChild_fkey" FOREIGN KEY ("idClientChild") REFERENCES "clients" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "clientsRelationships" ADD CONSTRAINT "clientsRelationships_idProgram_fkey" FOREIGN KEY ("idProgram") REFERENCES "programs" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table clients
-- ----------------------------
ALTER TABLE "clients" ADD CONSTRAINT "clients_id_fkey" FOREIGN KEY ("id") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "clients" ADD CONSTRAINT "clients_idLocation_fkey" FOREIGN KEY ("idLocation") REFERENCES "location" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table programs
-- ----------------------------
ALTER TABLE "programs" ADD CONSTRAINT "programs_id_fkey" FOREIGN KEY ("id") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "programs" ADD CONSTRAINT "programs_idPlan_fkey" FOREIGN KEY ("idPlan") REFERENCES "plans" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table addresses
-- ----------------------------
ALTER TABLE "addresses" ADD CONSTRAINT "addresses_id_fkey" FOREIGN KEY ("id") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "addresses" ADD CONSTRAINT "addresses_idSuburb_fkey" FOREIGN KEY ("idSuburb") REFERENCES "suburb" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table duePayments
-- ----------------------------
ALTER TABLE "duePayments" ADD CONSTRAINT "duePayments_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "clients" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "duePayments" ADD CONSTRAINT "duePayments_idProgram_fkey" FOREIGN KEY ("idProgram") REFERENCES "programs" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table phoneNumbers
-- ----------------------------
ALTER TABLE "phoneNumbers" ADD CONSTRAINT "phoneNumbers_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "clients" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table transactions
-- ----------------------------
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_idTransactionType_fkey" FOREIGN KEY ("idTransactionType") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table clientAdressesRelations
-- ----------------------------
ALTER TABLE "clientAdressesRelations" ADD CONSTRAINT "clientAdressesRelations_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "clients" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "clientAdressesRelations" ADD CONSTRAINT "clientAdressesRelations_idAdress_fkey" FOREIGN KEY ("idAdress") REFERENCES "addresses" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Foreign keys structure for table suburb
-- ----------------------------
ALTER TABLE "suburb" ADD CONSTRAINT "suburb_id_fkey" FOREIGN KEY ("id") REFERENCES "object" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "suburb" ADD CONSTRAINT "suburb_idLocation_fkey" FOREIGN KEY ("idLocation") REFERENCES "location" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

