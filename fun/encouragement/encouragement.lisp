;;;; encouragement.lisp

(in-package #:encouragement)

(defvar *words-of-encouragement*
  (list "Let the hacking commence!"
	"Hacks and glory await!"
	"Hack and be merry!"
	"Your hacking starts... NOW!"
	"May the source be with you!"
	"Take this REPL, brother, and may it serve you well."
	"Lemonodor-fame is but a hack away!"
	(concat (string-capitalize (getenv "USER"))
		", this could be the start of a beautiful program..")
	"Scientifically-proven optimal words of hackerish encouragement."))

(defun my/random-elt (list)
  "Return a random element from a list."
  (elt list (random (length list))))

(defun random-encouragement ()
  "Return a random string of hackerish encouragement."
  (my/random-elt *words-of-encouragement*))

(defcommand stump-encouragement () ()
  "Print a random string of hackerish encouragement."
  (message "~a" (random-encouragement)))
