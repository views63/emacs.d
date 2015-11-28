; -*- coding: utf-8 -*-

;;设置package源
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "https://marmalade-repo.org/packages/")
                           ("melpa" . "https://melpa.milkbox.net/packages/"))) 
(package-initialize)

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(if (file-exists-p "~/.custom.el") (load-file "~/.custom.el"))

;;;(when (require 'time-date nil t)
;;;  (message "Emacs startup time: %d seconds."
;;; 	   (time-to-seconds (time-since emacs-load-start-time))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(lua-indent-level 4)
 '(nxml-child-indent 4)
 '(package-selected-packages
   (quote
    (yasnippet tabbar sr-speedbar smex smartparens session pos-tip lua-mode helm-gtags ggtags fuzzy color-theme-solarized auto-complete)))
 '(session-use-package t nil (session)))
;;; Local Variables:
;;; no-byte-compile: t
;;; End:
(put 'erase-buffer 'disabled nil)
