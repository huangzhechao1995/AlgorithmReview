program poj2433;
 type arr=record
  l,r:longint;
 end;
 const maxn=1000+50;
 var i,j,n,m,q,l,r,k:longint;
 a,v:array[0..maxn] of longint;
 p:array[0..maxn] of arr;
 ans,tot:longint;

procedure openfile;
 begin
 assign(input,'poj2433.in');
 assign(output,'poj2433.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
function max(a,b:longint):longint;
 begin
 if a>b then exit(a) else exit(b);
 end;
procedure find_out_peak;
 var i,j,k:longint;
  flag:boolean;
 begin
 tot:=0;
 flag:=true; k:=0;
 for i:=1 to n+1 do
  begin
  if a[i]>a[i-1] then
   begin
   if not flag then
    begin
     inc(tot);
     p[tot].l:=k;
     p[tot].r:=i-1;
     k:=i-1;
     flag:=true;
    end
   end
  else
   if a[i]<a[i-1] then
   begin
   if i=n+1 then
    begin
    inc(tot);
    p[tot].l:=k;
    p[tot].r:=i;
    end;
   if flag then flag:=false;
   end;
  end;
 end;

procedure calculate;
 var i,j,k,tmp,min:longint;
 begin
  tmp:=0; min:=10000000;
  for i:=1 to tot do
   begin
   v[i]:=0;
   k:=max(a[p[i].l],a[p[i].r]);
   for j:=p[i].l+1 to p[i].r-1 do
    v[i]:=a[j]-k+v[i];
   if v[i]<min then
    begin
    min:=v[i];
    tmp:=i;
    end;
   end;
  inc(ans,min);
  k:=max(a[p[tmp].l],a[p[tmp].r]);
  for j:=p[tmp].l+1 to p[tmp].r-1 do
   a[j]:=k;
 end;
begin
// openfile;
 readln(n,k);
 for i:=1 to n do
  readln(a[i]);
 while true do
  begin
  find_out_peak;
  if tot<=k then break;
  calculate;
  end;
 writeln(ans);
// closefile;
end.