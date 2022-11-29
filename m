Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876AE63C1E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 15:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiK2OIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 09:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiK2OIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:08:40 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8659FC3;
        Tue, 29 Nov 2022 06:08:39 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q1so13080217pgl.11;
        Tue, 29 Nov 2022 06:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ/bUcZ+q8UKc+ToUuazZO/2MnH+YvwAovh+6rdU0YE=;
        b=JuVPwd4MK+lTZbZeu8nsiavTSFGu8WJLVTapVFNFqNNapYwhv5zRddBU2oymfIAZVT
         yXH3eAK8fvI9SbhPTevFZTH8pWT2tSLhB1oytbE4AC2Nv8Qlmv+QKG0bM6myFKaOwHJW
         adVE4EaNYhyPosntWLkWKm929CUK10b02hoXum+lCUpMgHiuhXjyc2u0MjNtocqCmVP2
         97Oopkfm+7xlOPBI6fkGen+2fKI2t9VnU9/SsLrvZ99tvorcg57qfQqE7/cDFAtTUR16
         t2fauIii+PHfrD3nzQML1HWQsCLdHMtsqgUiE6BFLs+zzTiEzQZm/uhIi76GzXH/h0qg
         OsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ/bUcZ+q8UKc+ToUuazZO/2MnH+YvwAovh+6rdU0YE=;
        b=LPi0SIZ0toq2LoNc2NH9S8e6CRocgmQacJiB5OHAN4a6aVT44VjvhXRfSZjPI5kiPn
         wthN7LQCwB137UdAM4VYVuKgLAAygXrDKOrAXhe5qDp/r73xCF7CCbPM1Ia77DcBjdwo
         cBetdwGG06Do46UJqdwL2HeRO5FEvWcS2QUpBKrAeLSxnnFMHcFE/cP7OuaKQ77Y8bf6
         ilDpA78iICtqkaSe0x99JKsF2SwTkxjozmubcDTc8o0Z8A5NXuvcUwsBCJpIfmgZ7BU6
         RTqqIkn1XXozhiKn0MAUHvUp400NasI16fUShrF4wN85mX1Fvok90mcnVLAO1Rg6BS6j
         5Y/A==
X-Gm-Message-State: ANoB5plOqYUhqYL0aSTTAxYlY0YOqEH2jeOiwJN/4xZNjvUzrJzmnRBk
        x6OY6ySkbim+Yo4fLCHDAZPjViCWrl8=
X-Google-Smtp-Source: AA0mqf5cxIi0oNxyucc8vSoJFRQQCx78ZL6xuSggFFjGtieMlhMmxQCnX3KbGYsTiHPAJv5jx242hg==
X-Received: by 2002:a63:2705:0:b0:477:4ba4:d966 with SMTP id n5-20020a632705000000b004774ba4d966mr31777486pgn.528.1669730918932;
        Tue, 29 Nov 2022 06:08:38 -0800 (PST)
Received: from debian.me (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id v13-20020a65460d000000b0047696938911sm8426983pgq.74.2022.11.29.06.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:08:38 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B11E6104369; Tue, 29 Nov 2022 21:08:33 +0700 (WIB)
Date:   Tue, 29 Nov 2022 21:08:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] composefs: Add documentation
Message-ID: <Y4YSYcqv3LdbseVy@debian.me>
References: <cover.1669631086.git.alexl@redhat.com>
 <8a9aefceebe42d36164f3516c173f18189f0d7e7.1669631086.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fo4UvxlbmVrMYP1q"
Content-Disposition: inline
In-Reply-To: <8a9aefceebe42d36164f3516c173f18189f0d7e7.1669631086.git.alexl@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--fo4UvxlbmVrMYP1q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2022 at 12:17:26PM +0100, Alexander Larsson wrote:
> This adds documentation about the composefs filesystem and
> how to use it.
>=20

Nit: s/This adds/Add/
Also, please Cc: linux-doc list for documentation patches.

> +Given such a descriptor called "image.cfs" and a directory with files
> +called "/dir" you can mount it like:
> +
> +  mount -t composefs image.cfs -o basedir=3D/dir /mnt

What about using literal code block, like below?

