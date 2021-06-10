Subroutine Scaling(n,r,E,r0)
    Implicit None

    Integer, Intent(In)     ::  n
    Real*8, Intent(Out)     ::  r0, r(n), E(n)

    ! local variables    
    Integer                 ::  i
!   Real*8                  ::  E0

    Read(101,*,End=11) (r(i), E(i), i = 1,n)
!   E0 = MinVal(E, Dim=1)
    r0 = r(MinLoc(E, Dim=1))

    Do i = 1,n
        r(i) = r(i) - r0
        E(i) = E(i) - E(n)
    EndDo
11  Close(101)

    Write(102,'(f8.4,f20.8)') (r(i), E(i), i=1,n)

End Subroutine Scaling
