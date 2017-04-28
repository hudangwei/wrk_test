counter = 1
math.randomseed(os.time())  
math.random(); math.random(); math.random()  

function file_exists(file)  
  local f = io.open(file, "rb")  
if f then f:close() end  
return f ~= nil  
end  

function shuffle(paths)  
  local j, k  
  local n = #paths  
for i = 1, n do  
    j, k = math.random(n), math.random(n)  
    paths[j], paths[k] = paths[k], paths[j]  
  end  
return paths  
end  

function non_empty_lines_from(file)  
if not file_exists(file) then return {} end  
  lines = {}  
for line in io.lines(file) do  
if not (line == '') then  
      lines[#lines + 1] = line  
    end  
  end  
return shuffle(lines)  
end  

paths = non_empty_lines_from("paths.txt")
if #paths <= 0 then  
  print("multiplepaths: No paths found. You have to create a file paths.txt with one path per line")  
  os.exit()  
end  
print("multiplepaths: Found " .. #paths .. " paths")  

-- bodys = non_empty_lines_from("bodys.txt")
-- if #bodys <= 0 then  
--   print("multiplepaths: No bodys found. You have to create a file bodys.txt with one path per line")  
--   os.exit()  
-- end  
-- print("multiplepaths: Found " .. #bodys .. " bodys") 

function response(status, headers, body)
  --print(body)
end

function init(args)
    for k, v in pairs(args) do
        --print(k, v)
    end
end

function done(summary, latency, requests)
  print("latency.min,latency.max,latency.mean,latency.stdev,latency:percentile(50.0),latency:percentile(90.0),latency:percentile(95.0),latency:percentile(99.0),summary.duration,summary.requests,summary.bytes,summary.errors.connect,summary.errors.read,summary.errors.write,summary.errors.status,summary.errors.timeout,qps,Transfer/sec(KB)")
  print(latency.min/1000 .. "," .. latency.max/1000 .. "," .. latency.mean/1000 .. "," .. latency.stdev/1000 .. "," .. latency:percentile(50.0)/1000 .. "," .. latency:percentile(90.0)/1000 .. "," .. latency:percentile(95.0)/1000 .. "," .. latency:percentile(99.0)/1000 .. "," .. summary.duration/1000000 .. "," .. summary.requests .. "," .. summary.bytes .. "," .. summary.errors.connect.. "," .. summary.errors.read.. "," .. summary.errors.write.. "," .. summary.errors.status.. "," .. summary.errors.timeout .. "," .. summary.requests/(summary.duration/1000000) .. "," .. (summary.bytes/1024)/(summary.duration/1000000))
end

function request()
    path = paths[counter]
    counter = counter + 1
    if counter > #paths then
      counter = 1
    end

    print("path: [" .. path .."]")  

    wrk.method = "POST"
    wrk.path = path
    wrk.headers["Content-Type"] = "application/json;charset=utf-8"
    --wrk.body = body
    --return wrk.format(wrk.method,wrk.path,wrk.headers,wrk.body)
    return wrk.format(wrk.method,path)
end
