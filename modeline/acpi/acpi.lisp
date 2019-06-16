;;;; acpi.lisp

(in-package #:acpi)

(defvar *acpi-refresh-time* 30
  "Time in seconds between updates of acpi information.")

(defvar *red* 25
  "Percentage at which the acpi information turns red.")

(defvar *yellow* 50
  "Percentage at which the acpi information turns yellow.")

(defvar *green* 75
  "Percentage at which the acpi information turns green.")

(defvar *disappear* 96
  "Percentage at which the acpi information disappears from the modeline.")

(defun acpi ()
  (let* ((bat (run-shell-command "acpi" t))
	 (bat (ppcre:scan-to-strings "[0-9]+%" bat))
	 (int (parse-integer bat :junk-allowed t)))
    (cond ((and (> *disappear* int) (<= *green* int)) bat)
	  ((and (> *green* int) (<= *yellow* int)) (concat "^2*" bat))
	  ((and (> *yellow* int) (<= *red* int)) (concat "^3*" bat))
	  ((and (> *red* int)) (concat "^1*" bat))
	  (t ""))))

(defcommand acpi-message () ()
  (let ((bat (battery)))
    (if (string= bat "")
	(message "Charged")
	(message bat))))

;; pinched from battery portable code
(let ((next 0)
      (last-value ""))
  (defun get-acpi (ml)
    (declare (ignore ml))
    (let ((now (get-universal-time)))
      (when (< now next)
	(return-from get-acpi last-value))
      (setf next (+ now *acpi-refresh-time*)))
    (setf last-value (acpi))))

(add-screen-mode-line-formatter #\B #'get-acpi)
