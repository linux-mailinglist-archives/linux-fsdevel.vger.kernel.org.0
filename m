Return-Path: <linux-fsdevel+bounces-57298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B2B204F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D746516F6C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8B2253EF;
	Mon, 11 Aug 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Y2hVlJpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6671C1F05;
	Mon, 11 Aug 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907155; cv=none; b=SH/0q1ZVLU6X2wPEh4ei6bHbM3A5fi3NzEXdzL0pPFCtr6N31QNvsg7inZtCx39e6JaS0rTihxZd+X3GUnY3CmbtbLCuylNHvwPccRWvlRPXBHMxdD+u8WEFSV3LNYPsg6kEsvN0rC3sr5Bl1tFZBP0Xyz2wrlifkseO8ZA8Wus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907155; c=relaxed/simple;
	bh=0hwiS0m5cHiYdtndYFB0rD9F++J6AXS8XuVuOz7WUdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8MvwdTQziAx+Bt1+dxHFrJnGkSEB/3XQLrR5e6p2aIOLyhtgvH4+6mlixXKlkgn3cGfWXT2hSiDu4LC8WmDhOzw5xY8PDkZluv4kCHlYl7HU5Ng/S/CAXLuuqXvCXN6Ger/8i0HttNPN9aYGHpH2sznmfFf9Ko0XT74xrJ+GKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Y2hVlJpE; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c0r6Q0v60z9t2j;
	Mon, 11 Aug 2025 12:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754907149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XEU5zlVFOVULGraJtitB5FtnZomkqZexV4SmnkieOa0=;
	b=Y2hVlJpEkip1xRP6cjvm3KEyu9xfpB5LyAnFfPUDO9YN3d4wx7R59RgB315TY4nDull6CQ
	O9go5945zO2EXd1pZ/LWjT5XP3VgxUFaM4WXa45JYp4i5nUn7muyfZr4c+iXIZTxy89AvX
	UDctIjxoZ7w/70EoHL5/imE7zLwaLg/kwdR3XoyN9KNObeD/LiCpeXsbVQXY3bcQRz2sYd
	ND4PO8br2rm6uEehnXjQk9Kuo1vMa0cZqcRMavbI9fmpPRhsDO40AsC8Plp31Ng1KDM6Pn
	cYmwQ7b9aNTn4bami5Y7yUwJJnHHOEjXO4/o/0NCY8Y4gaOwoFyZF+bY/LX36w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Mon, 11 Aug 2025 12:12:20 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
Message-ID: <hp2wzpu3bgwqyw6almor2x6exgx7t76kch4uec5fbh3xw6sy5w@p6bvhcdhpyea>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
X-Rspamd-Queue-Id: 4c0r6Q0v60z9t2j

> > > > Add a config option PERSISTENT_HUGE_ZERO_FOLIO that will always allocate
> > > > the huge_zero_folio, and disable the shrinker so that huge_zero_folio is
> > > > never freed.
> > > > This makes using the huge_zero_folio without having to pass any mm struct and does
> > > > not tie the lifetime of the zero folio to anything, making it a drop-in
> > > > replacement for ZERO_PAGE.
> > > > 
> > > > I have converted blkdev_issue_zero_pages() as an example as a part of
> > > > this series. I also noticed close to 4% performance improvement just by
> > > > replacing ZERO_PAGE with persistent huge_zero_folio.
> > > > 
> > > > I will send patches to individual subsystems using the huge_zero_folio
> > > > once this gets upstreamed.
> > > > 
> > > > Looking forward to some feedback.
> > > 
> > > Why does it need to be compile-time? Maybe whoever needs huge zero page
> > > would just call get_huge_zero_page()/folio() on initialization to get it
> > > pinned?
> > 
> > That's what v2 did, and this way here is cleaner.
> 
> Sorry, RFC v2 I think. It got a bit confusing with series names/versions.
> 

Another reason we made it a compile time config is because not all
machines would want a PMD sized folio just for zeroing. For example,
Dave Hansen told in one of the early revisions that a small x86 VM would
not want this.

So it is a default N, and it will be an opt-in.

--
Pankaj

