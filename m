Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7852CC9FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 23:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgLBWyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 17:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgLBWyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:54:33 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CA9C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 14:53:53 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b23so32610pls.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=6sMbfK6xSUKcyWfUeGG79f6zv6xb7kATzaDcIn4zO0I=;
        b=LJKvyhCz/emjw+E+7zoN6LwOSoLLsWeCO5XLuP0j/JRTD7q5K1/lU29OT5eTmpHFmD
         0n2TtGUKM1nsWEM1P5fy5DwT9XDEw5UW8zQ9EX7wpm4B4U17LPkrighPUFx5gKBioLCL
         ci/Zf7lodb5ThEg864+XURYdEgLLr0h/kQLwFcV087DvFgfNgBfl5H16thY5UJaUcD4n
         mvCRQoqiSyVsf7LFldGzHqHIya03oR3FOcPFruikczdP2OL2ZQX3TqxI1B0VCuDWN6fD
         m4xoECJ0iSSBGnEI04xJaLZXO/Dk5cbyesHzZOimApj4WRR94H512bETjuN8v8Gn3Ame
         wFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=6sMbfK6xSUKcyWfUeGG79f6zv6xb7kATzaDcIn4zO0I=;
        b=MPI8Vb13nguJ1fS4iawgWlkmEpCexv/0jnTVDZbLRkr+VeQVoqdua4A7NCSEDKSKEG
         jxLyEdqYH3+5hcmMbOuK3ONBw0gXFa8Ngb08edHDFtJguTPTdsk8+X5G7qKf+AuN83RR
         qOPKtR3YYL9HUUaMcSk56r4+hf5dA7jarWQZgnU82zdvJKNFFdXH/llQ/o+T7C8fsh4K
         gEUauFyHb5QZoKnLQ8IQUoXBKFUNt9+MH+bRUU08WjCYF2bN660Og6aiq9UZhI9kvX7G
         xyAgUdApCyrpQVMPQlLE2wm+y+JxAPW4tJj9/9Zt/kbPeOw6mxevN/6rD8AxpOcUArrS
         r1gw==
X-Gm-Message-State: AOAM530UhqQlaY6QuZLB8G0/6C0Eg8J79jL64eU3egXHPlkaxWsH6suW
        No0QobYnkgaGukHEKH0OZjkm8Q==
X-Google-Smtp-Source: ABdhPJz6ECrgDDZ+XdBZgCMqN1FpiHkNJc84tlPJNn2N0B+y7e+IT9zMAdGJb799KJgWqzkCobJ4Tg==
X-Received: by 2002:a17:902:ee0b:b029:da:20e7:bcfe with SMTP id z11-20020a170902ee0bb02900da20e7bcfemr359725plb.13.1606949632663;
        Wed, 02 Dec 2020 14:53:52 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x23sm107703pfo.209.2020.12.02.14.53.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:53:52 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A2F01966-90F0-4DD2-A61C-21414666EF9A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5B6E5F61-8EF9-4DE3-806E-E887B9EB323B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 6/9] fscrypt: move body of fscrypt_prepare_setattr()
 out-of-line
Date:   Wed, 2 Dec 2020 15:53:50 -0700
In-Reply-To: <20201125002336.274045-7-ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
 <20201125002336.274045-7-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_5B6E5F61-8EF9-4DE3-806E-E887B9EB323B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 24, 2020, at 5:23 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> From: Eric Biggers <ebiggers@google.com>
