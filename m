Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E388B5F2F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 13:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJCL0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJCLZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:25:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E472B183;
        Mon,  3 Oct 2022 04:25:53 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293AhhTW008549;
        Mon, 3 Oct 2022 11:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1uxG6jFpjWTO2OB/M3wacn1bByYrDv1WviP40zONzyE=;
 b=PkAlIIeZVCdW4Ke/UYKQcZ5XYA5mgOCN8Ihh357CgYrefRcUoifQ/H4+Lr/nUkFUnjmn
 7e9bTJSRkSc8AejvpC1aAEE+hb7u7hMeyOue7yRaPoEpvIH27IhoenSFApAm33p+2I7g
 NfFAE9rOeJi2xx1OkEujaVGhqGf4qCa8IINhVOD08WAIQXvSQnib65Dzhvjux4jRrYPJ
 yWQTpKVNg+LrqTOkgSvZNRBLIfsgMt0ol02rXWB6DmhMUWILW2sr7+patxWH7tk4yAWI
 77FCkPDBWYVJocOdtWD7rSZnZkmb8u6dYuYfHH7viKHXH4PVrD9hI1HDjVRfcx1gnpIG sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jyx82117s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 11:25:48 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 293BIbnr031331;
        Mon, 3 Oct 2022 11:25:48 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jyx82117a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 11:25:48 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 293BL3V5019465;
        Mon, 3 Oct 2022 11:25:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3jxd68stwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 11:25:46 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 293BPh7I62521678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Oct 2022 11:25:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9CFC42049;
        Mon,  3 Oct 2022 11:25:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80A6242042;
        Mon,  3 Oct 2022 11:25:41 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.15.122])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Oct 2022 11:25:41 +0000 (GMT)
Date:   Mon, 3 Oct 2022 16:55:38 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <YzrGitBjeu5OJWda@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <b78a3ec57625bc26f87c088c8c8165d787b15966.1664269665.git.ojaswin@linux.ibm.com>
 <20220929123926.5jxuta43otgtcbbp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929123926.5jxuta43otgtcbbp@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zWmHh9jUqttAr9lVEn8BMm6u022ZFV9K
X-Proofpoint-GUID: pIAnWvpOwEcSi2SeGXEz1u4dwqZ11NY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=838 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan, 

Thank you for the review. I've added some comments inline.

