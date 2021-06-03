If you had a file like this:

```bash
shell> head title.principals.tsv 
tconst	ordering	nconst	category	job	characters
tt0000001	1	nm1588970	self	\N	["Herself"]
tt0000001	2	nm0005690	director	\N	\N
tt0000001	3	nm0374658	cinematographer	director of photography	\N
tt0000002	1	nm0721526	director	\N	\N
tt0000002	2	nm1335271	composer	\N	\N
tt0000003	1	nm0721526	director	\N	\N
tt0000003	2	nm5442194	producer	producer	\N
tt0000003	3	nm1335271	composer	\N	\N
tt0000003	4	nm5442200	editor	\N	\N
```

The following invocation of awk_flatten0r produces: nconst|tconst[,tconst,...] \
by pivoting on the 3rd column (nconst) and extracting only the 1st column (tconst) \
i.e., finds all tconsts which 'belong' to a particular nconst.  

```bash
shell> head title.principals.tsv | awk_flatten0r -o 1 -p 3 -O',' 
nconst|tconst
nm0005690|tt0000001
nm0374658|tt0000001
nm0721526|tt0000002,tt0000003
nm1335271|tt0000002,tt0000003
nm1588970|tt0000001
nm5442194|tt0000003
nm5442200|tt0000003
```
