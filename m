Return-Path: <linux-fsdevel+bounces-15444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB6D88E870
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6832A76E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D329713280D;
	Wed, 27 Mar 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3XRX+do"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED2132482;
	Wed, 27 Mar 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551806; cv=none; b=WhMg5bB5zi1OLwqHXpNZ3Y1bLE1nYiDXsgJmqQ/p7qr6e9qryftvv8YXV3XCJFsB1Jqq7ViLStBFv4GXZ/C5AaebLVBF6EOARgd6TYRqzgg4xnkGK5lxMv03XxLIJXYkIztRXLEkBnw7OMQf5TEe2tv4gYmt80nXbHOfAkrFq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551806; c=relaxed/simple;
	bh=7eEcZmvTzb8VSbNdQfoe1CbrQJGiq8lc7tQjpI5gzrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1IR5m2922QycAV92PfWtzSXU8Sa087KUrbXHjj8p8kYf3dknnAsvcAcID5Qvx+N180+qgrK7NaOjuBPjMGuUk85HwkEwHEfhWfohs7oSVe394+z7V7GSxGfXdBP5P5FipEYxENGVFymRrhp1TUb6FVCuhSAvwgYB/V0E45yQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3XRX+do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2115C433F1;
	Wed, 27 Mar 2024 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711551804;
	bh=7eEcZmvTzb8VSbNdQfoe1CbrQJGiq8lc7tQjpI5gzrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3XRX+dorHzwJYR0nkw+/2S37Z3avXPbnL3l4xeBZaO1cOokPn4Sn8Hl3ZgYqaHK4
	 0kubFaY2NZBNaaFz+7fdRscWPnZxRPDlZVhYImbvdRTPeKaN4OyaH/sOSgLmtAlYUt
	 Py3S4E8DHYrdpnkfbALpT6mXIVFFYENSMqZFE0nVREpzuBagIQiXz1haBQlKTeyGMO
	 Mfmoclvn7X/CefsCt75iA8cIawPUlLgToUoGLqqiCWhn5GdaVUMHMMRhSW1z+TYvQM
	 Zpuu3oMbg25Sp08D4ejJN4eErkxISgRYvHfEgaYTvQunVgbodg7kui6XhwXKZ/DNsl
	 sUZGhIwYQm2GQ==
Date: Wed, 27 Mar 2024 17:02:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 2/3] mm/treewide: rename CONFIG_HAVE_FAST_GUP to
 CONFIG_HAVE_GUP_FAST
Message-ID: <ZgQ1Dh2KZ3JvevX_@kernel.org>
References: <20240327130538.680256-1-david@redhat.com>
 <20240327130538.680256-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327130538.680256-3-david@redhat.com>

On Wed, Mar 27, 2024 at 02:05:37PM +0100, David Hildenbrand wrote:
> Nowadays, we call it "GUP-fast", the external interface includes
> functions like "get_user_pages_fast()", and we renamed all internal
> functions to reflect that as well.
> 
> Let's make the config option reflect that.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arm/Kconfig       | 2 +-
>  arch/arm64/Kconfig     | 2 +-
>  arch/loongarch/Kconfig | 2 +-
>  arch/mips/Kconfig      | 2 +-
>  arch/powerpc/Kconfig   | 2 +-
>  arch/s390/Kconfig      | 2 +-
>  arch/sh/Kconfig        | 2 +-
>  arch/x86/Kconfig       | 2 +-
>  include/linux/rmap.h   | 8 ++++----
>  kernel/events/core.c   | 4 ++--
>  mm/Kconfig             | 2 +-
>  mm/gup.c               | 6 +++---
>  mm/internal.h          | 2 +-
>  13 files changed, 19 insertions(+), 19 deletions(-)
> 

