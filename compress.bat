@ECHO OFF
if exist "decompress" rmdir /Q /S decompress

for %%f in (input\*.epub) do (	
	if not exist "input" mkdir input
	if not exist "OEBPS" mkdir OEBPS
	if not exist "OEBPS\images" mkdir OEBPS\images
	if not exist "finished" mkdir finished
	if not exist "decompress" mkdir decompress
	

	7z.exe x "%%f" -aoa -o"%cd%\decompress\%%~nf"
	COPY "%%f" "finished\%%~nf.zip"
	for %%g in ("%cd%\decompress\%%~nf\OEBPS\images\*.jpg") do (
		echo Compressing image %%~nxg
		cjpeg -quality 80 "%%g" > OEBPS/images/%%~nxg
	)
	zip -r9 "%cd%\finished\%%~nf.zip" OEBPS
	rename "%cd%\finished\%%~nf.zip" "%%~nf.epub"
	
	
	if exist "OEBPS" rmdir /Q /S OEBPS
)
Echo.
Echo.
Echo.
Echo Finished
Echo.
Echo.
Echo.
pause