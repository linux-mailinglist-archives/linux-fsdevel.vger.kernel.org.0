Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C292CC9F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 23:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgLBWxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 17:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgLBWxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:53:02 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC2C061A47
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 14:52:16 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id r9so254pjl.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 14:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=lAa6ISm7uCrPT+h5o/8USKpvXIqsWq8U2NOa5556/m8=;
        b=cNWo4yBwRTwBwps8iyf8xmXmepIGTSCNf2LNGSIVMYdxdwlw6oVkX1Kl2NcbO5Zzq6
         Ei+x9gnv/ErCspG8p37WUrwiRoribroM4jK4LiahFy4A7mcu/GsMxVqWIIZsICuSPm3e
         BwN9orCgpdbZfC5izYfsDSTJIhRr/Vxv+YcWfl/tgkDTE/f46tvdOuwTHEVr9yA1CitO
         WAOTYd8siLfnKPDQKSeItxevtwzNjjG4fWfL71JFX6ndHZtrtkNLEq32DrQgAImMa111
         b07Uk4E6XS5n2cJt5a/hP3VgG+u50Rzu0PVSI8pZjbXqpd3gSsE6fYr8zmzpZjjdrXfF
         H0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lAa6ISm7uCrPT+h5o/8USKpvXIqsWq8U2NOa5556/m8=;
        b=PFsNko6WSQPkxPktI5LjoO2onRkIeeVUMjhhJpL5B/HmOmhSxku4rdAzTz8HtQJwlN
         amnDvzS6jsDqUGyjKO0X0taJ/7awpufrQqBqG5PSxUN2J4auYVrPpSuyNeHHMjzBeo5P
         pnfolKiAT0Qojohy2M4f7OPEHnmTeMXA9lfmv3WF2KO5UnHeHLU0RPABLBA+f8we+KGp
         r795Yf22VdiJxAMO8vThBR+ihZ3b5TzbI+RruGnSUoB2YBHo2oE3qrp+I6YXtgmJvmcr
         fqbeMKXsiYLApwZNZfVzCBYl5eawZobw9cDS/1kH8sI9BpxsqayF7H6HydjHy93tVe5+
         LNdQ==
X-Gm-Message-State: AOAM532TjDJm8QtXZjeiIaT3zpuyiKddk0tt/KmaY7yrK8BjVeCDyrEs
        kxEoiFmAOE1MmKmwbrpw9RaRJQ==
X-Google-Smtp-Source: ABdhPJxtnCQS2009pSf+S+On0hCx6qSAE8Q3l/QJC0K2JWJb2MdsnrrnPhEAqtLqDMMh7/JX8+0pLQ==
X-Received: by 2002:a17:902:ab98:b029:d8:c5e8:978a with SMTP id f24-20020a170902ab98b02900d8c5e8978amr280062plr.56.1606949536254;
        Wed, 02 Dec 2020 14:52:16 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k4sm119861pfa.103.2020.12.02.14.52.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:52:15 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <5C84DBE6-E9AE-44D9-8BFC-0683C85F666C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_086127B6-A5B9-4644-AEED-CBE64C521D8D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/9] fscrypt: introduce fscrypt_prepare_readdir()
Date:   Wed, 2 Dec 2020 15:52:13 -0700
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


--Apple-Mail=_086127B6-A5B9-4644-AEED-CBE64C521D8D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 24, 2020, at 5:23 PM, Eric Biggers <ebiggers@kernel.org> wrote:
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
> not.  Doing this is easier if we can work with high-level operations
> rather than direct filesystem use of fscrypt_get_encryption_info().
>=20
> So add a function fscrypt_prepare_readdir() which wraps the call to
> fscrypt_get_encryption_info() for the readdir use case.
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

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






--Apple-Mail=_086127B6-A5B9-4644-AEED-CBE64C521D8D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/IGp0ACgkQcqXauRfM
H+AP6Q/+MHpJH7lRfuvglXXmU4UThuvLs/rAMJKbloZXk/CvPKBUEtAUpscsZEur
9/Z4MUJTzAtVlc3PG391SSc4QqSOu58K5r8ZBtv9GsFZniEtRbRmuJJoAXorKz5Q
BiglWRT0Z2xWl0UdWMui5e8TldO2xAU3S4mznT+lZfiJsbjxM8u7vz4MkfPPNZx5
hKskvYV5YPSPlA1LGkNF89vyNxYXxDelt9lQJSs8tNMrhueXra5ddki6YO7ulwpL
6eaLYmnkPVZt7STEVNG5Aq/ZRkAlav/DIb2f6+9qHULMVMoibulXeyWSvCzshbt6
zGL7e5+MQUE+wb8rFe25Ic92sUZtEZ8JAKdQB6K6ZdZ0PWCNWLSRXDJJJwCi0MQM
XDKgR2ysAjioEpiNydcFDj5KMLEmVI4gu19KN0MpaX0B/kHNn+BG2QfVes25mSCT
XMgccEzyHISrDWtBRuUQoscTRKqUMLspJw++fPgCmT8lXARfV1YvI3C2GqzFd4HT
PRUCoArtHppOu7RgPNT12mTjmmwGF+YJ8WmgXgITWkkVfacHWFYVyf8DKT7JqYXy
VHfJoxwb73Xb/zQV73iPllCKfU0F4sRVNWHb0UeaoLZU7PecqTBzNSsPSpo/C/pL
hAmIUa7+slR997Sc0ng5C3PEhlAY5iLTdoiejVyYtknlAO05puA=
=kCNT
-----END PGP SIGNATURE-----

--Apple-Mail=_086127B6-A5B9-4644-AEED-CBE64C521D8D--
