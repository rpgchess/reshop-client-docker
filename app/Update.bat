@echo off
pskill Unico.Client /accepteula > nul
taskkill /IM Unico.Client.exe > nul
timeout 1 > nul
start /wait C:\Unico\Client\Setup /S /v/qn /W
timeout 1 > nul

netsh http delete urlacl url=http://+:2009/ > nul
netsh http delete urlacl url=http://+:2010/ > nul
netsh http delete urlacl url=http://+:2011/ > nul

netsh http add urlacl url=http://+:2009/ user=everyone > nul
netsh http add urlacl url=http://+:2010/ user=everyone > nul
netsh http add urlacl url=http://+:2011/ user=everyone > nul

netsh http add urlacl url=http://+:2009/ user=todos > nul
netsh http add urlacl url=http://+:2010/ user=todos > nul
netsh http add urlacl url=http://+:2011/ user=todos > nul

timeout 1 > nul
start C:\Unico\Client\Unico.Client
