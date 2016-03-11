;; buffer setting
(setq recentf-auto-cleanup 'never)
(require 'recentf)

;; open-junk-file
(require 'open-junk-file)
(setq open-junk-file-format "~/work/junk/%Y-%m-%d/%Y-%m-%d-%H-%M-%S.")
(global-set-key (kbd "C-c C-z") 'open-junk-file)

(require 'helm-config)

;; Command+f で helm-for-files
(define-key global-map (kbd "s-f") 'helm-for-files)
;; C-x b で helm-for-files
(define-key global-map (kbd "C-x b") 'helm-for-files)
;; Command+y で anything-show-kill-ring
;; (define-key global-map (kbd "C-y") 'helm-show-kill-ring)
;; Command+r で anything-resume
(define-key global-map (kbd "s-r") 'helm-resume)

(define-key global-map (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "C-c m") 'helm-imenu-anywhere)
(global-set-key (kbd "C-c h") 'helm-imenu)

(require 'magit)
(global-set-key "\C-c\C-s" 'magit-status)

