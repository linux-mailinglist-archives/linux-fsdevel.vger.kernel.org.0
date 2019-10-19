Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B186EDDB74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2019 01:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfJSXfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 19:35:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35999 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJSXfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 19:35:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id c22so181598wmd.1;
        Sat, 19 Oct 2019 16:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=id0wNIusA/qeB14i09dYcOborXEJQDy7nJNJMntOntg=;
        b=AO7vJZY4HBTCdjICedw1mdF1zp8mvoHgahAm4iFoQomsr+r0GhUOYSp/S6DsUCpvpk
         yr6AhtY4ftEVi31btmXRm6FWEMY76FoshNiIeVnXHO7BMGot/wwvMFoh8cemp6ihaoYy
         gpnLEoGNdxdCup1Q/oZunkhhUC9IqYhTq4mYnJVIVm/Spi4po4JlV3uSa6GIPY069ojV
         VNmiowOluOxX3dPa7fP6A6oLYmtc2/YPHu4Y8JVWM74ldhqYdi6RQMbZTcDu+gqQ5ugk
         rzZa4bU2Z/NkIVgc8oxCs34gAtCx19WJNr+GTEV4d0iA0JQ/enJVkXnjxJlsK28k8VKE
         IxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=id0wNIusA/qeB14i09dYcOborXEJQDy7nJNJMntOntg=;
        b=erNuAL/vUeB4YYq3icdB8EOHJXRHGE4rZI3x+Qjcq0adQVK2oANTN7zz3tj0fICgKC
         bjzb7Lk9O1+J8j81MWHSlFYwX3ZZK6uf9ZXQJ0BlwDTaQpgtFBYvwgl4nlg0iNS/Bkln
         fnpEhgf2Fuuv7e/rEpysaN0pnXF0KTexra9xRmk1OXh8D3Fo/HiWG2+K5wyYvGGvkcBd
         IuDt62kP7213WpFjqRFYzxQzc9N+P5NecGiuzxb7fXxT8Qco3cYONM+MUe70TGGLEt/J
         va/KEhZit70L63agy04EUtqzj0wxo5nLBj8hzmaL2nNNKK4ACkJFkx/QFJPbyqiLj5/q
         YuxA==
X-Gm-Message-State: APjAAAWmOHs9IAr+ygQHceJ5C431MzptZHGTVKfr1611S0gufyWmbVO1
        flvfyzbw/qDF4eJla26ifkw=
X-Google-Smtp-Source: APXvYqz+d1LHfM2LHvAOL0DN3LJQL0gzkWZzFoLIsuea+7bUn+0OYoXJ8uft1ehaL90prw8AXC2pJg==
X-Received: by 2002:a05:600c:2185:: with SMTP id e5mr13503623wme.78.1571528099345;
        Sat, 19 Oct 2019 16:34:59 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l18sm13632896wrn.48.2019.10.19.16.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Oct 2019 16:34:58 -0700 (PDT)
Date:   Sun, 20 Oct 2019 01:34:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
Message-ID: <20191019233449.bgimi755vt32itnf@pali>
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="emnqsyvtskz5hswi"
Content-Disposition: inline
In-Reply-To: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--emnqsyvtskz5hswi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello! I have not read deeply whole implementation, just spotted
suspicious options. See below.

On Friday 18 October 2019 15:18:39 Konstantin Komarov wrote:
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> new file mode 100644
> index 000000000000..5f8713fe1b0c
> --- /dev/null
> +++ b/fs/exfat/exfat_fs.h
> @@ -0,0 +1,388 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  linux/fs/exfat/super.c
> + *
> + * Copyright (c) 2010-2019 Paragon Software GmbH, All rights reserved.
> + *
> + */
> +
> +#include <linux/buffer_head.h>
> +#include <linux/hash.h>
> +#include <linux/nls.h>
> +#include <linux/ratelimit.h>
> +
> +struct exfat_mount_options {
> +	kuid_t fs_uid;
> +	kgid_t fs_gid;
> +	u16 fs_fmask;
> +	u16 fs_dmask;
> +	u16 codepage; /* Codepage for shortname conversions */

According to exFAT specification, section 7.7.3 FileName Field there is
no 8.3 shortname support with DOS/OEM codepage.

https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification#7=
73-filename-field

Plus it looks like that this member codepage is only set and never
accessed in whole driver.

So it can be clean it up and removed?

> +	/* minutes bias=3D UTC - local time. Eastern time zone: +300, */
> +	/*Paris,Berlin: -60, Moscow: -180*/
> +	int bias;
> +	u16 allow_utime; /* permission for setting the [am]time */
> +	unsigned quiet : 1, /* set =3D fake successful chmods and chowns */
> +		showexec : 1, /* set =3D only set x bit for com/exe/bat */
> +		sys_immutable : 1, /* set =3D system files are immutable */
> +		utf8 : 1, /* Use of UTF-8 character set (Default) */
> +		/* create escape sequences for unhandled Unicode */
> +		unicode_xlate : 1, flush : 1, /* write things quickly */
> +		tz_set : 1, /* Filesystem timestamps' offset set */
> +		discard : 1 /* Issue discard requests on deletions */
> +		;
> +};

