//
//  ViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Admin on 2018/11/18.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit
enum Theme {
    case Light
    case Dark
    case DarkTranslucent
}
extension UIViewController {
    func applyTheme(withTheme theme:Theme){
        let darkThemeBarTintColor = UIColor.init(red: 255.0/255.0, green: 51.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        let darkThemeTitleColor = UIColor.init(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        

        switch theme {
        case .Light:
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.tintColor = darkThemeBarTintColor
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [
                "NSForegroundColorAttributeName":UIColor.init(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 1.0)
            ]
            self.view.backgroundColor = UIColor.white
            break
            //    case Light:
            //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            //
            //    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
            //    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:255.0/255.0 green:51.0/255.0 blue:102.0/255.0 alpha:1.0]];
            //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:46.0/255.0 green:61.0/255.0 blue:73.0/255.0 alpha:1.0]}];
            //
        //    [self.view setBackgroundColor:[UIColor whiteColor]];
        case .Dark:
            self.view.backgroundColor = UIColor.init(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = UIColor.init(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 1.0)
            // self.edgesForExtendedLayout
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [
                "NSForegroundColorAttributeName":UIColor.white
            ]
            
            //    case Dark:
            //    [self.view setBackgroundColor:[UIColor colorWithRed:46.0/255.0 green:61.0/255.0 blue:73.0/255.0 alpha:1.0]];
            //
            //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
            //    [self.navigationController.navigationBar setTranslucent:YES];
            //    [self.navigationController.view setBackgroundColor:[UIColor colorWithRed:46.0/255.0 green:61.0/255.0 blue:73.0/255.0 alpha:1.0]];
            //    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:46.0/255.0 green:61.0/255.0 blue:73.0/255.0 alpha:1.0]];
            //    [self setEdgesForExtendedLayout:UIRectEdgeNone];
            //
            //    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
            //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
            break
        case .DarkTranslucent:
             self.view.backgroundColor = UIColor.init(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 0.9)
            //    case DarkTranslucent:
            //    [self.view setBackgroundColor:[UIColor colorWithRed:46.0/255.0 green:61.0/255.0 blue:73.0/255.0 alpha:0.9]];
            //
            //    break;
            break
        }
    }





}
