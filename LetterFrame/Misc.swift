//
//  Misc.swift
//  CoreTextWrapperTest
//
//  Created by huse on 11/08/20.
//  Copyright © 2020 huse. All rights reserved.
//

import UIKit


extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
    
    func squareDistance(to point: CGPoint) -> CGFloat {
        
        let xDist = x - point.x
        let yDist = y - point.y
        return (xDist * xDist + yDist * yDist)
        
    }
    
    static func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
    
    static func * (left: CGFloat, right: CGPoint) -> CGPoint {
        return CGPoint(x: right.x * left, y: right.y * left)
    }
    
    
    /**
     * ...
     * a + b
     */
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }

    /**
     * ...
     * a += b
     */
    static func += (left: inout CGPoint, right: CGPoint) {
        left = left + right
    }
    
}





protocol Autosizable : UIView {
     
}

extension Autosizable {

   
    func setupConstrains()
    {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let sv = self.superview {
        
        self.topAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.trailingAnchor).isActive = true

        self.bottomAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
         
    }
    
    
    func setupConstrains(constant: CGFloat)
    {

        self.translatesAutoresizingMaskIntoConstraints = false

        if let sv = self.superview {

        self.topAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
        self.leadingAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.trailingAnchor, constant: -constant).isActive = true

        self.bottomAnchor.constraint(equalTo: sv.safeAreaLayoutGuide.bottomAnchor, constant: -constant).isActive = true
        }

    }
    
}


///https://stackoverflow.com/questions/46690337/display-japanese-text-with-furigana-in-uilabel

extension String {
    func find(pattern: String) -> NSTextCheckingResult? {
        do {
            let re = try NSRegularExpression(pattern: pattern, options: [])
            return re.firstMatch(
                in: self,
                options: [],
                range: NSMakeRange(0, self.utf16.count))
        } catch {
            return nil
        }
    }

    func replace(pattern: String, template: String) -> String {
        do {
            let re = try NSRegularExpression(pattern: pattern, options: [])
            return re.stringByReplacingMatches(
                in: self,
                options: [],
                range: NSMakeRange(0, self.utf16.count),
                withTemplate: template)
        } catch {
            return self
        }
    }
}






class Utility: NSObject {
    class var sharedInstance: Utility {
        struct Singleton {
            static let instance = Utility()
        }
        return Singleton.instance
    }

    func furigana(String:String) -> NSMutableAttributedString {
        let attributed =
            String
                .replace(pattern: "(｜.+?《.+?》)", template: ",$1,")
                .components(separatedBy: ",")
                .map { x -> NSAttributedString in
                    if let pair = x.find(pattern: "｜(.+?)《(.+?)》") {
                        let string = (x as NSString).substring(with: pair.range(at: 1))
                        let ruby = (x as NSString).substring(with: pair.range(at: 2))

                        let annotation = CTRubyAnnotation.create(.center, .auto, 0.5, ruby)
  
                        return NSAttributedString(
                            string: string,
                            attributes: [kCTRubyAnnotationAttributeName as NSAttributedString.Key: annotation])
                    } else {
                        return NSAttributedString(string: x, attributes: nil)
                    }
                }
                .reduce(NSMutableAttributedString()) { $0.append($1); return $0 }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        paragraphStyle.lineSpacing = 12
        attributed.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, (attributed.length)))
        attributed.addAttributes([NSAttributedString.Key.font: UIFont(name: "HiraMinProN-W3", size: 14.0)!, NSAttributedString.Key.verticalGlyphForm: false,],range: NSMakeRange(0, (attributed.length)))

        return attributed
    }

}
