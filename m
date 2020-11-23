Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD52C174D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 22:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgKWVGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 16:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbgKWVGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:06:52 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBCFC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 13:06:51 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 62so15396034pgg.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 13:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ZcuvjTRlUM5/ntYaIwe9PoVejRWeM7YD38S9VrCPI5U=;
        b=kKLMJMpTZTsaP4gA9bZUQykwx3riBPXn+F3vVteCKIK5ka0wKq7HD2felNiz2letia
         TZKDtdDBWVDWf+tAlSIr+AKVsBfKY5/1I5CeOd8uOq1w9D8tKU340/i0vl5AtZutX/e+
         cSME5wGk0IZ0XuGw8LvFLD/LsrNMpVo5ybAYCd6SQXjRZYuuYF5BfNZGZO49d63j+x6T
         1kufeeARyYgps2D7rGmSdsq9E4ww/ySF+tCriBW+whrpErBTXvGC+EsFw9V+5lT1oH4D
         IdNRdcesQOnEr5cQ1q+TcuzzfojgULIGX+dxvRPhcFjb6NHDSsEG0k+t64OWZz9ouqvy
         ZGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ZcuvjTRlUM5/ntYaIwe9PoVejRWeM7YD38S9VrCPI5U=;
        b=CO09J7P77t0nrxPG5ohnItlrEZaZbQq8WbLKS+Oyde4H7B63vTm8mBxtaPvJXGPy1D
         m89AihNbWWw/mRv/WLJ+LR3MDFaSToRc5v4qyN864ydohb8tKW7X3ce7h+12Qj8Qxrbs
         aByDAZxElPpu8zxnQJ2NC3hgq04bsRzXeH9+Xr9foYh5gf3RaZ/FWieXxNogHP59X0Qf
         v14gI05Gvi3a1/rfZJKBeN5/gont9253tpBmfmOBW1DOmMMJ7ZdNORXcO7pndBFp7i0q
         65Aj7gZeSykSCYLpLZtiEtEiAmKeHzWXN3pRZNGQTshjOtj0SdA2ztWb6H/15U+F7Bwn
         RtEg==
X-Gm-Message-State: AOAM532Px+2seAwE/3F35roSaCpetYh3Q/MF8td3XlITJ5SQ21queSVW
        rTMtcNPkTsUSQJkEyi9RDD4bAg==
X-Google-Smtp-Source: ABdhPJy1rQIQqY2fTOhVFScZx8cOvVUq8aaeQscLRryFN/RgGGlo3Ww9YnxLDO78cDkUyChc9+BaEQ==
X-Received: by 2002:a65:6a46:: with SMTP id o6mr1126407pgu.36.1606165611330;
        Mon, 23 Nov 2020 13:06:51 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id v186sm12250233pfb.152.2020.11.23.13.06.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 13:06:50 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8728CF2B-8460-43FC-BED1-A46ADB1E8838@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_92D87735-E920-46DD-8699-448DBA1BE741";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH] vfs: fs{set,get}attr iops
Date:   Mon, 23 Nov 2020 14:06:47 -0700
In-Reply-To: <20201123141207.GC327006@miu.piliscsaba.redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
To:     Miklos Szeredi <miklos@szeredi.hu>
References: <20201123141207.GC327006@miu.piliscsaba.redhat.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_92D87735-E920-46DD-8699-448DBA1BE741
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 23, 2020, at 7:12 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
> Dmitry found an issue with overlayfs's =
FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR
> implementation:
>=20
>  =
https://lore.kernel.org/linux-unionfs/CACT4Y+bUfavwMVv2SEMve5pabE_AwsDO0Ys=
RBGZtYqX59a77vA@mail.gmail.com/
>=20
> I think the only proper soltuion is to move these into inode =
operations, which
> should be a good cleanup as well.
>=20
> This is a first cut, the FS_IOC_SETFLAGS conversion is not complete, =
and only
> lightly tested on ext4 and xfs.
>=20
> There are minor changes in behavior, like the exact errno value in =
case of
> multiple error conditions.
>=20
> 34 files changed, 668 insertions(+), 1170 deletions(-)


