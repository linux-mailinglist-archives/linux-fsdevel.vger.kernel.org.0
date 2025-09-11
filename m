Return-Path: <linux-fsdevel+bounces-60951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22082B532DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 14:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFAF3BF593
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 12:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9873E322DC1;
	Thu, 11 Sep 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="xvQtmMEh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF621C19D;
	Thu, 11 Sep 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595432; cv=none; b=cag4pXUb+tdoD/P1y7Z7n3jn2mYJagrhzilJuomSL2PuVq8+f7ArH3FhThq1fnfjZjYl813OM3AP0nplQ37e0cSIxLTTjqWuOptZWhmAikuX6WWGFTnZWQM9szrd4wvcBrWkkc6qzM8mBT88zsVvUzqCW6qZMxYPXUewugHGEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595432; c=relaxed/simple;
	bh=K+4XD5yFY+tAfXUiIUiyJLrRhDxis6mu+vq20L3/Ahw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLNvPbMfg9SLKZ5DFLNPL8tuNtodqoXyaigeJftSZ8HZIm5T23EeoZWaTLt9pvVsroTpFK6lOoUkIADL9QCz2GMKTs7xRt6fpOhZlO4L07uaJclDS/S3hjJ4t0wMUd2Bb0qts6sFFG6cQ1y8xqQ2L8grhsX5tlfVMaFDnlQVhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=xvQtmMEh; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cMyJ126d7z9v0c;
	Thu, 11 Sep 2025 14:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1757595425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FPtJkZGBhi1ttcgm/uOh+mtCdcmyZezd0zJhyU8kjvU=;
	b=xvQtmMEhDN7sp7BbZrnxjOsANXMyN5Jj7p/Bbawllq4g41blJZhsaWR2uBmdlF4k2P7YiK
	rfi1SXuRJeNcdp+XegJGtIUUi9OHdXNjQfrSVgy7TsbMbyINgcQFtPca+c5cYlGGoneMnt
	YxDLq1qvg5HNqqhq9K7ji9sJ4SYaUxk7x7dvd2tb2lJlQEBgD3/jTvWXDcj1YP5BOzCHYK
	YX3aaJQv02terwbVGfM77Uf5PWkeWMOqBkC0RFa8ex1w/SLtlkWWmc/3rCLHC2ST4kWuK0
	CKdHHLAhzSrOhop14hbxAB/eh0OD6IGX1GX+k2WCCPAeTS4YgnenWIafeyp9Aw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 11 Sep 2025 22:56:44 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 29/32] nsfs: add missing id retrieval support
Message-ID: <2025-09-11-edible-other-howl-rinse-HzYjnw@cyphar.com>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-29-4dd56e7359d8@kernel.org>
 <2025-09-10-yawning-gross-samba-lox-6iVSwq@cyphar.com>
 <20250911-korallen-aufgibt-faafc9df8f9a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2h4kdmb347cx47i"
Content-Disposition: inline
In-Reply-To: <20250911-korallen-aufgibt-faafc9df8f9a@brauner>
X-Rspamd-Queue-Id: 4cMyJ126d7z9v0c


--k2h4kdmb347cx47i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 29/32] nsfs: add missing id retrieval support
MIME-Version: 1.0

