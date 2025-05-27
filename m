Return-Path: <linux-fsdevel+bounces-49928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0FAC5AB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 21:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D134A276A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8E28853C;
	Tue, 27 May 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="iaV7rq0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9422882B4;
	Tue, 27 May 2025 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374140; cv=none; b=GhPgg50UvgwRFfi5FM7Eh2ERmep5LR2DlO2RKumkx7wQHA8bVCerpToOZ3dvFeXDfbRGCF+ea+EOVguK+5sBOidDlYNBRXN6zw7u3i+mnfdcGL/y3Avwg/yrt7JJaTIgNs95lDVkC8uz1AdNt5vqRyqJga81XFWNQ1rlxNsKNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374140; c=relaxed/simple;
	bh=MpHykqxWDAyFf40IcVv0Is/3+Mh+a8zNYGmx1jJOtpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGkh+oGgeg0iu5PAKtTR0PT0rRHLrRb630Fmkje0s2WKlowW9Wu/gXTwbmAgpTMqHTxcCKdMRVrZOMaxbmhETyV0CP7xcToi0P8UgclLzlN5iEd8Nbs4AwpQiyts3hNU8YFg76JeOXWd8GHy+x0TNuiJ+raMfVGySjCsLxpGPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=iaV7rq0c; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4b6N3N3QXYz9vGt;
	Tue, 27 May 2025 21:28:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1748374128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPtjj75LRfTYzMr7PmwGMbGTNi6uiMC9nL4Pt05dBys=;
	b=iaV7rq0c9sPviNFq8k/l6+ZI7uEV8a+jxbHrGmGr3AAFY6ozHA49ZP8mqDQ0Wz6PruzSU7
	EW/9I2wxBhoaskTqLXrx8ObKhDqKUZcokjtPvJCbe+ZvkJJWhxb7g+/3APHCERvUIQdr0P
	jKpCD97ca7GHbFefbKnGzQBntKwW6JKPZqR3HoGYf7oC7yZ/9y29QApLKaGj2drvOpgy4m
	fHzOSSFx7vRM+2/nEjXJQLeFRijj61SmP/TSTvxQTaag/q8S+IJ7yolna3lq01psb2dSfX
	AJ4VcyVsBylnUm0dMVl9YiYeKTyLK9oTLL/w90cNBgs6suD4xClLwkIRf9Jrmw==
Date: Tue, 27 May 2025 21:28:35 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, willy@infradead.org, x86@kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
Message-ID: <jewtporls43r5y3eybqzm4bcku5sf3wzw6ewfjbyykeb3mxp27@ydjcrck6ldkd>
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
 <626be90e-fa54-4ae9-8cad-d3b7eb3e59f7@intel.com>
 <5dv5hsfvbdwyjlkxaeo2g43v6n4xe6ut7pjf6igrv7b25y2m5a@blllpcht5euu>
 <1c1f0ad7-8668-406b-9e4c-59ee52f816b3@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1f0ad7-8668-406b-9e4c-59ee52f816b3@intel.com>
X-Rspamd-Queue-Id: 4b6N3N3QXYz9vGt

> > You are right that if this config is disabled, the callers with NULL mm
> > struct are guaranteed to fail, but we are not generating extra code
> > because there are still users who want dynamic allocation.
> 
> I'm pretty sure you're making the compiler generate unnecessary code.
> Think of this:
> 
> 	if (mm_get_huge_zero_folio(mm)
> 		foo();
> 	else
> 		bar();
> 
> With the static zero page, foo() is always called. But bar() is dead
> code. The compiler doesn't know that, so it will generate both sides of
> the if().
> 

Ahh, yeah you are right. I was thinking about the callee and not the
caller.

> If you can get the CONFIG_... option checks into the header, the
> compiler can figure it out and not even generate the call to bar().

Got it. I will keep this in mind before sending the next version.

> > Do you think it is better to have the code with inside an #ifdef instead
> > of using the IS_ENABLED primitive?
> It has nothing to do with an #ifdef versus IS_ENABLED(). It has to do
> with the compiler having visibility into how mm_get_huge_zero_folio()
> works enough to optimize its callers.

I think something like this should give some visibility to the compiler:

struct folio *huge_zero_folio __read_mostly;

...
#if CONFIG_STATIC_PMD_ZERO_PAGE

struct folio* mm_get_huge_zero_folio(...)
{
  return READ_ONCE(huge_zero_folio);
}

#else

struct folio* mm_get_huge_zero_folio(...)
{
  <old-code>
}

#endif

But I am not sure here if the compiler can assume here the static
huge_zero_folio variable will be non-NULL. It will be interesting to
check that in the output.

--
Pankaj

