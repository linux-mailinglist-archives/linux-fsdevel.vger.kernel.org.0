Return-Path: <linux-fsdevel+bounces-51727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE6ADADC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458E93A5D2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCFF29B239;
	Mon, 16 Jun 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JbX1CR8R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EDB27FB10;
	Mon, 16 Jun 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070986; cv=none; b=YLAZlh96tdPQS0iNzbVVm+8M4V1NqGWFP2uFgtI9foeMaZmM6N1wNEW9+9pn10eNvhio5X0flFnGE9j5DXXCh/vuoUU30r6Mqmou5FnRi+AZz3iIQGRwNLo900wG/GU8pngKFoP8z5cQRW5r0lTLw7f9oOPxjwYoCU0YPL07pNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070986; c=relaxed/simple;
	bh=dTq/ijg9wAiLDDvYi5+KhFq6NE1kLb9RMnNwHLT6zAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOKHVGbSTLTAQhCLd9u1kzBNhCdL1sT2yzIjON8IPlFFZhAMXjt/eBZrG4h3XXdI57eJDHxskX0HSBnwQVIzOVV5okQYXeoSMaa6+NsPO5My08HhRv6gIoihCzETxskxEUx9cAVtnq0LKk03w+YE0FralqkPprcZvuStQTznQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JbX1CR8R; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bLRb2549Vz9sQV;
	Mon, 16 Jun 2025 12:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750070974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XY8QmFX6C/sGkVxyzcatdwuMOackSJD85Ys2cJrlHdU=;
	b=JbX1CR8RBtgCBQt8jaWY9VXnIednZIJjOtAvoib1pnvZYtCrjr7WedGKILsmrbjHc5Ejk1
	U+EYALUUEEX7ioXOI0+f8htJlHxdiyPInM69QH9+x/zQ9MGxC/PYi1zKomi2BzPQ+ryMgM
	LWBw4qAe5jDrzf2wJNd56YTxKrpD5t+Nr9QYUhJnBmX3C3Qd8H3J9THwBFFDwS5ccAnMAY
	b6qdhL6RV5rmJCmXJv+c3mSrO2OVMeCWO6CN+ZTHSWd9Ne1KohY8T48fiOHT6/Jy5pikcV
	D12PQCDwZVtg6fZKx7tvUb43RvI0lMB8MnmpErrcoKnSAoVyj+TX4ORp6a1K/g==
Date: Mon, 16 Jun 2025 12:49:27 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de
Subject: Re: [PATCH 0/5] add STATIC_PMD_ZERO_PAGE config option
Message-ID: <vmc7bu6muygheuepfltjvbbio6gvjemxostq4rjum66s4ok2f7@x7l3y7ot7mf4>
References: <20250612105100.59144-1-p.raghav@samsung.com>
 <30a3048f-efbe-4999-a051-d48056bafe0b@intel.com>
 <nsquvkkywghoeloxexlgqman2ks7s6o6isxzvkehaipayaxnth@6er73cdqopmo>
 <76a48d80-7eb0-4196-972d-ecdcbd4ae709@intel.com>
 <jpuz2xprvhklazsziqofy6y66pjxy5eypj3pcypmkp6c2xkmpt@bblq4q5w7l7h>
 <b128d1de-9ad5-4de7-8cd7-1490ae31d20f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b128d1de-9ad5-4de7-8cd7-1490ae31d20f@redhat.com>

> > > 
> > > The mm is a nice convenient place to stick an mm but there are other
> > > ways to keep an efficient refcount around. For instance, you could just
> > > bump a per-cpu refcount and then have the shrinker sum up all the
> > > refcounts to see if there are any outstanding on the system as a whole.
> > > 
> > > I understand that the current refcounts are tied to an mm, but you could
> > > either replace the mm-specific ones or add something in parallel for
> > > when there's no mm.
> > 
> > But the whole idea of allocating a static PMD page for sane
> > architectures like x86 started with the intent of avoiding the refcounts and
> > shrinker.
> > 
> > This was the initial feedback I got[2]:
> > 
> > I mean, the whole thing about dynamically allocating/freeing it was for
> > memory-constrained systems. For large systems, we just don't care.
> 
> For non-mm usage we can just use the folio refcount. The per-mm refcounts
> are all combined into a single folio refcount. The way the global variable
> is managed based on per-mm refcounts is the weird thing.
> 
> In some corner cases we might end up having multiple instances of huge zero
> folios right now. Just imagine:
> 
> 1) Allocate huge zero folio during read fault
> 2) vmsplice() it
> 3) Unmap the huge zero folio
> 4) Shrinker runs and frees it
> 5) Repeat with 1)
> 
> As long as the folio is vmspliced(), it will not get actually freed ...
> 
> I would hope that we could remove the shrinker completely, and simply never
> free the huge zero folio once allocated. Or at least, only free it once it
> is actually no longer used.
> 

Thanks for the explanation, David.

But I am still a bit confused on how to proceed with these patches.

So IIUC, our eventual goal is to get rid of the shrinker.

But do we still want to add a static PMD page in the .bss or do we take
an alternate approach here?

--
Pankaj

