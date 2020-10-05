//
//  Routes.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import Foundation
import UIKit

class Routes {
    
    //MARK: STORYBOARD INITIATION
    static private var  mainBoard = UIStoryboard(name: "Main", bundle: nil)
    
    //MARK: VIEWCONTROLLER INITIATION
    
    static var chatViewController: ChatViewController  {
        let controller = ChatViewController()
        return controller
    }
}


