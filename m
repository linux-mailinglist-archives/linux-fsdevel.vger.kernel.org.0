Return-Path: <linux-fsdevel+bounces-45306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104AA75BE6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 21:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A9B166ECB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A281DC046;
	Sun, 30 Mar 2025 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRJoVu3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1780C02;
	Sun, 30 Mar 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743362472; cv=none; b=mFQtR34Y6SNMFD5P++rstzXr0aVo0czL9vRSScCcK7dYPrjE1tkdrxCdfUoLz3yDVPlDNA3pD12CzvMG4Zbk6uEKRzbCMnJMRbbKPrH+2RNNxnlptDQ+qqet1jKEoREsrEy1jjooLf2yKrLAVrbJB+/YTn8tRTCq+jC7K9cqr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743362472; c=relaxed/simple;
	bh=fRh1n733+fnnlBOjs18gAeRa/FnY9qSV0Dxz8Zd1Wbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvgiGBiGT7xNlPiGWs+ze4NSVH2SgTrlTzvMACgGVaMrKnyJA5C301aBy5mj5if9GbBxnBQQ+XeJgknM/6TLlHxcDzkTCASJwhmb9y1IAom0muFeobbDSf1kozIjGwSTxEek0z5F67Eb+ermPSw1SMEvUjaRfwQb+Y5TitpS4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRJoVu3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7255C4CEDD;
	Sun, 30 Mar 2025 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743362471;
	bh=fRh1n733+fnnlBOjs18gAeRa/FnY9qSV0Dxz8Zd1Wbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRJoVu3lIg4aI/zMyT6/57bzFWJIx6bHeYuYafkt1twQlScQvO3QOOyQuM9phR3wU
	 1fVtpue2xSFlZU0tgSIBhAmgZn+n3QXP5hSVNa8vqzaaow3xNIkIQgcI+lSz/vSofI
	 FkWPtpYMnJDkvlcSqJw6QjEd/ckJ54iapw9zP15JRE7GO+0mLWeEIxqZuSck3gm3qJ
	 Dultd0Q4ukGnCf5LZv7JRcQTvBlcfjVm+0I2lu1ogXlS2BY+hUaIJ/m2HkR1TE2gOS
	 wzjBDQHXmVyRvF3paDL+t3utoTrRp+X0wr+As0RxREAbL6fWAs5xJM5QZpHeYGezfT
	 jRhMsGfTTscTA==
Date: Sun, 30 Mar 2025 21:21:07 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@poochiereds.net>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2] name_to_handle_at.2: Document the
 AT_HANDLE_CONNECTABLE flag
Message-ID: <esepirxum5w6k3au4fapm6sksjy6bl5ypapvy5rflmqw2g3cjv@iij2nzq7i3uk>
References: <20250330163502.1415011-1-amir73il@gmail.com>
 <mu6nhfyv77ptgvsvr6n23dc5if3sr6ymjmv3bq7bfnvcas66nu@b7nrofzezhil>
 <CAOQ4uxj48SHB+8m0r50YhdqYZB2964+aK=BxdoW_yuWzZUgzGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z7m2cmnlnnznmxep"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj48SHB+8m0r50YhdqYZB2964+aK=BxdoW_yuWzZUgzGw@mail.gmail.com>


--z7m2cmnlnnznmxep
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@poochiereds.net>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2] name_to_handle_at.2: Document the
 AT_HANDLE_CONNECTABLE flag
References: <20250330163502.1415011-1-amir73il@gmail.com>
 <mu6nhfyv77ptgvsvr6n23dc5if3sr6ymjmv3bq7bfnvcas66nu@b7nrofzezhil>
 <CAOQ4uxj48SHB+8m0r50YhdqYZB2964+aK=BxdoW_yuWzZUgzGw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxj48SHB+8m0r50YhdqYZB2964+aK=BxdoW_yuWzZUgzGw@mail.gmail.com>

Hi Amir,

On Sun, Mar 30, 2025 at 09:17:51PM +0200, Amir Goldstein wrote:
> On Sun, Mar 30, 2025 at 7:56=E2=80=AFPM Alejandro Colomar <alx@kernel.org=
> wrote:
> >
> > Hi Amir,
> >
> > On Sun, Mar 30, 2025 at 06:35:02PM +0200, Amir Goldstein wrote:
> > > A flag since v6.13 to indicate that the requested file_handle is
> > > intended to be used for open_by_handle_at(2) to obtain an open file
> > > with a known path.
> > >
> > > Cc: Chuck Lever <chuck.lever@oracle.com>
> > > Cc: Jeff Layton <jlayton@poochiereds.net>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Alejandro,
> > >
> > > Addressed your comments from v1 and added missing documentation for
> > > AT_HANDLE_MNT_ID_UNIQUE from v6.12.
> >
> > Please split AT_HANDLE_MNT_ID_UNIQUE into a separate patch, possibly in
> > the same patch set.  Other than that, it LGTM.  Thanks!
> >
>=20
> I pushed the separate patches to
> https://github.com/amir73il/man-pages/commits/connectable-fh/
>=20
> Do you mind taking them from there?
>=20
> Most of the reviewers that I CC-ed would care about the text
> of the man page and less about formatting and patch separation,
> and I would rather not spam the reviewers more than have to,
> but if you insist, I can post the patches.

Could you please send with git-send-email(1) --suppress-cc=3Dall?


Cheers,
Alex

>=20
> Thanks,
> Amir.

--=20
<https://www.alejandro-colomar.es/>

--z7m2cmnlnnznmxep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfpmZwACgkQ64mZXMKQ
wqmPBxAAtx+dnnjlgwAY8W4i/a3lEExpUwyoATae7fT3i5N4Bh1WSllY38T3icCu
8JaFZvmZ8tFwXWlQTFH5iiJHHFaAXV8ltrMt9RL+bZ8T6UGF8o1yL08HrR5fwtqb
4ANC0m8NsGWmt06IlGhCaDZD9o0cYgFqVy9tByiwVoJwQYLycoGjmJTTCeSOQTUN
RDjfk9z0Kf8HiU0WaTX8/deo6Vfv5OdurD6XW4uKe4VjEiKOVdvIBgUs2BXtieG1
hYgD8i2rM76SNDTkzONSbx+gAPh0hkB6NSzU4+iZ3QBbdyTi79DZu8FtTLikPcdc
ag9vC/TdFxivq14tVGzUgHtz955l9GhqDKmAIybrx/Ki78SyedfUEG6jUxPmwrRu
7XOw1reSU47aBvdhQskr7yi/NQWktAYxhw3IN2Pdj7WUYZZKtl6hBHWSvasyZN8R
yZgApzPgGcv5AFWmDwFUwFaRdmI+Vgp2t6cCF1iF+XJQsEc4Z6SGUv+TGCWE3OBh
OJwF1WUjvFTwu9GucsoIXPkREGT5cqte+3rR5LtTpbb1P44XTlJlvC0fRBgotwpX
w1bDkYyJxe2WU10o4f2iV3TVOUkxvROC4at5qVcc7bPaB00yq9Sd9/1S/UMbqh1/
LKVVsyX4i/RdH6xfGjCHmIIdCX//bmvAdvqCGMM1e5ngSZ7XA7M=
=QvrJ
-----END PGP SIGNATURE-----

--z7m2cmnlnnznmxep--

