Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3C12C290
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 14:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfL2Nk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 08:40:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35628 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfL2Nk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 08:40:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so30489432wro.2;
        Sun, 29 Dec 2019 05:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ehUt6YUmkM/nA5AliofRzO8ZYUG51ztpo1WmqMNWyy8=;
        b=h7ftxb3r5KXuKF0AI1wYbmGcwrpA/cR10DohrK9NaafhVoyKuWxGiPzQTwxYWLdss5
         lTlSHEsexE/mGFxzdG9z/QL0CSnQFxFpyO7seWP91MZHyuD2or5oCXp6mJXz+6Z39eno
         VGCQAq4EhxFcnpz0F6GpJ1jifWIseqj8npyYkqH+onHb0G5EZLeQH0M3at8kZlt27ZH7
         Ju8vHK+9MrZCSiQ2x8n9EOMsUrww/b3lOv7Ekherm6Ymyt8B6t2c6LvDxnURANdPd/u7
         S/hGnV23Uxp+g9Vb21YLUa1Id0LYBVwBBE2SiAs2kuUgz/YT3q13kV9yU+Z2pejr6IXT
         E14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ehUt6YUmkM/nA5AliofRzO8ZYUG51ztpo1WmqMNWyy8=;
        b=Ukw7ylyrdNN/EcacS2I8sf+anEjhacP4KGP6mcbdrOknlunqQEOUXr3MpAGyrSVJqJ
         HeUl4MliiiiwSC8kWQovALHBwCyPIuUJLYGh40gzxmpilqKA0s19HNUGANso2E9KQdaB
         sefAY5dRc5bY/p2rDuyvUPsD08Uwkt3iqA0EVPbc+jB2Vlc/MiodiTYPvejvQ3iSNMBP
         wVqMUZIrmzVDb8hyje8EzYuGclS6j6SKS2kFW5D3BLn/KC76Zdis2J8OYVLmshV5LeVv
         GgNHKn8+q3HCg0cy0A0cEnoKxPH6/eG+Pe5kut0lRwG8pmCQ2jboSKdE6wWzxAixDLuv
         2+KA==
X-Gm-Message-State: APjAAAV8Et18rCLm+3a4EffMAid1A0OeRI16DxwhEDMDCazt59C0aVGw
        D8Kp8WQ6B1oyWpmJy48MXRE=
X-Google-Smtp-Source: APXvYqw9aWN6l4wsQ2nvfgY2Sv+Do01GwMwYq5p+l6Iv2ApCS5M1YaVotZW2ODLZONPrbQ+jsB8I6Q==
X-Received: by 2002:adf:f288:: with SMTP id k8mr64899732wro.301.1577626827311;
        Sun, 29 Dec 2019 05:40:27 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b10sm43285857wrt.90.2019.12.29.05.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 05:40:26 -0800 (PST)
Date:   Sun, 29 Dec 2019 14:40:25 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 02/13] exfat: add super block operations
Message-ID: <20191229134025.qb3mmqatsn5c4gao@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
 <20191220062419.23516-3-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7obuds6vfn3nabjb"
Content-Disposition: inline
In-Reply-To: <20191220062419.23516-3-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7obuds6vfn3nabjb
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

> +enum {
> +	Opt_uid,
> +	Opt_gid,
> +	Opt_umask,
> +	Opt_dmask,
> +	Opt_fmask,
> +	Opt_allow_utime,
> +	Opt_charset,
> +	Opt_utf8,
> +	Opt_case_sensitive,
> +	Opt_tz,
> +	Opt_errors,
> +	Opt_discard,
> +};
> +
> +static const struct fs_parameter_spec exfat_param_specs[] =3D {
> +	fsparam_u32("uid",			Opt_uid),
> +	fsparam_u32("gid",			Opt_gid),
> +	fsparam_u32oct("umask",			Opt_umask),
> +	fsparam_u32oct("dmask",			Opt_dmask),
> +	fsparam_u32oct("fmask",			Opt_fmask),
> +	fsparam_u32oct("allow_utime",		Opt_allow_utime),
> +	fsparam_string("iocharset",		Opt_charset),
> +	fsparam_flag("utf8",			Opt_utf8),

Hello! What is the purpose of having extra special "utf8" mount option?
Is not one "iocharset=3Dutf8" option enough?

> +	fsparam_flag("case_sensitive",		Opt_case_sensitive),
> +	fsparam_string("tz",			Opt_tz),
> +	fsparam_enum("errors",			Opt_errors),
> +	fsparam_flag("discard",			Opt_discard),
> +	{}
> +};

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7obuds6vfn3nabjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgisxgAKCRCL8Mk9A+RD
UktUAKDDJ8TMLpk5SiyjSTFBxLJKQqceigCdEQWkzJ9WOXV0Hzn/Hx1wPl1r3go=
=Lgqp
-----END PGP SIGNATURE-----

--7obuds6vfn3nabjb--
