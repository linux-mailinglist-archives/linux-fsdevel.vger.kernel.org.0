Return-Path: <linux-fsdevel+bounces-62336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7CB8D90E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 11:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A4A1799EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332712571C7;
	Sun, 21 Sep 2025 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eixpg1ja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819348F5B;
	Sun, 21 Sep 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758448749; cv=none; b=BciKjiPuqwYoQWf1yAWXfNHqm+Kl6iA0YAMnMwk5XND3khe1rzbl2bBdLoGevlrcGVyl8tnsxilB6bMUKrWz5fUZYFEBJQ2wzpotS8w/dx2SQhB0p8gXQJGJ7Uq9u2ZDs6aaVLShbxpAO+u8kptTLIrsE9CWo1TlMXZArsO3LWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758448749; c=relaxed/simple;
	bh=j673Ewx1Tw/u4hXjAc9b72cevzvi7kHBuyomuzuVZE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRjok75ZijfP8oke+z1TjlLxFN8FpRKAyCwvtN8hFaopwBt5c19KnfG2WxUfS55CyzBohwPrjfE2dTjnVi/O7DuZAyubpkwEAI7Lkw2+mFaZ9Haq6tnZkPrSEMmOTpGw+QwP9v0Juo14asK37FQoAk+OEZU/Fm9XxXIJOXmdL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eixpg1ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D370C4CEE7;
	Sun, 21 Sep 2025 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758448749;
	bh=j673Ewx1Tw/u4hXjAc9b72cevzvi7kHBuyomuzuVZE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eixpg1jaxGOl9kNmlOOQ9A8iiBQcMDcRcrDl+tRZCH1YkM7AUgXiOced88XMEcYPX
	 5Rd7epJLMEetoWZtwk6ciFR6UyVv4Iay2bHObZCkyCx2pFHjwzNagKJZcSai1sONB+
	 DERtNiE0hK3mqd1arrB+VINCkR2UEiQ/6gzutnVYu5PbQ/RVUoEPRat6Jy5OC9P/9t
	 NxQ6M7IPWn+Wjo3jBRZOlyrm0ilrnCX0oHRE5zyGdpOANZmDMfF88or+u7g0//b0VS
	 mPvJqfGAHrt9vD5dvRCuTPCM4aYr1zv+qhL9DDDMa2kL2Q7AR30NCPZY687kGI3BQ8
	 PLw/nF9rm85fw==
Date: Sun, 21 Sep 2025 11:59:01 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 10/10] man/man2/{fsconfig,mount_setattr}.2: add note
 about attribute-parameter distinction
Message-ID: <fkipds352mktqx42tsqfzrbr75zghs7wayb7udmlenxxq2i3yp@tho7msrqy5sc>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6n4nptq63ueesw6g"
Content-Disposition: inline
In-Reply-To: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>


--6n4nptq63ueesw6g
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
Subject: Re: [PATCH v4 10/10] man/man2/{fsconfig,mount_setattr}.2: add note
 about attribute-parameter distinction
Message-ID: <fkipds352mktqx42tsqfzrbr75zghs7wayb7udmlenxxq2i3yp@tho7msrqy5sc>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>

Hi Aleksa,

