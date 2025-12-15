;; 安装并配置 vterm（核心终端）
(use-package vterm
  :ensure t
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000)) ; 可选：增大滚动缓冲区

(defun my/vterm-new ()
  "创建一个新的、独立命名的 vterm 终端缓冲区。"
  (interactive)
  ;; 生成唯一缓冲区名，例如 *vterm-<timestamp>*
  (let ((buffer-name (generate-new-buffer-name "*vterm*")))
    (vterm buffer-name)))

(provide 'init-term)
