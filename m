Return-Path: <linux-fsdevel+bounces-23199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD1928981
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 15:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0AE1C21196
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3373314B973;
	Fri,  5 Jul 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ujpc489k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42913C8F9;
	Fri,  5 Jul 2024 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185876; cv=none; b=sTi9RZjYR1tRdc91ILtZo4U6zgm41O/1PWeYAbGQDOOtvi5aYR7/1eSteVC7jmpV8k2UDVryB8zoiA2rbxjJWyqGNV7jcm8Pm0sYzLzR47U0zqOVfzIJI4/fh6ykUCp+gJtW+zGg8Gzj6F2swYmKDEQdvRhGdKm8dzYUshHaAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185876; c=relaxed/simple;
	bh=j6OTkQpixN6EN4w4Np+abspGbdF/cicBV7CtNtP5MGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFB/KsEexwLtrlQY8Ecclg9coyxMMwu6NW1VpP4CpJkhJxF0grbNYhAWbXJ2AGrCDaXRhLCS3/7zPDe8voxPjdUTuU1+J0ZqNb+3hRbNXHGanbmqxcAGlvxV/KSEFgbdBPFPUyLSTq/DIQPYN032nMPi44j9YmeQVcejATwI4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ujpc489k; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WFvPN028Wz9t4r;
	Fri,  5 Jul 2024 15:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720185864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RI1x0wJ1+JJTcTJDJ2YPYh/0aofRmdFfu4awl092hi0=;
	b=ujpc489kYfI5CnIfvxBb+PVX93H2UwcqFo/dVZ0+jF/MDJqF1XaxxKsGD8BWyLb0BPjMLn
	FvwRySW+vd9W8jSoW4cOnd8qEU5Yp9xa7amLTb8sAhXfxXM9ZOJWraBLgjhStd9PzhC+Ej
	scDeEQRviHNvwIccuzMF/R9X0ep9yfdc0F8Oe9haOh6DrDYGSsK+8wh50sVSl7VtjjfaAP
	7K+rmK/Y3ANFUjZ6dkmZh21tYlObAQbH+q9BWVegwWy4ukxKKz4wnd4SHz5wsa7N19EKji
	FovQIf6lKk+VOLB+EPtbw9tOrfZMjm1eBKkJNYGBCdsyGPQomt9JR7rLCNs8Gg==
Date: Fri, 5 Jul 2024 13:24:18 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240705132418.gk7oeucdisat3sq5@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
 <Zoc2rCPC5thSIuoR@casper.infradead.org>
 <Zod3ZQizBL7MyWEA@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zod3ZQizBL7MyWEA@dread.disaster.area>
X-Rspamd-Queue-Id: 4WFvPN028Wz9t4r

> > I suggest you handle it better than this.  If the device is asking for a
> > blocksize > PMD_SIZE, you should fail to mount it.
> 
> That's my point: we already do that.
> 
> The largest block size we support is 64kB and that's way smaller
> than PMD_SIZE on all platforms and we always check for bs > ps 
> support at mount time when the filesystem bs > ps.
> 
> Hence we're never going to set the min value to anything unsupported
> unless someone makes a massive programming mistake. At which point,
> we want a *hard, immediate fail* so the developer notices their
> mistake immediately. All filesystems and block devices need to
> behave this way so the limits should be encoded as asserts in the
> function to trigger such behaviour.

I agree, this kind of bug will be encountered only during developement 
and not during actual production due to the limit we have fs block size
in XFS.

> 
> > If the device is
> > asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
> > not set, you should also decline to mount the filesystem.
> 
> What does CONFIG_TRANSPARENT_HUGEPAGE have to do with filesystems
> being able to use large folios?
> 
> If that's an actual dependency of using large folios, then we're at
> the point where the mm side of large folios needs to be divorced
> from CONFIG_TRANSPARENT_HUGEPAGE and always supported.
> Alternatively, CONFIG_TRANSPARENT_HUGEPAGE needs to selected by the
> block layer and also every filesystem that wants to support
> sector/blocks sizes larger than PAGE_SIZE.  IOWs, large folio
> support needs to *always* be enabled on systems that say
> CONFIG_BLOCK=y.

Why CONFIG_BLOCK? I think it is enough if it comes from the FS side
right? And for now, the only FS that needs that sort of bs > ps 
guarantee is XFS with this series. Other filesystems such as bcachefs 
that call mapping_set_large_folios() only enable it as an optimization
and it is not needed for the filesystem to function.

So this is my conclusion from the conversation:
- Add a dependency in Kconfig on THP for XFS until we fix the dependency
  of large folios on THP
- Add a BUILD_BUG_ON(XFS_MAX_BLOCKSIZE > MAX_PAGECACHE_ORDER)
- Add a WARN_ON_ONCE() and clamp the min and max value in
  mapping_set_folio_order_range() ?

Let me know what you all think @willy, @dave and @ryan.

--
Pankaj

