Return-Path: <linux-fsdevel+bounces-56651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75CAB1A56C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3BB18A2A87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D14021858A;
	Mon,  4 Aug 2025 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgvZoSlj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEgz/aYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92342C190;
	Mon,  4 Aug 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319699; cv=none; b=g1Epdk8Tb/bxRPAuip+00QGNtL98n9ULl8pKu5c6k5F8PyzxOjedkYVlCykPomsWzIhxkNBNqZ4qGhAMbT7D3aHaFd9CSk4QRiScOl+lnOCU6DcyQT2TsKT/9G9k9hBmmc4Xyu/kVp2CQ2JzDgBh47UC29Q6bzABj+YnRrjbz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319699; c=relaxed/simple;
	bh=FwobIH4OyPCkUNduXkRWqzeDMqJVa1hQQJWmjZl8DeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjfGcBE5YVZGQchjG9CmWVajhfYvsRN+VLv4GKwUEGK4tIGgZw957XXPBtl9qkViM4VdwetAhAoDWha5eC+aCeB9OJCWU2MkjvPISmUgq53ZgTxJcBJhVna3XJsCOwObSgpaXjPSE/z+wp0rGcgLj4wB3UjzzoO7sozdPlqOAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xgvZoSlj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEgz/aYI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 4 Aug 2025 17:01:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754319695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42vIk650U5Nu4ZZGP8OXuh4SGlMpsh3LVOR0xRo5c+A=;
	b=xgvZoSljK55eUZl49pOIFNnrdHdyhB+EguZ3VtXjLlw1qYheHhyjn1dh+JM/CN0bP0mFZ/
	tdTck748/5t0loLo7k3SOaQZq70ELh0QkFrVKXS9c26CQJCq0hx5AfknyV1PuI/aMXoxnK
	3M2q9amGHrJB88UYc6FayJkazQiw7Zg9Jsn1BPY6MaCeTAdHxlzHh7KaQuZXxSCQnovSbx
	+lwggG/J8XUl+sXnLhFX95K+3jDt6ym8zMY5Jz/qtkY2igFNCJ6jHt5rTEEjIphF0an7WZ
	RHHxF8hSznbmiJep7jI2q5bXttGLltUikhYX0OKrqmgEV9SyNyEMZ58PEMorsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754319695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42vIk650U5Nu4ZZGP8OXuh4SGlMpsh3LVOR0xRo5c+A=;
	b=UEgz/aYIXbU4AIWY7sRvA+X1Ixnt/rZ/UgnAHLyq1fS1UakxkmQZwtnfaPZS/Pv/yaQIJ3
	sOxqBD62VUPvTODg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christoph Hellwig <hch@lst.de>, Shuah Khan <shuah@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/15] kunit: Introduce UAPI testing framework
Message-ID: <20250721100913-0c6d93d8-79d6-482b-9db4-7b0c06b604fa@linutronix.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
 <20250717132259.GA25835@lst.de>
 <20250718073743-d4a1f713-f81b-4e89-b3f8-7eed838798e6@linutronix.de>
 <20250721070958.GA29367@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721070958.GA29367@lst.de>

Hi Christoph,

On Mon, Jul 21, 2025 at 09:09:58AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 18, 2025 at 08:22:26AM +0200, Thomas Weißschuh wrote:
> > > I had my own fair share of problems with kselftests,
> > > mostly because of the lack of structure and automated way to run them,
> > 
> > How did you overcome these issues? Why does everbody need to reinvent the
> > wheel here?
> 
> Told people to use everything remotely file system related to use
> xfstests instead, and either ignore or suffer from the rest.

Suffering from the rest is what I am trying to avoid.
(More on that below)

> > KUnit already exists and provides a lot of structure and tooling.
> 
> That's great.  Let's reuse it without having to drive running userspace
> programs from kernel code.

Running in the kernel is the point behind KUnit. It could be done by putting
all the userspace test into a initramfs and run them on boot from there.
But that has other drawbacks:
* The tests can't be run on an existing system.
* All tests need to be loaded into memory together, and not on demand.
* The tests can not be rerun.

> > > but adding them to the kernel (or a module) is overshooting the target
> > > by far.
> > 
> > That's a subjective statement without any reasoning I can engange with.
> 
> Well, then we're done here if you can't engage.

This was a response to one specific statement. Could you be a bit more specific
in your critique? I am not sure what exactly you mean in some cases, making it
hard to respond properly. For example "bloat", it is bloaty
* source code,
* object code for users enabling the new kconfig options,
* object code for other users *not* enabling the new kconfig options?
 
