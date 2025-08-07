Return-Path: <linux-fsdevel+bounces-56969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D58B1D5E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FEB5614E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2726A0C7;
	Thu,  7 Aug 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtVR2fHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B3262FE2;
	Thu,  7 Aug 2025 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754563174; cv=none; b=bVC6SF0wl47D3h85TujXIy9AiyCC7nudzV19EdTynvjbgc6rLHE9Ddu3MtMVKqmSzm+wRqIrlbwj+mE9E5L53IiZcW6j3iapL2uuFnM94OsW8l3So1zeBOkzOByj1EM577F5C0U0TuGdkkAoGShV8diLePoXUeL3n7Avd45bGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754563174; c=relaxed/simple;
	bh=Cf4fxHvMYCEv5sDz2Ig/oo+9B44+EhN3TJsaF+E3Wg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f++iijbexjq9dLnIDDMbshA4dRdsMyfKeQcbrpav7u0v407/dNY8jC5YMMiY0164J0rTAyQRrMoQj635/P3VCan7aBgZrnUSKmQPTLivatOwBAZO+7iMTzEfBE8NH908IYKAmvdFHd0BEIZ+QHcM0F/CRTpLg42DJuZlXbvbenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtVR2fHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C997C4CEEB;
	Thu,  7 Aug 2025 10:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754563173;
	bh=Cf4fxHvMYCEv5sDz2Ig/oo+9B44+EhN3TJsaF+E3Wg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtVR2fHuddn4fzzuYRlColYHI8Z16Bpcd0nZ/pY93x3mu91FCAwSQh36YV2cEL1sz
	 I7kXJnXVGqUgOqXBtIGenzmy7fIl6ffiOj11+Fxb7xPxlp3AGpFOptEp4K3nXnpoex
	 I/72N3vBlTWMiw6n+TIs2irtEHbSRn+GQJzBv1SztgAKET3ruWxmkRJ5QQHUJBjRTd
	 XwG+HJ/za0JLvpqimgfL7x0+xLUYprOGctxOi4+2B14cBV2h0HJx/dta+OE0iotjUs
	 TNcB4yWIyj7ZgJc8Hkqxm/8NvFDGck777eNlB4u67JLRsc2fnnMVStGT644jXTxcoO
	 HNV0k4bEsUKkg==
Date: Thu, 7 Aug 2025 12:39:19 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36 syscall
 wrappers
Message-ID: <aj6j7ue3eddbawshyelvsxli2nxs6fznzbfdsilvnjbgvxwc6k@ecgdixnxdmuk>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ysvk5kewsmv5st3z"
Content-Disposition: inline
In-Reply-To: <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>


--ysvk5kewsmv5st3z
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
Subject: Re: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36 syscall
 wrappers
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>

Hi Aleksa,

On Thu, Aug 07, 2025 at 03:44:35AM +1000, Aleksa Sarai wrote:
> Glibc 2.36 added syscall wrappers for the entire family of fd-based
> mount syscalls, including mount_setattr(2).  Thus it's no longer
> necessary to instruct users to do raw syscall(2) operations.
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks!  I've applied and pushed the patch.


Have a lovely day!
Alex

> ---
>  man/man2/mount_setattr.2 | 45 +++++++-----------------------------------=
---
>  1 file changed, 7 insertions(+), 38 deletions(-)
>=20
> diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> index 60d9cf9de8aa..c96f0657f046 100644
> --- a/man/man2/mount_setattr.2
> +++ b/man/man2/mount_setattr.2
> @@ -10,21 +10,12 @@ .SH LIBRARY
>  .RI ( libc ,\~ \-lc )
>  .SH SYNOPSIS
>  .nf
> -.BR "#include <linux/fcntl.h>" " /* Definition of " AT_* " constants */"
> -.BR "#include <linux/mount.h>" " /* Definition of " MOUNT_ATTR_* " const=
ants */"
> -.BR "#include <sys/syscall.h>" " /* Definition of " SYS_* " constants */"
> -.B #include <unistd.h>
> +.BR "#include <fcntl.h>" "       /* Definition of " AT_* " constants */"
> +.B #include <sys/mount.h>
>  .P
> -.BI "int syscall(SYS_mount_setattr, int " dirfd ", const char *" path ,
> -.BI "            unsigned int " flags ", struct mount_attr *" attr \
> -", size_t " size );
> +.BI "int mount_setattr(int " dirfd ", const char *" path ", unsigned int=
 " flags ","
