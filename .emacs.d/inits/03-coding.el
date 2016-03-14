(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/data/snippets/"
	"~/.emacs.d/elpa/yasnippet-20160226.1359/snippets/"))

(global-set-key (kbd "C-c y") 'helm-c-yas-complete)

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x v i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x v n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x v v") 'yas-visit-snippet-file)

(yas-global-mode 1)

;; coding
(define-key global-map (kbd "\C-ci") 'indent-region)

(define-key global-map (kbd "C-c r") 'rgrep)

;; smart-compile
(require 'smart-compile)
(setq compilation-window-height 15) ;; default window height is 15

;; smart compile
(custom-set-variables '(smart-compile-alist '(
  (emacs-lisp-mode    . (emacs-lisp-byte-compile))
  (html-mode          . (browse-url-of-buffer))
  (nxhtml-mode        . (browse-url-of-buffer))
  (html-helper-mode   . (browse-url-of-buffer))
  (octave-mode        . (run-octave))
  ("\\.c\\'"          . "gcc -O2 %f -lm -o %n")
;;  ("\\.c\\'"          . "gcc -O2 %f -lm -o %n && ./%n")
  ("\\.[Cc]+[Pp]*\\'" . "g++ -std=c++14 -O2 %f -lm -o %n && ./%n")
  ("\\.m\\'"          . "gcc -O2 %f -lobjc -lpthread -o %n")
  ("\\.java\\'"       . "javac %f")
  ("\\.php\\'"        . "php -l %f")
  ("\\.f90\\'"        . "gfortran %f -o %n")
  ("\\.[Ff]\\'"       . "gfortran %f -o %n")
  ("\\.cron\\(tab\\)?\\'" . "crontab %f")
  ("\\.tex\\'"        . (tex-file))
  ("\\.texi\\'"       . "makeinfo %f")
  ("\\.mp\\'"         . "mptopdf %f")
  ("\\.pl\\'"         . "perl -cw %f")
  ;; ("\\.rb\\'"         . "ruby -cw %f")
  ("\\.rb\\'"         . "ruby %f")
)))

(require 'auto-complete-config)
(ac-config-default)

(require 'projectile)
(projectile-global-mode)

(require 'helm-projectile)
(helm-projectile-on)

(define-key projectile-mode-map (kbd "C-c ; g") 'helm-projectile-grep)
(define-key projectile-mode-map (kbd "C-c ; f f") 'helm-projectile-find-file)
