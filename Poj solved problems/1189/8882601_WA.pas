program poj1189;
 type arr=record
  z,m:int64;
 end;
 var i,j,n,m,p,q,l,r,k:longint;
 map:array[1..52,1..52] of char;
 f:array[1..52,1..52]of arr;
 ch:char;
procedure openfile;
 begin
 assign(input,'poj1189.in');
 assign(output,'poj1189.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
function gcd(a,b:int64):int64;
 begin
 if b=0 then exit(a);
 exit(gcd(b,a mod b));
 end;
procedure add(var a:arr; b:arr; p:longint);
 var i,m,z:int64;
 begin
  m:=b.m*p;
  z:=b.z;
  if m+z=0 then exit;
  if a.z+a.m=0 then begin a.z:=z; a.m:=m; exit; end;
  a.z:=a.z*m+a.m*z;
  a.m:=a.m*m;
  i:=gcd(a.z,a.m);
  a.z:=a.z div i;
  a.m:=a.m div i;
  end;
begin
 //openfile;
 readln(n,m); inc(m);
 for i:=1 to n do
  begin
  ch:=' ';
  for j:=1 to i do
   begin
   while (ch<>'.')and(ch<>'*') do
    read(ch);
   map[i,j]:=ch; ch:=' ';
   end;
  end;
 f[1,1].z:=1; f[1,1].m:=1;
 for i:=1 to n do
  for j:=1 to i do
  begin
  if map[i,j]='*' then
   begin
   add(f[i+1,j],f[i,j],2);
   add(f[i+1,j+1],f[i,j],2);
   end;
  if map[i,j]='.' then
   begin
   add(f[i+2,j+1],f[i,j],1);
   end;
  end;
 if f[n+1,m].z+f[n+1,m].m=0 then f[n+1,m].m:=1;
 writeln(f[n+1,m].z,'/',f[n+1,m].m);
 //closefile;
end.
