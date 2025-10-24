Return-Path: <linux-fsdevel+bounces-65436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1809EC05512
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8138353211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB42F99A5;
	Fri, 24 Oct 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="iaabcnQI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t3ftFPHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A43309EE2;
	Fri, 24 Oct 2025 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297973; cv=none; b=kzPmsZvDBaCi7QnSpvWtfE3L4+JWmXg2BGALGKLaAZbFFh2CoYMdX5J/Dtlm0iNSXNb9WOADDR9QWeTfU3BWGlUX84snJJPeEDFoWygF/QTO2+NkWv44PkKj2hHbq2ZEiuCTfi2lIuhXEZSi8gNucGYf1dLbYFDCu8D11h5ByTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297973; c=relaxed/simple;
	bh=BdVucMLiQQEjX6RceDm+ToNFzzrCN8nClQ4+iyELyy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peGgqldxiJATwBQFv5eihh8pYRTWub9scsCvSnN0uCxajjZkgj6epskHg1TCJYlCeKnafKuVY3MwrCxFW1u6FM4ktmbrrxshf4hvfy0cQ9lu+RSjFnqqaUKRH9lASkrpfOMhBvcZxwHn8ZsqQm2TDBVyaAqPodvAvbes36DH3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=iaabcnQI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t3ftFPHs; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 8B730138021D;
	Fri, 24 Oct 2025 05:26:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 24 Oct 2025 05:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761297969; x=
	1761305169; bh=6vOP5u5uit3cxUkfpkAHqHBhu7MvgqmCIDH3vZUkkWg=; b=i
	aabcnQIduiFQ5ipLXI3sYTNqwj3QuA17NBDTDq1fIME6SB9RwYdbHrrV8OwW9Los
	O6lha55gjhXnpb5eCDrGKkyinUYaHKzN8iyO2oJdA5VsdbbLwPTXF+KaNhsa5HXt
	W7fHbXInNyT3a/9m3uXJIozft8IoQI0jQ65+d9PL74KPieqQu0QUPE0/wUFiqeBE
	7iMj8AvML4V2XZXHHXN6oSxbpCuTuH4YCHxfWxxFCzvgPhjyZYDu0nAnulvx0x1j
	G45MLfhl/6FzMdyVJtXuohWsEQrHvaDIPR3cbYpOGPopDdQcp1vwQNQMpMi38S/n
	A9G6tLNlvosmy7XMjM9sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761297969; x=1761305169; bh=6vOP5u5uit3cxUkfpkAHqHBhu7MvgqmCIDH
	3vZUkkWg=; b=t3ftFPHsQgOvgRoRYDMEV8j0Q2wDfdHCUdwMjoQGpoLSabmEXRI
	pg99abZAk5VB1xRJjFVJIfMgX4KUIUEEpSfkr6/SJ5AjhwnaB6e6gDyGXFTYA0+q
	BoqoUX2cDAACoaCsgWTm/eybdsJYfUHSfJNTR46qSaKN/pKQHZ6qgUECoQ5nxV09
	XN7fSWty1WZzkw9ILYo+4D3EpJRnX1xphb6IwHieXO7j2kbhciqz6yFYHJTq57A4
	mnlFVfvtvTPj8BZ9UzES61wz5xcvA1ngARNHcAKdk1DFsqJOOvJf+6DNNGdb7NTL
	zz5Rq/nq8xuoQnp+C8crw8vWURp4GUQVCTg==
X-ME-Sender: <xms:MEb7aKdZJSgZ29MHvsigNS1bPIyFFST-MmkpfrqhrCgodsPdMmrgIQ>
    <xme:MEb7aNRL2UNzZA7Mo3KYepn8bRHYT5FADopl3wnbPRb-mUeRtCAlQzf5pDkKAXRxm
    4K-91pOoMMr7g3W_tZtc23FQ5drWCpzaQOsPSvejcOz4AeAhBcsHHy8>
X-ME-Received: <xmr:MEb7aOfXts_XD94bsCrA1Fb57JewCvoNJVa1P7X5TOrDLcKJQ19xhiwQWRpWng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:MEb7aFCHdXRnXcHGjsRb842voZlMR7r8VLeZTiyu6Zwj0d1v31cjZg>
    <xmx:MEb7aDsCBhTTLvsrYgBSE047YfKVcvwZaZ3HwwV9jpp3G8KYxhmOPw>
    <xmx:MEb7aKFek1HdkRpUYzR7i4P6mo9kjt_kk0zltpGlnVpwAgfdBs2-jA>
    <xmx:MEb7aO2lBzM7RtgplMKnX5AS8rVgBdW4JrcthpKWMGX-iRcIAo-vpA>
    <xmx:MUb7aE-sgGrAILrrvqrM5ksHsNJ6VKG7Z3ffY1qxlijRyMG1p8k3BxRm>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:26:07 -0400 (EDT)
Date: Fri, 24 Oct 2025 10:26:05 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-ID: <xhpgje5pb5sxi5frjvje73v7oatablynl7ksyjnbrglwh5qx7h@fforsl3cwbl6>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-2-kirill@shutemov.name>
 <20251023134929.b72ab75a8c132a17ae68a582@linux-foundation.org>
 <3ad31422-81c7-47f2-ae3e-e6bc1df402ee@redhat.com>
 <20251023143624.1732f958020254baff0a4bee@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023143624.1732f958020254baff0a4bee@linux-foundation.org>

On Thu, Oct 23, 2025 at 02:36:24PM -0700, Andrew Morton wrote:
> On Thu, 23 Oct 2025 22:54:49 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > >> Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> > > 
> > > Sep 28 2025
> > > 
> > >> Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> > > 
> > > Sep 28 2025
> > > 
> > >> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> > > 
> > > Jul 26 2016
> > > 
> > > eek, what's this one doing here?  Are we asking -stable maintainers
> > > to backport this patch into nine years worth of kernels?
> > > 
> > > I'll remove this Fixes: line for now...
> > 
> > Ehm, why?
> 
> Because the Sep 28 2025 Fixes: totally fooled me and because this
> doesn't apply to 6.17, let alone to 6.ancient.
> 
> > It sure is a fix for that. We can indicate to which stable 
> > versions we want to have ti backported.
> > 
> > And yes, it might be all stable kernels.
> 
> No probs, thanks for clarifying.  I'll restore the
> 
> 	Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> 	Cc; <stable@vger.kernel.org>
> 
> and shall let others sort out the backporting issues.

One possible way to relax backporting requirements is only to backport
to kernels where we can have writable file mapping to filesystem with a
backing storage (non-shmem).

Maybe

Fixes: 01c70267053d ("fs: add a filesystem flag for THPs")

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

