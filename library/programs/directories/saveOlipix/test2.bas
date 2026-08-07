100 REMark NOT working
110 C=3
120 WHEN C=3
130   PRINT"inside";!C: REMark BUG ! lrun""
140 END WHEN 
150 REPeat loop1
160   REPeat loop2
170    PRINT"inside loop 2":EXIT loop2
180   END REPeat loop2
190   PRINT"after loop 2": EXIT loop1
200 END REPeat loop1
210 PRINT "End of test"
220 PAUSE
