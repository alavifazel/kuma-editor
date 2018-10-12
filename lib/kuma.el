(require 'package)
(require 'cl)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ;("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

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
  ;; install missing packages
  (install pkgs)
  )



(provide 'kuma)
