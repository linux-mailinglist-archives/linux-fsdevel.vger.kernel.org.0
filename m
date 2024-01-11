Return-Path: <linux-fsdevel+bounces-7817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D65FF82B6CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755D81F25489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E45820A;
	Thu, 11 Jan 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hheLtr7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEF58136;
	Thu, 11 Jan 2024 21:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B170CC433C7;
	Thu, 11 Jan 2024 21:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705009651;
	bh=Fu1ypAtEiesdzAwaXB0NR173q0atqGGzYX/w5m6UGjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hheLtr7nOCbCFXbzvVRgp2BcuSbaEVTJK6kby1LPvpB40jQK0L5cbYnXZ2GafJHvu
	 6leGA8iC2zylszpSetyrvNylol9U/O0snc8H6leCMBhG3Zx/bziqgLhtG9uxZFnvw3
	 6uNflX+84F9NI/Uh7HuW4x1jOBYWv0/PtG09pTZ/EUxXVPsho/ouEmu1ZWsIpp9BCP
	 5Y9P5hXK2PZstVvU4V3n4TmDdgmAxuOA4gyzXgQL5+s17png1dNhzwfnLzJR1yNDcn
	 hy3UT5maSUHtlVyTZINb2l2JGyKlWwmCAAljaw6/GU/L723ZmKRNdIntERTgY2hwoV
	 Ubivlfzk2TDgg==
Date: Thu, 11 Jan 2024 21:47:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oaeocmcu2u0GtUMN"
Content-Disposition: inline
In-Reply-To: <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
X-Cookie: Does the name Pavlov ring a bell?


--Oaeocmcu2u0GtUMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 11, 2024 at 12:38:57PM -0500, Kent Overstreet wrote:
> On Thu, Jan 11, 2024 at 03:35:40PM +0000, Mark Brown wrote:

> > IME the actually running the tests bit isn't usually *so* much the
> > issue, someone making a new test runner and/or output format does mean a
> > bit of work integrating it into infrastructure but that's more usually
> > annoying than a blocker.

> No, the proliferation of test runners, test output formats, CI systems,
> etc. really is an issue; it means we can't have one common driver that
> anyone can run from the command line, and instead there's a bunch of
> disparate systems with patchwork integration and all the feedback is nag
> emails - after you've finished whan you were working on instead of
> moving on to the next thing - with no way to get immediate feedback.

It's certainly an issue and it's much better if people do manage to fit
their tests into some existing thing but I'm not convinced that's the
big reason why you have a bunch of different systems running separately
and doing different things.  For example the enterprise vendors will
naturally tend to have a bunch of server systems in their labs and focus
on their testing needs while I know the Intel audio CI setup has a bunch
of laptops, laptop like dev boards and things in there with loopback
audio cables and I think test equipment plugged in and focuses rather
more on audio.  My own lab is built around on systems I can be in the
same room as without getting too annoyed and does things I find useful,
plus using spare bandwidth for KernelCI because they can take donated
lab time.

I think there's a few different issues you're pointing at here:

 - Working out how to run relevant tests for whatever area of the kernel
   you're working on on whatever hardware you have to hand.
 - Working out exactly what other testers will do.
 - Promptness and consistency of feedback from other testers.
 - UI for getting results from other testers.

and while it really sounds like your main annoyances are the bits with
other test systems it really seems like the test runner bit is mainly
for the first issue, possibly also helping with working out what other
testers are going to do.  These are all very real issues.

> And it's because building something shiny and new is the fun part, no
> one wants to do the grungy integration work.

I think you may be overestimating people's enthusiasm for writing test
stuff there!  There is NIH stuff going on for sure but lot of the time
when you look at something where people have gone off and done their own
thing it's either much older than you initially thought and predates
anything they might've integrated with or there's some reason why none
of the existing systems fit well.  Anecdotally it seems much more common
to see people looking for things to reuse in order to save time than it
is to see people going off and reinventing the world.

> > > example tests, example output:
> > > https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/single_device.ktest
> > > https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing

> > For example looking at the sample test there it looks like it needs
> > among other things mkfs.btrfs, bcachefs, stress-ng, xfs_io, fio, mdadm,
> > rsync

> Getting all that set up by the end user is one command:
>   ktest/root_image create
> and running a test is one morecommand:
> build-test-kernel run ~/ktest/tests/bcachefs/single_device.ktest

That does assume that you're building and running everything directly on
the system under test and are happy to have the test in a VM which isn't
an assumption that holds universally, and also that whoever's doing the
testing doesn't want to do something like use their own distro or
something - like I say none of it looks too unreasonable for
filesystems.

> > and a reasonably performant disk with 40G of space available.
> > None of that is especially unreasonable for a filesystems test but it's
> > all things that we need to get onto the system where we want to run the
> > test and there's a lot of systems where the storage requirements would
> > be unsustainable for one reason or another.  It also appears to take
> > about 33000s to run on whatever system you use which is distinctly
> > non-trivial.

> Getting sufficient coverage in filesystem land does take some amount of
> resources, but it's not so bad - I'm leasing 80 core ARM64 machines from
> Hetzner for $250/month and running 10 test VMs per machine, so it's
> really not that expensive. Other subsystems would probably be fine with
> less resources.

Some will be, some will have more demanding requirements especially when
you want to test on actual hardware rather than in a VM.  For example
with my own test setup which is more focused on hardware the operating
costs aren't such a big deal but I've got boards that are for various
reasons irreplaceable, often single instances of boards (which makes
scheduling a thing) and for some of the tests I'd like to get around to
setting up I need special physical setup.  Some of the hardware I'd like
to cover is only available in machines which are in various respects
annoying to automate, I've got a couple of unused systems waiting for me
to have sufficient bandwidth to work out how to automate them.  Either
way I don't think the costs are trival enough to be completely handwaved
away.

I'd also note that the 9 hour turnaround time for that test set you're
pointing at isn't exactly what I'd associate with immediate feedback.

--Oaeocmcu2u0GtUMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWgYe0ACgkQJNaLcl1U
h9AGUwf9EzzYc9GC3VLgQW2jSAvt8fpBW6u0etaKnnghvRUvtKxavMkeUvUqH/dl
ozDTR8K91RDvuBe8TatVwk7OsW50oQVFVWQvSRz6SCY2NUPzBL8r7NDgzyCegTU9
X2LkXX9xT6YUtRFW7xSBuuYXwXMes7nFG0s8CzPhOJAl9MmWbxL3A1PCKPk4rQu4
hVkn7BbAELXanc8hBqXHbcak8xiNThnIYGRleEzRcQ9R6KBGCdJ8nr114rapXGE5
17oGv909lvC3B2cXCFXZE1g83fiMXFKJtRVNAWf+uUihr2oH380cymHXUhCzTiPd
mO0vBJFc9XKQ5OdPxplj6FSkqVGZaQ==
=TLYT
-----END PGP SIGNATURE-----

--Oaeocmcu2u0GtUMN--

