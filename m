Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD22CC9F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 23:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgLBWxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 17:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgLBWxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:53:20 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92FEC061A48
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 14:52:39 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b23so31073pls.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 14:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=OmUP2MPcenXFfmwZ7lA2aT/KxEZB62H8R34vZjhjmNI=;
        b=nw+pbUJsDE2VGEhZebCyVBzZz9salofRyj4jtbw9NAhJa/FW41OT396ayeu5T5yNVW
         ggBcULktVieAz/K5iTAmfBrfPR+6AMDnIu7qM27gV/cpqqGPi9rFsR+I/eHm49ki9F1b
         kgYIygygOk56hoE+TjmqHVyViHTT6gs8ENlYEX8Qg1101IWRAFq8iEZnQadRjOLv+8Ki
         3zIOUCNId03yHgbFiLsTiLXWdjwWrcU0LyqbxWjNA53QdQSXRHJTS1mL3O6xoHR3VHKz
         WuKmkKikbNUct6yPWXRNohQhtbcN1LFYc9cn4K9CFvJM6Mx0vbUXfOK0YyHipdTA4p8K
         vlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=OmUP2MPcenXFfmwZ7lA2aT/KxEZB62H8R34vZjhjmNI=;
        b=r7E+bO9Dq5RsJajJyO7SP+T0ZOWPZPXWWO3e15afpERW0MBlhsayUsdWtl5usyOHBV
         WKiGMqdgNXHLg1j+bOl919IGyXdMktqSrkD6Zf5lhxndtj6beasHqr2ONVtX24KYsin/
         am7iUkDsBb5NIpBkpD7DVZ8muC+wnk3wqX5zKlBkfyd0vQEO+KWGuxGlxW56DIqnwWtW
         t8v9nshZOzmDdMLezZ3cN6fCnKxsmbVGbbyaIkx9OaO+p1jDfE9t7NmeMTuIHTK8rRo4
         2Rhxz3Xyc/uwVbaJDRWqtNHKb2yNGcPAGmkvq+Atl6XVYY8cUS/hM1agda1aL/D7SCwh
         /rQQ==
X-Gm-Message-State: AOAM533IF1KsoXWFgwpX8FjqKml1lgyaE1CZDXoC2xPeGYKQNmlAfzmR
        BmvL5gt/mMNKzVoPApWVQiLapg==
X-Google-Smtp-Source: ABdhPJy2sFJxHWGZ5G6i7qp1heXgxdv9zTwWgR9Q3+y8MTeiOA+nkHTIWvtORcYby+4Y7NSqrLY9mQ==
X-Received: by 2002:a17:902:8209:b029:d6:d2c9:1db5 with SMTP id x9-20020a1709028209b02900d6d2c91db5mr281911pln.54.1606949559241;
        Wed, 02 Dec 2020 14:52:39 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k4sm119861pfa.103.2020.12.02.14.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:52:38 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <61983A66-FC9F-413D-B712-1F30E9BDFCBC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E798FBC2-B426-42EC-9AAE-51D67E6BE4E1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/9] fscrypt: introduce fscrypt_prepare_readdir()
Date:   Wed, 2 Dec 2020 15:52:37 -0700
In-Reply-To: <20201125002336.274045-6-ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
 <20201125002336.274045-6-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_E798FBC2-B426-42EC-9AAE-51D67E6BE4E1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Nov 24, 2020, at 5:23 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> From: Eric Biggers <ebiggers@google.com>
>=20
> The last remaining use of fscrypt_get_encryption_info() from =
filesystems
> is for readdir (->iterate_shared()).  Every other call is now in
> fs/crypto/ as part of some other higher-level operation.
>=20
> We need to add a new argument to fscrypt_get_encryption_info() to
> indicate whether the encryption policy to allowed to be unrecognized =
or

(typo) *is* allowed

