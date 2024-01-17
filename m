Return-Path: <linux-fsdevel+bounces-8190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31B0830BF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 18:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC331F24C36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD722EE1;
	Wed, 17 Jan 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYdYhYXs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB32261A;
	Wed, 17 Jan 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512810; cv=none; b=o4MPZfacPszcYVbUVM+f5TSFgvqvZZoJsppQ6mocdTNNUhDNBhn3hW5xcEiXRvX/TbUW31FlHuXlpgq0N3Ix4o7H0AJkKB5za1fTgJ6CN/Zbl3OLE8SA1Fg0OGDG+37O3Cqhusd9cEmB9w0tnZ39RJQWFvWkjo0HpXOzdkPaMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512810; c=relaxed/simple;
	bh=+Wb3+6g4jOz7XRey17y/SlhFbOsOs7Bf2nj0XnSH1wI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=oXC3pK1AJ0J8HKjRQGhWUw3YYRFrXD8ZHUOKJSO5v8B2JHD2L7EtmI9UmtwufWxk/N8FQg0IZEj/zTQMk9KWYpuDkSUrTnQ3ggDzMEhou4TDgpVJAEqy70iV77ldz2Mz8c6Zgrkr8/Iffnyn1/TJl4bBhn6/9TaNfFDJslLTajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYdYhYXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB59C433A6;
	Wed, 17 Jan 2024 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705512809;
	bh=+Wb3+6g4jOz7XRey17y/SlhFbOsOs7Bf2nj0XnSH1wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jYdYhYXsmCv8kz6vcy4tt0FIjooLELWxNlp3tw6BUlc9nUgUyOIXKRUQqSae7VoKf
	 uBbQk+WGFhLe6fuhtfZfFZ/4k0rkjFsnU5Lm0SEgoLbtklKYiD74l1woi1K8DTCS1l
	 BOCTM9vn1V5mhqhj9WIZjJ36ssVaVXjXH2LU4b74k/+q9XLCi/RDD/WHEK7KhoXNpq
	 uZWQbvHClZ9wy4CmF3kyfcSqpN7IHSuWpbtSfcC1ypPtkXcCGVw0l0ysxR7O6NieOi
	 9IZa73I1ZQ9Rvrl2Qr8xdTnqlilrP0iN1XttHGUJT/gODtD8OKauvkHQFIvb0wFi/b
	 0k5kVMzqCmgRA==
Date: Wed, 17 Jan 2024 17:33:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Neal Gompa <neal@gompa.dev>, Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Nikolai Kondrashov <spbnick@gmail.com>,
	Philip Li <philip.li@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <279c6f69-9af2-4607-b5d1-1acd21f9da8b@sirena.org.uk>
References: <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lNBJ9/03mTaJ7xAl"
Content-Disposition: inline
In-Reply-To: <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
X-Cookie: Programmers do it bit by bit.


--lNBJ9/03mTaJ7xAl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2024 at 01:42:53PM -0500, Kent Overstreet wrote:
> On Fri, Jan 12, 2024 at 06:22:55PM +0000, Mark Brown wrote:

> > This depends a lot on the area of the kernel you're looking at - some
> > things are very amenable to testing in a VM but there's plenty of code
> > where you really do want to ensure that at some point you're running
> > with some actual hardware, ideally as wide a range of it with diverse
> > implementation decisions as you can manage.  OTOH some things can only
> > be tested virtually because the hardware doesn't exist yet!

> Surface wise, there are a lot of drivers that need real hardware; but if
> you look at where the complexity is, the hard complex algorithmic stuff
> that really needs to be tested thoroughly - that's all essentially
> library code that doesn't need specific drivers to test.

...

> And if we were better at that, it would be a good nudge towards driver
> developers to make their stuff easier to test, perhaps by getting a
> virtualized implementation into qemu, or to make the individual drivers
> thinner and move heavy logic into easier to test library code.

