Return-Path: <linux-fsdevel+bounces-59130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40143B34ACC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813327B1216
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F45428153D;
	Mon, 25 Aug 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtTXGeKo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347E3209;
	Mon, 25 Aug 2025 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149192; cv=none; b=d30LMHOWZmp8reGE/QWzbxWlEv1rnZ0fXET7QYIb8LynCREVXFlBWea2s/Xa3gMhfdNaXmoisq+2AmjvoUeXnkPR03S5SoQzgIJSHZFh/BzPfsQfj+m90OUv0SAOjciPaY9nuKwbZ1Uqm/vjmTWLeuYX3cq2k/Y/nNK1VRGTxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149192; c=relaxed/simple;
	bh=XuDh9ToJAetjDDhzGBO+rJdAmv8uxUf247J1DM4Uk8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E60LNfsyurhbGtvNAmxE5EU9T3gpp/unVdVIwgSPxIXAQzE+I0Q5wDxQqOMwSod6kS5W0YZjTOMllGqi+S5dhThP/I7TL6kL2w+Oucoay+Qc6XBZW/x9LZjLopcXDydEPgtsNR2tycPR8B/vlHaZ9F1/3Jogf82q5w/RHO8Yrws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtTXGeKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9A5C4CEED;
	Mon, 25 Aug 2025 19:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756149192;
	bh=XuDh9ToJAetjDDhzGBO+rJdAmv8uxUf247J1DM4Uk8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtTXGeKoPB5C1PTCI554fJrxkeoPex0235YdMB6cfR4v1DdJIMpaHFtrUstGXcE+i
	 Zgo+RABFyFEewgdIxfzKpSwfgP3FOR7gIK/LX+d+uov5SOjT2tBXzWqHdW72bUb8+7
	 od17cvYhjVaq+tEUQOec9X5oxMf7VDDcQXqbkj5v2lhmh7E9PslZCuIGzWCPiEATlV
	 rne4aU+D3OZHytFxCSFOOYgf7BFblU2ziAc1R/6PIm3MiPRGsxRNGFM/vLmrEpsYzp
	 lsUWyvWwqeAeKUqXx1dDq2SqgNdLQpeyeLVr6fde7/BPeOsuKht41pMNYWnjzyPAm+
	 nmuHRnAWDOKRg==
Date: Mon, 25 Aug 2025 21:13:05 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2 1/1] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
Message-ID: <rxl7zzllf374j6osujwvpvbvsnrjwikoo5tj2o3pqntfjdmwps@isiyqms4s776>
References: <20250825154839.2422856-1-safinaskar@zohomail.com>
 <20250825154839.2422856-2-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="is57tcmd2h5nvm6o"
Content-Disposition: inline
In-Reply-To: <20250825154839.2422856-2-safinaskar@zohomail.com>


--is57tcmd2h5nvm6o
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2 1/1] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
References: <20250825154839.2422856-1-safinaskar@zohomail.com>
 <20250825154839.2422856-2-safinaskar@zohomail.com>
MIME-Version: 1.0
In-Reply-To: <20250825154839.2422856-2-safinaskar@zohomail.com>

Hi Askar,

On Mon, Aug 25, 2025 at 03:48:39PM +0000, Askar Safin wrote:
> My edit is based on experiments and reading Linux code
>=20
> Signed-off-by: Askar Safin <safinaskar@zohomail.com>
> ---
>  man/man2/mount.2 | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/man/man2/mount.2 b/man/man2/mount.2
> index 5d83231f9..47fc2d21f 100644
> --- a/man/man2/mount.2
> +++ b/man/man2/mount.2
> @@ -405,7 +405,30 @@ flag can be used with
>  to modify only the per-mount-point flags.
>  .\" See https://lwn.net/Articles/281157/
>  This is particularly useful for setting or clearing the "read-only"
> -flag on a mount without changing the underlying filesystem.
> +flag on a mount without changing the underlying filesystem parameters.
> +The
> +.I data
> +argument is ignored if
> +.B MS_REMOUNT
> +and
> +.B MS_BIND
> +are specified.
> +Note that the mountpoint will