=2E..

> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> new file mode 100644
> index 000000000000..0705dab3c3fc
> --- /dev/null
> +++ b/fs/exfat/super.c
=2E..
> +enum {
> +	Opt_uid, Opt_gid, Opt_umask, Opt_dmask, Opt_fmask, Opt_allow_utime,
> +	Opt_codepage, Opt_quiet, Opt_showexec, Opt_debug, Opt_immutable,
> +	Opt_utf8_no, Opt_utf8_yes, Opt_uni_xl_no, Opt_uni_xl_yes, Opt_flush,
> +	Opt_tz_utc, Opt_discard, Opt_nfs, Opt_bias, Opt_err,
> +};
> +
> +static const match_table_t fat_tokens =3D {
> +	{ Opt_uid, "uid=3D%u" },
> +	{ Opt_gid, "gid=3D%u" },
> +	{ Opt_umask, "umask=3D%o" },
> +	{ Opt_dmask, "dmask=3D%o" },
> +	{ Opt_fmask, "fmask=3D%o" },
> +	{ Opt_allow_utime, "allow_utime=3D%o" },
> +	{ Opt_codepage, "codepage=3D%u" },
> +	{ Opt_quiet, "quiet" },
> +	{ Opt_showexec, "showexec" },
> +	{ Opt_debug, "debug" },
> +	{ Opt_immutable, "sys_immutable" },
> +	{ Opt_flush, "flush" },
> +	{ Opt_tz_utc, "tz=3DUTC" },
> +	{ Opt_bias, "bias=3D%d" },
> +	{ Opt_discard, "discard" },
> +	{ Opt_utf8_no, "utf8=3D0" }, /* 0 or no or false */
> +	{ Opt_utf8_no, "utf8=3Dno" },
> +	{ Opt_utf8_no, "utf8=3Dfalse" },
> +	{ Opt_utf8_yes, "utf8=3D1" }, /* empty or 1 or yes or true */
> +	{ Opt_utf8_yes, "utf8=3Dyes" },
> +	{ Opt_utf8_yes, "utf8=3Dtrue" },
> +	{ Opt_utf8_yes, "utf8" },

There are lot of utf8 mount options. Are they really needed?

Would not it be better to use just one "iocharset" mount option like
other Unicode based filesystem have it (e.g. vfat, jfs, iso9660, udf or
ntfs)?

> +	{ Opt_uni_xl_no, "uni_xlate=3D0" }, /* 0 or no or false */
> +	{ Opt_uni_xl_no, "uni_xlate=3Dno" },
> +	{ Opt_uni_xl_no, "uni_xlate=3Dfalse" },
> +	{ Opt_uni_xl_yes, "uni_xlate=3D1" }, /* empty or 1 or yes or true */
> +	{ Opt_uni_xl_yes, "uni_xlate=3Dyes" },
> +	{ Opt_uni_xl_yes, "uni_xlate=3Dtrue" },
> +	{ Opt_uni_xl_yes, "uni_xlate" },
> +	{ Opt_err, NULL }
> +};

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--emnqsyvtskz5hswi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXaudlgAKCRCL8Mk9A+RD
UvG4AJ9bGUB4FsHJFlupSy64yCLVxsmJXACgjhbbLlUZ+jqI0NJdYz0q9RCigp8=
=2Gnf
-----END PGP SIGNATURE-----

--emnqsyvtskz5hswi--
