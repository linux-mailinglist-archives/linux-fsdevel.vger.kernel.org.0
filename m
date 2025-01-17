Return-Path: <linux-fsdevel+bounces-39544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098DCA15791
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D688188C1B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526B81AA7AE;
	Fri, 17 Jan 2025 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geQjXpnk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8C1A9B5E;
	Fri, 17 Jan 2025 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139737; cv=none; b=BwCGZIt4nhLqW+VTWIfFCG0c8OgpW+tCAa9hniwDUPAD3Myk8skEpi7mtoXq6m5QW8CJdJOCt6Sd7pY3P5xHJ6DhYmR0AVe4wp7ajMxlMV1Ef4GcPp7Vhb+xlD+ek4k+/peVJAYVbp6e9gJ4eN46bM5LYbW4ooFemw92GOd3v3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139737; c=relaxed/simple;
	bh=uSFr7uPxilQbgYq0+zdRZr9nXpg4EleYwwocnWKeN/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCs3Z+cp1hsvT5VgrF8Ya3rq6YrqplBA+xu2Mt2pZGZQxzoU3CZ4QCisvWA/8xPZw8goRbnJImU5Vmth54R0msdIErRsSjPvTabIVWCq0SeDiYzz/pCjz0b6KvsidzeggfZU1PagH4kvgxdRR6Y3PR30YhCKwrPkOU6w8gkSazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geQjXpnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20AEC4CEDD;
	Fri, 17 Jan 2025 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139736;
	bh=uSFr7uPxilQbgYq0+zdRZr9nXpg4EleYwwocnWKeN/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geQjXpnkhLCLWNLZMlbB0uJh57q6izf7cWViOO2F3QNL/ezvbGLWlZ6EfPWvlc2My
	 rHe05QmuTuqLIidP4pipPlO48mWH7ktnfqpKLeeojkdVldgxvD7AaTKnc6uKPaXwIS
	 ga3EUvvp6X7PGXDi+/0ClVy9SKTfFIrn4XXbPiPPy5b7Ktwd2JKbsetGBzUa3xElwx
	 dd+7LrfnacEwWzKg9sfLTrUx2oHYSLZQJ1q/Tbb+sf7Kmt9ZGhbTzsUIslJc40j3zC
	 f0bWxHKeluIzDMEMuQUUD5l7BGPRYAg3ihn1LbR3xYyrdCik1B+gSzMB+629x65BkD
	 LE4h18DRFoGEw==
Date: Fri, 17 Jan 2025 18:48:55 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z4qmF2n2pzuHqad_@google.com>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4qb9Pv-mEQZrrXc@casper.infradead.org>

On 01/17, Matthew Wilcox wrote:
> On Fri, Jan 17, 2025 at 04:41:16PM +0000, Jaegeuk Kim wrote:
> > If users clearly know which file-backed pages to reclaim in system view, they
> > can use this ioctl() to register in advance and reclaim all at once later.
> > 
> > To MM and others,
> > 
> > I'd like to propose this API in F2FS only, since
> > 1) the use-case is quite limited in Android at the moment. Once it's generall
> > accepted with more use-cases, happy to propose a generic API such as fadvise.
> > Please chime in, if there's any needs.
> > 
> > 2) it's file-backed pages which requires to maintain the list of inode objects.
> > I'm not sure this fits in MM tho, also happy to listen to any feedback.
> 
> You didn't cc the patches to linux-mm, so that's a bad start.

Because #1.

> 
> I don't understand how this is different from MADV_COLD.  Please
> explain.

MADV_COLD is a vma range, while this is a file range. So, it's more close to
fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
at the time when it's called. The idea is to keep the hints only, and try to
reclaim all later when admin expects system memory pressure soon.

