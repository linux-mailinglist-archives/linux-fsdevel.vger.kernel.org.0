Return-Path: <linux-fsdevel+bounces-51521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABADAD7C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 22:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77393A9779
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 20:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652A2D8DA1;
	Thu, 12 Jun 2025 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="R4LaJXdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925B2D8773;
	Thu, 12 Jun 2025 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760628; cv=none; b=BIeleUsEaAeyPoC1vDnFOFqSOc5HcWjdHjeB0t/ircDGM68FpW2jDwPXHI+W8NPWJD7muldwNLOojLRG2r1Ub29CAtJXM1QibAKlO0tiqkCp6n1AH65iPFPqPv7A0Hq3SwmZx/lTZkVc6dcFfzbxA6XawlPrnrHU29bVLHQw2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760628; c=relaxed/simple;
	bh=9bR2YbjDcKulL5hNBeUJr73babSsUOTOMmhT4wUFqnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSlbG5l/xpouAIPRlee4lstuHG39DirTs343CmFEuozJMFWxh2xOvWn5izai1RFV25SvSrfWKaBVSXF4oN2TrixGThVdwnpENnS9GKaeoo1CVK8zZr7dUtZjdoZA4V89aX0v/rT3ibNXPo0OS28QVFrKAlNkhY8JPWr0rJfx7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=R4LaJXdj; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bJDpk5BGyz9t5Y;
	Thu, 12 Jun 2025 22:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1749760622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Smza2Jc4Jwl4Da5lRMks2Zjvr0wRUWchDcyc8CJiMs=;
	b=R4LaJXdjSwMzUkY7g817Vq/lRyAaIBH3jcKGIh7tWnoqeown1ttyXDuiZ3nabREK7v9XHw
	ycPTaxOzRz1qNET38XoBmQrfxk3NzK9NAxaTGLMHjSWjAwvtd7MxSvkbxp1VIOaaMP5DZE
	Byzvv5fxey/X9IFFTI5HPyGIgiMDIAcg6pfLG52GYWH8NVHJ5bthwJwL9aYMSMQlR/J3IP
	E30fKoibQSosM97GRjxFsckpEWYAEezBI+osesLhmBdWKdFPoTEVgIg2F2N5eic3cFBHCK
	4U7HoT/g5YhSxT117sCaYTkH6p15140lyOmGr94ba7fhb+algNv2I1TZ7ZZVfQ==
Date: Thu, 12 Jun 2025 22:36:48 +0200
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
Message-ID: <nsquvkkywghoeloxexlgqman2ks7s6o6isxzvkehaipayaxnth@6er73cdqopmo>
References: <20250612105100.59144-1-p.raghav@samsung.com>
 <30a3048f-efbe-4999-a051-d48056bafe0b@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a3048f-efbe-4999-a051-d48056bafe0b@intel.com>
X-Rspamd-Queue-Id: 4bJDpk5BGyz9t5Y

On Thu, Jun 12, 2025 at 06:50:07AM -0700, Dave Hansen wrote:
> On 6/12/25 03:50, Pankaj Raghav wrote:
> > But to use huge_zero_folio, we need to pass a mm struct and the
> > put_folio needs to be called in the destructor. This makes sense for
> > systems that have memory constraints but for bigger servers, it does not
> > matter if the PMD size is reasonable (like in x86).
> 
> So, what's the problem with calling a destructor?
> 
> In your last patch, surely bio_add_folio() can put the page/folio when
> it's done. Is the real problem that you don't want to call zero page
> specific code at bio teardown?

Yeah, it feels like a lot of code on the caller just to use a zero page.
It would be nice just to have a call similar to ZERO_PAGE() in these
subsystems where we can have guarantee of getting huge zero page.

Apart from that, these are the following problems if we use
mm_get_huge_zero_folio() at the moment:

- We might end up allocating 512MB PMD on ARM systems with 64k base page
  size, which is undesirable. With the patch series posted, we will only
  enable the static huge page for sane architectures and page sizes.

- In the current implementation we always call mm_put_huge_zero_folio()
  in __mmput()[1]. I am not sure if model will work for all subsystems. For
  example bio completions can be async, i.e, we might need a reference
  to the zero page even if the process is no longer alive.

I will try to include these motivations in the cover letter next time.

Thanks

[1] 6fcb52a56ff6 ("thp: reduce usage of huge zero page's atomic counter")

--
Pankaj

