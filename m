Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF75878CEE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjH2Vl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbjH2Vky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF47CED;
        Tue, 29 Aug 2023 14:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6636186D;
        Tue, 29 Aug 2023 21:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A859C433C8;
        Tue, 29 Aug 2023 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693345238;
        bh=G/IXVEbHXbA/TNJfDio2u2EqSl6QI/byoc4E/Nv9cN0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bCQk3rTf7Ez3IOhyIvVhdAoR78ip8YgIYMZeHYRU+T30zLVM6ukBh5y7DYVkEvHz5
         cvvTse4kRdCkdeML65OSlWIisYrp+25eaRG9/4T9UdV6YtA4cgPV0gM8gHvgbsNP3k
         7fy3OeglHZaufir7pMNz99HCRqZPlnX2Sn3Q51UN8vSUq/noboS1O/jNKeYPwpGrXb
         siQ10pie8Q1sxbrLwnsXNqpkY2J4JwVmOCD67j5Znj8MSSD3a3DBkTJcNTpmFiybvb
         PcGyBdQUJKiwjsbxkG2lOkQYqC4lJO/huaKWVxtSvUp9AUc+bxa6gh6X7gYl3rFu5K
         t6SSRPcIypOCg==
Message-ID: <941ad196-c6ae-728c-a8d5-2a866c20114a@kernel.org>
Date:   Tue, 29 Aug 2023 23:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/3] user_namespaces.7: Document pitfall with negative
 permissions and user namespaces
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        christian <christian@brauner.io>, ipedrosa <ipedrosa@redhat.com>,
        gscrivan <gscrivan@redhat.com>,
        =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>,
        acl-devel <acl-devel@nongnu.org>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ebiederm <ebiederm@xmission.com>
References: <20230829205833.14873-1-richard@nod.at>
 <20230829205833.14873-3-richard@nod.at>
 <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>
 <300010998.1870230.1693345150665.JavaMail.zimbra@nod.at>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <300010998.1870230.1693345150665.JavaMail.zimbra@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hdbah5UsGbLpBhayX3BQA1Wr"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hdbah5UsGbLpBhayX3BQA1Wr
Content-Type: multipart/mixed; boundary="------------22zWt3urw070L00gNi9pBi0X";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, christian <christian@brauner.io>,
 ipedrosa <ipedrosa@redhat.com>, gscrivan <gscrivan@redhat.com>,
 =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>,
 acl-devel <acl-devel@nongnu.org>, linux-man <linux-man@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 ebiederm <ebiederm@xmission.com>
Message-ID: <941ad196-c6ae-728c-a8d5-2a866c20114a@kernel.org>
Subject: Re: [PATCH 2/3] user_namespaces.7: Document pitfall with negative
 permissions and user namespaces
References: <20230829205833.14873-1-richard@nod.at>
 <20230829205833.14873-3-richard@nod.at>
 <51d4691d-dbc8-2e70-edc8-3b5814213c3f@kernel.org>
 <300010998.1870230.1693345150665.JavaMail.zimbra@nod.at>
In-Reply-To: <300010998.1870230.1693345150665.JavaMail.zimbra@nod.at>

--------------22zWt3urw070L00gNi9pBi0X
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-08-29 23:39, Richard Weinberger wrote:
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Alejandro Colomar" <alx@kernel.org>
>> $ unshare =E2=80=90S 0 =E2=80=90G 0 =E2=80=90=E2=80=90map=E2=80=90user=
s=3D100000,0,65536 =E2=80=90=E2=80=90map=E2=80=90groups=3D100000,0,65536 =
id
>> unshare: failed to execute =E2=80=90S: No such file or directory
>=20
> Well, maybe your unshare tool is too old.
> AFAIK it uses newuidmap only in recent versions.

I'm on Debian Sid.  That's quite unlikely :p
(Although Debian Sid still runs make-4.3, so it wouldn't be crazy).

>=20
> You can achieve the very same als using podman in rootless mode.
> e.g.
> podman run -it -v /scratch:/scratch/ bash -c "cat /scratch/games/game.t=
xt"
>=20
> Thanks,
> //richard

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------22zWt3urw070L00gNi9pBi0X--

--------------hdbah5UsGbLpBhayX3BQA1Wr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTuZdIACgkQnowa+77/
2zJ/yA//Wu0ZmKl7U/cReJWoZ3OeUjJYt/vHjm5gTUYYaViVVAGLiErshcL5I6E7
ZCCoCXZcAblxBBahQp3+LzhmPdBBviwxCQfQKcb2wNOPpX0h6tPAwY98PzzFbomQ
BsqeKUYoth90jN8YFd/liV86M5/zHJTA8F3LHLkMXtSsPvYspbCWYqfEgKrmY0ia
SN++xNLLiVAyfIJlB6bWd1OROJTm+o+sInsQyHNpSmy7dh5n0wgQyBnYk1qQ+P+n
9MlSmQ4/C+RkTNIvaPLqodInLC+RGyJrwm9xeZKgqnpaTg3EM69q16ncdgl1oj3E
MrMwozfUxj9vJ7+9cMC8xxiUbdwDMWCyYmB+oeYZtBGLjssqllbMMUE1gwEczsmk
FxvVF4iZJ+tmBQ6JIVKQoGcKYMl68cNYgc8LJaBXn+9lufG53q1bwf1KrfiZthOz
UrGxAhVOr+4JhEa0Ow7VbyPpSy3b13mytMJUCe+iEmw5ecT6zm7hC6hczSnIqCnQ
fQaF12NByEr7KmhbysBv7CG8OPR0SQea6EfsSH9r6Oy0ipqdavCeg7J3ATz7hcTU
rMg/qysPo3md7zNfZbCFWg/7vSe7RMrcP3ywGCi06mxs2J0yFi/H8AA+tNK0kdR7
bC5Xi00FtAnyQ9bxEHatSc5AwC2ILEizUlJLOFm0hDaWpsqfFhM=
=d9yg
-----END PGP SIGNATURE-----

--------------hdbah5UsGbLpBhayX3BQA1Wr--
