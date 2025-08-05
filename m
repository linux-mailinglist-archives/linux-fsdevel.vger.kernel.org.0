Return-Path: <linux-fsdevel+bounces-56737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFBEB1B2AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 13:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405757AA33A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B7125A626;
	Tue,  5 Aug 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="m3praHCn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC451917E3;
	Tue,  5 Aug 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754394071; cv=none; b=dhpLdAl/GfhWS5Pf8XogKZilzX3XS/CZ9ZhjNMAHswzQW2pkRa0Ndx2zgULHNbz6y0qDeGyl/yHp8KNIZyjsQo8ecipq4hzhkWUMrrOfnVPrkM4WmXFC6m8EU2i+9DY75thm1vC7TFN+uYnyimCjpdPnu/Ndb7XzIzuky22aeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754394071; c=relaxed/simple;
	bh=pNsHYAr00WaqEVJYvd9WruoCdVpv2BxDafChToYFmSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFLkHpB6YPi3v+IViulgLJpEKUzG+3td7Ql8Z19FuncDgwlhyZktm6VOSdPv4M+drBO3ePbeC1UTdEDncaj8B3sO1wTqiTY/ZRCbujtFDZBzrAIPA0KyDIIma14r3kXzoJNrdsf9hQVVCDqDs+k+xelK38DK2jQRmXB8qAC6jJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=m3praHCn; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxBMH4rKSz9t6B;
	Tue,  5 Aug 2025 13:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754394059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmEnKsY11qSmqnHzHIwJADtWs59gB0JXO/b+GAgtrX8=;
	b=m3praHCntM/p3xOI6zdjvjnxW8gQopf/zzPO6ndH3fXwgubVWgSr1ZbH5Jw0cV05Yn6xot
	hrYPn5XEMFYGJUyBqvh75jmM3UHRKvRC6VW55w9fZip21gotUBMJn/Fn5VeLcbiK1ymJUw
	rL3tZLd/io/ut39fnW3OdGrZT/hFCUaB7UKqzmEqUp3yVKMkg77gxUigEPNcCsFfshY/GK
	ukvvxjDeQ7F3mfHr/XThHYuhgnaOFbIWu2UwufT5PSxF+GBZWtT0Em9L97u1g/27uTIkx3
	1oUs5llRqGuFEBkd+5FxH1aU+u3VFKS1Tad9BZvAND99rLhbKUT9vIM0lJVp3g==
Date: Tue, 5 Aug 2025 13:40:47 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
Message-ID: <dwkcsytrcauf24634bsx6dm2wxofaxxaa4jwsu5xszmtje3gin@7dzzzn6opjor>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
 <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
 <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>

Thanks a lot Lorenzo and David for the feedback and quick iteration on
the patchset. I really like the number of lines of code has been
steadily reducing since the first version :)

I will fold the changes in the next series.

<snip>
> > > @@ -866,9 +866,14 @@ static int __init thp_shrinker_init(void)
> > >   	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
> > >   	shrinker_register(huge_zero_folio_shrinker);
> > > -	deferred_split_shrinker->count_objects = deferred_split_count;
> > > -	deferred_split_shrinker->scan_objects = deferred_split_scan;
> > > -	shrinker_register(deferred_split_shrinker);
> > > +	if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO)) {
> > > +		if (!get_huge_zero_folio())
> > > +			pr_warn("Allocating static huge zero folio failed\n");
> > > +	} else {
> > > +		deferred_split_shrinker->count_objects = deferred_split_count;
> > > +		deferred_split_shrinker->scan_objects = deferred_split_scan;
> > > +		shrinker_register(deferred_split_shrinker);
> > > +	}
> > >   	return 0;
> > >   }
> > > --
> > > 2.50.1
> > > 
> > > 
> > > Now, one thing I do not like is that we have "ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO" but
> > > then have a user-selectable option.
> > > 
> > > Should we just get rid of ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO?
> > 

One of the early feedbacks from Lorenzo was that there might be some
architectures that has PMD size > 2M might enable this by mistake. So
the ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO was introduced as an extra
precaution apart from user selectable CONFIG_STATIC_HUGE_ZERO_FOLIO.

Isn't it better to have an extra knob per-arch to be on the safer side
or you think it is too excessive?

> > Yeah, though I guess we probably need to make it need CONFIG_MMU if so?
> > Probably don't want to provide it if it might somehow break things?
> 
> It would still depend on THP, and THP is !MMU. So that should just work.
> 
> We could go one step further and special case in mm_get_huge_zero_folio() +
> mm_put_huge_zero_folio() on CONFIG_STATIC_HUGE_ZERO_FOLIO.
> 
> Something like
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9c38a95e9f091..9b87884e5f299 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -248,6 +248,9 @@ static void put_huge_zero_page(void)
> 
>  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
>  {
> +       if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
> +               return huge_zero_folio;
> +
>         if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
>                 return READ_ONCE(huge_zero_folio);
> 
> @@ -262,6 +265,9 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct
> *mm)
> 
>  void mm_put_huge_zero_folio(struct mm_struct *mm)
>  {
> +       if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
> +               return huge_zero_folio;
> +
>         if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
>                 put_huge_zero_page();
>  }
> 
> 
--
Pankaj

