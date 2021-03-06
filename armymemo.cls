% Army memo class
% Version 0.1 2011/09/15
% George L. Allen glallen01@gmail.com


\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{armymemo}[2011/09/01]

\LoadClass[
        %titlepage,
        12pt,
        letterpaper,
        headings=small,
        %twoside,
        oneside,
        %parskip=half-,
        %parindent,
        %liststotoc,
        %draft,
        headinclude,
        DIV=15,
        headlines=2,
        pdftex]{scrartcl}

\RequirePackage{fancyhdr}
\RequirePackage[margin=1in]{geometry}
%\RequirePackage[margin=1in,bottom=0.8in,includefoot]{geometry}
\RequirePackage{typearea}
  \setlength{\headheight}{24pt}
  \setlength{\footskip}{24pt}
\RequirePackage[absolute]{textpos}
\RequirePackage[utf8x]{inputenc}		% for windows quotes without having to sed them out
\RequirePackage{fontspec} % Requires Xelatex.  Used to change font face to Arial.
\RequirePackage{tgtermes}
\RequirePackage{color}
\RequirePackage{ctable}
\RequirePackage{datetime} % used to change date format
\RequirePackage{graphicx}
\RequirePackage{microtype}
\RequirePackage{ragged2e} \RaggedRight      	% recommended by jurabib for better ragged right
\RequirePackage{setspace}%\doublespacing    	% turns off in floats and tables
\singlespacing
%\RequirePackage{endnotes}
\RequirePackage{multicol}
\RequirePackage[normalem]{ulem}

%Setting penalties for widows and orphans: broken paragraphs with only one line
%at the top or bottom of the page. This messes up other formatting leaving lots
%of space at the bottom of some pages that requires manual intervention.
%% http://www.tex.ac.uk/cgi-bin/texfaq2html?label=widows
\widowpenalty=10000
\clubpenalty=10000
%  TODO Possible alternate solution, needs testing:
%   http://en.wikibooks.org/wiki/LaTeX/Page_Layout#Widows_and_orphans
%  \setlength{\parskip}{3ex plus 2ex minus 2ex}
%  Additional reference: http://www.economics.utoronto.ca/osborne/latex/PMAKEUP.HTM

% AR 25-50 recommends Arial as of 17 May 2013.  1-17b
\setmainfont{Arial}

% Army date format.  1-23a. Note, this is the long month name
\newdateformat{armydate}{\THEDAY\ \monthname[\THEMONTH] \THEYEAR}

\setlength{\parindent}{2em}

\newcounter{ParNumi}
\newcounter{ParNumii}[ParNumi]
\newcounter{ParNumiii}[ParNumii]
\newcounter{ParNumiiii}[ParNumiii]
\newcounter{ParNumiiiii}[ParNumiiii]

