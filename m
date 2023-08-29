Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B678CECB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 23:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjH2VdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbjH2VdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:33:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805A3CC0;
        Tue, 29 Aug 2023 14:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CDA260F95;
        Tue, 29 Aug 2023 21:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693A3C433C7;
        Tue, 29 Aug 2023 21:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693344780;
        bh=Z1HLwC+DKPh+wUb2qDDStTjYptSvd1e7Ne4oMWLoFVI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GjLu7Nen589+QjhnRfbFLDINhz6oeswp5F+UsoD1rpeHJSU6Ddg4TxXoO5Kb8uGft
         nJKK+pB/P+50PYxtgjr+xmltCYWO7Jw7qfKDLzYpB5wMWWKu5AFLTrNAm1R8Ug/gpM
         L4+oBeSI4wjv3s0vwPS+AC5V/3hfp4HChF1RfGffwV5CDTjs/cWXVnHIpTGvSQ+4Cz
         enjceRH0zUUmvovWbaKzJ4hEWFEEAiS+aa0vaVQPFF6ryTIut4J9Pg1VNX/jx3Ioba
         mxy7+HX2R4d2weNfjamvaD/8zaX5++OSho0eUObHBEIZq32xmV2bsyfra0vEqp4dsq
         apUPWCO08gC9A==
Message-ID: <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>
Date:   Tue, 29 Aug 2023 23:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/3] user_namespaces.7: Document pitfall with negative
 permissions and user namespaces
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>, serge@hallyn.com,
        christian@brauner.io, ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com
Cc:     acl-devel@nongnu.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com
References: <20230829205833.14873-1-richard@nod.at>
 <20230829205833.14873-3-richard@nod.at>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <20230829205833.14873-3-richard@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zsvM34VtaP1zNF0rIDbMeN3H"
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
--------------zsvM34VtaP1zNF0rIDbMeN3H
Content-Type: multipart/mixed; boundary="------------s8C16SAcWsgMs0SiKDHpQds4";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Richard Weinberger <richard@nod.at>, serge@hallyn.com,
 christian@brauner.io, ipedrosa@redhat.com, gscrivan@redhat.com,
 andreas.gruenbacher@gmail.com
Cc: acl-devel@nongnu.org, linux-man@vger.kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ebiederm@xmission.com
Message-ID: <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>
Subject: Re: [PATCH 2/3] user_namespaces.7: Document pitfall with negative
 permissions and user namespaces
References: <20230829205833.14873-1-richard@nod.at>
 <20230829205833.14873-3-richard@nod.at>
In-Reply-To: <20230829205833.14873-3-richard@nod.at>

--------------s8C16SAcWsgMs0SiKDHpQds4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 2023-08-29 22:58, Richard Weinberger wrote:
> It is little known that user namespaces and some helpers
> can be used to bypass negative permissions.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> This patch applies to the Linux man-pages project.
> ---
>  man7/user_namespaces.7 | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/man7/user_namespaces.7 b/man7/user_namespaces.7
> index a65854d737cf..4927e194bcdc 100644
> --- a/man7/user_namespaces.7
> +++ b/man7/user_namespaces.7
> @@ -1067,6 +1067,35 @@ the remaining unsupported filesystems
>  Linux 3.12 added support for the last of the unsupported major filesys=
tems,
>  .\" commit d6970d4b726cea6d7a9bc4120814f95c09571fc3
>  XFS.
> +.SS Negative permissions and Linux user namespaces
> +While it is technically feasible to establish negative permissions thr=
ough

Please use semantic newlines.

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
   Use semantic newlines
     In the source of a manual page, new sentences should  be  started
     on new lines, long sentences should be split into lines at clause
     breaks  (commas, semicolons, colons, and so on), and long clauses
     should be split at phrase boundaries.  This convention, sometimes
     known as "semantic newlines", makes it easier to see  the  effect
     of  patches,  which often operate at the level of individual sen=E2=80=
=90
     tences, clauses, or phrases.

> +DAC or ACL settings, such an approach is widely regarded as a suboptim=
al
> +practice. Furthermore, the utilization of Linux user namespaces introd=
uces the

