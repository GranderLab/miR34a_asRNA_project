create_survival_plot<- function(clinical_data,classes_to_compare=NULL,classnames=NULL,filename="survival.pdf",save_plot=FALSE,add_to_existing_plot=FALSE,plot_title=NULL,plot_cols=NULL,plot_lty=NULL,return_p=FALSE){
  
  # Check
  if(length(classes_to_compare)!=length(classnames)) stop("Lengths of classes to compare different from classnames")
  
  # Load libraries
  library(survival)
  library(KMsurv)
  
  # Rename colnames
  colnames(clinical_data)<- c("vital_state","FU","class")
  if(is.null(classes_to_compare)){
    classes_to_compare<- na.omit(unique(clinical_data[,"class"]))
    classnames<- paste("class ",classes_to_compare,sep="")
  }
  classnames<- classnames[order(classes_to_compare)]
  classes_to_compare<- sort(classes_to_compare)
  
  # Select classes
  clin_sel<- clinical_data[clinical_data[,"class"]%in%classes_to_compare,]
  
  # Survival parameters
  Death<- as.numeric(clin_sel[,"vital_state"]=="dead")
  FU<- as.numeric(clin_sel[,"FU"])
  FU[is.infinite(FU)]<-NA
  FU<- FU/365.25
  class<- clin_sel[,"class"]
  
  # Survival tables
  surv_table<-cbind(FU,Death,class)
  surv_table<-na.omit(surv_table[!is.infinite(surv_table[,1]),])
  attach(as.data.frame(surv_table))
  my.surv.object<-Surv(FU, Death) # Create survival object
  my.fit<-survfit(my.surv.object ~ class) # Fit
  
  # Plot
  classes_with_data<- which(classes_to_compare%in%gsub("class=","",names(my.fit$strata))) # Otherwise problems if no data
  if(save_plot==FALSE) x11()
  else if(add_to_existing_plot==FALSE) pdf(file=filename)
  else NA
  if(is.null(plot_cols)){
    plot(my.fit,col=classes_with_data,xlim=c(0,5),xlab="time (years)",ylab="Survival Probability",main=plot_title,frame=FALSE) # Plot
    legend("bottomleft",legend = classnames,bty = "n",text.col=1:length(classes_to_compare),y.intersp = 1,cex = 0.8)
  }
  else{
    plot(my.fit,col=plot_cols[classes_with_data],lty=plot_lty[classes_with_data],xlim=c(0,5),xlab="time (years)",ylab="Survival Probability",main=plot_title,frame=FALSE) # Plot
    legend("bottomleft",legend = classnames,bty = "n",text.col=plot_cols,lty = plot_lty,y.intersp = 1,cex = 0.8)
  }
  p<-survdiff(Surv(FU, Death) ~ class)
  p.val<- 1 - pchisq(p$chisq, length(p$n) - 1)
  mtext(text = paste("p=",signif(p.val,3),sep=""),side = 3,line=-2,cex = 0.75)
  detach(as.data.frame(surv_table))
  if(save_plot==TRUE&add_to_existing_plot==FALSE) dev.off()
  if(return_p) return(p.val)
}

get_survival<- function(surv_data,n_years=5){
  
  # Load libraries
  library(survival)
  library(KMsurv)
  
  # Rename colnames
  colnames(surv_data)<- c("vital_state","FU")
  
  # Survival parameters
  Death<- as.numeric(surv_data[,"vital_state"]=="dead")
  FU<- as.numeric(surv_data[,"FU"])
  FU[is.infinite(FU)]<-NA
  FU<- FU/365.25
  
  # Survival tables
  surv_table<-cbind(FU,Death)
  surv_table<-na.omit(surv_table[!is.infinite(surv_table[,1]),])
  my.surv.object<-Surv(FU, Death) # Create survival object
  my.fit<-survfit(my.surv.object ~ 1) # Fit
  
  # Calculate
  surv_prob<- summary(my.fit)$surv[summary(my.fit)$time==max(sort(summary(my.fit)$time)[sort(summary(my.fit)$time)<n_years])]
  
  # Return
  return(surv_prob)
}