Hi Miklos,
this looks like a good reduction in code duplication (-500 LOC is nice).

One issues I have with this patch is that it spreads the use of =
"fsxattr"
asthe name for these inode flags further into the VFS.  That was =
inherited
from XFS because of the ioctl name, but is very confusing with "real"
extended attributes, also using get/setxattr names but totally =
differently.

It would be better to use function/variable names with "xflags" and =
"iflags"
that are already used in several filesystems to separate this from =
xattrs.

It wouldn't be terrible to also rename the ioctl to FS_IOC_FSSETXFLAGS =
and
keep a #define for FS_IOC_FSSETXATTR for compatibility, but that is less
critical if that is now only used in one place in the code.

Some more comments inline...

> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> +/*
> + * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values =
and reject
> + * any invalid configurations.
> + *
> + * Note: must be called with inode lock held.
> + */
> +static int fssetxattr_prepare(struct inode *inode,
> +			      const struct kfsxattr *old_fa,
> +			      struct kfsxattr *fa)

> +{
> +       /*
> +        * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> +        * the relevant capability.
> +	*/
> +	if ((fa->fsx_flags ^ old_fa->fsx_flags) & (FS_APPEND_FL | =
FS_IMMUTABLE_FL) &&
> +	    !capable(CAP_LINUX_IMMUTABLE))
> +		return -EPERM;
> +
> +	if (fa->flags_valid)
> +		return fscrypt_prepare_setflags(inode, =
old_fa->fsx_flags, fa->fsx_flags);

This doesn't seem right?  It means if iflags are set, the rest of the =
checks are
skipped *even if* there are no problems with the fscrypt flags?  That =
bypasses
the DAX and PROJINHERIT checks later in this function, but it is also =
possible to
set/clear those flags via FS_IOC_SETFLAGS, and is not very obvious for =
the code
flow.  I'd think this should be something more like:

	if (IS_ENCRYPTED(inode) && fa->flags_valid) {
		rc =3D fscrypt_prepare_setflags(...);
		if (rc)
			return rc;
	}

and continue on to the rest of the checks, and maybe skip the =
xflags-specific
checks (EXTSIZE, EXTSZINHERIT, COWEXTSIZE) if xflags_valid is not set, =
though
they would just be no-ops in that case since the iflags interface will =
not
set those flags.

Alternately, move the DAX and PROJINHERIT checks above "flags_valid", =
but add
a comment that the remaining checks are only for xflags-specific values.

> +	/*
> +	 * Project Quota ID state is only allowed to change from within =
the init
> +	 * namespace. Enforce that restriction only if we are trying to =
change
> +	 * the quota ID state. Everything else is allowed in user =
namespaces.
> +	 */
> +	if (current_user_ns() !=3D &init_user_ns) {
> +		if (old_fa->fsx_projid !=3D fa->fsx_projid)
> +			return -EINVAL;
> +		if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
> +				FS_XFLAG_PROJINHERIT)
> +			return -EINVAL;
> +	}
> +
> +	/* Check extent size hints. */
> +	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && =
!S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +
> +	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
> +			!S_ISDIR(inode->i_mode))
> +		return -EINVAL;
> +
> +	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> +	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> +		return -EINVAL;
> +
> +	/*
> +	 * It is only valid to set the DAX flag on regular files and
> +	 * directories on filesystems.
> +	 */
> +	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> +		return -EINVAL;
> +
> +	/* Extent size hints of zero turn off the flags. */
> +	if (fa->fsx_extsize =3D=3D 0)
> +		fa->fsx_xflags &=3D ~(FS_XFLAG_EXTSIZE | =
FS_XFLAG_EXTSZINHERIT);
> +	if (fa->fsx_cowextsize =3D=3D 0)
> +		fa->fsx_xflags &=3D ~FS_XFLAG_COWEXTSIZE;
> +
> +	return 0;
> +}

