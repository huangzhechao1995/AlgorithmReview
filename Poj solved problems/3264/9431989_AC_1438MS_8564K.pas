program poj3264;
 const maxn=50000+1000;
 var i,j,n,m,p,q,k,l,r:longint;
 fmin,fmax:array[1..maxn,0..18] of longint;
 a:array[1..maxn] of longint;
 ans1,ans2:longint;
procedure openfile;
 begin
 assign(input,'poj3264.in');
 assign(output,'poj3264.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function max(a,b:longint):longint;
 begin
 if a>b then exit(a) else exit(b);
 end;
function min(a,b:longint):longint;
 begin
 if a<b then exit(a) else exit(b);
 end;
procedure init;
 begin
 readln(n,Q);
 for i:=1 to n do
  read(a[i]);
 end;
begin

 init;
 fillchar(fmin,sizeof(fmin),127);
 for i:=1 to n do
  begin
  fmax[i,0]:=a[i];
  fmin[i,0]:=a[i];
  end;
 for k:=1 to trunc(ln(n)/ln(2)) do
  begin
  for i:=1 to n do
   begin
   p:=i+1 shl (k-1);
   if p>n then fmax[i,k]:=fmax[i,k-1]
    else
    fmax[i,k]:=max(fmax[i,k-1],fmax[p,k-1]);
   if p>n then fmin[i,k]:=fmin[i,k-1]
    else
    fmin[i,k]:=min(fmin[i,k-1],fmin[p,k-1]);
   end;
  end;
 for i:=1 to q do
  begin
  readln(l,r);
  k:=trunc(ln(r-l+1)/ln(2));
  p:=r-(1 shl k)+1;
  ans1:=max(fmax[l,k],fmax[p,k]);
  ans2:=min(fmin[l,k],fmin[p,k]);
  writeln(ans1-ans2);
  end;

end.