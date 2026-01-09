Return-Path: <linux-fsdevel+bounces-73041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B4D08C00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 11:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA2F7306E581
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656233A9E9;
	Fri,  9 Jan 2026 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uHxhgvNS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4KxN6mj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D032C027E;
	Fri,  9 Jan 2026 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956134; cv=none; b=AJALY9ZZj1NjS0fMrlZUZoN1QZADb8OStHluQZB8iEVpYDFj9xfLK6Zy8/YPnHmPDCvHl2EzcEHF5BL+cVTE4tP2l9n+56Ja8YRfLqDF8fB4O5BDzWqNz6aBgMqKK4M2IvnzX30+dQVLj2OAg5zp21kI8uS1aQvb62TbHmFup90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956134; c=relaxed/simple;
	bh=Ny69Cq3LUZvUP0PPdQwXG4tD4agXQPrriiWcBA4uNaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWP6dAfwCUfg34IT+9o8ebd+H8f3O25ldIW8qFeidk3qQZI3fpHa8ghAegGdoLQkqiU/TB7pRYHYhQk/TN5sBPPTLrXYmsj44LvcV0atbJGNgjeKIuQPT89dsS+zRA7X1t3imoNC2//bw+81ynpuOoLLZMYOleN4AZgO7ckT5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uHxhgvNS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4KxN6mj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 9 Jan 2026 11:55:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767956131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/vQuGm/08WfgVEE6J+fqbyMJkmUyVqSa/4H0/4xB80=;
	b=uHxhgvNSm3b2gHJ4DJJv5MDrNIiCyJArhjhCFXICVFYM0SjNWi8gwhQQ5RZGhye1emFfec
	neA9lBFGI7EFm74wZFBpIzzbeJqqR9BFDKTdh0opUTTjxd1bVXIiGdbx0T0lFCV24/CYl9
	69NXonB9M3zjZBKCsUkkOj6g3gLEGNOPSCIBg6rjqJy5eviLqlWOnjT5HiRde3TIERUX4l
	VTyBBN+rQwGVNNF6poYTni/y0eKFDdRbhw+T9MHkCxCqqI4V5JT0xXNWibKhxtSwhU9SFS
	wJZZSqY6uKdA/7JmL8LBbaraqzzZnn7K0+4nyhpCIV5OipBfRhoJhk8HdXBeVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767956131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/vQuGm/08WfgVEE6J+fqbyMJkmUyVqSa/4H0/4xB80=;
	b=v4KxN6mjX42+MVhtaG/RU9zvgH+7vqoDPNrY9jn/seXHR5lrWcawM81aftlIi+zCgBl5lL
	tfC/J5v7MomhNoAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
Message-ID: <20260109114918-1c5ea28d-f32d-49e5-affb-cc3c74c4dd5b@linutronix.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
 <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
 <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
 <2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
 <e22544a1-dea4-44d0-9a72-b60d38eeac19@bsbernd.com>
 <20260109085917-e316ce57-5e78-4827-96d7-4a48a68aa752@linutronix.de>
 <20260109103827.1dc704f2@pumpkin>
 <ccdbf9b8-68d1-4af6-9ed4-f2259d1cecb4@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccdbf9b8-68d1-4af6-9ed4-f2259d1cecb4@bsbernd.com>

On Fri, Jan 09, 2026 at 11:45:33AM +0100, Bernd Schubert wrote:
> 
> 
> On 1/9/26 11:38, David Laight wrote:
> > On Fri, 9 Jan 2026 09:11:28 +0100
> > Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> wrote:
> > 
> >> On Thu, Jan 08, 2026 at 11:12:29PM +0100, Bernd Schubert wrote:
> >>>
> >>>
> >>> On 1/5/26 13:09, Arnd Bergmann wrote:  
> >>>> On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:  
> > ...
> >>>> I don't think we'll find a solution that won't break somewhere,
> >>>> and using the kernel-internal types at least makes it consistent
> >>>> with the rest of the kernel headers.
> >>>>
> >>>> If we can rely on compiling with a modern compiler (any version of
> >>>> clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
> >>>> could be used for custom typedef:
> >>>>
> >>>> #ifdef __UINT64_TYPE__
> >>>> typedef __UINT64_TYPE__		fuse_u64;
> >>>> typedef __INT64_TYPE__		fuse_s64;
> >>>> typedef __UINT32_TYPE__		fuse_u32;
> >>>> typedef __INT32_TYPE__		fuse_s32;
> >>>> ...
> >>>> #else
> >>>> #include <stdint.h>
> >>>> typedef uint64_t		fuse_u64;
> >>>> typedef int64_t			fuse_s64;
> >>>> typedef uint32_t		fuse_u32;
> >>>> typedef int32_t			fuse_s32;
> >>>> ...
> >>>> #endif  
> >>>
> >>> I personally like this version.  
> >>
> >> Ack, I'll use this. Although I am not sure why uint64_t and __UINT64_TYPE__
> >> should be guaranteed to be identical.
> > 
> > Indeed, on 64bit the 64bit types could be 'long' or 'long long'.
> > You've still got the problem of the correct printf format specifier.
> > On 32bit the 32bit types could be 'int' or 'long'.
> > 
> > stdint.h 'solves' the printf issue with the (horrid) PRIu64 defines.
> > But I don't know how you find out what gcc's format checking uses.
> > So you might have to cast all the values to underlying C types in
> > order pass the printf format checks.
> > At which point you might as well have:
> > typedef unsigned int fuse_u32;
> > typedef unsigned long long fuse_u64;
> > _Static_assert(sizeof (fuse_u32) == 4 && sizeof (fuse_u64) == 8);
> > And then use %x and %llx in the format strings.

These changes to format strings are what we are trying to avoid.

> The test PR from Thomas succeeds in compilation and build testing. Which
> includes 32-bit cross compilation
> 
> https://github.com/libfuse/libfuse/pull/1417

Unforunately there might still be issues on configurations not tested by the CI
where the types between the compiler and libc won't match.
But if it works sufficiently for you, I'm fine with it.

Also with the proposal from Arnd there were format strings warnings when
building the kernel, so now I have this:

#if defined(__KERNEL__)
#include <linux/types.h>
typedef __u64		fuse_u64;
...

#elif defined(__UINT64_TYPE__)
typedef __UINT64_TYPE__		fuse_u64;
...

#else
#include <stdint.h>
typedef uint64_t		fuse_u64;
...
#endif  


Thomas

