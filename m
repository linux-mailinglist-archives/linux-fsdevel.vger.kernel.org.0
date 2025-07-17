Return-Path: <linux-fsdevel+bounces-55236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C1EB08AD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 12:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E862F16F3C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20C5299955;
	Thu, 17 Jul 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="PTBFI/qq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64120A5EC;
	Thu, 17 Jul 2025 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748518; cv=none; b=TWEPJu9FgNnwazW+kG7Q+Tj/8itznR6tDOA1petM1MaLHZmW4yl0Ufn3RrtortRIsqHAlX6qvUQ820naYRRo09oP5sdPXTusoXeWNgqoMlohc136XBOITDHhw3NAWjHxl5x+dHjQ28egFsqc2LQmF+gpxTvyJUStLFbaKO9s87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748518; c=relaxed/simple;
	bh=D6Tx1yBFt3vqcbflTNUDgS5x8I66WBUE28pdk6FNMzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7nlAxsh6kokexbCUSg3n88cFWHZVJul60QRwOeLT9K5smktYGYpQnqJ9RXKQUbDCGU+lFXpy0pUWo1yr84a0BN8LmLC+LySpmhGhLY5/iCBGgGzUMBQhO5BsHJNuS4Ep/5jARGESybuyruxMQv+/lN+C1OBvj0WtoqjtwHHvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=PTBFI/qq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bjTp30TXJz9ts1;
	Thu, 17 Jul 2025 12:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752748507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RuP79Xyo9eJ/apZgJi9+2FlBvxVF/diDTxrd2884YVw=;
	b=PTBFI/qqJGNPenVj+XFELY2yRz4Py/dcj5Uc2u5m4EWXK5EvJ1sHGngRd54qNz8owNZUAx
	ROuzQvf5C5VY+6OEBlGKepXpItXbJrSxcvsFTsgFSOvT+m35xpyUyeA4+6dfsBixnI0jb/
	9H3VZKjhyvNK1stDtc9of5bqJLR+rxkDSN78QbhKOW641J4/8U/H55lkRhCzuPuQrzjRrx
	95ccHrsyat8to0Jhhf9c9CbImwlSboSXRPIOdIwnJ2yhNYry5teg0Lp0Pup4k6TjB1ZF3u
	b0010M5oo6Ve6bHo67wgiWczCQr1bjIax1dSvB+j7YctmWD3xvIzhwGfbgsm7Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Thu, 17 Jul 2025 12:34:51 +0200
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
Subject: Re: [PATCH v2 3/5] mm: add static PMD zero page
Message-ID: <gr6zfputin56222rjxbvnsacvuhh3ghabjbk6dgf4mcvgm2bs6@w7jak5ywgskw>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-4-kernel@pankajraghav.com>
 <26fded53-b79d-4538-bc56-3d2055eb5d62@redhat.com>
 <fbcb6038-43a9-4d47-8cf7-f5ca32824079@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcb6038-43a9-4d47-8cf7-f5ca32824079@redhat.com>
X-Rspamd-Queue-Id: 4bjTp30TXJz9ts1

> > Then, we'd only need a config option to allow for that to happen.
> 
> Something incomplete and very hacky just to give an idea. It would try allocating
> it if there is actual code running that would need it, and then have it
> stick around forever.
> 
Thanks a lot for this David :) I think this is a much better idea and
reduces the amount code and reuse the existing infrastructure.

I will try this approach in the next version.

<snip>
> +       /*
> +        * Our raised reference will prevent the shrinker from ever having
> +        * success -> static.
> +        */
> +       if (atomic_read(&huge_zero_folio_is_static))
> +               return huge_zero_folio;
> +       /* TODO: memblock allocation if buddy is not up yet? Or Reject that earlier. */

Do we need memblock allocation? At least the use cases I forsee for
static pmd zero page are all after the mm is up. So I don't see why we
need to allocate it via memblock.

> +       if (!get_huge_zero_page())
> +               return NULL;
> +       if (atomic_cmpxchg(&huge_zero_folio_is_static, 0, 1) != 0)
> +               put_huge_zero_page();
> +       return huge_zero_folio;
> +
> +}
> +#endif /* CONFIG_STATIC_HUGE_ZERO_FOLIO */
> +
>  static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
>                                         struct shrink_control *sc)
>  {
> 

--
Pankaj

