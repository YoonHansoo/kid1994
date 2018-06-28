SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,CASE e.JOB WHEN 'CLECK'     THEN e.sal * 0.05
                  WHEN 'SALESMAN'  THEN e.sal * 0.04
                  WHEN 'MANAGER'   THEN e.sal * 0.037
                  WHEN 'ANALYST'   THEN e.sal * 0.03
                  WHEN 'PRESIDENT' THEN e.sal * 0.015
        END as "경조사 지원금"
  FROM emp e
;

--2. Searched Case 구문으로 구해보자

SELECT e.EMPNO
      ,e.ENAME
      ,e.JOB
      ,CASE WHEN e.JOB ='CLERK' THEN e.sal * 0.05
            WHEN e.JOB ='SALESMAN' THEN e.sal * 0.04
            WHEN e.JOB ='MANAGER' THEN e.sal * 0.037
            WHEN e.JOB ='ANALYST' THEN e.sal * 0.03
            WHEN e.JOB ='PRESIDENT' THEN e.sal * 0.015
            ElSE 10
        END as "경조사 지원금"
  FROM emp e 
;
-- CASE 결과에 숫자 통화 패턴 씌우기 : $기호, 숫자 세자리 끊어 읽기, 소수점 이하 2자리
SELECT e.EMPNO
      ,e.ENAME
      ,nvl(e.JOB, '미지정') as "job"
      ,TO_CHAR(CASE WHEN e.JOB ='CLERK' THEN e.sal * 0.05
            WHEN e.JOB ='SALESMAN' THEN e.sal * 0.04
            WHEN e.JOB ='MANAGER' THEN e.sal * 0.037
            WHEN e.JOB ='ANALYST' THEN e.sal * 0.03
            WHEN e.JOB ='PRESIDENT' THEN e.sal * 0.015
            ElSE 10
        END,'$9,999.99') as "경조사 지원금"
  FROM emp e 
;  

/* SALGRADE 테이블의 내용 : 이 회사의 급여 등급 기준 값 
GRADE, LOSAL, HISAL
1	700	1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999 
*/

--제공되는 급여 등급을 바탕으로 각 사원들의 급여 등급을 구해보자
--CASE를 사용하여

SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
      , CASE WHEN e.SAL >=700 AND e.SAL <=1200 THEN 1
             WHEN e.SAL >1200 AND e.SAL <=1400 THEN 2
             WHEN e.SAL >1400 AND e.SAL <=2000 THEN 3
             WHEN e.SAL >2000 AND e.SAL <=3000 THEN 4
             WHEN e.SAL >3000 AND e.SAL <=9999 THEN 5
             ELSE 0
          END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;

-- WHEN 안의 구문을 BETWEEN으로 변경하여 작성
SELECT e.EMPNO
      ,e.ENAME
      ,e.SAL
      , CASE  WHEN e.SAL BETWEEN 700  AND 1200 THEN 1
              WHEN e.SAL BETWEEN 1201 AND 1400 THEN 2
              WHEN e.SAL BETWEEN 1401 AND 2000 THEN 3
              WHEN e.SAL BETWEEN 2001 AND 3000 THEN 4
              WHEN e.SAL BETWEEN 3001 AND 9999 THEN 5
              ELSE 0
              END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;

-----------2.그룹함수(복수행 함수)
--1)COUNT(*) : 특정 테이블의 행의 개수(데이터의 개수)를 세어주는 함수
--                NULL을 처리하는 <유일한> 그룹함수

--COUNT(expr) : expr 으로 등장한 값을 NULL 제외하고 세어주는 함수

--dept, salgrade 테이블의 전체 데이터 개수 조회
SELECT COUNT(*) AS "부서개수"
  FROM dept d
;

--10	ACCOUNTING	NEW YORK ===>
--20	RESEARCH	DALLAS     ===> COUNT(*) ===> 4
--30	SALES	CHICAGO        ===>
--40	OPERATIONS	BOSTON   ===>

SELECT *
  FROM dept d
;
SELECT COUNT(*) as "급여등급 개수"
  FROM salgrade s
;

