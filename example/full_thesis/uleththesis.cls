\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uleththesis}[2013/11/17 v0.3 University of Lethbridge Thesis]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Options
%%%%   - 10pt or 11pt or 12pt (default)
%%%%   - final (default) or draft
%%%%   - ma or msc (default) or phd
%%%%   - cs or math or physics  (no default set -- must choose one)
%%%%
%%%%   - Any other command gets passed directly to the ``report'' class.
%%%%      (note that using other options may result in incorrect formatting)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\nofiles\relax

% Set the defaults
\newcommand{\@myptsize}{12}
\newcommand{\@draft}{0}
\newcommand{\@degreetype}{1}
\newcommand{\@subject}{0}

% Size of font -- 12 is default
\DeclareOption{10pt}{\renewcommand{\@myptsize}{10}}
\DeclareOption{11pt}{\renewcommand{\@myptsize}{11}}
\DeclareOption{12pt}{\renewcommand{\@myptsize}{12}}

% Whether it is a draft or not
\DeclareOption{final}{\renewcommand{\@draft}{0}}
\DeclareOption{draft}{\renewcommand{\@draft}{1}}

% Which degree you are getting
\DeclareOption{ma}{\renewcommand{\@degreetype}{0}}
\DeclareOption{msc}{\renewcommand{\@degreetype}{1}}
\DeclareOption{phd}{\renewcommand{\@degreetype}{2}}

% Which discipline you are in (formats the thesis a little different)
\DeclareOption{cs}{\renewcommand{\@subject}{1}}
\DeclareOption{math}{\renewcommand{\@subject}{2}}
\DeclareOption{physics}{\renewcommand{\@subject}{3}}

