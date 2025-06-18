Return-Path: <linux-fsdevel+bounces-52113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD7FADF73F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DFF1BC19F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD22144CF;
	Wed, 18 Jun 2025 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="XMQEFkoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC3219313;
	Wed, 18 Jun 2025 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276277; cv=none; b=FGi8+py8YY0/PtO+UJU+C/tBOEgLWgTgzsA7ETbbuRdTlVGizMoM2scgNh63YUfC7mSF0J3u/nL5xNzQVHNfIQeUi+Jzb+zB311WtbZt32nCjwZ5z8at+kDxOGH2eAGGp7X47K8YoFGI+v1e/1ZkprQa3uZ2dByy9K5aQnsTHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276277; c=relaxed/simple;
	bh=5KlkuTtm4FeTLRqTK0bycK8bWuWhZXbiUBxN6zU2FGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHJBaOVJWsx9cPwlDAHCPijQUvUBGFjZHiNlSpSmDw+3BydlWd61MfvClNZuWlC8jeTFwny5cvoB98goLch7N5E97XmSicVqCZA+gLVw4k3yaEMFQhlks2V4OjedXVSmi/2Ap2oXw8IAZ1oVN/tBxjWPiYAyUlALU4aRa7Gyes8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=XMQEFkoz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bMvVy4j3Hz9tRK;
	Wed, 18 Jun 2025 21:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750276266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrGWr866gYFYKAItU5fzdWaaIqpQAM7PAGMpUgmo5Z4=;
	b=XMQEFkoz+3J9knCFJzCuE8/tSGheTgbnXSYE1J+2yh9OUccDHEcFUQZ8M1CEBiY3gnRu3K
	qIVNMFHrJbL7NqOUs78jGJiWuDOJDRVo/Jy8wj478sF9Efp7Kkg69Ap2f8WF+1mPvYQprl
	JB738HpNRRArW3Tz+rqMYt+q94TNdOZd+K4HGNTDqeodNOeZ5SqoeA5dwSocg3uSLDr7Ma
	cFyzf7B2fQAMEvHYLhQpoDg0I3LYCgQwcO6lbzOG2yrHOWYKWeyK/YE9NVaJVnvVQUPGww
	v3ffH4O8Yb+Zk78eToqlq0NwZnCpa+q53e875kSIhVM5GpnjRoCFEH6xEafxwQ==
Date: Wed, 18 Jun 2025 21:50:56 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Jan Kara <jack@suse.cz>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, mcgrof@kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH] fs/buffer: use min folio order to calculate upper limit
 in __getblk_slow()
Message-ID: <lv3zoqm3uuzfqskcr734btb3hgqy67ddmd4ik2vidl3y3qv2hj@2zb34igia4o5>
References: <20250618091710.119946-1-p.raghav@samsung.com>
 <rf5sve3v7vlkzae7ralok4vkkit24ashon3htmp56rmqshgcv5@a3bmz7mpkcwb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rf5sve3v7vlkzae7ralok4vkkit24ashon3htmp56rmqshgcv5@a3bmz7mpkcwb>

> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 8cf4a1dc481e..98f90da69a0a 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -1121,10 +1121,11 @@ __getblk_slow(struct block_device *bdev, sector_t block,
> >  	     unsigned size, gfp_t gfp)
> >  {
> >  	bool blocking = gfpflags_allow_blocking(gfp);
> > +	int blocklog = PAGE_SHIFT + mapping_min_folio_order(bdev->bd_mapping);
> >  
> >  	/* Size must be multiple of hard sectorsize */
> > -	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
> > -			(size < 512 || size > PAGE_SIZE))) {
> > +	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> > +		     (size < 512 || size > (1U << blocklog)))) {
> 
> So this doesn't quite make sense to me.  Shouldn't it be capped from above
> by PAGE_SIZE << mapping_max_folio_order(bdev->bd_mapping)?

This __getblk_slow() function is used to read a block from a block
device and fill the page cache along with creating buffer heads.

I think the reason we have this check is to make sure the size, which is
block size is within the limits from 512 (SECTOR_SIZE) to upper limit on block size.

That upper limit on block size was PAGE_SIZE before the lbs support in 
block devices, but now the upper limit of block size is mapping_min_folio_order.
We set that in set_blocksize(). So a single block cannot be bigger than
(PAGE_SIZE << mapping_min_folio_order).

I hope that makes sense.

-- 
Pankaj Raghav