---emp 테이블에서 job 컬럼의 데이터 개수를 카운트
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
JJ	(null)            ===> 개수를 세는 기준 컬럼인 JOBDL  NULL인 이 한행은 처리 안함 
*/

--회사에 매니저가 배정된 직원이 몇명인가?
SELECT COUNT(e.MGR) as "상사가 있는 직원"
  FROM emp e
;
-- 매니저 직을 맡고 있는 직원이 몇명인가?
--1.mgr 컬럼을 중복제거 하여 조회
--2.그떄의 결과를 카운트
SELECT COUNT(DISTINCT(e.MGR)) as "매니저 수"
  FROM emp e
;

--회사에서 부서가 배정된 직원이 몇명이나 있는가?
SELECT COUNT(e.DEPTNO) as "부서 배정 인원"
  FROM emp e
;
--COUNT(*)가 아닌 COUNT(expr)를 사용한 경우에는
SELECT e.DEPTNO
  FROM emp e
 where e.DEPTNO iS NOT NULL
;
--을 수행한 결과를 카운트 한 것으로 생각 할 수 있다.
SELECT COUNT(*) as "전체 직원"
      ,COUNT(e.DEPTNO) as "부서 배정 인원"
      ,COUNT(*)-COUNT(e.DEPTNO) as "부서 미배정 인원"
  FROM emp e
;

-- 2)SUM() : NULL 항목 제외하고
--           합산가능한 행을 모두 더한 결과를 출력
-- SALESMAN 들의 수당 총합을 구해보자
SELECT SUM(e.COMM)
  FROM emp e
 WHERE e.JOB = 'SALESMAN' 
;
-- 수당 총합 결과에 숫자 출려 패턴, 별칭
SELECT To_CHAR(SUM(e.COMM),'$9,999') as "수당 총합"
  FROM emp e
 WHERE e.JOB = 'SALESMAN' 
;

--3)AVG(expr) : NULL 값 제외하고 연산 가능한 항목의 산술 평균을 구함

--수당 평균을 구해보자
SELECT To_CHAR(AVG(e.COMM),'$9,999') as "수당 평균"
  FROM emp e
;

-- 4)MAX(expr) : expr에 등장한 값 중 최댓값을 구함
--               expr이 문자인 경우 알파벳순 뒷쪽에 위치한 글자를 최댓값으로 계산
-- 이름이 가장 나중인 직원
SELECT MAX(e.ename)
  FROM emp e
;

--------3. GROUP BY 절의 사용
--1)emp 테이블 각 부서별 급여의 총합을 조회

-- 총합을 구하기 위하여 SUM()을 사용
-- 그룹화 기준을 부서번호(deptno)를 사용
-- 그룹화 기준으로 잡은 부서번호가 GROUP BY 절에 등장해야 함
SELECT SUM(e.SAL) as "급여 총합"
          ,e.DEPTNO
  FROM emp e
 group by e.DEPTNO
;


--
--#####SELECT COUNT(*),ENAME
--  FROM emp 
-- group by ENAME 
--######;

--부서별 급여의 총합, 평균, 최대급여, 최소급여를 구하자
SELECT SUM(e.SAL) "급여 총합"
      ,TO_CHAR(AVG(e.SAL),'9,999') "급여 평균"
      ,MAX(e.SAL) "최대 급여"
      ,MIN(e.SAL) "최소 급여"
  FROM EMP e
 GROUP BY e.DEPTNO
;
--위의 쿼리는 수행되지만 정확하게 어느 부서의 결과인지
-- 알 수가 없다는 단점이 존재

/* #####################################################################
GROUP BY 절에 등장하는 그룹화 기준 컬럼은 반드시 SELECT 절에 똑같이 등장해야 한다.

하지만 위의 쿼리가 실행되는 이유는 
SELECT 절에 나열된 컬럼 중에서 그룹함수가 사용되지 않은 컬럼이 없기 때문
즉, 모두다 그룹함수가 사용된 컬럼들이기 떄문

########################################################################*/
SELECT e.DEPTNO   "부서번호"
      ,SUM(e.SAL) "급여 총합"
      ,TO_CHAR(AVG(e.SAL),'9,999') "급여 평균"
      ,MAX(e.SAL) "최대 급여"
      ,MIN(e.SAL) "최소 급여"
  FROM EMP e
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;

