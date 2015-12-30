;; begin 基础设置
;; Mark some symbols as end of sentences.
(setq sentence-end "\\([。！？；]\\|……\\|[.?!;][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space t) ; Use 2 spaces between sentences.
;; Set the pattern that might be used as line start.
(setq adaptive-fill-regexp "[ \t]+\\|[ \t]*\\([0-9]+\\.\\|\\*+\\)[ \t]*")

;; Enable `auto-fill-mode' which can wrap lines for you.  Very handy.
;;(add-hook 'text-mode-hook
;;          (lambda () (auto-fill-mode t)))

;; This is a font configuration example for Chinese
;; (set-default-font "Monaco:pixelsize=18")
;; (set-face-attribute 'default nil :font "Inconsolata 17") ;: height 130
(set-default-font "-outline-Tsentsiu Mono HG-normal-normal-normal-mono-18-*-*-*-c-*-iso8859-1")

;; Chinese Font
(dolist (charset '(han gb18030 chinese-gbk bopomofo cjk-misc symbol))
  (set-fontset-font t charset (font-spec :family "Tsentsiu Mono HG" :size 18)))

(set-fontset-font t 'unicode "Symbola" nil 'append)
(set-fontset-font t 'unicode "Segoe UI Emoji" nil 'append)
(set-fontset-font t 'unicode "STIX" nil 'append)

;; 指定新建buffer的默认编码为utf-8
(setq default-buffer-file-coding-system 'utf-8)
(setq ansi-color-for-comint-mode t)

;;将utf-8放到编码顺序表的最开始，即先从utf-8开始识别编码，此命令可以多次使用，后指定的编码先探测  
(prefer-coding-system 'utf-8)
(prefer-coding-system 'chinese-gbk)

;;窗口位置大小
;;(setq default-frame-alist
;;      '((height . 40) (width . 150)))

;;设置窗口位置为屏幕左上角(0,0)
(set-frame-position (selected-frame) 30 30)

;;设置宽和高
(set-frame-width (selected-frame) 120)
(set-frame-height (selected-frame) 35)

;;高亮当前行
(global-hl-line-mode t)

;; 高亮显示选中的区域
(transient-mark-mode t)

;; 高亮显示匹配的括号
(show-paren-mode t)

;; 鼠标要挡住正在打的字时自动移开
(mouse-avoidance-mode 'animate)

;;指针不要闪
(blink-cursor-mode -1)

;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;; 支持中键粘贴
(setq mouse-yank-at-point t)

;; 防止页面滚动时跳动， scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文。
(setq scroll-margin 3
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; 鼠标滚轮滚动页面
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;; 回车缩进
(global-set-key (kbd "C-<return>") 'newline)

;;;下移一行
(global-set-key "\C-m" 'newline-and-indent)

;;C-f4关闭当前buffer
(global-set-key [C-f4] 'kill-this-buffer)

;; 默认文本模式
(setq default-major-mode 'text-mode)

;; 窗口标题
(setq frame-title-format'("%S" (buffer-file-name "%f"(dired-directory dired-directory "%b"))))

;;; 在行尾上下移动的光标，始终保持在行尾
(setq track-eol t)


;; 把 lambda 显示成 λ
(unless (version< emacs-version "24.4")
  (progn
    (add-hook 'lisp-mode-hook
              (lambda ()
                (push '("lambda" . ?λ) prettify-symbols-alist)))
    (global-prettify-symbols-mode t)
    ))

;;把c语言风格设置为k&r风格
(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "k&r")))

;; spaces, no tabs
;;设置TAB键缩进为4个空格  
(setq-default indent-tabs-mode nil)  
(setq default-tab-width 4)  
(setq standard-indent 4)
(setq tab-width 4)   
(setq c-basic-offset 4)  
(setq tab-stop-list (number-sequence 4 120 4))

;; 关闭烦人的出错时的提示声
(setq visible-bell t)

;; 改变 Emacs 固执的要你回答 yes 的行为。按 y 或空格键表示 yes，n 表示 no
(fset 'yes-or-no-p 'y-or-n-p)

;; 显示行列号
(setq column-number-mode t)
(setq line-number-mode t)

;;在左边显示行号
(global-linum-mode 'linum-mode)

;;禁用启动信息  
(setq inhibit-startup-message t			 ;; don't show ...	  
	  inhibit-startup-echo-area-message t)	 ;; ... startup messages
(setq require-final-newline t)           ;; end files with a newline

;; 最近打开
(recentf-mode t)

;; 在 Emacs 中互动地打开文件
(ido-mode t)

;; 滚动条
(scroll-bar-mode t)

;;递归使用minibuffer
(setq enable-recursive-minibuffers t)

;; 去掉工具栏
(tool-bar-mode -1)

;; 添加目录和二级子目录
;; (defun add-to-load-path (load-path-name)
;;   (let (default-directory-old default-directory)
;;     (progn (cd load-path-name) 
;;        (normal-top-level-add-subdirs-to-load-path))))
 
;; (add-to-load-path "~/etc/emacs23/site-lisp") 

;; end 基础配置


;;代码格式化
(defun indent-buffer ()
  "Indent the whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key (kbd "<f10>") 'indent-buffer)

;;注释
(defun my-comment-or-uncomment-region (beg end &optional arg)
  (interactive (if (use-region-p)
		   (list (region-beginning) (region-end) nil)
		 (list (line-beginning-position)
		       (line-beginning-position 2))))
  (comment-or-uncomment-region beg end arg))
(global-set-key (kbd "M-;") 'my-comment-or-uncomment-region)
;;(global-set-key (kbd "M-;") 'comment-or-uncomment-region)

;; 配合键绑定可以实现 VIM 中的 % 跳转括号
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; 行距
(defun toggle-line-spacing ()
  "Toggle line spacing between 1 and 5 pixels."
  (interactive)
  (if (eq line-spacing 1)
      (setq-default line-spacing 5)
    (setq-default line-spacing 1)))
(global-set-key (kbd "<f7>") 'toggle-line-spacing)

;; Unfill buffer
(defun unfill-buffer ()
  "Unfill current buffer."
  (interactive "")
  (setq m (point-marker))
  (beginning-of-buffer)
  (while (re-search-forward "\\([^ ]+\\) *
 *\\([^ ]\\)" nil t)
    (replace-match "\\1 \\2"))
  (set-marker m 0 (current-buffer)))

;; 选中当前行
(defun select-current-line()
  "select current line."
  (interactive)
  (beginning-of-line)
  (push-mark)
  (end-of-line))
(global-set-key (kbd "M-'") 'select-current-line)

;; 中英文之间增加空格
(defun insert-space-between-eng-cn ()
  "Insert a space between English words and Chinese charactors"
  (interactive "")
  (beginning-of-buffer)
  (while (re-search-forward "\\(\\cc\\)\\([a-zA-Z0-9]\\)" nil t)
    (replace-match "\\1 \\2" nil nil))
  (beginning-of-buffer)
  (while (re-search-forward "\\([a-zA-Z0-9]\\)\\(\\cc\\)" nil t)
    (replace-match "\\1 \\2" nil nil))
  
  ;; 去掉全角标点与英文之间的空格
  (beginning-of-buffer)
  (while (re-search-forward "\\([。，！？；：“”（）、]\\) \\([a-zA-Z0-9]\\)" nil t)
    (replace-match "\\1\\2" nil nil))
  (beginning-of-buffer)
  (while (re-search-forward "\\([a-zA-Z0-9]\\) \\([。，！？；：“”（）、]\\)" nil t)
    (replace-match "\\1\\2" nil nil)))
(global-set-key (kbd "M-o") 'insert-space-between-eng-cn)

;; 去除断行
;; (defun anti-operation ()
;;   (interactive)
;;   (goto-char 1)
;;   (replace-regexp "\n+" "\n")
;;   (goto-char 1)
;;   (replace-regexp "\n[ 　]" "dkfjaojifwenfiewonfawo")
;;   (goto-char 1)
;;   (replace-regexp "\n" "")
;;   (goto-char 1)
;;   (replace-regexp "dkfjaojifwenfiewonfawo" "\n　")) 

;;计算选定区域中、英文个数 
(defun count-ce-word (beg end)
  "Count Chinese and English words in marked region."
  (interactive "r")
  (let* ((cn-word 0)
         (en-word 0)
         (total-word 0)
         (total-byte 0))
    (setq cn-word (count-matches "//cc" beg end)
          en-word (count-matches "//w+//W" beg end)
          total-word (+ cn-word en-word)
          total-byte (+ cn-word (abs (- beg end))))
    (message (format "总计: %d (汉字: %d, 英文: %d) , %d 字母."
                     total-word cn-word en-word total-byte))))

;; 半透明窗口
(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list))) ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab))))
     (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))))
(global-set-key [(f12)] 'loop-alpha)

;; 复制本行到下一行
(global-set-key [(ctrl d)] 'my-dup-line-down)
(defun my-dup-line-down ()                  
  "duplicate this line at next line"
  (interactive)
  (let ((c (current-column)))
    (beginning-of-line)
    (ue-select-line-down)
    (beginning-of-line)
    (yank)
    (previous-line 1)
    (move-to-column c)))
(defun ue-select-line-down ()
  "like Shift+down in UltraEdit."
  (interactive)
  (let ((s (point)))
    (setq next-line-add-newlines t)
    (next-line 1)
    (setq next-line-add-newlines nil)
    (kill-new (buffer-substring s (point)))))

;; 配色主题
;;(add-to-list 'load-path "~/plugings/color-theme")
;;(add-to-list 'load-path "~/plugings/color-theme-molokai")
;;(require 'color-theme)
;;(require 'color-theme-molokai)
;;(color-theme-molokai)
;;配色方案
(require 'solarized)
(load-theme 'solarized-dark t)
(global-font-lock-mode t)

;;使shell能够自动退出
(add-hook 'shell-mode-hook 'wcy-shell-mode-hook-func)
(defun wcy-shell-mode-hook-func ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                        #'wcy-shell-mode-kill-buffer-on-exit))

(defun wcy-shell-mode-kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))

;;; 80 列边界线
;;;(add-to-list 'load-path "~/plugings/fill-column-indicator")
;;;(require 'fill-column-indicator)
;;;(setq whitespace-style '(face trailing))
;;;(setq-default fill-column 80)
;;;(let ((faces '((font-lock-comment-face :foreground "#4d7a70" :slant italic)
;;;               (font-lock-constant-face :foreground "#6b7875")
;;;               (font-lock-string-face :foreground "#7a633d")
;;;               (font-lock-type-face :foreground "grey50")
;;;               (font-lock-warning-face :foreground "#cd5c5c")
;;;               (font-lock-preprocessor-face :foreground "#596766" :weight bold)
;;;               (font-lock-doc-face :foreground "#707f75" :slant italic)
;;;               (font-lock-keyword-face :foreground "#665d9c" :weight bold)
;;;               (font-lock-builtin-face :foreground "gray50" :weight bold)
;;;               (font-lock-function-name-face :foreground "#2e5fa2" :weight bold)
;;;               (font-lock-variable-name-face :foreground "#6f5057" :weight bold)
;;;               (mode-line  :background "#bedefe" :box (:line-width 2 :color "gray85")))))
;;;  (dolist (face faces)
;;;    (apply 'set-face-attribute (car face) nil (cdr face))))
;;;(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode t)))
;;;(global-fci-mode t)


;; 自动保存
(setq auto-save-default t)

;; 恢复上次关闭时的窗口
(when (fboundp 'winner-mode) (winner-mode) (windmove-default-keybindings))

;; C-x C-j 打开当前文件的所在目录
(global-set-key (kbd "C-x C-j")
                (lambda ()
                  (interactive)
                  (if (buffer-file-name)
                      (dired default-directory))))

;; 目录在前面
(defun sof/dired-sort ()
  "Dired sort hook to list directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil))
(add-hook 'dired-after-readin-hook 'sof/dired-sort)

;; 保存上次打开的文件记录
;; (add-to-list 'load-path "~/plugings/session")
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

(setq desktop-path '("~/desktop/"))
(setq desktop-dirname "~/desktop/")
(setq desktop-base-file-name ".emacs-desktop")
(desktop-save-mode t)
(load "desktop")
(desktop-load-default)
(setq-default desktop-load-locked-desktop t)

;; 当emacs退出时保存文件打开状态
(add-hook 'kill-emacs-hook
          '(lambda()(desktop-save "~/desktop/")))

;; 备份文件#xxx#
(setq
 backup-by-copying t ; 自动备份
 backup-directory-alist
 '(("." . "~/.backups")) ; 自动备份在目录"~/.backups"下
 delete-old-versions t ; 自动删除旧的备份文件
 kept-new-versions 6 ; 保留最近的6个备份文件
 kept-old-versions 2 ; 保留最早的2个备份文件
 version-control t) ; 多次备份

;; 设置打开文件的缺省路径
(setq default-directory "d:/Emacs")

;;自己的插件目录
(add-to-list 'load-path "~/plugings")

;;use highlight-indentation
;; (require 'highlight-indentation)
;; (add-hook 'nxml-mode-hook 'highlight-indentatoin-mode)
;; (add-hook 'nxml-mode-hook 'highlight-indentatoin-current-column-mode)

;;;代码折叠
(require 'yafolding)
(global-set-key [f4] 'yafolding-toggle-element)

;;在历史编辑位置跳转
(require 'goto-chg)
(global-set-key (kbd "C-,")  'goto-last-change)
(global-set-key (kbd "C-.")  'goto-last-change-reverse)

;;; imenu-tree
(add-to-list 'load-path "~/plugings/imenu-tree")
(require 'imenu-tree)
(setq imenu-tree-auto-update t)
(global-set-key (kbd "<f5>") 'imenu-tree)

(require 'imenu-anywhere)
(global-set-key [f6] 'imenu-anywhere)

;;; ibuffer
(global-set-key [f8] 'ibuffer)

;;; sr-speedbar 设置
;; (add-to-list 'load-path "~/plugings/sr-speedbar")
(require 'sr-speedbar)
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)
(setq sr-speedbar-width 30)
(setq sr-speedbar-right-side t)
(global-set-key (kbd "<f9>") (lambda()
                               (interactive)
                               (sr-speedbar-toggle)))

;; tabbar
(require 'tabbar)
(tabbar-mode t)

(global-set-key [(meta left)] 'tabbar-backward)
(global-set-key [(meta right)] 'tabbar-forward)

;; close default tabs，and move all files into one group
(setq tabbar-buffer-list-function
      (lambda ()
        (remove-if
         (lambda(buffer)
           (find (aref (buffer-name buffer) 0) " *"))
         (buffer-list))))
;;(setq tabbar-buffer-groups-function
;;      (lambda()(list "All")))

;; 设置tabbar外观
;; 设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
                    ;:family "Monaco"
                    :background "gray80"
                    :foreground "gray30"
                    :height 1.0                    
                    )

;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "yellow70")
                    )

;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "DarkGreen"
                    :background "LightGoldenrod"
                    :box '(:line-width 2 :color "DarkGoldenrod")
                    :overline "black"
                    :underline "black"
                    :weight 'bold
                    )

;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 2 :color "#00B2BF")
                    )

;;; 隐藏按钮
(defcustom tabbar-hide-header-button t
  "Hide header button at left-up corner.
  Default is t."
  :type 'boolean
  :set (lambda (symbol value)
         (set symbol value)
         (if value
             (setq
              tabbar-scroll-left-help-function nil ;don't show help information
              tabbar-scroll-right-help-function nil
              tabbar-help-on-tab-function nil
              tabbar-home-help-function nil
              ;;tabbar-buffer-home-button (quote (("") "")) ;don't show tabbar button
              tabbar-scroll-left-button (quote (("") ""))
              tabbar-scroll-right-button (quote (("") "")))))
  :group 'tabbar)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
;; (add-to-list 'yas/root-directory "~/.emacs.d/snippets")

;;; 自动补全  http://blog.csdn.net/winterTTr/article/details/7524336
;; (add-to-list 'load-path "~/plugings/pos-tip")
;; (add-to-list 'load-path "~/plugings/fuzzy-el")
;; (add-to-list 'load-path "~/plugings/popup-el")
;; (add-to-list 'load-path "~/plugings/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

(require 'pos-tip)
(setq ac-quick-help-prefer-pos-tip t)

(setq ac-use-quick-help t)
(setq ac-quick-help-delays 1.0)
(setq ac-dwim t)
(setq ac-fuzzy-enable t)

;; use smartparens
;; (add-to-list 'load-path "~/plugings/dash/")
;; (add-to-list 'load-path "~/plugings/smartparens/")
(require 'smartparens-config)
(smartparens-global-mode 1)

;;开启cedet的semantic自动补全
;; (require 'cedet)
;; (setq semantic-default-submodes
;;       '(global-semantic-idle-scheduler-mode
;;         global-semanticdb-minor-mode
;;         global-semantic-idle-summary-mode
;;         global-semantic-mru-bookmark-mode
;;         global-semantic-idle-completions-mode
;;         global-semantic-decoration-mode
;;         global-semantic-highlight-func-mode))
;; (semantic-mode 1)

;; ;; 加载跳转功能
;; (require 'semantic/analyze/refs)

;; (global-semantic-highlight-edits-mode (if window-system 1 -1))
;; (global-semantic-show-unmatched-syntax-mode 1)
;; (global-semantic-show-parser-state-mode 1)

;; ;; 这几个provide都很重要
;; (provide 'semantic-analyze)
;; (provide 'semantic-ctxt)
;; (provide 'semanticdb)
;; (provide 'semanticdb-find)
;; (provide 'semanticdb-mode)
;; (provide 'semantic-load)

;;;(add-to-list 'load-path "~/plugings/window-manager/")
;;;;;;(Provide 'init-e2wm)
;;;(require 'e2wm)
;;;(global-set-key (kbd "M-+") 'e2wm:start-management)
;;;(global-set-key (kbd "M--") 'e2wm:stop-management) 

;; lua-mode
;; (add-to-list 'load-path "~/plugings/lua-mode/")
(require 'lua-mode)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
(setq lua-indent-level 4)

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(cua-mode t nil (cua-base))
;;  '(lua-indent-level 4)
;;  '(nxml-child-indent 4))

;;;禁用cua-mode 模式快捷键绑定
(setq cua-enable-cua-keys nil)

;;; 录制宏工具
;;;(global-set-key [(meta f3)] 'start-kbd-macro)
;;;(global-set-key [(meta f4)] 'end-kbd-macro)
;;;(defun call-last-kbd-macro-N-times (n)
;;;  "Call call-last-kbd-macro N times."
;;;  (interactive "How many times?")
;;;  (call-last-kbd-macro n))
;;;(global-set-key [(meta f5)] 'call-last-kbd-macro-N-times)

;; 默认不开启 evil-mode
;;(setq evil-default-state 'emacs)  (setq exec-path (cons "/usr/local/git/bin/" exec-path))

; undo-tree 可视化撤销
(require 'undo-tree)
(global-undo-tree-mode)

;; 文件编码识别
;; (require 'unicad)

;; smex
(autoload 'smex "smex" nil t)
;; (smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; 环境变量
(setenv "PATH" (concat "~/gtags" (getenv "PATH")))
(setq exec-path (append exec-path '("~/gtags")))
;; (setq exec-path (cons "~/gtags" exec-path))

;; 警告等级
(setq warning-minimum-level :error)

;; 在行末或行中位置复制整行
(defadvice kill-ring-save (before slickcopy activate compile)
  (interactive
   (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
            (line-beginning-position 2)))))

;; 在行末或行中位置删除整行
(defadvice kill-region (before slickcut activate compile)
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2))))) 

;; ace-jump-mode
(add-to-list 'load-path "~/plugings/ace-jump/")
(require 'ace-jump-mode)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
	
;; 减少垃圾回收加快Emacs的运行 
(setq gc-cons-threshold (* 50 1024 1024))
