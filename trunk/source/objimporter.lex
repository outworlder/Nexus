
digit [0-9.]
letter [a-zA-z]
space [ \n]
float -?{digit}+
identifier {letter}({letter}|{digit}|_|\.)+

%%

{space}+  (yycontinue)
{float}   (list 'float (string->number yytext))
s          's
/       'slash
^mtllib 'mtllib
^usemtl 'usemtl
^v      'vertex-coord
^vn     'normal-coord
^vt     'texture-coord
^f      'face
^o      'object
\(null\) 'null
{identifier} (list 'identifier yytext)
^#        (let loop ()
             (let ([c (yygetc)])
               (if (or (eq? 'eof c) (char=? #\newline c))
                         (yycontinue)
                   (loop))))

<<EOF>>  'eof
<<ERROR>> (print yytext)
