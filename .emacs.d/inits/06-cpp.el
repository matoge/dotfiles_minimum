;; ---- cc-mode setting ----
(require 'cc-mode)

;; c-mode-common-hook は C/C++ の設定
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-default-style "k&r") ;; カーニハン・リッチースタイル
            (setq indent-tabs-mode nil)  ;; タブは利用しない
            (setq c-basic-offset 2)      ;; indent は 2 スペース
            (define-key c++-mode-map (kbd "C-c b") 'smart-compile)
            (setq ac-sources (append ac-sources '(ac-source-c-headers)))
            ))

;; ---- cpp mode setting ----
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(require 'flycheck)

;; ---- fly checker sett>ing ---
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook      'irony-mode)

(defmacro flycheck-define-clike-checker (name command modes)
  `(flycheck-define-checker ,(intern (format "%s" name))
     ,(format "A %s checker using %s" name (car command))
     :command (,@command source-inplace)
     :error-patterns
     ((warning line-start (file-name) ":" line ":" column ": 警告:" (message) line-end)
      (error line-start (file-name) ":" line ":" column ": エラー:" (message) line-end))
     :modes ',modes))
(flycheck-define-clike-checker c-gcc-ja
             ("gcc" "-fsyntax-only" "-Wall" "-Wextra")
             c-mode)
(add-to-list 'flycheck-checkers 'c-gcc-ja)
(flycheck-define-clike-checker c++-g++-ja
             ("g++" "-fsyntax-only" "-Wall" "-Wextra" "-std=c++11")
             c++-mode)
(add-to-list 'flycheck-checkers 'c++-g++-ja)

;; -- refactor--
(require 'srefactor)
(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)

(require 'auto-complete-c-headers)

(custom-set-variables '(achead:include-directories (list "." "/usr/include" "/usr/local/include" "/usr/include/c++/4.2.1/")))

(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/elpa/auto-complete-clang-async-20130526.814/clang-complete")
  (setq ac-sources (append ac-sources '(ac-source-clang-async)))
  (ac-clang-launch-completion-process))

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(my-ac-config)

(require 'function-args)
(fa-config-default)

(define-key function-args-mode-map (kbd "M-o") nil)
(define-key c-mode-map (kbd "C-M-:") 'moo-complete)
(define-key c++-mode-map (kbd "C-M-:") 'moo-complete)

(custom-set-faces
 '(fa-face-hint ((t (:background "#3f3f3f" :foreground "#ffffff"))))
 '(fa-face-hint-bold ((t (:background "#3f3f3f" :weight bold))))
 '(fa-face-semi ((t (:background "#3f3f3f" :foreground "#ffffff" :weight bold))))
 '(fa-face-type ((t (:inherit (quote font-lock-type-face) :background "#3f3f3f"))))
 '(fa-face-type-bold ((t (:inherit (quote font-lock-type-face) :background "#999999" :bold t)))))


(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

;; use helm
(setq ggtags-completing-read-function nil)

;; use eldoc
(setq-local eldoc-documentation-function #'ggtags-eldoc-function)

;; imenu
(setq-local imenu-create-index-function #'ggtags-build-imenu-index)

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;; (use-package flycheck
;;   :config
;;   (progn
;;     (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
;;     )
;;   )

;; (use-package cmake-ide
;;   :bind
;;   (("<f9>" . cmake-ide-compile))
;;   :config
;;   (progn
;;     (setq 
;;      ; rdm & rcコマンドへのパス。コマンドはRTagsのインストール・ディレクトリ下。
;;      cmake-ide-rdm-executable "path_to_rdm"
;;      cmake-ide-rc-executable  "path_to_rc"
;;      )
;;     )
;;   )

;; (use-package rtags
;;   :config
;;   (progn
;;     (rtags-enable-standard-keybindings c-mode-base-map)
;;     ; 関数cmake-ide-setupを呼ぶのはrtagsをrequireしてから。
;;     (cmake-ide-setup)
;;     )
;;   )

(defun my-irony-mode-hook ()
  (define-key irony-mode-map
    [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map
    [remap complete-symbol]
    'irony-completion-at-point-async)
  )

(use-package irony
  :config
  (progn
    ; ironyのビルド&インストール時にCMAKE_INSTALL_PREFIXで指定したディレクトリへのパス。
    (setq irony-server-install-prefix "where_to_install_irony")
    (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
    (add-hook 'irony-mode-hook 'my-irony-mode-hook)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    (add-hook 'irony-mode-hook 'irony-eldoc)
    (add-to-list 'company-backends 'company-irony)
    )
  )
