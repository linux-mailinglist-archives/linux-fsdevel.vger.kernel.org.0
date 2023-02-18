Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F141A69B387
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 21:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBQUJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 15:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBQUJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:09:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7967D1A4B3;
        Fri, 17 Feb 2023 12:09:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id o5so1354418pfw.10;
        Fri, 17 Feb 2023 12:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TDHZpW5nYJoQtV+YghFbveASSzhZpVDaczVl/jB6LmU=;
        b=Zw/HL78ipukDSzJtD+QC3r4/9OIXohqLDWcX0WqwvnM8lsoKS+dnj7EIYg/IaoFCwi
         JlQvP0vZqYTyvRjuwuDk9HlZFGj3Q09J46wwLPFgDuURF6lxqB8Zqgw+S+fHlgb0uEZQ
         qf533OxeN/Hm7FHLAi8f05V17p/w8us55qsUS9SFaZ/cr2sFRprTWq8K8DdRWLiFBzxF
         TYQb/610KBURSIdAj3fCf0QqPXGmHTU2wYrLjZOTHl04Y7f+zg0QUm5o/X6dpMBUorFA
         iisL/4KaKG/UyuX0N531f6nWR5R6Gs2u+CwqoO7u+M9O46JQ1uPceRhPGZg8vD/x7syz
         W2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDHZpW5nYJoQtV+YghFbveASSzhZpVDaczVl/jB6LmU=;
        b=6+aWr4G550qX8oQxS/j0MCh0nN3OsPvX3R/Xn2/3aKoqsnwCOBeW+5X8x6M064wK30
         wE+9JVDOOi/xV//POgOY9mJK3hNrjO+De09mHfTyowinS/UUj5YJBnBXGQMT9/619v4k
         qlxk/lDZbDtIVMgWHd0ctyi3OW8fGHVLRem0G6rIbFVQp0G41SYPG+SggabTsf0AHI+T
         ryyqefa7axhUtREkEDFC2SjZnxR9mk94s28KkmcMn7yxLgI6nJ/r1NZYq2DA22uOnejG
         M+H5tFgIRvkxMgTeoQdzHnrnEV7Lp8HLC7ZT4ph9t0QkjtSio5YS+joeG4YlF9zaCNnx
         4L+w==
X-Gm-Message-State: AO0yUKWF7150tEE3O4OpQm3T9CIlo+Q9uEgi0/p9nWzlJY7Vudsx9PiE
        +Hk1sdLUAOVYqTUd8+DCCVE=
X-Google-Smtp-Source: AK7set9f4PNqeeuMU32unek6ZLsWX+ZWbEeq4efIteIHmjSBJVPNKHLDihRjhfxKjwB71T/zyM7Sog==
X-Received: by 2002:a62:1850:0:b0:5a8:ac17:fa6c with SMTP id 77-20020a621850000000b005a8ac17fa6cmr2011058pfy.15.1676664542531;
        Fri, 17 Feb 2023 12:09:02 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id z18-20020aa785d2000000b005905d2fe760sm1767692pfn.155.2023.02.17.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:09:01 -0800 (PST)
