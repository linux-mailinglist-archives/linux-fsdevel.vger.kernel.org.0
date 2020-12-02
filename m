Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175042CCA0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 23:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbgLBWzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 17:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387806AbgLBWzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:55:21 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEB2C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 14:54:40 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b10so2203869pfo.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 14:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=n8gRmB/1qFzqG7wddTsdPmwprBqt+MsER1xrW91iNJ0=;
        b=ztmQVFcVMMIf8Z+Utie3UySUBHHHBp1eUtR3cRJCGhd9/C8pdBnTSc2cPOiJwkrBXT
         pzREWBO8OC4AU9zTSsUPJHfiMZHCyGQpmtZsv3HqfnEtxIzA/kTuICw3tbRl5sz+x/d7
         TwaKstUxMuCq6gFB3RL74G6jP/eUod6qm91FI/QNaZUYD3nhmmVJu1JxXUJxBoopDOTf
         z4Qosaua5fPmKQ+YCTDnktGluWKbN+vzCCd1rZz9N4oePmRwmsIG/sYEvhwKkGaemeIP
         DAHTUugz7HrfjV5yUpRUiZJxFBFR+HqF2T7TBMxWbkf3q9KjpyxmcIrfHngIqoD7wwqz
         3CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=n8gRmB/1qFzqG7wddTsdPmwprBqt+MsER1xrW91iNJ0=;
        b=pnWfNN6+3uB0jvGJ50SipQshm9dSxDmkaLNBoEbUSosX3U1/y8cE8g2yn+jfVC5zKe
         66VYICiSowbLi0kDkjGgHHl5ve+Xi6/ah4ssYIlxikmd8GFr19rAu4N6gWgQz9Fu0L5Q
         ieG3vl1H7pPB+Bj8px2KRbpcGHvTludEHxTTHBjmjwYWf3y12WhP/f1GQye/tABmNpcY
         ZPSfWP3ss6MoyoutFJ1ueTDb/UM0tfkyiaX3bhHgBkz9CpfAoUX4Q3+9hvnkISekPD7s
         K2Gws5mt1WTtB7Uii3pLFaKTQjTupseUAjgJAF1h3UoR/Nf1ovfQNCHZD6qyBiYX7FXB
         oQfQ==
X-Gm-Message-State: AOAM531qXThGdkkWDXk7EYx6/lhSvGHbzSK63rMOms3QdDfEaeD0Ta8X
        oI4jKMLxtexQBtI60iZnRo/qH1ye/U/vsyP7
X-Google-Smtp-Source: ABdhPJyroWX50B50vCBi4SXruvM8BeO/oOit3dvyqmtAmZ75kqPYuqDG6vNNxp/rOzH/+nGwcDJ7mQ==
X-Received: by 2002:a63:2060:: with SMTP id r32mr445169pgm.129.1606949680485;
        Wed, 02 Dec 2020 14:54:40 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x23sm107703pfo.209.2020.12.02.14.54.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:54:39 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F996D2F5-8821-4C8E-B9A7-0017B8F70D6D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_53D94ECE-D613-426B-A535-CC8071F61DE4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 7/9] fscrypt: move fscrypt_require_key() to
 fscrypt_private.h
Date:   Wed, 2 Dec 2020 15:54:38 -0700
In-Reply-To: <20201125002336.274045-8-ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
 <20201125002336.274045-8-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_53D94ECE-D613-426B-A535-CC8071F61DE4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Nov 24, 2020, at 5:23 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> From: Eric Biggers <ebiggers@google.com>
