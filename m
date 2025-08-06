Return-Path: <linux-fsdevel+bounces-56836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A216FB1C5D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 14:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CA05630BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EACB28B3EF;
	Wed,  6 Aug 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="LacdcLE2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E442A9D;
	Wed,  6 Aug 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483354; cv=none; b=XBg7IwaedJomN2jzJWE8F75XzjsS73CO33V9wXFNkAyywlh4mRV/451XqEDop13bAKtJBdNylkkWZLR1NHPhmKSMtTUnLZRaoFJfi8U2OtMK6BXfeKw0+nR11gdDDB4i08gBn5Ta6tvsHEWFb3b0N06TjL9ZUfw6nfpnnDhNakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483354; c=relaxed/simple;
	bh=v9V4MdkG3BSzKeizl+vcIWroYMD/MI5Oy2gdz8kgxy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/DU+zia7aBms7dTe67csoWDyonA5ZicMN0XFdxsMY8Wxr0bPh3/IhDgDcgqxJ5cbERKvypnzdTSrcZsbnqWfyHZXY+Wja1yMiukqisampbp5soxgqqCEQFtzN3gdALDaIaO1L2PxbI1at8PesKFjbqtfp+B9A/prhGqdG6zW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=LacdcLE2; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxqNG01wVz9tH7;
	Wed,  6 Aug 2025 14:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754483342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0F8BQtW5gEKdjUpXxWIiVv1CLkHbu0OfI1Sll7FP47U=;
	b=LacdcLE2Sl3BNVAhnaliq5tJcRCkq0DgNFSegd4CR6RwWZF1DYx4jEuqiabDykGdWJRyd/
	vmVJKr3FCG+CVve8Gdvn9ad9KjXQ9uZ5LS7R+QuoX5RLeqrn2wfKQlnTOMCJfADBN4Jhj+
	XXmesFjqMgXAnX21u0b5He5OPpMlHEztVJ6onekJ77Z053eBpEl39UYvYROP3HZjLFALhb
	fTN3qKT/vspypImciwtcYet1nZhANU62CxjGCQVrBL4Ei2U0Y1vqvhT5BOg3PX6IjOgLCi
	QSg8vidy4Vil82zaaKxISZPtLsLxJ66pOB33R0Jt2F+MxxBZQtBVJYu5aJwAqg==
Date: Wed, 6 Aug 2025 14:28:52 +0200
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
Message-ID: <iputzuntgitahlu3qu2sg5zbzido43ncykcefqawjpkbnvodtn@22gzzl5t77ct>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
 <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
 <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
 <bmngjssdvffqvnfcoledenlxefdqesvfv7l6os5lfpurmczfw5@mn7jouglo72s>
 <e67479f5-e8ed-43a7-8793-c6bff04ff1f4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e67479f5-e8ed-43a7-8793-c6bff04ff1f4@redhat.com>

On Wed, Aug 06, 2025 at 02:24:28PM +0200, David Hildenbrand wrote:
> On 06.08.25 14:18, Pankaj Raghav (Samsung) wrote:
> > > We could go one step further and special case in mm_get_huge_zero_folio() +
> > > mm_put_huge_zero_folio() on CONFIG_STATIC_HUGE_ZERO_FOLIO.
> > > 
> > 
> > Hmm, but we could have also failed to allocate even though the option
> > was enabled.
> 
> Then we return huge_zero_folio, which is NULL?
> 
> Or what are you concerned about?

But don't we want to keep the "dynamic" allocation part be present even
though we failed to allocate it statically in the shrinker_init?

Mainly so that the existing users of mm_get_huge_zero_folio() are not affected by
these changes.

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

