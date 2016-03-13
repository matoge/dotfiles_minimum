
;; python
(setq exec-path (append exec-path '("~/.pyenv/shims/")))
(setenv "PATH"
	(concat '"~/.pyenv/shims/:" (getenv "PATH")))