--부서별, 직무별 급여의 총합, 평균, 최대, 최소를 구해보자
SELECT e.DEPTNO   "부서번호"
      ,e.JOB      "직무"
      ,SUM(e.SAL) "급여 총합"
      ,AVG(e.SAL) "급여 평균"
      ,MAX(e.SAL) "최대 급여"
      ,MIN(e.SAL) "최소 급여"
  FROM EMP e
 GROUP BY e.DEPTNO, e.JOB
 ORDER BY e.DEPTNO, e.JOB
;

--오류코드
SELECT e.DEPTNO   "부서번호"
      ,e.JOB      "직무"      --SELECT에는 등장
      ,SUM(e.SAL) "급여 총합"
      ,AVG(e.SAL) "급여 평균"
      ,MAX(e.SAL) "최대 급여"
      ,MIN(e.SAL) "최소 급여"
  FROM EMP e
 GROUP BY e.DEPTNO          --GROUP BY 에는 누락된 컬럼 JOB
 ORDER BY e.DEPTNO, e.JOB
;
--그룹함수가 적용되지 않았고, GROUP BY 절에도 등장하지 않은 JOB 컬럼이
--SELECT 절에 있기 때문에, 오류가 발생

--오류코드 ORA-00937: not a single-group group function
SELECT e.DEPTNO   "부서번호"
      ,e.JOB      "직무"      --SELECT에는 등장
      ,SUM(e.SAL) "급여 총합"
      ,AVG(e.SAL) "급여 평균"
      ,MAX(e.SAL) "최대 급여"
      ,MIN(e.SAL) "최소 급여"
  FROM EMP e
--GROUP BY e.DEPTNO          --GROUP BY 에는 누락된 컬럼 JOB
 ORDER BY e.DEPTNO, e.JOB
;
--그룹함수가 적용되지 않은 컬럼들이 SELECT에 등장하면
--그룹화 기준으로 가정되어야 함 
--그룹화 기준으로 사용되는 GROUP BY 

--job 별 급여의 총합,평균,최대,최소를 구해보자
SELECT e.JOB as "job"
       ,SUM(e.SAL) as "총합"
       ,AVG(e.SAL) as "평균"
       ,SUM(e.SAL) as "최대"
      ,SUM(e.SAL) as "최소"
  FROM emp e
 GROUP BY e.JOB
;
--부서 미배정이여서 NULL인 데이터는 부서번호 대신 '미배정'이라고 분류
SELECT DECODE(nvl(e.deptno,0)
            , e.DEPTNO, e.DEPTNO || ''
            , '미배정')
     , SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.deptno
;

SELECT nvl(e.deptno||'','부서미지정')
     , SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.deptno
;

---4.HAVING 절의 사용
--GROUP BY 결과에 조건을 걸어서
--결과를 제한(필터링) 할 목적으로 사용되는 절

--문제)부서별 급여 평균이 2000이상 인 부서
--a)부서 별 급여 평균을 구한다
--b)a의 결과에서 2000이상인 부서만 남긴다.
SELECT e.DEPTNO   "부서번호"
     , AVG(e.SAL) "급여 평균"
  FROM EMP e
 GROUP BY e.DEPTNO
HAVING AVG(e.SAL) >=2000
 ORDER BY e.DEPTNO
;
--오류코드: HAVING 절을 사용하여 조건을 걸 때 주의할 점 :별칭을 사용할 수 없음
--HAVING 절이 존재하는 경우 SELECT 의 구문의 실행 순서 정리
/*
1.FROM 절의 테이블 각 행을 대상으로
2.WHERE 절의 조건에 맞는 행만 선택하고
3.GROUP BY 절에 나온 컬럼, 식(함수 식 등)으로 그룹화를 진행
4.HAVING 절의 조건을 만족시키는 그룹행만을 선택
5.4까지 선택된 그룹 정보를 가진 행에 대하여 
  SELECT 절에 명시된 컬럼, 식(함수 식 등)만 출력
6.ORDER BY 가 있다면 정렬 조건에 맞추어 최정 정렬하여 보여준다.



*/
SELECT e.DEPTNO   "부서번호"
     , AVG(e.SAL) "급여 평균"
  FROM EMP e
 GROUP BY e.DEPTNO
