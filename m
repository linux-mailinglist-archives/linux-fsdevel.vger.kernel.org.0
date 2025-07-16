Return-Path: <linux-fsdevel+bounces-55113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E7B06FED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03301892D85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E538292B53;
	Wed, 16 Jul 2025 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="NHIs7dgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3628FFEC;
	Wed, 16 Jul 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653322; cv=none; b=fc1AjStn8r6GCYy4YANs/m4nvhXkjwNJZvcCTxp7nWqWZnw2s38l3QJR2wnXWsBToBrVFQ2uQVJQPWPyGg2vtIA1yTIqtMx37Er6/BLnC1uhOVQa1ab1EEjg2DXi/NsQ7IfYP6iKFlTmGcYL/HuefdzebtHxBcg+S8srpy2Ks0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653322; c=relaxed/simple;
	bh=P9oBWoRAWelRRZX9/zMep3aOIbMkGManyEi921DBvwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeX/OJLak/81kJlf5r5trfxWnyrysrJFVbq8C2cfMRL8r0pWmwr/wWulq+nO1PebNXtrJFUnfzAhVNI9iz44AU8A6InCxEZ53D8SajwU2jMeJmh3fZxfRR7lkS9aE9kRA8u0Wlbs9OCdKXoRWinISc4QXdCPKk6OHP0B4A/AsHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=NHIs7dgb; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bhpbS5fkcz9t8n;
	Wed, 16 Jul 2025 10:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752653316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJKrk5r5ltCYBv5q1GLXxMUk75em/r0DRcmzMvc6rA8=;
	b=NHIs7dgbznvY0/lprePNJMdwzzZwGFnU5cgXO+T38Yssn9hlxixhCbYALK8gBqwE9buqww
	Z8LGFbi4vAoYzVDIB2IbHsmdtjC8mw8fDjJiNZRadeji3rKqh0z1ve2la5RatQSLKAWSD5
	ZynK4VF2Ra4NA/GB3Mr63RRaJesjeH7cLysNljrFBA3UFef0dZL/SAfSwJvkyoit+R6Uyy
	7qPNOssHTMa0KH9wJhAAP7UMZ+/e3LiA/EpRviljZYEBXexEBGbej8MV20GtB7lB+gy2mf
	YmvLl2lXLSMwkfrdJpq6hQu2dokRq/ZLpwRzrQ3Cvnt6LRUoX9YhztTMu9ZiDQ==
Date: Wed, 16 Jul 2025 10:08:28 +0200
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
Subject: Re: [PATCH v2 2/5] huge_memory: add
 huge_zero_page_shrinker_(init|exit) function
Message-ID: <2ir5ul6baqj7dk6uw5opwnsxuxfmobtoehyfxglnsadlrcurjs@7akcf3auqink>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-3-kernel@pankajraghav.com>
 <762c0b08-f5a5-4e76-8203-70514de6b5c8@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <762c0b08-f5a5-4e76-8203-70514de6b5c8@lucifer.local>

On Tue, Jul 15, 2025 at 03:29:08PM +0100, Lorenzo Stoakes wrote:
> Nit on subject, function -> functions.
> 
> On Mon, Jul 07, 2025 at 04:23:16PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >
> > Add huge_zero_page_shrinker_init() and huge_zero_page_shrinker_exit().
> > As shrinker will not be needed when static PMD zero page is enabled,
> > these two functions can be a no-op.
> >
> > This is a preparation patch for static PMD zero page. No functional
> > changes.
> 
> This is nitty stuff, but I think this is a little unclear, maybe something
> like:
> 
> 	We will soon be determining whether to use a shrinker depending on
> 	whether a static PMD zero page is available, therefore abstract out
> 	shrink initialisation and teardown such that we can more easily
> 	handle both the shrinker and static PMD zero page cases.
> 
This looks good. I will use add this to the commit message.

> >
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> Other than nits, this LGTM, so with those addressed:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks.

> >  #ifdef CONFIG_SYSFS
> >  static ssize_t enabled_show(struct kobject *kobj,
> > @@ -850,33 +868,31 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
> >
> >  static int __init thp_shrinker_init(void)
> >  {
> > -	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
> > -	if (!huge_zero_page_shrinker)
> > -		return -ENOMEM;
> > +	int ret = 0;
> 
> Kinda no point in initialising to zero, unless...
> 
> >
> >  	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
> >  						 SHRINKER_MEMCG_AWARE |
> >  						 SHRINKER_NONSLAB,
> >  						 "thp-deferred_split");
> > -	if (!deferred_split_shrinker) {
> > -		shrinker_free(huge_zero_page_shrinker);
> > +	if (!deferred_split_shrinker)
> >  		return -ENOMEM;
> > -	}
> > -
> > -	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
> > -	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
> > -	shrinker_register(huge_zero_page_shrinker);
> >
> >  	deferred_split_shrinker->count_objects = deferred_split_count;
> >  	deferred_split_shrinker->scan_objects = deferred_split_scan;
> >  	shrinker_register(deferred_split_shrinker);
> >
> > +	ret = huge_zero_page_shrinker_init();
> > +	if (ret) {
> > +		shrinker_free(deferred_split_shrinker);
> > +		return ret;
> > +	}
> 
> ... you change this to:
> 
> 	if (ret)
> 		shrinker_free(deferred_split_shrinker);
> 
> 	return ret;
> 
> But it's not a big deal. Maybe I'd rename ret -> err if you keep things as
> they are (but don't init to 0).

Sounds good.

--
Pankaj

