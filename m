Return-Path: <linux-fsdevel+bounces-390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AB27CA703
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870D6B20D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AD262AA;
	Mon, 16 Oct 2023 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoGvX7z2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF86E2374B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:52:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA40F3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697457152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpjjjpI+CcetBm4Yz9ltGQfVIhFEPGa0DNis6Y4vXbs=;
	b=DoGvX7z2ESN6SXHseBJx184Zm2SIwe5fpATrULsjgoztSAZLLg96qoHex7rkm3n8cfL2A/
	ld9TmxVTi8lGlZOuk6uLbzJ8ba2z088/VFKZadAwrw2QJfzBQBCN3i0V2H+cPPIsakTXGt
	pRJkzRPrZRHkOAeh6RQyke8Vm2jjBdg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-vcz3ThxBOreOc_ByGnSv9Q-1; Mon, 16 Oct 2023 07:52:31 -0400
X-MC-Unique: vcz3ThxBOreOc_ByGnSv9Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bcb13d8ddso323545566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 04:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457150; x=1698061950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpjjjpI+CcetBm4Yz9ltGQfVIhFEPGa0DNis6Y4vXbs=;
        b=flyuGb1baI0+62scETo7TVdVL7gUtvRIDo5DtoP9k3ynEWhCo2u7LK/6yrFj7wKZ3J
         zhpamf9w2XM5DJm14CeSJxIHdpFvGbGPPSrrJjRicZ1BXMHQzrll7ZrnhDO0wtHiFbtI
         T4FzOZ0j0NxhXWQ936QLrnhXFmgwrj6B/Z0v/CmpHtHVSzykcLOptisJ7p7OAwPeD3XE
         uSAOWVt/veTSqVOzxb5R9a/X+YUcVIzYTua9XJf0AuWxieZH5FRXfb6CF0k34s5TlbNf
         jzYZsaAJzlmb7XVxXgNIy34g7XAzpTFjAjOuEv+YO49AHMfAXQoVcjqzlncMGfoEIlzJ
         Z4fQ==
X-Gm-Message-State: AOJu0YznBtotjUodI+xNChF29JFDKe7jNsq1YbPXmzv9zctQBwSW7GTL
	pqWY0rZvNSEUGb2o6c6/5kdAy5SgpI/I4natWlsqrmoqGfJNLPUdHETZOBUY6PVFHOmID4KRPp1
	ASvHUdvt+2+4IvuEo4PFiSXtH
X-Received: by 2002:a17:906:c5:b0:9ad:c763:bc7a with SMTP id 5-20020a17090600c500b009adc763bc7amr27669205eji.23.1697457149988;
        Mon, 16 Oct 2023 04:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFSCUVmEo1L8d3XJ7xkQ6joZaZ2X6LocBmhuntEO3d2GoDh6Vxeex/0uU/r0D/hWnuhOSsQg==
X-Received: by 2002:a17:906:c5:b0:9ad:c763:bc7a with SMTP id 5-20020a17090600c500b009adc763bc7amr27669185eji.23.1697457149610;
        Mon, 16 Oct 2023 04:52:29 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id n25-20020a17090673d900b0099297782aa9sm3834603ejl.49.2023.10.16.04.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:52:29 -0700 (PDT)
Date: Mon, 16 Oct 2023 13:52:28 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 07/28] fsverity: always use bitmap to track verified
 status
Message-ID: <256y7jz5u6yj6d7gxoy7oo26eltcpcy43ugc2plog6fpcyz3tq@visdz2fzs7yc>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-8-aalbersh@redhat.com>
 <20231011031543.GB1185@sol.localdomain>
 <q75t2etmyq2zjskkquikatp4yg7k2yoyt4oab4grhlg7yu4wyi@6eax4ysvavyk>
 <20231012072746.GA2100@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012072746.GA2100@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-12 00:27:46, Eric Biggers wrote:
> On Wed, Oct 11, 2023 at 03:03:55PM +0200, Andrey Albershteyn wrote:
> > > How complicated would it be to keep supporting using the page bit when
> > > merkle_tree_block_size == page_size and the filesystem supports it?  It's an
> > > efficient solution, so it would be a shame to lose it.  Also it doesn't have the
> > > max file size limit that the bitmap has.
> > 
> > Well, I think it's possible but my motivation was to step away from
> > page manipulation as much as possible with intent to not affect other
> > filesystems too much. I can probably add handling of this case to
> > fsverity_read_merkle_tree_block() but fs/verity still will create
> > bitmap and have a limit. The other way is basically revert changes
> > done in patch 09, then, it probably will be quite a mix of page/block
> > handling in fs/verity/verify.c
> 
> The page-based caching still has to be supported anyway, since that's what the
> other filesystems that support fsverity use, and it seems you don't plan to
> change that.  The question is where the "block verified" flags should be stored.
> Currently there are two options: PG_checked and the separate bitmap.  I'm not
> yet convinced that removing the support for the PG_checked method is a good
> change.  PG_checked is a nice solution for the cases where it can be used; it
> requires no extra memory, no locking, and has no max file size.  Also, this
> change seems mostly orthogonal to what you're actually trying to accomplish.

Yes, I was trying to combine PG_checked and bitmap in the way it can
be also used by XFS. I will try change this patch to not drop
merkle_tree_block_size == page_size case.

> > > > Also, this patch removes spinlock. The lock was used to reset bits
> > > > in bitmap belonging to one page. This patch works only with one
> > > > Merkle tree block and won't reset other blocks status.
> > > 
> > > The spinlock is needed when there are multiple Merkle tree blocks per page and
> > > the filesystem is using the page-based caching.  So I don't think you can remove
> > > it.  Can you elaborate on why you feel it can be removed?
> > 
> > With this patch is_hash_block_verified() doesn't reset bits for
> > blocks belonging to the same page. Even if page is re-instantiated
> > only one block is checked in this case. So, when other blocks are
> > checked they are reset.
> > 
> > 	if (block_cached)
> > 		return test_bit(hblock_idx, vi->hash_block_verified);
> 
> When part of the Merkle tree cache is evicted and re-instantiated, whether that
> part is a "page" or something else, the verified status of all the blocks
> contained in that part need to be invalidated so that they get re-verified.  The
> existing code does that.  I don't see how your proposed code does that.

Oh, I see the problem now, I will revert it back.

-- 
- Andrey


