;
;--------------------------------------------------

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
;-- read data and set variable references

   f1 = addfile("difference.nc","r")
   f2 = addfile("annual_1962_1971_GHA_CRU.nc","r")
   f3 = addfile("annual_1972_1981_GHA_CRU.nc","r") 
   f4 = addfile("annual_difference.nc","r")

   T1 = f1->tmp
   T2 = f2->tmp
   T3 = f3->tmp
   T4 = f4->tmp
   lat   = f1->lat
   lon   = f1->lon

; Change the lat lon units of prec1..4 degrees_north and degrees_east
   ; prec1&lat@units="degrees_north"
  ;  prec1&lon@units="degrees_east"
   ; prec2&lat@units="degrees_north"
   ; prec2&lon@units="degrees_east"
   ; prec3&lat@units="degrees_north"
   ; prec3&lon@units="degrees_east"
    ;prec4&lat@units="degrees_north"
    ;prec4&lon@units="degrees_east"


;-- open a PNG file
   wks = gsn_open_wks("pdf","1981-2010_climatological_seasonal_mean_temperature_for_WA")

;-- create plot array
   plot = new(4,graphic)

   gsn_define_colormap(wks,"CBR_coldhot")                         ;-- change

;-- set resources

   res                                                            = True           ;-- resource varb
             
  



   res@mpFillOn                                                   = False        ; turn off gray fill
   res@mpOutlineBoundarySets                                      = "National"   ; turn on country boundaries
   res@mpGeophysicalLineColor                                     = "Black"       ; color of cont. outlines
   res@mpGeophysicalLineThicknessF                                = 1.5          ; thickness of outlines

   
   res@lbLabelBarOn                                               = False           ; turn off individual cb's
   res@gsnMaximize                                                = True
   res@vpWidthF                                                   = 0.8     ; make the plot wider than it is high
   res@vpHeightF                                                  = 0.8

   res@cnFillOn                                                   = True           ;-- turn on color
   res@cnLinesOn                                                  = False          ;-- no contour lines
   res@cnLineLabelsOn                                             = False          ;-- turn off line labels
   res@lbBoxMinorExtentF                                          = 0.15           ;-- decrease the height of the labelbar
   res@lbOrientation                                              = "vertical"     ;-- orientation of colour bar
   res@tiMainOn                                                   = True
   res@tiMainFontHeightF                                          = 0.03           ;-- main title height
   res@tiMainFont                                                 = 26             ;-- main title font size
   res@tiMainString                                               = "DJF"
   res@tiXAxisString                                              = lon@long_name
   res@tiYAxisString                                              = lat@long_name
   res@tiXAxisOffsetXF                                            = -0.02           ;-- move x-axis label away from the y-line
   res@tiXAxisOffsetYF                                            = -0.001           ;-- move x-axis label away from the x-line 
   res@tiYAxisOffsetXF                                            = -0.01           ;-- move y-axis label away from the y-line
   res@tiYAxisOffsetYF                                            = -0.05           ;-- move y-axis label away from the x-line

   res@cnLevelSelectionMode                                       = "ManualLevels" ;-- set contour levels manually
   res@cnMinLevelValF                                             = 100          ;-- minimum contour level
   res@cnMaxLevelValF                                             = -200         ;-- maximum contour level
   res@cnLevelSpacingF                                            = 1              ;-- contour level spacing
;-- Set the map (lon/lat) limits
   res@mpMinLatF                                                  = -3.5      
   res@mpMaxLatF                                                  = 1.5
   res@mpMinLonF                                                  = 4.5
   res@mpMaxLonF                                                  = 11.5
   
   
   ;res@gsnSpreadColors                                             = True         ;-- full colors
   ;res@pmLabelBarDisplayMode                                       = "Always"

   res@mpDataBaseVersion                                          = "MediumRes"  ;-- better map resolution
   res@gsnAddCyclic                                               = False        ;-- Do not add cyclic valeu since it is regional not global

   plot(0) = gsn_csm_contour_map(wks,T1(0,:,:),res)

   res@tiMainString                                               = "difference"
   plot(1) = gsn_csm_contour_map(wks,T2(0,:,:),res)
   
   res@tiMainString                                               = "annual"
   plot(2) = gsn_csm_contour_map(wks,T3(0,:,:),res)

   res@tiMainString                                               = "annual"
   plot(3) = gsn_csm_contour_map(wks,T4(0,:,:),res)

   resP                                                          = True 
   resP@txString                                                 = "1981-2010_climatological_seasonal_mean_temperature_for_Ghana (K)"
   resP@gsnPanelLabelBar                                          = True                ; add common colorbar
   resP@lbLabelFontHeightF                                        = 0.015               ; make labels smaller 

   gsn_panel(wks,plot,(/2,2/),resP)

end