As Greg indicated with the testing I doubt everyone has infinite budget
for developing emulation, and I will note that model accuracy and
performance tend to be competing goals.  When it comes to factoring
things out into library code that can be a double edged sword - changes
in the shared code can affect rather more systems than a single driver
change so really ought to be tested on a wide range of systems.  The
level of risk from changes does vary widly of course, and you can try to
have pure software tests for the things you know are relied upon, but
it can be surprising.

> > Yeah, similar with a lot of the more hardware focused or embedded stuff
> > - running something on the machine that's in front of you is seldom the
> > bit that causes substantial issues.  Most of the exceptions I've
> > personally dealt with involved testing hardware (from simple stuff like
> > wiring the audio inputs and outputs together to verify that they're
> > working to attaching fancy test equipment to simulate things or validate
> > that desired physical parameters are being achieved).

> Is that sort of thing a frequent source of regressions?

> That sounds like the sort of thing that should be a simple table, and
> not something I would expect to need heavy regression testing - but, my
> experience with driver development was nearly 15 years ago; not a lot of
> day to day. How badly are typical kernel refactorings needing regression
> testing in individual drivers?

General refactorings tend not to be that risky, but once you start doing
active work on the shared code dealing with the specific thing the risk
starts to go up and some changes are more risky than others.

> Filesystem development, OTOH, needs _heavy_ regression testing for
> everything we do. Similarly with mm, scheduler; many subtle interactions
> going on.

Right, and a lot of factored out code ends up in the same boat - that's
kind of the issue.

> > > > It's a basic lack of leadership. Yes, the younger engineers are always
> > > > going to be doing the new and shiny, and always going to want to build
> > > > something new instead of finishing off the tests or integrating with
> > > > something existing. Which is why we're supposed to have managers saying
> > > > "ok, what do I need to prioritize for my team be able to develop
> > > > effectively".

> > That sounds more like a "(reproducible) tests don't exist" complaint
> > which is a different thing again to people going off and NIHing fancy
> > frameworks.

> No, it's a leadership/mentorship thing.

> And this is something that's always been lacking in kernel culture.
> Witness the kind of general grousing that goes on at maintainer summits;
> maintainers complain about being overworked and people not stepping up
> to help with the grungy responsibilities, while simultaneously we still
> very much have a "fuck off if you haven't proven yourself" attitude
> towards newcomers. Understandable given the historical realities (this
> shit is hard and the penalties of fucking up are high, so there does
> need to be a barrier to entry), but it's left us with some real gaps.

> We don't have enough a people in the senier engineer role who lay out
> designs and organise people to take on projects that are bigger than one
> single person can do, or that are necessary but not "fun".

> Tests and test infrastructure fall into the necessary but not fun
> category, so they languish.

Like Greg said I don't think that's a realistic view of how we can get
things done here - often the thing with stop energy is that it just
makes people stop.  In a lot of areas everyone is just really busy and
struggling to keep up, we make progress on the generic stuff in part by
accepting that people have limited time and will do what they can with
everyone building on top of everyone's work.

> > > > Just requisition the damn machines.

> > There's some assumptions there which are true for a lot of people
> > working on the kernel but not all of them...

> $500 a month for my setup (and this is coming out of my patreon funding
> right now!). It's a matter of priorities, and being willing to present
> this as _necessary_ to the people who control the purse strings.

One of the assumptions there is that everyone is doing this in a well
funded corporate environment focused on upstream.  Even ignoring
hobbyists and students for example in the embedded world it's fairly
common to have stuff being upstreamed since people did the work anyway
for a customer project or internal product but where the customer
doesn't actually care either way if the code lands anywhere other than
their product (we might suggest that they should care but that doesn't
mean that they actually do care).