% Everything else gets passed to the memoir class
\DeclareOption{*}{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{12pt,final,msc}
\ProcessOptions

\PassOptionsToClass{\@myptsize pt,letterpaper,oneside}{report}

% Now load the report class, and configure it appropriately.
\LoadClass{report}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Commands to set variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\degreeyear}[1]{\gdef\@degreeyear{#1}}
\newcommand{\prevdegrees}[1]{\gdef\@prevdegrees{#1}}

\newcounter{numsignature}
\newcommand{\addsignatureline}[2]{
  \ifnum\value{numsignature}=0 \gdef\@memAname{#1}\gdef\@memA{#2} \fi
  \ifnum\value{numsignature}=1 \gdef\@memBname{#1}\gdef\@memB{#2} \fi
  \ifnum\value{numsignature}=2 \gdef\@memCname{#1}\gdef\@memC{#2} \fi
  \ifnum\value{numsignature}=3 \gdef\@memDname{#1}\gdef\@memD{#2} \fi
  \ifnum\value{numsignature}=4 \gdef\@memEname{#1}\gdef\@memE{#2} \fi
  \ifnum\value{numsignature}=5 \gdef\@memFname{#1}\gdef\@memF{#2} \fi
  \ifnum\value{numsignature}=6 \gdef\@memGname{#1}\gdef\@memG{#2} \fi
  \ifnum\value{numsignature}=7 \gdef\@memHname{#1}\gdef\@memH{#2} \fi
  \ifnum\value{numsignature}=8 \gdef\@memIname{#1}\gdef\@memI{#2} \fi
  \addtocounter{numsignature}{1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Various Titles
%%%%    Change these only if you have a good reason (e.g., different language)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\contentsname{Contents}                 % \tableofcontents
%                 ~~~~~~~~
\def\listfigurename{List of Figures}        % \listoffigures
%                   ~~~~~~~~~~~~~~~
\def\listtablename{List of Tables}          % \listoftables
%                  ~~~~~~~~~~~~~~
\def\listabbrevname{List of Abbreviations}  % \listofabbreviations
%                   ~~~~~~~~~~~~~~~~~~~~~
\def\listnotationname{List of Notations}    % \listofnotation
%                     ~~~~~~~~~~~~~~~~~
\def\bibname{Bibliography}                  % \bibliography
%            ~~~~~~~~~~~~
\def\indexname{Index}                       % \theindex
%              ~~~~~
\def\figurename{Figure}                     % \begin{figure}
%               ~~~~~~
\def\tablename{Table}                       % \begin{table}
%              ~~~~~
\def\chaptername{Chapter}                   % \chapter and \chapter*
%                ~~~~~~~
\def\appendixname{Appendix}                 % \appendix
%                 ~~~~~~~~
\def\partname{Part}                         % \part
%             ~~~~
\def\abstractname{Abstract}                 % \begin{abstract}
%                 ~~~~~~~~
\def\acknowledgename{Acknowledgments}       % \begin{acknowledgments}
%                    ~~~~~~~~~~~~~~~
\def\dedicationname{Dedication}             % \begin{dedication}
%                   ~~~~~~~~~~

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Margins / Double and single spacing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifnum\@draft=1
 \RequirePackage[letterpaper,left=1in,top=1in,right=1in,bottom=1in]{geometry}
\else
 \RequirePackage[letterpaper,left=3.8cm,top=2.5cm,right=2.5cm,bottom=2.5cm]{geometry}
\fi
\RequirePackage{setspace,fancyhdr}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Some Sanity Checks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifnum\@subject=0
  \ClassWarningNoLine{uleththesis}
    { ***** Need to declare your discipline (cs, math, physics) ***** }
  \renewcommand{\@subject}{2}
\fi

\ifnum\@draft=1
 \ClassWarningNoLine{uleththesis}
   {Draft mode disables most title pages and removes most ``overfull errors''.}
 \hfuzz=50pt % Ignore most overfull errors except very bad ones...
\fi

\newcommand{\errorifnotdefined}[1]{\@ifundefined{@#1}{
  \ClassError{uleththesis}{***** #1 is not declared *****}}{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Initialize variables for Title Page and Approval Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\setdegreeinfo}{
 \ifnum\@degreetype=0 \gdef\@degree{Master of Arts} \fi
 \ifnum\@degreetype=1 \gdef\@degree{Master of Science} \fi
 \ifnum\@degreetype=2 \gdef\@degree{Doctor of Philosophy} \fi

 \ifnum\@subject=1 \gdef\@department{Mathematics and Computer Science} \fi
 \ifnum\@subject=2 \gdef\@department{Mathematics and Computer Science} \fi
 \ifnum\@subject=3 \gdef\@department{Physics and Astronomy} \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Title Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\ulethtitle}{
\ifnum\@draft=0
 \setdegreeinfo
 \errorifnotdefined{title}
 \errorifnotdefined{author}
 \errorifnotdefined{degree}
 \errorifnotdefined{department}
 \errorifnotdefined{degreeyear}

  \protect\thispagestyle{empty}
  \vspace*{\fill}
  \begin{singlespace}
    \begin{center}
      {\bf
        \MakeUppercase{\@title}     % TITLE

        \vspace{2.5cm}
        \MakeUppercase{\@author}\\  % NAME
        \@prevdegrees               % Previous Degrees
      }
      
      \vspace{4cm}
      {
        A Thesis\\
        Submitted to the School of Graduate Studies\\
        of the University of Lethbridge\\
        in Partial Fulfillment of the\\
        Requirements for the Degree
      }
      
      \vspace{5mm}
      {\bf \MakeUppercase{\@degree} }   % DEGREE NAME
      
      \vspace{1.5cm}
      {
        Department of \@department\\
        University of Lethbridge\\
        LETHBRIDGE, ALBERTA, CANADA
      }
      
      \vspace{1.5cm}
      {\copyright{} \@author, \@degreeyear}
      
    \end{center}
  \end{singlespace}
  \vspace*{\fill}
  \clearpage
\fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Signature/Approval Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\signslot}[2]{\vspace{8mm} \\
      \rule{9cm}{0.25mm} & \rule{3cm}{0.25mm} \\
      \multicolumn{2}{@{}l@{}}{#2: #1} \\
      }

\newcommand{\ulethapproval}{
\ifnum\@draft=0
 \errorifnotdefined{title}
 \errorifnotdefined{author}
  
  \addcontentsline{toc}{chapter}{Approval/Signature Page}
  \protect\thispagestyle{empty}
  \vspace*{\fill}
  \begin{singlespace}
    {
      \begin{center}
        \MakeUppercase{\@title} % TITLE

        \vspace{5mm}
        \MakeUppercase{\@author} % NAME
      \end{center}
    }
    
    \vspace{1cm}

    Approved:

    \vspace{1cm}
    
    \begin{tabular}{@{}ll@{}}
      {\em Signature} & {\em Date} \\
       \ifnum\value{numsignature}>0 \errorifnotdefined{memAname} \signslot{\@memAname}{\@memA} \fi
       \ifnum\value{numsignature}>1 \errorifnotdefined{memBname} \signslot{\@memBname}{\@memB} \fi
       \ifnum\value{numsignature}>2 \errorifnotdefined{memCname} \signslot{\@memCname}{\@memC} \fi
       \ifnum\value{numsignature}>3 \errorifnotdefined{memDname} \signslot{\@memDname}{\@memD} \fi
       \ifnum\value{numsignature}>4 \errorifnotdefined{memEname} \signslot{\@memEname}{\@memE} \fi
       \ifnum\value{numsignature}>5 \errorifnotdefined{memFname} \signslot{\@memFname}{\@memF} \fi
       \ifnum\value{numsignature}>6 \errorifnotdefined{memGname} \signslot{\@memGname}{\@memG} \fi
       \ifnum\value{numsignature}>7 \errorifnotdefined{memHname} \signslot{\@memHname}{\@memH} \fi
       \ifnum\value{numsignature}>8 \errorifnotdefined{memIname} \signslot{\@memIname}{\@memI} \fi
    \end{tabular}  
    
  \end{singlespace}
  \vspace*{\fill}
  \clearpage
\fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\origtable=\table
\let\origendtable=\endtable
\renewenvironment{table}
{\origtable\begin{singlespace}}{\end{singlespace}\origendtable}  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Table of Contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\origtableofcontents=\tableofcontents
\renewcommand{\tableofcontents}{
 \clearpage
 \setcounter{tocdepth}{2}
 \addcontentsline{toc}{chapter}{\contentsname}
 \chaptermarknonum{\contentsname}
 \begin{singlespace}
  \thispagestyle{plain}
  \origtableofcontents
 \end{singlespace}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  List of Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\origlistoftables=\listoftables
 \renewcommand{\listoftables}{
  \ifnum\@draft=0
   \clearpage
   \addcontentsline{toc}{chapter}{\listtablename}
   \chaptermarknonum{\listtablename}
    \begin{singlespace}
     \origlistoftables
    \end{singlespace}
  \fi
 }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  List of Figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\origlistoffigures=\listoffigures
\renewcommand{\listoffigures}{
  \ifnum\@draft=0
   \clearpage
   \addcontentsline{toc}{chapter}{\listfigurename}
   \chaptermarknonum{\listfigurename}
   \begin{singlespace}
    \origlistoffigures
   \end{singlespace}
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Footnotes -- This makes the footnotes count continuously from the start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@removefromreset#1#2{\let\@tempb\@elt
   \expandafter\let\expandafter\@tempa\csname c@#1\endcsname
   \def\@elt##1{\expandafter\ifx\csname c@##1\endcsname\@tempa\else
         \noexpand\@elt{##1}\fi}%
   \expandafter\edef\csname cl@#2\endcsname{\csname cl@#2\endcsname}%
   \let\@elt\@tempb}
% use the command \@removefromreset to undo the \@addtoreset in report.cls:
\@removefromreset{footnote}{chapter}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\origbibliography=\bibliography
\renewcommand{\bibliography}[1]{
  \clearpage
  \begin{singlespace}
   \addcontentsline{toc}{chapter}{\bibname}
    \ifnum\@subject=1 \bibliographystyle{plain} \fi
    \ifnum\@subject=2 \bibliographystyle{plain} \fi
    \ifnum\@subject=3 \bibliographystyle{unsrt} \fi
   \origbibliography{#1}
  \end{singlespace}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Quotes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\origquote=\quote
\let\origendquote=\endquote
\renewenvironment{quote}
{\origquote\begin{singlespace}}{\end{singlespace}\origendquote}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Front/Main Matter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\frontmatter}{
 \setcounter{page}{1}
 \renewcommand{\thepage}{\roman{page}}
 \renewcommand{\thechapter}{\arabic{chapter}}
}
\newcommand{\mainmatter}{
 \clearpage
 \renewcommand{\thepage}{\arabic{page}}
 \setcounter{page}{1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Chapter/Section Headings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\spaceabovechapter}{25pt}
\newcommand{\spacebetweenchapterandname}{20pt}
\newcommand{\spacebelowchaptername}{35pt}
\newcommand{\chaptersize}{\huge}
\newcommand{\chapternamesize}{\huge}
\newcommand\sectionsize{\large}
\newcommand\subsectionsize{\normalsize}
\newcommand\subsubsectionsize{\normalsize}

\renewcommand{\@makechapterhead}[1]{ % This is for \chapter
  \clearpage
  \chaptermark{#1}
  \begin{singlespace}
    \vspace*{\spaceabovechapter}%
    {\raggedright \normalfont
      \chaptersize \bfseries \chaptername \space \thechapter
      \vskip \spacebetweenchapterandname
      \interlinepenalty\@M % Don't break the chapter name over two lines
      \chapternamesize \bfseries #1\par\nobreak
      \vskip \spacebelowchaptername
    }
  \end{singlespace}
}

\renewcommand{\@makeschapterhead}[1]{ % This is for \chapter*
  \clearpage
  \chaptermarknonum{#1}
  \begin{singlespace}
    \vspace*{\spaceabovechapter}%
    {\raggedright \normalfont
      \interlinepenalty\@M % Don't break the chapter name over two lines
      \chapternamesize \bfseries #1\par\nobreak
      \vskip \spacebelowchaptername
    }
  \end{singlespace}
}

\renewcommand{\section}{\@startsection {section}{1}{\z@}%
                                   {3.5ex \@plus 1ex \@minus .2ex}%
                                   {.5ex \@plus .3ex}%{1.4ex \@plus.2ex}%
                                   {\normalfont\sectionsize\bfseries}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {.3ex \@plus .2ex}%{1.2ex \@plus .2ex}%
                                     {\normalfont\subsectionsize\bfseries}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {.2ex \@plus .1ex}%{1ex \@plus .2ex}%
                                     {\normalfont\subsubsectionsize\bfseries}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Abstract / Dedication / Acknowledgments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifnum\@draft=1
 \renewenvironment{abstract}{\chapter*{\abstractname}}{}
 \newcommand{\dedication}[1]{}      % Do not show dedication on draft
 \newcommand{\acknowledgments}[1]{} % Do not show acknowledgments on draft
\else
 \renewenvironment{abstract}{\chapter*{\abstractname}}{}
 \newcommand{\dedication}[1]{\chapter*{\dedicationname} \begin{center} #1 \end{center}}
 \newcommand{\acknowledgments}[1]{\chapter*{\acknowledgename} #1}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Appendix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\appendix}{\par
  \clearpage
  \setcounter{chapter}{0}
  \setcounter{section}{0}
  \renewcommand\chaptername{\appendixname}
  \renewcommand{\thechapter}{\Alph{chapter}}
  \singlespacing
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Headers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@ulethheaderinfo}{}
\renewcommand{\markboth}{\@gobbletwo}
\renewcommand{\markright}{\@gobble}

\pagestyle{fancy}

\setlength{\headheight}{15pt}
\fancyhead{}
\fancyhead[R]{\@ulethheaderinfo}
\fancyfoot{}
\fancyfoot[C]{\thepage}

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.0pt}

\ifnum\@draft=1
 \fancyfoot[L]{DRAFT}   \fancyfoot[R]{\today}
\fi


\renewcommand{\chaptermark}[1]{
 \renewcommand{\@ulethheaderinfo}{\thechapter.~\MakeUppercase{#1}}
 \fancyhead[R]{\@ulethheaderinfo}
}
\renewcommand{\sectionmark}[1]{
 \renewcommand{\@ulethheaderinfo}{\thesection.~\MakeUppercase{#1}}
 \fancyhead[R]{\@ulethheaderinfo}
}
\renewcommand{\subsectionmark}[1]{}
\renewcommand{\subsubsectionmark}[1]{}

\newcommand{\chaptermarknonum}[1]{
 \renewcommand{\@ulethheaderinfo}{\MakeUppercase{#1}}
 \fancyhead[R]{\@ulethheaderinfo}
}

\def\ps@plain{
 \ifnum\@draft=1
  \def\@oddfoot{DRAFT \hfil \thepage \hfil \today}   % Footer
 \else
  \def\@oddfoot{\hfil \thepage \hfil}                % Footer
 \fi
 \def\@oddhead{}                                     % Header
 \def\@evenfoot\@oddfoot{}\def\@evenhead\@oddhead{}  % If you have twoside...
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Do some initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifnum\@draft=1 \singlespacing \else \doublespacing \fi
