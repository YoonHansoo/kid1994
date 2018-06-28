SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,CASE e.JOB WHEN 'CLECK'     THEN e.sal * 0.05
                  WHEN 'SALESMAN'  THEN e.sal * 0.04
                  WHEN 'MANAGER'   THEN e.sal * 0.037
                  WHEN 'ANALYST'   THEN e.sal * 0.03
                  WHEN 'PRESIDENT' THEN e.sal * 0.015
        END as "������ ������"
  FROM emp e
;

--2. Searched Case �������� ���غ���

SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,CASE WHEN e.JOB ='CLERK' THEN e.sal * 0.05
            WHEN e.JOB ='SALESMAN' THEN e.sal * 0.04
            WHEN e.JOB ='MANAGER' THEN e.sal * 0.037
            WHEN e.JOB ='ANALYST' THEN e.sal * 0.03
            WHEN e.JOB ='PRESIDENT' THEN e.sal * 0.015
            ElSE 10
        END as "������ ������"
  FROM emp e 
;
-- CASE ����� ���� ��ȭ ���� ����� : $��ȣ, ���� ���ڸ� ���� �б�, �Ҽ��� ���� 2�ڸ�
SELECT e.EMPNO
      ,e.ENAME
      ,nvl(e.JOB, '������') as "job"
      ,TO_CHAR(CASE WHEN e.JOB ='CLERK' THEN e.sal * 0.05
            WHEN e.JOB ='SALESMAN' THEN e.sal * 0.04
            WHEN e.JOB ='MANAGER' THEN e.sal * 0.037
            WHEN e.JOB ='ANALYST' THEN e.sal * 0.03
            WHEN e.JOB ='PRESIDENT' THEN e.sal * 0.015
            ElSE 10
        END,'$9,999.99') as "������ ������"
  FROM emp e 
;  

/* SALGRADE ���̺��� ���� : �� ȸ���� �޿� ��� ���� �� 
GRADE, LOSAL, HISAL
1	700	1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999 
*/

--�����Ǵ� �޿� ����� �������� �� ������� �޿� ����� ���غ���
--CASE�� ����Ͽ�

SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
      , CASE WHEN e.SAL >=700 AND e.SAL <=1200 THEN 1
             WHEN e.SAL >1200 AND e.SAL <=1400 THEN 2
             WHEN e.SAL >1400 AND e.SAL <=2000 THEN 3
             WHEN e.SAL >2000 AND e.SAL <=3000 THEN 4
             WHEN e.SAL >3000 AND e.SAL <=9999 THEN 5
             ELSE 0
          END as "�޿� ���"
  FROM emp e
 ORDER BY "�޿� ���" DESC
;

-- WHEN ���� ������ BETWEEN���� �����Ͽ� �ۼ�
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
      , CASE  WHEN e.SAL BETWEEN 700  AND 1200 THEN 1
              WHEN e.SAL BETWEEN 1201 AND 1400 THEN 2
              WHEN e.SAL BETWEEN 1401 AND 2000 THEN 3
              WHEN e.SAL BETWEEN 2001 AND 3000 THEN 4
              WHEN e.SAL BETWEEN 3001 AND 9999 THEN 5
              ELSE 0
              END as "�޿� ���"
  FROM emp e
 ORDER BY "�޿� ���" DESC
;

-----------2.�׷��Լ�(������ �Լ�)
--1)COUNT(*) : Ư�� ���̺��� ���� ����(�������� ����)�� �����ִ� �Լ�
--                NULL�� ó���ϴ� <������> �׷��Լ�

--COUNT(expr) : expr ���� ������ ���� NULL �����ϰ� �����ִ� �Լ�

--dept, salgrade ���̺��� ��ü ������ ���� ��ȸ
SELECT COUNT(*) AS "�μ�����"
  FROM dept d
;

--10	ACCOUNTING	NEW YORK ===>
--20	RESEARCH	DALLAS     ===> COUNT(*) ===> 4
--30	SALES	CHICAGO        ===>
--40	OPERATIONS	BOSTON   ===>

SELECT *
  FROM dept d
;
SELECT COUNT(*) as "�޿���� ����"
  FROM salgrade s
;

---emp ���̺��� job �÷��� ������ ������ ī��Ʈ
SELECT COUNT(e.job) 
  FROM emp e
;
SELECT *
  FROM emp e
