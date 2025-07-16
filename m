Return-Path: <linux-fsdevel+bounces-55164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF2B076D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B3D563852
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116D01AF4D5;
	Wed, 16 Jul 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="zwVpBnPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4B19F12D;
	Wed, 16 Jul 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672276; cv=none; b=neaisK2AbbT0FAHWuhtMLlkMKyu/jqzrlaesf9tHgrDwSAwJ6nuT7eGPWNpw7qFaEtEqipTuWk9QM/0KSyBCzd/Tw+ZkQrAQqAFqA/rvEf4Qt2tvqbhfIgu3iOzfMI7qWOXy47av1nML9xBlTql7GbkVVohNy2YrtlwEQt7BNOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672276; c=relaxed/simple;
	bh=Ycwee0KUkPIlMLpAT8kxcS0EgasHZ2db48sjv7B7q6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppo5fxhVwmszY8EHSFENDn7f5/7YTV+PyKCM4ENTFEXU35e4rlw5E2UuL34O8NW5mYCDL6oDW2NNdHTWLXqd2ZrpWMTZzho/vYLsKTUvXleir5bJwOER5IXF3H40zI8sYvJWP7jMhxhItGOr9esWewzBiAeRtniwrr2wTlyc3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=zwVpBnPN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bhxby5ZxHz9t8l;
	Wed, 16 Jul 2025 15:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752672270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zHp5F9+QAl3YKyU3XfG8xzFMXFlv6fbOmGfaI4nwnt4=;
	b=zwVpBnPNzovwfOdVnSWLfhcYGiGiJEXhxzQrhRqGFn2d1MYmkECMGNYtM1hjRJDwn7SnmX
	dK+0aG/gqVEyChEP3hSDpXmH3A/iPGHUHxe5aLCH/jTVmee5f+NKtIwrXSO76ZUSKbWNu0
	Pi+6w/vmUhzQW6+w1b5p2334kGkEuol3d6r7XqPRKT5U3vMp6A30G9eKmGjFMAXqGHnfjH
	6oSQdLm6uSsGZpMAO0vaGjeyi1YnaJN9kngf+/RAwASAD4oDPv1lbZWYU0eO36C4xP7cHv
	v9vD+x4EHnlJZydg33row3vnk06ulMTou2I0K0BcvEvyNO7xOlBmLDJ4zv+ksQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Wed, 16 Jul 2025 15:24:16 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 5/5] block: use largest_zero_folio in
 __blkdev_issue_zero_pages()
Message-ID: <ugprcoay3meavw4malotv5ebxlghyyrnh3jcqbrkbzfeoo22jj@cqpfvjso6spb>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-6-kernel@pankajraghav.com>
 <f7ad4e56-7634-400d-9e7c-3c3b65f9b1d0@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ad4e56-7634-400d-9e7c-3c3b65f9b1d0@lucifer.local>
X-Rspamd-Queue-Id: 4bhxby5ZxHz9t8l

On Tue, Jul 15, 2025 at 05:19:54PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jul 07, 2025 at 04:23:19PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >
> > Use largest_zero_folio() in __blkdev_issue_zero_pages().
> >
> > On systems with CONFIG_STATIC_PMD_ZERO_PAGE enabled, we will end up
> > sending larger bvecs instead of multiple small ones.
> >
> > Noticed a 4% increase in performance on a commercial NVMe SSD which does
> > not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
> > gains might be bigger if the device supports bigger MDTS.
> >
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  block/blk-lib.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index 4c9f20a689f7..70a5700b6717 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -196,6 +196,10 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
> >  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
> >  		struct bio **biop, unsigned int flags)
> >  {
> > +	struct folio *zero_folio;
> > +
> > +	zero_folio = largest_zero_folio();
> 
> Just assign this in the decl :)
Yeah!
> 
> > +
> >  	while (nr_sects) {
> >  		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
> >  		struct bio *bio;
> > @@ -208,15 +212,14 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
> >  			break;
> >
> >  		do {
> > -			unsigned int len, added;
> > +			unsigned int len;
> >
> > -			len = min_t(sector_t,
> > -				PAGE_SIZE, nr_sects << SECTOR_SHIFT);
> > -			added = bio_add_page(bio, ZERO_PAGE(0), len, 0);
> > -			if (added < len)
> > +			len = min_t(sector_t, folio_size(zero_folio),
> > +				    nr_sects << SECTOR_SHIFT);
> > +			if (!bio_add_folio(bio, zero_folio, len, 0))
> 
> Hmm, will this work if nr_sects << SECTOR_SHIFT size isn't PMD-aligned?

Yeah, that should not be a problem as long as (nr_sects << SECTOR_SHIFT) < PMD_SIZED
folio.

> 
> I guess it actually just copies individual pages in the folio as needed?
> 
> Does this actually result in a significant performance improvement? Do we
> have numbers for this to justify the series?
I put it in my commit message:
```
Noticed a 4% increase in performance on a commercial NVMe SSD which does
not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
gains might be bigger if the device supports bigger MDTS.
```

Even though it is more of a synthetic benchmark, but this goes to show the
effects of adding multiple bio_vecs with ZERO_PAGE instead of single
PMD_ZERO_PAGE.

--
Pankaj

