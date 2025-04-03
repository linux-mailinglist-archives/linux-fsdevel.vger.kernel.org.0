Return-Path: <linux-fsdevel+bounces-45703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0889A7B04D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5033B188AE03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F351FBC91;
	Thu,  3 Apr 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb6sS82k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08721A3165;
	Thu,  3 Apr 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712211; cv=none; b=OHpXCqciivQYiLRGwCuWzFdRz2KbolamE17VTNOwnnhpyorVMV/Hu5q/32U7ZoUZpmCVvSh2QDoqyUeJVBxGub43PGdroPzIWywzc3F39X9lhOgsEKwLenJpO/I4uG4pWsiUBYgn8Ai6d4eFbykeJJngLPHDCcmap7dfE73iV18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712211; c=relaxed/simple;
	bh=dSUufpWGsZo8kKRe250n+avTILUZ8xKwJiDS0Mzm0s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Webbqq+N8YzL+Xq/Beme1fkQhCRd6mH/QwvBq0sl0sSwBjmELjld5D/7dKowqCLdkW9HXc0TWvbDgJF46+FnrzPEk2/lwPTbg/SiutIVPTkUGTx9INCIVTfCcmNaxW10+Hqi3c/bLPyF8Ba3xYXfMlNRs1qTKzogelAP5KvM0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb6sS82k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE80C4CEE3;
	Thu,  3 Apr 2025 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743712210;
	bh=dSUufpWGsZo8kKRe250n+avTILUZ8xKwJiDS0Mzm0s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kb6sS82kiURJ1rACcVtjeMUeyJuOvB+JCKshKjp4Hx5lcusF6ZV4D9zlJ0Lhz677/
	 wVVZgW3gDwAgQjWHTbI0xUYLqk5w735rB42AZrttH+r6T51iH7WB7WhCZQxOabefT3
	 YmW0eovGbN8b8pTXMcOSP/PglQrDIscMZJXuUgzPYyK1ZVqOAwYW2Q8kKv9dPTbPqd
	 VYuXyKHthB1k7nEV1gwxcPTTEz32vOlnArGUnEGbG7Ee3wrBxzlOM53tlusDV6pzFb
	 M1hZa7XLyKlzFImVGRrXasSOrJL2xOyBZydWPASVQvwFlI8fDKCa04n/4skREKlSSN
	 DUl9hOz6NDt4A==
Date: Thu, 3 Apr 2025 22:30:06 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: Document mount namespace events
Message-ID: <ct7rqcfzokfa4a4ouqc3pnqfq2jqodsmae3bq23s5nuvsbhp6y@ba7h2bdwo35p>
References: <20250401194629.1535477-1-amir73il@gmail.com>
 <6gjqzfp252aiv6jqsw4tv2gbz7r6cjuiitkv4uzucpl2eotw3s@fmwqa26bjaco>
 <CAOQ4uxjOzFzdp-mkzGJAgHSBmSfdUpVJ+4Y1i1BHAq+dCJkQmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2dh2sbliwm7aulvj"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjOzFzdp-mkzGJAgHSBmSfdUpVJ+4Y1i1BHAq+dCJkQmw@mail.gmail.com>


--2dh2sbliwm7aulvj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: Document mount namespace events
References: <20250401194629.1535477-1-amir73il@gmail.com>
 <6gjqzfp252aiv6jqsw4tv2gbz7r6cjuiitkv4uzucpl2eotw3s@fmwqa26bjaco>
 <CAOQ4uxjOzFzdp-mkzGJAgHSBmSfdUpVJ+4Y1i1BHAq+dCJkQmw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjOzFzdp-mkzGJAgHSBmSfdUpVJ+4Y1i1BHAq+dCJkQmw@mail.gmail.com>

Hi Amir,

On Thu, Apr 03, 2025 at 02:23:10PM +0200, Amir Goldstein wrote:
> > > diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> > > index 699b6f054..26289c496 100644
> > > --- a/man/man2/fanotify_init.2
> > > +++ b/man/man2/fanotify_init.2
> > > @@ -330,6 +330,26 @@ that the directory entry is referring to.
> > >  This is a synonym for
> > >  .RB ( FAN_REPORT_DFID_NAME | FAN_REPORT_FID | FAN_REPORT_TARGET_FID =
).
>=20
> See here
>=20
> > >  .TP
> > > +.BR FAN_REPORT_MNT " (since Linux 6.14)"
> > > +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> > > +This value allows the receipt of events which contain additional inf=
ormation
> > > +about the underlying mount correlated to an event.
> > > +An additional record of type
> > > +.B FAN_EVENT_INFO_TYPE_MNT
> > > +encapsulates the information about the mount and is included alongsi=
de the
> > > +generic event metadata structure.
> > > +The use of
> > > +.BR FAN_CLASS_CONTENT ,
> > > +.BR FAN_CLASS_PRE_CONTENT,
> > > +or any of the
> > > +.B FAN_REPORT_DFID_NAME_TARGET
> >
> > What do you mean by any of the flags?  Is _NAME_ a placeholder?  If so,
> > the placeholder should be in italics:
> >
> >         .BI FOO_ placeholder _BAR
>=20
> FAN_REPORT_DFID_NAME_TARGET is a macro for combination
> of flags (see above)

Makes sense.

>=20
> None of those flags are allowed together with FAN_REPORT_MNT


> > s/BR/B/
> >
>=20
> Fixed all.
>=20
> Let me know if you are happy with my clarification on
> FAN_REPORT_DFID_NAME_TARGET

Yep, please go ahead.  Thanks!


Have a lovely night!
Alex

>=20
> and I will post v3.
>=20
> Thanks,
> Amir.

--=20
<https://www.alejandro-colomar.es/>
<https://www.alejandro-colomar.es:8443/>
<http://www.alejandro-colomar.es:8080/>

--2dh2sbliwm7aulvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfu78cACgkQ64mZXMKQ
wqlUfA/9EAU4Um/xsBOhuN0vHLANHDKo6vQ/E0S9Bzhf8ixYZ9v09usIoTAAdNzV
nxqELtd8kVuDkFu9P6OFGIP49jFXhgcT6P48bRSjC1aOPzQLSDXfX67MkMLGemjZ
3oD+dpHGKIq4m5iOE0M1ZOuYgX3LiouTnQqMF48dVocdNGqWtV4P5IjEVEKOwQjt
F+Y/wXwfGMaA6CjDDpq5sr2T2s7lNBWNi3oDCebChH6yL6jrnjivDovR0ZOJeEgE
eYeNDA2xcza5CC3Xc95icElyyKjiDVxX0dOtaGyx/X4ARMr3hi2LtWaApkY5ZR8H
zq2Mwbt+bYkOTKwz6sqT1WaZ8aqbBTk+jELlNypV1IZs6lgREE3y4dp427ccUfiD
diiJ+m3Ys14rFikZZClOdo9JW/DPZpVYo08aj2VjjB8I7EYLnlVr6sRG0du1q1NI
VfZtszy0wM71i6i7GiPe7mRkd77rL9ApZ0tuGD6lMDVM+iksjwuAxFuhyUpQbsU9
PvCi+0pFPW2zFt22sYuYV/Akr0qe6el/LVLnyFiSEO5Bydp3qq7owphLEv/sjsLi
KBBuC9e2EAvHjrt9Gm03LahlmGhYdA5IOtYsb5bT2kI2bdg2w2Zl0cgAF8+Qbjab
RekoTgwm5IOF6nWLjPmROcxFO+QCL2pBxe7LmfMo9WawrC/syuk=
=mYAX
-----END PGP SIGNATURE-----

--2dh2sbliwm7aulvj--

