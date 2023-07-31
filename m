Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46880769513
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGaLk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 07:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGaLk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:40:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB2A6;
        Mon, 31 Jul 2023 04:40:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-686b643df5dso2989121b3a.1;
        Mon, 31 Jul 2023 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690803625; x=1691408425;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbHaBnPJTBufVAwcPj+/e51E470qMaDLfU8RAgBBrSo=;
        b=Oqhj9+7q02O+W9LRy4/w9ygddowj5YGZdAuQcQiAKx8xsYNHClcRtsbok6QS0FT7o5
         EnqTLOZQ2khabaT7z9Y7sb4fRTsSVX1bDX522xRb1/pB6hkHuKktWo6tgpdO5UrJ+mVa
         yamBHZxv6GhHgFm+mFHhNbceYYuLchQPstzfFsuHCcE4ahCOp+1jICpS8uWPKscCPIK2
         lf51aYlmtmTfGIhtv1APtO6vSJrqsEq029SRG5gJ1Ak717eq5rbbpcAyxJaiRocDTPzT
         +PTy+sMzbnntJxzHX6SLblNYGLcritk1DuTMBjbjSc7spgbtTQ4U357QI6CCDHdnBlZt
         V/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690803625; x=1691408425;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NbHaBnPJTBufVAwcPj+/e51E470qMaDLfU8RAgBBrSo=;
        b=IvNVIG+IiCG58ug5YHoZoqa5d1wKnMPhu+3GSzywyni9sku/DLloZ8S2jeeZ4aIk9z
         08J7hdh/jB13i+fLVhKOry5OcRkZ/fGkEBm0MZgo5Ot4o9+VrJiTq4gfRkSsbHPxthPU
         94+kMDkWxg8FU1PzDdop/fNNZ5TKLWtbcNpQx3blgqOmrb9ak5Cp9mkoqk5SaT09EaFq
         qjhFWIp46WpmWarE1dsotfZElmho+lsAcmc6/PeBWii7XTbxRcl67sDO8TuqPCilxMv0
         xC+HmUbtz4gzNPQs67FMN4ARivdK7ZOlunCFEQPAqxzvc7Wbzknqz5iD0NNlTR7n3Y9o
         DvJA==
X-Gm-Message-State: ABy/qLadRyCLiiGPa3NW043+GEZdszw1v2fZXNYNuZ3hkjxpx1lnORe0
        IUC/5KZf2QiEBOwgjerVg1E=
X-Google-Smtp-Source: APBJJlExlIfJlZY/sSBlcw6EfNRGkZZTwEkZ+JAJ9sqSSJViGVx+t05/p99K9MXZ7/FpPZdW7zHT8w==
X-Received: by 2002:a05:6a20:9151:b0:13b:79dc:4538 with SMTP id x17-20020a056a20915100b0013b79dc4538mr9899227pzc.62.1690803625084;
        Mon, 31 Jul 2023 04:40:25 -0700 (PDT)
Received: from [10.90.34.137] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id e11-20020a63ae4b000000b00563962dbc70sm792422pgp.58.2023.07.31.04.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 04:40:24 -0700 (PDT)
Message-ID: <e106ee62-8b4b-59bc-d7ec-510c0c75c30a@gmail.com>
Date:   Mon, 31 Jul 2023 19:40:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH 03/11] maple_tree: Add some helper functions
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-4-zhangpeng.00@bytedance.com>
 <20230726150252.x56owgz3ikujzicu@revolver>
Cc:     peterz@infradead.org, mathieu.desnoyers@efficios.com,
        brauner@kernel.org, Peng Zhang <zhangpeng.00@bytedance.com>,
        surenb@google.com, linux-kernel@vger.kernel.org, npiggin@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, willy@infradead.org,
        linux-mm@kvack.org, avagin@gmail.com, michael.christie@oracle.com
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230726150252.x56owgz3ikujzicu@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/7/26 23:02, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
>> Add some helper functions so that their parameters are maple node
>> instead of maple enode, these functions will be used later.
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 71 +++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 55 insertions(+), 16 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index e0e9a87bdb43..da3a2fb405c0 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -164,6 +164,11 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
>>   	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
>>   }
>>   
>> +static inline void mt_free_one(struct maple_node *node)
>> +{
>> +	kmem_cache_free(maple_node_cache, node);
>> +}
>> +
> 
> There is a place in mas_destroy() that could use this if it is added.
I will make changes accordingly. It's not done here because it doesn't
seem to be relevant to the theme of this patchset.
> 
>>   static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>>   {
>>   	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
>> @@ -432,18 +437,18 @@ static inline unsigned long mte_parent_slot_mask(unsigned long parent)
>>   }
>>   
>>   /*
>> - * mas_parent_type() - Return the maple_type of the parent from the stored
>> - * parent type.
>> - * @mas: The maple state
>> - * @enode: The maple_enode to extract the parent's enum
>> + * ma_parent_type() - Return the maple_type of the parent from the stored parent
>> + * type.
>> + * @mt: The maple tree
>> + * @node: The maple_node to extract the parent's enum
>>    * Return: The node->parent maple_type
>>    */
>>   static inline
>> -enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
>> +enum maple_type ma_parent_type(struct maple_tree *mt, struct maple_node *node)
> 
> I was trying to keep ma_* prefix to mean the first argument is
> maple_node and mt_* to mean maple_tree.  I wasn't entirely successful
> with this and I do see why you want to use ma_, but maybe reverse the
> arguments here?
I just think it is redundant to construct maple enode through
node->parent in order to adapt the parameters of mte_*. So ma_* are
introduced to avoid meaningless construction.

