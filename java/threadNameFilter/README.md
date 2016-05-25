#Thread Name Filter
This is a simple servlet filter that I picked up from the tomcat-users mail list a long time ago.  I think this thread is the source. <http://grokbase.com/t/tomcat/users/0956a90sw9/change-thread-name-of-http-worker-threads-at-runtime>

This filter allows me to easily see how the threads in my tomcat server are behaving.  I can see how many thread are active, the last url that the thread served, a snap shot of how long it is taking threads to complete, and when threads are hung.