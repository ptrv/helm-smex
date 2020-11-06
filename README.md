[![MELPA](https://melpa.org/packages/helm-smex-badge.svg)](https://melpa.org/#/helm-smex)
[![MELPA Stable](https://stable.melpa.org/packages/helm-smex-badge.svg)](https://stable.melpa.org/#/helm-smex)

helm-smex
=========

This package provides [Helm](https://emacs-helm.github.io/helm/) integration for [smex](https://github.com/nonsequitur/smex)

Config
-------

``` emacs-lisp
(require 'helm-smex)
(global-set-key [remap execute-extended-command] #'helm-smex)
(global-set-key (kbd "M-X") #'helm-smex-major-mode-commands)
```

Sources
-------

* https://github.com/hatschipuh/helm-better-defaults
* https://github.com/wasamasa/dotemacs/blob/master/unpublished/helm-smex.el
