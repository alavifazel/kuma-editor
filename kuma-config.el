(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))


(package-initialize)

      
;; list of packages
(setq pkgs '
      (       
       rust-mode
       ))


(setq kuma-home (getenv "KUMA_HOME"))
(setq kuma-lib (concat kuma-home "/lib"))

;; loading up
(add-to-list 'load-path kuma-lib)
(require 'kuma)

;;initialize kaido editor

(kuma-initialize)