HAVING "급여 평균" >=2000
 ORDER BY e.DEPTNO
;
--오류코드 : ORA-00904: "급여 평균": invalid identifier HAVING의 조건에 별칭을 사용하였기 때문

--------------------------------------------------------------------------------
--수업중 실습 
--1.매니저 별, 부하직원의 수를 구하고, 많은 순으로 정렬
SELECT 
       (count(e.MGR)) as "부하직원의 수"
     , e.MGR          as "매니저"
  FROM emp e 
 WHERE e.MGR IS NOT NULL
 GROUP BY e.MGR
 ORDER BY (count(e.MGR)) desc
;
--2.부서별 인원을 구하고, 인원수 많은 순으로 정렬
SELECT e.deptno        as "부서번호"
     , count(e.deptno) as "사람 수"
  FROM emp e
 where deptno IS NOT NULL
 GROUP BY e.deptno
 ORDER By "사람 수" desc
;

--3.직무별 급여평균을 구하고, 급여평균 높은 순으로 정렬
SELECT nvl(e.JOB||'','직무미지정') as "직무"
      , TO_CHAR(AVG(e.sal),'9,999') as "직무별 급여평균"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY AVG(e.sal) desc
;
--4.직무별 급여의 총합을 구하고, 높은 순으로 정렬
SELECT nvl(e.JOB||'','직무미지정') as "직무"
      , TO_CHAR(SUM(e.sal),'9,999') as "직무별 급여총합"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY SUM(e.sal) desc
;

nvl(e.JOB||'','직무미지정');
--5.급여의 앞단위가 1000이하,1000,2000,3000,5000별로 인원수를 구하시오.
--  급여 단위 오름차순 정렬
--a)급여 단위를 어떻게 구할 것인가? TRUNC() 활용
SELECT e.EMPNO
     , e.ENAME
     , TRUNC(e.SAL, -3) as "급여단위"
  FROM emp e
;
--b)TRUNC로 언어낸 급여단위를 COUNT하면 인원수를 구할 수 있겠다.
SELECT TRUNC(e.SAL, -3) as "급여단위" 
     , COUNT(TRUNC(e.SAL, -3))
  FROM emp e
 GROUP BY TRUNC(e.SAL,-3)
 order by (TRUNC(e.sal,-3)) desc
;

--c)급여 단위가 1000미만인 경우 0으로 출력되는 것을 변경
-- : 범위 연산이 필요해보임 ===> CASE 구문 선택
SELECT CASE WHEN TRUNC(e.SAL, -3) <1000 THEN '1000 미만'
            ELSE TRUNC(e.SAL, -3) || ''
       END AS "급여단위"
     , COUNT(TRUNC(e.SAL, -3)) as "인원 명"
  FROM emp e
 GROUP BY TRUNC(e.SAL,-3)
 order by (TRUNC(e.sal,-3)) asc
;
-------------------------------------------------------------------------------
--5번을 다른 함수로 풀이
--a)sal 칼럼에 왼쪽으로 패딩을 붙여서 0을 채움
SELECT e.EMPNO
     , e.ENAME
     , LPAD(e.SAL, 4,'0')
  FROM emp e
;
--b)맨 앞의 글자를 잘라낸다. ==>단위를 구함
SELECT 
      SUBSTR(LPAD(e.SAL, 4,'0'),1,1) "급여단위"
     , COUNT(*) "인원(명)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4,'0'),1,1)
;

--c)

