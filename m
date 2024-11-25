Return-Path: <linux-fsdevel+bounces-35768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037E39D8366
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81D028675B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BFF192580;
	Mon, 25 Nov 2024 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxFJ6s2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F0185935;
	Mon, 25 Nov 2024 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530709; cv=none; b=Zf+iI95WeOBU1p+CiO/OiWheJ7srU1JHnYmT/syiy9+Ll4npaVBd7ckw0SsMoaw+oMpXx3wv0BaWGUuaNDYGJnfpSFHuLoCo5XZs9kzlz8ZCVm9QruHEwzsfp5C1A6tZ3AaGfBqzw9bEgz5B9ZbWuO/6GxHx2pn7v4o+0JaaiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530709; c=relaxed/simple;
	bh=eTfuv2LxBx6UZ5LgG369In0XkOLBybAubarRISlx7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHFlcnCRcJCX9SCVJw4I6+bERPM2bbvugMGTtNOicby6OgcDV8LOG4+VEBzgh9YUUFjakWhoFpnuXj/s7Z/FomVuLhNb/A8qB1EmT8kN5NtyB/d57mkuOrH8WJqsTUGzwqmdMGHoX+32mXoDAEBUWpl0vzEZZ+o0YGyFbxzRBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxFJ6s2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3898CC4CECE;
	Mon, 25 Nov 2024 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732530709;
	bh=eTfuv2LxBx6UZ5LgG369In0XkOLBybAubarRISlx7OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxFJ6s2yD9TxVkpmuK+/i+Bd8RNw8Y1etwo6+ma5u1RR9Uxf2QabUOuiAIeVogYQl
	 JCdKc7z7nJWhGBh2xH2JETPSFfprQdM0cktegn5k5xME9z7TbbIaWYW60oNLtmUNaH
	 eB6A4u2tcKAXpRPiOHegw9IjAjSuoLoTMKn7yiprLw1bcHldGqR2jj971YHJetFdV8
	 t4Ma4VXk0xwMdvqDrbzlfNxKLSK729v2wm8ZVVZbf4CxNMUKPdHGXApGh6JksLdQBq
	 lTbC3sLMCwyModXgipN5jhUYbHRajHZMKdTexqy91oXPyV1iGRDBosu+rsRP4lklJN
	 e0fGXj1C70Npw==
Date: Mon, 25 Nov 2024 11:31:46 +0100
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
Message-ID: <20241125103146.pqtapi3h5oizm3j7@devuan>
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
 <20240312021908.GC1182@sol.localdomain>
 <ZfRRaGMO2bngdFOs@debian>
 <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>
 <bjrixeb4yxanusxjn6w342bbpfp7vartr2hoo2n7ofwdbjztn4@dawohphne57h>
 <1d188d0e-d94d-4a49-ab88-23f6726b65c2@oracle.com>
 <7ljnlwwyvzfmfyl2uu726qvvawuedrnvg44jx75yeaeeyef63b@crgy3bn5w2nd>
 <20241124133515.cb7u64jccayt3deb@devuan>
 <aedc8625-a115-47b0-b3ab-1eec9653da42@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ieqyywgz6bssdk6w"
Content-Disposition: inline
In-Reply-To: <aedc8625-a115-47b0-b3ab-1eec9653da42@oracle.com>


--ieqyywgz6bssdk6w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
MIME-Version: 1.0

Hi John,

On Mon, Nov 25, 2024 at 09:03:50AM +0000, John Garry wrote:
> On 24/11/2024 13:35, Alejandro Colomar wrote:
> > Hi Kent, Eric, John,
> >=20
> > Thread: <https://lore.kernel.org/linux-man/20240311203221.2118219-1-ken=
t.overstreet@linux.dev/T/#u>
> >=20
> > I revisited this thread today and checked that there wasn't an updated
> > patch.  Would you like to send a revised version of the patch?
>=20
> Hi Alex,
>=20
> Wasn't this done in the following:

