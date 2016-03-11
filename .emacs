(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
(put 'set-goal-column 'disabled nil)
