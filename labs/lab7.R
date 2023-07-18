##3
ep
epdm <- table(ep$radius_wrt, ep$mass_wrt)
chisq_result <- chisq.test(epdm)
chisq_result
