//
//  QuestionBank.swift
//  AI_Recycle_Helper
//
//  Created by R L on 2022-01-09.
//

import Foundation


struct Quiz{
    var currentQustionNum=0; //index of questions
    var score = 0
    var usedQuestion:[Int];
    let questions = [
        Question(questionText:"Styrofoam should be placed in your recycling bin/cart." , options: ["True","False"], answers: [1], hasImage: false),
        Question(questionText: "Batteries and small electronics go in your recycling bin/cart.", options: ["True","False"], answers: [1], hasImage: false),
        Question(questionText: "Recyclables should be loose and not bagged.", options: ["True","False"], answers: [0], hasImage: false)
    ]
    
    func getTotalQuestionNumber() -> Int{
        return questions.count;
    }
    func getScore() -> Int{
        return score;
    }
    
    mutating func checkAns(userAnswer:[String])->Bool {
        var flag = true;
        for correctAns in questions[currentQustionNum].answers{
            if (userAnswer.contains(questions[currentQustionNum].options[correctAns])){
                self.score += (10/(questions[currentQustionNum].answers.count));
            }else{
                flag = false
            }
        }
        
        return flag
    }
    func getQuestionText() ->String{
        return questions[currentQustionNum].questionText
    }
    
    func getAnswers() ->[Int]{
        return questions[currentQustionNum].answers
    }
    
    func getOptions() -> [String]{
        return questions[currentQustionNum].options
    }
    
    
    mutating func nextQuestion(){
        var nextQuestionNum = Int.random(in: 1..<questions.count)
        while (usedQuestion.contains(nextQuestionNum)){
            nextQuestionNum = Int.random(in: 1..<questions.count)
        }
        self.currentQustionNum = nextQuestionNum
        self.usedQuestion.append(nextQuestionNum)
    }
    
    func numberOfAnsweredQuestion()-> Int{
        return usedQuestion.count
    }
    
}
