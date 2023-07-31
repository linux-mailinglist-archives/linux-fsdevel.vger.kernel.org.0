Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934F076963C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjGaMZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjGaMY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:24:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5B51703
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 05:24:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso4232978b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690806275; x=1691411075;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n33i2l+o13R2vXkTMdoXjMS5PBDW3Nc5tow2fit7wXw=;
        b=K6GPcQAxCt1vZzjj5YetA6l5koeAHwxlWkzP07rifIlXI502MaLVpwE/AyfjICJ6mS
         LvLbBpX160QFnZ0voELDsIi71o5vomh39WjAEwINwscs7Und+M4Gl/vm5CFpbXG7U52b
         wm+PC/JqkBZzyjLc/B4BuCb5EpPihhAFtIIEu3laGBI4PmV2NOtXojtIXiWPPiMFNUR2
         p3yL08t3+JrqnXJIsDMxvavpQeplUZjhPacMtSme5Fuvo1jkjJiDeCqGBiDOLIZRrX4P
         Syt2whJ0qVwEz8cEUZLVEqETAFZp25dRSmf1JHROH3XZztTAnvZ0CEkhqB0m6YLJz6YD
         GVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806275; x=1691411075;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n33i2l+o13R2vXkTMdoXjMS5PBDW3Nc5tow2fit7wXw=;
        b=as+YoyvmnrJGBRx0bWFBIWlgjU97AiF1ytrefD13IE1d+7SyQR7aiSPcdSCePR9fZO
         jyjRpyjmMiABZWQWAF22EHLqTETYbTn3fPlCwkXMUHbM8AnVQsyFNdcFt3FDJ0pHa4t3
         9299TLifNVhT8BCGWR9cKCWIMBhL5JRWF+czlzVYLO087gYxw80H9JnZ6+DkfwhgqsGo
         VSf4vlZvF4KOk9U6aspGhEqgH+6uGvXDXW7nTT5cNqPLlWxamF3uPOoNWMfMuKC2GeIT
         ba4HegEc7HO/Ys5xXjono6dpssSshZ1zGaKi01FS15IFySmP8+i38A7zLikIXBshvZfD
         MKXw==
X-Gm-Message-State: ABy/qLbRV7AvhUYFofGb5Cnq+qdyBrsn/SZWE4U9GJ2UzEa7hzKmRlGK
        hM6pY8Tj6rPbnEicN+xSf/NugA==
X-Google-Smtp-Source: APBJJlHIW1GlcpJxqQYz6lvbRT5uLUG/tKcYmNusnJKwbG9AYQELc26f4iscaquGrENqZMvdri//EA==
X-Received: by 2002:a05:6a00:9a2:b0:676:76ea:e992 with SMTP id u34-20020a056a0009a200b0067676eae992mr10589145pfg.5.1690806274821;
        Mon, 31 Jul 2023 05:24:34 -0700 (PDT)
Received: from [10.90.34.137] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id bn9-20020a056a00324900b0064398fe3451sm7465987pfb.217.2023.07.31.05.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 05:24:34 -0700 (PDT)
Message-ID: <beaab8b4-180c-017d-bd8d-8766196f302a@bytedance.com>
Date:   Mon, 31 Jul 2023 20:24:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH 04/11] maple_tree: Introduce interfaces __mt_dup() and
 mt_dup()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-5-zhangpeng.00@bytedance.com>
 <20230726160354.konsgq6hidj7gr5u@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, willy@infradead.org,
        michael.christie@oracle.com, surenb@google.com, npiggin@gmail.com,
        corbet@lwn.net, mathieu.desnoyers@efficios.com, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, brauner@kernel.org, peterz@infradead.org
