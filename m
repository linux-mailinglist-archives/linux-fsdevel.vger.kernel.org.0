Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0C221873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 01:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGOXeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 19:34:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgGOXeM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:34:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 027CCB02B;
        Wed, 15 Jul 2020 23:34:15 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jul 2020 09:34:05 +1000
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/23] md: remove the autoscan partition re-read
In-Reply-To: <20200714190427.4332-7-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-7-hch@lst.de>
Message-ID: <878sfkxsia.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14 2020, Christoph Hellwig wrote:

> devfs is long gone, and autoscan works just fine without this these days.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Song Liu <song@kernel.org>

Happy to see this go!

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> ---
>  drivers/md/md-autodetect.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
> index 0eb746211ed53c..6bc9b734eee6ff 100644
> --- a/drivers/md/md-autodetect.c
> +++ b/drivers/md/md-autodetect.c
> @@ -240,16 +240,6 @@ static void __init md_setup_drive(void)
>  			err =3D ksys_ioctl(fd, RUN_ARRAY, 0);
>  		if (err)
>  			printk(KERN_WARNING "md: starting md%d failed\n", minor);
> -		else {
> -			/* reread the partition table.
> -			 * I (neilb) and not sure why this is needed, but I cannot
> -			 * boot a kernel with devfs compiled in from partitioned md
> -			 * array without it
> -			 */
> -			ksys_close(fd);
> -			fd =3D ksys_open(name, 0, 0);
> -			ksys_ioctl(fd, BLKRRPART, 0);
> -		}
>  		ksys_close(fd);
>  	}
>  }
> --=20
> 2.27.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8Pkm0ACgkQOeye3VZi
gbmvhRAAqNcDpiKiYUoh6S31+KrS0faoFbgtIelgUebGH3b9IvlXaerDxxz7ZkYE
fWQxVUfscuRjirEJ2+SRztm6SLy0as8ufCrLV6EboI4mrqSij2WqNfSrEO9A7w76
xMs0JmWrnGmz073MoI7maLYbh6dcDycSvDzcnHWGjD10kaZoNC39E4jLMtZFe4VR
IVx69GH4LEWqWcE+wq9ZqGFKZnsGxdxr5+CIZrTTiZQcWEswBixbZc0Jsz0sh3CD
tOpsCkq/nXlNc8Fo8nvyBUZuWHaPlwxMtw3xflwEJCl6CVhCKx9lRsCfnbYSD8VK
hBJvdVmLazmVpR12ISimBJTH81xMayZNhCrqv97eXwY4LsRiOAN0F+VOtTew7WKI
mHWz6jvyJLrsbuWhyDnqwSphOHcIX6UjOKhEhB9l1WRN5cwt7Cgvva6vnv7f8FBZ
Dwo6YCshQw6llozCk3DBlNyw3mzsFSOo9GO2924lloxeN4W77giK68LCDSW3Wh94
vW+elFckRQH3Er27BlT524ptXjV6XyKuOGVQJI6vWA3mOxJf5Vd99gqm6EC3wq3+
a7C5QW+MO6FUeersShdyxfulSmQ5Bye1mByD6xuo4/2nvaufKQKQyIWEaECpTTst
+LXbbfaQWZmuSy9Ps4G2ugXHgt03Ke3p3iMpIClLqY9NHa7kl9c=
=n2C8
-----END PGP SIGNATURE-----
--=-=-=--
