program poj1664;
 const maxn=10; maxm=10;
 var t,n,m,i,j,k,p,q,l,r,time:longint;
 a,b:array[0..10] of longint;
 ans:longint;
procedure openfile;
 begin
 assign(input,'waff.in');
 assign(output,'waff.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure search(x,rest:longint);
 var i,j:longint;
 begin
 if x>m then begin if rest=0 then inc(ans); exit; end;
 if rest<a[x-1] then exit;
 for i:=a[x-1] to rest do
  begin
  a[x]:=i;
  search(x+1,rest-i);
  end;
 end;
begin
 //openfile;
 readln(time);
 for t:=1 to time do
  begin
  readln(n,m);
  ans:=0;
  search(1,n);
  end;
 writeln(ans);
 //closefile;
end.