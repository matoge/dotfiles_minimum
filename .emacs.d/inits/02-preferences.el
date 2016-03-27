;; color-theme
;; Buffer-dependent color themes

(require 'color-theme)
(color-theme-initialize)
;; global default
(color-theme-aliceblue)

;; Color theme buffer local
;; you can set different color-themes on different modes.

(require 'color-theme-buffer-local)
(add-hook 'python-mode-hook
	  (lambda () (color-theme-buffer-local 'color-theme-robin-hood (current-buffer))))

(add-hook 'howm-mode-hook
	  (lambda () (color-theme-buffer-local 'color-theme-rotor (current-buffer))))

(add-hook 'howm-view-summary-mode-hook
	  (lambda () (color-theme-buffer-local 'color-theme-rotor (current-buffer))))


;; font setting
;; (if (mac?)
;; (progn
;; (set-face-attribute 'default nil
;; 		    :family "Ricty Diminished"
;; 		    :height 140)
;; (set-fontset-font "fontset-default"
;; 		  'japanese-jisx0208
;; 		  '("Ricty Diminished" . "iso10646-1"))
;; (set-fontset-font "fontset-default"
;; 		  'katakana-jisx0201
;; 		  '("Ricty Diminished" . "iso10646-1"))
;; (setq face-font-rescale-alist
;;       '((".*Ricty-bold.*" . 1.0)
;; 	(".*Ricty-medium.*" . 1.0)
;; 	(".*HiraKakuProN-W6.*" . 1.2)
;; 	(".*Osaka-medium.*" . 1.2)
;; 	("-cdac$" . 1.4)))
;; )
;; (add-to-list 'default-frame-alist '(font . "ricty-16"))
;; )
