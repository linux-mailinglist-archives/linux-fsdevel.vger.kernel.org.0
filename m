Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B12D2A21E4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 22:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgKAV1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 16:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgKAV1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 16:27:50 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE33C061A04
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2020 13:27:44 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id i2so12864019ljg.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2020 13:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jasiak-xyz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IUm+02MidsojlW5fyhf8cyxyEKcWd8Rt8ToY5UOJ6+c=;
        b=r/6jxWRTfzY9FsqcnXJQy77Mw37FtnqSARc80Oobr0rtdIVwtgVg75l9ciELrr/LAt
         jUo/l/eofutem8pjSyUxCJdGEHkMjF6+tAzpG4rkYg0xpM1YUwfVpc4d4w5iiQNXq5Cl
         VmYCqtVQoOOGzGqox79vueHBsBu+2Vi4zPGfGD34xkJnuM1Z8SpLGfyLfsignymSVGk5
         CdxH+YhXMuDcbbfRlbn5pIHIKHouQmwvrcE6ilwMKo0PwXCbHb7AiIib2DzxC/RYcP+F
         8nXgy8SGw5U61oxJopexk2Gl0YjnwC0XFlL1Mc6MuXO3Ke81Z9AVJDO5TASv7DTjSOXZ
         TsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IUm+02MidsojlW5fyhf8cyxyEKcWd8Rt8ToY5UOJ6+c=;
        b=QWFCxIA9HHSWHgtmwUci8TKqFdTKDQcUGy5ulKeSrLilbZnW4P43tNTpgeRSZqsbWX
         Z37rX69hN1OvfdztS/l5i72cv/Yn5PRKxxSaES5Skr60kcTK9vk0U3v4c64TBc/hTS8j
         bisCC0Usd8hQQEqwy4FjE71JuJXmJZXidUDYKvAxE8pyt65F4bdn2+bd6sjotsNaH/0n
         Nv7CDy5loFougAm+HO2l/9F/J+NVpNWXqBeYjmAYJ+qg3bTVVwsEszYWfoT3QcmoJzXL
         iRL0Mq7jQCZvLjwx1caBDNtF3qThb1scxau3jET8UznCtFgoas92TLWsQoRFsWpSY8ur
         9i8Q==
X-Gm-Message-State: AOAM533jivDSkcgjkyaos8YdOu2Y8YqmQfg/MbO7UX1cZCpsgdq/Bt9b
        rIPcWYJrAdvRPC07x5szaoegzISYPtvYYQ==
X-Google-Smtp-Source: ABdhPJzPz1K0xAIQ9G2rQTJ0KBMzkQ/TPdrCQS2OVtoOx476LDxuemQYL2EAPVFjzj/bIj+hfBRsWg==
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr4936139ljc.90.1604266061480;
        Sun, 01 Nov 2020 13:27:41 -0800 (PST)
Received: from gmail.com (wireless-nat-78.ip4.greenlan.pl. [185.56.211.78])
        by smtp.gmail.com with ESMTPSA id k2sm1545519lfm.13.2020.11.01.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 13:27:40 -0800 (PST)
Date:   Sun, 1 Nov 2020 22:27:38 +0100
From:   =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201101212738.GA16924@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am trying to run examples from man fanotify.7 but fanotify_mark always
fail with errno =3D EFAULT.

fanotify_mark declaration is

SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
			      __u64, mask, int, dfd,
			      const char  __user *, pathname)

When=20

fanotify_mark(4, FAN_MARK_ADD | FAN_MARK_ONLYDIR,
              FAN_CREATE | FAN_ONDIR, AT_FDCWD, 0xdeadc0de)

is called on kernel side I can see in do_syscall_32_irqs_on that CPU
context is
    bx =3D 0x4        =3D 4
    cx =3D 0x9        =3D FAN_MARK_ADD | FAN_MARK_ONLYDIR,
    dx =3D 0x40000100 =3D FAN_CREATE | FAN_ONDIR
    si =3D 0x0
    di =3D 0xffffff9c =3D AT_FDCWD
    bp =3D 0xdeadc0de
    ax =3D 0xffffffda
    orix_ax =3D 0x153

I am not sure if it is ok because third argument is uint64_t so if I
understand correctly mask should be divided into two registers (dx and
si).

But in fanotify_mark we get
    fanotify_fd =3D 4          =3D bx
    flags       =3D 0x9        =3D cx
    mask        =3D 0x40000100 =3D dx
    dfd         =3D 0          =3D si
    pathname    =3D 0xffffff9c =3D di

I believe that correct order is
    fanotify_fd =3D 4          =3D bx
    flags       =3D 0x9        =3D cx
    mask        =3D 0x40000100 =3D (si << 32) | dx
    dfd         =3D 0xffffff9c =3D di
    pathname    =3D 0xdeadc0de =3D bp

I think that we should call COMPAT version of fanotify_mark here

COMPAT_SYSCALL_DEFINE6(fanotify_mark,
				int, fanotify_fd, unsigned int, flags,
				__u32, mask0, __u32, mask1, int, dfd,
				const char  __user *, pathname)

or something wrong is with 64-bits arguments.

I am running Linux 5.9.2 i686 on Pentium III (Coppermine).
For tests I am using Debian sid on qemu with 5.9.2 and default kernel
=66rom repositories.

Everything works fine on 5.5 and 5.4.

--=20

Pawe=C5=82 Jasiak

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEENIqkLxDcCMlLMdi0FzfmQudzVTgFAl+fKEYACgkQFzfmQudz
VTiEgQ//aiyjua4unpQBiXkKTTNgv1ICPmPSvR1YO26NKiF5oIW/EZDf1aKOdd4h
zCUR+rt74wtxbKlwIwMYokS9PJveh1H8WgWie+hmGCxR8shPZhKR3YthtuzTR6TO
t6PR2IWUA6S7gPxdh0aWrq6cQMTLJEQ5fO8W9lCBpwE5FAZH4phki5a5/K1a9YGN
uT4o++BUha1txqsnd7syKpT3o0buY2/92U2lQJQJt3Vyu1FRjif1qXIr2cyzaWPe
EmbQP9+9I8k92JycO6trj4Yd9NbtUZk+/215p9255r6yuQ4RLSkBRehfBRzPTEbp
FvKEeVQZX0tYM1B3WO+A5xqaGHKFItQOmsBJ8Bc7052ljZe4jk2GdaFc4EShUMd/
5QJpH8O+GCxbeZX5vY7ieftyRBxWIcWVPaevngpv6OV7sY3NY3ZmbIfcbbHoZkBL
PzFfvEsfEqabaL9qHV0+ZQowNxO+RFtwEwPlXCdeYBNibP16disvzzLZ81tHf8xj
6sJKUwS/aAQ3vLnk1/2b04/QVCu81wvi8GgOd/tQxHWHimjvl0i6ukC8iQlO94bU
jsZPuVtVFYbREwimgqGtI9R5vd37gGeS9Bd0o6Kyz0+PdYlo33K/GoV987djeG2P
HAPCyn5SDD7lV24x+O3/3WdxwSnsZyGqw3kXuqFPMU5OvUmHgwc=
=9KzB
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
