Return-Path: <linux-fsdevel+bounces-56828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CE3B1C22F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8758A18C150E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C047C27A45C;
	Wed,  6 Aug 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="nDeV21LU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3A27A44C;
	Wed,  6 Aug 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469081; cv=none; b=uSQiuCp2qsAQAk6VlVub+0GJu5b6sLdttMZP/KN7MAB7aqETyBibm4UbEC5XUIFmWJyr5IEwgVSTnyV1+SGrKIoN1SIjVpCWB9enbqFmRieMLGtg9F693fwjmBS8cE2VSLZ0Jvu7vN1vUBiC/jwcxCkVUWYPLlbk+SaAp01IOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469081; c=relaxed/simple;
	bh=mDzWbnRjPII8hImVT2ZZyfd/+Do9MUSNWOarhxJCHr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fifWCC8B+0LwYhbtagVmlD2iPvDFB6hroDGe7QrW1ZNYcNGYVM084L0GSBnml47bvRcxvbeawxVorfq+tt6h8rFQfXzYmfwez+zwKUUgP6bOmx1cvof3XQbe1wBbaQZidjdK5H6SMD6E6FIEhCx5ASg+NgItAXYeQHfj4hvmFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=nDeV21LU; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxk5q5vjrz9sqV;
	Wed,  6 Aug 2025 10:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754469071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=py34VqOzQ9pWh6EBiyUkIJl45E2Wer+VK9zaZW2R3SM=;
	b=nDeV21LUbtqaEOjteeH1riWZCiLBxbE3BkNV2HdvNgmGeCpKjBFZuH4cNvu89HmQ0VErfB
	ecy16tkxrUZDrAjY7lfQHzSRAofNCCN/EdEcxkFS90w845E/kAs6mlpdjSSMAnYyKL0gnR
	+7+VwzNzTUosrHelFt7O8mO6WHBwvYKkJyy7pE+F7RXkb4ivmYna5nevvQ4uQOSGWuAf98
	qGzRMKS95DASfhM0i7L92eOxI89wHympUSRIfzuceZksFJw9sc43ItD30/SVYRvsUiy75A
	uagw2l3ED9QiBNUUlzxhqRWFPGT3bhXKpoHP5OqUl5d/609MVvQBu4qYXJI2AA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Wed, 6 Aug 2025 10:31:02 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 0/5] add static huge zero folio support
Message-ID: <sqpsvjefzukhqbumjmnhsotixw2vpdy76d3batdtlbztzk4q5w@osrjvx22pvah>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <c3b0adc9-e8e9-45ce-b839-cb09dcce3b50@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b0adc9-e8e9-45ce-b839-cb09dcce3b50@intel.com>
X-Rspamd-Queue-Id: 4bxk5q5vjrz9sqV

On Tue, Aug 05, 2025 at 09:00:40AM -0700, Dave Hansen wrote:
> On 8/4/25 05:13, Pankaj Raghav (Samsung) wrote:
> > Add a config option STATIC_HUGE_ZERO_FOLIO that will always allocate
> > the huge_zero_folio, and it will never drop the reference.
> 
> "static" is a really odd naming choice for a dynamically allocated
> structure. It's one that's never freed, sure, but it's still dynamically
> allocated in the first place.

That is a fair point.

I like the rename you did to PERSISTENT_HUGE_ZERO_FOLIO instead of
STATIC_HUGE_ZERO_FOLIO as we still allocate it dynamically.

@David, @Lorenzo and @Zi: Does the rename sound good to you?

--
Pankaj

