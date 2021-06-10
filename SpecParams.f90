Subroutine SpecParams(Mu,r0,De,a1,a2,a3,we,wexe,Be,ae)
!   Use MSFunctionsModule
    Implicit None

    Real*8, Parameter       ::  pi      = 4.0d0*atan(1.0d0)
    Real*8, Parameter       ::  hplanck = 6.62606800d-34    ! Planck Constant
    Real*8, Parameter       ::  rconv   = 5.29177211d-11    ! Bohr to meter
    Real*8, Parameter       ::  mconv   = 1.66053886d-27    ! amu to Kg 
    Real*8, Parameter       ::  econv   = 4.35974394d-18    ! Hartree to Joule
    Real*8, Parameter       ::  velc    = 2.99792458d+08    ! speed of light 

    Real*8, Intent(InOut)   ::  Mu, r0, De, a1, a2, a3      ! input as au then convert to SI unit
    Real*8, Intent(Out)     ::  we, wexe, Be, ae            ! Omegae, OmegaeChie, Be, Alphae
    
    ! local functions
    Real*8                  ::  f2, f3, f4


    ! print Mu, r0, De    
    Write(104,*)
    Write(104,'(a)')'------------------------------------------'
    Write(104,'(a)')' Reduced Mass, Req, Ediss:'
    Write(104,'(a)')'------------------------------------------'
    Write(104,'(a,f12.6)') ' Reduced Mass (amu)         = ', Mu
    Write(104,'(a,f12.6)') ' Equilibrium bond dis (A0)  = ', r0*0.529177211
    Write(104,'(a,f12.6)') ' Dissociation energy (mEh)  = ', De*1000d0
    Write(104,'(a)')'------------------------------------------'
    Write(104,*)
    
    ! convert everything to SI unit
    a1 = a1/rconv
    a2 = a2/rconv**2
    a3 = a3/rconv**3
    De = De*econv
    r0 = r0*rconv
    Mu = Mu*mconv
   
    ! local functions in terms of De, a1, a2, a3  
    f2   = De*(a1**2 - 2*a2)
    f3   = 6.0d0*De*(a1*a2 - a3 - (a1**3/3.0d0))
    f4   = ((De*a1**4) - (6*f2*a1**2) - (4*f3*a1))
    
    ! spectroscopic parameters
    we   = 1/(2*pi*velc)*sqrt(f2/Mu)
    Be   = hplanck/(8.0d0*pi**2*velc*Mu*r0**2)
    ae   = -(6.0d0*Be**2/we)*(((f3*r0)/(3*f2)) + 1)
    wexe = (Be/8.0d0)*(-(f4*r0**2/f2) + 15.0d0*(1 + ((we*ae)/(6.0d0*Be**2)))**2)

    Write(104,*)
    Write(104,'(a)')'------------------------------------------'
    Write(104,'(a)')' Spectroscopic Parameters:'
    Write(104,'(a)')'------------------------------------------'
    Write(104,'(a,f12.4)') ' we   (cm-1)                = ', we/100.0d0
    Write(104,'(a,f12.4)') ' Be   (cm-1)                = ', Be/100.0d0
    Write(104,'(a,f12.4)') ' ae   (cm-1)                = ', ae/100.0d0
    Write(104,'(a,f12.4)') ' wexe (cm-1)                = ', wexe/100.0d0
    Write(104,'(a)')'------------------------------------------'
    Write(104,*) 

End Subroutine SpecParams