On 2025-09-11, Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Sep 11, 2025 at 02:49:49AM +1000, Aleksa Sarai wrote:
> > On 2025-09-10, Christian Brauner <brauner@kernel.org> wrote:
> > > The mount namespace has supported id retrieval for a while already.
> > > Add support for the other types as well.
> > >=20
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/nsfs.c                 | 74 +++++++++++++++++++++++++++++++++++++=
++--------
> > >  include/uapi/linux/nsfs.h | 12 ++++++--
> > >  2 files changed, 72 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/fs/nsfs.c b/fs/nsfs.c
> > > index 3c6fcf652633..527480e67fd1 100644
> > > --- a/fs/nsfs.c
> > > +++ b/fs/nsfs.c
> > > @@ -173,6 +173,13 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
> > >  	case NS_GET_NSTYPE:
> > >  	case NS_GET_OWNER_UID:
> > >  	case NS_GET_MNTNS_ID:
> > > +	case NS_GET_NETNS_ID:
> > > +	case NS_GET_CGROUPNS_ID:
> > > +	case NS_GET_IPCNS_ID:
> > > +	case NS_GET_UTSNS_ID:
> > > +	case NS_GET_PIDNS_ID:
> > > +	case NS_GET_TIMENS_ID:
> > > +	case NS_GET_USERNS_ID:
> > >  	case NS_GET_PID_FROM_PIDNS:
> > >  	case NS_GET_TGID_FROM_PIDNS:
> > >  	case NS_GET_PID_IN_PIDNS:
> > > @@ -226,18 +233,6 @@ static long ns_ioctl(struct file *filp, unsigned=
 int ioctl,
> > >  		argp =3D (uid_t __user *) arg;
> > >  		uid =3D from_kuid_munged(current_user_ns(), user_ns->owner);
> > >  		return put_user(uid, argp);
> > > -	case NS_GET_MNTNS_ID: {
> > > -		__u64 __user *idp;
> > > -		__u64 id;
> > > -
> > > -		if (ns->ops->type !=3D CLONE_NEWNS)
> > > -			return -EINVAL;
> > > -
> > > -		mnt_ns =3D container_of(ns, struct mnt_namespace, ns);
> > > -		idp =3D (__u64 __user *)arg;
> > > -		id =3D mnt_ns->ns.ns_id;
> > > -		return put_user(id, idp);
> > > -	}
> > >  	case NS_GET_PID_FROM_PIDNS:
> > >  		fallthrough;
> > >  	case NS_GET_TGID_FROM_PIDNS:
> > > @@ -283,6 +278,61 @@ static long ns_ioctl(struct file *filp, unsigned=
 int ioctl,
> > >  			ret =3D -ESRCH;
> > >  		return ret;
> > >  	}
> > > +	case NS_GET_MNTNS_ID:
> > > +		fallthrough;
> > > +	case NS_GET_NETNS_ID:
> > > +		fallthrough;
> > > +	case NS_GET_CGROUPNS_ID:
> > > +		fallthrough;
> > > +	case NS_GET_IPCNS_ID:
> > > +		fallthrough;
> > > +	case NS_GET_UTSNS_ID:
> > > +		fallthrough;
> > > +	case NS_GET_PIDNS_ID:
> > > +		fallthrough;
> > > +	case NS_GET_TIMENS_ID:
> > > +		fallthrough;
> > > +	case NS_GET_USERNS_ID: {
> > > +		__u64 __user *idp;
> > > +		__u64 id;
> > > +		int expected_type;
> > > +
> > > +		switch (ioctl) {
> > > +		case NS_GET_MNTNS_ID:
> > > +			expected_type =3D CLONE_NEWNS;
> > > +			break;
> > > +		case NS_GET_NETNS_ID:
> > > +			expected_type =3D CLONE_NEWNET;
> > > +			break;
> > > +		case NS_GET_CGROUPNS_ID:
> > > +			expected_type =3D CLONE_NEWCGROUP;
> > > +			break;
> > > +		case NS_GET_IPCNS_ID:
> > > +			expected_type =3D CLONE_NEWIPC;
> > > +			break;
> > > +		case NS_GET_UTSNS_ID:
> > > +			expected_type =3D CLONE_NEWUTS;
> > > +			break;
> > > +		case NS_GET_PIDNS_ID:
> > > +			expected_type =3D CLONE_NEWPID;
> > > +			break;
> > > +		case NS_GET_TIMENS_ID:
> > > +			expected_type =3D CLONE_NEWTIME;
> > > +			break;
> > > +		case NS_GET_USERNS_ID:
> > > +			expected_type =3D CLONE_NEWUSER;
> > > +			break;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		if (ns->ops->type !=3D expected_type)
> > > +			return -EINVAL;
> >=20
> > While I get that having this be per-ns-type lets programs avoid being
> > tricked into thinking that one namespace ID is actually another
> > namespace, it feels a bit ugly to have to add a new ioctl for every new
> > namespace.
> >=20
> > If we added a way to get the CLONE_* flag for a namespace (NS_GET_TYPE)
>=20
> That exists afaict: NS_GET_NSTYPE.

D'oh, yeah that's all you need.

> > we could have just NS_GET_ID. Of course, we would have to trust
> > userspace to do the right thing...
>=20
> So NS_GET_ID can just return the id and be done with it. If userspace
> wants to know what type it is they can issue a separate ioctl. But since
> the id space is shared all ids of all namespaces can be compared with
> each other reliably. So really for comparision you wouldn't need to
> care. IOW, yes.

Ah, I didn't realise they're all in the same id-space -- in that case it
makes even more sense to just have a single NS_GET_ID IMHO.

> > > +
> > > +		idp =3D (__u64 __user *)arg;
> > > +		id =3D ns->ns_id;
> > > +		return put_user(id, idp);
> > > +	}
> > >  	}
> > > =20
> > >  	/* extensible ioctls */
> > > diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> > > index 97d8d80d139f..f7c21840cc09 100644
> > > --- a/include/uapi/linux/nsfs.h
> > > +++ b/include/uapi/linux/nsfs.h
> > > @@ -16,8 +16,6 @@
> > >  #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> > >  /* Get owner UID (in the caller's user namespace) for a user namespa=
ce */
> > >  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> > > -/* Get the id for a mount namespace */
> > > -#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, __u64)
> > >  /* Translate pid from target pid namespace into the caller's pid nam=
espace. */
> > >  #define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
> > >  /* Return thread-group leader id of pid in the callers pid namespace=
=2E */
> > > @@ -42,6 +40,16 @@ struct mnt_ns_info {
> > >  /* Get previous namespace. */
> > >  #define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
> > > =20
> > > +/* Retrieve namespace identifiers. */
> > > +#define NS_GET_MNTNS_ID		_IOR(NSIO, 5,  __u64)
> > > +#define NS_GET_NETNS_ID		_IOR(NSIO, 13, __u64)
> > > +#define NS_GET_CGROUPNS_ID	_IOR(NSIO, 14, __u64)
> > > +#define NS_GET_IPCNS_ID		_IOR(NSIO, 15, __u64)
> > > +#define NS_GET_UTSNS_ID		_IOR(NSIO, 16, __u64)
> > > +#define NS_GET_PIDNS_ID		_IOR(NSIO, 17, __u64)
> > > +#define NS_GET_TIMENS_ID	_IOR(NSIO, 18, __u64)
> > > +#define NS_GET_USERNS_ID	_IOR(NSIO, 19, __u64)
> > > +
> > >  enum init_ns_ino {
> > >  	IPC_NS_INIT_INO		=3D 0xEFFFFFFFU,
> > >  	UTS_NS_INIT_INO		=3D 0xEFFFFFFEU,
> > >=20
> > > --=20
> > > 2.47.3
> > >=20
> >=20
> > --=20
> > Aleksa Sarai
> > Senior Software Engineer (Containers)
> > SUSE Linux GmbH
> > https://www.cyphar.com/
>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--k2h4kdmb347cx47i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaMLHDBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/mzwEAx9h4AVzSTJqdqBhkS8zK
BEnvqdVPIlPDANYwvmDIWUIBAOwZ/4o+AwKGmjWBo/SxQ951kZAsSKCS5CcqlP8p
8FQB
=EJ+O
-----END PGP SIGNATURE-----

--k2h4kdmb347cx47i--

