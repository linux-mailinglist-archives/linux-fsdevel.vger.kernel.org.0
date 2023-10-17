Return-Path: <linux-fsdevel+bounces-506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6597CB887
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 04:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F671F22A85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 02:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D7B5393;
	Tue, 17 Oct 2023 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Eyoh5PeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A42522F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 02:45:01 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E78E
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 19:45:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9bca1d96cso34047295ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697510700; x=1698115500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vk6qsMWI9JY/rqTZgWzwRzv4ez7UHpwgeGAhF/8re0=;
        b=Eyoh5PeVdqjzSKHiYMOOTQU6z7bwOMwwRdrwYT7RJhIw29L9dm+Ls7rI5nYvp7HyMp
         JWe11euDQ8D+qDRRIT8rUXaMFlv+uMlkZCcWsWnlTkdZuh9ZHuvA+W7RLGYxQM7SbTIA
         G1wyOrbxTWiNTaxlnR2eUZ+LMuVgUEBzA+a3wm63YTKKL2B9XSoXXRzyYWRBwropBEDh
         fXICQs2qCr/XbF/Sq0K79dtgdkWom5TnIXdUfOQEnCpeUXKqFio0fEoJoBxFUL/rAsXr
         YqSXoxAc7Eq+SVyxJMKHpBGxg7h5C6iPt5X5YVSQIjBw/mbYevDR+ShmzNgw4n4XfDQb
         l0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697510700; x=1698115500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1vk6qsMWI9JY/rqTZgWzwRzv4ez7UHpwgeGAhF/8re0=;
        b=BiyEiVh5lqgAmb6z7ASlpx1O0GEH0S+rHEbxn1huTWYE+r1oeonV6hUP6xD4Hn46vp
         ELCjqE+em1m56C9ItR3sQaPW3kQ54E3thuj/jL2POR5pqmFQFSAxYMzoYKBV31Rn7BB3
         Q1iZA1dYwCTzzutZfWoqADNybOkJpZG4uX/Xzv9LtcwKRrRwuzFcpp/2OsnxyxWZon97
         DSGyYIPWOWfWubBbvydWVjroWXKlEcfzbs8n1EZjPLvRV5fZFHTEIXB5mXE7NrhRJTbV
         qCvM+WPf+caUpWa2JqSpKJc82CrPVCi635m6PgYQHBejUAN4Lyk2dmFw9xCsgEn5XqX6
         0crw==
X-Gm-Message-State: AOJu0YzN68AITeC9GUgGmMw3F2IdfllWZ8KInqUXzOqsFElBUr7a+MPJ
	v/qYqVUXm7cIKfBOvEMPXtMwUA==
X-Google-Smtp-Source: AGHT+IH2Vaw5VpFjLCYEuyg5TbbuvFfpk2Jx9OW/8sn5hwvVrjx7wStSOHagOF7B9oUE06Cu0PJvrA==
X-Received: by 2002:a17:903:280b:b0:1c6:3157:29f3 with SMTP id kp11-20020a170903280b00b001c6315729f3mr1001700plb.36.1697510699886;
        Mon, 16 Oct 2023 19:44:59 -0700 (PDT)
Received: from [10.84.144.228] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b001b8a2edab6asm295896plb.244.2023.10.16.19.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 19:44:59 -0700 (PDT)
Message-ID: <1e2f1120-9889-445e-8b88-d7b6cb0e0843@bytedance.com>
Date: Tue, 17 Oct 2023 10:44:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
To: Matthew Wilcox <willy@infradead.org>
Cc: Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
 brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
 mjguzik@gmail.com, mathieu.desnoyers@efficios.com, npiggin@gmail.com,
 peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
 maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Peng Zhang <zhangpeng.00@bytedance.com>
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
 <20231016032226.59199-4-zhangpeng.00@bytedance.com>
 <ZS1ESVpQ+vY0yDt4@casper.infradead.org>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <ZS1ESVpQ+vY0yDt4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/10/16 22:10, Matthew Wilcox 写道:
> On Mon, Oct 16, 2023 at 11:22:19AM +0800, Peng Zhang wrote:
>> +++ b/lib/maple_tree.c
>> @@ -4,6 +4,10 @@
>>    * Copyright (c) 2018-2022 Oracle Corporation
>>    * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
>>    *	    Matthew Wilcox <willy@infradead.org>
>> + *
>> + * Algorithm for duplicating Maple Tree
>> + * Copyright (c) 2023 ByteDance
>> + * Author: Peng Zhang <zhangpeng.00@bytedance.com>
> 
> You can't copyright an algorithm.  You can copyright the
> _implementation_ of an algorithm.  You have a significant chunk of code
> in this file, so adding your copyright is reasonable (although not
> legally required, AIUI).  Just leave out this line:
> 
> + * Algorithm for duplicating Maple Tree
Okay, I will make the correction, thank you.
> 
>> +/**
>> + * __mt_dup(): Duplicate an entire maple tree
>> + * @mt: The source maple tree
>> + * @new: The new maple tree
>> + * @gfp: The GFP_FLAGS to use for allocations
>> + *
>> + * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
>> + * traversal. It uses memcopy() to copy nodes in the source tree and allocate
> 
> memcpy()?
Yes, thank you for pointing this out.
> 
>> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
>> +{
>> +	int ret = 0;
>> +	MA_STATE(mas, mt, 0, 0);
>> +	MA_STATE(new_mas, new, 0, 0);
>> +
>> +	mas_dup_build(&mas, &new_mas, gfp);
>> +
>> +	if (unlikely(mas_is_err(&mas))) {
>> +		ret = xa_err(mas.node);
>> +		if (ret == -ENOMEM)
>> +			mas_dup_free(&new_mas);
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(__mt_dup);
> 
> Why does it need to be exported?
I consider __mt_dup() as a general interface for Maple Tree,
uncertain whether it will be used by certain modules in the future.
> 
> 

