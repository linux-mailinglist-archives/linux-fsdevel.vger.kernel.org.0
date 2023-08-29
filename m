Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1FD78CEDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 23:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbjH2Vjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 17:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjH2Vjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:39:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B8A122;
        Tue, 29 Aug 2023 14:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3805C64152;
        Tue, 29 Aug 2023 21:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F53C433CA;
        Tue, 29 Aug 2023 21:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693345135;
        bh=ZhA4FB5OvyKlVDaKPDzsa6visNLSSlQIIWtelS0eVbI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=EY5oGscWqQeZNZ62ilvCiiLFBrv4c+Xtqo9d0r8EAYUMdH0mknmizr23KBItlwmec
         VyCu7MYeYoGCY9czW5VMBPy5O1UYiDvXWamrC5dUICxrHT/tv1zOrJprUwC9dDLS4H
         KlkFOLS5JdrLXf0KnfUFQFy1Xt2TisJ6Hq13jRtdxkIL4CMqGdJwg/uewUyR/HbJ+f
         F9ZGQ3qt5a9i+Zpb3pns9vnLiDjtAo2UQkUke0eeGJ0sNaQnm9TzWgEIXZHNMy3kjY
         5DbTUn6JiT7djWrpn3ufNPsM4pWnN1i8tqYIabx7XxeaU9kpQH1cirNb8SjEn0uRwf
         3W6UF9m5p28ew==
Message-ID: <34cb77d8-6513-138e-506e-82f4c66d7813@kernel.org>
Date:   Tue, 29 Aug 2023 23:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/3] user_namespaces.7: Document pitfall with negative
 permissions and user namespaces
Content-Language: en-US
From:   Alejandro Colomar <alx@kernel.org>
To:     Richard Weinberger <richard@nod.at>, serge@hallyn.com,
        christian@brauner.io, ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com
Cc:     acl-devel@nongnu.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com
References: <20230829205833.14873-1-richard@nod.at>
 <20230829205833.14873-3-richard@nod.at>
 <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>
Organization: Linux
In-Reply-To: <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NN9UVDlgElkg5CUVyL0wlPyn"
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
--------------NN9UVDlgElkg5CUVyL0wlPyn
Content-Type: multipart/mixed; boundary="------------DxVAjYEnxfqj1bT00BRr4Fyz";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Richard Weinberger <richard@nod.at>, serge@hallyn.com,
 christian@brauner.io, ipedrosa@redhat.com, gscrivan@redhat.com,
 andreas.gruenbacher@gmail.com
Cc: acl-devel@nongnu.org, linux-man@vger.kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ebiederm@xmission.com
Message-ID: <34cb77d8-6513-138e-506e-82f4c66d7813@kernel.org>
Subject: Re: [PATCH 2/3] user_namespaces.7: Document pitfall with negative
 permissions and user namespaces
References: <20230829205833.14873-1-richard@nod.at>
 <20230829205833.14873-3-richard@nod.at>
 <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>
In-Reply-To: <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>