Two spaces after period, if at all.  But note that semantic newlines
preclude that possibility.

> +potential to circumvent specific negative permissions.  This issue ste=
ms
> +from the fact that privileged helpers, such as
> +.BR newuidmap (1) ,

Thas second space is spurious.

> +enable unprivileged users to create user namespaces with subordinate u=
ser and
> +group IDs. As a consequence, users can drop group memberships, resulti=
ng
> +in a situation where negative permissions based on group membership no=
 longer
> +apply.
> +

Use .PP instead of blanks.

> +Example:
> +.in +4n
> +.EX
> +$ \fBid\fP
> +uid=3D1000(rw) gid=3D1000(rw) groups=3D1000(rw),1001(nogames)
> +$ \fBunshare -S 0 -G 0 --map-users=3D100000,0,65536 --map-groups=3D100=
000,0,65536 id\fP
> +uid=3D0(root) gid=3D0(root) groups=3D0(root)

This example is not working:

$ echo bar > foo
$ sudo chmod g=3D foo
$ sudo chown man foo
$ ls -l foo
-rw----r-- 1 man alx 4 Aug 29 23:28 foo
$ cat foo=20
cat: foo: Permission denied
$ id
uid=3D1000(alx) gid=3D1000(alx) groups=3D1000(alx),24(cdrom),25(floppy),2=
9(audio),30(dip),44(video),46(plugdev),108(netdev),115(lpadmin),118(scann=
er)
$ unshare =E2=80=90S 0 =E2=80=90G 0 =E2=80=90=E2=80=90map=E2=80=90users=3D=
100000,0,65536 =E2=80=90=E2=80=90map=E2=80=90groups=3D100000,0,65536 id
unshare: failed to execute =E2=80=90S: No such file or directory


> +.EE
> +.in
> +
> +User rw got rid of it's supplementary groups and can now access files =
that
> +have been protected using negative permissions that match groups such =
as \fBnogames\fP.
> +Please note that the
> +.BR unshare (1)
> +tool uses internally
> +.BR newuidmap (1) .
> +

Cheers,
Alex

>  .\"
>  .SH EXAMPLES
>  The program below is designed to allow experimenting with

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------s8C16SAcWsgMs0SiKDHpQds4--

--------------zsvM34VtaP1zNF0rIDbMeN3H
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTuZAgACgkQnowa+77/
2zJGgBAAi6DkeYdXHggSkasph0pRi40NkxQYBaILIPC11rwqsxCK8HX1NAWQtiXD
rAV5YCIbgTxlSTXAMQmVXxmNbXHn1gVcITKpvdViWGRSl9Rpx0ZhoAzyZP6mF7Pf
orW+3fH0zRwfUIQEr/rXvvqHkqXhBT6Lu13mHJV+trDstFE/anIABCzCM2j+4hWj
WzpAJ9aQKfdmlgBzYXT7Q+7CafDeqlf75V4sTFwakpDxVt4OZCicdNi9Qkm7Y+ov
/zm8duS3UJjCjy0eohslbaIqev0g0FrELuBZ6rIYHdnU9fnmXOyGR8N0/2GzWRSb
hZaAD2+wZmG0xAuU2o1PmcVaU1YhyvqqVS6Q6c0lE/IiBWhOnSn+g8i6jhFOQJAE
DvJ74u6WdsSrSiE3MGoU7kdtq1hmwdawahTbcklMCIs/6cJFvGtHhAJxEncJt/sE
NdhiaKNgUxdqhgywdwQqkXhAMdyYEEIn18+w/KPE59XoAxauh7N49ve7JVh7sdgD
m4wuTa5dHTrabyX3oNSvuLa7RYmwYL5nTEwauhqeZPljE52NSUF6tO/QyAunBVRb
5oZG+F0I3QAAL8O964rfKcCZadTFdUC66jG57yhl1CpL1q51hlgo5rJUlUQpqLP0
U+Sw123e8aQwSkQWBQVoI2tOUG/8j0RiA/zK7C9HXsh+FHYTFzY=
=0kac
-----END PGP SIGNATURE-----

--------------zsvM34VtaP1zNF0rIDbMeN3H--