Ahh, true.  I cound't find it because it was in another thread.  That's
why I prefer that patch v2 is a reply to the same thread that sent patch
v1.  :-)  I'll have to document this in the CONTRIBUTING.d/* guidelines.

Thanks!

>=20
> commit d0621648b4b5a356e86cea23e842f2591461f0cf
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Thu Jun 20 13:00:17 2024 +0000
>=20
>    statx.2: Document STATX_SUBVOL
>=20
>    Document the new statx.stx_subvol field.
>=20
>    This would be clearer if we had a proper API for walking subvolumes th=
at
>    we could refer to, but that's still coming.
>=20
>    Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdeve=
l/20240308022914.196982-1-kent.overstreet@linux.dev/__;!!ACWV5N9M2RV99hQ!JY=
MR3Qwb11MmwlhEqgGhq3ITse9gIJ2sfyZQHyiVMQsb77VfyLGvmdLonkpcrGymbqfkUZE0DnYah=
WZPrc-vZG1rkIHW$
>=20
>    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>    [jpg: mention supported FSes and formatting improvements]
>    Signed-off-by: John Garry <john.g.garry@oracle.com>
>    Cc: Eric Biggers <ebiggers@kernel.org>
>    Cc: <linux-fsdevel@vger.kernel.org>
>    Message-ID: <20240620130017.2686511-1-john.g.garry@oracle.com>
>    Signed-off-by: Alejandro Colomar <alx@kernel.org>
>=20
> BTW, on another totally separate topic, there is nothing for this:
>=20
> https://lore.kernel.org/linux-fsdevel/f20a786f-156a-4772-8633-66518bd09a0=
2@oracle.com/
>=20
> right?

grep(1) seems to say you're right.

alx@devuan:~/src/linux/man-pages/man-pages/contrib$ grep -rn RWF_NOAPPEND
alx@devuan:~/src/linux/man-pages/man-pages/contrib$=20

I guess we should ping that thread.

Have a lovely day!
Alex

>=20
> Thanks,
> John

--=20
<https://www.alejandro-colomar.es/>

--ieqyywgz6bssdk6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdEUgsACgkQnowa+77/
2zLCBQ/9GzmXWOPC5wI8qOwL9S9DxsZlcM5Ry63ea7ZHgpoh5jJ3JauPpOoVL3aK
jWgbYkVjzsAZvtZrs+VaI6xA2Cg3IWtJAgNq7G+eMQYQ8+L+KgCADx9xa3h2Sajy
S9se1qfKaGwqYL8I4tUXI3K54rDrFA6ukvai1SYtEtgLymMkK3xl6gYKPYb4CUik
1q+gsQiZKiAM11ZFeIXfF2FBIU2gpqSpsh9feRT8oaqP0MpphMl6FEbX8G/DDZwk
geTloDDvcgs+NlXj0lVeFWcsr/aT2cQXzBsiCCep9tqSUpdlQ0mVUohy5+gN6NZ+
KHwQCuiX/ZRdEwehTe4sDcUUnk8oi0GOlnCfTMPFk2YaNCgiCSC1oDaKfS9Zls3g
buG5NTSklk8PxGTtTCnJmWMsnYdF1fz9xl27bRrznaL2GrUJZ5IeMkRNln5301j5
HmEu2F+gesdEhR98WtgEIKPhKeWlLEs3hDgrSMZmRbXvCjbkSmiVWAgZSBHF0FzG
hG4zA+kfFJllDw7/AeoPOr6JbkvCrkl65eB50AzkGZMquVLmpyFm6CthoZmtWuTv
62ekuLZdxsjcsp5LQs4oT16upsjw79Rox9gzHyJOCMK4jxUi4duYmKgqlvAcXU+S
E5pJsxtrwGac/mE9uHLKcHwhhSN5dbF3XbhcyaJUQV5nI/MQjWU=
=8VQu
-----END PGP SIGNATURE-----

--ieqyywgz6bssdk6w--