--d)1000단위로 출력 형태 변경
SELECT CASE WHEN 
      SUBSTR(LPAD(e.SAL, 4,'0'),1,1) = 0 THEN '1000미만'
      ELSE TO_CHAR(SUBSTR(LPAD(e.SAL, 4,'0'),1,1)*1000)
      END as "급여단위"
     , COUNT(*) "인원(명)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4,'0'),1,1)
 order by SUBSTR(LPAD(e.SAL, 4,'0'),1,1) desc
;


   WHEN e.SAL >3000 AND e.SAL <=9999 THEN 5
             ELSE 0;
SELECT (TRUNC(e.sal,-3)) as "단위"
     , COUNT(e.sal)
  FROM emp e
 GROUP BY (TRUNC(e.sal,-3))
 order by (TRUNC(e.sal,-3)) desc
;

--6.직무별 급여 합의 단위를 구하고, 급여 합의 단위가 큰 순으로 정렬
SELECT nvl(e.JOB||'','직무미지정') as "직무"
     , TRUNC(SUM(e.SAL),-3) as "급여 단위"
  FROM emp e
GROUP BY e.JoB
ORDER BY SUM(e.SAL) desc
;




--7직무별 급여 평균이하인 경우를 구하고 평균이 높은 순으로 정렬
SELECT nvl(e.JOB||'','직무미지정') as "직무"
    , TO_CHAR(AVG(e.sal),'9,999') as "직무별 급여평균"
  FROM emp e
 GROUP BY e.JOB
HAVING AVG(e.sal)<=2000
 ORDER BY AVG(e.sal) desc
;
--8.년도 별 입사 인원을 구하시오
SELECT SUBSTR(e.HIREDATE,1,2) as "입사년도"
     , count(e.empno) as "입사 인원"
  FROM emp e
 GROUP BY SUBSTR(e.HIREDATE,1,2)
;

SELECT TO_CHAR(e.HIREDATE, 'YYYY') as "입사년도"
     , COUNT(*) as "인원(명)"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY')
 ORDER BY TO_CHAR(e.HIREDATE, 'YYYY')
;
--9 년도별 월별 입사 인원을 구하시오
SELECT SUBSTR(e.HIREDATE,1,2) as "입사년도"
     , SUBSTR(e.HIREDATE,4,2) as "입사월"
     , count(e.empno) as "입사 인원"
  FROM emp e
 GROUP BY SUBSTR(e.HIREDATE,1,2), SUBSTR(e.HIREDATE,4,2)
order by SUBSTR(e.HIREDATE,1,2), SUBSTR(e.HIREDATE,4,2) asc
;
--

SELECT TO_CHAR(e.HIREDATE, 'YYYY') as "입사년도"
     , TO_CHAR(e.HIREDATE, 'MM') as "입사 월"
     , COUNT(*) as "인원(명)"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY'),  TO_CHAR(e.HIREDATE, 'MM')
 ORDER BY TO_CHAR(e.HIREDATE, 'YYYY'),  TO_CHAR(e.HIREDATE, 'MM')
;


-----------------------------------------------------------------------
--년도별, 월별 입사 인원을 가로 표 형태로 출력
--a)년도 추출, 월 추출
 TO_CHAR(e.HIREDATE, 'YYYY'),  TO_CHAR(e.HIREDATE, 'MM')
 
--b)hiredate에서 월을 추출한 값이 01이 나오면 그떄의 숫자만 1월에서 카운트
-- 이 과정을 12월까지 반복

SELECT 
       TO_CHAR(e.HIREDATE, 'YYYY') as "입사년도" --그룹화 기준 컬럼
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'01',1) as "1월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'02',1) as "2월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'03',1) as "3월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'04',1) as "4월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'05',1) as "5월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'06',1) as "6월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'07',1) as "7월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'08',1) as "8월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'09',1) as "9월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'10',1) as "10월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'11',1) as "11월"
     , decode(TO_CHAR(e.HIREDATE, 'MM'),'12',1) as "12월"
  FROM emp e
 ORDER BY "입사년도" 
;

