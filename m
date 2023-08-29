Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA078CEBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjH2V1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 17:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbjH2V0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47106CCE;
        Tue, 29 Aug 2023 14:26:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D946D6315C;
        Tue, 29 Aug 2023 21:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9830BC433C8;
        Tue, 29 Aug 2023 21:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693344386;
        bh=Tii5eDqsexWzdHdMo1oF6diwDMZLGJvcD4CJdZHqaS0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UtnSxAXjhuPYxaDQBpUDDlXagzP2plXw4Oyi7dyrnaRZ9lKkDr3dbwTNZ0lDxU7pw
         LL9hUvPTEY39z9sjx9RyGNFhOavzboniUqHDa5AbgWwM+6NiAq1lFOpEMDIRCkUp9+
         Ar3cRmhlthqPnKCkUG8OEgDoCvNhOzMeWxtK9dZ0/Ag2d1zHQK9q3tdshJUdkqJD2r
         ytt71oouL6Ii/dSCx3lS/FiUuesL7lzcaNX/3sMDQ/rDGhVWxbsYjgclDAFwWMThNq
         Rxky9QFmfI4oEXGEOOlXR+t+Xf8wfmbdRy/PukU/RqsPwMT6z0bOGUly4Q1iF9Mo5s
         PRwOqc6EJW0bg==
Message-ID: <81098c50-bfec-9aa2-a302-abfebd0ff332@kernel.org>
Date:   Tue, 29 Aug 2023 23:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 0/3] Document impact of user namespaces and negative
 permissions
To:     Richard Weinberger <richard@nod.at>, serge@hallyn.com,
        christian@brauner.io, ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com
Cc:     acl-devel@nongnu.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com
References: <20230829205833.14873-1-richard@nod.at>
Content-Language: en-US
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <20230829205833.14873-1-richard@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------j0XLYtZT96Rqh930sulaBZAi"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------j0XLYtZT96Rqh930sulaBZAi
Content-Type: multipart/mixed; boundary="------------JaecQ2NLnSLaIH3UoAbqrO6v";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Richard Weinberger <richard@nod.at>, serge@hallyn.com,
 christian@brauner.io, ipedrosa@redhat.com, gscrivan@redhat.com,
 andreas.gruenbacher@gmail.com
Cc: acl-devel@nongnu.org, linux-man@vger.kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ebiederm@xmission.com
Message-ID: <81098c50-bfec-9aa2-a302-abfebd0ff332@kernel.org>
Subject: Re: [PATCH 0/3] Document impact of user namespaces and negative
 permissions
References: <20230829205833.14873-1-richard@nod.at>
In-Reply-To: <20230829205833.14873-1-richard@nod.at>

--------------JaecQ2NLnSLaIH3UoAbqrO6v
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Richard,

On 2023-08-29 22:58, Richard Weinberger wrote:
> I'm sending out this patch series to document the current situation reg=
arding
> negative permissions and user namespaces.
>=20
> From what I understand, the general agreement is that negative permissi=
ons
> are not recommended and should be avoided. This is why the ability to s=
omewhat
> bypass these permissions using user namespaces is tolerated, as it's de=
emed
> not worth the complexity to address this without breaking exsting progr=
ams such
> as podman.
>=20
> To be clear, the current way of bypassing negative permissions, whether=
 DAC or
> ACL, isn't a result of a kernel flaw. The kernel issue related to this =
was
> resolved with CVE-2014-8989. Currently, certain privileged helpers like=

> newuidmap allow regular users to create user namespaces with subordinat=
e user
> and group ID mappings.
> This allows users to effectively drop their extra group memberships.
>=20
> I recently stumbled upon this behavior while looking into how rootless =
containers
> work. In conversations with the maintainers of the shadow package, I le=
arned that
> this behavior is both known and intended.
> So, let's make sure to document it as well.

Can you please provide a small shell session where this is exemplified?
I.e., please show how a user (or group member) can read a file with
u=3D (or g=3D ) permissions on the file.

I.e., what can you do from here?:

$ echo bar > foo
$ ls -l foo
-rw-r--r-- 1 alx alx 4 Aug 29 23:24 foo
$ chmod u=3D foo
$ sudo chmod g=3D foo
$ ls -l foo
-------r-- 1 alx alx 4 Aug 29 23:24 foo
$ cat foo
cat: foo: Permission denied


Cheers,
Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------JaecQ2NLnSLaIH3UoAbqrO6v--

--------------j0XLYtZT96Rqh930sulaBZAi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTuYnQACgkQnowa+77/
2zJQ3A/9HcHXGi2mF4dv4nah/Z4OP+QHG13oQYy+WqLZu/m5CaJMhXl2pzsUv6Wv
Vvo02JL/iaVuLGagDnOwKi3MxPdvogXn5cQKJxXomUmaGfPyMDJA2//CYtVmySiL
9MrPVOxtCvDBn6nfcjbjQL75xzmDvrfH1wqzXa0EzSvJbJE1w9Q6j9lcTQWPAtCx
amkk93zuF3rB4eYgaN1K88egesQC8JAKN1/65nzEYXXUMk1c4BjocHJvHpTwvfdP
R5TB+ZZJyWnszUg5GuhxW3n6O6VdIfx3nXxMBzv0XwQZDh5+SPZrM4ocX/dF/dkE
+YgHFbIiNx5/DFD7YlNssl0csLQrshYBGIX7PQqRNfm0E0XiTxPWuMSkX5QJhyDe
ELGDya90ZCPPEl8VPZ/txerVY1+NE9dic+Pu+MVNuZstkAJ4Vu2TSQlJPKcPqZxp
7nJ+qAOehm/Q3wcHDpJOhv6ImLz3kNFgYDEu1p8MzPgUqqUL71NQRti7X79G9zSb
PxK1w4ULKRDZL/7t25YKJ3QN+A8ERPcICzEDQPVX6v2e+Nqw/STEZewIyr+zz47C
gBj8HTd+U7j5bkADsae8hTm83yWb0lDIr4kBiG7TeGPvO578t9/vyGCY1rW7oejB
KXinfvUSv3nmgk4kcdDohMhaZW21qHi/Aomf8qvX+FZ/iY5IRJE=
=JpLv
-----END PGP SIGNATURE-----

--------------j0XLYtZT96Rqh930sulaBZAi--
