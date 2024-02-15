Return-Path: <linux-fsdevel+bounces-11667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D35855F13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F251C20C94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDFE69977;
	Thu, 15 Feb 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vZX1wpbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0367E70;
	Thu, 15 Feb 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992529; cv=none; b=T+O91xhubMzydYujEZYnmUqG01Mga02XDCuEPKozStf5UGd1kfM9icRD6CGvZ8KC9deD7iY0qZtVNj0jbaRtgontio99gmewbiCOPYLsxOilznYCKClxtqMqJHNoGashq9Msx98nhCj5kmZdpnAcmHkB/bvgothZ3plzU/ws4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992529; c=relaxed/simple;
	bh=/Dix1Tteb5N08BuuAiCywdHuTxMwEbP3yQyeqKVeHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm8NsTCxI0wCIQnedHA1CTh/QmyEHZ/iplaS/0eDzsXq+SmcGUqC/G6ftlipPYD75UKzGvSSYvn2oHpWc48EV2egZYvhLR5MtzVKJiVmZcvm+IIfsxZzgfDB9GvnMm9RdDXfan3SXpwkzPPZpCFS65HBvPNPN3fUGPenZCdYmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vZX1wpbm; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TbB235Ksfz9sFp;
	Thu, 15 Feb 2024 11:22:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707992523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NnZTNxId4HvhxligzacqMgIgq+kndcvJz1yu+v6yYk=;
	b=vZX1wpbmCLAJnNrZn8YjBNNwyEH1MijDqpNW0HmOFv/2dMP2To5fvdAEKKiI25BCKdlU2K
	ClXREnsKvLn0KWiW3xaaziOE2H4W9e+Lu3O2yGbOCYVZH/Lb/wdQ95AfVX2jW7EfbaRdtt
	aaYiZ1dl6DqQ3d19wC7B+LrHuEfkdPzIO+IrKwN1jAARaSmb09V3GT6nCyeBN9plKCeP9J
	USX9UvJJ+1BwbvnqmIa3hsZQpJTvGkLBLysBufbyDmWPRDmhrG6sKEhb5FeJzlfH1d29Qh
	bZxjewjRaW+zwxwSq/KWdQfo1GVCAQEXrs+qis1WwGuUSBhLECBBJqSzK4g7Sw==
Date: Thu, 15 Feb 2024 11:21:58 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 01/14] fs: Allow fine-grained control of folio sizes
Message-ID: <7tarfabbkcpxseonoakpirh7kxu6z4jnxwe7lpeyam6ujqfoxu@vkwgt4ykhfwp>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-2-kernel@pankajraghav.com>
 <Zc0LTcCcgBJnuQRN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc0LTcCcgBJnuQRN@casper.infradead.org>
X-Rspamd-Queue-Id: 4TbB235Ksfz9sFp

On Wed, Feb 14, 2024 at 06:49:49PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 13, 2024 at 10:37:00AM +0100, Pankaj Raghav (Samsung) wrote:
> > +static inline void mapping_set_folio_orders(struct address_space *mapping,
> > +					    unsigned int min, unsigned int max)
> > +{
> > +	if (min == 1)
> > +		min = 2;
> 
> If you order the "support order-1 folios" patch first, you can drop
> these two lines.
> 
Thanks for pointing this out. I actually forgot to update this later in
my series.

The only failure I was noticing for LBS in 8k block sizes (generic/630)
gets fixed by this change as well :) .

> > +static inline unsigned int mapping_min_folio_nrpages(struct address_space *mapping)
> 
> I'm not sure if you need this, but it should return unsigned long, not
> unsigned int.  With 64KiB pages on Arm, a PMD page is 512MiB (order 13)
> and a PUD page will be order 26, which is far too close to 2^32 for
> my comfort.

There were some suggestions from Chinner which might make this function
go away. But in case I need it, I will update it to unsigned long to be
on the safe side.

