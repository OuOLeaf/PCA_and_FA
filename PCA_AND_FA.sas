proc print data= f;
var famrel factor4;
where factor4>1;
run;
proc factor res data = score2 cov
method=principle nfact=5 rotate=varimax score HEYWOOD out = f;
var _all_;

run;
proc import datafile = "D:\Dropbox\Andy\Multivariate_Statistics\Student_Performance\Maths.csv" out = score replace;
run;
data score2;
set score;
where school = "MS";
keep medu fedu traveltime studytime failures famrel freetime goout dalc walc health absences;
run;
ods trace on;
proc princomp data = score2 cov;
var _all_;
ods output eigenvalues = eva eigenvectors = eve SimpleStatistics = ss;
run;
data ss;
set ss;
array pc {12} Medu Fedu traveltime studytime failures famrel freetime goout Dalc Walc health absences ;
do i = 1 to 12;
pc{i} = round(pc{i},0.01);
end;
format Medu Fedu traveltime studytime failures famrel freetime goout Dalc Walc health absences  best4.3;
run;
proc print data= ss;run;

ods trace off;
data eve2;
set eve;
array pc {12} prin:;
do i = 1 to 12;
pc{i} = round(pc{i},0.01);
end;
format prin: best4.3;
run;
proc print noobs;
var variable prin1-prin6;
run;
data eva2;
set eva;

eigenvalue = round(eigenvalue,0.01);
cumulative_str = cat(round(cumulative,0.01) * 100, "%");
format eigenvalue best4.3;
run;
proc print data = eva2 noobs;
var eigenvalue;
run;

ods trace off;

proc corr data = score2 cov;
var _all_;
run;
ods trace on;
/*Factor Analysis*/
proc factor res data = score2 cov
method=principle nfact=6 rotate=varimax score HEYWOOD out = f;
var _all_;
ods output OrthRotFactPat = ORFP FinalCommunWgt = FCW;
run;
data ORFP2;
set ORFP;
factor1 = round(factor1, 0.01);
factor2 = round(factor2, 0.01);
factor3 = round(factor3, 0.01);
factor4 = round(factor4, 0.01);
factor5 = round(factor5, 0.01);
factor6 = round(factor6, 0.01);
format factor: best3.2;
RUN;
data FCW2;
set FCW;
rename communality = com;

run;
data FCW3;
SET FCW2;
com = round(com, 0.01);
format com best3.2;
keep com;
run;
proc print noobs;run;

ods trace off;
proc means data = score2 mean var;
var _all_;
run;
proc print data= f;
var Dalc Walc factor1;
where factor1>1;
run;
proc print data= f;
var freetime goout factor3;
where factor3>1;
run;
proc print data= f;
var famrel factor4;
where factor4>1;
run;
proc print data= f;
var health factor5;
where factor5>1;
run;
proc print data= f;
var absences factor6;
where factor6>1;
run;
