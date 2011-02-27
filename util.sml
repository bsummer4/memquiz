exception EOF
open TextIO
fun puts s = (output(stdOut,s); output(stdOut,"\n"); flushOut stdOut)
fun eputs s = (output(stdErr,s); output(stdErr,"\n"); flushOut stdErr)
fun flush() = flushOut stdOut
fun sep () = print "\n==================\n"
val (stderr, stdin) = (stdErr, stdIn)
fun gets() = fgets stdin
and fgets input =
 case inputLine input
  of NONE => raise EOF
   | (SOME l) => if #"\n"=String.sub(l,size l-1)
                 then String.substring(l,0,size l-1)
                 else l

fun trim s =
 let val len = size s
     fun count sofar idx inc =
          if idx<0 orelse idx>=len then len
          else if #" "=String.sub (s,idx)
          then count (sofar+1) (idx+inc) inc
          else sofar
     val (front, back) = (count 0 0 1, count 0 (len-1) ~1)
 in if front = len then ""
    else String.substring (s,front,len-(front+back))
 end
