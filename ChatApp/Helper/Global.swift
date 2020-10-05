//
//  Global.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/30/20.
//

import Foundation
//Convert date to timestamp
func convertToDateFromTimestamp (timestamp: Double) -> String {
  let date = Date(timeIntervalSince1970: timestamp / 1000)
  let dateFormatter = DateFormatter()
  dateFormatter.locale = NSLocale.current
  dateFormatter.dateFormat = "MMM dd, HH:mm"
  return dateFormatter.string(from: date)
}

// White space validation.
func isTextEmpty(text:String) -> Bool
{
    if (text.trimmingCharacters(in: .whitespaces).isEmpty)
    {
        return true

    }else{
        return false
    }
}
