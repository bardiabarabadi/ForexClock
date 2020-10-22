//
//  ViewController.swift
//  ForexClock
//
//  Created by Bardia Barabadi on 2020-10-20.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    
    @IBOutlet weak var img_bg_HourOfDay: UIImageView!
    @IBOutlet weak var img_bg_DayOfWeek: UIImageView!
    @IBOutlet weak var img_handle_HourOfDay: UIImageView!
    @IBOutlet weak var img_handle_DayOfWeek: UIImageView!
    @IBOutlet weak var txt_marketIsClosed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //MARK: Set the images
        img_bg_HourOfDay.image = UIImage(named: "Clock_HourOfDay.png")
        img_bg_DayOfWeek.image = UIImage(named: "Clock_DayOfWeek.png")
        
        img_handle_HourOfDay.image = UIImage(named: "Clock_HourOfDay_Handle.png")
        img_handle_DayOfWeek.image = UIImage(named: "Clock_DayOfWeek_Handle.png")
        
        updateCounting()
        scheduleTimerWithInterval()
    }

    
    
    func scheduleTimerWithInterval(){
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
       
    @objc func updateCounting(){
    /*
        let date = Date()
        let calendar = Calendar.current
        let second = calendar.component(.second, from: date)
           
           
        let second_fl = CGFloat(second)
           
        image_hourOfDay.transform = CGAffineTransform(rotationAngle: (second_fl/60)*4*3.145)
    */
        let UTCDate = Date.init()
        
        
        let seconds = Int(UTCDate.timeIntervalSince1970)
        var minuet_UTC = (seconds % 86400) / 60
        var hourOfDay_UTC = (seconds % 86400) / 3600
        var dayOfWeek_UTC = getDayOfWeek(UTCDate)!
        
        
        txt_marketIsClosed.alpha = 0.0
        
        // Check if Market is Closed
        if (dayOfWeek_UTC==0 || dayOfWeek_UTC==2){
            hourOfDay_UTC = 0
            dayOfWeek_UTC = 1
            txt_marketIsClosed.alpha = 1.0
        }
        
        if (hourOfDay_UTC==0){
            hourOfDay_UTC = 24
        }
        
        let rotation_angle_HourOfDay = Float(hourOfDay_UTC) * Float(2*Double.pi/24)
        let rotation_angle_DayOfWeek = (Float(dayOfWeek_UTC) - 2) * Float(2*Double.pi/5) + rotation_angle_HourOfDay/5
        img_handle_HourOfDay.transform = CGAffineTransform (rotationAngle: CGFloat(rotation_angle_HourOfDay))
        img_handle_DayOfWeek.transform = CGAffineTransform (rotationAngle: CGFloat(rotation_angle_DayOfWeek))
        
        
    }

    
    
    func getDayOfWeek(_ todayDate:Date) -> Int? {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
}
