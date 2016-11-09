//
//  ViewController.swift
//  Math Chil
//
//  Created by Doãn Tuấn on 11/9/16.
//  Copyright © 2016 doantuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label_Num1: UILabel!
    @IBOutlet weak var label_Num2: UILabel!
    @IBOutlet weak var label_Reult: UILabel!
    @IBOutlet weak var label_equal: UILabel!
    @IBOutlet weak var label_Oprator: UILabel!
    @IBOutlet weak var result1: UIButton!
    @IBOutlet weak var result2: UIButton!
    @IBOutlet weak var result3: UIButton!
    @IBOutlet weak var label_Correct: UILabel!
    @IBOutlet weak var label_Wrong: UILabel!
    @IBOutlet weak var label_Time: UILabel!
    var G_time :Timer!
    var G_second: Int!
    var G_check :Int!
    var G_conrrect :Int = 0
    var G_wrong :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label_Correct.text = "0"
        label_Wrong.text = "0"
        updateMath()
        updateTime()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // time
    
    func updateTime(){
        G_second = 60
        label_Time.text = String(G_second)
        G_time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.time_Count), userInfo: nil, repeats: true)
    }
    
    func time_Count(){
        G_second = G_second - 1
        label_Time.text = String(G_second)
        if G_second == 0{
            G_time.invalidate() // Stop timer
            gameOver(corr: G_conrrect, worr: G_wrong)
        }
    }
    // GAME OVERRR
    
    func gameOver(corr: Int, worr: Int ){
        let alertController = UIAlertController(title: "Game Over", message: "You have \(corr) Correct and \(worr) Wrong Answer", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
 // update
    func updateMath(){
        let getR = getRandomNumber()
        
        label_Num1.text = String(getR.num1)
        label_Num2.text = String(getR.num2)
        label_Reult.text = "?"
        let  res = Cal(check: getR.checkOperator,num1: getR.num1,num2: getR.num2)
        setResult(index: getR.indResult, result: res)
        G_check = getR.indResult
        label_Correct.text = String(G_conrrect)
        label_Wrong.text = String(G_wrong)

    }
    
    @IBAction func button_Result1(_ sender: Any) {
        if G_check == 0{
            G_conrrect += 1
        }else{
            G_wrong += 1

        }
        updateMath()
    }
  
    @IBAction func button_Result2(_ sender: Any) {
        if G_check == 1 {
            G_conrrect += 1
        }else{
            G_wrong += 1
        }
        updateMath()
    }
    
    @IBAction func button_Result3(_ sender: Any) {
        if G_check == 2{
            G_conrrect += 1
        }else{
            G_wrong += 1
        }
        updateMath()
    }
    
    
    
    
    // Caculator result and random for wrong answer
    func Cal(check: Int,num1: Int, num2: Int) -> Int{
        
        if check == 0
        {
            label_Oprator.text = "+"
            var r1:Int!
            var r2:Int!
            repeat{
                
                r1 = Int(arc4random_uniform(20))
                r2 = Int(arc4random_uniform(20))
                
            }while r2 == (num1+num2) && r1 == (num1+num2)
            
            setIndexResult(index: check, res1: r1, res2: r2)
            return num1 + num2
        }
        else
        {
            if check == 1
            {
                    label_Oprator.text = "-"
                var r1:Int!
                var r2:Int!
                repeat{
                    
                    
                    r2 = Int(arc4random_uniform(10))
                    r1 = Int(arc4random_uniform(10))
                    
                }while r2 == (num1-num2) && r1 == (num1-num2)
                
                setIndexResult(index: check, res1: r1, res2: r2)
                return num1-num2
            }
            else
            {
                label_Oprator.text = "x"
                var r1:Int!
                var r2:Int!
                repeat{
                    
                    r1 = Int(arc4random_uniform(100))
                    r2 = Int(arc4random_uniform(100))
                    
                }while r2 == (num1*num2) && r1 == (num1*num2)
                
                setIndexResult(index: check, res1: r1, res2: r2)
                return num1*num2
            }
        }
    }
    // set values for wrong answers
    func setIndexResult(index :Int, res1 :Int, res2: Int){
        if index == 0 {
            result3.setTitle(String(res2), for: UIControlState.normal)
            result2.setTitle(String(res1), for: UIControlState.normal)
        }else{
            if index == 1 {
                result1.setTitle(String(res2), for: UIControlState.normal)
                result3.setTitle(String(res1), for: UIControlState.normal)
            }else{
                if index == 2 {
                    result1.setTitle(String(res2), for: UIControlState.normal)
                    result2.setTitle(String(res1), for: UIControlState.normal)
                }
            
            }
        }
    }
    // set values true/ random answers
    func setResult(index: Int, result :Int){
        
        if index == 0{
            result1.setTitle(String(result), for: UIControlState.normal)
        }
        else{
            if index == 1{
                result2.setTitle(String(result), for: UIControlState.normal)
            }
            else{
                result3.setTitle(String(result), for: UIControlState.normal)
            }
        }
    }
    // get random two numbers and index of result button and operator
    func getRandomNumber() -> (num1: Int,num2: Int,checkOperator: Int,indResult: Int){
        var num1 :Int = Int(arc4random_uniform(9)) + 1
        
        var num2 :Int = Int(arc4random_uniform(9)) + 1
        
        if num1 < num2 {
           swap(&num1,&num2)
        }
        
        let checkOpr :Int = Int(arc4random_uniform(3))
        
        let indResult :Int = Int(arc4random_uniform(3))
        
        return (num1,num2,checkOpr,indResult)
        
    }

    

}

