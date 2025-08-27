Return-Path: <linux-fsdevel+bounces-59351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA98B37F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FAF5E643B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1134A30B;
	Wed, 27 Aug 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="m3NaKM4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E322538F;
	Wed, 27 Aug 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287746; cv=none; b=GcDC93lCaAr/et1IWCCfX7T5aUpL0CXCSLN6QHohzS6iX61dBQX6Z9IrbdfeueZlfoWSpL0Wh7A1xJtzrZVDcfWvFj6gzvzj7JOJ683YrSlHX5YX9yOdTNBfwUBESLBv10xAsGDPdkYyejs/kPh/w+o53iPvSBVKaMaGTO5pCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287746; c=relaxed/simple;
	bh=3Sp14yEFgDVi6HC4y65uU9BINjMHODRul02xeNchmKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEH0yawtNacJmDckrdFfOXoQnGGbbpoMcWg+UrdmMPKKC4WyKb3IRkZbdMf5JuuJjFbZiRY6lM/oEkL7vlJINRybH0cesEQJmxLLE2ZIdHwLRAM3YXRQvoQfCi9njgxKuK2ZQBsBDrbE9MzXzs+WYZPHwS1GL61S2ANfZZeER/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=m3NaKM4A; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cBfhD0y8Bz9tWp;
	Wed, 27 Aug 2025 11:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1756287740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLSSrJfUM3D43TuPKQAvi2pHl0Zy6+EXtS3y/NARj3o=;
	b=m3NaKM4AGfs6PR0pCut6gDGdd5SYGRctUC5wQqj+gXl41C778LNeyYpSjwpnqDFLyKMESz
	VA0l15UaTr7FinyJmD6jNCr0kj9K3TcQ2ixsw/B28ts23vD2W5Hmrfn+PXz5ihN0bAPJ9B
	9AUyKkXJphYlPuDx4Q0VquByDvu0MBLztm2/O8tL6jW2yJ8s0dHQhKQ7fRhXhOsP+UoiJ8
	OrpYrWPTGk8SXKFezDAPQCrjYos7k6qN68LaZ9V168CjOPTWio1eupAZn8bkQKC0srFm6K
	HTcxTfgP61FwcPbmLtpLb+99YoOOokqKcouw2d2KU4br11mfguWtyzSMn4qopw==
Date: Wed, 27 Aug 2025 19:42:09 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH v3 1/2] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
Message-ID: <2025-08-27.1756287489-unsure-quiet-flakes-gymnast-P41YdV@cyphar.com>
References: <20250826083227.2611457-1-safinaskar@zohomail.com>
 <20250826083227.2611457-2-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3alsljwz3axby77"
Content-Disposition: inline
In-Reply-To: <20250826083227.2611457-2-safinaskar@zohomail.com>


--c3alsljwz3axby77
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
MIME-Version: 1.0

On 2025-08-26, Askar Safin <safinaskar@zohomail.com> wrote:
> My edit is based on experiments and reading Linux code
>=20
> Signed-off-by: Askar Safin <safinaskar@zohomail.com>
> ---
>  man/man2/mount.2 | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/man/man2/mount.2 b/man/man2/mount.2
> index 5d83231f9..599c2d6fa 100644
> --- a/man/man2/mount.2
> +++ b/man/man2/mount.2
> @@ -405,7 +405,25 @@ flag can be used with
>  to modify only the per-mount-point flags.
>  .\" See https://lwn.net/Articles/281157/
>  This is particularly useful for setting or clearing the "read-only"
> -flag on a mount without changing the underlying filesystem.
> +flag on a mount without changing the underlying filesystem parameters.

When reading the whole sentence, this feels a bit incomplete
("filesystem parameters ... of what?"). Maybe

  This is particularly useful for setting or clearing the "read-only"
  flag on a mount without changing the underlying filesystem's
  filesystem parameters.

or

  This is particularly useful for setting or clearing the "read-only"
  flag on a mount without changing the filesystem parameters of the
  underlying filesystem.

would be better?

That one nit aside, feel free to take my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> +The
> +.I data
> +argument is ignored if
> +.B MS_REMOUNT
> +and
> +.B MS_BIND
> +are specified.
> +The mount point will
> +have its existing per-mount-point flags
> +cleared and replaced with those in
> +.IR mountflags .
> +This means that
> +if you wish to preserve
> +any existing per-mount-point flags,
> +you need to include them in
> +.IR mountflags ,
> +along with the per-mount-point flags you wish to set
> +(or with the flags you wish to clear missing).
>  Specifying
>  .I mountflags
>  as:
> @@ -416,8 +434,11 @@ MS_REMOUNT | MS_BIND | MS_RDONLY
>  .EE
>  .in
>  .P
> -will make access through this mountpoint read-only, without affecting
> -other mounts.
> +will make access through this mount point read-only
> +(clearing all other per-mount-point flags),
> +without affecting
> +other mounts
> +of this filesystem.
>  .\"
>  .SS Creating a bind mount
>  If
> --=20
> 2.47.2
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--c3alsljwz3axby77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaK7S8RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9nYAEAopJc+scVnNxW+RnKdodF
u4ILIeGLNCidv3zPdPn5YvgA/3VhEErR08i6dg18mcboAXWj6HoIIKdK9n602x+7
G0ML
=X0pv
-----END PGP SIGNATURE-----

--c3alsljwz3axby77--