--c) 입사 년도 기준으로 COUNT 함수 결과를 그룹화
SELECT 
       TO_CHAR(e.HIREDATE, 'YYYY') as "입사년도" --그룹화 기준 컬럼
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'01',1)) as "1월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'02',1)) as "2월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'03',1)) as "3월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'04',1)) as "4월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'05',1)) as "5월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'06',1)) as "6월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'07',1)) as "7월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'08',1)) as "8월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'09',1)) as "9월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'10',1)) as "10월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'11',1)) as "11월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'12',1)) as "12월"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YYYY')
 ORDER BY "입사년도" 
;
SELECT 
     '인원(명)' as "입사월" --그룹화 기준 컬럼
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'01',1)) as "1월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'02',1)) as "2월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'03',1)) as "3월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'04',1)) as "4월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'05',1)) as "5월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'06',1)) as "6월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'07',1)) as "7월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'08',1)) as "8월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'09',1)) as "9월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'10',1)) as "10월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'11',1)) as "11월"
     , COUNT(decode(TO_CHAR(e.HIREDATE, 'MM'),'12',1)) as "12월"
  FROM emp e
;

----------7. 조인과 서브쿼리
--(1)조인개요 : JOIN
--하나 이상의 테이블을 논리적으로 묶어서 하나의 테이블 인 것 처럼 다루는 기술
--FROM 절에 조인에 사용할 테이블 이름을 나열

--문제)직원의 소속 부서 번호가 아닌, 부서 명을 알고 싶다.
--a) FROM 절에 emp,dept 두 테이블을 나열 ==>조인 발생 ==>카디션 곱 ==>두 테이블의 모든 조합
SELECT e.ENAME
     , d.DNAME
  FROM emp e
     , dept d
;
--b) 조건이 추가 되어야 직원의 소속부서만 정확하게 연결할 수 있음

SELECT e.ENAME
     , d.DNAME
  FROM emp e
     , dept d
where e.deptno = d.deptno --오라클의 전통적인 조인 조건 작성 기법
;
--조인 조건이 적절히 추가되어 12행의 의미있는 데이터만 남김
SELECT e.ENAME
     , d.DNAME
  FROM emp e JOIN dept d ON (e.DEPTNO = D.DEPTNO)
             --최근 다른 DBMS 들이 사용하고 있는 기법
             -- 오라클에서 지원함
;
--문제) 위의 결과에서 ACCOUNTING 부서의 직원만 알고 싶다.
--     조인 조건과 일반 조건이 같이 사용될 수 있다.
SELECT e.ENAME
     , d.DNAME
  FROM emp e
     , dept d
where e.deptno = d.deptno --조인 조건
  AND d.DNAME = 'ACCOUNTING' --일반 조건
;

----2)조인 : 카티션 곱
--          조인 대상 테이블의 데이터를 가능한 모든 조합으로 엮는 것
--          조인 조건 누락시 발생
--          9i 버전 이후 CROSS JOIN 키워드 지원
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e CROSS JOIN dept d
             CROSS JOIN salgrade s
;
--emp 13 x dept 4 x salgrade 5 = 260행
----3) EQUI JOIN : 조인의 가장 기본 형태
--                 서로 다른 테이블의 공통 컬럼을 '=' 로 연결
--                 공통 컬럼 (join attribute)라고 부름

----- 1. 오라클 전통 적인 WHERE 에 조인 조건을 걸어주는 방법
SELECT E.ENAME
     , D.DNAME
 FROM emp e
     , dept d
 WHERE e.DEPTNO = d.DEPTNO --오라클의 전통적인 조인 조건 작성 기법
 ORDER BY d.DEPTNO
;

----- 2. NATURAL JOIN 키워드로 자동 조인
SELECT e.ENAME
     , d.DNAME
  FROM emp e NATURAL JOIN dept d --조인 공통 컬럼 명시가 필요 없음
;

----- 3. JOIN ~ USING 키워드로 조인
SELECT e.ENAME
     , d.DNAME
  FROM emp e JOIN dept d USING (deptno) -- USING 뒤에 공통 컬럼을 별칭 없이 명시
;

----- 4. JOIN ~ ON 키워드로 조인
SELECT e.ENAME
     , d.DNAME
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 -- ON 뒤에 조인 조건구문을 명시  



--(2)서브쿼리





