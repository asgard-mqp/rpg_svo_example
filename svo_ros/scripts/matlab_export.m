function matlab_export(camera_params)
intrin = camera_params.Intrinsics;
forwardPoly = intrin.MappingCoefficients;
size = intrin.ImageSize;
poly = [-forwardPoly(1);0;-forwardPoly(2);-forwardPoly(3);-forwardPoly(4)];
invpol = findinvpoly(poly,sqrt((size(1)/2)^2+(size(2)/2)^2));

fid = fopen('calib_results.txt', 'w');

fprintf(fid,'#polynomial coefficients for the DIRECT mapping function (ocam_model.ss in MATLAB). These are used by cam2world\n\n');

fprintf(fid,'%d ',length(poly)); %write number of coefficients
for i = 1:length(poly)
    fprintf(fid,'%e ',poly(i));
end

fprintf(fid,'\n\n');

fprintf(fid,'#polynomial coefficients for the inverse mapping function (ocam_model.invpol in MATLAB). These are used by world2cam\n\n');

fprintf(fid,'%d ',length(invpol)); %write number of coefficients
for i = 1:length(invpol)
    fprintf(fid,'%f ',invpol(end-i+1));
end

fprintf(fid,'\n\n');

fprintf(fid,'#center: "row" and "column", starting from 0 (C convention)\n\n');

distCenter = intrin.DistortionCenter;
fprintf(fid,'%f %f\n\n',distCenter(2)-1, distCenter(1)-1);

fprintf(fid,'#affine parameters "c", "d", "e"\n\n');
stretch = intrin.StretchMatrix;
fprintf(fid,'%f %f %f\n\n',stretch(1), stretch(2),stretch(3));

fprintf(fid,'#image size: "height" and "width"\n\n');

fprintf(fid,'%d %d\n\n',size(1), size(2));

fclose(fid);