Return-Path: <linux-fsdevel+bounces-49257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62719AB9CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B2E162E4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E224169A;
	Fri, 16 May 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="QhyCkFW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610761E521E;
	Fri, 16 May 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400625; cv=none; b=dAM7MhNnDWY9+232AsqWJc8qneggg7LYPMfVypdnRddCqFWv1/oH2IEX7i5ZgzfEJXuSJ8H6NWqwmXMzHA5Qn8UIr6gfj0f/LZffxoZj2NMonE/XHRTVwfJ8/ijqpBM8+OS3UBM9TzELR/Nlsu5SaVE5mgmurbq33RfmOhCgryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400625; c=relaxed/simple;
	bh=smfuN5fe6M/tq9D8lt3z+Q09J9nsqYyj9JERtoh++yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/0MDsm1KGVIumlykeSiK4zT4cPb02YHaeiUP9/yG0/EgFLXmxQoGfQHNWd3/W7S4B1QPJEu+ODPQhdNclBfBJz1fWHN+rAdj/KaEeQHPgx0WPir/F6u+40LdfqfCHzOMkP++VK+xO3njRgr+Js0UrRF4KkkdxrK1iVbAnimZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=QhyCkFW3; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZzS2237KPz9svH;
	Fri, 16 May 2025 15:03:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1747400618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k5jIIhYbIkxt9gsUjYrJMapDzXrc41ocEumqPERe5Cs=;
	b=QhyCkFW31XORoLY8RESpZbYqT50XjDBcU+SVfRlQPDM0GXbC1rqrz42fO+APu6Vt7KFGpk
	52oevjikdjxD5HPX2wsR/CLt+/Rr+lLllu800VS9lTCYKKaTwJpQUdwnK6X9VAqKycemSe
	1Bdd7XrEqt2UdBXwWiIVDM2kUpq/Zdt5SP9KN0nEY1wd9d/p0KKyKyiQZpOGj6/e7VwRQA
	/AMn3ZclX85uUcBA8+2MKbpzutKJDhQObyF8pnZp4Ol6DSLpzxwtLShv9WmJ5OzUEL04jN
	ehK9qq9MlhDifqNjW2mmaibRQXHSTBy2aGPcNZrtHXW7pwumV0T7bxHfljhm6Q==
Date: Fri, 16 May 2025 15:03:30 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, hch@lst.de, willy@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, 
	gost.dev@samsung.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC 1/3] mm: add large zero page for efficient zeroing of
 larger segments
Message-ID: <d2gqsc55wnzckszesku3xsa33nseueul4vnwfpjcb37flm5su4@xx6nahf5h3vu>
References: <20250516101054.676046-1-p.raghav@samsung.com>
 <20250516101054.676046-2-p.raghav@samsung.com>
 <cb52312d-348b-49d5-b0d7-0613fb38a558@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb52312d-348b-49d5-b0d7-0613fb38a558@redhat.com>
X-Rspamd-Queue-Id: 4ZzS2237KPz9svH

On Fri, May 16, 2025 at 02:21:04PM +0200, David Hildenbrand wrote:
> On 16.05.25 12:10, Pankaj Raghav wrote:
> > Introduce LARGE_ZERO_PAGE of size 2M as an alternative to ZERO_PAGE of
> > size PAGE_SIZE.
> > 
> > There are many places in the kernel where we need to zeroout larger
> > chunks but the maximum segment we can zeroout at a time is limited by
> > PAGE_SIZE.
> > 
> > This is especially annoying in block devices and filesystems where we
> > attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> > bvec support in block layer, it is much more efficient to send out
> > larger zero pages as a part of single bvec.
> > 
> > While there are other options such as huge_zero_page, they can fail
> > based on the system memory pressure requiring a fallback to ZERO_PAGE[3].
> 
> Instead of adding another one, why not have a config option that will always
> allocate the huge zeropage, and never free it?
> 
> I mean, the whole thing about dynamically allocating/freeing it was for
> memory-constrained systems. For large systems, we just don't care.

That sounds like a good idea. I was just worried about wasting too much
memory with a huge page in systems with 64k page size. But it can always be
disabled by putting it behind a config.

Thanks, David. I will wait to see what others think but what you
suggested sounds like a good idea on how to proceed.

-- 
Pankaj Raghav

