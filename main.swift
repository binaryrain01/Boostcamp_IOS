//
//  main.swift
//  grade_analyis
//
//  Created by Jinu on 2017. 6. 4..
//  Copyright © 2017년 Jinu. All rights reserved.
//

import Foundation
//let pathtmp = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("students.json")
//print(pathtmp)

/* NAVER Boostcamp 2기 - iOS지원 (학생 이름 알파벳순 정렬은 하지 못했음) */

/* NSHomeDirectory - Mac의 홈 경로 + students.json */
let path = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("students.json")

var names = [String]()
var grades = Array<[String: Int]>()
var gradetemp = [String: Any]()
var gradeavg = [Double]()
var allsum: Double = 0
var mancnt: Int = 0
var tmpnum: Int = 0
var conseq: String = ""
var output: String = ""

/* 설정한 경로에 실제 파일을 데이터로 가져올 수 있는지 조건문으로 확인 */
if let data = try Data(contentsOf: path, options: .alwaysMapped) as Data? {
    do {
        /* json 파일을 Deserialize하여 Any 데이터 형태로 가져옴 */
        let jsonArr =  try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
        // JSONObjectWithData returns AnyObject so the first thing to do is to downcast to dictionary type
        /* json 파일 내 있던 각각의 정보를 for 문을 통해 이름 및 성적을 받아와 각각의 배열에 값을 할당 */
        for json in jsonArr! {
            let jsontemp = json as! [String: Any]
            let name = jsontemp["name"] as! String
            let grade = jsontemp["grade"] as! [String: Int]
            names.append(name)
            grades.append(grade)
            mancnt += 1
        }
        
        /* 각 학생의 성적의 합을 구한 뒤 평균을 낸 것을 평균만 모아놓는 배열에 할당 */
        for grade in grades {
            // access all key / value pairs in dictionary
            var sum: Double = 0
            var cnt: Int = 0
            for (key, value) in grade {
                sum += Double(value)
                cnt += 1
            }
            var manavg: Double = sum/Double(cnt)
            gradeavg.append(manavg)
            allsum += manavg
        }
        
        
        /* 출력 화면 */
        print("성적 결과표\n")
        output += "성적 결과표\n\n"
        print("전체 평균 : " + (NSString(format:"%.2f", allsum/6) as String) + "\n")
        output += "전체 평균 : " + (NSString(format:"%.2f", allsum/6) as String) + "\n\n"
        print("개인별 학점")
        output += "개인별 학점\n"
        /* 각 점수 범위에 맞게 학점 할당하여 출력 */
        while tmpnum < names.count {
            if gradeavg[tmpnum] >= 90 && gradeavg[tmpnum] <= 100 {
                print(names[tmpnum] + "   : A")
                output += names[tmpnum] + "   : A\n"
            }
            else if gradeavg[tmpnum] >= 80 {
                print(names[tmpnum] + "   : B")
                output += names[tmpnum] + "   : B\n"
            }
            else if gradeavg[tmpnum] >= 70 {
                print(names[tmpnum] + "   : C")
                output += names[tmpnum] + "   : C\n"
            }
            else if gradeavg[tmpnum] >= 60 {
                print(names[tmpnum] + "   : D")
                output += names[tmpnum] + "   : D\n"
            }
            else {
                print(names[tmpnum] + "   : F")
                output += names[tmpnum] + "   : F\n"
            }
            tmpnum += 1
        }
        tmpnum = 0
        print("\n수료생")
        output += "\n수료생\n"
        /* 평균이 70점 이상인 학생만 골라내어 따로 결과 String에 출력 */
        while tmpnum < names.count {
            if gradeavg[tmpnum] >= 70 {
                conseq += names[tmpnum] + ", "
            }
            tmpnum += 1
        }
        let range = conseq.index(conseq.endIndex, offsetBy: -2)..<conseq.endIndex
        conseq.removeSubrange(range)

        print(conseq)
        output += conseq

        /* 앞서 시스템 상 출력된 내용을 output이라는 String 변수에 넣은 뒤 result.txt라는 파일에 출력(경로는 /Users/사용자/result.txt) */
        let file = "result.txt" //this is the file. we will write to and read from it
        
        let text = output //just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(file)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
        
    } catch let error {
        print(error.localizedDescription)
    }
}
else {
    print("Invalid filename/path.")
}

