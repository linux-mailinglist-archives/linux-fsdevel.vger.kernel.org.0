Return-Path: <linux-fsdevel+bounces-7883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A750D82C558
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 19:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DFFB218F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126C175B0;
	Fri, 12 Jan 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdlcrtmq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597902560A;
	Fri, 12 Jan 2024 18:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B58C433C7;
	Fri, 12 Jan 2024 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705083780;
	bh=lU3HCrdKgQWP+2uYW9g0VOt5OLiZn7shgDnF710EWXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdlcrtmqtc4RIj/ehk3I9GgSPENo8oFhjP05Q1gjkiiVIzH5RcFlOnoRBKmnvhC8S
	 MGXlhqBNmJ8uXmDzFEhy6HHY8uFIDjaqWE2klebrDfPJj9VW4D3a3jbQ//VIGi2hRH
	 gspA72SUP4AyCNu0l3Fo/7lOcYKiFnkg1v+4YSbAxd1vmnAe5OaBzZa/eft3LOcfcD
	 CtS4KbLBHMQ8/pqAfF+aOJPlXRzoPR70YFSHl8dXneVjl0OVTxUUejeYYb5heSdOar
	 0G9Y46AfkxdhMHfrAKnFBj2aJHokLxuY/VK1E9WXEjbNU9zGnRt47+Ts4v95VnzCEX
	 bKU0KuUs0/AmQ==
Date: Fri, 12 Jan 2024 18:22:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Neal Gompa <neal@gompa.dev>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UV+e11fnWR99TzU9"
Content-Disposition: inline
In-Reply-To: <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
X-Cookie: I want a WESSON OIL lease!!


--UV+e11fnWR99TzU9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 06:11:04AM -0500, Neal Gompa wrote:
> On Thu, Jan 11, 2024 at 8:11=E2=80=AFPM Kent Overstreet
> > On Thu, Jan 11, 2024 at 09:47:26PM +0000, Mark Brown wrote:

> > > It's certainly an issue and it's much better if people do manage to f=
it
> > > their tests into some existing thing but I'm not convinced that's the
> > > big reason why you have a bunch of different systems running separate=
ly
> > > and doing different things.  For example the enterprise vendors will
> > > naturally tend to have a bunch of server systems in their labs and fo=
cus
> > > on their testing needs while I know the Intel audio CI setup has a bu=
nch

> > No, you're overthinking.

> > The vast majority of kernel testing requires no special hardware, just a
> > virtual machine.

This depends a lot on the area of the kernel you're looking at - some
things are very amenable to testing in a VM but there's plenty of code
where you really do want to ensure that at some point you're running
with some actual hardware, ideally as wide a range of it with diverse
implementation decisions as you can manage.  OTOH some things can only
be tested virtually because the hardware doesn't exist yet!

> > There is _no fucking reason_ we shouldn't be able to run tests on our
> > own local machines - _local_ machines, not waiting for the Intel CI
> > setup and asking for a git branch to be tested, not waiting for who
> > knows how long for the CI farm to get to it - just run the damn tests
> > immediately and get immediate feedback.

> > You guys are overthinking and overengineering and ignoring the basics,
> > the way enterprise people always do.

> As one of those former enterprise people that actually did do this
> stuff, I can say that even when I was "in the enterprise", I tried to
> avoid overthinking and overengineering stuff like this. :)

> Nobody can maintain anything that's so complicated nobody can run the
> tests on their machine. That is the root of all sadness.

Yeah, similar with a lot of the more hardware focused or embedded stuff
- running something on the machine that's in front of you is seldom the
bit that causes substantial issues.  Most of the exceptions I've
personally dealt with involved testing hardware (from simple stuff like
wiring the audio inputs and outputs together to verify that they're
working to attaching fancy test equipment to simulate things or validate
that desired physical parameters are being achieved).

> > > of the existing systems fit well.  Anecdotally it seems much more com=
mon
> > > to see people looking for things to reuse in order to save time than =
it
> > > is to see people going off and reinventing the world.

> > It's a basic lack of leadership. Yes, the younger engineers are always
> > going to be doing the new and shiny, and always going to want to build
> > something new instead of finishing off the tests or integrating with
> > something existing. Which is why we're supposed to have managers saying
> > "ok, what do I need to prioritize for my team be able to develop
> > effectively".

