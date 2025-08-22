Return-Path: <linux-fsdevel+bounces-58799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B73B318DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C7C188C471
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50C2FC01D;
	Fri, 22 Aug 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="SzZDmclj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9A2D47FB;
	Fri, 22 Aug 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867989; cv=none; b=fswjMi2gOcNmM+p1vmPnUSlMJjTBaiGwmS04faOqULw4akevnosj81U+K2oEps7091ULf1c1gz5h/CYfILOodxPoYW8GDrUSsoNIO1aMWdFNX7yOXsS3RQgKQ+0xvHcDuHDpdwYyoIamWzGqFFsK6dpHSZUYll7TbnNTrsSUTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867989; c=relaxed/simple;
	bh=PxuXModFgelu5g4X/oAIYz2X0ajz8Wr8hSiqp7ZFUsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA5ig0c1j3aiE3lNUknRWL8X5EmtcReypbEbNpz5s9jI1zpQ+WHjvCrsX0FiTAIL4fXpzuGPrZ4ldd0ACd09GUpByefIyD/M8dnKo6TQkz8gSZGGDxdqwOM3gbj13cVDeMjIE81ahoh1S0IXsmnZminqnxRcQa3sNaVHPjZabC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=SzZDmclj; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c7gRr3skJz9tS7;
	Fri, 22 Aug 2025 15:06:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755867976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHmx0cJ6/Io1VNZMRU9XQfFPVcAOlWV0pZ8BMp/Jdos=;
	b=SzZDmcljApRV3l6KKZnj+240vwsmhmZvh5fktFEDd/Cz7XwgkRzzncWAxJnSVtWjU5dgc7
	BFkaJpRdG3t2ixcv4ES+JWUsHaB/nqybMngZU09KpKohPQ0e7PczLfTdqGzfdvBQMhjMsD
	ZAgZ9mrNJu2mkFodwPUOTRmAm/5NhRmvDLtByoMv3YJ6TJigzKaFO8bieH9eRIOSDnhW/T
	gTt80zOv0+Cr65TBJmNEDp1li3q8vLCvyZd7GJLwQP2EsdjdrmgUriuvHOywtnmQ5qznTG
	xcfWjoe2koQnmkYYRvHtainug2zcFn5T9hJOvHzRujardAoOF4eNdMoNeiPr8g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 22 Aug 2025 23:06:00 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH 1/1] man2/mount.2: expand and clarify docs for MS_REMOUNT
 | MS_BIND
Message-ID: <2025-08-22.1755866245-crummy-slate-scale-borough-gEcqKg@cyphar.com>
References: <20250822114315.1571537-1-safinaskar@zohomail.com>
 <20250822114315.1571537-2-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p3qrjcycv4xsxa5k"
Content-Disposition: inline
In-Reply-To: <20250822114315.1571537-2-safinaskar@zohomail.com>
X-Rspamd-Queue-Id: 4c7gRr3skJz9tS7


--p3qrjcycv4xsxa5k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] man2/mount.2: expand and clarify docs for MS_REMOUNT
 | MS_BIND
MIME-Version: 1.0

On 2025-08-22, Askar Safin <safinaskar@zohomail.com> wrote:
> My edit is based on experiments and reading Linux code
>=20
> Signed-off-by: Askar Safin <safinaskar@zohomail.com>
> ---
>  man/man2/mount.2 | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/man/man2/mount.2 b/man/man2/mount.2
> index 5d83231f9..909b82e88 100644
> --- a/man/man2/mount.2
> +++ b/man/man2/mount.2
> @@ -405,7 +405,19 @@ flag can be used with
>  to modify only the per-mount-point flags.
>  .\" See https://lwn.net/Articles/281157/
>  This is particularly useful for setting or clearing the "read-only"
> -flag on a mount without changing the underlying filesystem.
> +flag on a mount without changing flags of the underlying filesystem.

For obvious reasons, I would prefer the term "filesystem parameters"
here but mount(2) is kind of loose with its terminology...

> +The
> +.I data
> +argument is ignored if
> +.B MS_REMOUNT
> +and
> +.B MS_BIND
> +are specified.
> +The
> +.I mountflags
> +should specify existing per-mount-point flags,
> +except for those parameters
> +that are deliberately changed.

I would phrase this more like a note to make the advice a bit clearer:

  Note that the mountpoint will
  have its existing per-mount-point flags
  cleared and replaced with those in
  .I mountflags
  when
  .B MS_REMOUNT
  and
  .B MS_BIND
  are specified.
  This means that if
  you wish to preserve
  any existing per-mount-point flags
  (which can be retrieved using
  .BR statfs (2)),
  you need to include them in
  .IR mountflags ,
  along with the per-mount-point flags you wish to set
  (or with the flags you wish to clear missing).

(Still a bit too wordy, there's probably a nicer way of writing it...)

It might also be a good idea to reference locked mount flags (which are
explained in more detail in mount_namespaces(7)) since they are very
relevant to the text you're adding about MS_REMOUNT|MS_BIND.

The current docs only mention locked mounts once and the description is
kind of insufficient (it implies that only MS_REMOUNT affects this, and
that it's related to the mount being locked -- neither is really true).
When dealing with a mount with locked flags, remembering to include
existing mount attributes is very important.

>  Specifying
>  .I mountflags
>  as:
> @@ -416,8 +428,11 @@ MS_REMOUNT | MS_BIND | MS_RDONLY
>  .EE
>  .in
>  .P
> -will make access through this mountpoint read-only, without affecting
> -other mounts.
> +will make access through this mountpoint read-only
> +(and clear all other per-mount-point flags),

   (clearing all other per-mount-point flags)

> +without affecting
> +other mounts
> +of this filesystem.
>  .\"
>  .SS Creating a bind mount
>  If

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--p3qrjcycv4xsxa5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKhrOBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8sZwD+OgTGgm+DSDESZdbiNWUF
YAcH5koLu7PYFanFLAwEyDUA/39xwzVSAoEVMnlj2BAAEtrItuQIdoYu3D4VFMq7
iDgB
=NKc6
-----END PGP SIGNATURE-----

--p3qrjcycv4xsxa5k--

