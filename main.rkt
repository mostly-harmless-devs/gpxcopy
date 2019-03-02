#lang racket

(require file/glob)

(define src-dir "/Users/nainu/Documents/gpx/incoming/")
(define dest-dir "/Volumes/BRYTON/ExtraFiles/")
(define backup-dir "/Users/nainu/Documents/gpx/done/")
(define files (glob (string-append src-dir "*.gpx")))

(for/list ([src-file-path files])
  (let* ([file-name (path->string (file-name-from-path src-file-path))]
         [dest-path (string-append dest-dir file-name)])
    (printf (string-append "Copying " file-name " to " dest-path ": "))
    (if (not (file-exists? dest-path))
        (let ()
          (copy-file src-file-path dest-path)
          ;; If succeeded, move it to backup
          (when (file-exists? dest-path) ; backup and remove
            (let ([backup-path (string-append backup-dir file-name)])
              (when (not (file-exists? backup-path))
                (rename-file-or-directory src-file-path backup-path))))
          (printf "Done\n")
          )
        (printf "Already copied\n"))))