;
/*
SMITH	CLERK           ===>
ALLEN	SALESMAN        ===>
WARD	SALESMAN        ===>
JONES	MANAGER         ===>
MARTIN	SALESMAN      ===> COUNT(e.job) ===>12
BLAKE	MANAGER         ===>
CLARK	MANAGER         ===>
KING	PRESIDENT       ===>
TURNER	SALESMAN      ===>
JAMES	CLERK           ===>
FORD	ANALYST         ===>
MILLER	CLERK         ===>
JJ	(null)            ===> ������ ���� ���� �÷��� JOBDL  NULL�� �� ������ ó�� ���� 
*/

--ȸ�翡 �Ŵ����� ������ ������ ����ΰ�?
SELECT COUNT(e.MGR) as "��簡 �ִ� ����"
  FROM emp e
;
-- �Ŵ��� ���� �ð� �ִ� ������ ����ΰ�?
--1.mgr �÷��� �ߺ����� �Ͽ� ��ȸ
--2.�׋��� ����� ī��Ʈ
SELECT COUNT(DISTINCT(e.MGR)) as "�Ŵ��� ��"
  FROM emp e
;

--ȸ�翡�� �μ��� ������ ������ ����̳� �ִ°�?
SELECT COUNT(e.DEPTNO) as "�μ� ���� �ο�"
  FROM emp e
;
--COUNT(*)�� �ƴ� COUNT(expr)�� ����� ��쿡��
SELECT e.DEPTNO
  FROM emp e
 where e.DEPTNO iS NOT NULL
;
--�� ������ ����� ī��Ʈ �� ������ ���� �� �� �ִ�.
SELECT COUNT(*) as "��ü ����"
      ,COUNT(e.DEPTNO) as "�μ� ���� �ο�"
      ,COUNT(*)-COUNT(e.DEPTNO) as "�μ� �̹��� �ο�"
  FROM emp e
;

-- 2)SUM() : NULL �׸� �����ϰ�
--           �ջ갡���� ���� ��� ���� ����� ���
-- SALESMAN ���� ���� ������ ���غ���
SELECT SUM(e.COMM)
  FROM emp e
 WHERE e.JOB = 'SALESMAN' 
;
-- ���� ���� ����� ���� ��� ����, ��Ī
SELECT To_CHAR(SUM(e.COMM),'$9,999') as "���� ����"
  FROM emp e
 WHERE e.JOB = 'SALESMAN' 
;

--3)AVG(expr) : NULL �� �����ϰ� ���� ������ �׸��� ��� ����� ����

--���� ����� ���غ���
SELECT To_CHAR(AVG(e.COMM),'$9,999') as "���� ���"
  FROM emp e
;

-- 4)MAX(expr) : expr�� ������ �� �� �ִ��� ����
--               expr�� ������ ��� ���ĺ��� ���ʿ� ��ġ�� ���ڸ� �ִ����� ���
-- �̸��� ���� ������ ����
SELECT MAX(e.ename)
  FROM emp e
;

--------3. GROUP BY ���� ���
--1)emp ���̺� �� �μ��� �޿��� ������ ��ȸ

-- ������ ���ϱ� ���Ͽ� SUM()�� ���
-- �׷�ȭ ������ �μ���ȣ(deptno)�� ���
-- �׷�ȭ �������� ���� �μ���ȣ�� GROUP BY ���� �����ؾ� ��
SELECT SUM(e.SAL) as "�޿� ����"
          ,e.DEPTNO
  FROM emp e
 group by e.DEPTNO
;


--
--#####SELECT COUNT(*),ENAME
--  FROM emp 
-- group by ENAME 
--######;

--�μ��� �޿��� ����, ���, �ִ�޿�, �ּұ޿��� ������
SELECT SUM(e.SAL) "�޿� ����"
      ,TO_CHAR(AVG(e.SAL),'9,999') "�޿� ���"
      ,MAX(e.SAL) "�ִ� �޿�"
      ,MIN(e.SAL) "�ּ� �޿�"
  FROM EMP e
 GROUP BY e.DEPTNO
;
--���� ������ ��������� ��Ȯ�ϰ� ��� �μ��� �������
-- �� ���� ���ٴ� ������ ����

/* #####################################################################
GROUP BY ���� �����ϴ� �׷�ȭ ���� �÷��� �ݵ�� SELECT ���� �Ȱ��� �����ؾ� �Ѵ�.

������ ���� ������ ����Ǵ� ������ 
SELECT ���� ������ �÷� �߿��� �׷��Լ��� ������ ���� �÷��� ���� ����
��, ��δ� �׷��Լ��� ���� �÷����̱� ����

########################################################################*/
SELECT e.DEPTNO   "�μ���ȣ"
      ,SUM(e.SAL) "�޿� ����"
      ,TO_CHAR(AVG(e.SAL),'9,999') "�޿� ���"
      ,MAX(e.SAL) "�ִ� �޿�"
      ,MIN(e.SAL) "�ּ� �޿�"
  FROM EMP e
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;

--�μ���, ������ �޿��� ����, ���, �ִ�, �ּҸ� ���غ���
SELECT e.DEPTNO   "�μ���ȣ"
      ,e.JOB      "����"
      ,SUM(e.SAL) "�޿� ����"
      ,AVG(e.SAL) "�޿� ���"
      ,MAX(e.SAL) "�ִ� �޿�"
      ,MIN(e.SAL) "�ּ� �޿�"
  FROM EMP e
 GROUP BY e.DEPTNO, e.JOB
 ORDER BY e.DEPTNO, e.JOB
;

--�����ڵ�
SELECT e.DEPTNO   "�μ���ȣ"
      ,e.JOB      "����"      --SELECT���� ����
      ,SUM(e.SAL) "�޿� ����"
      ,AVG(e.SAL) "�޿� ���"
      ,MAX(e.SAL) "�ִ� �޿�"
      ,MIN(e.SAL) "�ּ� �޿�"
  FROM EMP e
 GROUP BY e.DEPTNO          --GROUP BY ���� ������ �÷� JOB
 ORDER BY e.DEPTNO, e.JOB
;
--�׷��Լ��� ������� �ʾҰ�, GROUP BY ������ �������� ���� JOB �÷���
--SELECT ���� �ֱ� ������, ������ �߻�

--�����ڵ� ORA-00937: not a single-group group function
SELECT e.DEPTNO   "�μ���ȣ"
      ,e.JOB      "����"      --SELECT���� ����
      ,SUM(e.SAL) "�޿� ����"
      ,AVG(e.SAL) "�޿� ���"
      ,MAX(e.SAL) "�ִ� �޿�"
      ,MIN(e.SAL) "�ּ� �޿�"
  FROM EMP e
--GROUP BY e.DEPTNO          --GROUP BY ���� ������ �÷� JOB
 ORDER BY e.DEPTNO, e.JOB
;
--�׷��Լ��� ������� ���� �÷����� SELECT�� �����ϸ�
--�׷�ȭ �������� �����Ǿ�� �� 
--�׷�ȭ �������� ���Ǵ� GROUP BY 

--job �� �޿��� ����,���,�ִ�,�ּҸ� ���غ���
SELECT e.JOB as "job"
       ,SUM(e.SAL) as "����"
       ,AVG(e.SAL) as "���"
       ,SUM(e.SAL) as "�ִ�"
      ,SUM(e.SAL) as "�ּ�"
  FROM emp e
 GROUP BY e.JOB
;
--�μ� �̹����̿��� NULL�� �����ʹ� �μ���ȣ ��� '�̹���'�̶�� �з�
SELECT DECODE(nvl(e.deptno,0)
            , e.DEPTNO, e.DEPTNO || ''
            , '�̹���')
     , SUM(e.SAL) as "�޿� ����"
     , AVG(e.SAL) as "�޿� ���"
     , MAX(e.SAL) as "�ִ� �޿�"
     , MIN(e.SAL) as "�ּ� �޿�"
  FROM emp e
 GROUP BY e.deptno
;

SELECT nvl(e.deptno||'','�μ�������')
     , SUM(e.SAL) as "�޿� ����"
     , AVG(e.SAL) as "�޿� ���"
     , MAX(e.SAL) as "�ִ� �޿�"
     , MIN(e.SAL) as "�ּ� �޿�"
  FROM emp e
 GROUP BY e.deptno
;

---4.HAVING ���� ���
--GROUP BY ����� ������ �ɾ
--����� ����(���͸�) �� �������� ���Ǵ� ��

--����)�μ��� �޿� ����� 2000�̻� �� �μ�
--a)�μ� �� �޿� ����� ���Ѵ�
--b)a�� ������� 2000�̻��� �μ��� �����.
SELECT e.DEPTNO   "�μ���ȣ"
     , AVG(e.SAL) "�޿� ���"
  FROM EMP e
 GROUP BY e.DEPTNO
