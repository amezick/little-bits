<%@ page
	import = "
		java.util.Calendar,
		java.util.TimeZone
	"
%>
<%!
	class Group {
		JspWriter out;
		Group(JspWriter out) {
			this.out = out;
		}
		void print(ThreadGroup tg, String prefix,long milis) throws java.io.IOException {
			int i;
			out.println(prefix + "G " + tg.getName()+"<br/>");
			ThreadGroup[] tga = new ThreadGroup[tg.activeGroupCount()];
			int nr = tg.enumerate(tga, false);
			for(i = 0; i < nr; i++) {
				this.print(tga[i], prefix + "&nbsp;&nbsp;&nbsp;&nbsp;",milis);
			}
			Thread[] ta = new Thread[tg.activeCount()];
			nr = tg.enumerate(ta, false);
			String[] names = new String[nr];
			for(i = 0; i < names.length; i++) {
				names[i] = ta[i].getName();
			}
			java.util.Arrays.sort(names);
			for(i = 0; i < nr; i++) {
			    if(!names[i].endsWith("DONE")&&names[i].indexOf(" - ")!=-1){
				    int dashPos=names[i].indexOf(" - ");
			        String timeString = names[i].substring(dashPos+3);
			        long time= Long.parseLong(timeString);
			        time= milis-time;
			        if(time>1000){
				        out.println(prefix + "<font color='red'>T " + names[i].substring(0,dashPos)+" - "+time+"</font><br/>");
			        }else{
				        out.println(prefix + "<b>T " + names[i].substring(0,dashPos)+" - "+time+"</b><br/>");
			            
			        }
			    }else if(names[i].endsWith("DONE")){
				    int dashPos=names[i].indexOf(" - ");
				    int donePos=names[i].indexOf(" DONE");
			        String timeString = names[i].substring(dashPos+3,donePos);
			        long time= Long.parseLong(timeString);
			        if(time>1500){
				        out.println(prefix + "<font color='orange'>T " + names[i].substring(0,dashPos)+" - "+time+" DONE</font><br/>");
			        }else{
						out.println(prefix + "T " + names[i]+"<br/>");
			        }
			    }else{
					out.println(prefix + "T " + names[i]+"<br/>");
			    }
			}
		}
	}
%>
<html>
<head>

<title>Threads - <%=request.getServerName()%></title>
</head>
<body>
<%
	java.util.Date now = Calendar.getInstance(TimeZone.getTimeZone("America/New_York")).getTime();
long milis = System.currentTimeMillis();
%>
Time: <%=now.toString()%><br/>
Milis: <%= milis %><br/>

<%
Thread current = Thread.currentThread();
ThreadGroup tg = current.getThreadGroup();
while(tg.getParent() != null) {
	tg = tg.getParent();
}
Group g = new Group(out);
g.print(tg, "",milis);
%>
</body>
</html>