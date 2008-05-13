;; Nexus Game Engine
;; Copyright (C) 2008 Falling Man Productions

;; Required facilities:
;; Window creation/destruction
;; Resolution switching
;; Hardware capabilities query
;; Graphics and sound initialization

(require-extension gl)
(require-extension glu)
(require-extension sdl)

(define window-width 640)
(define window-height 480)

(define mesh-path "../assets/models")

;; -----------------------------------------------------------------------------
;; SDL Interface
;; TODO: Fonts, sound - Check and select available video modes
;; -----------------------------------------------------------------------------

(define (open-viewport width height)
  (initialize-video-mode width height 0 (+ SDL_OPENGL)))

;; TODO: Throw exception here if SDL couldn't be initialized
(define (initialize-sdl)
  (sdl-init (+ SDL_INIT_VIDEO)))

(define (initialize-video-mode width height bpp flags)
  (sdl-wm-set-caption "Nexus Engine" "Nexus Engine")
  (sdl-set-video-mode width height bpp flags)
  (sdl-gl-set-attribute SDL_GL_DOUBLEBUFFER 1)
  (sdl-gl-set-attribute SDL_GL_RED_SIZE 5)
  (sdl-gl-set-attribute SDL_GL_GREEN_SIZE 5)
  (sdl-gl-set-attribute SDL_GL_BLUE_SIZE 5)
  (sdl-gl-set-attribute SDL_GL_DEPTH_SIZE 16))

(define (shutdown)
  (sdl-quit))

;; -----------------------------------------------------------------------------
;; OpenGL interface
;; -----------------------------------------------------------------------------

(define (initialize-view width height)
  (gl:PolygonMode gl:FRONT_AND_BACK gl:LINE)
  (gl:Viewport 0 0 width height)
  (gl:ClearColor 0.5 0.5 0.5 0.0)
  (gl:ClearDepth 1.0)
  (gl:MatrixMode gl:PROJECTION)
  (gl:LoadIdentity)
  (glu:Perspective 45.0 (/ window-width window-height) 0.1 1000.0)
  (gl:MatrixMode gl:MODELVIEW)
  (gl:LoadIdentity)
  ;;(gl:Enable gl:DEPTH_TEST
  )

(define (draw-test-scene)
  ;; Drawing a cube. Top face
  (gl:Clear (+ gl:COLOR_BUFFER_BIT gl:DEPTH_BUFFER_BIT))
  (gl:Color3f 1.0 1.0 1.0)
  (gl:LoadIdentity)
  (gl:Translatef 0.0 0.0 -3.0)
  (gl:Rotatef 20 1.0 0.0 0.0)
  (let ((cs 0.5))
    (gl:Begin gl:TRIANGLE_STRIP)
    (gl:Vertex3f (- cs) (- cs) cs)
    (gl:Vertex3f (- cs) (- cs) (- cs))
    (gl:Vertex3f cs (- cs) (- cs))
    (gl:Vertex3f cs (- cs) cs)
    (gl:End)
    ;; Left side
    (gl:Begin gl:TRIANGLE_STRIP)
    (gl:Vertex3f (- cs) ( - cs) cs)
    (gl:Vertex3f (- cs) cs (- cs))
    (gl:Vertex3f (- cs) (- cs) (- cs))
    (gl:Vertex3f (- cs) cs cs)
    (gl:End)
    ;; Right side
    (gl:Begin gl:TRIANGLE_STRIP)
    (gl:Vertex3f cs ( - cs) cs)
    (gl:Vertex3f cs cs (- cs))
    (gl:Vertex3f cs (- cs) (- cs))
    (gl:Vertex3f cs cs cs)
    (gl:End)
    ;; Bottom
    (gl:Begin gl:TRIANGLE_STRIP)
    (gl:Vertex3f cs (- cs) cs)
    (gl:Vertex3f cs (- cs) (- cs))
    (gl:Vertex3f cs cs (- cs))
    (gl:Vertex3f cs cs cs)
    (gl:End)
    )
  (gl:Flush)
  (sdl-gl-swapbuffers))

(initialize-sdl)  
(open-viewport window-width window-height)
(initialize-view window-width window-height)
(draw-test-scene)
(shutdown)
