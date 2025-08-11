rates_words <-lateral_subset_darkl %>% 
  group_by(HOSTWORD) %>% 
  summarise(count=n(),rate_mismatch=100*mean(PHONETIC_PHONOLOGICAL_AGREEMENT=="mismatch",na.rm=TRUE))

view(rates_words)

table(lateral_subset_darkl$POS_SYL,lateral_subset_darkl$SYL_TYPE)

### It's is not the case that
### qhile it is truye that in open sylable l is alaways in the onset. In a closed syllable, l can be in the onset, and sometimes in the coda.
#there are plenty of close syllables with l in the onset. Having a closed syllable, increases the luikelihoof of mismatcg. syl pois got kicked out of thhe model. so its a syllable type issue, not a pos syl issue

# rate of mismatch of l in a close syll by syll pos

closed_syls <- lateral_subset_darkl %>% 
  filter(SYL_TYPE=="closed") 

prop.table(table(closed_syls$PHONETIC_PHONOLOGICAL_AGREEMENT,closed_syls$POS_SYL), margin=2)

table(closed_syls$PHONETIC_PHONOLOGICAL_AGREEMENT,closed_syls$POS_SYL)