On Thu, Sep 29, 2022 at 02:39:26PM +0200, Jan Kara wrote:
> On Tue 27-09-22 14:46:47, Ojaswin Mujoo wrote:
> 
> I've found couple of smaller issues. See below. 
> 
> > ---
> >  fs/ext4/ext4.h    |   4 +-
> >  fs/ext4/mballoc.c | 192 ++++++++++++++++++++++++++++++++--------------
> >  fs/ext4/mballoc.h |   6 +-
> >  fs/ext4/super.c   |   4 +-
> >  4 files changed, 140 insertions(+), 66 deletions(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 3bf9a6926798..d54b972f1f0f 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1120,8 +1120,8 @@ struct ext4_inode_info {
> >  
> >  	/* mballoc */
> >  	atomic_t i_prealloc_active;
> > -	struct list_head i_prealloc_list;
> > -	spinlock_t i_prealloc_lock;
> > +	struct rb_root i_prealloc_node;
> > +	rwlock_t i_prealloc_lock;
> >  
> >  	/* extents status tree */
> >  	struct ext4_es_tree i_es_tree;
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index b91710fe881f..cd19b9e84767 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -3985,6 +3985,24 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
> >  	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
> >  }
> >  
> > +/*
> > + * This function returns the next element to look at during inode
> > + * PA rbtree walk. We assume that we have held the inode PA rbtree lock
> > + * (ei->i_prealloc_lock)
> > + *
> > + * new_start	The start of the range we want to compare
> > + * cur_start	The existing start that we are comparing against
> > + * node	The node of the rb_tree
> > + */
> > +static inline struct rb_node*
> > +ext4_mb_pa_rb_next_iter(int new_start, int cur_start, struct rb_node *node)
> 
> These need to be ext4_lblk_t, not int.

Noted. Will fix in next version.
> 
> > +{
> > +	if (new_start < cur_start)
> > +		return node->rb_left;
> > +	else
> > +		return node->rb_right;
> > +}
> > +
> 
> > @@ -4032,19 +4055,29 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
> >  	new_end = *end;
> >  
> >  	/* check we don't cross already preallocated blocks */
> > -	rcu_read_lock();
> > -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> > -		if (tmp_pa->pa_deleted)
> > +	read_lock(&ei->i_prealloc_lock);
> > +	iter = ei->i_prealloc_node.rb_node;
> > +	while (iter) {
> 
> Perhaps this would be nicer as a for-cycle? Like:
> 
> 	for (iter = ei->i_prealloc_node.rb_node; iter;
> 	     iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter))
> 

Right, I agree. Will do.
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
> > +			iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
> >  			continue;
> > +		}
> >  		spin_lock(&tmp_pa->pa_lock);
> >  		if (tmp_pa->pa_deleted) {
> >  			spin_unlock(&tmp_pa->pa_lock);
> > +			iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
> >  			continue;
> >  		}
> >  
> > -		tmp_pa_start = tmp_pa->pa_lstart;
> > -		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> > -
> >  		/* PA must not overlap original request */
> >  		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
> >  			ac->ac_o_ex.fe_logical < tmp_pa_start));
> > @@ -4052,6 +4085,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
> >  		/* skip PAs this normalized request doesn't overlap with */
> >  		if (tmp_pa_start >= new_end || tmp_pa_end <= new_start) {
> >  			spin_unlock(&tmp_pa->pa_lock);
> > +			iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
> >  			continue;
> >  		}
> >  		BUG_ON(tmp_pa_start <= new_start && tmp_pa_end >= new_end);
> > @@ -4065,8 +4099,9 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
> >  			new_end = tmp_pa_start;
> >  		}
> >  		spin_unlock(&tmp_pa->pa_lock);
> > +		iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter);
> >  	}
> > -	rcu_read_unlock();
> > +	read_unlock(&ei->i_prealloc_lock);
> 
> ....
> 
> > @@ -4409,17 +4444,23 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
> >  		return false;
> >  
> >  	/* first, try per-file preallocation */
> > -	rcu_read_lock();
> > -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> > +	read_lock(&ei->i_prealloc_lock);
> > +	iter = ei->i_prealloc_node.rb_node;
> > +	while (iter) {
> 
> Again, for-cycle would look more natural here.
> 
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
> > +			iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
> > +						  tmp_pa_start, iter);
> >  			continue;
> > +		}
> >  
> >  		/* non-extent files can't have physical blocks past 2^32 */
> >  		if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
> > @@ -4439,12 +4480,14 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
> >  			ext4_mb_use_inode_pa(ac, tmp_pa);
> >  			spin_unlock(&tmp_pa->pa_lock);
> >  			ac->ac_criteria = 10;
> > -			rcu_read_unlock();
> > +			read_unlock(&ei->i_prealloc_lock);
> >  			return true;
> >  		}
> >  		spin_unlock(&tmp_pa->pa_lock);
> > +		iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical,
> > +				tmp_pa_start, iter);
> >  	}
> > -	rcu_read_unlock();
> > +	read_unlock(&ei->i_prealloc_lock);
> >  
> >  	/* can we use group allocation? */
> >  	if (!(ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC))
> > @@ -4596,6 +4639,7 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
> >  {
> >  	ext4_group_t grp;
> >  	ext4_fsblk_t grp_blk;
> > +	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
> >  
> >  	/* in this short window concurrent discard can set pa_deleted */
> >  	spin_lock(&pa->pa_lock);
> > @@ -4641,16 +4685,51 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
> >  	ext4_unlock_group(sb, grp);
> >  
> >  	if (pa->pa_type == MB_INODE_PA) {
> > -		spin_lock(pa->pa_node_lock.inode_lock);
> > -		list_del_rcu(&pa->pa_node.inode_list);
> > -		spin_unlock(pa->pa_node_lock.inode_lock);
> > +		write_lock(pa->pa_node_lock.inode_lock);
> > +		rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
> > +		write_unlock(pa->pa_node_lock.inode_lock);
> > +		ext4_mb_pa_free(pa);
> >  	} else {
> >  		spin_lock(pa->pa_node_lock.lg_lock);
> >  		list_del_rcu(&pa->pa_node.lg_list);
> >  		spin_unlock(pa->pa_node_lock.lg_lock);
> > +		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
> >  	}
> > +}
> > +
> > +static void ext4_mb_rb_insert(struct rb_root *root, struct rb_node *new,
> > +                       int (*cmp)(struct rb_node *, struct rb_node *))
> > +{
> 
> Given this has only one callsite, why not just inline ext4_mb_pa_cmp()
> directly into this function?
> 
> > +       struct rb_node **iter = &root->rb_node, *parent = NULL;
> > +
> > +       while (*iter) {
> > +               parent = *iter;
> > +               if (cmp(new, *iter) > 0)
> > +                       iter = &((*iter)->rb_left);
> > +               else
> > +                       iter = &((*iter)->rb_right);
> > +       }
> > +
> > +       rb_link_node(new, parent, iter);
> > +       rb_insert_color(new, root);
> > +}
> > +
> > +static int ext4_mb_pa_cmp(struct rb_node *new, struct rb_node *cur)
> > +{
> > +	ext4_grpblk_t cur_start, new_start;
>  
> This should be ext4_lblk_t to match with pa->pa_lstart...

Noted, thanks.
> 
> > +	struct ext4_prealloc_space *cur_pa = rb_entry(cur,
> > +						      struct ext4_prealloc_space,
> > +						      pa_node.inode_node);
> > +	struct ext4_prealloc_space *new_pa = rb_entry(new,
> > +						      struct ext4_prealloc_space,
> > +						      pa_node.inode_node);
> > +	cur_start = cur_pa->pa_lstart;
> > +	new_start = new_pa->pa_lstart;
> >  
> > -	call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
> > +	if (new_start < cur_start)
> > +		return 1;
> > +	else
> > +		return -1;
> >  }
> 
> Here and in ext4_mb_rb_insert() the comparison seems to be reversed (thus
> effectively canceling out) but it is still confusing. Usually if we have
> cmp(a,b) functions then if a < b we return -1, if a > b we return 1.

Hmm so for ext4_mb_rb_insert(), it was already defined when I started
with the pathset so I just reused it with a new comparator
ext4_mb_pa_cmp(). While rebasing, I noticed that ext4_mb_rb_insert()
function was removed since we didn't need the rbtree after your changes
to CR1, so I just added it as it is. 

But you are correct, we should modify ext4_mb_rb_insert to make the
return values more intuitive. I'll fix this.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Regards,
ojaswin
