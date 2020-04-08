# Boostcamp
### Boostcamp 2기 iOS 과정 지원 사전 과제
#### 성적 결과분석 프로그램
##### 과제 세부내용
- [BoostCamp 2기 iOS Swift과제](https://docs.google.com/document/d/1bGuLv_8G2PuCF6HBeDVBoco8K5fYe1Ooo4x3mN6DKxY/edit)
- 사용자 홈 디렉터리의 students.json 파일 읽어들여 전체 학생의 평균, 개인별 학점, 수료생을 표시하는 결과를 나타내는 파일(result.txt) 출력
- 세부 조건
  - 전체 평균은 소수점 둘째자리까지만 표시
  - 학점
    - 90점 이상 100점 이하: A
    - 80점 이상 90점 미만: B
    - 70점 이상 80점 미만: C
    - 60점 이상 70점 미만: D
    - 그 외: F
  - 수료기준: 평균 70점 이상의 학생
  - 개인별 학점 및 수료생 명단은 abc 내림차순 정렬
- students.json 파일 내용
```json
[
   {
     "name": "jack",
     "grade": {
       "data_structure": 85,
       "algorithm": 76,
       "database": 42,
       "operating_system": 83
     }
   },
   {
     "name": "jain",
     "grade": {
       "data_structure": 56,
       "algorithm": 65,
       "networking": 68,
       "database": 46,
       "operating_system": 83
     }
   },
   {
     "name": "hana",
     "grade": {
       "data_structure": 86,
       "algorithm": 64,
       "database": 87,
       "operating_system": 96
     }
   },
   {
     "name": "john",
     "grade": {
       "data_structure": 35,
       "networking": 45,
       "database": 78
     }
   },
   {
     "name": "steve",
     "grade": {
       "algorithm": 56,
       "networking": 89,
       "operating_system": 100
     }
   },
   {
     "name": "bill",
     "grade": {
       "data_structure": 87,
       "algorithm": 45,
       "database": 65,
       "operating_system": 78
     }
   }
 ]
```
- 출력결과
```
성적결과표

전체 평균 : 70.24

개인별 학점
bill       : D
hana       : B
jack       : C
jain       : D
john       : F
steve      : B

수료생
hana, jack, steve
```
##### 구현방식
1. students.json 파일을 읽어들여 deserialize한 뒤 Dictionary 타입으로 변환
2. 변환한 값을 **이름 Array**와 **성적 Array**에 각각 값을 할당
3. 각 학생의 성적 합을 구한 뒤 평균 낸 것을 별도의 **평균 Array**에 할당
4. 각 점수 범위에 맞게 학점을 할당하며 출력한 뒤 평균 70점 이상 학생들은 별도로 골라내어 **결과 string**에 따로 출력
5. 출력된 모든 내용을 output이라는 별도의 string 변수에 할당한 뒤 result.txt 파일에 출력

##### 미구현사항
- 개인별 학점 및 수료생 명단은 abc 내림차순 정렬