[snip]

> +int vfs_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
> +{
> +	struct inode *inode =3D d_inode(dentry);
> +	struct kfsxattr old_fa;
> +	int err;
> +
> +	if (d_is_special(dentry))
> +		return -ENOTTY;
> +
> +	if (!inode->i_op->fssetxattr)
> +		return -ENOIOCTLCMD;
> +
> +	if (!inode_owner_or_capable(inode))
> +		return -EPERM;
> +
> +	inode_lock(inode);
> +	err =3D vfs_fsgetxattr(dentry, &old_fa);
> +	if (!err) {
> +		/* initialize missing bits from old_fa */
> +		if (fa->flags_valid) {
> +			fa->fsx_xflags |=3D old_fa.fsx_xflags & =
~FS_XFLAG_COMMON;
> +			fa->fsx_extsize =3D old_fa.fsx_extsize;
> +			fa->fsx_nextents =3D old_fa.fsx_nextents;
> +			fa->fsx_projid =3D old_fa.fsx_projid;
> +			fa->fsx_cowextsize =3D old_fa.fsx_cowextsize;
> +		} else {
> +			fa->fsx_flags |=3D old_fa.fsx_flags & =
~FS_COMMON_FL;
> +		}

This extra call to vfs_fsgetxattr() is adding pure overhead for the case =
of
FS_IOC_GETFLAGS and is totally unnecessary.  If iflags_valid is set, =
then
none of these other fields should be accessed in the ->fssetxattr() =
method,
and they can check for iflags_valid vs. xflags_valid themselves to see =
which
ioctl is being called and only access fields which are valid.

> +		err =3D fssetxattr_prepare(inode, &old_fa, fa);
> +		if (!err)
> +			err =3D inode->i_op->fssetxattr(dentry, fa);
> +	}
> +	inode_unlock(inode);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(vfs_fssetxattr);

Cheers, Andreas






--Apple-Mail=_92D87735-E920-46DD-8699-448DBA1BE741
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+8JGcACgkQcqXauRfM
H+DewQ//bEYJnBiOI58Ei4BiyCenJN9cTnhZz9URgbT6xoCS7k5Ocbk+E1yJDkHG
IH02oqVlHznxkEUKLCmcl58ynxMYbVWqBhDzRfZCz7Dfy7r/ekTD35QPo2xvKfxC
OopCdjcsdlc4ZhzQnIX8LqdJrTLelm5pZ+enWuLmxhaU5j0X8M1p8HiE/yQs+6Xd
IJpeEcbXooOq+B5DOeGM5ZkulMmGVyeb2gWFlMM7NdP2ogCBL03NacE22oC+Inn0
bEYZAlf7G6BSQTHXCqeN5/jjAP6iIzyisPLlUaljz7Ut/nKK7KMTIkUY4ftVWSL6
5bfEomJpLuGY/GK9/xINuTX21hrr2h5GVSqf6AejWnX3ccDHlNkpB1XuYI8nqwLp
ge9EmhvEU03do15FsVff4nR7unnH+QR/zudpNC5lOhlSJiawnb1YExyk2XglioZ3
zxxRnDOSkd8nm7efs/380btQHEGu4mPTI9r3AkCbkVm9EjuuxbQ14nvlh5cWoAFc
9H+QvYyNWkESJkCIbO7iL0A2KMoVA09SujCJdox3YpzcR5drz03q9Bth23K19rKK
4HELm91VVzOTOqa33/zL8IculykBjAm6O7oD8kGqQjiQoDeHPKjO92bBurWdxfM7
YUltkLSL+MaLJsqeVxJEAjdPpprE3++5bePwCGsqV7A5bAnjtyY=
=grIF
-----END PGP SIGNATURE-----

--Apple-Mail=_92D87735-E920-46DD-8699-448DBA1BE741--
