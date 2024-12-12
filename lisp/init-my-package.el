;;; init-my-package.el --- initialize the plugins

;; auto-save
(add-to-list 'load-path "~/.emacs.d/extensions/auto-save/") ; add auto-save to your load-path
(require 'auto-save)
(auto-save-enable)
(setq auto-save-silent t)   ; quietly save
(setq auto-save-delete-trailing-whitespace t)  ; automatically delete spaces at the end of the line when saving
;;; custom predicates if you don't want auto save.
;;; disable auto save mode when current filetype is an gpg file.
(setq auto-save-disable-predicates
      '((lambda ()
      (string-suffix-p
      "gpg"
      (file-name-extension (buffer-name)) t))))

;; achive
(use-package achive
  :load-path "~/.emacs.d/extensions/achive"
  :bind
  ("C-c z a" . achive)
  :custom
  (achive-auto-refresh t)
  (achive-refresh-seconds 5)
  (achive-stock-list '("sh600597" "sz000949" "sh600350" "sh600703")))
(use-package tablist
    :defer 1)


;; blink-search
(add-to-list 'load-path "~/.emacs.d/extensions/blink-search")
(require 'blink-search)

;; sort-tab
; (add-to-list 'load-path "~/.emacs.d/extensions/sort-tab") ; add sort-tab to your load-path
; (require 'sort-tab)
; (sort-tab-mode 1)

;; F#
(use-package fsharp-mode
  :defer t
  :ensure t)


;; weather
(defun my/weather ()
  "天气预报 based on https://github.com/chubin/wttr.in"
  (interactive)
  (eww "zh-cn.wttr.in/qingdao,laoshan?TAFm")) ;;qingdao,laoshan?TAFm 带区县也是可以

;; M-x user
(defun my/user()
  (interactive)
  ( insert (concat "Author: "
                   (user-login-name) "\n"
                   "Date: "
                   (current-time-string)
                   )))

;; 复制当前行
(defun my/copy-line ()
  (interactive)
  (save-excursion
    (back-to-indentation)
    (kill-ring-save
     (point)
     (line-end-position)))
  (message "1 line copied"))

;; show todo list
(defun my/show-todo-list()
  "show todo list"
  (interactive)
  (project-find-regexp "TODO")
  )

(global-set-key (kbd "C-c ,") 'my/user) ;; user - Date
(global-set-key (kbd "C-c z d") 'my/copy-line) ;; duplicate-line ;; (M-y) 粘贴
(global-set-key (kbd "C-c z t") 'my/show-todo-list) ;;展示所有todo标签
(global-set-key (kbd "C-c z w") 'my/weather) ;;查看天气
(global-set-key (kbd "C-c [") 'project-find-file) ;;项目中查找文件
(global-set-key (kbd "C-c z b") 'blink-search);; blink-search

(provide 'init-my-package)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:
;;; init-package.el ends here