Return-Path: <linux-fsdevel+bounces-22921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F90923B2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B0E2840ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27AD158848;
	Tue,  2 Jul 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="FF4DRMl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23B1514DC;
	Tue,  2 Jul 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915371; cv=none; b=TFlvqu8G5O8tBhAnNiYG3rPZ0q8JUy5GQ5ANwTuQ//SVCjXJ15rU/NpyWA9vje+BFddwkkdUTJ6QZk/VS+YEdvOcWDYIkDygBCaW7TNkhbp2V2Kv6mzJ0F2wgp67F0fUwx7jHgQ4/05T544iUXdHnEWmni8zpcACtOdpyEm2/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915371; c=relaxed/simple;
	bh=xEsM1aO2uLx2f3Z+Syzd55lzyPZVaHlu7JnC0dElj9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MchfnE41jIdjIDpF5taFmozhiUgfwanIJag5/g90FEt4qHN/8VJ38hNtuNc84N0sPsqNHMBn+qeW1CGCZhI4WtOFO5V4Fy9uAfJT4OruN4eInQM/2l+hGKkVdmSz/wVUFu1CsdlB8x4tP6eKhGcJJ3ciOB68i4DdwZyi0ySAb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=FF4DRMl+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WCzMS3Z0Kz9sQ6;
	Tue,  2 Jul 2024 12:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719915364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGA34wKwysx5NC5w2uPw2pO5+dBtQxqRiC/Wy1SKQaw=;
	b=FF4DRMl+i63yqfv5l5ySVR46sxgKZK3PxHrh7stGuzCkk65s4Cb6QPPwRLa9e112elGwQY
	wFUIrQf85JyE+Qw9huGuvKNmS8dJtZI0wn/YmDK+sr8f/K5/QsI+FrKiOmsonLkSybqi0D
	4AS7g1s6MyC+BRw1PAbOw65J3doVTw4+TAIef+7RMyXgB9gj5gYQdGJyramKdyyFyxourJ
	jZ9HXGRpsMxstbhmDmQy5vPyWKvGPScGog37mvQG+69cUVpXLxG1llo16HbPr9AqtOIrCy
	c0zu3BgehargAVk+XWlN5MQ4ZVawpxs9RQpzN4WfQvKCxHuG3OfgMchJ/5lpfQ==
Date: Tue, 2 Jul 2024 10:15:56 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@lst.de>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240702101556.jdi5anyr3v5zngnv@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
 <20240702074203.GA29410@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702074203.GA29410@lst.de>
X-Rspamd-Queue-Id: 4WCzMS3Z0Kz9sQ6

> > +fs_initcall(iomap_pagecache_init);
> 
> s/iomap_pagecache_init/iomap_buffered_init/
> 
> We don't use pagecache naming anywhere else in the file.

Got it.
> 
> > +/*
> > + * Used for sub block zeroing in iomap_dio_zero()
> > + */
> > +#define ZERO_PAGE_64K_SIZE (65536)
> 
> just use SZ_64K
> 
> > +#define ZERO_PAGE_64K_ORDER (get_order(ZERO_PAGE_64K_SIZE))
> 
> No really point in having this.

Hmm, I used it twice, hence the define. But if we decide to get rid of
set_memory_ro(), then this does not make sense.

> 
> > +static struct page *zero_page_64k;
> 
> This should be a folio.  Encoding the size in the name is also really
> weird and just creates churn when we have to increase it.

Willy suggested we could use raw pages as we don't need the metadata
from using a folio. [0]

> 
> 
> > +	/*
> > +	 * Max block size supported is 64k
> > +	 */
> > +	WARN_ON_ONCE(len > ZERO_PAGE_64K_SIZE);
> 
> 
> A WARN_ON without actually erroring out here is highly dangerous. 

I agree but I think we decided that we are safe with 64k for now as fs 
that uses iomap will not have a block size > 64k. 

But this function needs some changes when we decide to go beyond 64k
by returning error instead of not returning anything. 
Until then WARN_ON_ONCE would be a good stop gap for people developing
the feature to go beyond 64k block size[1]. 

> 
> > +
> >  	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> 
> Overly long line here.
> 

Not a part of my change, so I didn't bother reformatting it. :)

> > +
> > +static int __init iomap_dio_init(void)
> > +{
> > +	zero_page_64k = alloc_pages(GFP_KERNEL | __GFP_ZERO,
> > +				    ZERO_PAGE_64K_ORDER);
> 
> > +
> > +	if (!zero_page_64k)
> > +		return -ENOMEM;
> > +
> > +	set_memory_ro((unsigned long)page_address(zero_page_64k),
> > +		      1U << ZERO_PAGE_64K_ORDER);
> 
> What's the point of the set_memory_ro here?  Yes, we won't write to
> it, but it's hardly an attack vector and fragments the direct map.

That is a good point. Darrick suggested why not add a ro tag as we don't
write to it but I did not know the consequence of direct map
fragmentation when this is added. So probably there is no value calling
set_memory_ro here.


--
Pankaj

[0] https://lore.kernel.org/linux-fsdevel/ZkT46AsZ3WghOArL@casper.infradead.org/
[1] I spent a lot of time banging my head why I was getting FS corruption
when I was doing direct io in XFS while adding LBS support before I found
the PAGE_SIZE assumption here. 