> > I would be happy to do so, but for now I can only say that I disagree.
> > The patches have been on the testing-related lists for
> > some time and so far nobody had an issue with this aspect.
> 
> Has anyone actually chimed in and said "it's great that we bloat the
> kernel to run userspace tests", or have people just mostly ignored it
> like most things?

That specific wording wasn't used. Obviously...
So far nobody had any issues with the overall goal of the series.
There was criticism around implementation details and I have been and will be
working on resolving those.

Some feedback I got:

David [0]: "I've taken quite a liking to it: it'd definitely have made my
life easier more than once."
Benjamin is already playing with it, having built his own testcase [1].
I asked Shuah about it before starting development and she gave a go-ahead.
A collegue of mine is also using it to validate the PREEMPT_RT safety of
various UAPIs by combining KUnit UAPI with a runtime validator [2].

> > > > If the kernel toolchain is not fit to
> > > > produce userspace because of a missing libc, the kernel's own nolibc can
> > > > be used instead.
> > > 
> > > Is nolibc enough to run all the selftests?
> > 
> > It is not and most probably won't ever be. The maintainers of each testcase
> > will decide which libc to use. Like it is in tools/testing/selftests/ today.
> > Some use glibc, some nolibc and some can do both.
> 
> So why do you want to use it here?  And how is is related to the rest
> of the series?

To make it easier to test a wide range of architectures by not requiring a
libc from the toolchain. It also avoids relying on a bunch of out-of-tree
code (glibc) as part of the test. And there are existing kselftests which
use it over glibc for their own reasons.

But using nolibc in test code is not necessary and nobody is forced to do so.

(Maybe a disclaimer that I'm one of the nolibc maintainers is in order)

(...)

> You present running pure userspace tests as the solution to a problem
> you don't even explain, or rather just state very highlevel.

To run kselftests we need the following things:
a) A toolchain which can build userspace executables.
b) Quite a bit of supporting userland, at least glibc, coreutils and bash.
c) A rootfs assembled out of these.
d) An efficient way to incrementally rebuild the test executables and rootfs.
e) A way to put that rootfs into the system under test.
f) A way to configure a kernel which
   * is as small as possible and as fast as possible to build,
   * can run on QEMU or a real machine,
   * can run the functionality under test.
g) A way to select the tests to run in the system under test.
h) A way to communicate back the results.
i) Something to interpret the results.
j) Hook up everything into a CI system.

And for all of this there should be good in-tree tooling.

For a) and b) I am not aware of any toolchain provider or distribution which
provides this for all necessary architectures. And the existing userspace test
frameworks don't even try to address the points a) to e)/f) and let the user
figure it out. This is the case for xfstests and LTP. virtme(-ng) provide most
of it but don't support cross-architecture setups. On the other hand the tree
already contains solutions for most of those points. a) and d) are solved by
kbuild userprogs, e) to j) by KUnit and my new framework plugs b) and c).
Moving to a pure userspace solution would preclude the usage of KUnit as far as
I can see.

This all started when I worked on the generic vDSO data storage patches [3].
I needed to run the existing vDSO selftests against a bunch of architectures,
including some esoteric ones [4]. With my framework, running the vDSO selftests
for any architecture is now trivial and blazingly fast.

Does this make more sense?

> Yes, kselftests suck as most people will agree. But the answer is not
> to add a lot of kernel bloat to treat userspace integration tests
> like kernel units tests.

I fail to understand how this test code is worse than the existing KUnit test
code. This is not meant to test complex scenarios, but single system calls or
specific UAPIs, which may depend on architecture features. For example timers,
signals, vDSO, mm etc.

> How about you just fix kselftests, preferably
> by reusing well known and teststed userland code?

Is "well known and tested userland code" referring to glibc or testing
frameworks? As mentioned above, glibc can be used just fine and the frameworks
I know about are lacking.


Thomas


[0] https://lore.kernel.org/all/CABVgOSn+530YJ3OPNJQncLDQNbd9JEDtZ04Amyyxk57jOVYUyQ@mail.gmail.com/
[1] https://lore.kernel.org/all/20250626195714.2123694-3-benjamin@sipsolutions.net/
[2] https://lore.kernel.org/lkml/cover.1752088709.git.namcao@linutronix.de/
[3] https://lore.kernel.org/lkml/20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de/
[4] https://lore.kernel.org/lkml/20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de/

