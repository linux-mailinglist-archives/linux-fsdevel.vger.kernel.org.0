Return-Path: <linux-fsdevel+bounces-64358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02046BE2CBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD7FA4F8EFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3472D3A7B;
	Thu, 16 Oct 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPZ8xYYT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A542C11D4;
	Thu, 16 Oct 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610565; cv=none; b=raNESWGfdgFKFjyVVRUKpS2SaZ7Jh7DNV+mU6qB2Luavww3nT+2GkO+PIPmsYUyOFx514HtOvrsMcOaMRgkuH8Tw5cXQth95G9/B6W5/vyZwzxxYLiEbSw4pEGlbqd5lTuAEUrWytB39XLatN+JHhZ+ngfXt0rdPXYisg28/5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610565; c=relaxed/simple;
	bh=vGn4LQ6PjgY7cksHSlJCYhC4n/ojq1fCtHom8ypt/EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKnuBsgAmGFRvJPrbXn3nWdxr72hPcifP2+O8jlU5R5asCnWmsv5wc7P0pjVjSD6BiFwNVFtKMWF6fPrOadaCjtzfLzpDgFhl7Yizg5eotUGHleIMdx5YgsaFFzwCxk8W/0u1zjGUaBHsQxpotvYybQTMo0HGPlzWo3YIvq1WV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPZ8xYYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F7CC4CEF1;
	Thu, 16 Oct 2025 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610564;
	bh=vGn4LQ6PjgY7cksHSlJCYhC4n/ojq1fCtHom8ypt/EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPZ8xYYTdOxFH05lnqQg5lEMbELYS9myaW29dHJwnXrsIam9zHTVTFUKCYrv1ENuA
	 opBwv5htRr6F3a0MpVdhLcUmPXWx5gyCILN19GG4RWXcdMJuXOCT0PNnZoDZ84tDKV
	 sjKX+HZbmWx9ObnWhE7hBxQKmeDSqhlHpHvnMRsMbm41+AM14mhmira27WFxvWcOqd
	 JLzodzwtS48FcJPRMG0IWscauM/RB2nzSRYvZeQQEVJi/Tno+K2EbqlcP/XYrrSClt
	 uFrR8KmoM5zMllpcHfQu/J4CIV7eHdoICRRzXRbVVqoW9gZIFNSznCxX6E67P3TM5H
	 zjZiiggHI2Xmg==
Date: Thu, 16 Oct 2025 12:29:21 +0200
From: Alejandro Colomar <alx@kernel.org>
To: "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc: Luca Boccassi <luca.boccassi@gmail.com>, 
	Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, cyphar@cyphar.com, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
Message-ID: <caphk5vjat3dbm5hb5nhvpyc3p26nkc6bfr3p25lndqbqllj47@i45f4savslj4>
References: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
 <20251012125819.136942-1-safinaskar@gmail.com>
 <CAMw=ZnTuK=ZijDbhrMOXmiGjs=8i2qyQUwwtM9tcvTSP0k6H4g@mail.gmail.com>
 <bc7w4t422bvpcylsagpsagl3orryepdbz4qimkuttd3ehtdsfu@thng5d5wn567>
 <20251012185703.oksyg4loz5fcassb@illithid>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4y27m3sj7qvjy3rw"
Content-Disposition: inline
In-Reply-To: <20251012185703.oksyg4loz5fcassb@illithid>


--4y27m3sj7qvjy3rw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc: Luca Boccassi <luca.boccassi@gmail.com>, 
	Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, cyphar@cyphar.com, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
Message-ID: <caphk5vjat3dbm5hb5nhvpyc3p26nkc6bfr3p25lndqbqllj47@i45f4savslj4>
References: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
 <20251012125819.136942-1-safinaskar@gmail.com>
 <CAMw=ZnTuK=ZijDbhrMOXmiGjs=8i2qyQUwwtM9tcvTSP0k6H4g@mail.gmail.com>
 <bc7w4t422bvpcylsagpsagl3orryepdbz4qimkuttd3ehtdsfu@thng5d5wn567>
 <20251012185703.oksyg4loz5fcassb@illithid>
MIME-Version: 1.0
In-Reply-To: <20251012185703.oksyg4loz5fcassb@illithid>

Hi Branden, Luca,

On Sun, Oct 12, 2025 at 01:57:03PM -0500, G. Branden Robinson wrote:
> At 2025-10-12T16:57:22+0200, Alejandro Colomar wrote:
> > On Sun, Oct 12, 2025 at 03:25:37PM +0100, Luca Boccassi wrote:
> > > On Sun, 12 Oct 2025 at 13:58, Askar Safin <safinaskar@gmail.com> wrot=
e:
> > > > So everything is working as intended, and no changes to manual
> > > > pages are needed.
> > >=20
> > > I don't think so. This was in a mount namespace, so it was not
> > > shared, it was a new image, so not shared either, and '/' was not
> > > involved at all. It's probably because you tried with a tmpfs
> > > instead of an actual image.
> > >=20
> > > But it really doesn't matter, I just wanted to save some time for
> > > other people by documenting this, but it's really not worth having a
> > > discussion over it, feel free to just disregard it. Thanks.
> >=20
> > I appreciate you wanting to save time for other people by documenting
> > it.  But we should also make sure we understand it fully before
> > documenting it.  I'd like us to continue this discussion, to be able
> > to understand it and thus document it.  I appreciate Aleksa and
> > Askar's efforts in understanding this, and the discussion too, which
> > helps me understand it too.  I can't blindly take patches without
> > review, and this discussion helps a lot.
>=20
> I have some unsolicited project management advice to offer.
>=20
> I think you should say "won't" rather than "can't" in your final
> sentence.  You are defending a point of policy--rightly so, in my view.
> If someone wants to argue your preference on the subject, policy is the
> correct ground upon which to engage.

