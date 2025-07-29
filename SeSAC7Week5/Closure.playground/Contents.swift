import UIKit

//일급객체

// 클로저 표현식
// 이름 없는 함수를 어떻게 쓸까

//(Int) -> String
func randomNumber(number: Int) -> String {
    let random = Int.random(in: 1...number)
    return "오늘의 행운의 숫자는 \(random)입니다."
}

func todayNumber(result: (Int) -> String) {
    result(300)
}

// 인라인 클로저
todayNumber(result: { (hi: Int) -> String in
    let random = Int.random(in: 1...hi)
    return "오늘의 행운의 숫자는 \(random)입니다."
})

todayNumber(result: { (hi: Int) in
    let random = Int.random(in: 1...hi)
    return "오늘의 행운의 숫자는 \(random)입니다."
})

todayNumber(result: {
    let random = Int.random(in: 1...$0)
    return "오늘의 행운의 숫자는 \(random)입니다."
})

// 트레일링 클로저
todayNumber {
    let random = Int.random(in: 1...$0)
    return "오늘의 행운의 숫자는 \(random)입니다."
}

todayNumber(result: randomNumber(number:))




// () -> Void
func study() {
    print("iOS 개발자를 위해 열공중")
}

let studyHard = {
    print("iOS 개발자를 위해 열공중")
}

// 클로저 헤더 <- in -> 클로저 바디
let studyHard2 = { () -> Void in
    print("iOS 개발자를 위해 열공중")
}

func studyWithMe(study: () -> Void) {
    study()
}

// 인라인 클로저
studyWithMe(study: { () -> Void in
    print("iOS 개발자를 위해 열공중")
})

// 트레일링 클로저
studyWithMe() {
    print("iOS 개발자를 위해 열공중")
}

studyWithMe {
    print("iOS 개발자를 위해 열공중")
}

// 2. 매개변수에 함수를 사용할 수 있다.

// () -> Void
func oddNumber() {
    print("홀수입니다.")
}

// () -> Void
func evenNumber() {
    print("짝수입니다.")
}

func calculateNumber(number: Int, odd: () -> Void, even: () -> Void) {
    return number.isMultiple(of: 2) ? even() : odd()
}

calculateNumber(number: 44, odd: oddNumber, even: evenNumber)

// 클로저 축약 형태
calculateNumber(number: 43) {
        print("짝수입니다.")
} even: {
        print("홀수입니다.")
}



// (String) -> String
func hello(name: String) -> String {
    return "저는 \(name)입니다."
}

// (String) -> String
func hello(username: String) -> String {
    return "저는 \(username)입니다."
}

// () -> Void, () -> ()
func hello() {
    print("안녕하세요")
}

let c: () -> Void = hello

// 함수 표기법으로 함수가 실행된 상태는 아님
let d: (String) -> String = hello(name:)
let e = hello(username:)

d("andev")



//1. 변수나 상수에 함수를 저장할 수 있다.
func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "국민", "신한"]
    
    return bankArray.contains(bank) ? true : false
}

//이 코드는 함수가 실행된 반환값인 Bool이 a에 저장됨
let a = checkBankInformation(bank: "대구")
print(a)

//함수만 상수에 담은 것으로, 실행은 아직 안된 상태
//일급객체는 변수, 상수에 함수 자체를 대입할 수 있다.
let account = checkBankInformation
let b = account("신한")
print(b)


func average(a: Int, b: Int) -> Int {
    return (a + b) / 2
}

let value = average(a: 3, b: 5)
print("평균 \(value)점 입니다.")

let functionType = average
print("이 평균은 \(functionType(20, 40))입니다.")



