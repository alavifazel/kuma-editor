(require 'package)
(require 'cl)

(defun install (required-pkgs)
  (setq pkgs-to-install
      (let ((uninstalled-pkgs (remove-if 'package-installed-p required-pkgs)))
        (remove-if-not '(lambda (pkg) (y-or-n-p (format "Package %s is missing. Install it? " pkg))) uninstalled-pkgs)))

  (when (> (length pkgs-to-install) 0)
    (package-refresh-contents)
   (dolist (pkg pkgs-to-install)
    (package-install pkg))))



(defun add-to-path-with-subdirs (dir)
  (add-to-list 'load-path dir)
  (--each (f-directories dir) (add-to-list 'load-path it)))

(defun kuma-initialize ()
  (require 'package)
  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		      (not (gnutls-available-p))))
	 (proto (if no-ssl "http" "https")))
    ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
    (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
    ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
    (when (< emacs-major-version 24)
      ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
  (package-initialize)
  ;; highlight matching params
  (show-paren-mode 1)

  ;; associating .rs files to rust-mode
  (autoload 'rust-mode "rust-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  
  ;; enabling cua mode
  (cua-mode t)
  (setq cua-auto-tabify-rectangles nil)
  (transient-mark-mode 1)
  (setq cua-keep-region-after-copy t)

  ;; adding compile/run shortcut
  (global-set-key [f4] 'compile)
  
  ;; making fullscreen on startup
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  
  ;; disabling auto backup files
  (setq make-backup-files nil)
  (setq auto-save-default nil)

  ;; enable line numbers globally
  (global-linum-mode t) 
 
  ;; Setting default font to Consolas
  (set-face-attribute 'default nil
		      :family "monospace"
		      :height 110
		      :weight 'normal
		      :width 'normal)
  ;; Loading a dark theme
  (load-theme 'deeper-blue) 


  ;; install missing packages
  (install pkgs)

  (require 'company)
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  (global-company-mode)
  )



(provide 'kuma)