HAVING AVG(e.SAL) >=2000
 ORDER BY e.DEPTNO
;
--�����ڵ�: HAVING ���� ����Ͽ� ������ �� �� ������ �� :��Ī�� ����� �� ����
--HAVING ���� �����ϴ� ��� SELECT �� ������ ���� ���� ����
/*
1.FROM ���� ���̺� �� ���� �������
2.WHERE ���� ���ǿ� �´� �ุ �����ϰ�
3.GROUP BY ���� ���� �÷�, ��(�Լ� �� ��)���� �׷�ȭ�� ����
4.HAVING ���� ������ ������Ű�� �׷��ุ�� ����
5.4���� ���õ� �׷� ������ ���� �࿡ ���Ͽ� 
  SELECT ���� ��õ� �÷�, ��(�Լ� �� ��)�� ���
6.ORDER BY �� �ִٸ� ���� ���ǿ� ���߾� ���� �����Ͽ� �����ش�.



*/
SELECT e.DEPTNO   "�μ���ȣ"
     , AVG(e.SAL) "�޿� ���"
  FROM EMP e
 GROUP BY e.DEPTNO
HAVING "�޿� ���" >=2000
 ORDER BY e.DEPTNO
;
--�����ڵ� : ORA-00904: "�޿� ���": invalid identifier HAVING�� ���ǿ� ��Ī�� ����Ͽ��� ����

--------------------------------------------------------------------------------
--������ �ǽ� 
--1.�Ŵ��� ��, ���������� ���� ���ϰ�, ���� ������ ����
SELECT 
       (count(e.MGR)) as "���������� ��"
     , e.MGR          as "�Ŵ���"
  FROM emp e 
 WHERE e.MGR IS NOT NULL
 GROUP BY e.MGR
 ORDER BY (count(e.MGR)) desc
;
--2.�μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
SELECT e.deptno        as "�μ���ȣ"
     , count(e.deptno) as "��� ��"
  FROM emp e
 where deptno IS NOT NULL
 GROUP BY e.deptno
 ORDER By "��� ��" desc
;

--3.������ �޿������ ���ϰ�, �޿���� ���� ������ ����
SELECT nvl(e.JOB||'','����������') as "����"
      , TO_CHAR(AVG(e.sal),'9,999') as "������ �޿����"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY AVG(e.sal) desc
;
--4.������ �޿��� ������ ���ϰ�, ���� ������ ����
SELECT nvl(e.JOB||'','����������') as "����"
      , TO_CHAR(SUM(e.sal),'9,999') as "������ �޿�����"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY SUM(e.sal) desc
;

nvl(e.JOB||'','����������');
--5.�޿��� �մ����� 1000����,1000,2000,3000,5000���� �ο����� ���Ͻÿ�.
--  �޿� ���� �������� ����
--a)�޿� ������ ��� ���� ���ΰ�? TRUNC() Ȱ��
SELECT e.EMPNO
     , e.ENAME
     , TRUNC(e.SAL, -3) as "�޿�����"
  FROM emp e
;
--b)TRUNC�� �� �޿������� COUNT�ϸ� �ο����� ���� �� �ְڴ�.
SELECT TRUNC(e.SAL, -3) as "�޿�����" 
     , COUNT(TRUNC(e.SAL, -3))
  FROM emp e
 GROUP BY TRUNC(e.SAL,-3)
 order by (TRUNC(e.sal,-3)) desc
;

--c)�޿� ������ 1000�̸��� ��� 0���� ��µǴ� ���� ����
-- : ���� ������ �ʿ��غ��� ===> CASE ���� ����
SELECT CASE WHEN TRUNC(e.SAL, -3) <1000 THEN '1000 �̸�'
            ELSE TRUNC(e.SAL, -3) || ''
       END AS "�޿�����"
     , COUNT(TRUNC(e.SAL, -3)) as "�ο� ��"
  FROM emp e
 GROUP BY TRUNC(e.SAL,-3)
 order by (TRUNC(e.sal,-3)) asc
;
-------------------------------------------------------------------------------
--5���� �ٸ� �Լ��� Ǯ��
--a)sal Į���� �������� �е��� �ٿ��� 0�� ä��
SELECT e.EMPNO
     , e.ENAME
     , LPAD(e.SAL, 4,'0')
  FROM emp e
