Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0C532CFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbiEXPLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiEXPLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 11:11:48 -0400
X-Greylist: delayed 710 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 May 2022 08:11:47 PDT
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82680366B6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 08:11:46 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ntW0l-0007dT-Ad; Tue, 24 May 2022 10:59:51 -0400
Message-ID: <1f4ae5c0c72180650bf94c83283fed2dd9048b3f.camel@surriel.com>
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
From:   Rik van Riel <riel@surriel.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, Chris Mason <clm@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Tue, 24 May 2022 10:59:50 -0400
In-Reply-To: <CAJfpeguOHRtmWTuQfUT_Lb98ddiyzZcjk=D8WyyYA8i923-Lag@mail.gmail.com>
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
         <20211112101307.iqf3nhxgchf2u2i3@wittgenstein>
         <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
         <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
         <d6f632bc-c321-488d-f50e-749d641786d6@fb.com>
         <20220518112229.s5nalbyd523nxxru@wittgenstein>
         <CAJfpegtNKbOzu0F=-k_ovxrAOYsOBk91e3v6GPgpfYYjsAM5xw@mail.gmail.com>
         <CAEf4BzaNjPMgBWuRH_me=+Gp6_nmuwyY7L-wiGFs6G=5A=fQ4g@mail.gmail.com>
         <20220519085919.yqj2hvlzg7gpzby3@wittgenstein>
         <CAEf4BzY5en_O9NtKUB=1uHkGdHLSo_FqddUkokh7pcEWAQ2omw@mail.gmail.com>
         <CAJfpeguOHRtmWTuQfUT_Lb98ddiyzZcjk=D8WyyYA8i923-Lag@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-43N9HgNTK06EtozOSBEz"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-43N9HgNTK06EtozOSBEz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-05-24 at 09:07 +0200, Miklos Szeredi wrote:
> On Tue, 24 May 2022 at 06:36, Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>=20
> > I still think that tools like perf being able to provide good
> > tracing
> > data is going to hurt due to this cautious rejection of access, but
> > with Kconfig we at least give an option for users to opt out of it.
> > WDYT?
>=20
> I'd rather use a module option for this, always defaulting to off .
> Then sysadmin then can choose to turn this protection off if
> necessary. This would effectively be the same as "user_allow_other"
> option in /etc/fuse.conf, which fusermount interprets but the kernel
> doesn't.

Configuring that behavior through /sys/module/fuse/user_allow_other
(or some other name if people have better ideas) seems like a good
way to configure that, indeed!

--=20
All Rights Reversed.

--=-43N9HgNTK06EtozOSBEz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmKM8uYACgkQznnekoTE
3oMeRAf5AREQOV2ibKvPp054G9owN2c31+laf9ZbBMq+kfBGHSkr5fRZIkiY4Veg
NpXZViDxyduvzOEA15Ec95MA7PM8uNfah4Dx46wuHcqtjC+sQB3Gj3t2u4LFZYlP
JePCWqeh6OTyZTkqIbpi640cGpe+nRrKKYwqdOiLm3DxddmGcrTlg9OJ3iHFUKGD
TIe33+zRWIoIF9+IhCICq4MqcpfLIv/2DGE8E9Vc85pni9jlWQawP84eJR0SWqqi
eFB1S8PNo0lEYn3ZZsvtBuGlWKiqTUbE85L9AmQn7o0oWbAu2bxGj/EnovzEmsEy
X/4eMxfOvo2o1WI56yrRa5UtN7S90Q==
=wKKo
-----END PGP SIGNATURE-----

--=-43N9HgNTK06EtozOSBEz--
