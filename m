Return-Path: <linux-fsdevel+bounces-48478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402C3AAFAA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 14:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4929E1C22035
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E59450FE;
	Thu,  8 May 2025 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bjRVISLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9A227B94;
	Thu,  8 May 2025 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708957; cv=none; b=lOzDIckcnBIoCvdVCdiahb0PvA/WVs7sh7YT2Vdhh5UYzEsliegPOhsGqpLjhFFi8PjFAt5uo4B63NfjDW55RyGEAkre7Ex44jondrnQcYbuYqCONWu4UPNPST5zFZs90Br7UJyRfwb+GI6i6AQsrEoLC8up+VKM4nO1Vpanf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708957; c=relaxed/simple;
	bh=Lj45j4fOwe928+apVmd2LQmRdI6iPSMldwVQtJCnIBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7fFjSCw6niTzdWIIxOf0dB5ZhjkL5v1QmNaLIvSvwA2Op6FUVeVSMBmY48HaAzNZVrThS/Cy2nb04t9/L+mCI1MisilwfQAak0s2oGG04peMml0oVuxB1B2FcNe/yvehYFqOhwRjP4LClj/DyeawjFBuawe3w4CPRgF41g3wVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bjRVISLB; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZtXDl0rVQz9tH2;
	Thu,  8 May 2025 14:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1746708951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1U4rZGx6XERUK703NiiO7qOrMXmSyQcFqlgMieceks=;
	b=bjRVISLBtHX5DfYSngZXkcLernXd84uYnUhhfzmlqWxXU9ogXS+VA1nVBWV9C1OFAPhqrl
	DQwRHux+nTpoGHBRb/gwfeWNh70+kMhrQWYrv79phGNmIEqQXGFC49a2bgJPAHmLhdkwxt
	ZFp+s7KYFMcqqnWUY3eI9hBea5SP0YjYFVmEo5lpFa4k3vI9fvdUMGMfwOoBrm+8Sqls4s
	Qcc8j5qQPJHtt1XCPgM7RJ3+7TRvmqeAX2koZA923N0GkgcrDXU5tBajcjK6B2FKUpknB2
	fqW9+yH4BbWCpv7P1pegCvQqVTLRoXqbMzB7aHwj2DPWWBsYwRCLPJGemPmoVw==
Date: Thu, 8 May 2025 14:55:43 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 1/5] mm/readahead: Honour new_order in
 page_cache_ra_order()
Message-ID: <nepi5e74wtghvr6a6n26rdgqaa7tzitylyoamfnzoqu6s5gq4h@zqtve2irigd6>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430145920.3748738-2-ryan.roberts@arm.com>

Hey Ryan,

On Wed, Apr 30, 2025 at 03:59:14PM +0100, Ryan Roberts wrote:
> FOLIO  0x0001a000  0x0001b000       4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000       4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000       4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000       4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000       4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000       4096       31       32      1      0
> FOLIO  0x00020000  0x00024000      16384       32       36      4      2
> FOLIO  0x00024000  0x00028000      16384       36       40      4      2
> FOLIO  0x00028000  0x0002c000      16384       40       44      4      2
> FOLIO  0x0002c000  0x00030000      16384       44       48      4      2
> ...
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/readahead.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6a4e96b69702..8bb316f5a842 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -479,9 +479,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  

So we always had a fallback to do_page_cache_ra() if the size of the
readahead is less than 4 pages (16k). I think this was there because we
were adding `2` to the new_order:

unsigned int min_ra_size = max(4, mapping_min_folio_nrpages(mapping));

/*
 * Fallback when size < min_nrpages as each folio should be
 * at least min_nrpages anyway.
 */
if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size)
	goto fallback;

>  	limit = min(limit, index + ra->size - 1);
>  
> -	if (new_order < mapping_max_folio_order(mapping))
> -		new_order += 2;

Now that you have moved this, we could make the lhs of the max to be 2
(8k) instead of 4(16k).

- unsigned int min_ra_size = max(4, mapping_min_folio_nrpages(mapping));
+ unsigned int min_ra_size = max(2, mapping_min_folio_nrpages(mapping));

I think if we do that, we might ramp up to 8k sooner rather than jumping
from 4k to 16k directly?

> -
>  	new_order = min(mapping_max_folio_order(mapping), new_order);
>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  	new_order = max(new_order, min_order);
> @@ -683,6 +680,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  	ra->size = get_next_ra_size(ra, max_pages);
>  	ra->async_size = ra->size;
>  readit:
> +	order += 2;
>  	ractl->_index = ra->start;
>  	page_cache_ra_order(ractl, ra, order);
>  }
> -- 
> 2.43.0
> 

--
Pankaj

