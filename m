Return-Path: <linux-fsdevel+bounces-70626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9CDCA2945
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 07:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7F83027A57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C925A30FF2A;
	Thu,  4 Dec 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yrzQIRIm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EqX6JXCv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA87308F1E;
	Thu,  4 Dec 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764831509; cv=none; b=hxj1E9zCQ1zZAKEhtULNX8SzIF8+GnPGJzKtU1XllnpWsb5+3ai3IrUTPP2eJX7VpUfXkrNro66/ZVNL1vr7ONvkvhQd5UiLrRJwz1nV5e3wvxjUY/CweIW+CfG0WJdWMzvpLGOixnL9GpZSNvAqfkNTETCGgzFS82JV51ZKZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764831509; c=relaxed/simple;
	bh=mJzAy3jJVPEWY5k7z8rnjYSpd3CXSSkHBlXWbXNBHKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUlshHqOqPidgotJoHgco9qmJ/CdPX0gER61BdxLiHD5xi/+7Wqz3+viWBZ2fT9vSdYkAxyEfhMD+Q8UUZan/aJkwoo6nvNVHVrJ9JDRmNRRlH/nJ8Hdy0fjX9bGtzSnh0KDo1422X7+2l81rjYhjhQLQes55oiSinGPSx/bl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yrzQIRIm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EqX6JXCv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Dec 2025 07:58:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764831505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7daBY4NxQdcpTEkBUDsjzEoBWoHfTQcwn2Ul45rfP8=;
	b=yrzQIRImCVSjcDxrBWqB4zq41mFK9eWdai1GZaMgh1E8rq2kQ34SVumjT4Z1MFmhQnfdcE
	rHp7C73qmcxH/QIU/sI6g2SZmXamSF5MMMlcrNEHaXogpuVXEUrlk4s8I4fQhoQHwMCSpC
	SgoAzLT+TVvxog6ib4QeMmwlCk4LYQvEr8TSEffcDCq988GvFJauVHM48gNzKZ+zGdx0EU
	RfEn18tYsrTu41VeqYM7l3x5se7+F5nvl6WT2PyW+iOODsuwvRP/w+I0EIKyr+Eg+EeAwU
	PxVfAts1vxJ5BWzRmSGlveWpl7vDgBrCtuZkwWKe/zTyoZkzGYtt0auNDjv6eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764831505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7daBY4NxQdcpTEkBUDsjzEoBWoHfTQcwn2Ul45rfP8=;
	b=EqX6JXCvk8SXjhJldI+onkBWPk8mSrbbb+HmLibmSScuAj1bp9TFMIcn+HBe60YA+GNpi1
	227kijaCy7tU3JDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: use UAPI types for new struct delegation definition
Message-ID: <20251204075422-78bae8db-0be5-4053-b0b9-33fc4c7125ae@linutronix.de>
References: <20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de>
 <75186ab2-8fc8-4ac1-aebe-a616ba75388e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75186ab2-8fc8-4ac1-aebe-a616ba75388e@app.fastmail.com>

On Wed, Dec 03, 2025 at 03:14:31PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 3, 2025, at 14:57, Thomas Weiﬂschuh wrote:
> > Using libc types and headers from the UAPI headers is problematic as it
> > introduces a dependency on a full C toolchain.
> >
> > Use the fixed-width integer types provided by the UAPI headers instead.
> >
> > Fixes: 1602bad16d7d ("vfs: expose delegation support to userland")
> > Fixes: 4be9e04ebf75 ("vfs: add needed headers for new struct delegation 
> > definition")
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -4,11 +4,7 @@
> > 
> >  #include <asm/fcntl.h>
> >  #include <linux/openat2.h>
> > -#ifdef __KERNEL__
> >  #include <linux/types.h>
> > -#else
> > -#include <stdint.h>
> > -#endif
> 
> I think we have a couple more files that could use similar changes,
> but they tend to be at a larger scale:

To start, let's extend the UAPI header tests to detect such dependencies [0].
Then we can clean them up without new ones popping up.

> include/uapi/linux/fuse.h
> include/uapi/linux/idxd.h
> include/uapi/linux/ax25.h
> include/uapi/regulator/regulator.h

> include/uapi/xen/privcmd.h

I have no idea how that header is supposed to work at all, as it depends on
non-UAPI headers. It is also ignored in the UAPI header tests.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/commit/?h=b4/uapi-nostdinc


Thomas

