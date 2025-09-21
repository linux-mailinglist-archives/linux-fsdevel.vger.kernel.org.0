Return-Path: <linux-fsdevel+bounces-62343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A515EB8DD4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 17:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69ADC1793E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7361DE2A7;
	Sun, 21 Sep 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/qP71uH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AEF846F;
	Sun, 21 Sep 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467848; cv=none; b=PSIjQ+y+ZzGGtmTAMIGVaoCmKRBUsnhQ0e2dF2B9a+pa53mswBhlU9Jdz2oy92LiCs8TNNrbrYk2SyrmbeNXM1rBcAiZb0+2lmZkBAMn0KNOaC7+xY/7LBgqnfPwDWdOsvhfv+FrsdSd73NpUUL176OCPfDe80ajNzdldGo2KbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467848; c=relaxed/simple;
	bh=wB6t+PXCW9xWp0M7SlgE39OvB5IKHEMkH6szH1iq7o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUNMZuo9Daw+iGncvqzwjWsGmYFc7UpafZl5lu54T5/WxUY5jWj+3ObhNnZx4/9ZljmlcDcoOzC+24Qlph+NnTcIgem3+TbCi11nCQ3EyyeAw4NrwDZ9tVYSr/CYPPdu6tX6uamUX6SSOX+URPpKU3yi4vP467f/KOlHNNO6IXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/qP71uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BA3C4CEE7;
	Sun, 21 Sep 2025 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758467848;
	bh=wB6t+PXCW9xWp0M7SlgE39OvB5IKHEMkH6szH1iq7o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/qP71uH939/px8WS9ORSXfpsmn6bSVJSbLh8vMm3hYpGip1hxDmk14qjfpymPFeV
	 gtXzDCZwDXo1kElLvYuU07on20lScurvRvB7bNq4k8RhMxmaxAVpiUWe1t9djd+bkG
	 LqW9CcE3TSMQMjThx+OAwYMpMAhAA9Q4HjWhFDPqHc/GShQFerZ7lyszwao5d2VP01
	 yw1/QKjTZ8V5vNUwUg8ezLxxZ+vcOGpi1lCL5F5Dh5LbQq7BVZMUhwF4ORkf73/LOB
	 TPVNaCVDt3r275sm4Vl12OoM1rKEBh3SKiEWd2xeqZ9x1bdUadV5+5mWBWLpe3ms/x
	 aajlUckXAyiCg==
Date: Sun, 21 Sep 2025 17:17:20 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 03/10] man/man2/fspick.2: document "new" mount API
Message-ID: <5mty7i4v7ygpbedhjevg2fvdlm26rmxeatar7a2u675ulacfyh@ljjjc4za4nl6>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
 <y77zyujsduf5furdf2biphuszil63kftb44cs74ed2d2hf2gdr@hci7mzt6yh7b>
 <2025-09-21-petite-busy-mucus-rite-01PHer@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uoobs7joup3kfhd6"
Content-Disposition: inline
In-Reply-To: <2025-09-21-petite-busy-mucus-rite-01PHer@cyphar.com>


--uoobs7joup3kfhd6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 03/10] man/man2/fspick.2: document "new" mount API
Message-ID: <5mty7i4v7ygpbedhjevg2fvdlm26rmxeatar7a2u675ulacfyh@ljjjc4za4nl6>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-3-1261201ab562@cyphar.com>
 <y77zyujsduf5furdf2biphuszil63kftb44cs74ed2d2hf2gdr@hci7mzt6yh7b>
 <2025-09-21-petite-busy-mucus-rite-01PHer@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-09-21-petite-busy-mucus-rite-01PHer@cyphar.com>

Hi Aleksa,

On Mon, Sep 22, 2025 at 12:55:13AM +1000, Aleksa Sarai wrote:
> > This should use '.B. (Bold).  BR means alternating Bold and Roman, but
> > this only has one token, so it can't alternate.
> >=20
> > If you run `make -R build-catman-troff`, this will trigger a diagnostic:
> >=20
> > 	an.tmac: <page>:<line>: style: .BR expects at least 2 arguments, got 1
>=20
> Grr, I thought I fixed all of these. I must've changed it in a rework
> and forgot to fix it.

No problem; mistakes happen.  :)

> > > +Please note that\[em]in contrast to
> > > +the behaviour of
> > > +.B MS_REMOUNT
> > > +with
> > > +.BR mount (2)\[em] fspick ()
> >=20
> > Only have one important keyword per macro call.  In this case, I prefer
> > em dashes to only be attached to one side, as if they were parentheses,
> > so we don't need any tricks:
> >=20
> > 	Please note that
> > 	\[em]in contrast to
> > 	...
> > 	.BR mount (2)\[em]
> > 	.BR fspick ()
>=20
> Based on my testing, doing it that way adds whitespace to one side of
> the em dash

You're correct; this adds whitespace on one side of the em dash.

> and typographically em dashes should not have whitespace on
> either side AFAIK.

This rule differs for different style guides, and different languages.
In Spanish, the most common style is having spaces as if the dashes
were parentheses; very much in a logical style, like quotes not having
extraneous punctuation inside them.

I very much prefer the Spanish conventions, and dislike the more common
used conventions for English.  I don't know if Branden can illustrate us
with some history about em dashes.

> If there is a way to get the layout right without
> breaking the "one macro per line" rule, I'd love to know! :D

There's a way.  I'll show it just for your curiosity.  :D


	.BR mount (2)\[em]\c
	.BR fspick ()

(I hope it works, because I haven't tested it.  Accidental typos might
 break my untested examples.)  :)


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--uoobs7joup3kfhd6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjQFwAACgkQ64mZXMKQ
wqkV5w/9GcRWolkmcFLp9q+F29lEA747+yi0l2yW0atOOQNVEFNbVX5o1+S7jZDH
RS2pTsM9YAhA4i4RgxMBMYOtNcDB+mdqX2kjMNkORoMqxC1ePROibQz2MQCuJlJp
Ok8OA3M/5NrctrshMfuMRf0weY+BJWIMfryhMz5zYByXQW6Gi6RMubBCs1Awc8It
PYpueQJpIk18PZ1Jpxf4RR2FUidcNNJ/QR6ETW63COgBYoByZuAnm7guSHWdi1wQ
r0f9rAXwO2ll3FcgRo0f3YJIARx/Xk4Kto03B8YZ903llyNlhsFcBqqQsKnIKmxl
dDuj92J04t3dNhST4H5X4cuFwsHJjDND43OVfwAWi4lmE0p7uMXWVfxMhYFqFg8J
4J/l0v7HcJ//aZ1qR1MCskp8++YUUE7RlGxsvwTlVKSxtSJ7NLS5X2fCUCCo92aJ
6NfilDOr54bqz59ks06SX0sAoiXIuPZ5SN2Wpa7WYD1B4N4HWkEmQssiMCa0hJi9
fYkCs613XPasoqJLYewClhekxmeTVk6/d1rWb5kNcoPUmw8SynE6Ui9qQaNyqCgX
/kU6XyAtMqvILhHQ7Df9+KxILEHxOa6GLLG+Pyc+hDHbfIhM/JUTkOxPohNGw+ut
AoRyXT70bkFOaa2T8dxOR+AEarlP6ec7Tla9kG9CSZSDPLyvMNk=
=WeB5
-----END PGP SIGNATURE-----

--uoobs7joup3kfhd6--

