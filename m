Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AE2CCA27
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 23:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgLBW7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 17:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgLBW7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:59:09 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86DC061A49
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 14:57:50 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id z12so16914pjn.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 14:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=85jVaX64uXbWiZtDwL7TYE3kBy+q94gHdu8YJHmEhKI=;
        b=m38ZP2Xice03c5u/hTXZb5zk5p5OsBoZf6ZdBGPnT1Bf4ewSHREq/XIfwSaVfKzOVX
         gGVycM/QE2TbuCzGO+6jRHOXrVqumwhUTh7UM7gJ8sKaufquPKIqnCvUZHDYimC5rShQ
         aMwFvSREeikglC/l3J4Ru3u/u/jyuNGm8HeFrn5DKpk5yaR1HD9Gigw4ddV26WSVHqEY
         +f8otb9pcB7gfpZg3XBOx5myrODMzUwKuCnRYN7xeNmZI4TPcIR+aCAd4Lf4I6yEipAY
         /5irEmC0t0EFiC+NBwgR5vGVpJZraKP9cW4ZCzSTNyzfk/2EBC/0oKGz9+tpJ5B6vP7A
         36fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=85jVaX64uXbWiZtDwL7TYE3kBy+q94gHdu8YJHmEhKI=;
        b=DIembYoVIaaqjO9wzcusNBztrrxMpnuxMMNoWpJy+bIgPK5df1aA8GA6ZhOORT5cCC
         7r4uXU/s6mZPTa/YPYT8eLtGItKZK1+pSpdEXEgD1ecQdqWhqCnY0ybZ1SyoT2WH6l6G
         dObJuxGmso1WPmuuBglFGZALR13sm6yLNlHWbM+O9OVF8ODWYAerArXm99Ji1C/hmzOP
         DYtxNxWHYJ/zt/i39M+BUTgNAo7ZY4bzW5YcGSMg3bEMghr1ysEXZCqjtWwa94N7xX0b
         wd7K6BmuliV2WcUH5ptj8U7AFF8llJ2/J4cLNspaPHVLj4niGzbYYMb8FNnIumqTPhgX
         Q7eA==
X-Gm-Message-State: AOAM530cdC+YHQ8XOuJ0bqEpEpA4cPCo7QUx2wPTg0rT51KtpiT6kLl5
        m+cYfeTHJ7O1K8uvaRpj5NSWPA==
X-Google-Smtp-Source: ABdhPJy0IRdwJ1Qqg/0pI2kQG9NJwxoZkg110bAHxN3MJQ4NndXEm6fWsn5qvTAYeM0bRE7ji2q/aQ==
X-Received: by 2002:a17:902:7488:b029:da:6be9:3aac with SMTP id h8-20020a1709027488b02900da6be93aacmr261365pll.59.1606949869483;
        Wed, 02 Dec 2020 14:57:49 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i4sm91833pgg.67.2020.12.02.14.57.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:57:48 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <02E14979-924E-407E-BF57-3E4B3266BE23@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B80FF583-5BAA-4846-8CF1-5AAF8041371E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 9/9] fscrypt: allow deleting files with unsupported
 encryption policy
Date:   Wed, 2 Dec 2020 15:57:46 -0700
In-Reply-To: <20201125002336.274045-10-ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
 <20201125002336.274045-10-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_B80FF583-5BAA-4846-8CF1-5AAF8041371E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 24, 2020, at 5:23 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> From: Eric Biggers <ebiggers@google.com>
