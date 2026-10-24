@echo off
title Serveur M.A.M.A.N - USCSS Nostromo
cd /d "%~dp0"
echo Demarrage du serveur local M.A.M.A.N sur http://localhost:8000 ...
echo Laissez cette fenetre ouverte. Fermez-la pour arreter le serveur.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=8000; $root=(Get-Location).Path; $l=New-Object System.Net.HttpListener; $l.Prefixes.Add('http://localhost:'+$p+'/'); $l.Start(); Start-Process ('http://localhost:'+$p+'/maman-nostromo.html'); while($l.IsListening){ $c=$l.GetContext(); $rel=[Uri]::UnescapeDataString($c.Request.Url.AbsolutePath.TrimStart('/')); if($rel -eq ''){ $rel='maman-nostromo.html' }; $f=Join-Path $root $rel; if((Test-Path $f -PathType Leaf) -and ((Resolve-Path $f).Path.StartsWith($root))){ $b=[IO.File]::ReadAllBytes($f); if($f -like '*.html'){ $c.Response.ContentType='text/html; charset=utf-8' }; $c.Response.OutputStream.Write($b,0,$b.Length) } else { $c.Response.StatusCode=404 }; $c.Response.Close() }"
pause
