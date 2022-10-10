Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5765F9D33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiJJLAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiJJLAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:00:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D8A6D574;
        Mon, 10 Oct 2022 04:00:32 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AAhSjT025614;
        Mon, 10 Oct 2022 11:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=M9EMeZjkhjQVWcAHZnlu9y0f5IYkwlTt+gfNtWBWWyM=;
 b=qaA7MqtiZvvOfS/L/vTsujHdrT48/EL8jIi2A+CFxPodO8U24GVcRyT6FLd8nR0725Hq
 bVBORMfANc0hQ1jcJTC/Z8QKQepNu+Lq4/rfQt9jG2KTt/NyGSHwMJNUkrz1p6Qyf5Bk
 eu7nDp5fQzmysIAch+P35Eq6mP3gtmPotKQTyVnwFQJ49I9jEjJeRYrO/qCe/MnqTT7A
 i9QMfcQWyvYIb5aT+tohyrg8UD1dHTQM1Prv5Im+1manqTGTBuz1L3cKAmoo3UOMS0dZ
 rjpH0Shf9Rzlc+28iLABxRm+21Te3tWy5WBa/3dCgOUBXl+ELEDXBw/tzAFX1dfmUdja jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3k9893sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 11:00:25 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29A9gO45016220;
        Mon, 10 Oct 2022 11:00:25 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3k9893r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 11:00:25 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29AArUNf029557;
        Mon, 10 Oct 2022 11:00:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3k30fj1yb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 11:00:22 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29AB0puV53150162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 11:00:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A93C411C04A;
        Mon, 10 Oct 2022 11:00:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5BFB11C04C;
        Mon, 10 Oct 2022 11:00:17 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.59.13])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Oct 2022 11:00:17 +0000 (GMT)
Date:   Mon, 10 Oct 2022 16:30:14 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y0P7Pu0/KQFdgnp/@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1665088164.git.ojaswin@linux.ibm.com>
 <ee2dd0087cea34b5fdfdbee5d9bc56fb4dd22e54.1665088164.git.ojaswin@linux.ibm.com>
 <20221010093826.uc3zvxyhcyjqosrg@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010093826.uc3zvxyhcyjqosrg@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BByjOUzRN0574ALx0EhWfEmk0WJ7EkOK
X-Proofpoint-ORIG-GUID: sl7tY1w06NSGMmYi24H_atE55YKrMfiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_05,2022-10-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=824 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:38:26AM +0200, Jan Kara wrote:
> On Fri 07-10-22 02:16:18, Ojaswin Mujoo wrote:
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
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Looks mostly good to me now. Just three nits below. With those fixes feel
> free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > @@ -4031,19 +4054,27 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
> >  	new_end = *end;
> >  
> >  	/* check we don't cross already preallocated blocks */
> > -	rcu_read_lock();
> > -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> > -		if (tmp_pa->pa_deleted)
> > +	read_lock(&ei->i_prealloc_lock);
> > +	for (iter = ei->i_prealloc_node.rb_node; iter;
> > +	     iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter)) {
> > +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
> > +				  pa_node.inode_node);
> > +		tmp_pa_start = tmp_pa->pa_lstart;
> > +		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> > +
> > +		/*
> > +		 * If pa is deleted, ignore overlaps and just iterate in rbtree
> > +		 * based on tmp_pa_start
> > +		 */
> > +		if (tmp_pa->pa_deleted) {
> >  			continue;
> > +		}
> 
> Curly braces here are pointless.
> 
> > @@ -4408,17 +4439,21 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
> >  		return false;
> >  
> >  	/* first, try per-file preallocation */
> > -	rcu_read_lock();
> > -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> > +	read_lock(&ei->i_prealloc_lock);
> > +	for (iter = ei->i_prealloc_node.rb_node; iter;
> > +	     iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical, tmp_pa_start, iter)) {
> > +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space, pa_node.inode_node);
> >  
> >  		/* all fields in this condition don't change,
> >  		 * so we can skip locking for them */
> >  		tmp_pa_start = tmp_pa->pa_lstart;
> >  		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> >  
> > +		/* original request start doesn't lie in this PA */
> >  		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
> > -		    ac->ac_o_ex.fe_logical >= tmp_pa_end)
> > +		    ac->ac_o_ex.fe_logical >= tmp_pa_end) {
> >  			continue;
> > +		}
> 
> Again, curly braces here are pointless.
> 
> > +static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
> > +                       int (*cmp)(struct rb_node *, struct rb_node *))
> > +{
> > +       struct rb_node **iter = &root->rb_node, *parent = NULL;
> > +
> > +       while (*iter) {
> > +               parent = *iter;
> > +               if (cmp(new, *iter) < 0)
> > +                       iter = &((*iter)->rb_left);
> > +               else
> > +                       iter = &((*iter)->rb_right);
> > +       }
> > +
> > +       rb_link_node(new, parent, iter);
> > +       rb_insert_color(new, root);
> > +}
> 
> I think I wrote it already last time: ext4_mb_rb_insert() is always called
> with ext4_mb_pa_cmp() as the comparison function. Furthemore
> ext4_mb_pa_cmp() is used nowhere else. So I'd just opencode
> ext4_mb_pa_cmp() in ext4_mb_rb_insert() and get rid of the indirect call.
> Better for speed as well as readability.

Hi Jan,

As mentioned in change notes, I intentionally left it as it is to make
ext4_mb_rb_insert() helper function reusable. However, I agree with your 
point about readability so I'll just merge the 2 functions and send a
next version.

Thanks,
Ojaswin
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