>=20
> Currently it's impossible to delete files that use an unsupported
> encryption policy, as the kernel will just return an error when
> performing any operation on the top-level encrypted directory, even =
just
> a path lookup into the directory or opening the directory for readdir.
>=20
> More specifically, this occurs in any of the following cases:
>=20
> - The encryption context has an unrecognized version number.  Current
>  kernels know about v1 and v2, but there could be more versions in the
>  future.
>=20
> - The encryption context has unrecognized encryption modes
>  (FSCRYPT_MODE_*) or flags (FSCRYPT_POLICY_FLAG_*), an unrecognized
>  combination of modes, or reserved bits set.
>=20
> - The encryption key has been added and the encryption modes are
>  recognized but aren't available in the crypto API -- for example, a
>  directory is encrypted with FSCRYPT_MODE_ADIANTUM but the kernel
>  doesn't have CONFIG_CRYPTO_ADIANTUM enabled.
>=20
> It's desirable to return errors for most operations on files that use =
an
> unsupported encryption policy, but the current behavior is too strict.
> We need to allow enough to delete files, so that people can't be stuck
> with undeletable files when downgrading kernel versions.  That =
includes
> allowing directories to be listed and allowing dentries to be looked =
up.
>=20
> Fix this by modifying the key setup logic to treat an unsupported
> encryption policy in the same way as "key unavailable" in the cases =
that
> are required for a recursive delete to work: preparing for a readdir =
or
> a dentry lookup, revalidating a dentry, or checking whether an inode =
has
> the same encryption policy as its parent directory.
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/crypto/fname.c           |  8 ++++++--
> fs/crypto/fscrypt_private.h |  4 ++--
> fs/crypto/hooks.c           |  4 ++--
> fs/crypto/keysetup.c        | 19 +++++++++++++++++--
> fs/crypto/policy.c          | 22 ++++++++++++++--------
> include/linux/fscrypt.h     |  9 ++++++---
> 6 files changed, 47 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 1fbe6c24d705..988dadf7a94d 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -404,7 +404,7 @@ int fscrypt_setup_filename(struct inode *dir, =
const struct qstr *iname,
> 		fname->disk_name.len =3D iname->len;
> 		return 0;
> 	}
> -	ret =3D fscrypt_get_encryption_info(dir);
> +	ret =3D fscrypt_get_encryption_info(dir, lookup);
> 	if (ret)
> 		return ret;
>=20
> @@ -560,7 +560,11 @@ int fscrypt_d_revalidate(struct dentry *dentry, =
unsigned int flags)
> 		return -ECHILD;
>=20
> 	dir =3D dget_parent(dentry);
> -	err =3D fscrypt_get_encryption_info(d_inode(dir));
> +	/*
> +	 * Pass allow_unsupported=3Dtrue, so that files with an =
unsupported
> +	 * encryption policy can be deleted.
> +	 */
> +	err =3D fscrypt_get_encryption_info(d_inode(dir), true);
> 	valid =3D !fscrypt_has_encryption_key(d_inode(dir));
> 	dput(dir);
>=20
> diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> index c1c302656c34..f0bed6b06fa6 100644
> --- a/fs/crypto/fscrypt_private.h
> +++ b/fs/crypto/fscrypt_private.h
> @@ -571,7 +571,7 @@ int fscrypt_derive_dirhash_key(struct fscrypt_info =
*ci,
> void fscrypt_hash_inode_number(struct fscrypt_info *ci,
> 			       const struct fscrypt_master_key *mk);
>=20
> -int fscrypt_get_encryption_info(struct inode *inode);
> +int fscrypt_get_encryption_info(struct inode *inode, bool =
allow_unsupported);
>=20
> /**
>  * fscrypt_require_key() - require an inode's encryption key
> @@ -589,7 +589,7 @@ int fscrypt_get_encryption_info(struct inode =
*inode);
> static inline int fscrypt_require_key(struct inode *inode)
> {
> 	if (IS_ENCRYPTED(inode)) {
> -		int err =3D fscrypt_get_encryption_info(inode);
> +		int err =3D fscrypt_get_encryption_info(inode, false);
>=20
> 		if (err)
> 			return err;
> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> index 1c16dba222d9..79570e0e8e61 100644
> --- a/fs/crypto/hooks.c
> +++ b/fs/crypto/hooks.c
> @@ -116,7 +116,7 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
>=20
> int __fscrypt_prepare_readdir(struct inode *dir)
> {
> -	return fscrypt_get_encryption_info(dir);
> +	return fscrypt_get_encryption_info(dir, true);
> }
> EXPORT_SYMBOL_GPL(__fscrypt_prepare_readdir);
>=20
> @@ -332,7 +332,7 @@ const char *fscrypt_get_symlink(struct inode =
*inode, const void *caddr,
> 	 * Try to set up the symlink's encryption key, but we can =
continue
> 	 * regardless of whether the key is available or not.
> 	 */
> -	err =3D fscrypt_get_encryption_info(inode);
> +	err =3D fscrypt_get_encryption_info(inode, false);
> 	if (err)
> 		return ERR_PTR(err);
> 	has_key =3D fscrypt_has_encryption_key(inode);
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index 6339b3069a40..261293fb7097 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -546,6 +546,11 @@ fscrypt_setup_encryption_info(struct inode =
*inode,
> /**
>  * fscrypt_get_encryption_info() - set up an inode's encryption key
>  * @inode: the inode to set up the key for.  Must be encrypted.
> + * @allow_unsupported: if %true, treat an unsupported encryption =
policy (or
> + *		       unrecognized encryption context) the same way as =
the key
> + *		       being unavailable, instead of returning an error. =
 Use
> + *		       %false unless the operation being performed is =
needed in
> + *		       order for files (or directories) to be deleted.
>  *
>  * Set up ->i_crypt_info, if it hasn't already been done.
>  *
> @@ -556,7 +561,7 @@ fscrypt_setup_encryption_info(struct inode *inode,
>  *	   encryption key is unavailable.  (Use =
fscrypt_has_encryption_key() to
>  *	   distinguish these cases.)  Also can return another -errno =
code.
>  */
> -int fscrypt_get_encryption_info(struct inode *inode)
> +int fscrypt_get_encryption_info(struct inode *inode, bool =
allow_unsupported)
> {
> 	int res;
> 	union fscrypt_context ctx;
> @@ -567,24 +572,34 @@ int fscrypt_get_encryption_info(struct inode =
*inode)
>=20
> 	res =3D inode->i_sb->s_cop->get_context(inode, &ctx, =
sizeof(ctx));
> 	if (res < 0) {
> +		if (res =3D=3D -ERANGE && allow_unsupported)
> +			return 0;
> 		fscrypt_warn(inode, "Error %d getting encryption =
context", res);
> 		return res;
> 	}
>=20
> 	res =3D fscrypt_policy_from_context(&policy, &ctx, res);
> 	if (res) {
> +		if (allow_unsupported)
> +			return 0;
> 		fscrypt_warn(inode,
> 			     "Unrecognized or corrupt encryption =
context");
> 		return res;
> 	}
>=20
> -	if (!fscrypt_supported_policy(&policy, inode))
> +	if (!fscrypt_supported_policy(&policy, inode)) {
> +		if (allow_unsupported)
> +			return 0;
> 		return -EINVAL;
> +	}
>=20
> 	res =3D fscrypt_setup_encryption_info(inode, &policy,
> 					    fscrypt_context_nonce(&ctx),
> 					    IS_CASEFOLDED(inode) &&
> 					    S_ISDIR(inode->i_mode));
> +
> +	if (res =3D=3D -ENOPKG && allow_unsupported) /* Algorithm =
unavailable? */
> +		res =3D 0;
> 	if (res =3D=3D -ENOKEY)
> 		res =3D 0;
> 	return res;
> diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> index faa0f21daa68..a51cef6bd27f 100644
> --- a/fs/crypto/policy.c
> +++ b/fs/crypto/policy.c
> @@ -590,7 +590,7 @@ EXPORT_SYMBOL_GPL(fscrypt_ioctl_get_nonce);
> int fscrypt_has_permitted_context(struct inode *parent, struct inode =
*child)
> {
> 	union fscrypt_policy parent_policy, child_policy;
> -	int err;
> +	int err, err1, err2;
>=20
> 	/* No restrictions on file types which are never encrypted */
> 	if (!S_ISREG(child->i_mode) && !S_ISDIR(child->i_mode) &&
> @@ -620,19 +620,25 @@ int fscrypt_has_permitted_context(struct inode =
*parent, struct inode *child)
> 	 * In any case, if an unexpected error occurs, fall back to =
"forbidden".
> 	 */
>=20
> -	err =3D fscrypt_get_encryption_info(parent);
> +	err =3D fscrypt_get_encryption_info(parent, true);
> 	if (err)
> 		return 0;
> -	err =3D fscrypt_get_encryption_info(child);
> +	err =3D fscrypt_get_encryption_info(child, true);
> 	if (err)
> 		return 0;
>=20
> -	err =3D fscrypt_get_policy(parent, &parent_policy);
> -	if (err)
> -		return 0;
> +	err1 =3D fscrypt_get_policy(parent, &parent_policy);
> +	err2 =3D fscrypt_get_policy(child, &child_policy);
>=20
> -	err =3D fscrypt_get_policy(child, &child_policy);
> -	if (err)
> +	/*
> +	 * Allow the case where the parent and child both have an =
unrecognized
> +	 * encryption policy, so that files with an unrecognized =
encryption
> +	 * policy can be deleted.
> +	 */
> +	if (err1 =3D=3D -EINVAL && err2 =3D=3D -EINVAL)
> +		return 1;
> +
> +	if (err1 || err2)
> 		return 0;
>=20
> 	return fscrypt_policies_equal(&parent_policy, &child_policy);
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 4b163f5e58e9..d23156d1ac94 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -753,8 +753,9 @@ static inline int fscrypt_prepare_rename(struct =
inode *old_dir,
>  *
>  * Prepare for ->lookup() in a directory which may be encrypted by =
determining
>  * the name that will actually be used to search the directory =
on-disk.  If the
> - * directory's encryption key is available, then the lookup is =
assumed to be by
> - * plaintext name; otherwise, it is assumed to be by no-key name.
> + * directory's encryption policy is supported by this kernel and its =
encryption
> + * key is available, then the lookup is assumed to be by plaintext =
name;
> + * otherwise, it is assumed to be by no-key name.
>  *
>  * This also installs a custom ->d_revalidate() method which will =
invalidate the
>  * dentry if it was created without the key and the key is later =
added.
> @@ -786,7 +787,9 @@ static inline int fscrypt_prepare_lookup(struct =
inode *dir,
>  * form rather than in no-key form.
>  *
>  * Return: 0 on success; -errno on error.  Note that the encryption =
key being
> - *	   unavailable is not considered an error.
> + *	   unavailable is not considered an error.  It is also not an =
error if
> + *	   the encryption policy is unsupported by this kernel; that is =
treated
> + *	   like the key being unavailable, so that files can still be =
deleted.
>  */
> static inline int fscrypt_prepare_readdir(struct inode *dir)
> {
> --
> 2.29.2
>=20


Cheers, Andreas






--Apple-Mail=_B80FF583-5BAA-4846-8CF1-5AAF8041371E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/IG+oACgkQcqXauRfM
H+CN6BAAlNeym7Aty4p4BiT7NE8FQrv4LujWzh3n2QVDzd79aGRGoAPUpuvpcyKB
9NOEXebkCak32RhqXx/c8iIb9lrO5rx7VxztH3obNcJHZv4bsA+aiZnmNSl9Zsdt
talxaPhbi5Ztd3xBrvK0FPO/j5i8e2Nppp7gDYw3PaPwHswa+7EmwKF9mRA5m6pm
dMSas80scJEWaGqCK7jE64iG/HrOoGHYaAop3i/5nWA10braHWgVSqzg5G0Yyuwx
dLgLaxU7z4rHN9MIICAj8ZoUpq3yamhcmMf8XCaWUHxzgAtUwV+m0uMYdcscezr+
YfLG6JikAVlCgCdW4AlPll/DyJUgPxawkmMc2Izht/kyk6HqAMdhT48a6Ob0HJjy
4XcpMt1hI5/IsbVNgOkD/VRB6vdJqnar0RHesBg/8K1DLBQ3eshwHZjadPPdMSIf
J4MF5BlWaByRxgpLImWmnWVnebQrgRWmlkSOP+8UkLZwmeASz0Z5d5RkAmQmeCp5
E+pfba3tATGUE6GtpUpTY/RpLZLaMgD0E7xLZOlrApWLNjxZX3vNRkoH/2+gmlDq
TjDJL/5lzS/sM/+HRZ9GTw4+zgIn/z9loSnAEBWABdyzWUgWlt0ULuV++K+vMOgD
VVUHzWK/dPSUxuWQpyvnDOhwSK1J5c2Z8WsPQ8EC0T37qlKp2LQ=
=Gi/4
-----END PGP SIGNATURE-----

--Apple-Mail=_B80FF583-5BAA-4846-8CF1-5AAF8041371E--
