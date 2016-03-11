(add-to-list 'load-path "~/.pyenv/versions/2.7/bin")

;; python-mode用に実行できるプログラムのパスを指定する
(setq exec-path (append exec-path '("~/.pyenv/shims/")))
(setenv "PATH"
	(concat '"~/.pyenv/shims/" (getenv "PATH")))

(add-to-list 'load-path "~/.emacs.d/python-mode")
(require 'python-mode)
(require 'quickrun)
(setq quickrun-timeout-seconds nil)

(define-key python-mode-map (kbd "C-c c") 'quickrun)

;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)

(defun init-python ()
  (pyenv-mode)
  (pyenv-mode-set "my-pyenv")
  )

(add-hook 'python-mode-hook 'init-python)
;; (add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
;; (add-hook 'python-mode-hook 'ac-anaconda-setup)

;; (eval-after-load "company"
;;  '(progn
;;     (add-to-list 'company-backends 'company-anaconda)))

(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

;; (setq ac-modes (remove 'python-mode ac-modes))
;; (debug ac-modes)

;; auto-completeとanaconda-modeの相性が悪いのでpythonの場合はcompanyを使う。
(defadvice auto-complete-mode (around disable-auto-complete-for-python)
  (unless (eq major-mode 'python-mode) ad-do-it))
(ad-activate 'auto-complete-mode)

(require 'flymake-python-pyflakes)

(add-hook 'python-mode-hook
	  '(lambda ()
             (define-key python-mode-map (kbd "C-c b") 'smart-compile)
             (company-mode)
             (anaconda-mode)
             (flymake-python-pyflakes-load)
	     (define-key python-mode-map (kbd "C-c a") 'anzu-query-replace-at-cursor-thing)
	     (define-key python-mode-map (kbd "C-c q") 'anzu-query-replace-regexp)
	     ))

;; (declare-function smartrep-define-key "smartrep")

;;(add-hook 'python-mode-hook 'flycheck-mode)

;;(add-hook 'python-mode-hook 'flymake-find-file-hook)

(define-key global-map (kbd "M-g M-n") 'flymake-goto-next-error)
(define-key global-map (kbd "M-g M-p") 'flymake-goto-prev-error)

;; flymakeとpyflakesを統合する
;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;      ; Make sure it's not a remote buffer or flymake would not work
;;      (when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
;;       (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                          'flymake-create-temp-inplace))
;;              (local-file (file-relative-name
;;                           temp-file
;;                           (file-name-directory buffer-file-name))))
;;         (list "pyflakes" (list local-file)))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))

;; (eval-after-load "flymake-cursor"
;;   '(progn
;;      (fset 'flyc/show-fly-error-at-point-pretty-soon
;; 	   (symbol-function 'flyc/show-fly-error-at-point-pretty-soon-quick))
;;      (fset 'flyc/show-stored-error-now (symbol-function 'flymake-show-and-sit))
;;      ))


;; (require 'popup)
;; (defun my-popup-flymake-display-error ()
;;   (interactive)
;;   (let* ((line-no            (flymake-current-line-no))
;;          (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info
;;                                                            line-no)))
;;          (count              (length line-err-info-list)))
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((file       (flymake-ler-file (nth (1- count)
;;                                                   line-err-info-list)))
;;                (full-file (flymake-ler-full-file (nth (1- count)
;;                                                       line-err-info-list)))
;;                (text      (flymake-ler-text (nth (1- count)
;;                                                  line-err-info-list)))
;;                (line      (flymake-ler-line (nth (1- count)
;;                                                  line-err-info-list))))
;;           (popup-tip (format "[%s] %s" line text))))
;;       (setq count (1- count)))))

;; Use this parameter in pod-mode
(quickrun-add-command "python"
                      '((:command . "source ~/.zshrc && PYENV_VERSION=my-pyenv python")
                        (:compile-only . "pyflakes %s"))
                      :mode 'python-mode)

 (setq pdb-path '~/.pyenv/versions/2.7/lib/python2.7/pdb.py
       gud-pdb-command-name (symbol-name pdb-path))

 (defadvice pdb (before gud-query-cmdline activate)
   "Provide a better default command line when called interactively."
   (interactive
    (list (gud-query-cmdline pdb-path
	 		    (file-name-nondirectory buffer-file-name)))))
