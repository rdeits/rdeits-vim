#!/usr/bin/python
from __future__ import division
import sys
import os
import re

print sys.argv

in_file = open(sys.argv[1],'r')

base_filename = sys.argv[1].split(os.path.extsep)[0]
out_file = open(base_filename+'.tex','w')

sys.stdout = out_file

print '\\documentclass[10pt]{article}'
print '\\usepackage[at]{easylist}'
print '\\oddsidemargin=0in'
print '\\textwidth=6.5in'
print '\\begin{document}'

print '\\title{'+in_file.readline()+'}'
print '\\author{Robin Deits}'
print '\\date{\\today}'
print '\\maketitle'

line = in_file.readline()

# print '\\begin{outline}'
in_list = False

while line != '':
    if line != '\n':
        current_indent = line.count('\t')+1
        if current_indent > 0 and not in_list:
            print '\\begin{easylist}[booktoc]'
            in_list = True
        if current_indent == 0 and in_list:
            print '\\end{easylist}'
            in_list = False
        new_text =  line.rpartition('*')[2].lstrip().rstrip()
        if current_indent == 0:
            print '\\section{'+new_text+'}'
        else:
            new_line = '@'*current_indent
            new_line += ' ' + new_text     
            new_line = re.sub('&','\&',new_line)
            print new_line
    line = in_file.readline()


if in_list:
    print '\\end{easylist}'
print '\\end{document}'

out_file.close()
sys.stdout = sys.__stdout__

os.system('pdflatex ' + base_filename + '.tex')

os.system('rm ' + base_filename + '.aux')
os.system('rm ' + base_filename + '.log')

