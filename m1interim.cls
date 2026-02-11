\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{m1interim}[2024/01/01 M1 Interim Presentation Abstract Class]

% ---- フォントプリセットオプション ----
% luatexja-preset のプリセット名をクラスオプションとして指定可能。
% 省略時は従来どおり MS 明朝/MS ゴシックを手動設定する。
\newif\if@usepreset
\@usepresetfalse
\newcommand{\m@jfontpreset}{}

\DeclareOption{haranoaji}{\@usepresettrue\renewcommand{\m@jfontpreset}{haranoaji}}
\DeclareOption{hiragino-pron}{\@usepresettrue\renewcommand{\m@jfontpreset}{hiragino-pron}}
\DeclareOption{ipaex}{\@usepresettrue\renewcommand{\m@jfontpreset}{ipaex}}
\DeclareOption{noto-jp}{\@usepresettrue\renewcommand{\m@jfontpreset}{noto-jp}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Base class: article, A4, 10pt body
\LoadClass[a4paper,10pt,twocolumn]{article}

% ---- Packages ----
\RequirePackage[top=20mm,bottom=25mm,left=20mm,right=20mm]{geometry}
\RequirePackage{luatexja}
\ltjsetparameter{jacharrange={-2}} % avoid conflicts

\if@usepreset
  % オプション指定時: luatexja-preset 経由（luatexja-fontspec は自動読み込み）
  \edef\@tempa{\noexpand\PassOptionsToPackage{\m@jfontpreset,scale=1.0}{luatexja-preset}}
  \@tempa
  \RequirePackage{luatexja-preset}
\else
  % デフォルト: 従来の手動 MS フォント設定を維持
  \def\Cjascale{1.0}                % CJK scale = 1.0 (Word互換)
  \RequirePackage{luatexja-fontspec}
\fi

\RequirePackage{fontspec}
\RequirePackage{newtxmath}            % Math: Times clone

% ---- Fonts ----
% 欧文: Times New Roman
\setmainfont{Times New Roman}
% 和文: プリセット未指定時のみ手動設定（プリセット時は luatexja-preset が設定済み）
\if@usepreset\else
  \setmainjfont{MS Mincho}[BoldFont=MS Gothic,Scale=1.0,YokoFeatures={JFM=mono}]
  \setsansjfont{MS Gothic}[Scale=1.0,YokoFeatures={JFM=mono}]
\fi
\RequirePackage{graphicx}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{titlesec}
\RequirePackage{etoolbox}

% ---- Column separation ----
\setlength{\columnsep}{6mm}

% ---- Line spacing ----
% 2ページ目45行基準: textheight(252mm) / 45 = 5.6mm ≈ 15.87bp
\AtBeginDocument{%
  \fontsize{10bp}{15.87bp}\selectfont
  \setlength{\parskip}{0pt}%
  \ltjsetparameter{kanjiskip=0.5mm plus 0.2mm minus 0.1mm}%
}

% ---- Section formatting ----
\titleformat{\section}[block]{\normalsize\bfseries}{\thesection．}{0pt}{}
\titlespacing*{\section}{0pt}{0.8em}{0.4em}
\titleformat{\subsection}[block]{\normalsize\bfseries}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{0.6em}{0.3em}

% ---- Renew thesection to use full-width numbers ----
\renewcommand{\thesection}{\ifcase\value{section}\or
  １\or ２\or ３\or ４\or ５\or ６\or ７\or ８\or ９\fi}

% ---- Remove page numbers ----
\pagestyle{empty}

% ---- Title fields ----
\newcommand{\jptitle}[1]{\newcommand{\@jptitle}{#1}}
\newcommand{\entitle}[1]{\newcommand{\@entitle}{#1}}
\newcommand{\department}[1]{\newcommand{\@department}{#1}}
\newcommand{\studentid}[1]{\newcommand{\@studentid}{#1}}
\newcommand{\studentname}[1]{\newcommand{\@studentname}{#1}}
\newcommand{\labname}[1]{\newcommand{\@labname}{#1}}
\newcommand{\supervisor}[1]{\newcommand{\@supervisor}{#1}}

% ---- Maketitle ----
\renewcommand{\maketitle}{%
  \twocolumn[%
    \begin{center}
      {\fontsize{14bp}{24bp}\selectfont
        \if@usepreset\gtfamily\bfseries\else\jfontspec{MS Gothic}[FakeBold=3]\fi
        \@jptitle\par}
      \vskip 1.0em
      {\fontsize{12bp}{20bp}\selectfont\bfseries\rmfamily \@entitle\par}
      \vskip 2.0em
    \end{center}
    \vskip 0.5em
    {\fontsize{12bp}{16bp}\selectfont
      \noindent
      \hspace*{5em}\@department\hfill\@studentid\hspace{1em}\@studentname\hspace*{5em}\par
      \noindent
      \hspace*{5em}\@labname\hfill 指導教員\hspace{1em}\@supervisor\hspace*{5em}\par
    }
    \vskip 2.0em
  ]%
}

% ---- Reference section name ----
\renewcommand{\refname}{参考文献}

\endinput
