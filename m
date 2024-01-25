Return-Path: <linux-fsdevel+bounces-9011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31183CED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 22:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AC328CF8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 21:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C813AA30;
	Thu, 25 Jan 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UauIyJax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626C135413;
	Thu, 25 Jan 2024 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219225; cv=none; b=D3AGhW9P/kTBs4uW3a5Bd9udZ4vaJX/MHwI97i1DHM8ipDYp2tf3RWaW7iivJVHJpBZb74YEU2nlfZxw8OtY2B8r/bvngkXXuZI2mkAywPQFSaQ4Bi62VJFbOPb1rsFBj2g7O0eowblshYf1iM3BWHsgjc7ke/HbdTFCXLLYDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219225; c=relaxed/simple;
	bh=fjFf6vRo4yuWVrpY3vShY+6xxu0dgHE9J/OQbltZeUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD0c1pbjYnWQOdbZZSBLa30wbTAKX2wHdq2aDTmzz0SY+ZXeR0by6ryt/1AuBqAsbdkUgiJAVpJ+V8Ya2edYl8pB4411u5U9wrh64lVHvj0+GWusvr6u27OvEiFukotrAyAn44sXwqYebTptd+BQOf3F1ThOi4QIZKVdCox3MfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UauIyJax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE51C433C7;
	Thu, 25 Jan 2024 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706219225;
	bh=fjFf6vRo4yuWVrpY3vShY+6xxu0dgHE9J/OQbltZeUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UauIyJaxOjRGvGs4W/OY+L7QWCmsRuosHxifU5R6Qx0UzIbhXAa87Cm0Dmpg2x5dr
	 Jd2PMPu8MnnzXoIfjVsJR3Qc82TKDSFpjGEoW827lPQEoDtPqQi2yGB5PU6DJG5/5k
	 RRWm1N1X+o1CaFtc0BaWEu4CiYAtNyg0m3XchubQTIXEC64QZNf9zWWJeYoGs+mbl1
	 TZDQonudge3fIQOhFfNSAK6oSLlGekENiN4IcCc6daA4vT0L2sQXRxmUbJrKXCydW5
	 /DAKupIyOlPDEMvE2qgrV3rvHNrUVJ3dBMGvq7/oDlN2xNFo0Jk4tFQesovJabhgL1
	 aeK8IN40vfqjA==
Date: Thu, 25 Jan 2024 21:46:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	Neal Gompa <neal@gompa.dev>, Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Nikolai Kondrashov <spbnick@gmail.com>,
	Philip Li <philip.li@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <ZbLW0/t57GVQJVF1@sirena.org.uk>
References: <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
 <20240117055457.GL911245@mit.edu>
 <5b7154f86913a0957e0518b54365a1b0fce5fbea.camel@HansenPartnership.com>
 <c69a3103-ae4d-459a-b5f4-d3bbe2af6fb2@sirena.org.uk>
 <vm5fwfqtqoy5yl37meflf4yrmzotyi5aszouwthfv6q7nrtxhq@oucmld5ak4uo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="95W9f47JAmPj9bg9"
Content-Disposition: inline
In-Reply-To: <vm5fwfqtqoy5yl37meflf4yrmzotyi5aszouwthfv6q7nrtxhq@oucmld5ak4uo>
X-Cookie: You might have mail.
X-TUID: zJhhZNiCh8nK


--95W9f47JAmPj9bg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 10:24:09PM -0500, Kent Overstreet wrote:
> On Wed, Jan 17, 2024 at 06:19:43PM +0000, Mark Brown wrote:
> > On Wed, Jan 17, 2024 at 08:03:35AM -0500, James Bottomley wrote:

> > I think that's a *bit* pessimistic, at least for some areas of the
> > kernel - there is commercial stuff going on with kernel testing with
> > varying degrees of community engagement (eg, off the top of my head
> > Baylibre, Collabora and Linaro all have offerings of various kinds that
> > I'm aware of), and some of that does turn into investments in reusable
> > things rather than proprietary stuff.  I know that I look at the
> > kernelci.org results for my trees, and that I've fixed issues I saw
> > purely in there.  kselftest is noticably getting much better over time,
> > and LTP is quite active too.  The stuff I'm aware of is more focused
> > around the embedded space than the enterprise/server space but it does
> > exist.  That's not to say that this is all well resourced and there's no
> > problem (far from it), but it really doesn't feel like a complete dead
> > loss either.

> kselftest is pretty exciting to me; "collect all our integration tests
> into one place and start to standarize on running them" is good stuff.

> You seem to be pretty familiar with all the various testing efforts, I
> wonder if you could talk about what you see that's interesting and
> useful in the various projects?

Well, I'm familiar with the bits I look at and some of the adjacent
areas but definitely not with the testing world as a whole.

For tests themselves there's some generic suites like LTP and kselftest,
plus a lot of domain specific things which are widely used in their
areas.  Often the stuff that's separate either lives with something like
a userspace library rather than just being a purely kernel thing or has
some other special infrastructure needs.

For lab orchestration there's at least:

    https://beaker-project.org/
    https://github.com/labgrid-project/labgrid
    https://www.lavasoftware.org/

Beaker and LAVA are broadly similar in a parallel evolution sort of way,
scalable job scheduler/orchestration things intended for non interactive
use with a lot of overlap in design choices.  LAVA plays nicer with
embedded boards since Beaker comes from RedHat and is focused more on
server/PC type use cases though I don't think there's anything
fundamental there.  Labgrid has a strong embedded focus with facilities
like integrating anciliary test equipment and caters a lot more to
interactive use than either of the other two but AIUI doesn't help so
much with batch usage, though that can be built on top.  All of them can
handle virtual targets as well as physical ones.

All of these need something driving them to actually generate test jobs
and present the results, as well as larger projects there's also people
like Guenter Roeck and myself who run things that amuse us and report
them by hand.  Of the bigger general purpose orchestration projects off
the top of my head there's

    https://github.com/intel/lkp-tests/blob/master/doc/faq.md
    https://cki-project.org/
    https://kernelci.org/
    https://lkft.linaro.org/

CKI and KernelCI are not a million miles apart, they both monitor a
bunch of trees and run well known testsuites that they've integrated,
and have code available if you want to deploy your own thing (eg, for
non-public stuff).  They're looking at pooling their results into kcidb
as part of the KernelCI LF project.  Like 0day is proprietary to Intel
LKFT is proprietary to Linaro, LKFT has a focus on running a lot of
tests on stable -rcs with manual reporting though they do have some best
effort coverage of mainline and -next as well.

There's also a bunch of people doing things specific to a given hardware
type or other interest, often internal to a vendor but for example Intel
have some public CI for their graphics and audio:

    https://intel-gfx-ci.01.org/
    https://github.com/thesofproject/linux/

(you can see the audio stuff doing it's thing on the pull requests in
the SOF repo.)  The infra behind these is a bit task specific AIUI, for
example the audio testing includes a lot of boards that don't have
serial consoles or anything (eg, laptops) so it uses a fixed filesystem
on the device, copies a kernel in and uses grub-reboot to try it one
time.  They're particularly interesting because they're more actively
tied to the development flow.  The clang people have something too using
a github flow:

    https://github.com/ClangBuiltLinux/continuous-integration2

(which does have some boots on virtual platforms as well as just build
coverage.)

> I think a lot of this stems from a lack of organization and a lack of
> communication; I see a lot of projects reinventing things in slightly
> different ways and failing to build off of each other.

There's definitely some NIHing going on in places but a lot of it comes
=66rom people with different needs or environments (like the Intel audio
stuff I mentioned), or just things already existing and nobody wanting
to disrupt what they've got for a wholesale replacement.  People are
rarely working from nothing, and there's a bunch of communication and
sharing of ideas going on.

> > Some of the issues come from the different questions that people are
> > trying to answer with testing, or the very different needs of the
> > tests that people want to run - for example one of the reasons
> > filesystems aren't particularly well covered for the embedded cases is
> > that if your local storage is SD or worse eMMC then heavy I/O suddenly
> > looks a lot more demanding and media durability a real consideration.

> Well, for filesystem testing we (mostly) don't want to be hammering on
> an actual block device if we can help it - there are occasionally bugs
> that will only manifest when you're testing on a device with realistic
> performance characteristics, and we definitely want to be doing some
> amount of performance testing on actual devices, but most of our testing
> is best done in a VM where the scratch devices live entirely in dram on
> the host.

Sure, though there can be limitations with the amount of memory on a lot
of these systems too!  You can definitely do things, it's just not
always ideal - for example filesystem people will tend to default to
using test filesystems sized like the total memory of a lot of even
modern embedded boards so if nothing else you need to tune things down
if you're going to do a memory only test.

--95W9f47JAmPj9bg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWy1tIACgkQJNaLcl1U
h9CVTgf/R7iosqegrv7uwYe4o59k308aqsf0UrmWnF7gVhEtitPC84CIBvjkKRc+
6w0aNtqn16xcQT11AqCbzmkZvlmODIpwLyS58fknXWBF+VXz082jtYVK0SThg22+
cGnCMUrWCWJ6t6Y4nsA0ocRe2MDB4Ykk84XSjgn6sPeP8GX3HRY3GKHsJhQ7nLMu
bTBttmqO/e39T+F8ldYOX25ZK+qHpW4x7k7WEdpVBm2xXGPtdZzUwXHAtqVx/GJQ
CaiclaF/HHd/uCv6ErlcmYB3VNHtnpW0k+zqiqlW6kC2Z4QkMdr0MdGkvAqbPjHi
Ooqh5CkJTQXefxz2oEuXWGz7FBIlnA==
=fF9S
-----END PGP SIGNATURE-----

--95W9f47JAmPj9bg9--

