Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA60237BE5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhELNlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:41:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58292 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhELNlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:41:51 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcelo.cerri@canonical.com>)
        id 1lgp6Q-0008Uv-TR
        for linux-fsdevel@vger.kernel.org; Wed, 12 May 2021 13:40:43 +0000
Received: by mail-qt1-f200.google.com with SMTP id d16-20020ac811900000b02901bbebf64663so15767953qtj.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 06:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VYEKXVkN9u3lnA8zpQDxYechXjs5duJFmHltUQ/NB4s=;
        b=gnvh8326sGEMG5t44ImBjBlTQecRzBAE39UHbQI79503P7EtpLmmfwmUolyKPJZgTB
         F8+GSUzDCBs6KUzn7DFs29/DBAZu84QUQsuHItEaumfJRnb4KLnjbt/T/Gvm6U7g4uZV
         uQOnudfo1k6DuASs5FDPeqAjAOTATJzeVxHkm2Ja3ffZGrS7eXq0PUCMIMFGJ/naiB4r
         jw954aA9awhINhL/+djNoNxwkN6F+h7n3xvqYaJVllitGQxP57pR2Vh7Xl1g+GSc0izc
         zLod32uIjsOwEkX4rTXsDQZMgbATUZjOZPrj/bsWDT1ygYzldzPFTFJJd2Y2lnjQ/yXm
         Lxtw==
X-Gm-Message-State: AOAM532TAfcKR3wMhS7XCsfzT3+EPKdhPMMbUynjZNaomz7PggzXLJcA
        e9+RhL6UUWEWfj3nQK/ifs51qOM7NLlvLxrRR1JimFNDHvskdy+eGuacUBz/73Jw1iEoVd9bRfm
        v6w6Q9zw7gaURC59zEj6o0K6YD1QUoyeuDikbsloLkA==
X-Received: by 2002:a05:620a:1223:: with SMTP id v3mr33044803qkj.470.1620826841536;
        Wed, 12 May 2021 06:40:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYMCQdKqrTPM1xrqTM/HYTuLKjjXoE5ZhUvwWQALMlRohWX0j8daLxdeZ7O6ehUNllPB8dlw==
X-Received: by 2002:a05:620a:1223:: with SMTP id v3mr33044771qkj.470.1620826841209;
        Wed, 12 May 2021 06:40:41 -0700 (PDT)
Received: from valinor ([177.76.120.156])
        by smtp.gmail.com with ESMTPSA id s5sm21781qkg.88.2021.05.12.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:40:40 -0700 (PDT)
Date:   Wed, 12 May 2021 10:40:35 -0300
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, David Disseldorp <ddiss@suse.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Helge Deller <deller@gmx.de>, Oleg Nesterov <oleg@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: Avoid mixing integer types in mem_rw()
Message-ID: <20210512134035.3i2laytgxftfxfhw@valinor>
References: <20210512125215.3348316-1-marcelo.cerri@canonical.com>
 <YJvV3jsotDj5COKe@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jwishfqnt62764ng"
Content-Disposition: inline
In-Reply-To: <YJvV3jsotDj5COKe@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--jwishfqnt62764ng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 04:19:26PM +0300, Alexey Dobriyan wrote:
> On Wed, May 12, 2021 at 09:52:12AM -0300, Marcelo Henrique Cerri wrote:
> > Use size_t when capping the count argument received by mem_rw(). Since
> > count is size_t, using min_t(int, ...) can lead to a negative value
> > that will later be passed to access_remote_vm(), which can cause
> > unexpected behavior.
> >=20
> > Since we are capping the value to at maximum PAGE_SIZE, the conversion
> > from size_t to int when passing it to access_remote_vm() as "len"
> > shouldn't be a problem.
>=20
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -854,7 +854,7 @@ static ssize_t mem_rw(struct file *file, char __use=
r *buf,
> >  	flags =3D FOLL_FORCE | (write ? FOLL_WRITE : 0);
> > =20
> >  	while (count > 0) {
> > -		int this_len =3D min_t(int, count, PAGE_SIZE);
> > +		size_t this_len =3D min_t(size_t, count, PAGE_SIZE);
>=20
> As much as I don't like signed integers, VFS caps read/write lengths
> at INT_MAX & PAGE_MASK, so casting doesn't change values.

Although that should always be true we had a recent example of a
caller that wasn't properly capping it and since count is unsigned
anyway it makes sense to keep this value positive which might mitigate
similar issues in the future.

--=20
Regards,
Marcelo


--jwishfqnt62764ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEExJjLjAfVL0XbfEr56e82LoessAkFAmCb2tIACgkQ6e82Loes
sAn06wwAtuYnkjrJ4+IavVS7V1Toe6u0unn+Icxr1imFAyRvC0npZomI+84WjTOa
CjDXgtZ/wyQeMHt6FXrvG6ILerUVaIME611jJ4PM9GbtRgRQ1CwdWTIbKlEgJ8PT
3K5ZRV6H0a2VzNipDYJ7ZrnbG44Hhltz0yk4ZsMNnOVQZzL8DWrUQvaFs0cafQPj
G4FpScJYv1ZwGXAAHHaKy7da7BnnlQ84pqzV5I12N/siWXaVgZHbS6sq87r/A8f3
gcbln0tTfKis6eMdDRibqxJv2o/pcUDlWNwqgUqf83SbKe79tkHxj1jBNpq2yIFh
RMFPUFle+4iKBXjgk610+CKeaUH2Q4RE46wGkkTjCVplg5P1FuTXDuwR+kWQNX4G
Kp9+vA2Oc2QhWmPZDvn2c4I2zfmiIgEdDKqNrQwU1D7IBCrCjhhCWU9KEBwUinRT
LDXLCAKNkd5AlqQpwrxjgy08Sql/YqeFiWXhCuwdbH0ymWUDcT1s0GJENNd70QWQ
ZiQToyGr
=YWms
-----END PGP SIGNATURE-----

--jwishfqnt62764ng--
