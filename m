Return-Path: <linux-fsdevel+bounces-60140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37223B41BCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 12:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF98A4E3E77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3212E9EB8;
	Wed,  3 Sep 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Jv8Wg+LY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5281DA60F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895164; cv=none; b=D3cD1ffKEad9DIbV8pF4IDCsKWwRcbRYSVzrtuE0bs1cR3yxOqaQmP4wSkM+lXv2Ehf1sxMRnIi84u86lS4VI3Ip3EQy3kymygp5s0o5y985iSg9+fJfDmNj5PH12raxPMubqXRJ1wvu2R8QYSH1eBytDw5O/HlY2vjvnryQBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895164; c=relaxed/simple;
	bh=why+2o/qZ+qV8wK40Vlp/9a9rF14vFQwGL2Cdiilp9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MvHhExbilBdztHhmPvKe58GQGvesOwzAPPyiRt+M1Y+sIecCP+RD8f8HyMpdLEaKqm8FE97gsVNywmkhPvH+OBj8HDWc+8PEHxRkFq1SVccqeq2Jn5BXyff8bcQ3CknCUUEr6O6/duE6ySnIU0J/5FoHmgJLaPoEcrfhnBowFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Jv8Wg+LY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5DLIqhrEqw+Ij5qDt19eiYQRBFAkC3sA0QbfTB0VuZg=; b=Jv8Wg+LYuJTAvS5RDsicJ0c5aI
	ZmwV++tsHDUkEsPR7ES/NOUir8ywXsPIlkA49PLdKropw/Cz7lZEzjfAE9qg9S+K6hi1E8RcKDhKg
	Q9liSCHphsrg1Ea55M5Zea1eWRk3r7nYHlO+EP0sOBhm1lMoGFO2US4J4pQY3oFHszGpwMuXqxTAw
	B8ikGquzI2zOoqx1mHA+B0H3uUdhxsrqBfqYBk65yHIFAO6bxsX2pDQQLjz4QLi9Fi0croywwUoiy
	4oqMOxK77NIN+YMrEiZDO/axBLgP/PBngBcYUg/wBVZmch6kkdJeOHoozyWn1ZJkcBafOGYxqipE3
	mkoH6iEw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utkgh-0068re-S1; Wed, 03 Sep 2025 12:25:59 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,  Jim Harris <jiharris@nvidia.com>
Subject: Re: [PATCH 3/4] fuse: remove redundant calls to fuse_copy_finish()
 in fuse_notify()
In-Reply-To: <20250902144148.716383-3-mszeredi@redhat.com> (Miklos Szeredi's
	message of "Tue, 2 Sep 2025 16:41:45 +0200")
References: <20250902144148.716383-1-mszeredi@redhat.com>
	<20250902144148.716383-3-mszeredi@redhat.com>
Date: Wed, 03 Sep 2025 11:25:53 +0100
Message-ID: <87ms7bessu.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02 2025, Miklos Szeredi wrote:

> Remove tail calls of fuse_copy_finish(), since it's now done from
> fuse_dev_do_write().
>
> No functional change.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c | 79 +++++++++++++++------------------------------------
>  1 file changed, 23 insertions(+), 56 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 85d05a5e40e9..1258acee9704 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1622,35 +1622,31 @@ static int fuse_notify_poll(struct fuse_conn *fc,=
 unsigned int size,
>  			    struct fuse_copy_state *cs)
>  {
>  	struct fuse_notify_poll_wakeup_out outarg;
> -	int err =3D -EINVAL;
> +	int err;
>=20=20
>  	if (size !=3D sizeof(outarg))
> -		goto err;
> +		return -EINVAL;
>=20=20
>  	err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
>  	if (err)
> -		goto err;
> +		return err;
>=20=20
>  	fuse_copy_finish(cs);
>  	return fuse_notify_poll_wakeup(fc, &outarg);
> -
> -err:
> -	fuse_copy_finish(cs);
> -	return err;
>  }
>=20=20
>  static int fuse_notify_inval_inode(struct fuse_conn *fc, unsigned int si=
ze,
>  				   struct fuse_copy_state *cs)
>  {
>  	struct fuse_notify_inval_inode_out outarg;
> -	int err =3D -EINVAL;
> +	int err;
>=20=20
>  	if (size !=3D sizeof(outarg))
> -		goto err;
> +		return -EINVAL;
>=20=20
>  	err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
>  	if (err)
> -		goto err;
> +		return err;
>  	fuse_copy_finish(cs);
=20
I wonder if these extra fuse_copy_finish() calls should also be removed.
It doesn't seem to be a problem to call it twice, but maybe it's not
needed, or am I missing something?  This happens in a few places.

Other than that, and FWIW, the series look good to me.

Cheers,
--=20
Lu=C3=ADs

>=20
>  	down_read(&fc->killsb);
> @@ -1658,10 +1654,6 @@ static int fuse_notify_inval_inode(struct fuse_con=
n *fc, unsigned int size,
>  				       outarg.off, outarg.len);
>  	up_read(&fc->killsb);
>  	return err;
> -
> -err:
> -	fuse_copy_finish(cs);
> -	return err;
>  }
>=20=20
>  static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int si=
ze,
> @@ -1669,29 +1661,26 @@ static int fuse_notify_inval_entry(struct fuse_co=
nn *fc, unsigned int size,
>  {
>  	struct fuse_notify_inval_entry_out outarg;
>  	int err;
> -	char *buf =3D NULL;
> +	char *buf;
>  	struct qstr name;
>=20=20
> -	err =3D -EINVAL;
>  	if (size < sizeof(outarg))
> -		goto err;
> +		return -EINVAL;
>=20=20
>  	err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
>  	if (err)
> -		goto err;
> +		return err;
>=20=20
> -	err =3D -ENAMETOOLONG;
>  	if (outarg.namelen > fc->name_max)
> -		goto err;
> +		return -ENAMETOOLONG;
>=20=20
>  	err =3D -EINVAL;
>  	if (size !=3D sizeof(outarg) + outarg.namelen + 1)
> -		goto err;
> +		return -EINVAL;
>=20=20
> -	err =3D -ENOMEM;
>  	buf =3D kzalloc(outarg.namelen + 1, GFP_KERNEL);
>  	if (!buf)
> -		goto err;
> +		return -ENOMEM;
>=20=20
>  	name.name =3D buf;
>  	name.len =3D outarg.namelen;
> @@ -1704,12 +1693,8 @@ static int fuse_notify_inval_entry(struct fuse_con=
n *fc, unsigned int size,
>  	down_read(&fc->killsb);
>  	err =3D fuse_reverse_inval_entry(fc, outarg.parent, 0, &name, outarg.fl=
ags);
>  	up_read(&fc->killsb);
> -	kfree(buf);
> -	return err;
> -
>  err:
>  	kfree(buf);
> -	fuse_copy_finish(cs);
>  	return err;
>  }
>=20=20
> @@ -1718,29 +1703,25 @@ static int fuse_notify_delete(struct fuse_conn *f=
c, unsigned int size,
>  {
>  	struct fuse_notify_delete_out outarg;
>  	int err;
> -	char *buf =3D NULL;
> +	char *buf;
>  	struct qstr name;
>=20=20
> -	err =3D -EINVAL;
>  	if (size < sizeof(outarg))
> -		goto err;
> +		return -EINVAL;
>=20=20
>  	err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
>  	if (err)
> -		goto err;
> +		return err;
>=20=20
> -	err =3D -ENAMETOOLONG;
>  	if (outarg.namelen > fc->name_max)
> -		goto err;
> +		return -ENAMETOOLONG;
>=20=20
> -	err =3D -EINVAL;
>  	if (size !=3D sizeof(outarg) + outarg.namelen + 1)
> -		goto err;
> +		return -EINVAL;
>=20=20
> -	err =3D -ENOMEM;
>  	buf =3D kzalloc(outarg.namelen + 1, GFP_KERNEL);
>  	if (!buf)
> -		goto err;
> +		return -ENOMEM;
>=20=20
>  	name.name =3D buf;
>  	name.len =3D outarg.namelen;
> @@ -1753,12 +1734,8 @@ static int fuse_notify_delete(struct fuse_conn *fc=
, unsigned int size,
>  	down_read(&fc->killsb);
>  	err =3D fuse_reverse_inval_entry(fc, outarg.parent, outarg.child, &name=
, 0);
>  	up_read(&fc->killsb);
> -	kfree(buf);
> -	return err;
> -
>  err:
>  	kfree(buf);
> -	fuse_copy_finish(cs);
>  	return err;
>  }
>=20=20
> @@ -1776,17 +1753,15 @@ static int fuse_notify_store(struct fuse_conn *fc=
, unsigned int size,
>  	loff_t file_size;
>  	loff_t end;
>=20=20
> -	err =3D -EINVAL;
>  	if (size < sizeof(outarg))
> -		goto out_finish;
> +		return -EINVAL;
>=20=20
>  	err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
>  	if (err)
> -		goto out_finish;
> +		return err;
>=20=20
> -	err =3D -EINVAL;
>  	if (size - sizeof(outarg) !=3D outarg.size)
> -		goto out_finish;
> +		return -EINVAL;
>=20=20
>  	nodeid =3D outarg.nodeid;
>=20=20
> @@ -1846,8 +1821,6 @@ static int fuse_notify_store(struct fuse_conn *fc, =
unsigned int size,
>  	iput(inode);
>  out_up_killsb:
>  	up_read(&fc->killsb);
> -out_finish:
> -	fuse_copy_finish(cs);
>  	return err;
>  }
>=20=20
> @@ -1962,13 +1935,12 @@ static int fuse_notify_retrieve(struct fuse_conn =
*fc, unsigned int size,
>  	u64 nodeid;
>  	int err;
>=20=20
> -	err =3D -EINVAL;
>  	if (size !=3D sizeof(outarg))
> -		goto copy_finish;
> +		return -EINVAL;
>=20=20
>  	err =3D fuse_copy_one(cs, &outarg, sizeof(outarg));
>  	if (err)
> -		goto copy_finish;
> +		return err;
>=20=20
>  	fuse_copy_finish(cs);
>=20=20
> @@ -1984,10 +1956,6 @@ static int fuse_notify_retrieve(struct fuse_conn *=
fc, unsigned int size,
>  	up_read(&fc->killsb);
>=20=20
>  	return err;
> -
> -copy_finish:
> -	fuse_copy_finish(cs);
> -	return err;
>  }
>=20=20
>  /*
> @@ -2098,7 +2066,6 @@ static int fuse_notify(struct fuse_conn *fc, enum f=
use_notify_code code,
>  		return fuse_notify_inc_epoch(fc);
>=20=20
>  	default:
> -		fuse_copy_finish(cs);
>  		return -EINVAL;
>  	}
>  }
> --=20
> 2.49.0
>