I would remove "Note that".  Starting with "The" already is equally
meaningful, and two less meaningless words for the reader.

Should we say "mount point" instead?  Otherwise, it's inconsistent with
"mount-point flags" below.  Also, see:

alx@debian:~/src/linux/man-pages/man-pages/master/man$ grep -rn 'mount poin=
t' | wc -l
98
alx@debian:~/src/linux/man-pages/man-pages/master/man$ grep -rn 'mountpoint=
' | wc -l
3


> +have its existing per-mount-point flags
> +cleared and replaced with those in
> +.I mountflags
> +when
> +.B MS_REMOUNT
> +and
> +.B MS_BIND
> +are specified.

Maybe reverse the sentence to start with this?

	When
	.B MS_REMOUNT
	and
	.B MS_BIND
	are specified,
	the ...
	will have its existing ...
	cleared and replaced with those in
	.IR mountflags .

Having conditionals at the end makes my brain have to reparse the
previous text to understand it.  If I read the conditional early on,
my branch predictor kind of knows what to expect.  :)

> +This means that if

I would move the 'if' to the next line.

> +you wish to preserve
> +any existing per-mount-point flags,
> +you need to include them in
> +.IR mountflags ,
> +along with the per-mount-point flags you wish to set
> +(or with the flags you wish to clear missing).
>  Specifying
>  .I mountflags
>  as:
> @@ -416,8 +439,11 @@ MS_REMOUNT | MS_BIND | MS_RDONLY
>  .EE
>  .in
>  .P
> -will make access through this mountpoint read-only, without affecting
> -other mounts.

Hmmm, I see this uses 'mountpoint' already.

I guess we should have a clear direction of what term we want to use.
Since the existing text already uses this, I think we should change it
in a separate commit.  Do you want to send a second patch to use
'mount point'?

> +will make access through this mountpoint read-only
> +(clearing all other per-mount-point flags),
> +without affecting
> +other mounts
> +of this filesystem.


Have a lovely night!
Alex

>  .\"
>  .SS Creating a bind mount
>  If
> --=20
> 2.47.2
>=20

--=20
<https://www.alejandro-colomar.es/>

--is57tcmd2h5nvm6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmistcEACgkQ64mZXMKQ
wqlUpg//VPTB1lJJ8kOm1ru8cOvoN2SsoTNM377y26r4IT1jE7YknYYnUYI0GsrT
/JVqaELk/jCUjwo02P9pC7lRvgA2H4l+/rE6opE33PvcMWSYv9484BjuicSOtEfZ
WMi++HFGiw4WwJMpecit1wFiWybes+dNizWowDGGbViee9kbpWPu6KVUxn4gPG9s
MCJ+2Ed2K3QJT28DT6spEf7kpFxlKfMxXmB6zHOdwsNwKvxVb6gBtGho/2V0YxkU
UBXCwu25hUFgtD4q+XcZhmJqOBjapDJXX5QDzr4A7RNSYz5PxKOe0xLkWVsRBGGq
bt5ctgy6h5KBfEvTZEjgS+8assySKax8QNy10sITT9JokJgkX+oS3U4z+pcZwCpv
eBZfbWf0gRcj0fCyqjPpDFn91TtCDDSeTtazH1f4Dmsk6YdWkitKOu4JpZea6JiF
C4S6P5uCoE9BSYnUNqm5RHIu7ojz/hxeGXSGZKXp6mmPJ8O7gclp5JEnjp/nAM11
Yhlu4H/WjUV82lMkmUnpi4EMJPxmOzmrRAAgyeoobjVLJlDUf2tNv9QaofHpUKN2
rXzYtC6cKeVz7H/SL4/Nfv+oW5NQL0W0IBf46tZsthmiGLuOapywia8LrvRPkGx/
jWBZ8dCAEV3KrF0IX7hyaePHzApqGIgS+WN3HIx9vldOJKtBgKw=
=tUvE
-----END PGP SIGNATURE-----

--is57tcmd2h5nvm6o--

