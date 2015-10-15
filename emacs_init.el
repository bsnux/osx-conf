;; emacs kicker --- kick start emacs setup
;;
;; Based on https://github.com/dimitri/emacs-kicker
;;
;; 

(require 'cl)               ; common lisp goodies, loop

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

(setq
 el-get-sources
 '((:name evil
      :after (progn
            (define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
            (define-key evil-insert-state-map "\C-e" 'end-of-line)
            (define-key evil-visual-state-map "\C-e" 'evil-end-of-line)
            (define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
            (define-key evil-normal-state-map "\C-f" 'evil-forward-char)
            (define-key evil-insert-state-map "\C-f" 'evil-forward-char)
            (define-key evil-insert-state-map "\C-f" 'evil-forward-char)
            (define-key evil-normal-state-map "\C-b" 'evil-backward-char)
            (define-key evil-insert-state-map "\C-b" 'evil-backward-char)
            (define-key evil-visual-state-map "\C-b" 'evil-backward-char)
            (define-key evil-normal-state-map "\C-d" 'evil-delete-char)
            (define-key evil-insert-state-map "\C-d" 'evil-delete-char)
            (define-key evil-visual-state-map "\C-d" 'evil-delete-char)
            (define-key evil-normal-state-map "\C-n" 'evil-next-line)
            (define-key evil-insert-state-map "\C-n" 'evil-next-line)
            (define-key evil-visual-state-map "\C-n" 'evil-next-line)
            (define-key evil-normal-state-map "\C-p" 'evil-previous-line)
            (define-key evil-insert-state-map "\C-p" 'evil-previous-line)
            (define-key evil-visual-state-map "\C-p" 'evil-previous-line)
            (define-key evil-insert-state-map "\C-k" 'evil-delete-line)
            (define-key evil-visual-state-map "\C-k" 'evil-delete-line)))
   (:name auto-complete
      :after (progn
         (define-key ac-complete-mode-map "\C-n" 'ac-next)
         (define-key ac-complete-mode-map "\C-p" 'ac-previous)))))

;; packages
(setq
 my:el-get-packages
 '(el-get
   auto-complete
   yasnippet
   evil
   flycheck
   color-theme
   color-theme-zenburn
   monokai-theme
   color-theme-almost-monokai))

(setq my:el-get-packages
      (append
       my:el-get-packages
       (loop for src in el-get-sources collect (el-get-source-name src))))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)


(setq delete-auto-save-files t)     ; Delete unnecesary auto-save files (ex. #%*mail*#')

;; No backup files
(setq make-backup-files nil)

;; Custom init buffer
(setq initial-scratch-message ";; scratch buffer: Lisp evaluation & draft notes")

(line-number-mode 1)                ; have line numbers and
(column-number-mode 1)              ; column numbers in the mode line
(global-hl-line-mode)               ; highlight current line
(set-face-background 'hl-line "#3e4446")
(global-linum-mode 1)               ; add line numbers on the left

;; Adding spaces between line numbers and buffer content
(add-hook 'linum-before-numbering-hook
        (lambda ()
          (setq-local linum-format-fmt
                      (let ((w (length (number-to-string
                                        (count-lines (point-min) (point-max))))))
                        (concat "%" (number-to-string w) "d")))))
(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'mode-line)))
(setq linum-format 'linum-format-func)

;; Automatically re-visiting the file in current buffer when it was
;; modified by an external program
(global-auto-revert-mode 1)

;; Show and delete trailing whitespace (on save)
(setq whitespace-style '(lines))
(setq whitespace-line-column 78)
(global-whitespace-mode 1)
(setq-default show-trailing-whitespace t)
(setq default-indicate-empty-lines t)

(evil-mode 1)                           ; evil-mode

;(load-theme 'zenburn t)
(load-theme 'monokai t)

(fset 'yes-or-no-p 'y-or-n-p)           ; Changes all yes/no questions to y/n type

(electric-pair-mode 1)                  ; New in Emacs 24.4


(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
(setq ido-default-buffer-method 'selected-window)

;; default key to switch buffer is C-x b, but that's not easy enough
;;
;; when you do that, to kill emacs either close its frame from the window
;; manager or do M-x kill-emacs.  Don't need a nice shortcut for a once a
;; week (or day) action.
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)

;; have vertical ido completion lists
(setq ido-decorations
      '("\n-> " "" "\n   " "\n   ..." "[" "]"
    " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))

;; Disabling auto-save for files
(setq auto-save-default nil)

;; `flycheck` module
;; It works out of the box for many languages but you'll need to install checkers
;; first:
;;      $ pip install flake8
;;      $ npm install jshint -g
(add-hook 'after-init-hook #'global-flycheck-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a6b3505132c41686521cad3cccdc28ef7cc1f04338073a63146a231a1786537c" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