>=20
> In preparation for reducing the visibility of fscrypt_require_key() by
> moving it to fscrypt_private.h, move the call to it from
> fscrypt_prepare_setattr() to an out-of-line function.
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/crypto/hooks.c       |  8 ++++++++
> include/linux/fscrypt.h | 11 +++++++++--
> 2 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> index 82f351d3113a..1c16dba222d9 100644
> --- a/fs/crypto/hooks.c
> +++ b/fs/crypto/hooks.c
> @@ -120,6 +120,14 @@ int __fscrypt_prepare_readdir(struct inode *dir)
> }
> EXPORT_SYMBOL_GPL(__fscrypt_prepare_readdir);
>=20
> +int __fscrypt_prepare_setattr(struct dentry *dentry, struct iattr =
*attr)
> +{
> +	if (attr->ia_valid & ATTR_SIZE)
> +		return fscrypt_require_key(d_inode(dentry));
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
> +
> /**
>  * fscrypt_prepare_setflags() - prepare to change flags with =
FS_IOC_SETFLAGS
>  * @inode: the inode on which flags are being changed
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 8cbb26f55695..b20900bb829f 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -243,6 +243,7 @@ int __fscrypt_prepare_rename(struct inode =
*old_dir, struct dentry *old_dentry,
> int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
> 			     struct fscrypt_name *fname);
> int __fscrypt_prepare_readdir(struct inode *dir);
> +int __fscrypt_prepare_setattr(struct dentry *dentry, struct iattr =
*attr);
> int fscrypt_prepare_setflags(struct inode *inode,
> 			     unsigned int oldflags, unsigned int flags);
> int fscrypt_prepare_symlink(struct inode *dir, const char *target,
> @@ -543,6 +544,12 @@ static inline int =
__fscrypt_prepare_readdir(struct inode *dir)
> 	return -EOPNOTSUPP;
> }
>=20
> +static inline int __fscrypt_prepare_setattr(struct dentry *dentry,
> +					    struct iattr *attr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> static inline int fscrypt_prepare_setflags(struct inode *inode,
> 					   unsigned int oldflags,
> 					   unsigned int flags)
> @@ -840,8 +847,8 @@ static inline int fscrypt_prepare_readdir(struct =
inode *dir)
> static inline int fscrypt_prepare_setattr(struct dentry *dentry,
> 					  struct iattr *attr)
> {
> -	if (attr->ia_valid & ATTR_SIZE)
> -		return fscrypt_require_key(d_inode(dentry));
> +	if (IS_ENCRYPTED(d_inode(dentry)))
> +		return __fscrypt_prepare_setattr(dentry, attr);
> 	return 0;
> }
>=20
> --
> 2.29.2
>=20


Cheers, Andreas






--Apple-Mail=_5B6E5F61-8EF9-4DE3-806E-E887B9EB323B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/IGv4ACgkQcqXauRfM
H+BEuhAAm/v75p+tdLX3VyODRb1mULfJBeY25WD5wMaqEAkSuLZUmUfepeSljY0f
ok/rpkOYVBtfzQB4YS30GMjC/HbKUdkmPuvWfHpFsLKO7CPHJMZcr2FQFNYlIaLR
Of6kEFqSpxNNh46FOEq+ufFbNxWj++Tq7agI8b7qtp8AscEdRBydLmf1O92GAJMh
O4hG6LlHAtS8W0zFjXm+QXw7aO5a1fkeG8BzD05VPwVI2EAksxCJl3oRFgLnQ8go
c0+NOiEc31MlE8v0KSBhWvvYNIDvVsrqX/IBcHAU2bAULVLTiF41EFPZhZD1ddgu
I8VN9tedrK4sZ0uTwtamzBwUDTQbWQD6mdzX57NXpgha8zU+cN8OJ5UeVByyDhLX
uD1GnM2x8WvzkWd+EIfgNpXZ1kRKZr6LnefMT3lhSjPrDPDzs/QFjMDqLtakdGPa
+Dl9eGB9Y6HE5CkX2b5KDn94gKbEgXdPIJZ8QzBLPcukwhjpBlwNQrRBrybF0UEC
6IuWi+6dqCPJ1B+z6H7BLVVQ/IgyEfgdFLyFzTQ1PwSCW/8Qna37XF9UFODhYyrH
q9lVoWV/HAvHqdTtC5BJNHFPb7qE5cs4YB1yQ7FWw2PseRAK0+tXNE95uuYQYtt8
h7B1yNxEGzk/mLYYhL1k31/lnFt/9HDe3XOcmTGrzzsEyfyS/Rs=
=vQsk
-----END PGP SIGNATURE-----

--Apple-Mail=_5B6E5F61-8EF9-4DE3-806E-E887B9EB323B--
