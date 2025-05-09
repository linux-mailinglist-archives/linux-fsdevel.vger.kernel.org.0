Return-Path: <linux-fsdevel+bounces-48666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C32FBAB1E8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 22:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272021BA5903
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0825F7AB;
	Fri,  9 May 2025 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="rG01sxaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4811254AF0;
	Fri,  9 May 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746823852; cv=none; b=DQ0qqslL9BZ7RHSqYnWJstJ/nI4cztlfEBiSiMx5/W8QOVDujYNHCzDNqFEnFHjvJXjku86TuVIDb6C5fkerOREUPpXh80m3AZGouqox+JY07I7c+acTX30yWalt2BZupglzoDyWHlv/mHdiM0DeteFx8HKZsATlo2Z8bY56Oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746823852; c=relaxed/simple;
	bh=+rnJQhpIdvi8n7d/eXk9rhHWaHKhecmumCmZihOwicA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaA2R1yFVtjfVPyDcy5mY7nSnhNTkzAGXqSriHp5/2DxHD9XzRU0cEaATGS5Bx1J5xe9jynYX0VCiChOvuE5dEE4l/jiVWmdDzdM474bF2pgLsK+WjRUrzOTFbX9yxfFhipQ4zTm7mEn8lj+bQ6+qVZgjstxXGiI6bqspCbJBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=rG01sxaH; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZvLk912xRz9spL;
	Fri,  9 May 2025 22:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1746823841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SdXRG7RMOcGcSkcOmgddaIl70trvrvcQZYo0G1lX58=;
	b=rG01sxaH+rCqVLlhWdLqiLaZzCT3l3yOBNy9rMw3G/0e1HhACjPeme2+mhhdloKhy+yuPn
	CFI5bkUTjkTrzGmxXiDFAwhv/cC3o/YsBKE1J9W0EgRrldxPShQvMfl4oNZz2vf4Bk0CCL
	4FYRofVykvh3SEKvljDUkRzmZZev29V7ravpCcR6IkdqEDBu0j7OeM+855TxVCUsoYQPCn
	C0x1FC/xU9/ZuRkDONc6t16fVmRc8ULeFSYHoWDUTjbwMIskQLbiIOu3ZNipzqx/+d/ME+
	iy7boEy+3xpOVC7yyYAuM94+4xBVMjHzLDXDk88D3GykyIAXUNobJT2z1NuSDw==
Date: Fri, 9 May 2025 22:50:32 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, p.raghav@samsung.com
Subject: Re: [RFC PATCH v4 1/5] mm/readahead: Honour new_order in
 page_cache_ra_order()
Message-ID: <pskrpcu3lflo3pgeyfvnifcn7z2o6bsieaclntsbyvefs4ab3a@cyfnf36mccvi>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-2-ryan.roberts@arm.com>
 <nepi5e74wtghvr6a6n26rdgqaa7tzitylyoamfnzoqu6s5gq4h@zqtve2irigd6>
 <22e4167a-6ed0-4bda-86b8-a11c984f0a71@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e4167a-6ed0-4bda-86b8-a11c984f0a71@arm.com>
X-Rspamd-Queue-Id: 4ZvLk912xRz9spL

> >>  
> > 
> > So we always had a fallback to do_page_cache_ra() if the size of the
> > readahead is less than 4 pages (16k). I think this was there because we
> > were adding `2` to the new_order:
> 
> If this is the reason for the magic number 4, then it's a bug in itself IMHO. 4
> pages is only 16K when the page size is 4K; arm64 supports other page sizes. But
> additionally, it's not just ra->size that dictates the final order of the folio;
> it also depends on alignment in the file, EOF, etc.
> 

IIRC, initially we were not able to use order-1 folios[1], so we always
did a fallback for any order < 2 using do_page_cache_ra(). I think that
is where the magic order 2 (4 pages) is coming. Please someone can
correct me if I am wrong.

But we don't have that limitation for file-backed folios anymore, so the
fallback for ra->size < 4 is probably not needed. So the only time we do
a fallback is if we don't support large folios.

> If we remove the fallback condition completely, things will still work out. So
> unless someone can explain the reason for that condition (Matthew?), my vote
> would be to remove it entirely.

I am actually fine with removing the first part of this fallback condition.
But as I said, we still need to do a fallback if we don't support large folios.

--
Pankaj

[1] https://lore.kernel.org/all/ZH0GvxAdw1RO2Shr@casper.infradead.org/

