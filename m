Return-Path: <linux-fsdevel+bounces-53158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7FFAEB153
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 10:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A20C7B0660
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580924E4AF;
	Fri, 27 Jun 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2aC/CWCX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CmuK24lM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3023BD1B;
	Fri, 27 Jun 2025 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012864; cv=none; b=eUr2MHVUCP/fSmN6Luv1jgQwdv8eBR5E0jnl5bhOkuZAiwdGPHx0YF+tOgcCmRAAeERNYPYx6y3yRDqITHpb7En5PdNbTQrRvsYAqo/0siQAalP9wzeVLx+E3Attb9/4QfeemdVw409EYsbBymBpEgvo5CGn6MI2SXjE9YATbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012864; c=relaxed/simple;
	bh=YRUIoOzu1tATu4wgHlO+GjAHs+OYHRlReZgqQTEBN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dz9AipkcLEhrhuOikdTng06uNM8mTfLhmXusnf669EsN3BJmx5CWfscywyaSPgjuHAws4hn2Zs/gj9Mx7r+i5QQyqt2HQqDQasoo8BAdR9MNjpGkkO80yHsqcjeK1weUejRFS7iaIymZBqNE+iaR7HjLTQXtLyA29g2F19S/5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2aC/CWCX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CmuK24lM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 27 Jun 2025 10:27:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751012859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwOcZZs1ZIVtoa5esxxBWO/UwD8QHSKhv8lKZGDgSx0=;
	b=2aC/CWCXE3jx9ogAHfeVvi5askDWzS4IIKA+1ZfA5SSTxSLYBQ90m6Dy2nICwxv8qzRoGL
	rY6faDt9BJM+h83DTYHmU2Hh5lgLpbyej4lAKL3nKPN6lPO4+y6zJDpRWeq6XmAJNwvkhs
	lGslEcJtbzrxI1LQsXqONZI9p7AOL1ZwoFSh6tfVaanUB1UnrcbnUPincQuvsHUo9RBv01
	dwTADTWtGWwrTj2m21XatcwxDmi1F8SIRGrHmBmYpJLoGXdpFTy2m8yJ9XpPikUfOshPNg
	VZ3uW2mSn2xV8eSUmW9NhS/5YVQmsUXxwrqWyDgJIxA3l6WEGRs3rpHnniX1jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751012859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwOcZZs1ZIVtoa5esxxBWO/UwD8QHSKhv8lKZGDgSx0=;
	b=CmuK24lMiNHqVe9jMdhvIIcCp3aCMFD6MbSCB8x5brTssfB2wvfSQdz+md2aVmzdnSIPBf
	zKnT8k9vrlWiU0Ag==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Berg <benjamin@sipsolutions.net>, 
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 12/15] kunit: Introduce UAPI testing framework
Message-ID: <20250627100608-9eff2270-8f5b-49d4-9fe3-54a12a14dd25@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-12-48760534fef5@linutronix.de>
 <66deaafe1974c989e949975bafe3ab0b2ae3f5ff.camel@sipsolutions.net>
 <20250627060129-4fe09191-4714-4856-9de5-c8e5cf5ed0d6@linutronix.de>
 <8cfa715301c7c357c5d6c82fabd9b53d2fa01182.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cfa715301c7c357c5d6c82fabd9b53d2fa01182.camel@sipsolutions.net>

