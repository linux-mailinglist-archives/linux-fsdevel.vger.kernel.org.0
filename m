Return-Path: <linux-fsdevel+bounces-55114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F3B06FF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FD74A4A4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02028ECD8;
	Wed, 16 Jul 2025 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ljO+xFh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612A28A1C8;
	Wed, 16 Jul 2025 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653484; cv=none; b=Xf2JBDvrVUccXmY951VTmBpYJRGwBeBrjTKdpOGelP2r3BmzEXbD/XgIEF4hUa5A2RKCHwx1UrYccXzxE8t5Uz64201nHj033z3zXfFek1pHRuNgvhK2IC9KVa/UHWlnTrQGc8MI+9MZ7uCfZWcdut1LedC/F6ZuTUCB7mrAilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653484; c=relaxed/simple;
	bh=6ccQpvHCT+zQtnhskzEb1OB/aT3mW47fTVKbeyH3kw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY6sU/siIl/CfcWF7OxkWE4w0WNeGhH9XsTH8pILcRBufK109V+HE4fEcR4OVqUXvkSk0wf/+TUMqgyZaOMJtv9grJuX5tUGLXCPAUH5cIngMpEGIxplH6uyLdQSZy/GtAcyjFwDcVMhrhQ+vAaHs1LROZyKtuaxKk+L9IU4tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ljO+xFh6; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bhpRL3bH3z9t13;
	Wed, 16 Jul 2025 10:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752652894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3rasd4RGckjps2nqSbEf6Ca5JxDIgpN3WKYKHYhHA8=;
	b=ljO+xFh6Y1Sje5EQViYAsg+P9EjH3pA2x794jvl2LOaBYpa5FpLuWXqb6yGwU8i8kII6VJ
	3Uwwh9BZXTeSxmbw6qvRUllHFvtXV1slM2vXWsXymvRfl1bfB0Dte54ludvDhCTExmlcAr
	TioWvJNa/8HuqSPiwcw3Rf11XFdcpms1V2BDJQxScDBis+sdgOZ/boFSRyXBXv2YQTpihb
	N33CmHZMciL5N3CZZWzPAcRl2Fu0Ki5+tVbBfpW/72DHeurb5VJBzIBaYT+e7d/kza/QQY
	UC5AFH+xhLqSDb1Nlg4rcT76u4MXxhXVYGVMxlSH3zQrV8DIs9ibrwl6nWNpAA==
Date: Wed, 16 Jul 2025 10:01:24 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 2/5] huge_memory: add
 huge_zero_page_shrinker_(init|exit) function
Message-ID: <fyvz7637sirugvc3yv2qzohpzybgk6zjkuaif4v6k5w5psnckw@3pjssnjpt57p>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-3-kernel@pankajraghav.com>
 <3336b153-7600-4b1a-9acc-0ecde8d32cdc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3336b153-7600-4b1a-9acc-0ecde8d32cdc@redhat.com>

On Tue, Jul 15, 2025 at 04:18:26PM +0200, David Hildenbrand wrote:
> On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Add huge_zero_page_shrinker_init() and huge_zero_page_shrinker_exit().
> > As shrinker will not be needed when static PMD zero page is enabled,
> > these two functions can be a no-op.
> > 
> > This is a preparation patch for static PMD zero page. No functional
> > changes.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >   mm/huge_memory.c | 38 +++++++++++++++++++++++++++-----------
> >   1 file changed, 27 insertions(+), 11 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d3e66136e41a..101b67ab2eb6 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -289,6 +289,24 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
> >   }
> >   static struct shrinker *huge_zero_page_shrinker;
> > +static int huge_zero_page_shrinker_init(void)
> > +{
> > +	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
> > +	if (!huge_zero_page_shrinker)
> > +		return -ENOMEM;
> > +
> > +	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
> > +	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
> > +	shrinker_register(huge_zero_page_shrinker);
> > +	return 0;
> > +}
> > +
> > +static void huge_zero_page_shrinker_exit(void)
> > +{
> > +	shrinker_free(huge_zero_page_shrinker);
> > +	return;
> > +}
> 
> While at it, we should rename most of that to "huge_zero_folio" I assume.
Sounds good.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