---- >8 ----
diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesy=
stems/composefs.rst
index a0d88cc9baf9fb..e1faaf0ca69181 100644
--- a/Documentation/filesystems/composefs.rst
+++ b/Documentation/filesystems/composefs.rst
@@ -22,7 +22,7 @@ file content from the filesystem by looking up that filen=
ame in a set
 of base directories.
=20
 Given such a descriptor called "image.cfs" and a directory with files
-called "/dir" you can mount it like:
+called "/dir" you can mount it like::
=20
   mount -t composefs image.cfs -o basedir=3D/dir /mnt
=20

> +Composefs uses `fs-verity
> +<https://www.kernel.org/doc/Documentation/filesystems/fsverity.rst>`

Use :doc: for internal linking to other documentation:

---- >8 ----
diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesy=
stems/composefs.rst
index 65a8c9889427b2..38dac5af117551 100644
--- a/Documentation/filesystems/composefs.rst
+++ b/Documentation/filesystems/composefs.rst
@@ -51,8 +51,7 @@ all mounts.
 Integrity validation
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Composefs uses `fs-verity
-<https://www.kernel.org/doc/Documentation/filesystems/fsverity.rst>`
+Composefs uses :doc:`fs-verity <fsverity>`
 for integrity validation, and extends it by making the validation also
 apply to the directory metadata.  This happens on two levels,
 validation of the descriptor and validation of the backing files.

> +
> +Expected use-cases
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

Sphinx reported underline too short warning, so you need to match the under=
line
length with title text:

---- >8 ----
diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesy=
stems/composefs.rst
index 75fbf14aeb3355..65a8c9889427b2 100644
--- a/Documentation/filesystems/composefs.rst
+++ b/Documentation/filesystems/composefs.rst
@@ -72,7 +72,7 @@ files. This means any (accidental or malicious) modificat=
ion of the
 basedir will be detected at the time the file is used.
=20
 Expected use-cases
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Container Image Storage
 ```````````````````````

> +Mount options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +`basedir`: A colon separated list of directories to use as a base when r=
esolving relative content paths.
> +`verity_check=3D[0,1,2]`: When to verify backing file fs-verity: 0 =3D=
=3D never, 1 =3D=3D if specified in image, 2 =3D=3D always and require it i=
n image.
> +`digest`: A fs-verity sha256 digest that the descriptor file must match.=
 If set, `verity_check` defaults to 2.

Use definition list for list of options and its descriptions:

---- >8 ----
diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesy=
stems/composefs.rst
index 38dac5af117551..a0d88cc9baf9fb 100644
--- a/Documentation/filesystems/composefs.rst
+++ b/Documentation/filesystems/composefs.rst
@@ -112,9 +112,17 @@ all directory metadata and file content is validated l=
azily at use.
 Mount options
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-`basedir`: A colon separated list of directories to use as a base when res=
olving relative content paths.
-`verity_check=3D[0,1,2]`: When to verify backing file fs-verity: 0 =3D=3D =
never, 1 =3D=3D if specified in image, 2 =3D=3D always and require it in im=
age.
-`digest`: A fs-verity sha256 digest that the descriptor file must match. I=
f set, `verity_check` defaults to 2.
+basedir
+    A colon separated list of directories to use as a base when resolving
+    relative content paths.
+
+verity_check=3D[0,1,2]
+    When to verify backing file fs-verity: 0 =3D=3D never; 1 =3D=3D if spe=
cified in
+    image; 2 =3D=3D always and require it in image.
+
+digest
+    A fs-verity sha256 digest that the descriptor file must match. If set,
+    verity_check defaults to 2.
=20
=20
 Filesystem format

Finally, you need to add the documentation to table of contents for filesys=
tem
documentation:

---- >8 ----
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystem=
s/index.rst
index bee63d42e5eca0..9b7cf136755dce 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -75,6 +75,7 @@ Documentation for filesystem implementations.
    cifs/index
    ceph
    coda
+   composefs
    configfs
    cramfs
    dax
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--fo4UvxlbmVrMYP1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4YSXQAKCRD2uYlJVVFO
oz2HAP91ZWwG+0hgk38m+7EhZKNFot318jInA34kqYNBpkLy3wEArQK7LihJ+m4m
9ps0sV6LA0KsR8km5fh3KxhGC+IldwA=
=7Jn1
-----END PGP SIGNATURE-----

--fo4UvxlbmVrMYP1q--
