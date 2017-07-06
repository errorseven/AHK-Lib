/*
    __      _                 _          _     ___ _     _           _       
   /__\_  _| |_ ___ _ __   __| | ___  __| |   /___\ |__ (_) ___  ___| |_ ___ 
  /_\ \ \/ / __/ _ \ '_ \ / _` |/ _ \/ _` |  //  // '_ \| |/ _ \/ __| __/ __|
 //__  >  <| ||  __/ | | | (_| |  __/ (_| | / \_//| |_) | |  __/ (__| |_\__ \
 \__/ /_/\_\\__\___|_| |_|\__,_|\___|\__,_| \___/ |_.__// |\___|\___|\__|___/
    Coded by errorseven @ 5-14-17                    |__/      v1.1.3         

Change Log:
----------- 
   v1.1.3 @ 6-4-17
           - Changed Count property to future proof implementation
           
   v1.1.2 @ 6-2-17:
           - Fixed Formating issue
           - Added Documention and Usage examples
           
   v1.1.1 @ 6-2-17:
           - Added default declaration of Options in Sort()
           - Fixed Sort() from returning array with new deliminator
           - Added override StrSplit() to intialize an Extended Object

    v1.1 @ 5-29-17:
           - Added Sort method to ease sorting Arrays/Objects
*/

#include <strObj>

Class _Object extends _str {

    Count[] {
        /* 
        Returns an actual Count of objects contained in Array
        
        Usage:
            Obj := {a:1, b:2, c:3}
            obj.count ; --> 3
        */
        
        get {
            return this.SetCapacity(0)
        }
    }    

    IsLinear[] {
        /*
        Deterimines if an Array is Linear 
        Intended for Internal use, but have at it if you find a use
        */
   
        Get {
            While (A_Index != this.MaxIndex()) 
                If !(this.hasKey(A_Index)) 
                    Return False
            Return True        
        }
    }
    
    Print[] { 
        /* 
        Returns an accurate Str representation of your Object/Array
        
        Usage: 
            obj := [1, 2, 3, {a: 1, b: 2}]
            obj.print ; --> [1, 2, 3, {a:1, b:2}]
        */
        
        Get {
        
            If this.IsCircle()
                Return "Error: Object contains a Circluar Reference"
                
            Linear := this.IsLinear
            
            For k, v in this {
                if (Linear == False) {
                    if (IsObject(v)) 
                       r .= k ":" this[k].print ", "        
                    else {                  
                        r .= k ":"  
                        if v is number 
                            r .= v ", "
                        else 
                            r .= """" v """, " 
                    }            
                } else {
                    if (IsObject(v)) 
                        r .= this[k].print ", "
                    else {          
                        if v is number 
                            r .= v ", "
                        else 
                            r .= """" v """, " 
                    }
                }
            }
            return Linear ? "[" trim(r, ", ") "]" 
                          : "{" trim(r, ", ") "}"
        }
    }

    Reverse[] {
        /*
        Returns a reverse ordered Array/Object
        
        Usage: 
            obj := [1, 2, 3].reverse
            obj.print ; --> [3, 2, 1]
        */
        
        get {
            x := []
            loop % this.count
                x.push(this.pop())
            return x
        }
    }
    
    
    IsCircle(Objs=0) {
        /*
        Function by GeekDude
        Returns True if Object contains a reference to itself
        Intended for internal use, but have at it if you find a use
        */
        
        if !Objs
            Objs := {}
        For Key, Val in this
            if (IsObject(Val)&&(Objs[&Val]||Val.IsCircle((Objs,Objs[&Val]:=1))))
                return 1
        return 0
    }
    
    Contains(x, y:="") {
        /*
        Returns a Str index (True) or False         
        Usage: 
            obj := [1, 3, 2, [5, 4]] 
            obj.contains(4) ; --> [4][2]
        */
        
        If this.IsCircle()
            return 0
    
        For k, v in this {         

            if (v == x)
                return y "[" k "]"

            if (IsObject(v) && v != this) 
                z := this[k].contains(x, y "[" k "]" )
        
            if (z)
                return z
        }

        return 0
    }   

    Sort(options:="", delim:="`n") {
        /*    
        Use Sort Command documentation to interpret options. The deliminator is 
        seperate for ease of implementation.
        
        Usage: 
            obj := [c, d, b, a].sort()
            obj.print ; --> [a, b, c, d]
        */
        
        For e, v in this
            r .= v delim
        Sort, r, % options "D" delim
        return StrSplit(trim(r, delim), delim)
    }
    
}

Class _Array Extends _Object {
    ; Just here to extend functions
}
    
Array(prm*) {
    /* 
       Since prm is already an array of the parameters, just give it a
       new base object and return it. Using this method, _Array.__New()
       is not called and any instance variables are not initialized.
    */
    x := {}
    loop % prm.length()
        x[A_Index] := prm[A_Index]
    x.base := _Array
    return x
} 

Object(prm*) {
    /*
        Create a new object derived from _Object.
    */
    obj := new _Object
    ; For each pair of parameters, store a key-value pair.
    Loop % prm.MaxIndex()//2 
        obj[prm[A_Index*2-1]] := prm[A_Index*2]
    ; Return the new object.
    return obj
}

StrSplit(x, dlm:="", opt:="") {
    /* 
    Use help documentation definition to determine options. This override 
    is here to properly intialize an Extended Object using Object Class.
    
    Usage:
        Obj := StrSplit("abc")
        Obj.print ; --> ["a", "b", "c"]
    */
    
    r := [], o:=""
    StringSplit, o, x, %dlm%, %opt%
    
    loop, %o0% 
        r.push(o%A_index%)
 
    return r
}