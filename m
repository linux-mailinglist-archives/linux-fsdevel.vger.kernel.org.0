Return-Path: <linux-fsdevel+bounces-57247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A90B1FE77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFE354E1D3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 05:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44C268C55;
	Mon, 11 Aug 2025 05:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="QnYsJ6TQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CA264F9C
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889260; cv=none; b=po20I+b512GA/T/aoNpcxKLvHo/05dKIERy8Y3PlapZm9M7CJcY2/PY26J/5N9wC6C9H3JGZuk5vxTUhbRmGTdr/CF+Wng/7NeASR670LTFcMU+W1UtvMNbl1t6pdnUB7smDorlkfBRNDky4Cln7+jkgxDaOjSqrE8+Q3q24W6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889260; c=relaxed/simple;
	bh=1DVpCgKZtMGDlHlBBsbZMIuw9zI4dYhPvEqP5k7blkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npDCDjiCnfbjnWT4sBVJl8x2r4OPCG30T6B0lz6EXl+K3wXxkbDLyj2pFOQhRerdMjGXUAElrA20E79y/YZ6fTzOB9ZVqI/0IR15BpCYzCh7wZwf6Kj3NQV2pGrdVyT4SlPCw5Je4SI0WVl2o7TCT3ALimtT6smVKoZp59PdjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=QnYsJ6TQ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c0jV93420z9tR6;
	Mon, 11 Aug 2025 07:14:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754889249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WtaV5i7VdJo7E0LZgBAs5NAGIr5JvgxFQc8tGpnZeeY=;
	b=QnYsJ6TQmab719SAJGG8kUyhER0KNqw6jTRs+zdKQzkRFsUeIzkAb9pWjwfs6VIeQvwG18
	w+nUo9L+UH1mC817FcqaYgKCS8BNNfEir3eQKvbUAROLLTrsHWRKmsM9f0adLYTpZO2wq3
	14oF/8oP2niyf6zY81hdZk4q4KxQCeR7nWKWeoqCW8sLKLuVFDDbChGfP4Dc01AoRBi9BK
	cSQ8lIXx/5Qo5aV6KzuA5W+vVGGH2sO3DH/d9AIF4XeUMuyWPX1dgzI/tG6oteSH5H248a
	A3XMUTPMkFtbhoIQZffhCIy6+thoytZR7Y2C8D6Zd4k7mNFFR9sN+8uD7l+ZhQ==
Date: Mon, 11 Aug 2025 15:13:56 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, patches@lists.linux.dev
Subject: Re: [PATCH] vfs: fs/namespace.c: remove ms_flags argument from
 do_remount
Message-ID: <2025-08-11.1754889104-proper-butch-stone-vagabond-Dm6UAJ@cyphar.com>
References: <20250811045444.1813009-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obbhnswi4kpf73bp"
Content-Disposition: inline
In-Reply-To: <20250811045444.1813009-1-safinaskar@zohomail.com>


--obbhnswi4kpf73bp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] vfs: fs/namespace.c: remove ms_flags argument from
 do_remount
MIME-Version: 1.0

On 2025-08-11, Askar Safin <safinaskar@zohomail.com> wrote:
> ...because it is not used

Doing some spelunking, this usage was removed in commit 43f5e655eff7e,
when David split out the (MS_REMOUNT|MS_BIND) handling. As such, maybe
this deserves a

Fixed: 43f5e655eff7 ("vfs: Separate changing mount flags full remount")

=2E..?

And feel free to take my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks!

> Signed-off-by: Askar Safin <safinaskar@zohomail.com>
> ---
>  fs/namespace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ddfd4457d338..dbc773b36d49 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3279,7 +3279,7 @@ static int do_reconfigure_mnt(struct path *path, un=
signed int mnt_flags)
>   * If you've mounted a non-root directory somewhere and want to do remou=
nt
>   * on it - tough luck.
>   */
> -static int do_remount(struct path *path, int ms_flags, int sb_flags,
> +static int do_remount(struct path *path, int sb_flags,
>  		      int mnt_flags, void *data)
>  {
>  	int err;
> @@ -4109,7 +4109,7 @@ int path_mount(const char *dev_name, struct path *p=
ath,
>  	if ((flags & (MS_REMOUNT | MS_BIND)) =3D=3D (MS_REMOUNT | MS_BIND))
>  		return do_reconfigure_mnt(path, mnt_flags);
>  	if (flags & MS_REMOUNT)
> -		return do_remount(path, flags, sb_flags, mnt_flags, data_page);
> +		return do_remount(path, sb_flags, mnt_flags, data_page);
>  	if (flags & MS_BIND)
>  		return do_loopback(path, dev_name, flags & MS_REC);
>  	if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
> --=20
> 2.47.2
>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--obbhnswi4kpf73bp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJl8FBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/xuQEA8aE/yEvjxUNkcZsFLWZi
vmJB7e+Sf0ZaysQKFGe9bOUA/A8w9Fzi3XxE+yS2bj24+7RCHSyuAzgF4cY7KsaJ
v9EL
=/xFk
-----END PGP SIGNATURE-----

--obbhnswi4kpf73bp--

