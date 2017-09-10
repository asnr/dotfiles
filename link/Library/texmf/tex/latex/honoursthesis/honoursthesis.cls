\ProvidesClass{honoursthesis}

%Pass options on
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions

\LoadClass{book}

% line-spacing factor
\renewcommand{\baselinestretch}{1.2}

% no headers and page numbers on
% blank pages at the end of chapters
\newcommand{\blanknonumber}{\newpage\thispagestyle{empty}}

% margins
 \setlength{\voffset}{-1in}
 \setlength{\hoffset}{-1in}
 \setlength{\oddsidemargin}{4cm}
 \setlength{\evensidemargin}{2.5cm}
 \setlength{\textwidth}{14.5cm}
 \setlength{\textheight}{22.5cm}
 \setlength{\topmargin}{2.5cm}
  

%\usepackage[top=2.5cm,bottom=2cm,left=3cm,right=3cm]{geometry}

% needed for pictures
\usepackage{graphicx}


% probably not even necessary:
%\usepackage{fancyhdr}

% Dutch style of paragraph formatting, i.e. no indents. 
%\setlength{\parskip}{1.3ex plus 0.2ex minus 0.2ex}
%\setlength{\parindent}{0pt}