> not.  Doing this is easier if we can work with high-level operations
> rather than direct filesystem use of fscrypt_get_encryption_info().
>=20
> So add a function fscrypt_prepare_readdir() which wraps the call to
> fscrypt_get_encryption_info() for the readdir use case.
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> fs/crypto/hooks.c       |  6 ++++++
> fs/ext4/dir.c           |  8 +++-----
> fs/ext4/namei.c         |  2 +-
> fs/f2fs/dir.c           |  2 +-
> fs/ubifs/dir.c          |  2 +-
> include/linux/fscrypt.h | 24 ++++++++++++++++++++++++
> 6 files changed, 36 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> index c809a4afa057..82f351d3113a 100644
> --- a/fs/crypto/hooks.c
> +++ b/fs/crypto/hooks.c
> @@ -114,6 +114,12 @@ int __fscrypt_prepare_lookup(struct inode *dir, =
struct dentry *dentry,
> }
> EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
>=20
> +int __fscrypt_prepare_readdir(struct inode *dir)
> +{
> +	return fscrypt_get_encryption_info(dir);
> +}
> +EXPORT_SYMBOL_GPL(__fscrypt_prepare_readdir);
> +
> /**
>  * fscrypt_prepare_setflags() - prepare to change flags with =
FS_IOC_SETFLAGS
>  * @inode: the inode on which flags are being changed
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 16bfbdd5007c..c6d16353326a 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -118,11 +118,9 @@ static int ext4_readdir(struct file *file, struct =
dir_context *ctx)
> 	struct buffer_head *bh =3D NULL;
> 	struct fscrypt_str fstr =3D FSTR_INIT(NULL, 0);
>=20
> -	if (IS_ENCRYPTED(inode)) {
> -		err =3D fscrypt_get_encryption_info(inode);
> -		if (err)
> -			return err;
> -	}
> +	err =3D fscrypt_prepare_readdir(inode);
> +	if (err)
> +		return err;
>=20
> 	if (is_dx_dir(inode)) {
> 		err =3D ext4_dx_readdir(file, ctx);
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 7b31aea3e025..5fa8436cd5fa 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1004,7 +1004,7 @@ static int htree_dirblock_to_tree(struct file =
*dir_file,
> 					   EXT4_DIR_REC_LEN(0));
> 	/* Check if the directory is encrypted */
> 	if (IS_ENCRYPTED(dir)) {
> -		err =3D fscrypt_get_encryption_info(dir);
> +		err =3D fscrypt_prepare_readdir(dir);
> 		if (err < 0) {
> 			brelse(bh);
> 			return err;
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 47bee953fc8d..049500f1e764 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -1022,7 +1022,7 @@ static int f2fs_readdir(struct file *file, =
struct dir_context *ctx)
> 	int err =3D 0;
>=20
> 	if (IS_ENCRYPTED(inode)) {
> -		err =3D fscrypt_get_encryption_info(inode);
> +		err =3D fscrypt_prepare_readdir(inode);
> 		if (err)
> 			goto out;
>=20
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index 009fbf844d3e..1f33a5598b93 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -514,7 +514,7 @@ static int ubifs_readdir(struct file *file, struct =
dir_context *ctx)
> 		return 0;
>=20
> 	if (encrypted) {
> -		err =3D fscrypt_get_encryption_info(dir);
> +		err =3D fscrypt_prepare_readdir(dir);
> 		if (err)
> 			return err;
>=20
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 0c9e64969b73..8cbb26f55695 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -242,6 +242,7 @@ int __fscrypt_prepare_rename(struct inode =
*old_dir, struct dentry *old_dentry,
> 			     unsigned int flags);
> int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
> 			     struct fscrypt_name *fname);
> +int __fscrypt_prepare_readdir(struct inode *dir);
> int fscrypt_prepare_setflags(struct inode *inode,
> 			     unsigned int oldflags, unsigned int flags);
> int fscrypt_prepare_symlink(struct inode *dir, const char *target,
> @@ -537,6 +538,11 @@ static inline int __fscrypt_prepare_lookup(struct =
inode *dir,
> 	return -EOPNOTSUPP;
> }
>=20
> +static inline int __fscrypt_prepare_readdir(struct inode *dir)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> static inline int fscrypt_prepare_setflags(struct inode *inode,
> 					   unsigned int oldflags,
> 					   unsigned int flags)
> @@ -795,6 +801,24 @@ static inline int fscrypt_prepare_lookup(struct =
inode *dir,
> 	return 0;
> }
>=20
> +/**
> + * fscrypt_prepare_readdir() - prepare to read a possibly-encrypted =
directory
> + * @dir: the directory inode
> + *
> + * If the directory is encrypted and it doesn't already have its =
encryption key
> + * set up, try to set it up so that the filenames will be listed in =
plaintext
> + * form rather than in no-key form.
> + *
> + * Return: 0 on success; -errno on error.  Note that the encryption =
key being
> + *	   unavailable is not considered an error.
> + */
> +static inline int fscrypt_prepare_readdir(struct inode *dir)
> +{
> +	if (IS_ENCRYPTED(dir))
> +		return __fscrypt_prepare_readdir(dir);
> +	return 0;
> +}
> +
> /**
>  * fscrypt_prepare_setattr() - prepare to change a possibly-encrypted =
inode's
>  *			       attributes
> --
> 2.29.2
>=20


Cheers, Andreas






--Apple-Mail=_E798FBC2-B426-42EC-9AAE-51D67E6BE4E1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/IGrUACgkQcqXauRfM
H+DTQhAAuYlAZUnmGq1PBm62te5T4PH0Rz7ZV8pizJPaidGHUb8wgNx+XEEQ3RKJ
zkP12wPe5i/2CQuuGyJAihuGQDBEocJhz8xAnCTVSJtp9i5cLzgOoP7FlMlIzeXC
5//PQE+eQIXfqaAcsYFbMSlogupdVOUxNiA5Vsit4zVAbaWqZH/1E4CQl/4xIS3L
wV20KyhzylH1nxbYoNYC+AFEhbp+/rHLGlu6ZlrkLPs6EtsPHSJMywdyj7rS9wty
iAE82ZGdDRKhf+s4hxCiMVKNtsJ0Qq+psHLzUpLo3Nn/F40mdSo2lt0KDS7dhONB
Z3KmukXq8D8/4bmb5P6+yVtF6wRwsZrQ+PwCdjT6Z9Y48fZxpZin0KqKgoDGBlkT
zTSZBDDxys5KGEQ91lJA0EJrl20F3RJckwUHeaiNNYpUS2JMzDipVZHSFpJzqsk6
9MdyETVc0RbGCMIavUyAuxMxHg9zEccqZNZgGo6OCfsQ7t4Z4zFsVLjbzARonldl
hmczfzZw5xb7qh2Fte7Wl2wk0ltyuhB9mPhbMiotfdwkq9ZQoaCD4NtSXb9DCJvc
qunKdVZD+ig/geI5ZgTBsPW3YC5olrItqRJzXbGM6guW5WXZIjcd3lJK7+ixG6xI
xBBRk59t5uh34lt8OoOECGOmD4IyFGHpEoRxn9eT3aB7pDsDcQQ=
=6a0V
-----END PGP SIGNATURE-----

--Apple-Mail=_E798FBC2-B426-42EC-9AAE-51D67E6BE4E1--