Actually, I think I should have said "shouldn't" instead of "can't".

I technically can (in the sense that nothing stops me from doing
'git am && git push' if I wanted to), so "can't" is not appropriate.

And I don't know what I'll do tomorrow, so "won't" is not appropriate
either; I always reserve the right to change my mind later.

However, as a guideline, I "shouldn't" merge stuff without understanding
it.  Sometimes there are reasons for doing so, such as not having
knowledgeable reviewers at hand, and not being knowledgeable myself.
In this specific case, we have Aleksa and Askar willing to help, which
is why I want to follow the policy.

> The practice of distinguishing mechanism from policy is a valuable skill
> in domains outside of software design where we most often speak of them.

Thanks for correcting me on this.

> It's even more important in the instant context to articulate matters of
> policy when a contributor indulges a passive-aggressive outburst like
> Luca's, above.  Confusion of mechanism with policy is the lever by which
> that sort of emotionalism operates; obviously we _could_ just do
> whatever a contributor wants without discussion and without
> interrogating the wisdom of doing so.

I was trying to be nice with Luca.  I think confronting his message,
which I agree was a bit passive-aggressive, can be counter-productive in
this case, where I'm interested in having him continue discussing this
matter with Aleksa and Askar.

And in the case of Luca, I have a story, which I should disclose for
context.

A year ago or so, I contributed (or tried to) to systemd, for my first
time, and I experienced what looked to me terrible project management.
<https://github.com/systemd/systemd/pull/35275>
<https://github.com/systemd/systemd/pull/35226>
We had a heated fight, and they banned me from systemd.  I didn't know
Luca before, nor any of the systemd maintainers.

After some time, and seeing Luca engage (aggressively) with other people
elsewhere (mostly, LWN), I have a theory, that Luca's aggressive
behavior might be related to receiving a lot of hate by his work in
systemd.  I still don't know if it's a cause or a consequence, though.

So, I wanted to show Luca the management style we're used to here, and
that a maintainer can be nice with contributors, even if they disagree.=20

Even if Luca has behaved in a way that I don't like elsewhere, I'd like
to give him the opportunity to be nice here.  And for that, I was ready
to indulge his previous message.

Luca, I still would like you to engage in discussion with Aleksa and
Askar to better understand this matter.  Please do so.  Taking some
extra time to fully understand it now, can help document this better,
and save many times that amount of time to other programmers.

Peace and love.  :)


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--4y27m3sj7qvjy3rw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjwyPsACgkQ64mZXMKQ
wqk+Mw//c02phs9bkKnnt1aR7YDepCQsc1NPOnUiaG3CHrcARz1/c1Qnl6bEYppO
Z7fDkFLnm/yKBjSTKCU75JdSj31KklKyMR3rzw3Lqj7YxELRwhiNx21YR6pERjSL
nn/UI1hGucCRJ7V12UJ8eC6/0T+HW/KNsxINriL+mTAVFkxoO/SI3gU890jmvhiZ
/xv2ofUrMJkRYLMr/g/kp2UcarolOLVeXLTsb3AatFg4M6lOKNGSbhPFv3gsmdk7
cjJtvRFP0LbD46IjCSbM8+aCfURkoD6G/Q/on8rhK3iaYHTyMzEiwjC3jtHFz679
Q8PTwxOFJ2k7bXYH6bwLGwmd7J679+4xW4o/I9xLlMMGNXEhyP68V8gxSQ7njY4y
2b8fIdcH3Nc6iYDInidlN2YAON8VGmkfBtw813BKRN2R8jQOgh5r4NwMErZb+oNH
FqBUoDPw311A/BJkwHZtUnqN8Y9kAUcYlk5ZGYk6AVjDSP9sBiV2a+58xNCAfiKh
t4kTaiuxngmpQawceAqDCYu4DnEXcfz1oy7jf4gVq0Zhly3Zbj8fjCzDaYjGVyFN
bsXxP3dhHUmokU1Y+XPybLmoyxBcQUj0C0FA2jpZkWwgiv9K+buGNOnm2CcRKjtk
uB1L9/4ench9jn7aUndP+Z8B8lOu4nlwaIQ06tfmgPCOC7VdR8I=
=bn4h
-----END PGP SIGNATURE-----

--4y27m3sj7qvjy3rw--

