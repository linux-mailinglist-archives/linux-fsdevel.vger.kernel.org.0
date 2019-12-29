Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0012C296
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 14:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfL2Nzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 08:55:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41061 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfL2Nzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 08:55:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so30522907wrw.8;
        Sun, 29 Dec 2019 05:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1hSPYl1k111Xaok7uIj/3w+cxaSyR5stkdCWePLF25w=;
        b=dXrLmsnIT4g/mGqo+9r1wUgKqV6Y3q8rKRJr7g4MyCmbu22DZ7zdZ0/073Vr97Cuf2
         2akgWgNHa7Ha/wZ5njFdJjtXvwCghuQUwlJKR+raooqP6A4ccqoJGgs8OjyLyCJuQBOz
         LU2fhCUm+cDl3kyLxafokRspXlQg1OQd10Xarwt2ohEnHuMEsBSclt/2m2LTCxrRHqnl
         6pgTqy4hTsc/zf1NbEcUjDIJzxKBIBzUt+XKoBXKaSbvz0xsrnffdCo2TEE+Sw31xZOo
         1RsGnpzQAw0rirKrlYJP7XQLhcDhRg8phBwWf2mxp2Zf0F1xg2la+t7UE0t7Go0DsIel
         avqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hSPYl1k111Xaok7uIj/3w+cxaSyR5stkdCWePLF25w=;
        b=UMhC/KStkVafpF7nUMR6MM/xFs1DxtmMt593DRanq+bZ+DQlEOx1gGRnpTeAagrRYQ
         k71ZohAlNUghysIlnGAo7fsil7mBh/MNW5uPtK+XT3Ir1cUIN42mSU4q/n6MZTYNLg5A
         wjn6vAJGEo51Y80EpJpeyL7/5LuRnmwm7eI1xvByU6zNDJcvNMwx0uut6vCuGpw8AZJB
         kySKgsSmTvbUF6qb7SDMEe0+9oBDUpWy24U5n00G/+kSk/PV/K/WEl9VwoHtmC7UUV1Q
         8mORTd1HGvGLVHG67nzgbO0Vcq7oKjysG4ZlP1ao8Yp0EAcNmb5N9620XQPSkObM1olF
         TtoQ==
X-Gm-Message-State: APjAAAV+DSYO11fvA4o8AsDOg0MQ4SwaaBh6y47YJRkznXMcWMdPXgXt
        gIUYHZpxzPaQHspf13i7XMk=
X-Google-Smtp-Source: APXvYqyMxBL496OayMHdzr27XoWRqBfUK5Y4K65MF+5zOmXC0AKL3CCmeTpWUVSrUE6SSwGrFlFU4A==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr64502398wrm.223.1577627750088;
        Sun, 29 Dec 2019 05:55:50 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l7sm41726597wrq.61.2019.12.29.05.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 05:55:49 -0800 (PST)
Date:   Sun, 29 Dec 2019 14:55:48 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 02/13] exfat: add super block operations
Message-ID: <20191229135548.qu3i3zglezlnndds@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
 <20191220062419.23516-3-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yvlybd3ehwpgg52a"
Content-Disposition: inline
In-Reply-To: <20191220062419.23516-3-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--yvlybd3ehwpgg52a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 20 December 2019 01:24:08 Namjae Jeon wrote:
> This adds the implementation of superblock operations for exfat.
>=20
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/super.c | 732 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 732 insertions(+)
>  create mode 100644 fs/exfat/super.c
>=20
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> new file mode 100644
> index 000000000000..07687997c7f8
> --- /dev/null
> +++ b/fs/exfat/super.c

=2E..

> +
> +	if (le16_to_cpu(p_bpb->bsx.vol_flags) & VOL_DIRTY) {
> +		sbi->vol_flag |=3D VOL_DIRTY;
> +		exfat_msg(sb, KERN_WARNING,
> +			"Volume was not properly unmounted. Some data may be corrupt. Please =
run fsck.");

Hello, do you have some pointers which fsck tool should user run in this
case?

> +	}
> +
> +	ret =3D exfat_create_upcase_table(sb);
> +	if (ret) {
> +		exfat_msg(sb, KERN_ERR, "failed to load upcase table");
> +		goto free_bh;
> +	}
> +
> +	/* allocate-bitmap is only for exFAT */

It looks like that this comment is relict from previous version which
had also FAT32 code included...

> +	ret =3D exfat_load_bitmap(sb);
> +	if (ret) {
> +		exfat_msg(sb, KERN_ERR, "failed to load alloc-bitmap");
> +		goto free_upcase_table;
> +	}

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yvlybd3ehwpgg52a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgiwYAAKCRCL8Mk9A+RD
UqP9AJ9hposR+eZyv75rSTi6R9atwHUYwACgx/W0sMYtPI5nojzlFH8DgZetbGo=
=jrkF
-----END PGP SIGNATURE-----

--yvlybd3ehwpgg52a--