In-Reply-To: <20230726160354.konsgq6hidj7gr5u@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/7/27 00:03, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
>> Introduce interfaces __mt_dup() and mt_dup(), which are used to
>> duplicate a maple tree. Compared with traversing the source tree and
>> reinserting entry by entry in the new tree, it has better performance.
>> The difference between __mt_dup() and mt_dup() is that mt_dup() holds
>> an internal lock.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   include/linux/maple_tree.h |   3 +
>>   lib/maple_tree.c           | 211 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 214 insertions(+)
>>
>> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>> index c962af188681..229fe78e4c89 100644
>> --- a/include/linux/maple_tree.h
>> +++ b/include/linux/maple_tree.h
>> @@ -327,6 +327,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
>>   		void *entry, gfp_t gfp);
>>   void *mtree_erase(struct maple_tree *mt, unsigned long index);
>>   
>> +int mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
>> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
>> +
>>   void mtree_destroy(struct maple_tree *mt);
>>   void __mt_destroy(struct maple_tree *mt);
>>   
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index da3a2fb405c0..efac6761ae37 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -6595,6 +6595,217 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
>>   }
>>   EXPORT_SYMBOL(mtree_erase);
>>   
>> +/*
>> + * mt_dup_free() - Free the nodes of a incomplete maple tree.
>> + * @mt: The incomplete maple tree
>> + * @node: Free nodes from @node
>> + *
>> + * This function frees all nodes starting from @node in the reverse order of
>> + * mt_dup_build(). At this point we don't need to hold the source tree lock.
>> + */
>> +static void mt_dup_free(struct maple_tree *mt, struct maple_node *node)
>> +{
>> +	void **slots;
>> +	unsigned char offset;
>> +	struct maple_enode *enode;
>> +	enum maple_type type;
>> +	unsigned char count = 0, i;
>> +
> 
> Can we make these labels inline functions and try to make this a loop?
I did this just to make things easier. Refer to the implementation of
walk_tg_tree_from() in sched/core.c. Using some loops and inline
functions probably doesn't simplify things. I'll try to do that and give
up if it complicates things.
> 
>> +try_ascend:
>> +	if (ma_is_root(node)) {
>> +		mt_free_one(node);
>> +		return;
>> +	}
>> +
>> +	offset = ma_parent_slot(node);
>> +	type = ma_parent_type(mt, node);
>> +	node = ma_parent(node);
>> +	if (!offset)
>> +		goto free;
>> +
>> +	offset--;
>> +
>> +descend:
>> +	slots = (void **)ma_slots(node, type);
>> +	enode = slots[offset];
>> +	if (mte_is_leaf(enode))
>> +		goto free;
>> +
>> +	type = mte_node_type(enode);
>> +	node = mte_to_node(enode);
>> +	offset = ma_nonleaf_data_end_nocheck(node, type);
>> +	goto descend;
>> +
>> +free:
>> +	slots = (void **)ma_slots(node, type);
>> +	count = ma_nonleaf_data_end_nocheck(node, type) + 1;
>> +	for (i = 0; i < count; i++)
>> +		((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
>> +
>> +	/* Cast to __rcu to avoid sparse checker complaining. */
>> +	mt_free_bulk(count, (void __rcu **)slots);
>> +	goto try_ascend;
>> +}
>> +
>> +/*
>> + * mt_dup_build() - Build a new maple tree from a source tree
>> + * @mt: The source maple tree to copy from
>> + * @new: The new maple tree
>> + * @gfp: The GFP_FLAGS to use for allocations
>> + * @to_free: Free nodes starting from @to_free if the build fails
>> + *
>> + * This function builds a new tree in DFS preorder. If it fails due to memory
>> + * allocation, @to_free will store the last failed node to free the incomplete
>> + * tree. Use mt_dup_free() to free nodes.
>> + *
>> + * Return: 0 on success, -ENOMEM if memory could not be allocated.
>> + */
>> +static inline int mt_dup_build(struct maple_tree *mt, struct maple_tree *new,
>> +			       gfp_t gfp, struct maple_node **to_free)
> 
> I am trying to change the functions to be two tabs of indent for
> arguments from now on.  It allows for more to fit on a single line and
> still maintains a clear separation between code and argument lists.
I'm not too concerned about code formatting. . . At least in this
patchset.
> 
>> +{
>> +	struct maple_enode *enode;
>> +	struct maple_node *new_node, *new_parent = NULL, *node;
>> +	enum maple_type type;
>> +	void __rcu **slots;
>> +	void **new_slots;
>> +	unsigned char count, request, i, offset;
>> +	unsigned long *set_parent;
>> +	unsigned long new_root;
>> +
>> +	mt_init_flags(new, mt->ma_flags);
>> +	enode = mt_root_locked(mt);
>> +	if (unlikely(!xa_is_node(enode))) {
>> +		rcu_assign_pointer(new->ma_root, enode);
>> +		return 0;
>> +	}
>> +
>> +	new_node = mt_alloc_one(gfp);
>> +	if (!new_node)
>> +		return -ENOMEM;
>> +
>> +	new_root = (unsigned long)new_node;
>> +	new_root |= (unsigned long)enode & MAPLE_NODE_MASK;
>> +
>> +copy_node:
> 
> Can you make copy_node, descend, ascend inline functions instead of the
> goto jumping please?  It's better to have loops over jumping around a
> lot.  Gotos are good for undoing things and retry, but constructing
> loops with them makes it difficult to follow.
Same as above.
> 
>> +	node = mte_to_node(enode);
>> +	type = mte_node_type(enode);
>> +	memcpy(new_node, node, sizeof(struct maple_node));
>> +
>> +	set_parent = (unsigned long *)&(new_node->parent);
>> +	*set_parent &= MAPLE_NODE_MASK;
>> +	*set_parent |= (unsigned long)new_parent;
> 
> Maybe make a small inline to set the parent instead of this?
> 
> There are some defined helpers for setting the types like
> ma_parent_ptr() and ma_enode_ptr() to make casting more type-safe.
Ok, I'll try to do that.
> 
>> +	if (ma_is_leaf(type))
>> +		goto ascend;
>> +
>> +	new_slots = (void **)ma_slots(new_node, type);
>> +	slots = ma_slots(node, type);
>> +	request = ma_nonleaf_data_end(mt, node, type) + 1;
>> +	count = mt_alloc_bulk(gfp, request, new_slots);
>> +	if (!count) {
>> +		*to_free = new_node;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for (i = 0; i < count; i++)
>> +		((unsigned long *)new_slots)[i] |=
>> +				((unsigned long)mt_slot_locked(mt, slots, i) &
>> +				 MAPLE_NODE_MASK);
>> +	offset = 0;
>> +
>> +descend:
>> +	new_parent = new_node;
>> +	enode = mt_slot_locked(mt, slots, offset);
>> +	new_node = mte_to_node(new_slots[offset]);
>> +	goto copy_node;
>> +
>> +ascend:
>> +	if (ma_is_root(node)) {
>> +		new_node = mte_to_node((void *)new_root);
>> +		new_node->parent = ma_parent_ptr((unsigned long)new |
>> +						 MA_ROOT_PARENT);
>> +		rcu_assign_pointer(new->ma_root, (void *)new_root);
>> +		return 0;
>> +	}
>> +
>> +	offset = ma_parent_slot(node);
>> +	type = ma_parent_type(mt, node);
>> +	node = ma_parent(node);
>> +	new_node = ma_parent(new_node);
>> +	if (offset < ma_nonleaf_data_end(mt, node, type)) {
>> +		offset++;
>> +		new_slots = (void **)ma_slots(new_node, type);
>> +		slots = ma_slots(node, type);
>> +		goto descend;
>> +	}
>> +
>> +	goto ascend;
>> +}
>> +
>> +/**
>> + * __mt_dup(): Duplicate a maple tree
>> + * @mt: The source maple tree
>> + * @new: The new maple tree
>> + * @gfp: The GFP_FLAGS to use for allocations
>> + *
>> + * This function duplicates a maple tree using a faster method than traversing
>> + * the source tree and inserting entries into the new tree one by one. The user
>> + * needs to lock the source tree manually. Before calling this function, @new
>> + * must be an empty tree or an uninitialized tree. If @mt uses an external lock,
>> + * we may also need to manually set @new's external lock using
>> + * mt_set_external_lock().
>> + *
>> + * Return: 0 on success, -ENOMEM if memory could not be allocated.
>> + */
>> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> 
> We use mas_ for things that won't handle the locking and pass in a maple
> state.  Considering the leaves need to be altered once this is returned,
> I would expect passing in a maple state should be feasible?
But we don't really need mas here. What do you think the state of mas
should be when this function returns? Make it point to the first entry,
or the last entry?
> 
>> +{
>> +	int ret;
>> +	struct maple_node *to_free = NULL;
>> +
>> +	ret = mt_dup_build(mt, new, gfp, &to_free);
>> +
>> +	if (unlikely(ret == -ENOMEM)) {
> 
> On other errors, will the half constructed tree be returned?  Is this
> safe?
Of course, mt_dup_free() is carefully designed to handle this.
> 
>> +		if (to_free)
>> +			mt_dup_free(new, to_free);
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(__mt_dup);
>> +
>> +/**
>> + * mt_dup(): Duplicate a maple tree
>> + * @mt: The source maple tree
>> + * @new: The new maple tree
>> + * @gfp: The GFP_FLAGS to use for allocations
>> + *
>> + * This function duplicates a maple tree using a faster method than traversing
>> + * the source tree and inserting entries into the new tree one by one. The
>> + * function will lock the source tree with an internal lock, and the user does
>> + * not need to manually handle the lock. Before calling this function, @new must
>> + * be an empty tree or an uninitialized tree. If @mt uses an external lock, we
>> + * may also need to manually set @new's external lock using
>> + * mt_set_external_lock().
>> + *
>> + * Return: 0 on success, -ENOMEM if memory could not be allocated.
>> + */
>> +int mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> 
> mtree_ ususually used to indicate locking is handled.
Before unifying mtree_* and mt_*, I don't think I can see any difference
between them. At least mt_set_in_rcu() and mt_clear_in_rcu() will hold
the lock.
> 
>> +{
>> +	int ret;
>> +	struct maple_node *to_free = NULL;
>> +
>> +	mtree_lock(mt);
>> +	ret = mt_dup_build(mt, new, gfp, &to_free);
>> +	mtree_unlock(mt);
>> +
>> +	if (unlikely(ret == -ENOMEM)) {
>> +		if (to_free)
>> +			mt_dup_free(new, to_free);
> 
> Again, is a half constructed tree safe to return?  Since each caller
> checks to_free is NULL, could that be in mt_dup_free() instead?
Yes, this check can be put in mt_dup_free().
> 
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(mt_dup);
>> +
>>   /**
>>    * __mt_destroy() - Walk and free all nodes of a locked maple tree.
>>    * @mt: The maple tree
>> -- 
>> 2.20.1
>>
>>
