var
  f,w,s:array[0..301,0..301] of longint;
  a:array[0..301] of longint;
  tmp,i,j,k,m,n,ans:longint;

begin
  //while not eof do
      readln(n,m);
      for i:=1 to n do read(a[i]);
      for i:=1 to n do
        begin
          w[i,i]:=0;
          for j:=i+1 to n do
            w[i,j]:=w[i,j-1]+a[j]-a[(i+j)>>1];
        end;
      for i:=1 to n do
        begin
          f[i,1]:=w[1,i];
          s[i,1]:=0;
        end;
      for i:=2 to m do
        begin
          s[n+1,i]:=n;
          for j:=n downto i+1 do
            begin
              f[j,i]:=maxlongint;
              for k:=s[j,i-1] to s[j+1,i] do
                begin
                  tmp:=f[k,i-1]+w[k+1,j];
                  if tmp<f[j,i] then
                    begin
                      f[j,i]:=tmp;
                      s[j,i]:=k;
                    end;
                end;
            end;
        end;
      writeln(f[n,m]);
  //end;
end.