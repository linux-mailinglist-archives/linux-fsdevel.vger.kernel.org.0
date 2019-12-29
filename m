Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44612C29A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 15:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfL2OAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 09:00:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40651 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfL2OAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 09:00:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so30504993wrn.7;
        Sun, 29 Dec 2019 06:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7CWd2Rx8Vc6NPJBS0gYo2M8ZKUeKMMZulpcbCZ9zB+s=;
        b=LP8ET5UdT7fnJQGQE0h5RAKRz275MIjg4OfL8Bpf7Y4vU7SC+AAavtptDGgNx0W6GF
         24mylDjHeTyhV7cnzBPGSJgeWB+EDtwW8mou+N0UAYHxHnWpkhkaHjQRWPKYVwwL5Zd8
         KKhaEa7VD9BIsLovkA0Eeav6QUaXdjt6OrI+Oif0GKh0leOxWWiy26Blnp4U2s7G1Do6
         kYoSVdp0nFFfNd784hKoKl/MJ5+z2jEWuwiagLWyLVjHGLKdGyW+N++Fajwe1B05cqYV
         zOKdp07I0Sjj8dtxYAqywLmP0DyF4qwQ+/pY53lOiH1Q2DbNWCZlG/L542ie4trzUZcK
         in+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7CWd2Rx8Vc6NPJBS0gYo2M8ZKUeKMMZulpcbCZ9zB+s=;
        b=IYDvFcEWOIv2O1CqQKqJckGcFF1z6XkF0XCcJUS3EjHNDu0ODaak8EMn7ilYSnVjqG
         KSM+2jByOBd+kDfiAzzOJEydTpvlll9n2SuoKiCKOUciXLmjoMHesT/cLsVq0sHww0dL
         ShoEAxxxP8Z7cR6UC825wTzM4ARQia2Lp0uYwBHrfG6KjP26E09jIvvCCjlbPiJ/exfq
         6CebNqMPCTDvP3AFgZwFH/yY+eIGXQYMnVz5d0/myzlPGlXQFGSPcPIbi4xmYIIHpsxn
         MpmeexM6QJv3rUK+6XpxZxkCsuZ2AgPzuopef8+lJO5zWC/jYAvROpEfLG+lpCSS253Y
         g9/g==
X-Gm-Message-State: APjAAAUye8mPJ26p/xvwi7jzEjpRHmkGLE6C4hKSi2i10x8MVsawLyi9
        gqgNVFpttK4ruxbW9zHbUX4=
X-Google-Smtp-Source: APXvYqzvPBvGyLeDEA2oV/tdS9cPcN2+ZpkJ4+ocqfUYTJpr/zgBxuKiyDe1ntw4hJKNfLeNSSkj8w==
X-Received: by 2002:adf:fd43:: with SMTP id h3mr24487506wrs.169.1577628007010;
        Sun, 29 Dec 2019 06:00:07 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r6sm42068829wrq.92.2019.12.29.06.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 06:00:06 -0800 (PST)
Date:   Sun, 29 Dec 2019 15:00:05 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 09/13] exfat: add misc operations
Message-ID: <20191229140005.qrffmjnmizstjkh4@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062737epcas1p3c0f9e408640148c9186b84efc6d6658b@epcas1p3.samsung.com>
 <20191220062419.23516-10-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="o5ddwdsvztwdyzxl"
Content-Disposition: inline
In-Reply-To: <20191220062419.23516-10-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--o5ddwdsvztwdyzxl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 20 December 2019 01:24:15 Namjae Jeon wrote:
> This adds the implementation of misc operations for exfat.
>=20
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/misc.c | 240 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 240 insertions(+)
>  create mode 100644 fs/exfat/misc.c
>=20
> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
> new file mode 100644
> index 000000000000..2fa182cd4ff2
> --- /dev/null
> +++ b/fs/exfat/misc.c

=2E..

> +/* Convert linear UNIX date to a FAT time/date pair. */
> +void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64 *t=
s,
> +		struct exfat_date_time *tp)
> +{
> +	time_t second =3D ts->tv_sec;
> +	time_t day, month, year;
> +	time_t ld; /* leap day */
> +
> +	if (!sbi->options.tz_utc)
> +		second -=3D sys_tz.tz_minuteswest * SECS_PER_MIN;
> +
> +	/* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
> +	if (second < UNIX_SECS_1980) {
> +		tp->second  =3D 0;
> +		tp->minute  =3D 0;
> +		tp->hour =3D 0;
> +		tp->day  =3D 1;
> +		tp->month  =3D 1;
> +		tp->year =3D 0;
> +		return;
> +	}
> +#if (BITS_PER_LONG =3D=3D 64)
> +	if (second >=3D UNIX_SECS_2108) {
> +		tp->second  =3D 59;
> +		tp->minute  =3D 59;
> +		tp->hour =3D 23;
> +		tp->day  =3D 31;
> +		tp->month  =3D 12;
> +		tp->year =3D 127;
> +		return;
> +	}
> +#endif

Hello! Why is this code #if-ed? Kernel supports 64 bit long long
integers also for 32 bit platforms.

Function parameter struct timespec64 *ts is already 64 bit. so above
#if-code looks really suspicious.

> +
> +	day =3D second / SECS_PER_DAY - DAYS_DELTA_DECADE;
> +	year =3D day / 365;
> +
> +	MAKE_LEAP_YEAR(ld, year);
> +	if (year * 365 + ld > day)
> +		year--;
> +
> +	MAKE_LEAP_YEAR(ld, year);
> +	day -=3D year * 365 + ld;

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--o5ddwdsvztwdyzxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgixYwAKCRCL8Mk9A+RD
UrL7AKCCZpXpghQmLjXT12GlDiQnZrtZqQCeOtO1ZAc8ycv+mwxPtum98ybnRT8=
=FbCv
-----END PGP SIGNATURE-----

--o5ddwdsvztwdyzxl--
