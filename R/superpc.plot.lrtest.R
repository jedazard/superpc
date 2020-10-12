superpc.plot.lrtest <- function(object.lrtestcurv, 
                                call.win.metafile=FALSE) {

    if (call.win.metafile) {
        dev.new()
    }
    
    plot(object.lrtestcurv$threshold, object.lrtestcurv$lrtest, xlab="Threshold", ylab="Likelihood ratio statistic", type="b")

    if (call.win.metafile) {
        dev.off()
    }

}
