program poj2337;
 type arr=record
  s:string;
  num,l,r:longint;
  end;
 const maxn=1000+5;
 var i,j,n,m,p,q,l,r,k,df:longint;
  t,time:longint;
  a:Array[0..maxn] of arr;
  pre,count,count2:array[0..30] of longint;
  hash:array[0..maxn] of boolean;
  stack,outline:array[0..maxn] of longint;
  tail,tot:longint;
  sout:ansistring;
procedure openfile;
 begin
 assign(input,'poj.in');
 assign(output,'poj.out');
 reset(input);rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure qsort(l,r:longint);
 var t:arr; m:string; i,j:longint;
 begin
  i:=l; j:=r;
  m:=a[(l+r)div 2].s;
  repeat
   while a[i].s<m do inc(i);
   while a[j].s>m do dec(j);
   if i<=j then
    begin
    t:=a[i]; a[i]:=a[j]; a[j]:=t;
    inc(i); dec(j);
    end;
   until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
 end;
procedure fluery(x:longint);
 var i,p:longint;
 begin
  for i:=pre[x] to pre[x+1]-1 do
   if not hash[i] then
   begin
    hash[i]:=true;// dec(count[x]);
    inc(tail); stack[tail]:=i;
    fluery(a[i].r);
   end;
  inc(tot); outline[tot]:=stack[tail];
  dec(tail);
 end;
begin
  readln(time);
 for t:=1 to time do
  begin
  readln(m);
  for i:=1 to m do
   a[i].s:='';
  for i:=1 to m do
   readln(a[i].s);
  qsort(1,m);
  fillchar(hash,sizeof(hash),false);
  fillchar(count,sizeof(count),0);
  fillchar(count2,sizeof(count2),0);
  fillchar(pre,sizeof(pre),0);
  for i:=1 to m do
   begin
   a[i].num:=i;
   a[i].l:=ord(a[i].s[1])-ord('a')+1;
   a[i].r:=ord(a[i].s[length(a[i].s)])-ord('a')+1;
   end;
  for i:=m downto 1 do
   pre[a[i].l]:=i;
  pre[27]:=m+1;
  for i:=26 downto 1 do
   if pre[i]=0 then pre[i]:=pre[i+1];
  for i:=1 to m do  begin inc(count[a[i].l]);  inc(count2[a[i].r]); end;
  p:=0; q:=0; df:=0;
  for i:=1 to 26 do
   begin
   if count[i]-count2[i]=1 then inc(p);
   if count[i]-count2[i]=-1 then inc(q);
   if abs(count[i]-count2[i])>1 then  inc(df);
   end;
  if (p>1)or(q>1)or(p<>q)or(df>0) then begin writeln('***'); continue; end;
  tail:=0; tot:=0;
  fillchar(stack,sizeof(stack),0);
  fillchar(outline,sizeof(outline),0);
  if p=0 then fluery(A[1].l)
   else
    begin
    for i:=26 downto  1  do
     if count[i]-count2[i]=1 then df:=i;
     fluery(df);
    end;
  if tot<m+1 then begin  writeln('***'); continue; end
   else
   begin
   sout:='';
   for i:=tot downto 1 do
    sout:=sout+a[outline[i]].s+'.';
   delete(sout,length(sout),1);
  // delete(sout,length(sout),1);
   delete(sout,1,1);
   WRITELN(sout);
   end;
  end;
 end.