>=20
> fscrypt_require_key() is now only used by files in fs/crypto/.  So
> reduce its visibility to fscrypt_private.h.  This is also a =
prerequsite
> for unexporting fscrypt_get_encryption_info().
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/crypto/fscrypt_private.h | 26 ++++++++++++++++++++++++++
> include/linux/fscrypt.h     | 26 --------------------------
> 2 files changed, 26 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> index a61d4dbf0a0b..16dd55080127 100644
> --- a/fs/crypto/fscrypt_private.h
> +++ b/fs/crypto/fscrypt_private.h
> @@ -571,6 +571,32 @@ int fscrypt_derive_dirhash_key(struct =
fscrypt_info *ci,
> void fscrypt_hash_inode_number(struct fscrypt_info *ci,
> 			       const struct fscrypt_master_key *mk);
>=20
> +/**
> + * fscrypt_require_key() - require an inode's encryption key
> + * @inode: the inode we need the key for
> + *
> + * If the inode is encrypted, set up its encryption key if not =
already done.
> + * Then require that the key be present and return -ENOKEY otherwise.
> + *
> + * No locks are needed, and the key will live as long as the struct =
inode --- so
> + * it won't go away from under you.
> + *
> + * Return: 0 on success, -ENOKEY if the key is missing, or another =
-errno code
> + * if a problem occurred while setting up the encryption key.
> + */
> +static inline int fscrypt_require_key(struct inode *inode)
> +{
> +	if (IS_ENCRYPTED(inode)) {
> +		int err =3D fscrypt_get_encryption_info(inode);
> +
> +		if (err)
> +			return err;
> +		if (!fscrypt_has_encryption_key(inode))
> +			return -ENOKEY;
> +	}
> +	return 0;
> +}
> +
> /* keysetup_v1.c */
>=20
> void fscrypt_put_direct_key(struct fscrypt_direct_key *dk);
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index b20900bb829f..a07610f27926 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -688,32 +688,6 @@ static inline bool =
fscrypt_has_encryption_key(const struct inode *inode)
> 	return fscrypt_get_info(inode) !=3D NULL;
> }
>=20
> -/**
> - * fscrypt_require_key() - require an inode's encryption key
> - * @inode: the inode we need the key for
> - *
> - * If the inode is encrypted, set up its encryption key if not =
already done.
> - * Then require that the key be present and return -ENOKEY otherwise.
> - *
> - * No locks are needed, and the key will live as long as the struct =
inode --- so
> - * it won't go away from under you.
> - *
> - * Return: 0 on success, -ENOKEY if the key is missing, or another =
-errno code
> - * if a problem occurred while setting up the encryption key.
> - */
> -static inline int fscrypt_require_key(struct inode *inode)
> -{
> -	if (IS_ENCRYPTED(inode)) {
> -		int err =3D fscrypt_get_encryption_info(inode);
> -
> -		if (err)
> -			return err;
> -		if (!fscrypt_has_encryption_key(inode))
> -			return -ENOKEY;
> -	}
> -	return 0;
> -}
> -
> /**
>  * fscrypt_prepare_link() - prepare to link an inode into a =
possibly-encrypted
>  *			    directory
> --
> 2.29.2
>=20


Cheers, Andreas






--Apple-Mail=_53D94ECE-D613-426B-A535-CC8071F61DE4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/IGy4ACgkQcqXauRfM
H+DQAw//fLJfA+YSOvXOMgSO+VdKYlIGvZ+7i0b/EqobCgX+LimQHN/xWB2LXTxR
jA5ZJs27vliuurESPr0tAsB/UdRe2ToZfgBDZfKA9sH7msuMmbFQPxYFP3tDAb4V
xFyNxz2jn8fWUWr5rsyNKRTESZKOvf+7V0Vxcw4dyXdgP4DBrfiJpSh/WmFV/4IW
Jhnec+7AaWP9Sd83mz6Vwte4JY55jvF5QwHGTq7J/3JiGoFpCAgfIzkTcymQ3bkn
M23wmBvgRaZdPrDItE8F2tz1QsU+Prqk8uZI9uL3U4wVpzM0Si7pQdaS3wRVE5Fs
0Yi87MdoEDFwTtslLi1K5PkREhgA55myWqMocNSX6HTAf3b68yCcd23eauBRAv9F
xvwRB5UztbQmQIGnGwRnAcwmB0dhC6Z9vFJjRTXpckwVrxe3lkICpxKZU/ZmE0yj
Sl4G5WHzY8uCh6TtYIqRPI7ylM4UJqmmnF+pWt8Qqnnmi5KRuwv+lFwCIbkWQ12X
WUzcoL/A5uKqYcitlZBv9xNw95BskeiD+QwOnEM1gUsCinQji5cxGRDZNiP2lnZD
RtcHUerikV40EI7zS8BbjuLbMpiTrlw/HP1KD1L+41RB+zarX7+0V++0dkOtljxz
I/HXYJt5dEmXGaZNiZdO5AmFO3stSNAIvkQwTXKKBi1vpy4PWsk=
=znFQ
-----END PGP SIGNATURE-----

--Apple-Mail=_53D94ECE-D613-426B-A535-CC8071F61DE4--
