Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC03212C2A0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 15:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfL2OPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 09:15:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51490 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL2OPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 09:15:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so12084778wmd.1;
        Sun, 29 Dec 2019 06:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4//S+eihLFgQG+FF44tL/nOReEy4FYmTgBB/nNp98dA=;
        b=iKyPsE201SxsR8H44GP3fTCkY5HdrjjKDl3LaddDq+wwXiFu/c4eH08j74sTRfE8s2
         314Ww5t4THV0rl/og5y6SgHGhr18daXQ3R296MYXKunhgZZg+OAxYzF7J21UWGxum8wo
         ZH1j9pX0xl3K3z0ClwUHh6S9VqbjyOP7YzFCJ+oHIu9Ha4Q2M46NTHNThs530MqUbMMs
         lvg+Yw5JZUotzYJEvRFLfPe9g1TtJV19DmcQ5QZUT/WNHG87rRfeANzHO20dJvH2eDYq
         anCdqfox+KlYVOqIk0rVfDsyZWa0YwJHh2tRM/PCInkAxKW02sjAKYB78hahyGjMGL49
         V/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4//S+eihLFgQG+FF44tL/nOReEy4FYmTgBB/nNp98dA=;
        b=U3mW6OJQSBC8o0r0R9FXqoWRfQcLKDdWoLTAPODuGgiV517gg1iaUbFc5JOsCy875d
         DlrMjC0zJhYPVIWgdTlg2fEtzV7fQFujGzTR9YBoLE588hLbMs2Ws8AdA8T02+G0uinL
         lojkvcsTu34lE6Ip1ifPl3r5Lu578F+VDvuy64PMBeCFsfxB3w5SGiEFUCCm0mPveWOW
         xGWKcS6MhHW1VYhPg23WPNH2Eo7hcSJ4IxwuGfbCG5Qj8v5Q4gTUmWVoiFPnBl9flAhy
         BSGKdNCOEC4+tPHQXyTCU/u1vdXSQH4ZkBWu7Q5e8MeNkGCE+cG0o7mZFjt4B3KX8F5i
         EVGA==
X-Gm-Message-State: APjAAAUeSKlLqhRd5A5F5LbTeOmqWpVttj9WNHYqCB4MBXUxfHGkFuPN
        CmjmHapdQ6XTxZiSPtHYUMw=
X-Google-Smtp-Source: APXvYqxFBqsWAvlKOQXiVaD9Ch/UakrBYZKraxb5wLGf0s6jkaCRgjA5OE4l7Ig/r8ZJLDHJt7fw8Q==
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr29389578wml.114.1577628951694;
        Sun, 29 Dec 2019 06:15:51 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 4sm17525795wmg.22.2019.12.29.06.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 06:15:51 -0800 (PST)
Date:   Sun, 29 Dec 2019 15:15:50 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 03/13] exfat: add inode operations
Message-ID: <20191229141550.w66jnp2ayvd4bkk3@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p1afd7af6ca2bfbde3d9a883f55f4f3b60@epcas1p1.samsung.com>
 <20191220062419.23516-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nfhy2aomfwhdigtr"
Content-Disposition: inline
In-Reply-To: <20191220062419.23516-4-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--nfhy2aomfwhdigtr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 20 December 2019 01:24:09 Namjae Jeon wrote:
> This adds the implementation of inode operations for exfat.
>=20
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/inode.c |  694 ++++++++++++++++++++++
>  fs/exfat/namei.c | 1459 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 2153 insertions(+)
>  create mode 100644 fs/exfat/inode.c
>  create mode 100644 fs/exfat/namei.c

=2E..

> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> new file mode 100644
> index 000000000000..1bda97b82ef4
> --- /dev/null
> +++ b/fs/exfat/namei.c

=2E..

> +
> +/*
> + * Name Resolution Functions :
> + * Zero if it was successful; otherwise nonzero.
> + */
> +static int __exfat_resolve_path(struct inode *inode, const unsigned char=
 *path,
> +		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
> +		int lookup)
> +{
> +	int namelen;
> +	int lossy =3D NLS_NAME_NO_LOSSY;
> +	struct super_block *sb =3D inode->i_sb;
> +	struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> +	struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +
> +	/* DOT and DOTDOT are handled by VFS layer */
> +
> +	/* strip all trailing spaces */
> +	/* DO NOTHING : Is needed? */

Hello, this comment looks like a TODO item which should be fixed.

> +
> +	/* strip all trailing periods */
> +	namelen =3D __exfat_striptail_len(strlen(path), path);
> +	if (!namelen)
> +		return -ENOENT;
> +
> +	/* the limitation of linux? */

And this one too.

> +	if (strlen(path) > (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
> +		return -ENAMETOOLONG;
> +
> +	/*
> +	 * strip all leading spaces :
> +	 * "MS windows 7" supports leading spaces.
> +	 * So we should skip this preprocessing for compatibility.
> +	 */
> +
> +	/* file name conversion :
> +	 * If lookup case, we allow bad-name for compatibility.
> +	 */
> +	namelen =3D exfat_nls_vfsname_to_uni16s(sb, path, namelen, p_uniname,
> +			&lossy);
> +	if (namelen < 0)
> +		return namelen; /* return error value */
> +
> +	if ((lossy && !lookup) || !namelen)
> +		return -EINVAL;
> +
> +	exfat_chain_set(p_dir, ei->start_clu,
> +		EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flags);
> +
> +	return 0;
> +}
> +

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nfhy2aomfwhdigtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgi1FAAKCRCL8Mk9A+RD
UtZbAJ9kvwSHrQAHJ7JZmR7C4bLPpG997QCfaxuwF41zC5bTAs1dH8LEqlm3zhQ=
=sQej
-----END PGP SIGNATURE-----

--nfhy2aomfwhdigtr--
