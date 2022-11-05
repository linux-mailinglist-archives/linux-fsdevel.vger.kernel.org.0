Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5098361D925
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Nov 2022 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKEJeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Nov 2022 05:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKEJeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Nov 2022 05:34:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D402FC07;
        Sat,  5 Nov 2022 02:34:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so10285045pjc.3;
        Sat, 05 Nov 2022 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUeB1wxwElA3aU1LB1KCP8hHPZ77G0BqrxE34Pw9il0=;
        b=DG4aT/WxsEYDkYDEQxTOXS7q8vHLOyEO/uj+tBuwJI7Gf6FYQcEI3ymvAahj2azh66
         8drK0z5ZhBZmHagLhgti7LhYkid3BGk/uXURcd+V0Fu7mdzFKqi+7QvMuZ4XEsU3FckX
         9CVXVizm8h1tSwLNC7phGOfzR4LgPoVoBMR/5FghmgBj+c81TQBoBha+CeceBUqcV9oG
         //ExBqFUH98era++tIN0uHYp81/p4+t4r3bRB/PGP+q94N3Dp6GfknG8tY4x3ZopCf66
         Z1TYVmzZTrk/FojaOmw8m/WEuJE8SohAWh4zPLrBu1HRKKsrnKqh3ghK5h4i+pH9dy+X
         nW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUeB1wxwElA3aU1LB1KCP8hHPZ77G0BqrxE34Pw9il0=;
        b=WVG4t0AAmmPupjS+13/7x3ZcA90cPnx3dYaXt3cTabgZhIbMua07yDP/hZ/HZYww6t
         LorCHqCUiZaJyQ+waCBoETw0EL2i6EVb9/wSjP5NngF6dC0k40NBbWu3xV8v4GKzxXZN
         MKGQUa5TMeQWjR/GLs2v51PLkr90f624NHAme5tlDLVzPPfeporXYn75u5w/eseCR7kE
         r5j/1zGuMSFSAtti0ifSVyRHuWBm1qgRKzqfEa7wxvDrnisSSkeWKz9wTvZNCqzV4t9V
         Re1jnmMeaKmQ0UD6908gYoBXMveOyG6CcL/BRooxjfOnsbN/zuUAwtptRJ+LmQLUhCzN
         GbBw==
X-Gm-Message-State: ACrzQf10dWN8HI4OhU+kuA2IleLe7B4rGuY5CgZ/vpJ0vWnx3Jiyfyew
        VRATCegHjEYZ6SeCJb33mzs=
X-Google-Smtp-Source: AMsMyM7o+xG/DHwr/irwiuAo0sjuhrxPhigy9HbbCc5RG6Iiz0G6wbIvOGGzAIILbhx/o+me6tgjnw==
X-Received: by 2002:a17:902:f252:b0:186:9efb:7203 with SMTP id j18-20020a170902f25200b001869efb7203mr39101549plc.12.1667640849834;
        Sat, 05 Nov 2022 02:34:09 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id e38-20020a631e26000000b0046497308480sm921374pge.77.2022.11.05.02.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 02:34:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 97F4310400E; Sat,  5 Nov 2022 16:34:05 +0700 (WIB)
Date:   Sat, 5 Nov 2022 16:34:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, hughd@google.com,
        hannes@cmpxchg.org, david@redhat.com, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: anonymous shared memory naming
Message-ID: <Y2YuDfQbAwtLRLq4@debian.me>
References: <20221105025342.3130038-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FQfVBk6NiV0tGkMf"
Content-Disposition: inline
In-Reply-To: <20221105025342.3130038-1-pasha.tatashin@soleen.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--FQfVBk6NiV0tGkMf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 05, 2022 at 02:53:42AM +0000, Pasha Tatashin wrote:
> Since:
> commit 9a10064f5625 ("mm: add a field to store names for private anonymous
> memory")
>=20
> We can set names for private anonymous memory but not for shared
> anonymous memory. However, naming shared anonymous memory just as
> useful for tracking purposes.
>=20

Who are "we"?

Instead, say "Since commit <commit>, name for private anonymous memory,
but not shared anonymous, can be set".

> @@ -431,8 +431,10 @@ is not associated with a file:
>   [stack]                    the stack of the main process
>   [vdso]                     the "virtual dynamic shared object",
>                              the kernel system call handler
> - [anon:<name>]              an anonymous mapping that has been
> + [anon:<name>]              a private anonymous mapping that has been
>                              named by userspace
> + path [anon_shmem:<name>]   an anonymous shared memory mapping that has
> +                            been named by userspace
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> =20

The table above triggers Sphinx warning:

Documentation/filesystems/proc.rst:436: WARNING: Malformed table.
Text in column margin in table line 8.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[heap]                     the heap of the program
[stack]                    the stack of the main process
[vdso]                     the "virtual dynamic shared object",
                           the kernel system call handler
[anon:<name>]              a private anonymous mapping that has been
                           named by userspace
path [anon_shmem:<name>]   an anonymous shared memory mapping that has
                           been named by userspace
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

I have applied the fixup:

---- >8 ----

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems=
/proc.rst
index 8f1e68460da5cd..3f17b4ef307fe4 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -426,7 +426,7 @@ with the memory region, as the case would be with BSS (=
uninitialized data).
 The "pathname" shows the name associated file for this mapping.  If the ma=
pping
 is not associated with a file:
=20
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [heap]                     the heap of the program
  [stack]                    the stack of the main process
  [vdso]                     the "virtual dynamic shared object",
@@ -435,7 +435,7 @@ is not associated with a file:
                             named by userspace
  path [anon_shmem:<name>]   an anonymous shared memory mapping that has
                             been named by userspace
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
  or if empty, the mapping is anonymous.
=20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--FQfVBk6NiV0tGkMf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2YuCAAKCRD2uYlJVVFO
oz9oAPwKlsfNy7oaWuFtBZRtmLiAWjuEXXO/oYQ+eLkQNog6eQEAgqNvsaT5kEro
1QjKBz5gzd7Eh3lTYQX3y9Kbt/pH/QI=
=lgY4
-----END PGP SIGNATURE-----

--FQfVBk6NiV0tGkMf--
