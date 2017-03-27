# agreementMeasure
# agreementMeasure

The Report.Rnw is a knitr document in which all the code necessary to reproduce the results in 
Caceres and Gonzalez 2017 ("Assessing agreement between experiments to distinguish conditions") is given. 

To reproduce the results, open R and type

> library(knitr)
> knitr("Report.Rnw")

this runs the R code and produces a latex file (Report.tex) that can be compiled with your latex compiler, for example:

> system("pdflatex Report.tex")  

You should obtain Report.pdf in which tables and figures and simulations have all been computed from scratch. Report.pdf should be similar to Report_0.pdf, previously ran.

The code without text can be found in the file: code.R.

Preprocessed data for each study has been stored in ./data. Within each study directory there is a README file, that explains how to run such analyses.  

Analyses were done in R-3.1.0.
