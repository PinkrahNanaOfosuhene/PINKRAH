load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/diagnostics_cam.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

f1 = addfile("monthly_climatology_1961_1970_Ghana_tmp.nc","r")

prec1 = f1->tmp

lat   = f1->lat
lon   = f1->lon

wks = gsn_open_wks("png","PINKRAH")
;------------------------------------------------------------------------

res  = True
res@gsnDraw  = False
res@gsnFrame = False
res@mpMinLatF  =  4.5   
res@mpMaxLatF  =  11.5  
res@mpMinLonF  =  -3.3
res@mpMaxLonF  = 1.3

res@cnLevelSelectionMode = "ExplicitLevels"

res@cnLevels             = (/-20,-16,-12,-8,-4,0,4,8,12,16,20/)

gsn_define_colormap(wks,"CBR_coldhot")

res@cnLevelSelectionMode                                       = "ManualLevels" ;-- set contour levels manually
res@cnMinLevelValF                                             = 20     ;-- minimum contour level
res@cnMaxLevelValF                                             = 30       ;-- maximum contour level
res@cnLevelSpacingF                                            = 1 ;-- contour level spacing

res@pmTickMarkDisplayMode       = "Always"

res@cnLineDashSegLenF           = 0.3
res@cnFillOn                    = True         
res@cnLinesOn                   = True
res@cnLineLabelsOn              = True

res@sfXArray  = lon
res@sfYArray  = lat
;res@sfElementNodes = RR
;res@sfFirstNodeIndex = 0

res@pmTickMarkDisplayMode = "Always"   ; nicer tickmarks
res@mpDataBaseVersion     = "MediumRes"       ; better and more map outlines
res@mpDataSetName         = "Earth..4"
res@mpOutlineBoundarySets = "AllBoundaries"
;res@mpOutlineBoundarySets  = "National"
res@mpGeophysicalLineColor = "Black"
res@mpNationalLineColor    = "Black"
res@mpUSStateLineColor     = "Black"
res@mpUSStateLineThicknessF     = 2.        ; default is 1.0
res@mpNationalLineThicknessF    = 2.
res@mpGeophysicalLineThicknessF = 2.
res@mpOutlineOn           = True

res@gsnAddCyclic                                               = False 


res@lbOrientation         = "Vertical"
res@tiMainOffsetYF        = 0.01           ; Move the title down
res@tiMainString  = "T2"

;----------------------MASKING------------------------------------
mask_areas = (/"Ghana"/);,"Ocean"/)
res@mpMaskAreaSpecifiers  = mask_areas              ; keep these regions
res@mpOutlineSpecifiers = mask_areas              ; outline these regions
res@mpOceanFillColor = 0                        ; fill the oceans with index 0 (=white)
res@mpLandFillColor = 0                       ; fill the land with index 0 (=white)
;res@mpInlandWaterFillColor = 0               ; fill the inland water with index 0 (=white)
res@mpFillDrawOrder       = "PostDraw"     ; fille the ocean, land, and inland water last, but do not 

;------------------------------------------------------------------
;plot = gsn_csm_contour_map_ce(wks,prec1,res)

plot = gsn_csm_contour_map(wks,prec1(0,:,:),res)

;---Attach three different sets of shapefile outlines to map-------
lnres                  = True
lnres@gsLineColor      = "black"
lnres@gsLineThicknessF = 0.1
shmp = gsn_add_shapefile_polylines(wks,plot,"GHA_adm1.shp",lnres)

draw(plot)
frame(wks)

;----------------------------write netCDF ------------------------------
;out = "rr_obs31_01jun13.nc"
;nCDF = addfile (out,"c")
;nCDF ->RR = RR

end