I'll also note that there's people like me who do things with areas of
the kernel not urgently related to their current employer's business and
hence very difficult to justify as a work expense.  With my lab some
companies have been generous enough to send me test hardware (which I'm
very greatful for, that's most of the irreplaceable stuff I have) but
the infrastructure around them and the day to day operating costs are
all being paid for by me personally.

> > > > I'd also really like to get automated performance testing going too,
> > > > which would have similar requirements in that jobs would need to be
> > > > scheduled on specific dedicated machines. I think what you're doing
> > > > could still build off of some common infrastructure.

> > It does actually - like quite a few test labs mine is based around LAVA,
> > labgrid is the other popular option (people were actually thinking about
> > integrating the two recently since labgrid is a bit lower level than

...

> > want to run and what results I expect.  What I've got is *much* more
> > limited than I'd like, and frankly if I wasn't able to pick up huge
> > amounts of preexisting work most of this stuff would not be happening.

> That's interesting. Do you have or would you be willing to write an
> overview of what you've got? The way you describe it I wonder if we've
> got some commonality.

I was actually thinking about putting together a talk about it, though
realistically the majority of it is just a very standard LAVA lab which
is something there's a bunch of presentations/documentation about
already.

> The short overview of my system: tests are programs that expose
> subcommends for listing depencies (i.e. virtual machine options, kernel
> config options) and for listing and running subtests. Tests themselves
> are shell scripts, with various library code for e.g. standard
> kernel/vm config options, hooking up tracing, core dump catching, etc.

> The idea is for tests to be entirely self contained and need no outside
> configuration.

The tests themselves bit sounds like what everyone else is doing - it
all comes down to running some shell commands in a target environment
somewhere.  kselftest provides information on which config options it
needs which would be nice to integrate too.

> and the CI, on top of all that, watches various git repositories and -
> as you saw - tests every commit, newest to oldest, and provides the
> results in a git log format.

> The last one, "results in git log format", is _huge_. I don't know why I
> haven't seen anyone else do that - it was a must-have feature for any
> system over 10 years ago, and it never appeared so I finally built it
> myself.

A lot of the automated testing that gets done is too expensive to be
done per commit, though some does.  I do actually do it myself, but even
there it's mainly just some very quick smoke tests that get run per
commit with more tests done on the branch as a whole (with a bit more
where I can parallise things well).  My stuff is more organised for
scripting so expected passes are all just elided, I just use LAVA's UI
if I want to pull the actual jobs for some reason.  I've also see aiaiai
used for this, though I think the model there was similarly to only get
told about problems.

> We (inherently!) have lots of issues with tests that only sometimes fail
> making it hard to know when a regression was introduced, but running all
> the tests on every commit with a good way to see the results makes this
> nearly a non issue - that is, with a weak and noisy signal (tests
> results) we just have to gather enough data and present the results
> properly to make the signal stand out (which commit(s) were buggy).

Yeah, running for longer and/or more often helps find the hard to
reproduce things.  There's a bunch of strategies for picking exactly
what to do there, per commit is certainly a valid one.

--lNBJ9/03mTaJ7xAl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWoD2MACgkQJNaLcl1U
h9CUZQf/Xr237utclK4Iwcpwarn5XOFXPan2c+a4D74Nz9uzDCbqw5tCCVay7YWP
HfeMCSSswtW8ZLii/6imjAZJFfai5oq6oBcOV4CdJgLzFZ0p7czVRMRTmmKr04wk
GFp+kykeMhnNRd/lgurMDx7pfjjCFMHYF8r8faJXUkQgCgVJmvMUmw3I5EulacyM
jC0F72YBlkhM97eVe4qrlmrZrxedb1B06o9xltoqpOW2ItoZEDtHKYapP4KrBY2w
9E0DVpBBEGEY70+v19VMDejAYvoQUhYPSBaX5QxibzgU39zXvX+34DoGesF6l0Zo
718dKzGrXI6+3i6TmdLhNdEGEh0FvA==
=PZJy
-----END PGP SIGNATURE-----

--lNBJ9/03mTaJ7xAl--

