;;; zenrei --- zenrei client for Emacs

;; Copyright (C) 2019- blue0513

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

;; Author: blue0513
;; URL: https://github.com/blue0513/zenrei
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1") (posframe "0.4.3"))

;;; Commentary:

;; Edit your init.el
;;
;; (require 'zenrei)
;;

;;; Code:

(require 'posframe)

(defvar zenrei-search-query "https://zenrei.nyamikan.net/v1/search?q=")
(defvar zenrei-suggest-query "https://zenrei.nyamikan.net/v1/suggest?q=")
(defvar zenrei-synonyms-query "https://zenrei.nyamikan.net/v1/synonym?q=")

(defvar zenrei-buffer-showing nil)
(defvar zenrei-buffer-name "*zenrei-buffer*")
(defvar zenrei-buffer-color "black")

(defun zenrei--generate-result (payload)
  (shell-command-to-string
   (mapconcat #'shell-quote-argument
	      (list "curl" "-s" payload)
	      " ")))

(defun zenrei--format-string (str)
  (shell-command-to-string (concat "echo " str " | " "jq .")))

(defun zenrei-show (str query)
  (let* ((payload (concat query str))
	 (result (zenrei--generate-result payload))
	 (result-string (concat "'" result "'"))
	 (formated-string (zenrei--format-string result-string)))
    (zenrei--show-posframe formated-string)))

(defun zenrei--show (str query)
  (if zenrei-buffer-showing
      (zenrei--delete-posframe)
    (zenrei-show str query)))

(defun zenrei--show-posframe (str)
  (posframe-show
   zenrei-buffer-name
   :string str
   :background-color zenrei-buffer-color
   :position (point)))

(defun zenrei--delete-posframe ()
  (setq zenrei-buffer-showing nil)
  (posframe-delete zenrei-buffer-name))

(defun zenrei-delete ()
  (interactive)
  (zenrei--delete-posframe))

(defun zenrei-search (str)
  (interactive "sString: ")
  (zenrei--show str zenrei-search-query))

(defun zenrei-suggest (str)
  (interactive "sString: ")
  (zenrei--show str zenrei-suggest-query))

(defun zenrei-synonyms (str)
  (interactive "sString: ")
  (zenrei--show str zenrei-synonyms-query))

;; * provide

(provide 'zenrei)

;;; zenrei.el ends here
