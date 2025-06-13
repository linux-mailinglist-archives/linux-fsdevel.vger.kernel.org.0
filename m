Return-Path: <linux-fsdevel+bounces-51576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F77AD8621
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 10:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52E57A8872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148327281F;
	Fri, 13 Jun 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="MMO1xn8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8727B2DA748;
	Fri, 13 Jun 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749805118; cv=none; b=cKepygy+ahkUOcxlMAnXjc6xqQUMH0E+bwG9XYuSKrMffGg7+2jS2/83yPvOCLze1Zg0NW8dnAnkzE5jOM6pXhrWNeQJhyc2YChD0TAAEvc2oymBY9arpRr5mqiQPvo+S1kKS7/ZD/HKbHl4W9R4elOSR6auP4MOxn6jvkLoXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749805118; c=relaxed/simple;
	bh=dagkQ97GqIPDCbUOnDxBpmhXyMshaVbJQJOl8c1sM34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiS9DKCxmqdYMpEAJa9ZyB/gY2TcAeGmQMWbROdcb4/UnX7Q/upc7K47oQBQEbqZyadqJpwwHAQsGN4aDAvOzyR5x6WOftMEMd8bR1+0ruM9k5c8nN90xabjXKKZk8EZHRCK45YXGBEIdOtQEGzdQChYkqrr/kxcrxet0hj/bOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=MMO1xn8w; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bJYGJ2fvjz9t8V;
	Fri, 13 Jun 2025 10:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1749805112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2jomFBz2wMuPndwQd5iG25ynyxt9aXkujr5axP6UUI=;
	b=MMO1xn8wlpONqE+KPlWLozUOErEPYd4E2YI69SMPEhvG6j+lBhWvUDviiofp3xrQpunbMn
	vgh1XyuaMAqxStcd/Xi6bQ/Z+9hXlS8osru9te+iMAE1+scQL6No6y5ZuadwHlCDOdqPAK
	1BMB6cfqjP3UDQ8nZlzXNr8BlbUTiACKxL/lleuJWXbCdh2tcA96k+2BKtDECL3kOCHcDa
	H373TlNzoB6xivpxumubb5noY2fROfyPUa5RgpLNS24sN12yBvH4jHPDGT79nAV9LoYT+H
	+wJlczYGnY0Pv7e0MKOlPE/UyQrx5ycxApN0BFCN0coNPujQQdgmzK0/YDsL1w==
Date: Fri, 13 Jun 2025 10:58:15 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de
Subject: Re: [PATCH 0/5] add STATIC_PMD_ZERO_PAGE config option
Message-ID: <jpuz2xprvhklazsziqofy6y66pjxy5eypj3pcypmkp6c2xkmpt@bblq4q5w7l7h>
References: <20250612105100.59144-1-p.raghav@samsung.com>
 <30a3048f-efbe-4999-a051-d48056bafe0b@intel.com>
 <nsquvkkywghoeloxexlgqman2ks7s6o6isxzvkehaipayaxnth@6er73cdqopmo>
 <76a48d80-7eb0-4196-972d-ecdcbd4ae709@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a48d80-7eb0-4196-972d-ecdcbd4ae709@intel.com>

On Thu, Jun 12, 2025 at 02:46:34PM -0700, Dave Hansen wrote:
> On 6/12/25 13:36, Pankaj Raghav (Samsung) wrote:
> > On Thu, Jun 12, 2025 at 06:50:07AM -0700, Dave Hansen wrote:
> >> On 6/12/25 03:50, Pankaj Raghav wrote:
> >>> But to use huge_zero_folio, we need to pass a mm struct and the
> >>> put_folio needs to be called in the destructor. This makes sense for
> >>> systems that have memory constraints but for bigger servers, it does not
> >>> matter if the PMD size is reasonable (like in x86).
> >>
> >> So, what's the problem with calling a destructor?
> >>
> >> In your last patch, surely bio_add_folio() can put the page/folio when
> >> it's done. Is the real problem that you don't want to call zero page
> >> specific code at bio teardown?
> > 
> > Yeah, it feels like a lot of code on the caller just to use a zero page.
> > It would be nice just to have a call similar to ZERO_PAGE() in these
> > subsystems where we can have guarantee of getting huge zero page.
> > 
> > Apart from that, these are the following problems if we use
> > mm_get_huge_zero_folio() at the moment:
> > 
> > - We might end up allocating 512MB PMD on ARM systems with 64k base page
> >   size, which is undesirable. With the patch series posted, we will only
> >   enable the static huge page for sane architectures and page sizes.
> 
> Does *anybody* want the 512MB huge zero page? Maybe it should be an
> opt-in at runtime or something.
> 
Yeah, I think that needs to be fixed. David also pointed this out in one
of his earlier reviews[1].

> > - In the current implementation we always call mm_put_huge_zero_folio()
> >   in __mmput()[1]. I am not sure if model will work for all subsystems. For
> >   example bio completions can be async, i.e, we might need a reference
> >   to the zero page even if the process is no longer alive.
> 
> The mm is a nice convenient place to stick an mm but there are other
> ways to keep an efficient refcount around. For instance, you could just
> bump a per-cpu refcount and then have the shrinker sum up all the
> refcounts to see if there are any outstanding on the system as a whole.
> 
> I understand that the current refcounts are tied to an mm, but you could
> either replace the mm-specific ones or add something in parallel for
> when there's no mm.

But the whole idea of allocating a static PMD page for sane
architectures like x86 started with the intent of avoiding the refcounts and
shrinker.

This was the initial feedback I got[2]:

I mean, the whole thing about dynamically allocating/freeing it was for 
memory-constrained systems. For large systems, we just don't care.


[1] https://lore.kernel.org/linux-mm/1e571419-9709-4898-9349-3d2eef0f8709@redhat.com/
[2] https://lore.kernel.org/linux-mm/cb52312d-348b-49d5-b0d7-0613fb38a558@redhat.com/
--
Pankaj

