Return-Path: <linux-fsdevel+bounces-53134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC18EAEADC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 06:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E10565B30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 04:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CFD1DC9B5;
	Fri, 27 Jun 2025 04:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="01tfxppe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Vj0yGzk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D871D5CD1;
	Fri, 27 Jun 2025 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750998011; cv=none; b=mR3cFzOXc+22HHQdAgQkRsR4RFvkVquVVd0UbE4KLP/kPcrG4Qo4pUOjuNpulV57lSlA0tRfWOHK/CJjW6Ej08YG8UpDwjUvGkKCc+lrmp1P4gocIdDAdGmJlMH6ieXSHh3P0wrrenABHLOihaqGkqY0AOMe/XT9r7PNVe0NOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750998011; c=relaxed/simple;
	bh=X2RNTFBcE5pFgCTIGNIa+ZUV72ZQZno5e4FS+xPjWBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzoPAHVA25rZUMQZ6QUzPrfWYudrOkycDv9cIyNad1hTkbQw7l/HgOPzy/msI5ZIaZmQXR6MSa2/Azkvb+sHN7GyvqWAzGrH9XZXC/A3K+/T/5SaQ4vboPPgY+11Qvf04mGloMRNBFCHxYfY8NlX00+rUZ9507noes8mQxauvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=01tfxppe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Vj0yGzk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 27 Jun 2025 06:20:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750998007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwUcgevfKNTLblfy7PqHrCF2Fjb7b409d5rtxcTmjxU=;
	b=01tfxppe/vlWzhIQ9PBxgV4F7dFyiqCfNqdmOrgfYRi3Eu9iVCocPyE2tu5gd8tJvdOHBV
	8a9Z9bE9Grw/PCRriaOyl76ic2oJvB+7M2YA8sqQFMrlsPgq+BawvIaKqcRoKsgp1xpd3w
	mwlkznL3U08XYX2GdoHm0I4DqjJCvD0J7ahQBRVtY93JXICdDUImzPRN72f2m7/kEmNuCE
	hDPzsXa19VpFlwjaK/3ytWGUwN3+GsLBv5jcxnMclIDjOSlEd4pC/9ZNPVw9H7QGO/OGe5
	rCUD/e0r/+wzohDK7LvRe82yL4sW/DMfchqF2vFm0MG9tHve62PKy5MpCTjnwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750998007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GwUcgevfKNTLblfy7PqHrCF2Fjb7b409d5rtxcTmjxU=;
	b=+Vj0yGzknQek4tIHi46J5NKXSB8IWruQaSEQ7axtDLPVKaotRa8p+q9w35/H/QrourZMgR
	e72p5m+NNkUs6eAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 12/15] kunit: Introduce UAPI testing framework
Message-ID: <20250627060129-4fe09191-4714-4856-9de5-c8e5cf5ed0d6@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-12-48760534fef5@linutronix.de>
 <66deaafe1974c989e949975bafe3ab0b2ae3f5ff.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66deaafe1974c989e949975bafe3ab0b2ae3f5ff.camel@sipsolutions.net>

Hi Benjamin,

On Thu, Jun 26, 2025 at 08:11:17PM +0200, Benjamin Berg wrote:
> I ran into two minor issues trying out the patches, see inline.

Thanks for testing the series.

> On Thu, 2025-06-26 at 08:10 +0200, Thomas Weiﬂschuh wrote:
> > Enable running UAPI tests as part of kunit.
> > The selftests are embedded into the kernel image and their output is
> > forwarded to kunit for unified reporting.
> > 
> > The implementation reuses parts of usermode drivers and usermode
> > helpers. However these frameworks are not used directly as they make it
> > impossible to retrieve a thread's exit code.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > [SNIP]
> > +/**
> > + * KUNIT_UAPI_EMBED_BLOB() - Embed another build artifact into the kernel
> > + * @_name: The name of symbol under which the artifact is embedded.
> > + * @_path: Path to the artifact on disk.
> > + *
> > + * Embeds a build artifact like a userspace executable into the kernel or current module.
> > + * The build artifact is read from disk and needs to be already built.
> > + */
> > +#define KUNIT_UAPI_EMBED_BLOB(_name, _path)					\
> > +	asm (									\
> > +	"	.pushsection .rodata, \"a\"				\n"	\
> > +	"	.global " __stringify(CONCATENATE(_name, _data)) "	\n"	\
> > +	__stringify(CONCATENATE(_name, _data)) ":			\n"	\
> > +	"	.incbin " __stringify(_path) "				\n"	\
> > +	"	.size " __stringify(CONCATENATE(_name, _data)) ", "		\
> > +			". - " __stringify(CONCATENATE(_name, _data)) "	\n"	\
> > +	"	.global " __stringify(CONCATENATE(_name, _end)) "	\n"	\
> > +	__stringify(CONCATENATE(_name, _end)) ":			\n"	\
> > +	"	.popsection						\n"	\
> > +	);									\
> > +										\
> > +	extern const char CONCATENATE(_name, _data)[];				\
> > +	extern const char CONCATENATE(_name, _end)[];				\
> > +										\
> > +	static const struct kunit_uapi_blob _name = {				\
> > +		.path	= _path,						\
> > +		.data	= CONCATENATE(_name, _data),				\
> > +		.end	= CONCATENATE(_name, _end),				\
> > +	}									\
> 
> For me, the compiler could not find the files for the ".incbin" unless
> I added an include path. i.e. adding
>   ccflags-y := -I$(obj)
> to lib/kunit/Makefile fixed the problem for me.

Can you share some more details on your build setup?
This worked for me as-is and also passed 0day build testing.

> > [SNIP]
> > +static int kunit_uapi_run_executable_in_mount(struct kunit *test, const char *executable,
> > +						†† struct vfsmount *mnt)
> > +{
> > +	struct kunit_uapi_user_mode_thread_ctx ctx = {
> > +		.setup_done	= COMPLETION_INITIALIZER_ONSTACK(ctx.setup_done),
> > +		.executable	= executable,
> > +		.pwd		= {
> > +			.mnt	= mnt,
> > +			.dentry	= mnt->mnt_root,
> > +		},
> > +	};
> > +	int forward_err, wait_err, ret;
> 
> ret needs to be initialized to zero here as the kernel_wait function
> will only set "ret" if wo.wo_stat is non-zero.

Ack.

> > [SNIP]


Thomas

