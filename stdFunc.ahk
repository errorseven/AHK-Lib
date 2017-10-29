/*
         __  _____  ___     ___                 _   _                 
        / _\/__   \/   \   / __\   _ _ __   ___| |_(_) ___  _ __  ___ 
        \ \   / /\/ /\ /  / _\| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
        _\ \ / / / /_//  / /  | |_| | | | | (__| |_| | (_) | | | \__ \
        \__/ \/ /___,'   \/    \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
         Coded by errorseven @ 6-4-17                       v1.0                                                          

                 A useful collection of Standard Functions!
*/


Bin(x) {
    /*
        Convert an integer number to a binary string. 
        
        Return: binary str
        
        x -> int 
        
        example: bin(5) -> 0b101
                 bin(-2398892) -> -0b1001001001101010101100
    */
    
    if (x < 0)
        neg := True, x := abs(x)
       
    While(x != 0) {
        z := Mod(x, 2) z
        x := x // 2
    }
    
    return (neg?"-":_) "0b" ltrim(z, "0")


}

Hex(x) {
    /*
        Convert an integer number to a hexcidecimal string. 
        
        Return: hexcidecimal str
        
        x -> int 
        
        example: hex(22) -> 0x16
    */ 
    if (x < 0)
        neg := True, x := abs(x)
        
    return (neg?"-":_) format("0x{:x}", x)
    
}

Max(arr, index:=0) {
    /* 
        Returns Maximum value or index of the values contained in an array
        
        arr    ->   object
        index  ->   bool
        
        Examples: max([3, 2, 1], 1) ; -> 1
    */
    
    if !(IsObject(arr))
        return
    
    for e, v in arr {
        if (e == 1)
            cur:=Max:=v,key:=e
        else {
            max := v > Max ? v : Max
            key := v > Max ? e : key
        } 
    }
    
    return (index ? key : max)
}

Min(arr, index:=0) {
    /* 
        Returns Minimum value or index of the values contained in an array
        
        arr    ->   object
        index  ->   bool
        
        Examples: min([3, 2, 1], 1) ; -> 3
    */
    
    if !(IsObject(arr))
        return
    
    for e, v in arr {
        if (e == 1)
            cur:=min:=v,key:=e
        else {
            min := v < min ? v : min
            key := v < min ? e : key
        } 
    }
    
    return (index ? key : min)
}

Oct(x) {
    /*
        Convert an integer number to a octal string. 
        
        Return: octal str
        
        x -> int 
        
        example: oct(23) -> 0o27
    */ 
    if (x < 0)
        neg := True, x := abs(x)
     
    num := power := 0
 
    while (x > 0) {
        num += 10 ** power * (Mod(x, 8))
        x //= 8, power++
    }
    return (neg?"-":_) "0o" num
}

Random(x:=0, y:=9) {
    /*    
        Use Random Command documentation to interpret options.
        
        Examples: 
            var := Random()          ; --> var == 0 ... 9
            var := Random(100)       ; --> var == 0 ... 100
            var := Random(10, 50)    ; --> var == 10 ... 50
    */
    if(x > 0 && x > y)
        y:=x, x:=0
        
    o := ""
    Random, o, x, y
    return o
}

Range(start:="", stop:="", step:=1) {
    /* 
        Creates an array containing arithmetic progressions. It is most often 
        used in for loops. The arguments must be plain integers. If the step 
        argument is omitted, it defaults to 1. If the start argument is omitted,
        it defaults to 0.
        
        Return: Array
        
        start -> int
        stop  -> int
        step  -> int
        
        example: range(5) -> [0, 1, 2, 3, 4] || range(0, 7, 2) -> [0, 2, 4, 6]
    */

    r := []
    if (start == "")
        return 
        
    if (stop == "")
        stop:=start,start:=0
    
    if (step == 0) 
        return r
    
    while((step < 0 ? start >= stop : start <= stop))
        r.push(start), start += step
    
/*    
    if (step < 0) {
        loop {
            r.push(start) 
            start += step
            if (start <= stop) 
                break
        }
    }
    else {
        loop {
            r.push(start) 
            start += step
            if (start >= stop) 
                break         
        }
    }
    
    */
    return r
}

Sort(str, options:="", delim:="`n") {
    /*    
        Use Sort Command documentation to interpret options. The deliminator is 
        seperate for ease of implementation.
        
        str     ->   str
        options ->   str
        delim   ->   str
        
        Usage: 
            var := Sort("c d b a",," ") ; --> a b c d
    */
    Sort, str, % options "D" delim
    return str
}

Sum(iter, start:=1) {
    /* 
        Sums start and the items of an iterable from left to right and returns 
        the total. start defaults to 0. The iterable‘s items are normally 
        numbers, and the start value is not allowed to be a string.
        
        Return: int or float
        
        iter -> Array
        start -> int
        
        example: sum([1, 2 ,3]) -> 6 || sum([1.0, 2.0, 3.0], 2) -> 5.00000
    */   
    
    if !(isObject(iter))
        return
    r := 0
    for e,v in iter
        if (e >= start)
            r += v
    return r
}

Zip(x*) {
    /* 
        This function returns an array of arrays, where the i-th array contains 
        the i-th element from each of the argument sequences or iterables. The 
        returned array is truncated in length to the length of the shortest 
        argument sequence. When there are multiple arguments which are all of 
        the same length. 
        
        Return: array
        
        x -> varadic 
        
        example: zip([1, 2, 3], [4, 5, 6]) -> [[1, 4], [2, 5], [3, 6]]
    */
        
    z := [], i:=1
        for e,v in x {
            if !(IsObject(v))
                return
            if (e == 1)
                min := v.length()
            else
                min := min > v.length() ? v.length() : min
        }
        loop % min {
            newArr := []
            for e, v in x
                newArr.push(v[i])
            z[i] := newArr, i++
        }
    
    return z
}