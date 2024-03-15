Return-Path: <linux-fsdevel+bounces-14456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E94887CE3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840E2B21DD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0154B2CCAD;
	Fri, 15 Mar 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3olND42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F224A13;
	Fri, 15 Mar 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510444; cv=none; b=noTd8Q+djTkbgJyCkCABwz3rwZlqD5WCHMQljftfKM9wFx+E09BcvhYtEFbvU00hU+qNfK96KMa8jhwJWYq8SNSkjYaVc7fRa9oOM4CfkPnOvVFrDL9uLCT0Nhj2sSeDY7jf0z0LmECSI9TTRk/3oUXXlrxvnyZ5vhqQAdUQcPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510444; c=relaxed/simple;
	bh=WZKSCm4I1cJxUT1dB7anQ5dQ3CQgP62hCCuNX0RFUDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRZsuWWNrkttKQs5Mp7kaZZBzqV4+SMSkFqYfpfei9dSGX/SYHjouH9qpikFmIn3O7ETlsFP5cUcEATnQklzH7Fq9fAnUK1n2M9u0bejCWxpYgWRbog5HB2/aeLWyRbrwkXVIL5r0XPVZDR51hi9R5IfgQlVLHTP/5kYe29MOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3olND42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4B3C433F1;
	Fri, 15 Mar 2024 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710510444;
	bh=WZKSCm4I1cJxUT1dB7anQ5dQ3CQgP62hCCuNX0RFUDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3olND42NPRr7GHVTiRFmHwiT3COsI3pTwBkQG26HWOMmopGetI5qDXTUL42msVNk
	 g5Tg0/Tj356EXwKOGuQtJZSvCkBh2OKWQ+G2HSYec2A3tVMPBdNpS4i/1XAXseFmHO
	 eEWa06NoA4tHWncP2L8AAyN7FPIBwpRpv2hvDyDUY1UqM+cK+dBJj5TZJJuuh3X5xA
	 8WjROsoT4GewQGAEk57Op1nGRxpXcG0fAidsOTYf3fUSo27gdwP2RmzkTnSOJmiLsL
	 LC1LSJJiPo2l7k3ai69x40o1Q7F4rv/TCuuHq7qV7d7Xwwk63QA7ExScfvF9+RavK2
	 SXpFy3iS0OlIA==
Date: Fri, 15 Mar 2024 14:47:20 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
Message-ID: <ZfRRaGMO2bngdFOs@debian>
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
 <20240312021908.GC1182@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1SBjcjs/NEOtcOiI"
Content-Disposition: inline
In-Reply-To: <20240312021908.GC1182@sol.localdomain>


--1SBjcjs/NEOtcOiI
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Mar 2024 14:47:20 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL

Hi!

On Mon, Mar 11, 2024 at 07:19:08PM -0700, Eric Biggers wrote:
> On Mon, Mar 11, 2024 at 04:31:36PM -0400, Kent Overstreet wrote:
> > Document the new statxt.stx_subvol field.
> >=20
> > This would be clearer if we had a proper API for walking subvolumes that
> > we could refer to, but that's still coming.
> >=20
> > Link: https://lore.kernel.org/linux-fsdevel/20240308022914.196982-1-ken=
t.overstreet@linux.dev/
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Alejandro Colomar <alx@kernel.org>
> > Cc: linux-man@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > ---
> >  man2/statx.2 | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/man2/statx.2 b/man2/statx.2
> > index 0dcf7e20bb1f..480e69b46a89 100644
> > --- a/man2/statx.2
> > +++ b/man2/statx.2
> > @@ -68,6 +68,7 @@ struct statx {
> >      /* Direct I/O alignment restrictions */
> >      __u32 stx_dio_mem_align;
> >      __u32 stx_dio_offset_align;
> > +    __u64 stx_subvol;      /* Subvolume identifier */
> >  };
> >  .EE
> >  .in
> > @@ -255,6 +256,8 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTI=
ME.
> >  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> >  STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
> >  	(since Linux 6.1; support varies by filesystem)
> > +STATX_SUBVOL	Wants stx_subvol
> > +	(since Linux 6.9; support varies by filesystem)
>=20
> The other ones say "Want", not "Wants".
>=20
> > +.TP
> > +.I stx_subvolume
>=20
> It's stx_subvol, not stx_subvolume.
>=20
> > +Subvolume number of the current file.
> > +

Also, don't use blank lines.  We use '.P' for new paragraphs.

> > +Subvolumes are fancy directories, i.e. they form a tree structure that=
 may be walked recursively.

And please use semantic newlines (see man-pages(7)).

Have a lovely day!
Alex

>=20
> How about documenting which filesystems support it?
>=20
> - Eric
>=20

--=20
<https://www.alejandro-colomar.es/>

--1SBjcjs/NEOtcOiI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX0UWgACgkQnowa+77/
2zJzvBAAqD0ofioGqo0fyumCr5QI1S5cvYiS+Mv5DaMiwKBuATfdJRro74XSKs5P
gGKM9vObAexpA9uuAlRXtrxSMdm1U5c9lnVnRy0iJSN0hMPwK1+A1oaMhxwPwNQD
DpXl3FvxioeK9gWKUhNzvCAJFBCBrcCec9FQi5OBK5vqKyfLhs/FlGvg8xosKHP4
vmsLEtnv7tGD4R7+mFPSKm2WnchFf7UsrEkBi2aYbQW6+HpV3n1SMx0SpXswA0v4
jgIakuH1naEWipkf1MhRnEELkzOPLV/rk4gqBV6mPWdcG/PahpynMuYeqqSUN2GP
k3YpRcCbDD+6/qr7YcmubBfJAOXvPuGIyvkyL+wnb6/T7f/39p2iglUqlH/khCHa
TvpuJD71MLoezA2knRgW+f3mKy4iJEjwmSAMCQ9TTDIUADU6LoXe+ZcubqUNbtfx
MYUFBSu+XRMAEWYjr2NwSk99sjKgW2Rfd6xlphCJpVOHTZTGQsKxWGUvI7vaAelW
EtpT0fFpepvrJTzfA4WCfY1MbnVv/Mg7hPrfcUNdxiXQj+Tv9xyDfVqsERX5MhQh
hiVUZjKa8lhavzS6vspKWQNsFvWTnkKkVQe0uO9kyZG7t+EavXrhd5tjwvhw4ujq
L8gCRygbqR8Pl5zJQ2ocrad77myRmI8+TogU1rZhn4PC40ppf84=
=CpTm
-----END PGP SIGNATURE-----

--1SBjcjs/NEOtcOiI--

