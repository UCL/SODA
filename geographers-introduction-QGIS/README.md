
## A Geographer's Introduction to QGIS

This is the readme file for the A Geographer's Introduction to QGIS practical work. The main listing for the resource is https://www.rgs.org/research/higher-education-resources/a-geographers-introduction-to-qgis and when directing people to the resource, use this link. 

This repository is listed on the RGS website and also includes some direct links to resources. If you want to update the resource, please note that the repository only contains the source files (Quarto and images). The compiled PDF and HTML files are not stored in the repository. They are stored as binaries under a release. 

The links are:
- https://github.com/UCL/SODA/releases/latest/download/manual-qgis.pdf
- https://github.com/UCL/SODA/releases/latest/download/manual-qgis.html
- https://github.com/UCL/SODA/releases/latest/download/manual-r.pdf
- https://github.com/UCL/SODA/releases/latest/download/manual-r.html
- https://github.com/UCL/SODA/releases/latest/download/lesson-2-data.zip
- https://github.com/UCL/SODA/releases/latest/download/lesson-3-data.zip
- https://github.com/UCL/SODA/releases/latest/download/lesson-5-data.zip
- https://github.com/UCL/SODA/releases/latest/download/lesson-6-data.zip

If you have a small update, you do not need to update the compiled files. See [here](editing-on-github.md) for details on how to do this using GitHub. Or you can update the source files in the repository, and submit a pull request. This will be reviewed and merged if appropriate. The source PDF and HTML files will then be manually updated. 

To compile the R material locally, you need to extract the data in to a working folder. This is set on line 16 of `manual-r.qmd` and is currently set to `C:/Users/nick/Documents/GIS/sdi-data`. Extract a copy of all of the zip data files (`lesson-2-data.zip`, `lesson-3-data.zip`, `lesson-5-data.zip` and `lesson-6-data.zip`). Some of the files are duplicated, it should not matter whether you overwrite files or not. Set this folder to whatever you want, and then it should compile fine. 

If you want to update the complied files, clone the repository on to your own machine as normal. Make the changes and make sure both HTML and PDF versions of the material compile locally. I have used RStudio to write these, and used the **Render** tool within RStudio. 

The QGIS HTML materials take a few seconds to render, and the QGIS PDF materials take about a minute to render. The R materials take longer to render because all of the R commands are run. For me, the HTML version of the R material took about 8 min to render, and the PDF took about 19 min to render. 

Once you are happy it compiles locally fine, submit a Pull Request, or a Push if you have permissions and update the source files. 

To make the new compiled files accessible, go to [Releases](https://github.com/UCL/SODA/releases) and **Draft a new release**. Choose a new version tag, and summarise the changes since the previous release. Make your you update the version number in the final line of the materials. Now attach the compiled materials and data in the *Attach binaries by dropping them here or selecting them". Choose **Publish Release**. 

GitHub will update the 'Latest' release to the one you have just submitted. All the links will point to the 'latest' release. 

For example, for v1.0, a link would be:

	> https://github.com/UCL/SODA/releases/download/v1.0/lesson-2-data.zip

But we can tweak this to get the latest version:

	> https://github.com/UCL/SODA/releases/latest/download/lesson-2-data.zip

We have done this will all of the links on the RGS page. 

Any questions, please raise an [issue](https://github.com/UCL/SODA/issues). 
