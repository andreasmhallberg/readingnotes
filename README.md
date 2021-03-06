# README

**TODO:**

- Format bibliographical reference in title to English.
- add reference type to keywords

## General description

These are my research related reading-notes on books and articles relating to Arabic Linguistics. I continuously add to and edit these notes as I read and re-read things. I have placed them here primarily as a backup and to make them accessible on different devices. I also want to make these notes accessible to colleges and students, although I am not sure how useful they might be.

Not all of these notes are complete summaries and they should not be read as such. I typically only note things that are of interest to what I am doing, meaning that some notes only record a specific detail of a paper or book.

Since these notes are related to my research there is a focus on:

- Arabic linguistics (quite broadly)
- diglossia
- speech
- language ideology
- eye-tracking
- reading

See also [Keywords](#keywords) below.



## Structure and format

Each file contains notes from one single reference. They are formatted in [markdown](https://daringfireball.net/projects/markdown/syntax) (a light weighthuman readable markup language). As such they can be easily converted via [Pandoc](http://pandoc.org) or a similar tool to other formats, such as doc, pdf, HTML (which is how they are displayed on the GitHub page), or whatever. 

### File name

File names have the following form:

```
<author last name>, <year>. <title>.md
```

For example:

> Ferguson, 1959. Diglossia.md

If there are several authors, the file name only contains the first author, without "et\ al.".

Subtitles are separated from main title with ` - ` rather than the more common `: ` for compatibility reasons. Subtitles are kept in the file name if they are informative and not too long.

For bibtex references, see the file [`bibliotek.bib`](https://github.com/andreasmhallberg/dotfile/mylatexstuff/blob/master/bibliotek.bib) in the [`dotfiles` repo](https://github.com/andreasmhallberg/dotfiles). This is my general bibtex database where I dump all references without any particular order. The format of the citation key here is 

```
@<first author>_<first content word in title>_<year>
```

For example:

for example

```
@ferguson_diglossia_1959
```

### Header

Each file begins with the complete biographical reference in Chicago author-date format as header (i.e., marked with initial `#` in markdown). In some notes the header is followed by some general information or comments about the reference.

### Contents

The actual notes referencing the content of the article or book are organized as nested lists. (More than 4 list levels cause Pandoc to protest and are avoided.)

Page reference are given at the end of lines. No page reference at the end of a line means that it is on the same page as previous item.

When the original wording is important (and also when I have been lazy) it is quoted rather then summarized. Longish quotes are in block quotes (marked in markdown with initial `> `) nested (with indentation) under a list item which presents a very brief summary of the quote. This summary of the quote is intended to make the content quickly skimmable.

Material in square brackets are my comments.

Lists and tables are sometimes quoted in markdown.

Subheadings (`##` in markdown) are occasionally used on long notes to improve readability, typically reflecting chapters in book-length sources.

### Keywords

At the end of each file one or more keywords are listed. Each keyword begins with `@` and is on a new line. See the file [`keywords.md`](https://github.com/andreasmhallberg/readingnotes/blob/master/Keywords.md) for a list of keywords. 

Hyphens are used for spaces in keywords (e.g. `@language-ideology`). Colon is used for sub-keywords. Primarily this is used for varieties of Arabic, e.g. `@Arabic:Egyptian`.

Keywords are added by me and are not those of the original author. There are some inconsistencies in how they are applied.

Keywords are used instead of sorting notes in directories for field/language/publication type/whatever. It makes it possible for a note to simultaneously belong to several categories. `grep -l @<keyword> *` and such is used to filter notes. `ack -l '@<key1>' | ack -xl '@<key2>'` to find files containing both keywords.


For counts of keywords (useful for spell-checking), use `grep -oh -E "^@\S+" *.md | sort | uniq -c | less`
