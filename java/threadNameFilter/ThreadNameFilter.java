package com.fry.lumber.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;


public class ThreadNameFilter implements Filter {
    /**
     * Logger for this class
     */
    //    private static final Logger logger = Logger.getLogger(ThreadNameFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        //      logger.info("ThreadNameFilter init, Now renaming threads.");

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        Thread t = Thread.currentThread();
        String oldName = t.getName();
        int atat = oldName.indexOf("@@@");
        if (atat == -1) {
            atat = oldName.length() + 1;
        }

        HttpServletRequest request = (HttpServletRequest) req;
        long milis = System.currentTimeMillis();
        try {

            t.setName(oldName.substring(0, atat - 1) + " @@@ " + request.getServerName() + request.getRequestURI() + " - " + milis);
            chain.doFilter(req, res);
        } finally {
            try {
                t.setName(oldName.substring(0, atat - 1) + " @@@ " + request.getServerName() + request.getRequestURI() + " - "
                        + (System.currentTimeMillis() - milis) + " DONE");
            } catch (Throwable e) {
                e.printStackTrace();
            }
        }

    }

    @Override
    public void destroy() {
        //logger.info("ThreadNameFilter destroy, No longer renaming threads.");

    }

}
