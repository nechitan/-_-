
BEGIN;

CREATE TABLE IF NOT EXISTS public."заявки"
(
    "id_заявки" integer NOT NULL,
    "id_сотрудника" integer NOT NULL,
    "id_клиента" integer NOT NULL,
    "дата_заказа" date NOT NULL,
    CONSTRAINT "заявки_pkey" PRIMARY KEY ("id_заявки")
);

CREATE TABLE IF NOT EXISTS public."клиенты"
(
    "id_клиента" integer NOT NULL,
    "фамилия" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    "имя" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    "отчество" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    "телефон" character varying(25) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "клиенты_pkey" PRIMARY KEY ("id_клиента")
);

CREATE TABLE IF NOT EXISTS public."сотрудники"
(
    "id_сотрудника" integer NOT NULL,
    "фамилия" character varying(25) NOT NULL,
    "имя" character varying(25) NOT NULL,
    "отчество" character varying(25) NOT NULL,
    "телефон" character varying(25) NOT NULL,
    "должность" character varying(25) NOT NULL,
    PRIMARY KEY ("id_сотрудника")
);

CREATE TABLE IF NOT EXISTS public."поставки"
(
    "id_поставки" integer NOT NULL,
    "id_заявки" integer NOT NULL,
    "id_поставщика" integer NOT NULL,
    "дата_поставки" date NOT NULL,
    "количество" integer NOT NULL,
    "id_продукта" integer NOT NULL,
    PRIMARY KEY ("id_поставки")
);

CREATE TABLE IF NOT EXISTS public."продукты"
(
    "id_продукта" integer NOT NULL,
    "название_продукта" character varying(100) NOT NULL,
    "вес_продукта" integer NOT NULL,
    "цена_продукта" serial NOT NULL,
    PRIMARY KEY ("id_продукта")
);

CREATE TABLE IF NOT EXISTS public."поставщики"
(
    "id_поставщика" integer NOT NULL,
    "наименование_поставщика" character varying(100) NOT NULL,
    "адрес" character varying(100) NOT NULL,
    PRIMARY KEY ("id_поставщика")
);

ALTER TABLE IF EXISTS public."заявки"
    ADD FOREIGN KEY ("id_клиента")
    REFERENCES public."клиенты" ("id_клиента") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."заявки"
    ADD FOREIGN KEY ("id_сотрудника")
    REFERENCES public."сотрудники" ("id_сотрудника") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."поставки"
    ADD FOREIGN KEY ("id_заявки")
    REFERENCES public."заявки" ("id_заявки") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."поставки"
    ADD FOREIGN KEY ("id_поставщика")
    REFERENCES public."поставщики" ("id_поставщика") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."поставки"
    ADD FOREIGN KEY ("id_продукта")
    REFERENCES public."продукты" ("id_продукта") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."продукты"
    ADD FOREIGN KEY ("id_продукта")
    REFERENCES public."поставки" ("id_продукта") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;
