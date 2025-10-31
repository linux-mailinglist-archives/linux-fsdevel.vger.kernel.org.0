Return-Path: <linux-fsdevel+bounces-66584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B2C250D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1353406D37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A133FE15;
	Fri, 31 Oct 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+mxzDpw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFC335569
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914372; cv=none; b=Po7fhkLQeManN51z7QNwi6CcDzqWeIgOtQbAAZFW9JLWeOkkj6a6yzn6fVuD2SpU2SCAwf9uw8rjZ4kTKNMpgGIuLeLtvbfsz8So6ubiBKi4E+e2pyPU9fe82rJgsb4193uxGuQGF47gb6++DJku8i2ofvnW3x8cfYmFBsCqCI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914372; c=relaxed/simple;
	bh=sDDhumZ7pDaQZP4Vv3keDVFBeuoND2GQiVNJ3Njlv7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX9uYvMJnBQkYVpeiGYuaIwcuswAhXifo0zSsUfAaGWqgrB1jawFEbDEZs7xyNo/Or+/NfXHpHrWzrdI4qJEoGCg87dOYYOVfkCrW9+l7de12JyJ1LBTEHQQ9X27qU3yoxoExdk8EHHMB2D3ePvuJd6Y+WKgsIQbv63c7Bk9Vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+mxzDpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF61C4CEE7;
	Fri, 31 Oct 2025 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761914371;
	bh=sDDhumZ7pDaQZP4Vv3keDVFBeuoND2GQiVNJ3Njlv7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+mxzDpweUBpRT3I+RVb22M5bxT7GAicCl4XYe625kHCaWiyDjFzQvD2P1247F4iL
	 dCcv1t7MKm7ihLtSGtvQZGfq6Aasld5CD9gsgO7o6loqYaItmGiwF2kMzjZy0uZuu2
	 0dHUWEeuWZm2VSmRxlAmonT5zTIjsHfabIizH1dyOI2Ewqey5XhtODtf1+/G1OzgdQ
	 lsEEkOGXjWZqhJE0UQZ9oRJC20Tccz/uHrUcedevJ+EK33SGCFx5BNKeLox20LAKu/
	 yanTdVib3pTthR6K64WHofF7iHwrk1Uqm+ieOPKELxED/HSE9QMMpxlEJmuPY7EW6D
	 dYdFPPvZHmIAQ==
Date: Fri, 31 Oct 2025 13:39:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: bfoster@redhat.com, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] vfs-6.19.iomap commit 51311f045375 fixups
Message-ID: <20251031-gasflasche-degradieren-af75b5711388@brauner>
References: <20251028181133.1285219-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028181133.1285219-1-joannelkoong@gmail.com>

On Tue, Oct 28, 2025 at 11:11:31AM -0700, Joanne Koong wrote:
> These are two fixups for commit 51311f045375 ("iomap: track pending read
> bytes more optimally") in the vfs-6.19.iomap branch. It would be great
> if these could get folded into that original commit, if possible.

It's possible. However, your rename patch will mean that it'll cascade a
bunch of merge conflicts for following patches in your earlier series.
IOW, that can't be cleanly folded.

So really the race fix should go first and be folded into 51311f045375
and I think that can be done without causing a bunch of conflicts.

The rename patch can go on top of what's in vfs-6.19.iomap as that's
really not fixing a bug as in "breaks something" but a cleanup.

Let me know if that works.

> 
> The fix for the race was locally tested by running generic/051 in a loop on an
> xfs filesystem with 1k block size, as reported by Brian in [1].
> 
> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#t 
> 
> Changelog:
> v2 -> v3:
> Fix the race by adding a bias instead of returning from iomap_read_end() early.
> 
> v2: https://lore.kernel.org/linux-fsdevel/20251027181245.2657535-1-joannelkoong@gmail.com/
> v1: https://lore.kernel.org/linux-fsdevel/20251024215008.3844068-1-joannelkoong@gmail.com/#t
> 
> Joanne Koong (2):
>   iomap: rename bytes_pending/bytes_accounted to
>     bytes_submitted/bytes_not_submitted
>   iomap: fix race when reading in all bytes of a folio
> 
>  fs/iomap/buffered-io.c | 75 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 56 insertions(+), 19 deletions(-)
> 
> -- 
> 2.47.3
> 

