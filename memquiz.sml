(*
	# Usage
		memquiz [ -g words ] quiz-file

	# How it works:
	1. Show a question
	2. Wait for some input (any input)
	3. Show the answer
	4. goto 1
*)

open TextIO

exception SyntaxError
val r =
 let val rand = Random.rand (234,892)
     fun r i = Random.randRange (0,i-1) rand
 in r end

structure S = Substring
fun parsePair line =
 case S.position " :: " (S.full line)
  of (a,b) => if 0 = S.size b then raise SyntaxError
              else (trim (S.string a), trim (S.string (Substring.triml 4 b)))

fun getInput file =
 let val input = openIn file
     fun r sofar = if endOfStream input then vector sofar
                   else r (parsePair (fgets input)::sofar)
 in r [] end

fun getPair pv = Vector.sub(pv,r (Vector.length pv))
fun ask (q,a) =
 (sep(); puts q; gets(); print "    "; puts a)

;
(let val inFile = hd (CommandLine.arguments())
     val pv = (getInput inFile)
 in while true do ask (getPair pv)
 end
) handle EOF => ()
       | Empty => eputs ("usage: "^(CommandLine.name())^" words-file")
       | SyntaxError => eputs "Invalid syntax in the given words file";