That sounds more like a "(reproducible) tests don't exist" complaint
which is a different thing again to people going off and NIHing fancy
frameworks.

> > > That does assume that you're building and running everything directly=
 on
> > > the system under test and are happy to have the test in a VM which is=
n't
> > > an assumption that holds universally, and also that whoever's doing t=
he
> > > testing doesn't want to do something like use their own distro or
> > > something - like I say none of it looks too unreasonable for
> > > filesystems.

> > No, I'm doing it that way because technically that's the simplest way to
> > do it.

> > All you guys building crazy contraptions for running tests on Google
> > Cloud or Amazon or whatever - you're building technical workarounds for
> > broken procurement.

I think you're addressing some specific stuff that I'm not super
familiar with here?  My own stuff (and most of the stuff I end up
looking at) involves driving actual hardware.

> > Just requisition the damn machines.

There's some assumptions there which are true for a lot of people
working on the kernel but not all of them...

> Running in the cloud does not mean it has to be complicated. It can be
> a simple Buildbot or whatever that knows how to spawn spot instances
> for tests and destroy them when they're done *if the test passed*. If
> a test failed on an instance, it could hold onto them for a day or two
> for someone to debug if needed.

> (I mention Buildbot because in a previous life, I used that to run
> tests for the dattobd out-of-tree kernel module before. That was the
> strategy I used for it.)

Yeah, or if your thing runs in a Docker container rather than a VM then
throwing it at a Kubernetes cluster using a batch job isn't a big jump.

> > I'd also really like to get automated performance testing going too,
> > which would have similar requirements in that jobs would need to be
> > scheduled on specific dedicated machines. I think what you're doing
> > could still build off of some common infrastructure.

It does actually - like quite a few test labs mine is based around LAVA,
labgrid is the other popular option (people were actually thinking about
integrating the two recently since labgrid is a bit lower level than
LAVA and they could conceptually play nicely with each other).  Since
the control API is internet accessible this means that it's really
simple for me to to donate spare time on the boards to KernelCI as it
understands how to drive LAVA, testing that I in turn use myself.  Both
my stuff and KernelCI use a repository of glue which knows how to drive
various testsuites inside a LAVA job, that's also used by other systems
using LAVA like LKFT.

The custom stuff I have is all fairly thin (and quite janky), mostly
just either things specific to my physical lab or managing which tests I
want to run and what results I expect.  What I've got is *much* more
limited than I'd like, and frankly if I wasn't able to pick up huge
amounts of preexisting work most of this stuff would not be happening.

> > > I'd also note that the 9 hour turnaround time for that test set you're
> > > pointing at isn't exactly what I'd associate with immediate feedback.

> > My CI shards at the subtest level, and like I mentioned I run 10 VMs per
> > physical machine, so with just 2 of the 80 core Ampere boxes I get full
> > test runs done in ~20 minutes.

> This design, ironically, is way more cloud-friendly than a lot of
> testing system designs I've seen in the past. :)

Sounds like a small private cloud to me!  :P

--UV+e11fnWR99TzU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWhg38ACgkQJNaLcl1U
h9DHZwf+PUi1dDbFvsjAfmvcY+0m2KkcjKJUtDiUwTEHmzVMfX8ecVVG8n3KvIoK
yJPiP3akTv4vWMqCVYjXdWrIWgxd9JD3tLscfll2OH1dFJPKVKynWNhqdAKLfBIv
dZALV/v+MthofRA4/SQclK5mUqp8TfQ9Y+oHdKoc9IZ/ouD2XKpmdx2Pd7czeDXF
3g5bgNNV0B6qTNySSsk9kFIMqGrFd9x8lD5JGDI+Yn0Pszd1apv0G2Jd0GizYuUa
0zWhQFJC1o7YVIdocJlIUQMMw4DarW45ZWzhHOqw/l4qyJ5ozT5LPB+PzEmfNLQj
Sk+tVn8kcBGo7OmCWlw8wcd5eUNqvQ==
=b3J3
-----END PGP SIGNATURE-----

--UV+e11fnWR99TzU9--

