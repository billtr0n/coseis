!     -*- f90 -*-
!     This file is autogenerated with f2py (version:2_4954)
!     It contains Fortran 90 wrappers to fortran functions.

      subroutine f2pywrap_m_util_timer (timerf2pywrap, i)
      use m_util, only : timer
      integer i
      real timerf2pywrap
      timerf2pywrap = timer(i)
      end subroutine f2pywrap_m_util_timer
      
      subroutine f2pyinitm_util(f2pysetupfunc)
      use m_util, only : zone
      use m_util, only : cube
      use m_util, only : invert
      use m_util, only : scalaraverage
      use m_util, only : vectoraverage
      use m_util, only : radius
      use m_util, only : vectornorm
      use m_util, only : tensornorm
      use m_util, only : scalarsethalo
      use m_util, only : vectorsethalo
      use m_util, only : strtok
      interface 
      subroutine f2pywrap_m_util_timer (timerf2pywrap, i)
      integer i
      real timerf2pywrap
      end subroutine f2pywrap_m_util_timer
      end interface
      external f2pysetupfunc
      call f2pysetupfunc(zone,cube,invert,scalaraverage,vectoraverage,ra&
     &dius,vectornorm,tensornorm,scalarsethalo,vectorsethalo,f2pywrap_m_&
     &util_timer,strtok)
      end subroutine f2pyinitm_util


