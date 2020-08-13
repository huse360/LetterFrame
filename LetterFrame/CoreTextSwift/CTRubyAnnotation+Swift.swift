import CoreText
import Foundation

extension CTRubyAnnotation {



    static func create (_ alignment: CTRubyAlignment, _ overhang: CTRubyOverhang, _ sizeFactor: CGFloat, _ string: NSString) -> CTRubyAnnotation {
    
        var text: [Unmanaged<CFString>?] = [Unmanaged<CFString>.passRetained(string as CFString) as Unmanaged<CFString>, .none, .none, .none]
        
         return CTRubyAnnotationCreate(
             _ : alignment,
             _ : overhang,
             _ : sizeFactor,
             _ : &text[0])
    }

    static func create (_ alignment: CTRubyAlignment, _ overhang: CTRubyOverhang, _ sizeFactor: CGFloat, _ string: String) -> CTRubyAnnotation {
    
        var text: [Unmanaged<CFString>?] = [Unmanaged<CFString>.passRetained(string as CFString) as Unmanaged<CFString>, .none, .none, .none]
        
         return CTRubyAnnotationCreate(
             _ : alignment,
             _ : overhang,
             _ : sizeFactor,
             _ : &text[0])
    }


    func create (_ alignment: CTRubyAlignment, _ overhang: CTRubyOverhang, _ sizeFactor: CGFloat, _ text: UnsafeMutablePointer<Unmanaged<CFString>?>) -> CTRubyAnnotation {
    
         CTRubyAnnotationCreate(
             _ : alignment,
             _ : overhang,
             _ : sizeFactor,
             _ : text)
    }
    
    
    


    static func createWithAttributes(_ alignment: CTRubyAlignment, _ overhang: CTRubyOverhang, _ position: CTRubyPosition, _ string: CFString, _ attributes: CFDictionary) -> CTRubyAnnotation {
    
        CTRubyAnnotationCreateWithAttributes(_ : alignment, _ : overhang, _ : position, _ : string, _ : attributes)
    
    }
    
    

     
     static func createWithAttributes(alignment: CTRubyAlignment, overhang: CTRubyOverhang, position: CTRubyPosition, string: NSString, attributes: CFDictionary) -> CTRubyAnnotation {
    
        CTRubyAnnotationCreateWithAttributes(_ : alignment, _ : overhang, _ : position, _ : string as CFString, _ : attributes)
    
     }
     

    var copy : CTRubyAnnotation {get {
         CTRubyAnnotationCreateCopy(self)
    }}

    var alignment : CTRubyAlignment {get {
        CTRubyAnnotationGetAlignment(self)
    }}

/**
    @enum       CTRubyOverhang
    @abstract   These constants specify whether, and on which side, ruby text is allowed to overhang adjacent text if it is wider than the base text.

    @constant   kCTRubyOverhangAuto
                The ruby text can overhang adjacent text on both sides.

    @constant   kCTRubyOverhangStart
                The ruby text can overhang the text that proceeds it.

    @constant   kCTRubyOverhangEnd
                The ruby text can overhang the text that follows it.

    @constant   kCTRubyOverhangNone
                The ruby text cannot overhang the proceeding or following text.
*/
    var overhang : CTRubyOverhang { get { CTRubyAnnotationGetOverhang(self) }}
    
    /**
    
    @abstract   Get the size factor of a ruby annotation object.
    */
    var sizeFactor : CGFloat {get {CTRubyAnnotationGetSizeFactor(self)}}
    
    /**
    @function   getTextForPosition
    @abstract   Get the ruby text for a particular position in a ruby annotation.

    @param      position
                The position for which you want to get the ruby text. (i.e.  .before = 0)

    @result     If the "rubyAnnotation" reference and the position are valid, then this
                function will return a CFStringRef for the text. Otherwise it will return NULL.
*/
    func getTextForPosition( _ position: CTRubyPosition = .before) -> CFString? {
        CTRubyAnnotationGetTextForPosition(self, _ : position)
    }
    
    
}
