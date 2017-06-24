#include <StdFunc>

class CustomObject extends _str
{
    static _ := "".base.base := CustomObject
}

class _str {

    ; +-+-+-+- PROPERTIES +-+-+-+-
    
    ascii_letters[] {
        get {
            return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
    }
    
    ascii_lowercase[] {
        get {
            return "abcdefghijklmnopqrstuvwxyz"
        }
    }
    
    ascii_uppercase[] {
        get {
            return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
    }
    
    ascii_vowels[] {
        get {
            return "aeiouy"
        }
    }
    
    ascii_consonants[] {
        get {
            return "bcdfghjklmnpqrstvwxyz"
        }
    }
    ; +-+-+-+- Methods +-+-+-+-
    
    capitalize() {
        /* 
           Returns a copy of the string with 
           only its first character capitalized.
        */
        cap := false
        for e,v in this {
            if (cap == false) {
                r .= Format("{1:U}", v)
                cap := true
            }
            else
                r .= v
         }      
        return r
    }
    
    center(width, fillchar:=" ") {
        /* 
           Returns centred in a string of length width.
           Padding is done using the specified fillchar. 
           Default filler is a space.
        */
        pad := round((width - this.length()) // 2)
        loop % pad 
            r .= fillchar
        return r this.toString() r
    }
          
    endswith(suffix, beg:=0, end:="") {
        /* 
           Returns True if the string ends with the specified suffix, 
           otherwise return False optionally restricting the matching 
           with the given indices start and end.
        */
        if (end == "")
            end := this.length()
        for e,v in range(beg, end)
            r .= this[v]
        return suffix == r
    }
    
    expandtabs(tabsize:=8) {
        /* 
           Returns a copy of the string in which tab characters ie. 
           '\t' are expanded using spaces, optionally using the given 
           tabsize (default 8)..
        */
        
        loop % tabsize 
            r .= " "
        return StrReplace(this.toString(), "`t", r)
    }
    
    isupper() {
        for e,v in this
            if ("".ascii_uppercase ~= v)
                return true
        return false
    }
    
    join(seq) {
        /* 
           Returns a string in which the string elements of sequence have been
           joined by string separator.
        */
        
        r := ""
        for e,v in seq {
            if (e == seq.MaxIndex()) {
                r .= v
                break
            }
            r .= v this.toString()
        }         
        return r
    }
    
    ljust(width, fillchar:=" ") {
        /* 
           Returns string padded on the left 
           with zeros to fill width.
        */
        
        pad := abs(width - this.length())
        loop % pad 
            r .= fillchar
        return this.toString() r
    }
    
    rjust(width, fillchar:=" ") {
        /* 
           Returns string padded on the left 
           with zeros to fill width.
        */
        
        pad := abs(width - this.length())
        loop % pad 
            r .= fillchar
        return r this.toString()
    }
    
    slice(start, stop:="", step:=1) {
        /*  
            Return a slice object representing the set of 
            indices specified by range(start, stop, step). 
        */
        
        if (stop == "") 
            stop := start, start := 1
        if (IsObject(this)) {
            for e,v in range(start, stop, step) {
                r .= this[v]
            }
        }
        return r
    } 
    
    swapcase() {
        /* 
           Returns a copy of the string in which all the case-based 
           characters have had their case swapped.
        */
        
        for e,v in this 
            if (this.ascii_letters ~= v)
                r .= (this.ascii_uppercase ~= v ? format("{1:L}", v) 
                                                : format("{1:U}", v))
            else 
                r .= v
        return r
    }
    
    toString() {
        ; Returns string from str() object
       
        for e,v in this
            r .= v
        return r
    }
    
    zfill(width) {
        /* Returns string padded on the left 
           with zeros to fill width.
        */
        
        loop % abs(this.length() - width)
            r .= 0
        return r . this.tostring()    
    }
}

str(prm) {
    /* 
        Initiates String Class Object / Array 
        granting access to a plethora of String Methods
        
        Returns: Class Object
        
        prm -> value or object
        
        example: str("abc") -> ["a", "b", "c"]
                 x := [1, 2, 3, [4, 5]]
                 str(x).ToString() -> [1, 2, 3, [4, 5]]
    */
    
    r := StrSplit(prm)
    return r
    
} 