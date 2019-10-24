Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E252E3EAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 23:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfJXV5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 17:57:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50320 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbfJXV5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:57:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so6301wmk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q80crq6dcFo4FVg0RAcx8WwRU/EPfdre/VW0eFU98dM=;
        b=SNQgcTwGxX/niXS62JOK1k3Q0f07ugHX0l7GDKYMASpoTay+9Fnqc2VuQHPgUXJhoq
         m2HtX/VjY7TeUeeXU5coPwRTv4F9+l8+iOml1j1YW7gbb8EB2rxxSCnEnzCR9YdSfd7S
         Cf6m40JpATPgct/oz7oi/7uaLyMVHx70B4xRrUS+MK7GA88WHkdLaS/bsNvlHiLFtMTG
         sAMSaWHYDyk2h+GfAgZO20tQGyM4x43Be2/HlLksPctvCuQDhaFCDYEMGpUGPygcxcr9
         IRLCkAcIkc523BN6N+VfWu2x9nu2Ixe0Mp2S4UWoNI3cQKkd1//lLA6n7yFNayIf96Ii
         wCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q80crq6dcFo4FVg0RAcx8WwRU/EPfdre/VW0eFU98dM=;
        b=JRVHZ03ff8HETggpbKXI+65o4rwdtiMrt9M7Ua00QPGichE0E9TqaIge3J77d5uX4J
         S/DJVMXw3Rx5FUjFkSgRoqI575f1kEsWu5zlDV1dH0o5fiqZmrNhgupOIMGeco1C43Zo
         Qq89NWM9VIG8ZQatU86KGvw4UJrhgx5T34oXeXH/bua9AtU5iqjA7jQFsGs/Wx6AeMKD
         loIbjFhKbVLDX/Tw2i6JccKoNmha1YYrE88TyCAdZsYnYn3Y94lFOyxZEjnpNVd70jmq
         ZG48wwCdpJG8/Jt0efAlUvE85MVzBvd6yB81WkNzjJO9JrR6tBqcL+FPnIbhYSL6U2F0
         svog==
X-Gm-Message-State: APjAAAUdL54UT8h6iaf8Z/FjY5IoBPkyOaycBh21mydPgKB0JjJYyuLR
        0m9MkKHADACvIcJHaVvUYCM=
X-Google-Smtp-Source: APXvYqzWmMSL7QY+El/Xp8RRPZ9BzN3YoL1FNb5TdwzerErOYQJWkOQVAZpv7a8pzoSJ1fiv7ZcXUg==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr419991wmf.162.1571954271925;
        Thu, 24 Oct 2019 14:57:51 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u1sm44907wmc.38.2019.10.24.14.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 14:57:50 -0700 (PDT)
Date:   Thu, 24 Oct 2019 23:57:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Is rename(2) atomic on FAT?
Message-ID: <20191024215740.dtcudmehqvywfnks@pali>
References: <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali>
 <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali>
 <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
 <20191023171611.qfcwfce2roe3k3qw@pali>
 <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com>
 <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com>
 <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com>
 <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="55hcgvpxz234sddp"
Content-Disposition: inline
In-Reply-To: <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--55hcgvpxz234sddp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 24 October 2019 23:46:43 Chris Murphy wrote:
> So that leads me to, what about FAT? i.e. how does this get solved on FAT?

Hi Chris! I think that for FAT in most cases it used ostrich algorithm.
Probability that kernel crashes in the middle of operation which is
updating kernel image on boot partition is very low.

I'm Looking at grub's fat source code and there is no handling of dirty
bit... http://git.savannah.gnu.org/cgit/grub.git/tree/grub-core/fs/fat.c
It just expects that whole FAT fs is in consistent state.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--55hcgvpxz234sddp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXbIeUgAKCRCL8Mk9A+RD
UijiAKCp+9iYE4Hx4s+CaIzz/w33uoEdsQCeJb0T1aaocsYz2MPxbp8iqRwHUL0=
=uU9w
-----END PGP SIGNATURE-----

--55hcgvpxz234sddp--
