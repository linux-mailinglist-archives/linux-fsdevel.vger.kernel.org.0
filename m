Return-Path: <linux-fsdevel+bounces-55400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC4B09B47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 08:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0D24E1D7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 06:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5191F8EFF;
	Fri, 18 Jul 2025 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pgW4XT1V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="26bpvT2r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5041C861E;
	Fri, 18 Jul 2025 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752819755; cv=none; b=TEYlTWNw/MSndhzyqyFLx3OspW4DaW0wZI7b6NIbOPx9n9U85GnUvg800nZuNSSNeG+s9bJ8KFXCbVC4yR59cafXe4+2aMCp5JuJT6eYqXIj12GsyiIPnFW+oRTTdKzjb5gGxVkkFQmAql7omjP2+5fjaRY8XkHMKiQ9gUBsx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752819755; c=relaxed/simple;
	bh=ICoPDyL2R75Iu7QQ1/kG+OuXPgtdLyK2qH53nhmr100=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+aLMJSEDfoE0g66/IkrwI7h2EJ3jBkoH4BfbwKVlv/CqejLAGtsVKsL4kQKYUJmkOihXg6CH655E2e1Paao+8a9b2Qs7dqvQD4/vFxraalyLoPPPE4q68+wF32NK7PAJgJNunkG6U3FFy+JnKscYrDlBXYSeZzX62evraFC8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pgW4XT1V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=26bpvT2r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 08:22:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752819750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r15MXxvdvuJjkg2dcxT5OmMbq5ijcwE+26Y6C9Smhh8=;
	b=pgW4XT1VmFV5nWy0E58ydruyYpt1gnI1VRPiYxoBNM5pJxEII+vO0ZJSLj31AAOU1a0V4X
	hC2kuGioG9WquczLzyVQ34xvvyXs3bZX4pyvei4WuKKFlqjb6F5MhZiAQrBxJ3iEm+rjzR
	E2dpnPABOqx7JndQXnwJPDbRJxDedZD7dUjeEJh3/ipMh/jjvHA/xsg8PWyBEmgntKsrQH
	LIwRN1hsH27w4Qyz5OkkWzPxepT0Df3WbRpAVMNLvzJWeGyiEaGCdKfUvctio5K2p/w1lF
	5Lv7lQTkeYARXuEWZ7ytGwdxzHbG8nYF/X73l3B1wu2SljbX7Dwt8WFmW0m8Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752819750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r15MXxvdvuJjkg2dcxT5OmMbq5ijcwE+26Y6C9Smhh8=;
	b=26bpvT2r5Gg6wqblcqwvNsj8QyQRBJSt2YcdRWznzsotPK6Oh5ANbFa38/u4eDdO80CSXT
	9372IrTxpC1ydzAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Luis Chamberlain <mcgrof@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/15] kunit: Introduce UAPI testing framework
Message-ID: <20250718073743-d4a1f713-f81b-4e89-b3f8-7eed838798e6@linutronix.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
 <20250717132259.GA25835@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717132259.GA25835@lst.de>

On Thu, Jul 17, 2025 at 03:23:00PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 17, 2025 at 10:48:02AM +0200, Thomas Weißschuh wrote:

(...)

> > This series aims to combine kselftests and kunit, avoiding both their
> > limitations. It works by compiling the userspace kselftests as part of
> > the regular kernel build, embedding them into the kunit kernel or module
> > and executing them from there.

(...)

> I had my own fair share of problems with kselftests,
> mostly because of the lack of structure and automated way to run them,

How did you overcome these issues? Why does everbody need to reinvent the
wheel here? KUnit already exists and provides a lot of structure and tooling.

> but adding them to the kernel (or a module) is overshooting the target
> by far.

That's a subjective statement without any reasoning I can engange with.
I would be happy to do so, but for now I can only say that I disagree.
The patches have been on the testing-related lists for
some time and so far nobody had an issue with this aspect.

> > If the kernel toolchain is not fit to
> > produce userspace because of a missing libc, the kernel's own nolibc can
> > be used instead.
> 
> Is nolibc enough to run all the selftests?

It is not and most probably won't ever be. The maintainers of each testcase
will decide which libc to use. Like it is in tools/testing/selftests/ today.
Some use glibc, some nolibc and some can do both.

> If so we should just do it unconditionally, but linking to different
> libraries by availability seems a bit problematic.

Agreed. But as mentioned above it will be the maintainers decision.

Only the preinit executable will need to support all configurations so needs
the availability check. For the framework selftest it also makes sense to
support as many configurations as possible. For the example test, any
configuration is fine. 

(...)

While having this discussion, can we also work on dealing with the symbol
exports, as discussed before?


Thomas

