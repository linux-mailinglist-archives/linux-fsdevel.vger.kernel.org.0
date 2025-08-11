Return-Path: <linux-fsdevel+bounces-57300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC23B2051F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7043AE4D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2A22A4CC;
	Mon, 11 Aug 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="g745/gIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109E1DF982;
	Mon, 11 Aug 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907608; cv=none; b=mtSuLi620x8p/4RtP/OYk+kpKhV16qh7yWU/kp/pBRwZllnUvvI8QScNNp5amsQOwlUS4gHXhq3mpaDexREHv9kwnlsMhAOjsXu5zCpHxS9JIlfsBMmB25f/y5KP4HOkVpSYQI3Ze5m6CsKN78SxPTZaoAEVFMB6TXQAphjBpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907608; c=relaxed/simple;
	bh=FJlUFyL1R+XZtVmsXNA2lWDfz7UoNDLHRD8kXsfNIDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlZU7EwUIBI4KibNVpNITDk0wkbIbTj108FrxoKZuZAYOBC4y5/6jA3JKz7Z2oLeN73J2AOyX2WF9zLK8LvbF1QEMLNOOuAbHpzMzdl10T4kEkGERdQ97+mb/JcSCQ9D4Dsm5uLMkJMOOHk9+xT07P90yZ8XJ8XzgvEehb+HNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=g745/gIx; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c0rH42b22z9sjB;
	Mon, 11 Aug 2025 12:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754907600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDBt9G451b4z8m3hFF/H1Ireg3q2+0iEF/cMTnKNzjI=;
	b=g745/gIxsbzXatM5o0BK3LZFVN6WHz3Fg23aj1XXyhxFSZy1cW+pJm2UEOjzgJeffNYz37
	GVM3XBUXUQZ8JW3wbKjUWS/+aivLVvyPnn8Pvu0j+wRyG48R6a5vdqmIlXSsBfC6r/4SgX
	ziz/h9mKmEnMlRZwPfmH9VPESZ2khnyampl+h4lh5/aZ73vmLygtHqGP57JAiTg8JYkzBc
	VlrAh4pSk//WffTSUiQBeih6Onm1GPDJefFzjLwQRL3+sNAsirC0Fz5+8G5hhGYJZr5xcE
	PU9G7R+5WBj4xL0Ed9NB3pSGCKDk7GXeKrnwWYSugCBPnrtb/+POv+xDYeaHug==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Mon, 11 Aug 2025 12:19:51 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
Message-ID: <p6ciia5cm5re4paau3tqhcdk3cdjmnwjuc2l5rv6ztb6kcgvyp@2g6ei7okvuw5>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
 <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
X-Rspamd-Queue-Id: 4c0rH42b22z9sjB

> > Sorry, RFC v2 I think. It got a bit confusing with series names/versions.
> 
> Well, my worry is that 2M can be a high tax for smaller machines.
> Compile-time might be cleaner, but it has downsides.
> 
> It is also not clear if these users actually need physical HZP or virtual
> is enough. Virtual is cheap.

We do need physical as the main usecase was for block IO where we will
be DMAing. The main reason I was seeing an improvement in perf was we
were sending bigger chunks of memory in a single bio_vec instead of
using multiple bio_vec.

--
Pankaj


