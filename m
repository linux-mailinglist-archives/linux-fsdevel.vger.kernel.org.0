Return-Path: <linux-fsdevel+bounces-46778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E36BA94B6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 05:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E0D189140F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3874257424;
	Mon, 21 Apr 2025 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKw6y3hr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F572571CC;
	Mon, 21 Apr 2025 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204994; cv=none; b=l93ag/xLSJQBQkG4/SQ/jseFL+/DjLcupLf/uPQkMQwN4xF8th50TFDsKS0SYHaJ2ej4Cm5kAGIzmAqMrXCbBGRbxJzWuUcB3CdUlQ8HqZKR2/HTSRL1Gqi3kfbMK+RHK2j0kIj2zDKB0kxDkrDsQEgrwcwGfnXQTVH/PZNKSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204994; c=relaxed/simple;
	bh=utlV7YV5L4zVTAuFRwKh50s3JF93WI0+AxKIZ+qDB0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3yluE9ppo/ytfww+STerTn7IqW+zGKOTlSTHGbdARldrl3KhOpzo9SrvWCNi5n0JcYJDDOrwN38OkjjLLONTP+MdHM7/IkSj0ADHyorWkMw863AzJf8uINSXr32xnNzQf1LUgys+CxiW08lxmLjZdnIuZTr6setaxJFD5TgGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKw6y3hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8C5C4CEE2;
	Mon, 21 Apr 2025 03:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745204993;
	bh=utlV7YV5L4zVTAuFRwKh50s3JF93WI0+AxKIZ+qDB0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKw6y3hrVj02EZe0H2U3x0U1HOqhtt62f9Euh3YcPKMcQW3D2ip0fMoj6AltHEqlk
	 8pxyxuUflGB4pxWmJibBGoz9T1ha/KEV6q9alpDtVfDH2jwfmXGje/2/UjeISWMAMa
	 hLiguzAYUhrwHzfgI6f5/f71WNX8FQGw/cWAk4ooBN+MZBml22F+aV1OtwK+fqNxwd
	 sdgUFmZ2DSVWf1ZIkHjF+e2vNAfm9k4j0eE/Em0scJtexJBec5MxSKWzU9f/abDBuO
	 szWVZAg6Qlpyzgflbu/f/sIunfw/B+JEeGkh2E1lcF+hiHmKLy3HbjmGXR3bjxp0NX
	 TvpiIpKPKcXtg==
Date: Sun, 20 Apr 2025 20:09:50 -0700
From: Kees Cook <kees@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] enumarated refcounts, for debugging refcount issues
Message-ID: <202504202008.533326EF4@keescook>
References: <20250420155918.749455-1-kent.overstreet@linux.dev>
 <202504201808.3064FFB55E@keescook>
 <yd3f6ie56x2dbagqycwluxtz7inrmbub5fg7omp226vrdvxtb2@sjn23uj3r6t7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yd3f6ie56x2dbagqycwluxtz7inrmbub5fg7omp226vrdvxtb2@sjn23uj3r6t7>

On Sun, Apr 20, 2025 at 09:27:26PM -0400, Kent Overstreet wrote:
> On Sun, Apr 20, 2025 at 06:08:41PM -0700, Kees Cook wrote:
> > On Sun, Apr 20, 2025 at 11:59:13AM -0400, Kent Overstreet wrote:
> > > Not sure we have a list for library code, but this might be of interest
> > > to anyone who's had to debug refcount issues on refs with lots of users
> > > (filesystem people), and I know the hardening folks deal with refcounts
> > > a lot.
> > 
> > Why not use refcount_t instead of atomic_t?
> 
> It's rather pointless here since percpu refcounts don't (and can't)
> support saturation, and atomic_long_t should always suffice - you'd have
> to be doing something particularly bizarre for it not to, since
> refcounts generally count things in memory.

Ah yes, my eyes skipped over the "long" part when I was reading the
patches. There's currently no sane reason to use refcount_t when
already using atomic_long_t. Sorry for the noise!

> Out of curiousity, has overflow of an atomic_long_t refcount ever been
> observed?

Not to my knowledge. :)

-- 
Kees Cook

