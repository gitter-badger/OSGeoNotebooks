# OSGeo-Live GSOC2015
---

# Open Source Geospatial Notebooks

##Abstract:

   This GSoC 2015 Idea will focus on the development of a cross-projects python library with the aim of bridging together the several software libraries already installed on the live through the use of the  [Jupyter notebook](http://jupyter.org) server in a series of open source geospatial notebooks. 

##Introduction
  
  OSGeo-Live is a self-contained bootable DVD, USB thumb drive or Virtual Machine based on Lubuntu, that allows you to try a wide variety of open source geospatial software without installing anything. It is composed entirely of free software, allowing it to be freely distributed, duplicated and passed around. It provides pre-configured applications for a range of geospatial use cases, including storage, publishing, viewing, analysis and manipulation of data. It also contains sample datasets and documentation.

##Background
 
   The OSGeo-Live user has access to a wide set of desktop and web GIS application, which are easily accessible from the OS application-menu and for each software a quick-starts introduction is available to help new users to get started. 
   The documentation is automatically built during the live-disc generation process from a set of RST files, one for each project, and is accessible via web browser. 
   On the OSGeo-Live also a large number of software libraries is installed and ready for use, most of them are accessible from command line or via python bindings other are accessible via specific software like R, commonly used for statistical analysis. All this software libraries, at the  moment, are hidden under the hood of the OSGeo-Live with missed or poor documentation. Moreover they can complete specific tasks like I/O, Statistic analysis, geoprocessing, Chart display and more.
 
##The idea
  
  This GSoC 2015 Idea will focus on the development of a set cross-projects digital notebooks with the aim of bridging together the several software libraries already installed on the OSGeo-Live through the use of the Jupyter notebook. The work will consist in integrate descriptive documentation and code samples in a series of "topic-oriented" geospatial notebooks.
 
  The notebooks developed for this work will run different programming languages including Python2, Python3, R, Octave Bash and more. 
  Thanks to the support of multiple kernels it is possible to include in a notebook any command line tool installed on OSGeo-Live. 
  Since one of the main goals of OSGeo-Live is for education, this will substantially improve the *live-user* experience in having access to many tools under the OSGeo umbrella. 
  The OSGeo-Live user will learn how to bring all this software together as well as learn how to process geospatial data using other standard scientific tools for data exploration.

###[Notebooks](https://github.com/epifanio/OSGeoNotebooks/blob/master/GSOC/notebooks/Introduction.ipynb)

---

[![Binder](http://mybinder.org/badge.svg)](http://mybinder.org/repo/epifanio/OSGeoNotebooks)

[![Join the chat at https://gitter.im/epifanio/OSGeoNotebooks](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/epifanio/OSGeoNotebooks?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)