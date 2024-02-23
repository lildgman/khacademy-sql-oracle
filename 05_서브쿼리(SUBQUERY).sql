/*
    * �������� (SUBQUERY)
    �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
    ���� SQL���� ���� ���� ������ �ϴ� ������
    
*/

-- ������ �������� ����
-- 1. ���ö ����� ���� �μ��� ���� ����� ��ȸ

-- 1) ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� �� �ܰ踦 �ϳ��� ����������
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '���ö');
    
-- ������ �������� ����2
-- �� ���� ��ձ޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
-- 1) �������� ��ձ޿�
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 2) 3047663���� ���� �޴� ����� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;
     
-- 3) �� �ܰ踦 ���غ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (
    SELECT ROUND(AVG(SALARY))
    FROM EMPLOYEE
    );
    
/*
    ���������� ����
    ���������� ������ ������� ���� ��� �����Ŀ� ���� �з�
    
    -- ������ ��������: ���������� ��ȸ ������� ������ ������ 1���� ��
    -- ������ ��������: ���������� ��ȸ ������� ���� ���϶�(������ �ѿ�)
    -- ���߿� ��������: ���������� ��ȸ ������� �� �������� �÷��� ������ �� ��
    -- ������ ���߿� ��������: ���������� ��ȸ ������� ������ �����÷��� ��
    
    >> ���������� ������ ���Ŀ� ���� �������� �տ� �ٴ� �����ڰ� �޶�����
    
*/

/*
    1. ������ ��������
    ���������� ��ȸ ������� ������ ������ 1���� ��(���� �ѿ�)
    �Ϲ� �񱳿����� ��� ����
    = != > <= ...
*/

--1) �� ������ ��� �޿����� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿���ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (
    SELECT ROUND(AVG(SALARY))
    FROM EMPLOYEE
    );
    
--2) �����޿��� �޴� ����� ���, �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (
        SELECT MIN(SALARY)
        FROM EMPLOYEE
        );
--3) ���ö ����� �޿����� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (
        SELECT SALARY
        FROM EMPLOYEE
        WHERE EMP_NAME = '���ö'
        );

--4) ���ö ����� �޿����� ���� �޴� ������� ���, �̸�, �μ���, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (
        SELECT SALARY
        FROM EMPLOYEE
        WHERE EMP_NAME = '���ö'
        );

--5) �μ��� �޿� ���� ���� ū �μ��� �μ��ڵ�, �޿� ��
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
            SELECT MAX(SUM(SALARY))
            FROM EMPLOYEE
            GROUP BY DEPT_CODE
        ); 

--6) '������' ����� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, �Ի���, �μ���
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (
        SELECT DEPT_CODE
        FROM EMPLOYEE
        WHERE EMP_NAME = '������'
    )
    AND EMP_NAME NOT LIKE '������';


------------------------------------------------------------------------------
/*
    2. ������ ��������
    ���������� ������ ������� �������� ��(�÷��� �Ѱ�)
    
    IN (��������): ���� �� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� �ִٸ� ��ȸ
    > ANY (��������): ���� ���� ����� �߿��� �Ѱ��� Ŭ ���
    < ANY (��������): ���� ���� ����� �߿��� �Ѱ��� ���� ���
        �񱳴�� > ANY (���������� ����� => ��1, ��2, ��3 ...)
        = �񱳴�� > ��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3
        
    > ALL (��������): ���� ���� ��� ������� ���� Ŭ ���
    < ALL (��������): ���� ���� ��� ������� ���� ���� ���
        �񱳴�� > ALL (���������� ����� => ��1, ��2, ��3 ...)
        = �񱳴�� > ��1 AND �񱳴�� > ��2 AND �񱳴�� > ��3 ... 
*/

-- 1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, ���� �ڵ�, �޿�
-- ����� �Ǵ� ������ ���� �ڵ�
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�����', '������');

-- ������ J3, J7�� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3','J7');

-- �� ������ ���������� ���� ���غ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('�����', '������')
                );

--2) �븮 �����Ӿֵ� ���� ���� �޿��� �� �ּ� �޿����� ���� �޴� ����� ��ȸ
-- (���, �̸�, ����, �޿�)

--2_1) ���� ���� �޿�
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����';
--2_2) �븮�����̸鼭 ���� ����� ���� �ϳ��� ū ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SALARY > ANY(220000, 3760000, 2500000);

-- �� ���� ������
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SALARY > ANY(SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING (JOB_CODE)
                WHERE JOB_NAME = '����')
    AND JOB_NAME = '�븮';

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > (
        SELECT MIN(SALARY)
        FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE)
        WHERE JOB_NAME = '����'
    );

------------------------------------------------------------------------

/*
    3. ���߿� ��������
    ������� �� �������� ������ �÷����� ���� ���� ���
*/

