Return-Path: <linux-fsdevel+bounces-7800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E59C82B1E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 16:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7741F22906
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3AF4CDFE;
	Thu, 11 Jan 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er/xDDkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74EC4CB3C;
	Thu, 11 Jan 2024 15:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B3FC433F1;
	Thu, 11 Jan 2024 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704987345;
	bh=oEtfuOtGz1guJomIj/XNL0SEY1LCnTnBwTbggCFg54M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=er/xDDkYdR6hDbM48Uq1Ghk5KkaZVzSJ3rzSL18PDuUYSf6nHjNh4h8WLhAYtgF5Q
	 tcb+zXPlvRsAXDbdNTmqYW7jaPzfeeLoM37n3mPEproaPVLia0+/Roc0x+rpinKLJF
	 ieoTcSKs3e4/phDC7dRpTNLJZOxA/5aZWOVU6s/VNpiyAm1tXN/1JmB1DkEiph/6/E
	 8JKMuIzK/XAJI7Y9Asm/wESu9qL6dCGZcI40xe4EYRNo4nXHV4FbPKUkFNxHbBwBCv
	 o+y/nZ5vLiYpkT64ZBxgABYzTYcIAhWLmQb2dQKXRIA2H0dIws4PzEdifPMZ1PVzhr
	 DfLhZIXIfhXCA==
Date: Thu, 11 Jan 2024 15:35:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zG6rsRDIXKqR7++b"
Content-Disposition: inline
In-Reply-To: <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
X-Cookie: Does the name Pavlov ring a bell?


--zG6rsRDIXKqR7++b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2024 at 07:58:20PM -0500, Kent Overstreet wrote:
> On Wed, Jan 10, 2024 at 04:39:22PM -0800, Kees Cook wrote:

> > With no central CI, the best we've got is everyone running the same
> > "minimum set" of checks. I'm most familiar with netdev's CI which has
> > such things (and checkpatch.pl is included). For example see:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240110110451.5473-3-ptikhomirov@virtuozzo.com/

> Yeah, we badly need a central/common CI. I've been making noises that my
> own thing could be a good basis for that - e.g. it shouldn't be much
> work to use it for running our tests in tools/tesing/selftests. Sadly no
> time for that myself, but happy to talk about it if someone does start
> leading/coordinating that effort.

IME the actually running the tests bit isn't usually *so* much the
issue, someone making a new test runner and/or output format does mean a
bit of work integrating it into infrastructure but that's more usually
annoying than a blocker.  Issues tend to be more around arranging to
drive the relevant test systems, figuring out which tests to run where
(including things like figuring out capacity on test devices, or how
long you're prepared to wait in interactive usage) and getting the
environment on the target devices into a state where the tests can run.
Plus any stability issues with the tests themselves of course, and
there's a bunch of costs somewhere along the line.

I suspect we're more likely to get traction with aggregating test
results and trying to do UI/reporting on top of that than with the
running things bit, that really would be very good to have.  I've copied
in Nikolai who's work on kcidb is the main thing I'm aware of there,
though at the minute operational issues mean it's a bit write only.

> example tests, example output:
> https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/single_device.ktest
> https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing

For example looking at the sample test there it looks like it needs
among other things mkfs.btrfs, bcachefs, stress-ng, xfs_io, fio, mdadm,
rsync and a reasonably performant disk with 40G of space available.
None of that is especially unreasonable for a filesystems test but it's
all things that we need to get onto the system where we want to run the
test and there's a lot of systems where the storage requirements would
be unsustainable for one reason or another.  It also appears to take
about 33000s to run on whatever system you use which is distinctly
non-trivial.

I certainly couldn't run it readily in my lab.

> > At the very least, checkpatch.pl is the common denominator:
> > https://docs.kernel.org/process/submitting-patches.html#style-check-your-changes

> At one point in my career I was religious about checkpatch; since then
> the warnings it produces have seemed to me more on the naggy and less
> on the useful end of the spectrum - I like smatch better in that
> respect.  But - I'll start running it again for the deprecation
> warnings :)

Yeah, I don't run it on incoming stuff because the rate at which it
reports things I don't find useful is far too high.

--zG6rsRDIXKqR7++b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWgCssACgkQJNaLcl1U
h9ALhAf+KOq/v9wp8cyhZPwe58TqgiLwFONHT/PvczGJsYC87rrdJUCxvFs2dnxb
mdbhIBgXftCvHZqpVnXLa+3yZEzflXdPbTXSxpRIofkMZcjiBpkvKagLJsQQ0mR+
JI5Nzd0y6Apiou7ge01JsYc1oFVghw0BRlptV9yKAH/oenKsCI7AfmBijLQiJOiX
GQ9wxOh7O49g6bs90XQ5iS7GrjcBRr1SPlHx+QXHjOFU5Jl5LsKBJ90mBZOaJBu3
zqzCbYpN9SkycuXZ4P1sleiNA5UoWCwiXqEsYL1Hnm+5+lP2ydyIp6j/3jQM3zkB
h7TdSKjYRJtlwc/P1vHb7MA5Ru+zBg==
=K28Q
-----END PGP SIGNATURE-----

--zG6rsRDIXKqR7++b--

