;;; helm-smex.el --- Helm interface for smex -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Peter Vasil

;; Author: Peter Vasil <mail@petervasil.net>
;; Version: 0.1
;; Package-Requires: ((emacs "24") (smex "3.0") (helm "1.7.7))
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package provides the helm interface for smex.
;;
;; Example config:
;;
;;   (require 'helm-smex)
;;   (global-set-key [remap execute-extended-command] #'helm-smex)
;;
;; Sources:
;; https://github.com/hatschipuh/helm-better-defaults
;; https://github.com/wasamasa/dotemacs/blob/master/unpublished/helm-smex.el

;;; Code:

(require 'smex)
(require 'helm)
(require 'helm-elisp)
(require 'helm-source)

(defun helm-smex--init ()
  (unless smex-initialized-p
    (smex-initialize))
  (and smex-auto-update
       (smex-detect-new-commands)
       (smex-update)))

(defun helm-smex--execute-command (command)
  (let ((prefix-arg current-prefix-arg))
    (unwind-protect
        (command-execute command 'record)
      (smex-rank command))))

(defun helm-smex--persistent-action (candidate)
  (helm-elisp--persistent-help
   candidate 'helm-describe-function))

(defclass helm-smex-source (helm-source-sync)
  ((init :initform 'helm-smex--init)
   (candidates :initform 'smex-ido-cache)
   (match :initform 'helm-fuzzy-match)
   (action :initform 'helm-smex--execute-command)
   (coerce :initform 'intern)
   (persistent-action
    :initform helm-smex--persistent-action)
   (persistent-help :initform "Describe command")))

;;;###autoload
(defun helm-smex ()
  (interactive)
  (let ((helm--mode-line-display-prefarg t))
    (helm :buffer "*helm-smex*"
          :sources (helm-make-source "Smex" helm-smex-source))))

(provide 'helm-smex)

;;; helm-smex.el ends here
