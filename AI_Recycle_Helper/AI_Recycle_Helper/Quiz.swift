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
    var usedQuestion:[Int]=[];
    let questions = [
        Question(questionText:"Styrofoam should be placed in your recycling bin/cart." , options: ["True","False"], answers: [1], hasImage: true, hint: "1"),
        Question(questionText: "Batteries and small electronics go in your recycling bin/cart.", options: ["True","False"], answers: [1], hasImage: true,hint: "2"),
        Question(questionText: "Recyclables should be loose and not bagged.", options: ["True","False"], answers: [0], hasImage: true,hint: "3"),
        Question(questionText: "Old garden hoses and electric cords belong in your recycling bin/cart.", options: ["Yes","No"], answers: [0], hasImage: false,hint: "4"),
        Question(questionText: "All metal is recyclable - just put it in your recycling bin/cart at home. ", options: ["True", "False"], answers: [1], hasImage: false,hint: "5"),
        Question(questionText: "Which of the following plastic bottles are recyclable?", options: ["Only shampoo bottle",    "Only laundry detergent",    "Only dish soap",    "Only window cleaner", "All of above"], answers: [4], hasImage: false,hint: "1"),
        Question(questionText: "You should not…", options: ["Place recycling in plastic bags and then putting them in the recycling bin.","Put recyclable items in the general rubbish bin.","Separate food scraps from pizza boxes before recycling."], answers: [0,1,2], hasImage: false,hint: "1"),
        Question(questionText: "Which of these materials can be disposed of in your recycling bin or cart?", options: ["Bug Killer","Batteries","Paint","none of the above"], answers: [3], hasImage: false,hint: "1"),
        Question(questionText: "Do you know what to do with plastic bags?", options: ["To be recycled, they need to go back to retail","Plastic bags can be recycled in my bin/cart"], answers: [0], hasImage: false,hint: "1"),
        Question(questionText: "Paper napkins go in which cart?", options: ["Trash Cart","Recycling Cart"], answers: [0], hasImage: false,hint: "1"),
        Question(questionText: "Polystyrene goes in which cart?", options: ["Trash Cart","Recycling Cart"], answers: [0], hasImage: false,hint: "1"),
        Question(questionText: "Plastic hangers go in which cart?", options: ["Trash cart","Recycling Cart"], answers: [0], hasImage: false,hint: "1"),
        Question(questionText: "Greasy cardboard goes in which cart?", options: ["Trash cart","Recycling Cart"], answers: [0], hasImage: true,hint: "1"),
        Question(questionText: "True or False: Shredded paper can be recycled.", options: ["TRUE","FALSE"], answers: [0], hasImage: true,hint: "1"),
        Question(questionText: "Shampoo and lotion bottles go in which cart?", options: ["Trash Cart","Recycling Cart"], answers: [1], hasImage: true,hint: "1"),
        Question(questionText: "Wrapping paper goes in which cart?", options: ["Trash cart","Recycle cart"], answers: [1], hasImage: true,hint: "1")
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
    
    
    mutating func getQuestion(){
        var nextQuestionNum = Int.random(in: 0..<questions.count)
        while (usedQuestion.contains(nextQuestionNum)){
            nextQuestionNum = Int.random(in: 0..<questions.count)
        }
        self.currentQustionNum = nextQuestionNum
        self.usedQuestion.append(nextQuestionNum)
    }
    
    func numberOfAnsweredQuestion()-> Int{
        return usedQuestion.count
    }
    
    func getHint() -> String{
        return questions[currentQustionNum].hint
    }
    
}
