Return-Path: <linux-fsdevel+bounces-53319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00152AED957
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 12:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57A53B2CAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752724A063;
	Mon, 30 Jun 2025 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="zuotKfvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739D6BFC0;
	Mon, 30 Jun 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277970; cv=none; b=uZ66a8pEtl9YcdeKrFm9ZP+xATyFr6yUusT6XF7h1707mc3qjGONeR6HeUH+axutCsfb55sMJwWqgYWYwCah6DI5koQJWVzkAJsRkMmoc2X6JJAstd3/VAublTAJIwhIDOovF9ZfRtRoCSqNXCC5jOZcm60aCllqZrVZvA/1+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277970; c=relaxed/simple;
	bh=idmzxaWZUEccbmv3UFhsjZX2rlSRens+xjcxcEIn1F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdyV+cqw3Jc1S6Tms3hQOHA+pb+1o3fpBOf3UeKy7Rro09E9wZFvdGq/bc4D7I4cnr9D7hcsaIRQf++s4WKSn+pjs0UF22QSI1wpKs+2ol2mKtA2gpThrQiiHjUQSPUnkRCxpefCjtYxoMInraJjIMIqpb/tfOTv2EOpZp3yqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=zuotKfvT; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bW1yN51X8z9sqc;
	Mon, 30 Jun 2025 12:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751277964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUqY6p8xHWIMOVC9OJie7vZ2SH/5zciF2FM6fFp1tPg=;
	b=zuotKfvTKbBNr1XDp7EnliGK08aysOe25VVCo+8rUypcZBOouhwTjkRdSF35Twqw4juFE5
	sY2zRtelnAw5GmqnoOLvQsFrD5gSZpTMKHiJpa49mPEfXw1u/Z/8zD4StVtPE6xWbGGUs7
	vNTBG7xssauguqtbD57PTLNe3gH7nnAL6X6scmuEr9XikUWT5xnUSshyAmW96XIrWEZ5tQ
	Es+JiAqk714dlnGaoZdpjcvpo/D18+FAy3NPw9dTeKhh9RMN1Tf0aFtiBnHU4LlunZQolZ
	7yPmB0iFqwjNIKSr6L/7t4D6gFS2Iv9s34M9UFCAYKQqNnThqyCxF+M3Zeh8dw==
Date: Mon, 30 Jun 2025 12:05:54 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Baokun Li <libaokun1@huawei.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, mcgrof@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, Matthew Wilcox <willy@infradead.org>, 
	Zhang Yi <yi.zhang@huawei.com>, Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH v4] fs/buffer: remove the min and max limit checks in
 __getblk_slow()
Message-ID: <4qln6l2oc4y3yvfm36tbsgkxxaq4i7yvxbzlnz36yrvajdwmfs@lkk7ujwbulq2>
References: <20250626113223.181399-1-p.raghav@samsung.com>
 <3398cb62-3666-4a79-84c1-3b967059cd77@huawei.com>
 <20250629111506.7c58ccd7@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629111506.7c58ccd7@pumpkin>
X-Rspamd-Queue-Id: 4bW1yN51X8z9sqc

On Sun, Jun 29, 2025 at 11:15:06AM +0100, David Laight wrote:
> On Fri, 27 Jun 2025 10:02:30 +0800
> Baokun Li <libaokun1@huawei.com> wrote:
> 
> > On 2025/6/26 19:32, Pankaj Raghav wrote:
> > > All filesystems will already check the max and min value of their block
> > > size during their initialization. __getblk_slow() is a very low-level
> > > function to have these checks. Remove them and only check for logical
> > > block size alignment.
> > >
> > > As this check with logical block size alignment might never trigger, add
> > > WARN_ON_ONCE() to the check. As WARN_ON_ONCE() will already print the
> > > stack, remove the call to dump_stack().
> > >
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>  
> > 
> > Makes sense. Feel free to add:
> > 
> > Reviewed-by: Baokun Li <libaokun1@huawei.com>
> > 
> > > ---
> > > Changes since v3:
> > > - Use WARN_ON_ONCE on the logical block size check and remove the call
> > >    to dump_stack.
> > > - Use IS_ALIGNED() to check for aligned instead of open coding the
> > >    check.
> > >
> > >   fs/buffer.c | 11 +++--------
> > >   1 file changed, 3 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/buffer.c b/fs/buffer.c
> > > index d61073143127..565fe88773c2 100644
> > > --- a/fs/buffer.c
> > > +++ b/fs/buffer.c
> > > @@ -1122,14 +1122,9 @@ __getblk_slow(struct block_device *bdev, sector_t block,
> > >   {
> > >   	bool blocking = gfpflags_allow_blocking(gfp);
> > >   
> > > -	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> > > -		     (size < 512 || size > PAGE_SIZE))) {
> > > -		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
> > > -					size);
> > > -		printk(KERN_ERR "logical block size: %d\n",
> > > -					bdev_logical_block_size(bdev));
> > > -
> > > -		dump_stack();
> > > +	if (WARN_ON_ONCE(!IS_ALIGNED(size, bdev_logical_block_size(bdev)))) {
> > > +		printk(KERN_ERR "getblk(): block size %d not aligned to logical block size %d\n",
> > > +		       size, bdev_logical_block_size(bdev));
> > >   		return NULL;
> 
> Shouldn't that use WARN_ONCE(condition, fmt, ...)

We need to return NULL if the check fails. So having the condition and
the format as an `if` condition does not look nice. Plus the formatting
will look weird.

--
Pankaj

