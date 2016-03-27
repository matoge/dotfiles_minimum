;; font setting
(if (mac?)
(progn
(set-face-attribute 'default nil
		    :family "Ricty Diminished"
		    :height 140)
(set-fontset-font "fontset-default"
		  'japanese-jisx0208
		  '("Ricty Diminished" . "iso10646-1"))
(set-fontset-font "fontset-default"
		  'katakana-jisx0201
		  '("Ricty Diminished" . "iso10646-1"))
(setq face-font-rescale-alist
      '((".*Ricty-bold.*" . 1.0)
	(".*Ricty-medium.*" . 1.0)
	(".*HiraKakuProN-W6.*" . 1.2)
	(".*Osaka-medium.*" . 1.2)
	("-cdac$" . 1.4)))
)
(add-to-list 'default-frame-alist '(font . "ricty-16"))
)
