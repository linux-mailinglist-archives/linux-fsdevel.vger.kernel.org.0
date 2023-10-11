Return-Path: <linux-fsdevel+bounces-62-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430E67C54B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F278D282529
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8E31F197;
	Wed, 11 Oct 2023 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmpB8lb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13A81EA92
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 13:04:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EE298
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697029439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vcjxFApevYb82qtuqxNQX9mHDiHm2BlEhPt3ZccGP80=;
	b=bmpB8lb9sU8n4Q6IOx7mWdtuhRLgEZIUZgx0n+BbqSHkuCEb+FjuW4AiP29nfLjS//ejjL
	Y5sX0o0pSEEDhvydWgQzAC6B8C7wMfC0m4h3vdRthR8nXpbVVz+/GIcnlch/EpPr7Dsx10
	ptsDteYdr7KmFKPo+uqqtcpYFOjaP34=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Af3wA_lOPJajC4lCjUANMA-1; Wed, 11 Oct 2023 09:03:58 -0400
X-MC-Unique: Af3wA_lOPJajC4lCjUANMA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52f274df255so1054356a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029437; x=1697634237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcjxFApevYb82qtuqxNQX9mHDiHm2BlEhPt3ZccGP80=;
        b=SOpGSpcLzyAjNb905iyxtxomWfHA6IIV4aoCaDaXQHjF+LUe2j59/8kr5ZG+M1W1wB
         3CpzqDmnC6HffIP0pLOawlgbXf648NeA2EQcx7xDrQtUP7DFVoQLv/Ku9HzaTdWypufY
         aAqrJY6vPliLkO7iET8+DwiNlJnesq9xs6z+Zdecf1j8lHCuqTByyBs1Gnu1KbLtPFWO
         eFjypIfMhcd2nHg9BUeH0HaCaWYWguAMKoY0nwRx+vaMEEHjxwojQeYpyb/9hUVv6dzE
         5KUKp0r/n7ygMqV5BKGhknYOis47akgNeDTzFkSdfH81kJCeAdIjybQmZ9xNeWMTTd0s
         FRKg==
X-Gm-Message-State: AOJu0YziEbKp5TscNinbOgVid+JSPcGGH2/lDCBz9UqTRWHc/jh5DiQF
	go1tdkmnZxx8RDNnk33F/VpufTxhkLxqVze48v8D7tyjJBr233npn/ajo3cENlVlHUFVqUI8ZfS
	3bbTmk0fEWKg7grNcvnv25op1Exvoth5x
X-Received: by 2002:a05:6402:22a2:b0:52f:86a1:3861 with SMTP id cx2-20020a05640222a200b0052f86a13861mr16163322edb.7.1697029436837;
        Wed, 11 Oct 2023 06:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZEvueQYrwAAq5x464YyQHDNKA6a56GKCk88BLyTHffcIh2aUnXX9p1BjNOaOf1lgPTbG4wg==
X-Received: by 2002:a05:6402:22a2:b0:52f:86a1:3861 with SMTP id cx2-20020a05640222a200b0052f86a13861mr16163315edb.7.1697029436539;
        Wed, 11 Oct 2023 06:03:56 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id cw2-20020a056402228200b0053dea07b669sm467377edb.87.2023.10.11.06.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:03:56 -0700 (PDT)
Date: Wed, 11 Oct 2023 15:03:55 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 07/28] fsverity: always use bitmap to track verified
 status
Message-ID: <q75t2etmyq2zjskkquikatp4yg7k2yoyt4oab4grhlg7yu4wyi@6eax4ysvavyk>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-8-aalbersh@redhat.com>
 <20231011031543.GB1185@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011031543.GB1185@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-10 20:15:43, Eric Biggers wrote:
> On Fri, Oct 06, 2023 at 08:49:01PM +0200, Andrey Albershteyn wrote:
> > The bitmap is used to track verified status of the Merkle tree
> > blocks which are smaller than a PAGE. Blocks which fits exactly in a
> > page - use PageChecked() for tracking "verified" status.
> > 
> > This patch switches to always use bitmap to track verified status.
> > This is needed to move fs-verity away from page management and work
> > only with Merkle tree blocks.
> 
> How complicated would it be to keep supporting using the page bit when
> merkle_tree_block_size == page_size and the filesystem supports it?  It's an
> efficient solution, so it would be a shame to lose it.  Also it doesn't have the
> max file size limit that the bitmap has.

Well, I think it's possible but my motivation was to step away from
page manipulation as much as possible with intent to not affect other
filesystems too much. I can probably add handling of this case to
fsverity_read_merkle_tree_block() but fs/verity still will create
bitmap and have a limit. The other way is basically revert changes
done in patch 09, then, it probably will be quite a mix of page/block
handling in fs/verity/verify.c

> > Also, this patch removes spinlock. The lock was used to reset bits
> > in bitmap belonging to one page. This patch works only with one
> > Merkle tree block and won't reset other blocks status.
> 
> The spinlock is needed when there are multiple Merkle tree blocks per page and
> the filesystem is using the page-based caching.  So I don't think you can remove
> it.  Can you elaborate on why you feel it can be removed?

With this patch is_hash_block_verified() doesn't reset bits for
blocks belonging to the same page. Even if page is re-instantiated
only one block is checked in this case. So, when other blocks are
checked they are reset.

	if (block_cached)
		return test_bit(hblock_idx, vi->hash_block_verified);

> > -	if (PageChecked(hpage)) {
> > -		/*
> > -		 * A read memory barrier is needed here to give ACQUIRE
> > -		 * semantics to the above PageChecked() test.
> > -		 */
> > -		smp_rmb();
> > +	if (block_cached)
> >  		return test_bit(hblock_idx, vi->hash_block_verified);
> 
> It's not clear what block_cached is supposed to mean here.

If block was re-instantiated or was in cache. I can try to come up
with better name.

-- 
- Andrey


