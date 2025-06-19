Return-Path: <linux-fsdevel+bounces-52238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E02AE0813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F217C1899061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EED227EA8;
	Thu, 19 Jun 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="jxITsji5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EBB20468E;
	Thu, 19 Jun 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341481; cv=none; b=LlKDYdbnXtygpTmpKBT0xv2NXW2ax54kD82sateq/Rr59hPHN6tkJdszV9mg5bQqYdrK+26PNmrto4t1APKvLKqPW10hYUWngWrgYGmDnbCQ0l+JlqmyPMUzeYV/zVa0EX4bAeqMJ///lHsSiiGGKAWjgk0beKz1Tlp8Ukbrulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341481; c=relaxed/simple;
	bh=bCDV3BcsYXdCIA30x7VqPCtmDc1ODOHcLZX9aa+1cS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckfn3bfWSMvoCFZdmt0QTu9ZmiknCeOHv4GJaLCYlIzxxpds/f4HvKtQRIlA3sycx1OlYFE6HZWdwr1txm6HkD9dHA09xro/sNU2q6bYGF8J2UEkNdKqS3Na1KXFapZgPnHL7Zgvem/HzKPItKNwHNvrSf6LEQeZtcd9O6fnPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=jxITsji5; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bNMcs5r2Xz9sxP;
	Thu, 19 Jun 2025 15:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750341469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9w8mAaS+Acuvj4HIZua4Ds/KZD8eaNIVssZfmst57VI=;
	b=jxITsji54cVMA2klcCcKMsaSvZB354ZHFFJwIM1XObRvU4lEQsQDHmwwRjcgp0PwPfvprv
	PeHaUr/Sw01raD47jLNAzcciFnzuDFNmCYYTQbcrFsXDhWvIMs9glZDchPYUnYGGh/WZSF
	WG6eCXdXRfN8nTelwrZVLfedLt6QP82jU2r/aj4O1wYdupDv4tNUV2N4Df2A0/JWspTRge
	itp72HgVNZb0Z0Pe12tXXTgVuO57iDu8bk69CMUa1wI/xUOrELZ8GoCgKCIEpah5TXToEr
	WOnxP2TKLcgtJRX7ZbM/0Tjy1km/ewycYFttRY7nL/btb3l7eKPixPCs0fPeIg==
Date: Thu, 19 Jun 2025 15:57:40 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, mcgrof@kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gost.dev@samsung.com
Subject: Re: [PATCH v2] fs/buffer: use min folio order to calculate upper
 limit in __getblk_slow()
Message-ID: <tuf33rhiur3h42o27sjrgs4jxhstmul3gqjbh6sjikhv7z3ntt@ebfq6ojqisp3>
References: <20250619121058.140122-1-p.raghav@samsung.com>
 <aFQJoA6gyq6l56XS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFQJoA6gyq6l56XS@casper.infradead.org>
X-Rspamd-Queue-Id: 4bNMcs5r2Xz9sxP

On Thu, Jun 19, 2025 at 01:59:12PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 19, 2025 at 02:10:58PM +0200, Pankaj Raghav wrote:
> > +++ b/fs/buffer.c
> > @@ -1121,9 +1121,10 @@ __getblk_slow(struct block_device *bdev, sector_t block,
> >  	     unsigned size, gfp_t gfp)
> >  {
> >  	bool blocking = gfpflags_allow_blocking(gfp);
> > +	int blocklog = PAGE_SHIFT + mapping_min_folio_order(bdev->bd_mapping);
> >  
> >  	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> > -		     (size < 512 || size > PAGE_SIZE))) {
> > +		     (size < 512 || size > (1U << blocklog)))) {
> >  		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
> >  					size);
> >  		printk(KERN_ERR "logical block size: %d\n",
> 
> Is this what we want though?  If ext4 wants to create an 8kB block size
> filesystem on top of a 512 byte sector size device, shouldn't it be

That will not be a problem because we set the min order of the FS on the
block device[1] from ext4[2] through set_blocksize() routine.

> allowed to?  So just drop the max:

But I do agree with dropping it because we have these checks all over the
place. So the question is: do we need it again in a low level function
such as __getblk_slow().

> 
>  	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> -		     (size < 512 || size > PAGE_SIZE))) {
> +		     (size < 512)))) {
> 
> (also, surely logical_block_size is always at least 512, so do we really
> need this check at all?)

True!

Just the alignment check with logical block size should be enough.

--
Pankaj

[1] https://elixir.bootlin.com/linux/v6.16-rc2/source/block/bdev.c#L210
[2] https://elixir.bootlin.com/linux/v6.16-rc2/source/fs/ext4/super.c#L5110

