Return-Path: <linux-fsdevel+bounces-22626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 899EA91A70B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFCA8B28351
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FD17E46A;
	Thu, 27 Jun 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqbf4MM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575317BB21;
	Thu, 27 Jun 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492932; cv=none; b=HwR9eLRbF0QA2Vh8CQ1EkqY1zw9gGXj3nm58sxtAE4Zwp4LbPn/zFGwzA31aZ/YBDAXsghgi31udeKETLuVgl2IYBesxZNkbvgkaH+ltvgvSAbX92mt9HKJqt936q5V0N3wwwlnPMbYTubOsHi3R9RpiNPe3RALBi8A4v3jU834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492932; c=relaxed/simple;
	bh=hijuL27/WjufvRwRY9t/S2jvAjjTAQygAC6Xv48jRFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSDpslAjycWjr1WiINgeWXF64eV+6hVPDR7WYmM3hOXfFTOWW4G90PDdFHRV8+8p7Ittnmp0QJOq87dTObhJfaIrXdQaHzCRQtyxvDVEvJ/yQLWQIeyc77VLMjjVB/YplhNw9X/1D80EHJceGPA83pUGPulocfItxtNgHXwzbhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqbf4MM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDBCC2BBFC;
	Thu, 27 Jun 2024 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719492930;
	bh=hijuL27/WjufvRwRY9t/S2jvAjjTAQygAC6Xv48jRFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nqbf4MM7h/4SBTTWk69v9TNQOr5L/Khw/8CPrsJ8TuIxo2uIewtRFZQw+CibgcrBw
	 Ua0BqSWCCXaftFHdtsSQdl2EfB0oJiFWiXZP0gb1YiI0pe9pEX5gguA99CpsEHiD+o
	 VAtI/LlMsOI5fYMVNrpnFyAzL1Ri4SaeytLya2epIiCy2p+TGx9YpVpNn1wLLSrP8E
	 L8aPMfwXrcwhnKzGVxHpqh5pgzB6G0DMIizysxU7FSvq3kMk8fF8x81hRwp4kLht/9
	 ZMpRvgVR5491HiWGImwx6fwhEu405Xzs90D1a6wUlQ7gj8Me5bFejKCCGhDzzxJshp
	 qN5jKusz2vWtA==
Date: Thu, 27 Jun 2024 14:55:27 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ebiggers@kernel.org, kent.overstreet@linux.dev
Subject: Re: [PATCH v2] statx.2: Document STATX_SUBVOL
Message-ID: <qxw4tx7k5n7stolsmchdtpvbr6xws5g4ivaecql33ywr7wfdo7@fogsp4m6dvct>
References: <20240620130017.2686511-1-john.g.garry@oracle.com>
 <4332d711-81e4-43ba-9cf9-cd4db9701499@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dqglqzhdudjr47mu"
Content-Disposition: inline
In-Reply-To: <4332d711-81e4-43ba-9cf9-cd4db9701499@oracle.com>


--dqglqzhdudjr47mu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ebiggers@kernel.org, kent.overstreet@linux.dev
Subject: Re: [PATCH v2] statx.2: Document STATX_SUBVOL
References: <20240620130017.2686511-1-john.g.garry@oracle.com>
 <4332d711-81e4-43ba-9cf9-cd4db9701499@oracle.com>
MIME-Version: 1.0
In-Reply-To: <4332d711-81e4-43ba-9cf9-cd4db9701499@oracle.com>

On Thu, Jun 27, 2024 at 01:05:38PM GMT, John Garry wrote:
> On 20/06/2024 14:00, John Garry wrote:

Hi John,

> Hi Alex,
>=20
> Is there anything else required to get this picked up?
>=20
> I have some more dependent changes waiting.

No; I'll try to review it tonight or tomorrow.  Thanks for the ping!
I'm doing many things these days, and forgot about this patch.

Have a lovely day!
Alex