On Fri, Jun 27, 2025 at 08:58:11AM +0200, Benjamin Berg wrote:
> On Fri, 2025-06-27 at 06:20 +0200, Thomas Weiﬂschuh wrote:
> > On Thu, Jun 26, 2025 at 08:11:17PM +0200, Benjamin Berg wrote:
> > > I ran into two minor issues trying out the patches, see inline.
> > 
> > Thanks for testing the series.
> > 
> > > On Thu, 2025-06-26 at 08:10 +0200, Thomas Weiﬂschuh wrote:
> > > > Enable running UAPI tests as part of kunit.
> > > > The selftests are embedded into the kernel image and their output is
> > > > forwarded to kunit for unified reporting.
> > > > 
> > > > The implementation reuses parts of usermode drivers and usermode
> > > > helpers. However these frameworks are not used directly as they make it
> > > > impossible to retrieve a thread's exit code.
> > > > 
> > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > > 
> > > > [SNIP]
> > > > +/**
> > > > + * KUNIT_UAPI_EMBED_BLOB() - Embed another build artifact into the kernel
> > > > + * @_name: The name of symbol under which the artifact is embedded.
> > > > + * @_path: Path to the artifact on disk.
> > > > + *
> > > > + * Embeds a build artifact like a userspace executable into the kernel or current module.
> > > > + * The build artifact is read from disk and needs to be already built.
> > > > + */
> > > > +#define KUNIT_UAPI_EMBED_BLOB(_name, _path)					\
> > > > +	asm (									\
> > > > +	"	.pushsection .rodata, \"a\"				\n"	\
> > > > +	"	.global " __stringify(CONCATENATE(_name, _data)) "	\n"	\
> > > > +	__stringify(CONCATENATE(_name, _data)) ":			\n"	\
> > > > +	"	.incbin " __stringify(_path) "				\n"	\
> > > > +	"	.size " __stringify(CONCATENATE(_name, _data)) ", "		\
> > > > +			". - " __stringify(CONCATENATE(_name, _data)) "	\n"	\
> > > > +	"	.global " __stringify(CONCATENATE(_name, _end)) "	\n"	\
> > > > +	__stringify(CONCATENATE(_name, _end)) ":			\n"	\
> > > > +	"	.popsection						\n"	\
> > > > +	);									\
> > > > +										\
> > > > +	extern const char CONCATENATE(_name, _data)[];				\
> > > > +	extern const char CONCATENATE(_name, _end)[];				\
> > > > +										\
> > > > +	static const struct kunit_uapi_blob _name = {				\
> > > > +		.path	= _path,						\
> > > > +		.data	= CONCATENATE(_name, _data),				\
> > > > +		.end	= CONCATENATE(_name, _end),				\
> > > > +	}									\
> > > 
> > > For me, the compiler could not find the files for the ".incbin" unless
> > > I added an include path. i.e. adding
> > > † ccflags-y := -I$(obj)
> > > to lib/kunit/Makefile fixed the problem for me.
> > 
> > Can you share some more details on your build setup?
> > This worked for me as-is and also passed 0day build testing.
> 
> Funny, I ran this on a Fedora 41 with gcc --version saying
> gcc (GCC) 14.3.1 20250523 (Red Hat 14.3.1-1)
> 
> I tried both 32 and 64 bit builds for ARCH=um.
> 
> Attaching my current kernel configuration and the last few lines of a
> V=1 build.
> 
> The kernel I used is a bit newer than what you had. Applied on top of
> ee88bddf7f2f5d1f1da87dd7bedc734048b70e88 (bpf-fixes merge).

So this happens because you are building inside the source tree.
scripts/Makefile.lib has this block:

# $(src) for including checkin headers from generated source files
# $(obj) for including generated headers from checkin source files
ifdef building_out_of_srctree
_c_flags   += $(addprefix -I, $(src) $(obj))
_a_flags   += $(addprefix -I, $(src) $(obj))
_cpp_flags += $(addprefix -I, $(src) $(obj))
endif

Apparently GNU/clang assemblers don't look for .incbin/.include files next to
the including files [0].
In contrast, the ARM compiler does (at least according to its docs) [1].

Maybe we can work around this in the macro, but I assume this will become even
uglier. So for the next revision I'll use your proposal of explicit cflags.
Or if Masahiro prefers to have a more global and generic solution, we can do that.

[0] https://sourceware.org/binutils/docs/as/I.html
[1] https://developer.arm.com/documentation/dui0801/l/Directives-Reference/INCBIN


Thomas

