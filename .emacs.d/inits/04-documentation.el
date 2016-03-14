(require 'helm-dash)
(define-key global-map (kbd "C-c d") 'helm-dash-at-point)

(defvar helm-dash-required-docsets '() "A list of required helm-dash-docsets")

(setq helm-dash-required-docsets
      '(
	C++
	C
	OpenCV_Python
	OpenCV_C++
	Pandas
	Python_2
	Python_3
	Qt_5
	Emacs_Lisp
	Bash
    ))

(defun gf/helm-dash-install-docsets ()
  "Install required docsets"
  (interactive)
  (dolist (doc (mapcar 'symbol-name helm-dash-required-docsets))
    (when (not (member doc (helm-dash-installed-docsets)))
      (message (format "Installing helm-dash docset '%s'" doc))
      (helm-dash-install-docset doc))))

(defun gf/helm-dash-upgrade-docsets ()
  "Upgrade installed docsets"
  (interactive)
  (dolist (doc (helm-dash-installed-docsets))
      (message (format "Upgrading helm-dash docset '%s'" doc))
      (helm-dash-update-docset doc)))

(defun helm-dash-elisp ()
  (setq-local helm-dash-docsets '("Emacs Lisp")))

(add-hook 'emacs-lisp-mode-hook 'helm-dash-elisp)

(defun helm-dash-c++ ()
  (interactive)
  (setq-local helm-dash-docsets '("C++" "C" "OpenCV C++")))

(add-hook 'c++-mode-hook 'helm-dash-c++)

(defun helm-dash-python ()
  (interactive)
  (setq-local helm-dash-docsets '("Python 2" "Python 3" "OpenCV Python" "Pandas" "Qt 5")))
(add-hook 'python-mode-hook 'helm-dash-python)

(defun helm-dash-shell ()
  (interactive)
  (setq-local helm-dash-docsets '("Bash")))

(add-hook 'sh-mode-hook 'helm-dash-shell)

(setq helm-dash-docsets-path "~/docsets")

(setq helm-dash-common-docsets nil)