>=20
> Thanks
>=20
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >=20
> > Document the new statx.stx_subvol field.
> >=20
> > This would be clearer if we had a proper API for walking subvolumes that
> > we could refer to, but that's still coming.
> >=20
> > Link: https://lore.kernel.org/linux-fsdevel/20240308022914.196982-1-ken=
t.overstreet@linux.dev/
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > [jpg: mention supported FSes and formatting improvements]
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> > I am just sending a new version as I want to post more statx updates
> > which are newer than stx_subvol.
> > diff --git a/man/man2/statx.2 b/man/man2/statx.2
> > index 0dcf7e20b..5b17d9afe 100644
> > --- a/man/man2/statx.2
> > +++ b/man/man2/statx.2
> > @@ -68,6 +68,8 @@ struct statx {
> >       /* Direct I/O alignment restrictions */
> >       __u32 stx_dio_mem_align;
> >       __u32 stx_dio_offset_align;
> > +\&
> > +    __u64 stx_subvol;      /* Subvolume identifier */
> >   };
> >   .EE
> >   .in
> > @@ -255,6 +257,8 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTI=
ME.
> >   STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> >   STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
> >   	(since Linux 6.1; support varies by filesystem)
> > +STATX_SUBVOL	Want stx_subvol
> > +	(since Linux 6.10; support varies by filesystem)
> >   .TE
> >   .in
> >   .P
> > @@ -439,6 +443,14 @@ or 0 if direct I/O is not supported on this file.
> >   This will only be nonzero if
> >   .I stx_dio_mem_align
> >   is nonzero, and vice versa.
> > +.TP
> > +.I stx_subvol
> > +Subvolume number of the current file.
> > +.IP
> > +Subvolumes are fancy directories,
> > +i.e. they form a tree structure that may be walked recursively.
> > +Support varies by filesystem;
> > +it is supported by bcachefs and btrfs since Linux 6.10.
> >   .P
> >   For further information on the above fields, see
> >   .BR inode (7).
>=20

--=20
<https://www.alejandro-colomar.es/>

--dqglqzhdudjr47mu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ9YT4ACgkQnowa+77/
2zKuBw/+JK4WxQg/DwbkZsHaOnLMtYh/eVkcm7pyXlG+3c59WU3JHn7U9eVYJBgi
AVPs1DEE972ltMAWSofwS2Mm4v8Zk4YROiLORAh9aDIoKTSW3An2hsMpDitiHmdy
MyX/NYmv7Hf8kYFB/gIT7oSG4sz/WnpgevCfnWJkRShb2/ibioszlrT+Wj1QOb/9
hUViAeA6ftY5gruoyaUCkMH9aM77mD8ODNy5bOlgHFlid2OWzu4bfAbDxDnyWUvu
HarUxJw0I7Q5A3CrMTMsIw2pIttMwzGOB0W2J9yC0ys3rduzF2caMEyZ0Kbjq0Fp
SDCCyTb4UlkmNhE9ZrGBQyUeicDorkJO5voPbIpMlc4hqWObftSNBpESDDCB/fqx
0Em58U+zegS+oqGtikSdIVqri9AsktemBeFWGZdPJa/5TLuVOO/PUnTn8PTI7VGr
+yEvrftANOxKU88M1UWa/gjP+KUFdvjt+VnDrRxK7M3+1Ims5SkMwxdU/wI9F4jc
gcn8lZVtkpVT+GQZJClQ8YmQ5EWPgRULu7b+NMDYDuBdfqtTSMdau8hhEp+mCNnA
oD89RWSXUl88/Yi469UzLJS9EZjbI7x0eLRvtWJ1lH5YLz1bRduJ3v59bnuofIEH
tuP0xAEynMDtFPL3u/J3pxKxoB0mcPutnydr3q0A1jnns0+HFZA=
=HeYv
-----END PGP SIGNATURE-----

--dqglqzhdudjr47mu--