;
--b)�� ���� ���ڸ� �߶󳽴�. ==>������ ����
SELECT 
      SUBSTR(LPAD(e.SAL, 4,'0'),1,1) "�޿�����"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4,'0'),1,1)
;

--c)

--d)1000������ ��� ���� ����
SELECT CASE WHEN 
      SUBSTR(LPAD(e.SAL, 4,'0'),1,1) = 0 THEN '1000�̸�'
      ELSE TO_CHAR(SUBSTR(LPAD(e.SAL, 4,'0'),1,1)*1000)
      END as "�޿�����"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4,'0'),1,1)
 order by SUBSTR(LPAD(e.SAL, 4,'0'),1,1) desc
;


   WHEN e.SAL >3000 AND e.SAL <=9999 THEN 5
             ELSE 0;
SELECT (TRUNC(e.sal,-3)) as "����"
     , COUNT(e.sal)
  FROM emp e
 GROUP BY (TRUNC(e.sal,-3))
 order by (TRUNC(e.sal,-3)) desc
;

--6.������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����
SELECT nvl(e.JOB||'','����������') as "����"
     , TRUNC(SUM(e.SAL),-3) as "�޿� ����"
  FROM emp e
GROUP BY e.JoB
ORDER BY SUM(e.SAL) desc
;




--7������ �޿� ��������� ��츦 ���ϰ� ����� ���� ������ ����
SELECT nvl(e.JOB||'','����������') as "����"
    , TO_CHAR(AVG(e.sal),'9,999') as "������ �޿����"
  FROM emp e
 GROUP BY e.JOB
HAVING AVG(e.sal)<=2000
 ORDER BY AVG(e.sal) desc
;
--8.�⵵ �� �Ի� �ο��� ���Ͻÿ�
SELECT SUBSTR(e.HIREDATE,1,2) as "�Ի�⵵"
     , count(e.empno) as "�Ի� �ο�"
  FROM emp e
 GROUP BY SUBSTR(e.HIREDATE,1,2)
;

SELECT TO_CHAR(e.HIREDATE, 'YYYY') as "�Ի�⵵"
     , COUNT(*) as "�ο�(��)"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY')
 ORDER BY TO_CHAR(e.HIREDATE, 'YYYY')
;
--9 �⵵�� ���� �Ի� �ο��� ���Ͻÿ�
SELECT SUBSTR(e.HIREDATE,1,2) as "�Ի�⵵"
     , SUBSTR(e.HIREDATE,4,2) as "�Ի��"
     , count(e.empno) as "�Ի� �ο�"
  FROM emp e
 GROUP BY SUBSTR(e.HIREDATE,1,2), SUBSTR(e.HIREDATE,4,2)
order by SUBSTR(e.HIREDATE,1,2), SUBSTR(e.HIREDATE,4,2) asc
;
--

SELECT TO_CHAR(e.HIREDATE, 'YYYY') as "�Ի�⵵"
     , TO_CHAR(e.HIREDATE, 'MM') as "�Ի� ��"
     , COUNT(*) as "�ο�(��)"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY'),  TO_CHAR(e.HIREDATE, 'MM')
 ORDER BY TO_CHAR(e.HIREDATE, 'YYYY'),  TO_CHAR(e.HIREDATE, 'MM')
;


-----------------------------------------------------------------------
--�⵵��, ���� �Ի� �ο��� ���� ǥ ���·� ���
--a)�⵵ ����, �� ����
 TO_CHAR(e.HIREDATE, 'YYYY'),  TO_CHAR(e.HIREDATE, 'MM')
 
--b)hiredate���� ���� ������ ���� 01�� ������ �׋��� ���ڸ� 1������ ī��Ʈ
-- �� ������ 12������ �ݺ�

SELECT 
       TO_CHAR(e.HIREDATE, 'YYYY') as "�Ի�⵵" --�׷�ȭ ���� �÷�
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'01',1) as "1��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'02',1) as "2��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'03',1) as "3��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'04',1) as "4��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'05',1) as "5��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'06',1) as "6��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'07',1) as "7��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'08',1) as "8��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'09',1) as "9��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'10',1) as "10��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'11',1) as "11��"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'12',1) as "12��"
  FROM emp e
 ORDER BY "�Ի�⵵" 
;