%added \par's for each line to force separation even without linebreaks between \Ni's
%need to do this differently to force a newline at a \par, but to ignore
%additional newlines if there's already a separation
\newcommand{\Ni}{\refstepcounter{ParNumi}\noindent\makebox[\parindent][l]{\arabic{ParNumi}. }}
\newcommand{\Nii}{\refstepcounter{ParNumii}\noindent\hspace{\parindent}\makebox[\parindent][l]{\alph{ParNumii}. }}
\newcommand{\Niii}{\refstepcounter{ParNumiii}\noindent\hspace{2\parindent}\makebox[\parindent][l]{\roman{ParNumiii}. }}
\newcommand{\Niiii}{\refstepcounter{ParNumiiii}\noindent\hspace{3\parindent}\makebox[\parindent][l]{(\arabic{ParNumiiii}) }}
\newcommand{\Niiiii}{\refstepcounter{ParNumiiiii}\noindent\hspace{4\parindent}\makebox[\parindent][l]{(\alph{ParNumiiiii}) }}
\newcommand{\Nx}[1]{\noindent\hspace{#1\parindent}}

% #0 Department
% #1 UNIT
% #2 Address1
% #3 Office Symbol
% #4 Subject

% define the saveboxes for internal use
\newsavebox{\DEPT}
\newsavebox{\UNIT}   
\newsavebox{\ADDRESS}
\newsavebox{\OSYMB}  
\newsavebox{\MEMOFOR}
\newsavebox{\SUBJECT}
\newcommand{\AMfor}[1]{\renewcommand{\AMfor}{#1}}
\newcommand{\AMsubject}[1]{\renewcommand{\AMsubject}{#1}}

% could adjust to add other services or customizable 'dept'
\newcommand{\AMdept}[1]{\sbox{\DEPT}{\textmd{{#1}}}}
\newcommand{\AMunit}[1]{\sbox{\UNIT}{\headfmt{#1}}}
\newcommand{\AMaddress}[1]{\sbox{\ADDRESS}{\headfmt{#1}}}
\newcommand{\AMsymbol}[1]{\sbox{\OSYMB}{#1}}
%\newcommand{\AMsubject}[1]{\sbox{\SUBJECT}{#1}}
%\newcommand{\AMfor}[1]{\sbox{\MEMOFOR}{#1}}

%\newcommand{\AMfor}[1][MEMORANDUM FOR RECORD]{\newsavebox{\MEMOFOR}\sbox{\MEMOFOR}{#1}}

\newcommand{\headfmt}[1]{\uppercase{\footnotesize\textmd{{#1}}}}

\setkomafont{pagehead}{\normalfont}
\setkomafont{pagefoot}{\normalfont}
\setkomafont{pagenumber}{\normalfont}
\setkomafont{disposition}{\normalfont}
\setkomafont{disposition}{\normalfont}

\fancypagestyle{plain}{%
\fancyhf{} %clear all header and footer fields
\lhead{%
\setlength{\unitlength}{1pc}    
\begin{picture}(0,0)
\put(-3,-2.5){\includegraphics[height=1in]{DA_LOGO}}
\end{picture}}
\chead{%
%HEADER and SECTION ADDRESS
\usebox{\DEPT}\\
\usebox{\UNIT}\\
\usebox{\ADDRESS}}
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}
}

\fancypagestyle{body}{%
%\lhead[]{\newgeometry{margin=1.0in,includefoot}\usebox{\OSYMB}\\SUBJECT: \AMsubject\\[24pt]}
\lhead[]{\usebox{\OSYMB}\\SUBJECT: \AMsubject\\}%[24pt]}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}
}

\newcommand{\AMsethead}{
 \setlength{\parskip}{0pt}
 \thispagestyle{plain}
 \pagestyle{body}
 \ \vspace*{12pt}\\      
 \noindent\usebox{\OSYMB}\hfill\armydate\today\\\ \\ \ \\ % two blank lines 2-4a.5
 \noindent \AMfor\\\ \\
 \noindent SUBJECT: \AMsubject\\\ \\% two blank lines 2-4b.1
 \setlength{\parskip}{12pt}%\vspace*{-24pt}
}

% #1 Name
% #2 Rank, Branch
% #3 Title
% #4 Enclosures
\newcommand{\AMsigblock}[4]{
	\setlength{\parskip}{0pt}
	\vspace{48pt}
	\noindent\parbox[t]{3in}{\noindent #4}
	\hfill\parbox[t]{0.5\textwidth}{\uppercase{#1\\#2}\\#3}\\
}
% This should be overscored.
\newcommand{\AMMOAsig}[7]{
	\setlength{\parskip}{0pt}
	\vspace{48pt}
	\begin{minipage}{\textwidth}
	\noindent\parbox[t]{0.45\textwidth}{\noindent #1\\#2\\#3}
	\hfill\parbox[t]{0.45\textwidth}{\uppercase{#4\\#5}\\#6}
	\end{minipage}
	\ \\\vspace{24pt}
	\noindent\parbox[t]{2in}{\noindent #7}
}
