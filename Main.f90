Program Main
    Implicit None

    Integer                 ::  nPoints
    Character(120)          ::  PES, RedMass
    Real*8, Allocatable     ::  r(:), E(:)

    Real*8                  ::  Mu, r0, De, a1, a2, a3      ! input as au then convert to SI unit
    Real*8                  ::  we, wexe, Be, ae            ! Omegae, OmegaeChie, Be, Alphae
    
    Real*8                  ::  er

    Integer                 ::  n


    n = iargc()
    If ( n /= 2 ) then
        Write(*,'(a)') ' Usage: ./MS [PES file in Bohr] [Reduced mass of the diatom (au)]'
        Call Exit
    EndIf

    ! Read the PES file as character
    Call getarg(1, PES)
    Call getarg(2, RedMass); Read(RedMass,'(f20.8)') Mu

    ! Open PES file:
    Open(Unit=101, File=PES, Status='Unknown')
    nPoints = 0
    Do
        Read(101,*,End=10) 
        nPoints = nPoints + 1   ! count the entries in PES
    EndDo
10  Close(101)

    ! Scale the PES
    Allocate ( r(nPoints), E(nPoints) )
    Open(Unit=101, File=PES, Status='Unknown')
    Open(Unit=102, File='ScaledPES.dat', Status='Unknown')
    Call Scaling(nPoints,r,E,r0)
    Close(101)
    Close(102)

    ! fit the data set to Murrel Sorbie function using GNUplot
    Call System('gnuplot -p MSfit.gnu > fit.log') 

    ! Read the fitted parameters: De, a1, a2, a3
    open(103, File='fit.log', status='unknown')
    Call Readfit(De,a1,a2,a3)
    close(103)

    ! Error estimation of fitting
    Call Error(nPoints,r,E,De,a1,a2,a3,er)
    
    ! Finally calculate the spectroscopic parameters using formulas
    Open(104, File='Results.dat', Status='Unknown')
    Write(104,'(a)') 
    Write(104,'(a)')'   *******************************        ' 
    Write(104,'(a)')'   * Murrel Sorbie Curve Fitting *        ' 
    Write(104,'(a)')'   *******************************        ' 
    Write(104,'(a)')
    Write(104,'(a)')'  Program written by Gaurab Ganguly       '
    Write(104,'(a)')'  Email: gaurabganguly1989@gmail.com      '
    Write(104,'(a)')
    Write(104,'(a)')'------------------------------------------'
    Write(104,'(a)')' Fitted Parameters:'
    Write(104,'(a)')'------------------------------------------'
    Write(104,'(a,f12.6)') ' a1                         = ', a1
    Write(104,'(a,f12.6)') ' a2                         = ', a2
    Write(104,'(a,f12.6)') ' a3                         = ', a3
    Write(104,'(a,f12.6)') ' RMSE Error in fitting      = ', er
    Write(104,'(a)')'------------------------------------------'
    Write(104,'(a)') 
    Call SpecParams(Mu,r0,De,a1,a2,a3,we,wexe,Be,ae)
    Close(104)
    
    Deallocate ( r, E )

    Write(*,'(a)') 
    Write(*,'(a)') 'Results are written to Results.dat'
    Write(*,'(a)')

End Program Main