-- 1) ������ ����� ���� �μ��ڵ�, ���� ���� �ڵ忡 �ش��ϴ� ����� ��ȸ
-- �����, �μ��ڵ�, �����ڵ�, �Ի���
--> ������ ��������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (
                SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������')
    AND JOB_CODE = (
                SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������');
--> ���߿� ��������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
                SELECT DEPT_CODE, JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������');

--�ڳ��� ����� ���� �����ڵ�, ���� ����� �������ִ� ������� ���, �����, �����ڵ�, �����ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (
            SELECT JOB_CODE, MANAGER_ID
            FROM EMPLOYEE
            WHERE EMP_NAME = '�ڳ���')
    AND EMP_NAME NOT LIKE '�ڳ���';

----------------------------------------------------------------------------------------
/*
    4. ������ ���߿� ��������
    ���������� ��ȸ ������� ������ �������� ���
*/

-- 1) �� ���޺� �ּұ޿��� �޴� ��� ��ȸ(���, �����, �����ڵ�, �޿�)
--> �� ���޺� �ּұ޿�
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

--> �� ���޺� �ּұ޿��� �޴� ����� ��ȸ
-- (���, �����, �����ڵ�, �޿�)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE = 'J7' AND SALARY = 1380000
    OR JOB_CODE = 'J3' AND SALARY = 3400000
    OR JOB_CODE = 'J6' AND SALARY = 2000000
    OR JOB_CODE = 'J5' AND SALARY = 2200000
    OR JOB_CODE = 'J1' AND SALARY = 8000000
    OR JOB_CODE = 'J4' AND SALARY = 1550000;
    
-- �������� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (
        SELECT JOB_CODE, MIN(SALARY)
        FROM EMPLOYEE
        GROUP BY JOB_CODE);
        
-------------------------------------------------------------------------------
-- �� �μ��� �ְ�޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE (DEPT_CODE, SALARY) IN (
            SELECT DEPT_CODE, MAX(SALARY)
            FROM EMPLOYEE
            GROUP BY DEPT_CODE)
ORDER BY SALARY DESC;

----------------------------------------------------------------------------

/*
    5. �ζ��� ��
    FROM���� ���������� �ۼ��� ��
    ���������� ������ ����� ��ġ ���̺�ó�� ���
*/

--������� ���, �̸�, ���ʽ� ���� ����, �μ��ڵ带 ��ȸ
--��, ���ʽ����� ������ NULL�� �Ǹ� �ȵȴ�.
--��, ���ʽ����� ������ 3000���� �̻��� ����鸸 ��ȸ

SELECT ROWNUM, EMP_ID, EMP_NAME, (SALARY + (SALARY*NVL(BONUS,0)))*12 AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + (SALARY*NVL(BONUS,0)))*12 > 30000000
ORDER BY ���� DESC;

--> �ζ��� �並 �ַ� ����ϴ� �� >> TOP-N�м�: ���� ��� ��ȸ
--�� ���� �� �޿��� ���� ���� 5�� ��ȸ
-- ROWNUM: ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <=5
ORDER BY SALARY DESC;

--> ORDER BY���� ����� ����� ������ ROWNUM �ο� -> ���� 5�� ��ȸ
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT ROWNUM, EMP_NAME, SALARY
    FROM EMPLOYEE
    ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ(�����, �޿� �Ի���)
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM (SELECT *
      FROM EMPLOYEE
      ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;

-- �� �μ��� ��ձ޿��� ���� 3���� �μ�
SELECT DEPT_TITLE, ���
FROM (SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS ���
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY ��� DESC)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE ROWNUM <= 3;

-- �μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��鿡 ����
-- �μ��ڵ�, �μ��� �� �޿���, �μ��� ��ձ޿�, �μ��� ��� ��

SELECT DEPT_CODE, SUM(SALARY) AS �޿���, ROUND(AVG(SALARY)) AS �޿����, COUNT(*) AS �����
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000;

SELECT *
FROM (
    SELECT DEPT_CODE, SUM(SALARY) AS �޿���, ROUND(AVG(SALARY)) AS �޿����, COUNT(*) AS �����
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
WHERE �޿���� > 2700000;

-----------------------------------------------------------------------------------
/*
    ������ �ű�� �Լ�(WINDOW FUNCTION)
    RANK() OVER(���ı���) | DENSE_RANK() OVER(���ı���)
    RANK() OVER(���ı���): ������ ���� ���� ����� ������ �ο� �� ��ŭ �ǳʶٰ� ���� ���
    DANSE_RANK() OVER(���ı���): ������ ������ �ִٰ��ص� �� ���� ����� ������ 1�� ������Ŵ
    
    ������ SELECT�������� ��� ����
*/

-- �޿��� ���� ������� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY,RANK() OVER(ORDER BY SALARY DESC) AS ����
FROM EMPLOYEE;
-- ���� 19�� 2�� �� ���� ����� 21������ �ϳ� �ǳ� ��

SELECT EMP_NAME, SALARY,DENSE_RANK() OVER(ORDER BY SALARY DESC) AS ����
FROM EMPLOYEE;
--> 19���� ���������� �� �ڿ� 20���� �ٷ� ���´�

SELECT *
FROM (SELECT EMP_NAME, SALARY,DENSE_RANK() OVER(ORDER BY SALARY DESC) AS ����
        FROM EMPLOYEE)
WHERE ���� <= 5;


