(defvar os-type nil)

(cond ((string-match "apple-darwin" system-configuration) ;; Mac
       (setq os-type 'mac))
      ((string-match "linux" system-configuration)        ;; Linux
       (setq os-type 'linux))
      ((string-match "freebsd" system-configuration)      ;; FreeBSD
       (setq os-type 'bsd))
      ((string-match "mingw" system-configuration)        ;; Windows
       (setq os-type 'win)))

(defun mac? ()
  (eq os-type 'mac))

(defun linux? ()
  (eq os-type 'linux))

(defun bsd? ()
  (eq os-type 'freebsd))

(defun win? ()
  (eq os-type 'win))


;; basic configs
(global-hl-line-mode 1)
(show-paren-mode 1)
(column-number-mode 0)
(transient-mark-mode 1)
(setq confirm-kill-emacs 'y-or-n-p)
(setq gc-cons-threshold (* 10 gc-cons-threshold))
(setq history-length 1000)
(defalias 'yes-or-no-p 'y-or-n-p)
(display-time-mode 1)
(display-battery-mode 0)

(global-linum-mode t)

(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; encodings
(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
;;(set-keyboard-coding-system 'sjis-mac)
(set-keyboard-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'sjis-mac)


(setq-default buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
