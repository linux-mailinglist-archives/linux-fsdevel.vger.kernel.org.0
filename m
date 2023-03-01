Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78B66A67B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 07:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCAGol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 01:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCAGok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:44:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CCE32504;
        Tue, 28 Feb 2023 22:44:39 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3213hesn024166;
        Wed, 1 Mar 2023 06:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=WTZCQYGUaufbYgRNIsn1AVRsdFAHWc+heWSesaphOCo=;
 b=OQbIXh/pbn6PM3cgQtHggPhSitU9a88Q4Tm/OwseWpNafh3PzWFPOanwYazRTPxb2AcY
 inUCetLR0MPT4Q0qiA2lnwlazL1l+3g2qfFpSuZoi62/jXpqFTeYuXPEW3b3P5bapLT8
 kUZltE4zAdDB+/l2aYpL4DGIvdcaCwTbhzddX45C3obe799NdbwP0MklQdO6LlvrCiAL
 UmxD/YlYIdVcoJfiNVeI9PrIpBrwCSj2MyQpvfohuNyqDxTWorlBOldW91OLWirVDGMR
 no3u3bv5gJxa5Eh8E0KtbuM4GVCi0hUHeGsTG7QUGC5Q/5wDBMLAQ4Ylv8I93480OaAy TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1y23bj96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 06:44:34 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3216XhV8005116;
        Wed, 1 Mar 2023 06:44:34 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1y23bj8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 06:44:34 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31SIMTmS017670;
        Wed, 1 Mar 2023 06:44:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3nybbyu1sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 06:44:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3216iTE664225674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 06:44:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E33DD2004E;
        Wed,  1 Mar 2023 06:44:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C11D320063;
        Wed,  1 Mar 2023 06:44:27 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.62.226])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Mar 2023 06:44:27 +0000 (GMT)
Date:   Wed, 1 Mar 2023 12:14:24 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>
Subject: Re: [PATCH v4 8/9] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y/70SFCCfKxcpHcp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1676634592.git.ojaswin@linux.ibm.com>
 <bc5f70ca1d2974a41b77154966e736d1e58a8d20.1676634592.git.ojaswin@linux.ibm.com>
 <20230227121925.6hfrrhq4gn5g2vlh@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227121925.6hfrrhq4gn5g2vlh@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rhl0Fw51WbUdRng5kzEm3IzlUeQIXq7N
X-Proofpoint-GUID: Zr7ZdsraZuUJ-oW9dal2LVVV43TIXPe8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_02,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 mlxscore=0
 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:19:25PM +0100, Jan Kara wrote:
> On Fri 17-02-23 17:44:17, Ojaswin Mujoo wrote:
> > Currently, the kernel uses i_prealloc_list to hold all the inode
> > preallocations. This is known to cause degradation in performance in
> > workloads which perform large number of sparse writes on a single file.
> > This is mainly because functions like ext4_mb_normalize_request() and
> > ext4_mb_use_preallocated() iterate over this complete list, resulting in
> > slowdowns when large number of PAs are present.
> > 
> > Patch 27bc446e2 partially fixed this by enforcing a limit of 512 for
> > the inode preallocation list and adding logic to continually trim the
> > list if it grows above the threshold, however our testing revealed that
> > a hardcoded value is not suitable for all kinds of workloads.
> > 
> > To optimize this, add an rbtree to the inode and hold the inode
> > preallocations in this rbtree. This will make iterating over inode PAs
> > faster and scale much better than a linked list. Additionally, we also
> > had to remove the LRU logic that was added during trimming of the list
> > (in ext4_mb_release_context()) as it will add extra overhead in rbtree.
> > The discards now happen in the lowest-logical-offset-first order.
> > 
> > ** Locking notes **
> > 
> > With the introduction of rbtree to maintain inode PAs, we can't use RCU
> > to walk the tree for searching since it can result in partial traversals
> > which might miss some nodes(or entire subtrees) while discards happen
> > in parallel (which happens under a lock).  Hence this patch converts the
> > ei->i_prealloc_lock spin_lock to rw_lock.
> > 
> > Almost all the codepaths that read/modify the PA rbtrees are protected
> > by the higher level inode->i_data_sem (except
> > ext4_mb_discard_group_preallocations() and ext4_clear_inode()) IIUC, the
> > only place we need lock protection is when one thread is reading
> > "searching" the PA rbtree (earlier protected under rcu_read_lock()) and
> > another is "deleting" the PAs in ext4_mb_discard_group_preallocations()
> > function (which iterates all the PAs using the grp->bb_prealloc_list and
> > deletes PAs from the tree without taking any inode lock (i_data_sem)).
> > 
> > So, this patch converts all rcu_read_lock/unlock() paths for inode list
> > PA to use read_lock() and all places where we were using
> > ei->i_prealloc_lock spinlock will now be using write_lock().
> > 
> > Note that this makes the fast path (searching of the right PA e.g.
> > ext4_mb_use_preallocated() or ext4_mb_normalize_request()), now use
> > read_lock() instead of rcu_read_lock/unlock().  Ths also will now block
> > due to slow discard path (ext4_mb_discard_group_preallocations()) which
> > uses write_lock().
> > 
> > But this is not as bad as it looks. This is because -
> > 
> > 1. The slow path only occurs when the normal allocation failed and we
> >    can say that we are low on disk space.  One can argue this scenario
> >    won't be much frequent.
> > 
> > 2. ext4_mb_discard_group_preallocations(), locks and unlocks the rwlock
> >    for deleting every individual PA.  This gives enough opportunity for
> >    the fast path to acquire the read_lock for searching the PA inode
> >    list.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Looks good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Just a few style nits below...
> 
> > @@ -3992,80 +4010,162 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
> >  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
> >  	struct ext4_prealloc_space *tmp_pa;
> >  	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> > +	struct rb_node *iter;
> >  
> > -	rcu_read_lock();
> > -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> > -		spin_lock(&tmp_pa->pa_lock);
> > -		if (tmp_pa->pa_deleted == 0) {
> > -			tmp_pa_start = tmp_pa->pa_lstart;
> > -			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> > +	read_lock(&ei->i_prealloc_lock);
> > +	for (iter = ei->i_prealloc_node.rb_node; iter;
> > +	     iter = ext4_mb_pa_rb_next_iter(start, tmp_pa_start, iter)) {
> > +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
> > +				  pa_node.inode_node);
> > +		tmp_pa_start = tmp_pa->pa_lstart;
> > +		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> >  
> > +		spin_lock(&tmp_pa->pa_lock);
> > +		if (tmp_pa->pa_deleted == 0)
> >  			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
> > -		}
> >  		spin_unlock(&tmp_pa->pa_lock);
> >  	}
> > -	rcu_read_unlock();
> > +	read_unlock(&ei->i_prealloc_lock);
> >  }
> > -
> 
> Please keep the empty line here.
> 
> > @@ -4402,6 +4502,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
> >  	struct ext4_locality_group *lg;
> >  	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
> >  	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> > +	struct rb_node *iter;
> >  	ext4_fsblk_t goal_block;
> >  
> >  	/* only data can be preallocated */
> > @@ -4409,14 +4510,17 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
> >  		return false;
> >  
> >  	/* first, try per-file preallocation */
> > -	rcu_read_lock();
> > -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> > +	read_lock(&ei->i_prealloc_lock);
> > +	for (iter = ei->i_prealloc_node.rb_node; iter;
> > +	     iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical, tmp_pa_start, iter)) {
> > +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space, pa_node.inode_node);
> 
> Perhaps wrap above two lines to fit in 80 characters?
> 
> > @@ -5043,17 +5177,18 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
> >  
> >  repeat:
> >  	/* first, collect all pa's in the inode */
> > -	spin_lock(&ei->i_prealloc_lock);
> > -	while (!list_empty(&ei->i_prealloc_list) && needed) {
> > -		pa = list_entry(ei->i_prealloc_list.prev,
> > -				struct ext4_prealloc_space, pa_node.inode_list);
> > +	write_lock(&ei->i_prealloc_lock);
> > +	for (iter = rb_first(&ei->i_prealloc_node); iter && needed; iter = rb_next(iter)) {
> 
> Wrap this line as well?
> 
> > +		pa = rb_entry(iter, struct ext4_prealloc_space,
> > +				pa_node.inode_node);
> >  		BUG_ON(pa->pa_node_lock.inode_lock != &ei->i_prealloc_lock);
> > +

Thanks for the review Jan and Ritesh. I'll fix the styling issues and
resend the series. 

Ted, just wanted to check if you still want me to rebase this over
Kemeng's [1] mballoc cleanup series since seems like they'll have to
send another version.

[1]
https://lore.kernel.org/linux-ext4/81568343-36fb-aa90-2952-d1f26547541c@huaweicloud.com/T/#t

Regards,
Ojaswin

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