--c) �Ի� �⵵ �������� COUNT �Լ� ����� �׷�ȭ
SELECT 
       TO_CHAR(e.HIREDATE, 'YYYY') as "�Ի�⵵" --�׷�ȭ ���� �÷�
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'01',1)) as "1��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'02',1)) as "2��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'03',1)) as "3��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'04',1)) as "4��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'05',1)) as "5��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'06',1)) as "6��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'07',1)) as "7��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'08',1)) as "8��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'09',1)) as "9��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'10',1)) as "10��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'11',1)) as "11��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'12',1)) as "12��"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YYYY')
 ORDER BY "�Ի�⵵" 
;
SELECT 
     '�ο�(��)' as "�Ի��" --�׷�ȭ ���� �÷�
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'01',1)) as "1��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'02',1)) as "2��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'03',1)) as "3��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'04',1)) as "4��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'05',1)) as "5��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'06',1)) as "6��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'07',1)) as "7��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'08',1)) as "8��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'09',1)) as "9��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'10',1)) as "10��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'11',1)) as "11��"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'12',1)) as "12��"
  FROM emp e
;

----------7. ���ΰ� ��������
--(1)���ΰ��� : JOIN
--�ϳ� �̻��� ���̺��� �������� ��� �ϳ��� ���̺� �� �� ó�� �ٷ�� ���
--FROM ���� ���ο� ����� ���̺� �̸��� ����

--����)������ �Ҽ� �μ� ��ȣ�� �ƴ�, �μ� ���� �˰� �ʹ�.
--a) FROM ���� emp,dept �� ���̺��� ���� ==>���� �߻� ==>ī��� �� ==>�� ���̺��� ��� ����
SELECT e.ENAME
     , d.DNAME
  FROM emp e
     , dept d
;
--b) ������ �߰� �Ǿ�� ������ �ҼӺμ��� ��Ȯ�ϰ� ������ �� ����

SELECT e.ENAME
     , d.DNAME
  FROM emp e
     , dept d
where e.deptno = d.deptno --����Ŭ�� �������� ���� ���� �ۼ� ���
;
--���� ������ ������ �߰��Ǿ� 12���� �ǹ��ִ� �����͸� ����
SELECT e.ENAME
     , d.DNAME
  FROM emp e JOIN dept d ON (e.DEPTNO = D.DEPTNO)
             --�ֱ� �ٸ� DBMS ���� ����ϰ� �ִ� ���
             -- ����Ŭ���� ������
;
--����) ���� ������� ACCOUNTING �μ��� ������ �˰� �ʹ�.
--     ���� ���ǰ� �Ϲ� ������ ���� ���� �� �ִ�.
SELECT e.ENAME
     , d.DNAME
  FROM emp e
     , dept d
where e.deptno = d.deptno --���� ����
  AND d.DNAME = 'ACCOUNTING' --�Ϲ� ����
;

----2)���� : īƼ�� ��
--          ���� ��� ���̺��� �����͸� ������ ��� �������� ���� ��
--          ���� ���� ������ �߻�
--          9i ���� ���� CROSS JOIN Ű���� ����
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e CROSS JOIN dept d
             CROSS JOIN salgrade s
;
--emp 13 x dept 4 x salgrade 5 = 260��
----3) EQUI JOIN : ������ ���� �⺻ ����
--                 ���� �ٸ� ���̺��� ���� �÷��� '=' �� ����
--                 ���� �÷� (join attribute)��� �θ�

----- 1. ����Ŭ ���� ���� WHERE �� ���� ������ �ɾ��ִ� ���
SELECT E.ENAME
     , D.DNAME
 FROM emp e
     , dept d
 WHERE e.DEPTNO = d.DEPTNO --����Ŭ�� �������� ���� ���� �ۼ� ���
 ORDER BY d.DEPTNO
;

----- 2. NATURAL JOIN Ű����� �ڵ� ����
SELECT e.ENAME
     , d.DNAME
  FROM emp e NATURAL JOIN dept d --���� ���� �÷� ��ð� �ʿ� ����
;

----- 3. JOIN ~ USING Ű����� ����
SELECT e.ENAME
     , d.DNAME
  FROM emp e JOIN dept d USING (deptno) -- USING �ڿ� ���� �÷��� ��Ī ���� ���
;

----- 4. JOIN ~ ON Ű����� ����
SELECT e.ENAME
     , d.DNAME
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 -- ON �ڿ� ���� ���Ǳ����� ���  



--(2)��������





