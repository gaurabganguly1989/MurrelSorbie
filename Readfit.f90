Subroutine Readfit(De,a1,a2,a3)
    Implicit None

    Character(120)          ::  line
    Real*8, Intent(Out)     ::  De, a1, a2, a3

1   Read(103,'(a)',End=11) line
    If      ( line(1:18) == 'De              = ' ) then
            Read(line(19:26),*) De
    ElseIf  ( line(1:18) == 'a1              = ' ) then
            Read(line(19:26),*) a1
    ElseIf  ( line(1:18) == 'a2              = ' ) then
            Read(line(19:26),*) a2
    ElseIf  ( line(1:18) == 'a3              = ' ) then
            Read(line(19:26),*) a3
    EndIf
    GoTo 1
11  Continue
   
End Subroutine readfit


