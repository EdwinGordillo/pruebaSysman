-- Crear la tabla TASKS
CREATE TABLE TASKS (
    TASK_ID NUMBER PRIMARY KEY,
    TITLE VARCHAR2(100) NOT NULL,
    DESCRIPTION VARCHAR2(4000),
    COMPLETED NUMBER(1, 0) DEFAULT 0,
    CREATED_AT TIMESTAMP DEFAULT SYSDATE,
    UPDATED_AT TIMESTAMP
);

-- Crear la secuencia para auto-generar TASK_ID
CREATE SEQUENCE SEQ_TASK_ID
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Trigger para asignar automáticamente el ID y fecha de actualización
CREATE OR REPLACE TRIGGER TRG_TASKS_BI
BEFORE INSERT ON TASKS
FOR EACH ROW
BEGIN
    IF :NEW.TASK_ID IS NULL THEN
        :NEW.TASK_ID := SEQ_TASK_ID.NEXTVAL;
    END IF;

    :NEW.UPDATED_AT := SYSDATE;
END;
/

-- Trigger para actualizar la fecha de modificación
CREATE OR REPLACE TRIGGER TRG_TASKS_BU
BEFORE UPDATE ON TASKS
FOR EACH ROW
BEGIN
    :NEW.UPDATED_AT := SYSDATE;
END;
/


--Creación del paquete

-- Especificación del paquete
CREATE OR REPLACE PACKAGE TASK_PKG AS
    PROCEDURE CREATE_TASK(
        p_title IN VARCHAR2,
        p_description IN VARCHAR2,
        p_task_id OUT NUMBER
    );

    PROCEDURE UPDATE_TASK(
        p_task_id IN NUMBER,
        p_title IN VARCHAR2,
        p_description IN VARCHAR2,
        p_completed IN NUMBER
    );

    PROCEDURE DELETE_TASK(p_task_id IN NUMBER);

    FUNCTION GET_ALL_TASKS RETURN SYS_REFCURSOR;

    FUNCTION GET_TASK_BY_ID(p_task_id IN NUMBER) RETURN SYS_REFCURSOR;
END TASK_PKG;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY TASK_PKG AS

    PROCEDURE CREATE_TASK(
        p_title IN VARCHAR2,
        p_description IN VARCHAR2,
        p_task_id OUT NUMBER
    ) IS
    BEGIN
        INSERT INTO TASKS (TITLE, DESCRIPTION)
        VALUES (p_title, p_description)
        RETURNING TASK_ID INTO p_task_id;
    END;

    PROCEDURE UPDATE_TASK(
        p_task_id IN NUMBER,
        p_title IN VARCHAR2,
        p_description IN VARCHAR2,
        p_completed IN NUMBER
    ) IS
    BEGIN
        UPDATE TASKS
        SET TITLE = p_title,
            DESCRIPTION = p_description,
            COMPLETED = p_completed
        WHERE TASK_ID = p_task_id;
    END;

    PROCEDURE DELETE_TASK(p_task_id IN NUMBER) IS
    BEGIN
        DELETE FROM TASKS
        WHERE TASK_ID = p_task_id;
    END;

    FUNCTION GET_ALL_TASKS RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT * FROM TASKS;
        RETURN v_cursor;
    END;

    FUNCTION GET_TASK_BY_ID(p_task_id IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT * FROM TASKS WHERE TASK_ID = p_task_id;
        RETURN v_cursor;
    END;

END TASK_PKG;
/