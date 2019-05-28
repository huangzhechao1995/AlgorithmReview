program poj1830;
var a:array[0..30] of longint;
    i,j,k,n,l,ans,task:longint;
begin
 readln(task);
 for task:=1 to task do
  begin
  fillchar(a,sizeof(a),0);
  readln(n); ans:=0;
  for i:=1 to n do
   read(a[i]);
  for i:=1 to n do
   begin
   read(j); a[i]:=(A[i] xor j)+1<<i;
   end ;
  read(i,j);
  while i<>0 do
   begin
   a[j]:=a[j] or (1<<i);
   read(i,j);
   end;
  j:=1;
  for i:=1 to n do
   begin
   k:=j;
   while not odd(a[k]>>i)and(k<=n) do inc(k);
   if k<=n then
    begin
    a[0]:=a[k]; a[k]:=a[j]; a[j]:=a[0];
    for l:=j+1 to n do
     if odd(a[l]>>i) then a[l]:=a[l] xor a[j];
    inc(J);
    end;
    end;
   ans:=n-j+1;
   for j:=j to n do if odd(a[j]) then ans:=-1;
   if ans>=0 then writeln(1<<ans)
    else writeln('Oh,it''s impossible~!!');
  end;
end.