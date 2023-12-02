BEGIN;


CREATE TABLE IF NOT EXISTS public."SATELLITE_заявки"
(
    "id_заявки" integer NOT NULL,
    "дата_заказа" date NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_заявки")
);

CREATE TABLE IF NOT EXISTS public."SATELLITE_клиенты"
(
    "id_клиента" integer NOT NULL,
    "фамилия" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    "имя" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    "отчество" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    "телефон" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "клиенты_pkey" PRIMARY KEY ("id_клиента")
);

CREATE TABLE IF NOT EXISTS public."SATELLITE_сотрудники"
(
    "id_сотрудника" integer NOT NULL,
    "фамилия" character varying(25) NOT NULL,
    "имя" character varying(25) NOT NULL,
    "отчество" character varying(25) NOT NULL,
    "телефон" character varying(25) NOT NULL,
    "должность" character varying(25) NOT NULL,
    PRIMARY KEY ("id_сотрудника")
);

CREATE TABLE IF NOT EXISTS public."SATELLITE_поставки"
(
    "id_поставки" integer NOT NULL,
    "id_заявки" integer NOT NULL,
    "id_поставщика" integer NOT NULL,
    "дата_поставки" date NOT NULL,
    "количество" integer NOT NULL,
    "id_продукта" integer NOT NULL,
    PRIMARY KEY ("id_поставки")
);

CREATE TABLE IF NOT EXISTS public."SATELLITE_продукты"
(
    "id_продукта" integer NOT NULL,
    "название_продукта" character varying(100) NOT NULL,
    "вес_продукта" integer NOT NULL,
    "цена_продукта" serial NOT NULL,
    PRIMARY KEY ("id_продукта")
);

CREATE TABLE IF NOT EXISTS public."SATELLITE_поставщики"
(
    "id_поставщика" integer NOT NULL,
    "наименование_поставщика" character varying(100) NOT NULL,
    "адрес" character varying(100) NOT NULL,
    PRIMARY KEY ("id_поставщика")
);

CREATE TABLE IF NOT EXISTS public."HUB_заявки"
(
    "id_заявки" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_заявки")
);

CREATE TABLE IF NOT EXISTS public."HUB_сотрудники"
(
    "id_сотрудника" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_сотрудника")
);

CREATE TABLE IF NOT EXISTS public."HUB_клиенты"
(
    "id_клиента" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_клиента")
);

CREATE TABLE IF NOT EXISTS public."HUB_поставки"
(
    "id_поставки" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_поставки")
);

CREATE TABLE IF NOT EXISTS public."HUB_продукты"
(
    "id_продукта" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_продукта")
);

CREATE TABLE IF NOT EXISTS public."HUB_поставщики"
(
    "id_поставщика" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_поставщика")
);

CREATE TABLE IF NOT EXISTS public."LINK_заявки_клиенты"
(
    "id_заявки" integer NOT NULL,
    "id_клиента" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_заявки", "id_клиента")
);

CREATE TABLE IF NOT EXISTS public."LINK_заявки_сотрудники"
(
    "id_заявки" integer NOT NULL,
    "id_сотрудника" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_заявки", "id_сотрудника")
);

CREATE TABLE IF NOT EXISTS public."LINK_заявки_поставки"
(
    "id_заявки" integer NOT NULL,
    "id_поставки" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_заявки", "id_поставки")
);

CREATE TABLE IF NOT EXISTS public."LINK_поставки_поставщика"
(
    "id_поставки" integer NOT NULL,
    "id_поставщика" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_поставщика", "id_поставки")
);

CREATE TABLE IF NOT EXISTS public."LINK_поставки_продукты"
(
    "id_поставки" integer NOT NULL,
    "id_продукта" integer NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_продукта", "id_поставки")
);

ALTER TABLE IF EXISTS public."SATELLITE_заявки"
    ADD FOREIGN KEY ("id_заявки")
    REFERENCES public."HUB_заявки" ("id_заявки") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."SATELLITE_клиенты"
    ADD FOREIGN KEY ("id_клиента")
    REFERENCES public."HUB_клиенты" ("id_клиента") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."SATELLITE_сотрудники"
    ADD FOREIGN KEY ("id_сотрудника")
    REFERENCES public."HUB_сотрудники" ("id_сотрудника") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."SATELLITE_поставки"
    ADD FOREIGN KEY ("id_поставки")
    REFERENCES public."HUB_поставки" ("id_поставки") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."SATELLITE_продукты"
    ADD FOREIGN KEY ("id_продукта")
    REFERENCES public."SATELLITE_поставки" ("id_продукта") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."SATELLITE_продукты"
    ADD FOREIGN KEY ("id_продукта")
    REFERENCES public."HUB_продукты" ("id_продукта") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."SATELLITE_поставщики"
    ADD FOREIGN KEY ("id_поставщика")
    REFERENCES public."HUB_поставщики" ("id_поставщика") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_заявки_клиенты"
    ADD FOREIGN KEY ("id_заявки")
    REFERENCES public."HUB_заявки" ("id_заявки") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_заявки_клиенты"
    ADD FOREIGN KEY ("id_клиента")
    REFERENCES public."HUB_клиенты" ("id_клиента") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_заявки_сотрудники"
    ADD FOREIGN KEY ("id_заявки")
    REFERENCES public."HUB_заявки" ("id_заявки") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_заявки_сотрудники"
    ADD FOREIGN KEY ("id_сотрудника")
    REFERENCES public."HUB_сотрудники" ("id_сотрудника") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_заявки_поставки"
    ADD FOREIGN KEY ("id_заявки")
    REFERENCES public."HUB_заявки" ("id_заявки") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_заявки_поставки"
    ADD FOREIGN KEY ("id_поставки")
    REFERENCES public."HUB_поставки" ("id_поставки") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_поставки_поставщика"
    ADD FOREIGN KEY ("id_поставки")
    REFERENCES public."HUB_поставки" ("id_поставки") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_поставки_поставщика"
    ADD FOREIGN KEY ("id_поставщика")
    REFERENCES public."HUB_поставщики" ("id_поставщика") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_поставки_продукты"
    ADD FOREIGN KEY ("id_поставки")
    REFERENCES public."HUB_поставки" ("id_поставки") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."LINK_поставки_продукты"
    ADD FOREIGN KEY ("id_продукта")
    REFERENCES public."HUB_продукты" ("id_продукта") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;