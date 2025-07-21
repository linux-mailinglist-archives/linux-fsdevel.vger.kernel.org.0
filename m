Return-Path: <linux-fsdevel+bounces-55556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B8EB0BD3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD493BB341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 07:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF0E2820BA;
	Mon, 21 Jul 2025 07:10:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0C3BB48;
	Mon, 21 Jul 2025 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081806; cv=none; b=WG4vtaXcBMDYbgo/oioCMiLk8+499+CxhAyxuIT2VgfZjWi3vxY10K7C9XvJ3TrdZQT/A/huDRAkGDTAfLhhyPaJrCyI0ndUNg4yjcOpq2hKtlApSg9/WDBoLTuVBHVfZnzESlenK+F0soT2AM3vEzzicCicl3hW5zIxuvkjf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081806; c=relaxed/simple;
	bh=YbRazSO+bR8Uqt1x97vsHYhhB3rrxVcwiGJqpGBRc8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neNkhbKBkgKFmuBzjcMr56KE5qr8ay5cZ60/R7Fp/cmzNptvy1bQ8FFp5FjuHeUrxPAiGAf9E4CCJ5RU/WY42UORcqSXxzfRQnRIowtPutSTtwS08BxIjYidOBT3qpuMcOXB+AORuTobt3FuU4MmB7BpbiktuCJRzIY5+/FZmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C0F0168B05; Mon, 21 Jul 2025 09:09:58 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:09:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20250721070958.GA29367@lst.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de> <20250717132259.GA25835@lst.de> <20250718073743-d4a1f713-f81b-4e89-b3f8-7eed838798e6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718073743-d4a1f713-f81b-4e89-b3f8-7eed838798e6@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 18, 2025 at 08:22:26AM +0200, Thomas Weißschuh wrote:
> > I had my own fair share of problems with kselftests,
> > mostly because of the lack of structure and automated way to run them,
> 
> How did you overcome these issues? Why does everbody need to reinvent the
> wheel here?

Told people to use everything remotely file system related to use
xfstests instead, and either ignore or suffer from the rest.

> KUnit already exists and provides a lot of structure and tooling.

That's great.  Let's reuse it without having to drive running userspace
programs from kernel code.

> > but adding them to the kernel (or a module) is overshooting the target
> > by far.
> 
> That's a subjective statement without any reasoning I can engange with.

Well, then we're done here if you can't engage.

> I would be happy to do so, but for now I can only say that I disagree.
> The patches have been on the testing-related lists for
> some time and so far nobody had an issue with this aspect.

Has anyone actually chimed in and said "it's great that we bloat the
kernel to run userspace tests", or have people just mostly ignored it
like most things?

> > > If the kernel toolchain is not fit to
> > > produce userspace because of a missing libc, the kernel's own nolibc can
> > > be used instead.
> > 
> > Is nolibc enough to run all the selftests?
> 
> It is not and most probably won't ever be. The maintainers of each testcase
> will decide which libc to use. Like it is in tools/testing/selftests/ today.
> Some use glibc, some nolibc and some can do both.

So why do you want to use it here?  And how is is related to the rest
of the series?

> While having this discussion, can we also work on dealing with the symbol
> exports, as discussed before?

Well, the scope of the entire series makes it pretty clear that this
series as is simply should not go in.

You present running pure userspace tests as the solution to a problem
you don't even explain, or rather just state very highlevel.  Yes,
kselftests suck as most people will agree.  But the answer is not
to add a lot of kernel bloat to treat userspace integration tests
like kernel units tests.  How about you just fix kselftests, preferably
by reusing well known and teststed userland code?