> 
>>   {
>>   	unsigned long p_type;
>>   
>> -	p_type = (unsigned long)mte_to_node(enode)->parent;
>> +	p_type = (unsigned long)node->parent;
>>   	if (WARN_ON(p_type & MAPLE_PARENT_ROOT))
>>   		return 0;
>>   
>> @@ -451,7 +456,7 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
>>   	p_type &= ~mte_parent_slot_mask(p_type);
>>   	switch (p_type) {
>>   	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
>> -		if (mt_is_alloc(mas->tree))
>> +		if (mt_is_alloc(mt))
>>   			return maple_arange_64;
>>   		return maple_range_64;
>>   	}
>> @@ -459,6 +464,19 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * mas_parent_type() - Return the maple_type of the parent from the stored
>> + * parent type.
>> + * @mas: The maple state
>> + * @enode: The maple_enode to extract the parent's enum
>> + * Return: The node->parent maple_type
>> + */
>> +static inline
>> +enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
>> +{
>> +	return ma_parent_type(mas->tree, mte_to_node(enode));
>> +}
>> +
>>   /*
>>    * mas_set_parent() - Set the parent node and encode the slot
>>    * @enode: The encoded maple node.
>> @@ -499,14 +517,14 @@ void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
>>   }
>>   
>>   /*
>> - * mte_parent_slot() - get the parent slot of @enode.
>> - * @enode: The encoded maple node.
>> + * ma_parent_slot() - get the parent slot of @node.
>> + * @node: The maple node.
>>    *
>> - * Return: The slot in the parent node where @enode resides.
>> + * Return: The slot in the parent node where @node resides.
>>    */
>> -static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
>> +static inline unsigned int ma_parent_slot(const struct maple_node *node)
>>   {
>> -	unsigned long val = (unsigned long)mte_to_node(enode)->parent;
>> +	unsigned long val = (unsigned long)node->parent;
>>   
>>   	if (val & MA_ROOT_PARENT)
>>   		return 0;
>> @@ -519,15 +537,36 @@ static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
>>   }
>>   
>>   /*
>> - * mte_parent() - Get the parent of @node.
>> - * @node: The encoded maple node.
>> + * mte_parent_slot() - get the parent slot of @enode.
>> + * @enode: The encoded maple node.
>> + *
>> + * Return: The slot in the parent node where @enode resides.
>> + */
>> +static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
>> +{
>> +	return ma_parent_slot(mte_to_node(enode));
>> +}
>> +
>> +/*
>> + * ma_parent() - Get the parent of @node.
>> + * @node: The maple node.
>> + *
>> + * Return: The parent maple node.
>> + */
>> +static inline struct maple_node *ma_parent(const struct maple_node *node)
> 
> I had a lot of these helpers before, but they eventually became used so
> little that I dropped them.
Just for not wanting to construct maple enode. It's not really a
problem.
> 
>> +{
>> +	return (void *)((unsigned long)(node->parent) & ~MAPLE_NODE_MASK);
>> +}
>> +
>> +/*
>> + * mte_parent() - Get the parent of @enode.
>> + * @enode: The encoded maple node.
>>    *
>>    * Return: The parent maple node.
>>    */
>>   static inline struct maple_node *mte_parent(const struct maple_enode *enode)
>>   {
>> -	return (void *)((unsigned long)
>> -			(mte_to_node(enode)->parent) & ~MAPLE_NODE_MASK);
>> +	return ma_parent(mte_to_node(enode));
>>   }
>>   
>>   /*
>> -- 
>> 2.20.1
>>
