Return-Path: <linux-fsdevel+bounces-54993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231CEB06301
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7B54A3B1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08B2264A9;
	Tue, 15 Jul 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="1UWeokjT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE1247298;
	Tue, 15 Jul 2025 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593575; cv=none; b=ONlde4K18KQRXCCnpsPtkDJscHjWnv88aEui2GyAdGOosWyvIVUAvahYaRFeMAz6Ochmg/kSfCEO0NqXZWxOK/3Ajxra1lvoP7y7Q301spHgQ4biXYe+UZ4LrLMCMcQRu7tDHNG8N2U31+LQUbn0yp5+GrotFhVgb4O4cxWNkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593575; c=relaxed/simple;
	bh=iqvttP6jIPTW1p1gklV7sBMld/X2QkcZqdqQ6Fveqec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q01tz8/217BKnXzHN8583kTCfq46oI1JG06zb6yJTTSfTox1v8vzc9tWysWeZadz3qlxzS9/YDQighmvuhyKUL+Bu5UBYNetbMsGFHQ8ZJs964H7aAl57ab2vZdxSzpmj0lXm0OEGAxsH9qZPwctDCSzh5AjZAjyD9xOdyVxnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=1UWeokjT; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bhNLJ4VQHz9tSw;
	Tue, 15 Jul 2025 17:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752593144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SlG4eFKE51I8Q2pDUIOuf68MZDRUyEWzcus631AbRg8=;
	b=1UWeokjTAAWkY7Vgo1D5IZLcQVj+c0tkriQM+avtk5iC1C5x3Q7O0NNFp/9ISFj3SiY2Ea
	sE0c1214SEwH/iS7lOD+ycunHCqpzYxAT+Jdma7GLtR/16pyiczLXpkqNrs4tar1eCLojL
	FvKdi6GTqOek9OzGe1duoKtrb8FQqoGV0XF4GNYYhjA/CJWG1QQwl9CxNytwXJ+3qxgNdd
	byO1NlbI+8gXDSniu9kFoPPJFPGwHK27PAGlIsonEqIQdqFXlRhKwH6zgce6TuneWMrqta
	rvEA4SObEvTL93xvsBmXwZAY5ehT/7srZNquOUTs2hEER8LX98/u2ND870livQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Tue, 15 Jul 2025 17:25:29 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
Message-ID: <bdlp7psevt6qqtssknhp55b65sfmbrnz373hudn3i4hqkoxa7u@oabcqpvc3z5k>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
 <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
 <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
 <c3aa4e27-5b00-4511-8130-29c8b8a5b6d9@redhat.com>
 <dca5912a-cdf4-4f7e-a79a-796da8475826@lucifer.local>
 <d7fa2e67-1960-4b1f-a8b7-147371e37010@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7fa2e67-1960-4b1f-a8b7-147371e37010@redhat.com>
X-Rspamd-Queue-Id: 4bhNLJ4VQHz9tSw

On Tue, Jul 15, 2025 at 04:16:44PM +0200, David Hildenbrand wrote:
> On 15.07.25 16:12, Lorenzo Stoakes wrote:
> > On Tue, Jul 15, 2025 at 04:06:29PM +0200, David Hildenbrand wrote:
> > > I think at some point we discussed "when does the PMD-sized zeropage make
> > > *any* sense on these weird arch configs" (512MiB on arm64 64bit)
> > > 
> > > No idea who wants to waste half a gig on that at runtime either.
> > 
> > Yeah this is a problem we _really_ need to solve. But obviously somewhat out of
> > scope here.
> > 
> > > 
> > > But yeah, we should let the arch code opt in whether it wants it or not (in
> > > particular, maybe only on arm64 with CONFIG_PAGE_SIZE_4K)
> > 
> > I don't think this should be an ARCH_HAS_xxx.
> > 
> > Because that's saying 'this architecture has X', this isn't architecture
> > scope.
> > 
> > I suppose PMDs may vary in terms of how huge they are regardless of page
> > table size actually.
> > 
> > So maybe the best solution is a semantic one - just rename this to
> > ARCH_WANT_STATIC_PMD_ZERO_PAGE
> > 
> > And then put the page size selector in the arch code.
> > 
> > For example in arm64 we have:
> > 
> > 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> > 
> > So doing something similar here like:
> > 
> > 	select ARCH_WANT_STATIC_PMD_ZERO_PAGE if ARM64_4K_PAGES
> > 
> > Would do thie job and sort everything out.
> 
> Yes.

Actually I had something similar in one of my earlier versions[1] where we
can opt in from arch specific Kconfig with *WANT* instead *HAS*.

For starters, I will enable this only from x86. We can probably extend
this once we get the base patches up.

[1] https://lore.kernel.org/linux-mm/20250522090243.758943-2-p.raghav@samsung.com/
--
Pankaj