> +.BI "                  struct mount_attr *" attr ", size_t " size );"
>  .fi
> -.P
> -.IR Note :
> -glibc provides no wrapper for
> -.BR mount_setattr (),
> -necessitating the use of
> -.BR syscall (2).
>  .SH DESCRIPTION
>  The
>  .BR mount_setattr ()
> @@ -586,6 +577,7 @@ .SH HISTORY
>  .\" commit 7d6beb71da3cc033649d641e1e608713b8220290
>  .\" commit 2a1867219c7b27f928e2545782b86daaf9ad50bd
>  .\" commit 9caccd41541a6f7d6279928d9f971f6642c361af
> +glibc 2.36.
>  .SH NOTES
>  .SS ID-mapped mounts
>  Creating an ID-mapped mount makes it possible to
> @@ -914,37 +906,14 @@ .SH EXAMPLES
>  #include <err.h>
>  #include <fcntl.h>
>  #include <getopt.h>
> -#include <linux/mount.h>
> -#include <linux/types.h>
> +#include <sys/mount.h>
> +#include <sys/types.h>
>  #include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> -#include <sys/syscall.h>
>  #include <unistd.h>
>  \&
> -static inline int
> -mount_setattr(int dirfd, const char *path, unsigned int flags,
> -              struct mount_attr *attr, size_t size)
> -{
> -    return syscall(SYS_mount_setattr, dirfd, path, flags,
> -                   attr, size);
> -}
> -\&
> -static inline int
> -open_tree(int dirfd, const char *filename, unsigned int flags)
> -{
> -    return syscall(SYS_open_tree, dirfd, filename, flags);
> -}
> -\&
> -static inline int
> -move_mount(int from_dirfd, const char *from_path,
> -           int to_dirfd, const char *to_path, unsigned int flags)
> -{
> -    return syscall(SYS_move_mount, from_dirfd, from_path,
> -                   to_dirfd, to_path, flags);
> -}
> -\&
>  static const struct option longopts[] =3D {
>      {"map\-mount",       required_argument,  NULL,  \[aq]a\[aq]},
>      {"recursive",       no_argument,        NULL,  \[aq]b\[aq]},
>=20
> --=20
> 2.50.1
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--ysvk5kewsmv5st3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiUglcACgkQ64mZXMKQ
wqmCCw//eUArDHqSONlIP3uqnTBhx/PKkjBThLBfdhTjYobbByBIVMGDA28mcaxt
hAayT2r0vRA/I6GlEZIcm6L2ijLW463jydE0FRdah0GFTnH70tw4p121Mk/v1pes
Fqpi64tYOR9PqN5hmSEz8mqVR4AVdBq4sA9Pq+i0FoEAmLiUcW+sn2K3O9cFKNBN
LYFCt4mCRPVESxbX9lEnPf/W3zfgxgCp/s0q8SDp221SDbNc7OD1/PnhRhZ5kRvJ
lFJgMRm2p0wPD3ZPQ8qOVKvk9eWBBoPrOJm8M3JpXZCbz7zkBGubZAsDSYCCX5RV
0n7ZzgBll3XHZDS/dH63JYRsw5NN8pSI4JJKOn4sIWb5RZRAovpJMpO/uPjeqqIN
2Mteq6eK+BInS2EXFoyF+Mkwm88aSFbK2mNFI6S+PPf9qFCIAW2NN6IQNLDcJ/CH
zeJt+pN7JVl39yGl2a7mCFIwNrUSo45fTZFUIO6imdkZU2TQ4JDo4KfWou/2JG1t
BhtDoDbLnXa2XDSwlHn5HRO9eTp+zB5AGnhRi3vL5EkNwlT+khoPkLxbgUePrJZ8
4dk9SIeFePE/xYcfBin+B030bJ5SA7ZUt4MQ0bDZ5kyabOllBdATIBq3itB4xLG9
MO+p5Qic+OkH/umg3GCrOoxeFydLiSG5aS+95GI247WP3w66a3Y=
=SuDS
-----END PGP SIGNATURE-----

--ysvk5kewsmv5st3z--