--------------DxVAjYEnxfqj1bT00BRr4Fyz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-08-29 23:32, Alejandro Colomar wrote:
> Hi Richard,
>=20
> On 2023-08-29 22:58, Richard Weinberger wrote:
>> It is little known that user namespaces and some helpers
>> can be used to bypass negative permissions.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>> This patch applies to the Linux man-pages project.
>> ---
>>  man7/user_namespaces.7 | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/man7/user_namespaces.7 b/man7/user_namespaces.7
>> index a65854d737cf..4927e194bcdc 100644
>> --- a/man7/user_namespaces.7
>> +++ b/man7/user_namespaces.7
>> @@ -1067,6 +1067,35 @@ the remaining unsupported filesystems
>>  Linux 3.12 added support for the last of the unsupported major filesy=
stems,
>>  .\" commit d6970d4b726cea6d7a9bc4120814f95c09571fc3
>>  XFS.
>> +.SS Negative permissions and Linux user namespaces
>> +While it is technically feasible to establish negative permissions th=
rough
>=20
> Please use semantic newlines.
>=20
> $ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
>    Use semantic newlines
>      In the source of a manual page, new sentences should  be  started
>      on new lines, long sentences should be split into lines at clause
>      breaks  (commas, semicolons, colons, and so on), and long clauses
>      should be split at phrase boundaries.  This convention, sometimes
>      known as "semantic newlines", makes it easier to see  the  effect
>      of  patches,  which often operate at the level of individual sen=E2=
=80=90
>      tences, clauses, or phrases.
>=20
>> +DAC or ACL settings, such an approach is widely regarded as a subopti=
mal
>> +practice. Furthermore, the utilization of Linux user namespaces intro=
duces the
>=20
> Two spaces after period, if at all.  But note that semantic newlines
> preclude that possibility.
>=20
>> +potential to circumvent specific negative permissions.  This issue st=
ems
>> +from the fact that privileged helpers, such as
>> +.BR newuidmap (1) ,
>=20
> Thas second space is spurious.
>=20
>> +enable unprivileged users to create user namespaces with subordinate =
user and
>> +group IDs. As a consequence, users can drop group memberships, result=
ing
>> +in a situation where negative permissions based on group membership n=
o longer
>> +apply.
>> +
>=20
> Use .PP instead of blanks.
>=20
>> +Example:
>> +.in +4n
>> +.EX
>> +$ \fBid\fP
>> +uid=3D1000(rw) gid=3D1000(rw) groups=3D1000(rw),1001(nogames)
>> +$ \fBunshare -S 0 -G 0 --map-users=3D100000,0,65536 --map-groups=3D10=
0000,0,65536 id\fP
>> +uid=3D0(root) gid=3D0(root) groups=3D0(root)
>=20
> This example is not working:
>=20
> $ echo bar > foo
> $ sudo chmod g=3D foo
> $ sudo chown man foo
> $ ls -l foo
> -rw----r-- 1 man alx 4 Aug 29 23:28 foo
> $ cat foo=20
> cat: foo: Permission denied
> $ id
> uid=3D1000(alx) gid=3D1000(alx) groups=3D1000(alx),24(cdrom),25(floppy)=
,29(audio),30(dip),44(video),46(plugdev),108(netdev),115(lpadmin),118(sca=
nner)
> $ unshare =E2=80=90S 0 =E2=80=90G 0 =E2=80=90=E2=80=90map=E2=80=90users=
=3D100000,0,65536 =E2=80=90=E2=80=90map=E2=80=90groups=3D100000,0,65536 i=
d
> unshare: failed to execute =E2=80=90S: No such file or directory

Ahh, now I see it.  You should use \- to produce pastable ASCII 0x2D.

>=20
>=20
>> +.EE
>> +.in
>> +
>> +User rw got rid of it's supplementary groups and can now access files=
 that
>> +have been protected using negative permissions that match groups such=
 as \fBnogames\fP.
>> +Please note that the
>> +.BR unshare (1)
>> +tool uses internally
>> +.BR newuidmap (1) .
>> +
>=20
> Cheers,
> Alex
>=20
>>  .\"
>>  .SH EXAMPLES
>>  The program below is designed to allow experimenting with
>=20

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------DxVAjYEnxfqj1bT00BRr4Fyz--

--------------NN9UVDlgElkg5CUVyL0wlPyn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTuZWsACgkQnowa+77/
2zLE+Q//bphpqXlS+CC6OWYfBS+DPRLb2lvMNgx43UWOsxg+msYHJ6qZaTUOTTsn
wZyyXLW9RH49uWFrCilUBjiWLa+Jx/IMO79FTbCJWfsrAHm2FrZaoK36ug7pU0Bu
fqjHEZBH1F7vUaDFJ0aX3EN9Qjo6kQgyYrIdYZ/IpCMQlk1Lj8ki3RvFsxtyn2nK
VfwFmWkAk14eU95krvLjszdHsYqFf7Xvf2CsoAoLbXhjtQ+jwdBbHs+AeQXEye4g
EuFEmWjaLH5dzPOdU6dRHcW3pSL5+L2pGli6vHSL0rrKrXJdWiZv4g2fAWdA2Hzo
5c9DnCoH/Z//vJwqSfExFGD42kGmk9FVSBdOgkb24LHclqYyyfw8TIQOMf3era0V
UlWt/bM9SVdMuVFNv5OsLwmi5vxk7DfbTp88CwwtP3aWOSv69gRUpISqrECUQKiA
fRWKZZJtjP0EM8hTdBxOGh/befDBMcTCvVved/utdrzUxzGZ/hSP0Tsj7s//0Z6O
dVrhjBJl9sjwMQlhDg3jRFubLi6g/tV0cGtyrCQ7PPLykSG8mQSV+LPJrKVgYEsj
TaQNDmKIxtO/Co3PA2QGujn7NJPc/73/TrhXb/4pCX6+jnikahX8cwb9YiyiRzw5
jEkfRpN97jMIA9kAvzVs50oJ25ORWVGUi/bBFrNqEyJEK2Oyi2o=
=heP3
-----END PGP SIGNATURE-----

--------------NN9UVDlgElkg5CUVyL0wlPyn--
