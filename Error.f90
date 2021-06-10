Subroutine Error(n,r,E,De,a1,a2,a3,er)
    Implicit None
    
    Integer, Intent(In)             ::  n
    Real*8, Intent(In)              ::  r(n), E(n)
    Real*8, Intent(In)              ::  De, a1, a2, a3
    Real*8, Intent(Out)             ::  er
    Real*8, External                ::  fMS

    Integer                         ::  i


    er = 0.0d0
    Do i = 1,n
        er = er + (E(i) - fMS(r(i),De,a1,a2,a3))**2
    EndDo

!   Write(*,'(a,f8.4)') 'RMSE Error = ', er
    
End Subroutine Error

!Contains
    !----------------------------------------------
    !   Murrel Sorbie function
    !----------------------------------------------
    
    Real*8 Function fMS(x,De,a1,a2,a3)
        Implicit None
    
        Real*8, Intent(In)      ::  x, De, a1, a2, a3
    
        fMS = -De*(1 + a1*x + a2*x**2 + a3*x**3)*exp(-a1*x)
    
    End Function fMS

!End Subroutine Error
