Return-Path: <linux-fsdevel+bounces-57499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD985B2238A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B833A605C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3552EAB78;
	Tue, 12 Aug 2025 09:41:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9422EA74B;
	Tue, 12 Aug 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991676; cv=none; b=oJlYrZESlelcWQ0jKBhIWq9hrA1OmTm/Z/ntc3D3kSlbUsPLc62kbWj94liLrdKfxdcx7fwXfebY1s/NGyYKaRM1llNDK9TjxMX8b30B5QYzouWBCn/iqjsBvh1AVxQstWszFA7eOLmDwfDWtiwcK8oVqlkokMiG352prPOkZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991676; c=relaxed/simple;
	bh=nZrtRwq7jI63cTMZsCTitO8VDthmYTcuRU7KOnqfPnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdEosusUf2XTejDse0nbY7j1bWKIl004FCyPyScgRj7JqBx2QaRtkIMsa3FwMMLmuWEYwTCga93hUzbAFgpMpgaKueZm5QAj9LfC9bi3fmRb6PHLFawOFbDhVBumQajfMkjgZydBvMc49DLki4BXvcrxZ2emQCEBR+QqK7WHU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8E6B68AA6; Tue, 12 Aug 2025 11:41:07 +0200 (CEST)
Date: Tue, 12 Aug 2025 11:41:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Shuah Khan <shuah@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/15] kunit: Introduce UAPI testing framework
Message-ID: <20250812094107.GA27450@lst.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de> <20250717132259.GA25835@lst.de> <20250718073743-d4a1f713-f81b-4e89-b3f8-7eed838798e6@linutronix.de> <20250721070958.GA29367@lst.de> <20250721100913-0c6d93d8-79d6-482b-9db4-7b0c06b604fa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721100913-0c6d93d8-79d6-482b-9db4-7b0c06b604fa@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 04, 2025 at 05:01:35PM +0200, Thomas Weißschuh wrote:
> > That's great.  Let's reuse it without having to drive running userspace
> > programs from kernel code.
> 
> Running in the kernel is the point behind KUnit.

When using kunit as is to unit test kernel functionality - obviously.

When running it to integration test the syscall boundary - not at all.

> It could be done by putting
> all the userspace test into a initramfs and run them on boot from there.
> But that has other drawbacks:
> * The tests can't be run on an existing system.
> * All tests need to be loaded into memory together, and not on demand.
> * The tests can not be rerun.

None of that is true.  While running syscall level tests from an
initramfs could be a nice feature for an automatd kernel CI system,
nothin in this tests should require running from an initramfs.

> This was a response to one specific statement. Could you be a bit more specific
> in your critique? I am not sure what exactly you mean in some cases, making it
> hard to respond properly. For example "bloat", it is bloaty
> * source code,
> * object code for users enabling the new kconfig options,
> * object code for other users *not* enabling the new kconfig options?

You are adding kernel code both at the source and object level to run
userspace tests.  That is very clearly bloat.  Even more so as it adds
functionality and exports that don't fit in with what the kernel already
does for actual kernel functionality.

> > > It is not and most probably won't ever be. The maintainers of each testcase
> > > will decide which libc to use. Like it is in tools/testing/selftests/ today.
> > > Some use glibc, some nolibc and some can do both.
> > 
> > So why do you want to use it here?  And how is is related to the rest
> > of the series?
> 
> To make it easier to test a wide range of architectures by not requiring a
> libc from the toolchain. It also avoids relying on a bunch of out-of-tree
> code (glibc) as part of the test. And there are existing kselftests which
> use it over glibc for their own reasons.
> 
> But using nolibc in test code is not necessary and nobody is forced to do so.
> 
> (Maybe a disclaimer that I'm one of the nolibc maintainers is in order)

Well, why do you even mix it up with this unrelated series then?

> To run kselftests we need the following things:
> a) A toolchain which can build userspace executables.

You'll need that for any userspace program, no matter what test
harness.

> b) Quite a bit of supporting userland, at least glibc, coreutils and bash.

Well, a libc you will need anyway.  Maybe nolibc is good enough for
some tests, but as you already stated not for very many.  The others
are just an artifcat of how you run tests.

> c) A rootfs assembled out of these.
> d) An efficient way to incrementally rebuild the test executables and rootfs.
> e) A way to put that rootfs into the system under test.

You don't need a rootfs.

> And for all of this there should be good in-tree tooling.

Absolutely.

> Moving to a pure userspace solution would preclude the usage of KUnit as far as
> I can see.

You've still failed why using kunit is the goal and not just something
that made your life easier archieving your goal.

> > Yes, kselftests suck as most people will agree. But the answer is not
> > to add a lot of kernel bloat to treat userspace integration tests
> > like kernel units tests.
> 
> I fail to understand how this test code is worse than the existing KUnit test
> code. This is not meant to test complex scenarios, but single system calls or
> specific UAPIs, which may depend on architecture features. For example timers,
> signals, vDSO, mm etc.

So now having another half-assed test framework is a good thing?

> > How about you just fix kselftests, preferably
> > by reusing well known and teststed userland code?
> 
> Is "well known and tested userland code" referring to glibc or testing
> frameworks? As mentioned above, glibc can be used just fine and the frameworks
> I know about are lacking.

Basically any kind of testing framework that has broad use.  It's not
like there aren't userland unit test frameworks if you really want to
use that.

