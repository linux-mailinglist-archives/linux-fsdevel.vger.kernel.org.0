Return-Path: <linux-fsdevel+bounces-71967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55520CD8753
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 09:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D37573011A7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4531ED67;
	Tue, 23 Dec 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zx76NCDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vy+1Rr/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D82E764B;
	Tue, 23 Dec 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479036; cv=none; b=VMcNlDQ36REgls/2TMvZfnHxga+BM9s4GHIBs6gwmJ0IsteelAJhvwBUE7jm/LAlS4oOS4jY1BY8PgaSEqMpIBMNw6mFBB5Z8GEG+lgKejUKszG+yWfeuHKIJ5rvbO3fVif/WWE4siMyouq5LrF3UsVJWaqTvmmGRQlI1v3JPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479036; c=relaxed/simple;
	bh=ibMCSA/zI6YtVmHX38O2NZAL61W6OCqSiA7uFb4z9wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNNgCsLxAd+CXFb+1c3M7C6+TnnPWvrSrxgHPF8VUVIm1q3J1/hzfgvc/JcFoxTSfXmYxrt/51S+cb87YCicymELveP8ZFbE3UcF6n4bsaUOjhZ6UCD2wlHOo8W4mvSYlNr2C4N6QDoobUb/yQub9ZuPOspu6vqT+4RvKx/W9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zx76NCDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vy+1Rr/r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Dec 2025 09:37:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766479026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pj5vPByX32eBF40sFg+fy1FB0cDDK+MaDXIzfvpLCA4=;
	b=Zx76NCDT5WBnyQLAqoyfA/OKduyYevWLcQeerpH7yVILN7vm+RC9LJfOOZvfNHvDtUfBVT
	83gn7xbWfLVEcmIURBgvDJRCn3zEPtJAkpOg0PvkTOxZjgyHLau2SCe0t2EOUUZ+U1P1K7
	RtOzt/fi4doob97RbDiphaMSfXUc7YU0f92JdbqgqUddMkyiKhGpsTqVCtrHYK8qDw5x1c
	nJC5ptn/P5XfBuVQBcxFw8g6mH1LTQL7S9R918gVCqTjQoVIo4LyUNGMm4fQ7lysdTsijQ
	KGqoTgm0XrmsK0KytIoB7tdcWeTanNuyHS4PDvi/G5XyEsXfBKBJvkDg9ztC6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766479026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pj5vPByX32eBF40sFg+fy1FB0cDDK+MaDXIzfvpLCA4=;
	b=vy+1Rr/r7SeBlV8D3oiq9awwhJbIx/F9YfCRadYewSI+yxP8j68tpRIeFs9WwWZxA4tB3I
	geBKkOloI5o9+DBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fuse: uapi: use UAPI types
Message-ID: <20251223092253-6c03d7f4-04c7-4272-a4e8-9e38f41f4dad@linutronix.de>
References: <20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de>
 <e320ea3d-dd4d-4deb-81fe-aea41f648e31@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e320ea3d-dd4d-4deb-81fe-aea41f648e31@bsbernd.com>

Hi Bernd,

On Mon, Dec 22, 2025 at 10:16:39PM +0100, Bernd Schubert wrote:
> On 12/22/25 09:06, Thomas Weiﬂschuh wrote:
> > Using libc types and headers from the UAPI headers is problematic as it
> > introduces a dependency on a full C toolchain.
> > 
> > Use the fixed-width integer types provided by the UAPI headers instead.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> I think that came up a couple of times already. 
> 
> https://lkml.org/lkml/2015/10/15/672
> 
> Also see
> https://git.zx2c4.com/linux-rng/commit/include/uapi/linux/fuse.h?id=4c82456eeb4da081dd63dc69e91aa6deabd29e03&follow=1

Thanks for these pointers.

Looking at the linked commit 4c82456eeb4d ("fuse: fix type definitions in
uapi header"), it seems you were fine with custom typedefs/defines for
non-Linux targets. But the way it was done previously was problematic for
cross-compilation.

What about the following aproach:

#if defined(__KERNEL__)
#include <linux/types.h>
#elif defined(__linux__)
#include <linux/types.h>
#else
#include <stdint.h>
typedef uint32_t __u32;
...
#endif

(borrowed from include/uapi/drm/drm.h, the identical #if/#elif branches are
necessary for unifdef.

This works correctly when (cross-)compiling the kernel itself. It also uses
the standard UAPI types when used from Linux userspace and also works on
non-Linux userspace. And the header can still be copied into libfuse as is.


Thomas