Date:   Sat, 18 Feb 2023 07:03:25 +0530
Message-Id: <87ttzj7o62.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>
Subject: Re: [PATCH v4 8/9] ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list
In-Reply-To: <bc5f70ca1d2974a41b77154966e736d1e58a8d20.1676634592.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> Currently, the kernel uses i_prealloc_list to hold all the inode
> preallocations. This is known to cause degradation in performance in
> workloads which perform large number of sparse writes on a single file.
> This is mainly because functions like ext4_mb_normalize_request() and
> ext4_mb_use_preallocated() iterate over this complete list, resulting in
> slowdowns when large number of PAs are present.
>
> Patch 27bc446e2 partially fixed this by enforcing a limit of 512 for
> the inode preallocation list and adding logic to continually trim the
> list if it grows above the threshold, however our testing revealed that
> a hardcoded value is not suitable for all kinds of workloads.
>
> To optimize this, add an rbtree to the inode and hold the inode
> preallocations in this rbtree. This will make iterating over inode PAs
> faster and scale much better than a linked list. Additionally, we also
> had to remove the LRU logic that was added during trimming of the list
> (in ext4_mb_release_context()) as it will add extra overhead in rbtree.
> The discards now happen in the lowest-logical-offset-first order.
>
> ** Locking notes **
>
> With the introduction of rbtree to maintain inode PAs, we can't use RCU
> to walk the tree for searching since it can result in partial traversals
> which might miss some nodes(or entire subtrees) while discards happen
> in parallel (which happens under a lock).  Hence this patch converts the
> ei->i_prealloc_lock spin_lock to rw_lock.
>
> Almost all the codepaths that read/modify the PA rbtrees are protected
> by the higher level inode->i_data_sem (except
> ext4_mb_discard_group_preallocations() and ext4_clear_inode()) IIUC, the
> only place we need lock protection is when one thread is reading
> "searching" the PA rbtree (earlier protected under rcu_read_lock()) and
> another is "deleting" the PAs in ext4_mb_discard_group_preallocations()
> function (which iterates all the PAs using the grp->bb_prealloc_list and
> deletes PAs from the tree without taking any inode lock (i_data_sem)).
>
> So, this patch converts all rcu_read_lock/unlock() paths for inode list
> PA to use read_lock() and all places where we were using
> ei->i_prealloc_lock spinlock will now be using write_lock().
>
> Note that this makes the fast path (searching of the right PA e.g.
> ext4_mb_use_preallocated() or ext4_mb_normalize_request()), now use
> read_lock() instead of rcu_read_lock/unlock().  Ths also will now block
> due to slow discard path (ext4_mb_discard_group_preallocations()) which
> uses write_lock().
>
> But this is not as bad as it looks. This is because -
>
> 1. The slow path only occurs when the normal allocation failed and we
>    can say that we are low on disk space.  One can argue this scenario
>    won't be much frequent.
>
> 2. ext4_mb_discard_group_preallocations(), locks and unlocks the rwlock
>    for deleting every individual PA.  This gives enough opportunity for
>    the fast path to acquire the read_lock for searching the PA inode
>    list.
>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/ext4.h    |   4 +-
>  fs/ext4/mballoc.c | 284 +++++++++++++++++++++++++++++++++-------------
>  fs/ext4/mballoc.h |   6 +-
>  fs/ext4/super.c   |   4 +-
>  4 files changed, 211 insertions(+), 87 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 140e1eb300d1..fad5f087e4c6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1120,8 +1120,8 @@ struct ext4_inode_info {
>
>  	/* mballoc */
>  	atomic_t i_prealloc_active;
> -	struct list_head i_prealloc_list;
> -	spinlock_t i_prealloc_lock;
> +	struct rb_root i_prealloc_node;
> +	rwlock_t i_prealloc_lock;
>
>  	/* extents status tree */
>  	struct ext4_es_tree i_es_tree;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 7b8bbfb9ad58..1bee8a46662b 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3984,6 +3984,24 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
>  	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
>  }
>
> +/*
> + * This function returns the next element to look at during inode
> + * PA rbtree walk. We assume that we have held the inode PA rbtree lock
> + * (ei->i_prealloc_lock)
> + *
> + * new_start	The start of the range we want to compare
> + * cur_start	The existing start that we are comparing against
> + * node	The node of the rb_tree
> + */
> +static inline struct rb_node*
> +ext4_mb_pa_rb_next_iter(ext4_lblk_t new_start, ext4_lblk_t cur_start, struct rb_node *node)
> +{
> +	if (new_start < cur_start)
> +		return node->rb_left;
> +	else
> +		return node->rb_right;
> +}
> +
>  static inline void
>  ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>  			  ext4_lblk_t start, ext4_lblk_t end)
> @@ -3992,80 +4010,162 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_prealloc_space *tmp_pa;
>  	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +	struct rb_node *iter;
>
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> -		spin_lock(&tmp_pa->pa_lock);
> -		if (tmp_pa->pa_deleted == 0) {
> -			tmp_pa_start = tmp_pa->pa_lstart;
> -			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +	read_lock(&ei->i_prealloc_lock);
> +	for (iter = ei->i_prealloc_node.rb_node; iter;
> +	     iter = ext4_mb_pa_rb_next_iter(start, tmp_pa_start, iter)) {
> +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
> +				  pa_node.inode_node);
> +		tmp_pa_start = tmp_pa->pa_lstart;
> +		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
>
> +		spin_lock(&tmp_pa->pa_lock);
> +		if (tmp_pa->pa_deleted == 0)
>  			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
> -		}
>  		spin_unlock(&tmp_pa->pa_lock);
>  	}
> -	rcu_read_unlock();
> +	read_unlock(&ei->i_prealloc_lock);
>  }
> -
>  /*
>   * Given an allocation context "ac" and a range "start", "end", check
>   * and adjust boundaries if the range overlaps with any of the existing
>   * preallocatoins stored in the corresponding inode of the allocation context.
>   *
> - *Parameters:
> + * Parameters:
>   *	ac			allocation context
>   *	start			start of the new range
>   *	end			end of the new range
>   */
>  static inline void
>  ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
> -			 ext4_lblk_t *start, ext4_lblk_t *end)
> +			  ext4_lblk_t *start, ext4_lblk_t *end)

Ok so I think we now have a PA adjustment window logic in this
function based on searching the immediate undeleted neighbours
within the rbtree.

I went through the new logic and it looks functionally correct to me.
Although the previous logic of undelete the PA was simpler to code,
but I think as we discussed, we rather not go in that rabbit hole.

For the rest of the patch since I was directly involved in the
development and had done multiple reviews, so this time I have only
verified new pa overlap adjustment function.
(Let me know in case if there were any other changes to this patch)

With that please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
