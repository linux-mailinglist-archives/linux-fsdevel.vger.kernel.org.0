Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2A2A2230
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 23:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgKAW2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 17:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgKAW2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 17:28:09 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84BDC061A47
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2020 14:28:03 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id m8so6880214ljj.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2020 14:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jasiak-xyz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DMTV4qSTXxTsyRh79hlPaHDlwv+MDWJQbcfZIs8RYf0=;
        b=gBvoLkPk3+d2TToeRJtqTKN5julOkqomoTGzRtGzRlNOENsQr7sU4EVV0o2ClIyz+w
         Z2l+6ag18lKZMXY1whrSCc/fFubFsgQQGYqS+/elAH8IyRqUzQPzbbiJtIAaX3K9i0bN
         GhugijmGKZ5HbgDpIh0UIaufZIdPIiN23WiI4Aop0KvS5g/JfreWUjHdkHf/cnevtQNK
         YSqjDmJT9uFqLN5VF+lLk99TYIN/pX8c7ZEEYLiCVYYnTbDwDeUEckHN7sdJ/Af647tx
         8Nq0T5ISO9AtmlRuSStMc0PoUETxHlX+3ZwjyMPxU7Y3+8FH/gfJhYlwgLnyz/N2rA9Q
         UFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DMTV4qSTXxTsyRh79hlPaHDlwv+MDWJQbcfZIs8RYf0=;
        b=a7/mB9tkBhIQ1NFMa8mwvatdIZPnNy4zB6Gte6rXW4QrmZwSrELxS1Oq3RfD/7zZVI
         L39RDpPPVwMq6f4EE/VuyDCffQ0wYMk7B+uWB2H6pjKTZyXGGs1HF61j25N0Dlv1oCo5
         VUn09xr+KxrojEkZxv7BXmzJuODrPq023OnqYy7QwPTc0dJECj2Tc6KIG4qS5+F0xYxb
         F8gUl+j7u+WhDKdUMVA7aImXE1P9w7ilAaxDD3y/MylAlw5f7XY6zIhws3T1xO4LV0ds
         efjc6uc0xeIVKqH00nxH47Z/BW/7htSSc95fb/w1W8OAZREhCJEvsZe9NpVBhGJkiTvS
         MtWw==
X-Gm-Message-State: AOAM531lBqGUdGYoqJUebstXvMHJs1W0APzuEzJGDrU3Aux8FRNYiOSj
        MUxHBfJSMJoL1XjufPdH9Jlqcg==
X-Google-Smtp-Source: ABdhPJwWNBJgbJ2s1C6/dTWKArKzJEVQH9+8NQfHA1q7r2ZYhapmFE7yGCkyt7EJAB3N2WlYaK5cwA==
X-Received: by 2002:a2e:9b58:: with SMTP id o24mr4878374ljj.94.1604269682141;
        Sun, 01 Nov 2020 14:28:02 -0800 (PST)
Received: from gmail.com (wireless-nat-78.ip4.greenlan.pl. [185.56.211.78])
        by smtp.gmail.com with ESMTPSA id z26sm1999353ljm.121.2020.11.01.14.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 14:28:01 -0800 (PST)
Date:   Sun, 1 Nov 2020 23:27:59 +0100
From:   =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201101222759.GA25654@gmail.com>
References: <20201101212738.GA16924@gmail.com>
 <20201101213845.GH27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20201101213845.GH27442@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/11/20, Matthew Wilcox wrote:
> On Sun, Nov 01, 2020 at 10:27:38PM +0100, Pawe=C5=82 Jasiak wrote:
> > I am trying to run examples from man fanotify.7 but fanotify_mark always
> > fail with errno =3D EFAULT.
> >=20
> > fanotify_mark declaration is
> >=20
> > SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
> > 			      __u64, mask, int, dfd,
> > 			      const char  __user *, pathname)
>=20
> Don't worry about that.  You aren't calling the SYSCALL, you're calling
> glibc and glibc is turning it into a syscall.
>=20
> extern int fanotify_mark (int __fanotify_fd, unsigned int __flags,
>                           uint64_t __mask, int __dfd, const char *__pathn=
ame)
>=20
> > When=20
> >=20
> > fanotify_mark(4, FAN_MARK_ADD | FAN_MARK_ONLYDIR,
> >               FAN_CREATE | FAN_ONDIR, AT_FDCWD, 0xdeadc0de)
>=20
> The last argument is supposed to be a pointer to a string.  I'm guessing
> there's no string at 0xdeadc0de.

You are right but it's not a problem. 0xdeadc0de is just a _well
known_ address here only for debug purpose.

pathname inside kernel should be a pointer to string located in
user space at 0xdeadc0de but it is equal to 0xffffff9c which is
AT_FDCWD.

If you call

fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_ONLYDIR, FAN_CREATE |
              FAN_ONDIR, AT_FDCWD, argv[1]);

=66rom example with *valid* pointer at argv[1] you still get EFAULT
because pathname is equal to AT_FDCWD in kernel space -- last argument
is not used.

In my example in user space we have
    fanotify_fd =3D 4
    flags       =3D 0x9
    mask        =3D 0x40000100
    dfd         =3D 0xffffff9c
    pathname    =3D 0xdeadc0de

and in kernel space we have
    fanotify_fd =3D 4
    flags       =3D 0x9
    mask        =3D 0x40000100
    dfd         =3D 0
    pathname    =3D 0xffffff9c

So all arguments after __u64 mask are shifted by one.

It looks similar to https://lists.linux.it/pipermail/ltp/2020-June/017436.h=
tml

--=20

Pawe=C5=82 Jasiak

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEENIqkLxDcCMlLMdi0FzfmQudzVTgFAl+fNmwACgkQFzfmQudz
VTjRZhAA4fB7nZEsrAZKgFmixIZd5ROhKQIcstuQhSmfyve0iAWRyOS7XzxtNG98
u2qsUkddRorMb2RCp/Tns6zGrUsFQCv+Yy74Td/w91r/GjCHCDdVCq4bU9q1tlsj
DGKLCYLVxzFr5h41/xn3TJ9FSMwZI4y+b08FcUKNdclA/jzT1RTzoNPo1q4iSTlI
baF4Hx/kalIM7F7qV2zGgXnhTd45uDMJv8UAUN1Ky7h6wHCjZ/DzcBbn1WWGWmyw
zJYSybXbAUhBj8VJUHuuubB9zDUWAcohBQ2JmwjxawIgDHmgJ3FLqNx3hkoY8WC6
G7f4gTZbqR7vWbgSEHsM9lg6vVH4VOSaSxvtwJOlB80wc6fTBi/cC/PyUBIP/KDI
8wl7003QMJI4UcrbojE+0QhWxFPRdH364qdGDlcb7B2/q9ckYuy/r5Oe10jVt/k+
f6lvGbXmveehYSgD5KWmF0LjrqtGL0m1EbxaeeJcTimcGCdBHJwxPDQ5tFXk7SM2
hkm2Xl++Jhk7gOrO4dYxrebgOkwYpyoMAPtwHZ2P4GGMdJUOM2FB8Jy2bEvMeeF4
eGsblO2Zy6V5KHRRNq8jt03jc24XDS7OJoiA5vN3RHV58UgLFfeVz6QemuBsInwL
9RC/ebRA8GBZXL6L8mVftY0olWjItiwgDVHwlLceUY/pIjPa1is=
=Dvh3
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
