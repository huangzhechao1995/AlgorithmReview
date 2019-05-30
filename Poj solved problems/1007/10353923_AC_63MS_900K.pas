program poj1007;
 var len,n:longint;
 i,j,m,p,q,l,r,k:longint;
 a:array[1..100] of string;
 b:array[1..100] of longint;

procedure openfile;
 begin
 assign(input,'waff.in');
 assign(output,'waff.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure qsort(l,r:longint);
 var i,j,m,t:longint; ap:string;
 begin
 i:=l; j:=r; m:=b[(l+r) div 2];
 repeat
  while b[i]<m do inc(i);
  while b[j]>m do dec(j);
  if i<=j then
   begin
   t:=b[i]; b[i]:=b[j]; b[j]:=t;
   ap:=a[i]; a[i]:=a[j]; a[j]:=ap;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
begin
// openfile;
 readln(Len,n);
 for i:=1 to n do
  readln(a[i]);
 for i:=1 to n do
  begin
  for l:=1 to len-1 do
   for r:=l+1 to len do
    if ord(a[i][l])>ord(a[i][r]) then
     inc(b[i]);
  end;

 qsort(1,n);
 for i:=1 to n do
  writeln(a[i]);
// closefile;
end.