On Fri, Sep 19, 2025 at 11:59:51AM +1000, Aleksa Sarai wrote:
> This was not particularly well documented in mount(8) nor mount(2), and
> since this is a fairly notable aspect of the new mount API, we should
> probably add some words about it.
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man/man2/fsconfig.2      | 12 ++++++++++++
>  man/man2/mount_setattr.2 | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>=20
> diff --git a/man/man2/fsconfig.2 b/man/man2/fsconfig.2
> index 5a18e08c700ac93aa22c341b4134944ee3c38d0b..d827a7b96e08284fb025f94c3=
348a4acc4571b7d 100644
> --- a/man/man2/fsconfig.2
> +++ b/man/man2/fsconfig.2
> @@ -579,6 +579,18 @@ .SS Generic filesystem parameters
>  Linux Security Modules (LSMs)
>  are also generic with respect to the underlying filesystem.
>  See the documentation for the LSM you wish to configure for more details.
> +.SS Mount attributes and filesystem parameters
> +Some filesystem parameters
> +(traditionally associated with
> +.BR mount (8)-style
> +options)
> +have a sibling mount attribute
> +with superficially similar user-facing behaviour.
> +.P
> +For a description of the distinction between
> +mount attributes and filesystem parameters,
> +see the "Mount attributes and filesystem parameters" subsection of
> +.BR mount_setattr (2).
>  .SH CAVEATS
>  .SS Filesystem parameter types
>  As a result of
> diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> index b27db5b96665cfb0c387bf5b60776d45e0139956..f7d0b96fddf97698e36cab020=
f1d695783143025 100644
> --- a/man/man2/mount_setattr.2
> +++ b/man/man2/mount_setattr.2
> @@ -790,6 +790,46 @@ .SS ID-mapped mounts
>  .BR chown (2)
>  system call changes the ownership globally and permanently.
>  .\"
> +.SS Mount attributes and filesystem parameters
> +Some mount attributes
> +(traditionally associated with
> +.BR mount (8)-style
> +options)
> +have a sibling mount attribute
> +with superficially similar user-facing behaviour.
> +For example, the
> +.I -o ro

As said in another page, this should be

	.I \-o\~ro

> +option to
> +.BR mount (8)
> +can refer to the
> +"read-only" filesystem parameter,
> +or the "read-only" mount attribute.
> +Both of these result in mount objects becoming read-only,
> +but they do have different behaviour.
> +.P
> +The distinction between these two kinds of option is that
> +mount object attributes are applied per-mount-object
> +(allowing different mount objects
> +derived from a given filesystem instance
> +to have different attributes),
> +while filesystem instance parameters
> +("superblock flags" in kernel-developer parlance)
> +apply to all mount objects
> +derived from the same filesystem instance.
> +.P
> +When using
> +.BR mount (2),
> +the line between these two types of mount options was blurred.
> +However, with
> +.BR mount_setattr ()
> +and
> +.BR fsconfig (2),
> +the distinction is made much clearer.
> +Mount attributes are configured with
> +.BR mount_setattr (),
> +while filesystem parameters can be configured using
> +.BR fsconfig (2).
> +.\"

LGTM.

I've finished with the review of the patch set.  It's quite good.  :)


Have a lovely day!
Alex

>  .SS Extensibility
>  In order to allow for future extensibility,
>  .BR mount_setattr ()
>=20
> --=20
> 2.51.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--6n4nptq63ueesw6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjPzGUACgkQ64mZXMKQ
wqmqag/9EaQI3xYLKVOiwwL5pTLeBXzWPO4P5fPie4HjKzckCkdCYD7mDZtKGUoH
NdIrVgtlFTYvc5a9Ru0mFmi2FGI1lJYebJ0mz8SxowMvRjtkTPPjwkT36lIWCso2
wEa538ps/2Wg7A58gOXS2Akl94RrE46H8lmV6qJ6gpB+zqB9hP7SAhmYHquwPzOc
cap2v2hRl04mWYOC72dHFKuL4J/olo/Ky6Xe2klZ2AyJoVj+EwP/xix5HGWRrWpT
dEI/7jrCMEq+dSHjllrzeNWr5azsrlQ7d6hyo67IVk5/vq8qq4vaXBsOAaBmqA30
QujGSGP8OFndEz+E909dWrktpdwkciAn3b3fLROmyP0YmMUy5Z3RJHi7uBIPP+hb
D3j93Rz88v11sfmgofD3/QNxlet5NRSLOmhvE39c6QI78aSL8Gtw2ZH4GqFUj+mm
mUSzl9cbOHJT3XC9dsDvXk9Cw+27TlHH36cdBaeSEj3MvBEJF7tRYS/u6B5xZeI2
zi9aDtzT39W29KOc5IMihZ/9yBty11spfshFYkDag78iwnsqRi4N05wlpA8RnkRm
RcWPu6AJAadzkIYJ9fSbjXvxKWapGRKMvSB8zYzb8GpXMq01DL/Vl7446+EagTWv
m4j2VYoBiHozl7hpB/v3mTT0TLmj9hXoa9FkPtO+iwf+P87bkuo=
=mCvb
-----END PGP SIGNATURE-----

--6n4nptq63ueesw6g--

