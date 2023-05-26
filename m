Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1BC712483
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbjEZKWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242765AbjEZKWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 06:22:41 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C8FB;
        Fri, 26 May 2023 03:22:37 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230526102225euoutp02f3ee4392ab1b2d57683ecb95db40883c~iqmFZZxFr0213402134euoutp02K;
        Fri, 26 May 2023 10:22:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230526102225euoutp02f3ee4392ab1b2d57683ecb95db40883c~iqmFZZxFr0213402134euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685096545;
        bh=E5j3mNncGUKQnVTagpyIHdEzaEGKl4d4KchUoa6tm8s=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ieli2mS0rP58yAIJ+EDq/aGVemzZNhHrOwujB/tO/Jy96TEvoTca7XhdbkUCdhaSw
         wxb+tH1Nd+3xVMwn0q4BUmnmUXqXAy4ozGV+b8UXNcrfVXswEPq1QGLabfQGmDJbik
         jJsPv7/AVOsdKOtMg0HE0iw5XFETEbii88s3pEdc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230526102225eucas1p2dd4eb7d91c12b5f7be915c7768048675~iqmFQvdZY1456714567eucas1p2m;
        Fri, 26 May 2023 10:22:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 71.52.42423.16880746; Fri, 26
        May 2023 11:22:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230526102224eucas1p140af5598f8323865da3bb5e39fdb5192~iqmEqgkW60550205502eucas1p1F;
        Fri, 26 May 2023 10:22:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230526102224eusmtrp149fb1eb2c5a49727eabc3dadd11f28b2~iqmEp6aUF2919029190eusmtrp1x;
        Fri, 26 May 2023 10:22:24 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-8d-647088616b8e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C9.7F.10549.06880746; Fri, 26
        May 2023 11:22:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230526102224eusmtip18210e41d32b9a2e482bd9185d96079fd~iqmEbuqRA0765907659eusmtip1B;
        Fri, 26 May 2023 10:22:24 +0000 (GMT)
Received: from localhost (106.210.248.78) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 26 May 2023 11:22:23 +0100
Date:   Fri, 26 May 2023 12:22:22 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     <mcgrof@kernel.org>, Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v4 7/8] sysctl: Refactor base paths registrations
Message-ID: <20230526102222.c5anxpcfia5djnxe@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="s4khld4elb45pjku"
Content-Disposition: inline
In-Reply-To: <c97bfda5-cecf-4521-880b-02c6da987120@kili.mountain>
X-Originating-IP: [106.210.248.78]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7qJHQUpBqsOS1u8PvyJ0eLDvFZ2
        izPduRZ79p5ksbi8aw6bxY0JTxktDpyewmxx/u9xVotlO/0cOD1mN1xk8dg56y67x4JNpR6b
        VnWyedy5tofN4/MmOY9NT94yBbBHcdmkpOZklqUW6dslcGXc/zqRtaBZsmLKzL3MDYwThbsY
        OTkkBEwk7n1ZwdbFyMUhJLCCUeLmzQtMIAkhgS+MErNb1CASnxklZp1azwbTcfJuNztEYjmj
        xLv3B5nhqpae/c0E4WxhlDjb+IYdpIVFQFWi81kXWDubgI7E+Td3mEFsESD739/JLCA2s8AS
        Jolry2RBbGEBV4nL68+CxXkFzCWuXrzECGELSpyc+QSqvkJi7vIPQHEOIFtaYvk/DpAwp4Cj
        xKnbx1khLlWS2Nr1jgnCrpU4teUW2G0SAus5JQ6tfcIOkXCR+POmmRHCFpZ4dXwLVFxG4vTk
        HhaIhsmMEvv/fWCHcFYzSixr/Ao11lqi5QrIJA4g21Fi5gx9CJNP4sZbQYg7+SQmbZvODBHm
        lehoE4JoVJNYfe8NywRG5VlIPpuF5LNZCJ9BhHUkFuz+xIYhrC2xbOFrZgjbVmLduvcsCxjZ
        VzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgQmu9P/jn/awTj31Ue9Q4xMHIyHGFWAmh9t
        WH2BUYolLz8vVUmEd0NOfooQb0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lCAumJJanZqakF
        qUUwWSYOTqkGprr68Enr/DND5l/6lxz66f6qWJ9aPW3nsPurQ49b3ZA8JNXbe//jOq/+Jha+
        bUryx1z/5f//7zfZcpu0WEfSWnfr3xyfC3unuSV237VymvTKYPfhhS9vWBfcc7xWxsu7b225
        yunTaeapk2LthLXXzv20Z+G1/55HF7Pcr2n9ta1qRfnd6VdqZXJEm0wvS36czXtWk3FO5Ftm
        j6rqs0frAt/3XNg231Ti7vqoNyfkNq6deuzsTSGHFd5RelO8TTmyWk9vir7evbVBfmO+2PRv
        u+crd8WZnPkXp7KhJSBl+fbzyf4P7GZWmZ2fXSfZ6Fu5UEj+g2dYxza7d308jqusepj+TF2Z
        lx7Lei3w3wz+xUosxRmJhlrMRcWJALdsrrbxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7oJHQUpButn6lm8PvyJ0eLDvFZ2
        izPduRZ79p5ksbi8aw6bxY0JTxktDpyewmxx/u9xVotlO/0cOD1mN1xk8dg56y67x4JNpR6b
        VnWyedy5tofN4/MmOY9NT94yBbBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GUs6//PUtAoWXGyQ7WBsV+4i5GTQ0LAROLk3W72LkYuDiGBpYwS
        k48eZIFIyEhs/HKVFcIWlvhzrYsNougjo8SaD5NZIJwtjBLvPpxjBKliEVCV6HwGUsXJwSag
        I3H+zR1mEFsEyP73F6KBWWAJk8TCtmVgK4QFXCUurz8LZvMKmEtcvXiJEWLqH0aJKTOusUEk
        BCVOznwCVsQsUCYxc00jUJwDyJaWWP6PAyTMKeAocer2cahTlSS2dr1jgrBrJT7/fcY4gVF4
        FpJJs5BMmoUwCSKsJXHj30smDGFtiWULXzND2LYS69a9Z1nAyL6KUSS1tDg3PbfYUK84Mbe4
        NC9dLzk/dxMjMOq3Hfu5eQfjvFcf9Q4xMnEwHmJUAep8tGH1BUYplrz8vFQlEd4NOfkpQrwp
        iZVVqUX58UWlOanFhxhNgcE4kVlKNDkfmI7ySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNL
        UrNTUwtSi2D6mDg4pRqYtsyaPzsia9Wsh1t8/zrM3SAV3/STSUE6u+lI3ZyT1fvOR/Zrn5Pe
        MPE3g3uzcGfsOrG+a88PX/oerfg4pfvv5Wu/GHwbVCozVDMu3jxp2Cd9ZuU5qZlm6dU3H/m1
        XFYI4+icOfuk59x+fat94Zvtvt0Q14vaNWV65JSbyQLft3uKzt1yR3Ke2pYMNnZe/SmT39w6
        e+KbTVaXZW3uF8a7NSe4zT6xHmsJ2v3/KsOthT823b+xN8l+9rL/dzLNI2fatV6r+Wn34a5A
        c3XtXIZ38xwrDCzKH/1Q+L01/8supx3Kvz+ZTXvCe6Li1ImgeJ/HHxbzx08oEV0VvahTQrRf
        WHJXqtBy3fjrWf4XdytPP6fEUpyRaKjFXFScCAApwMtUjwMAAA==
X-CMS-MailID: 20230526102224eucas1p140af5598f8323865da3bb5e39fdb5192
X-Msg-Generator: CA
X-RootMTR: 20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3
References: <20230523122220.1610825-1-j.granados@samsung.com>
        <CGME20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3@eucas1p1.samsung.com>
        <20230523122220.1610825-8-j.granados@samsung.com>
        <c97bfda5-cecf-4521-880b-02c6da987120@kili.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--s4khld4elb45pjku
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 11:37:47AM +0300, Dan Carpenter wrote:
> On Tue, May 23, 2023 at 02:22:19PM +0200, Joel Granados wrote:
> > This is part of the general push to deprecate register_sysctl_paths and
> > register_sysctl_table. The old way of doing this through
> > register_sysctl_base and DECLARE_SYSCTL_BASE macro is replaced with a
> > call to register_sysctl_init. The 5 base paths affected are: "kernel",
> > "vm", "debug", "dev" and "fs".
> >=20
> > We remove the register_sysctl_base function and the DECLARE_SYSCTL_BASE
> > macro since they are no longer needed.
> >=20
> > In order to quickly acertain that the paths did not actually change I
> > executed `find /proc/sys/ | sha1sum` and made sure that the sha was the
> > same before and after the commit.
> >=20
> > We end up saving 563 bytes with this change:
> >=20
> > ./scripts/bloat-o-meter vmlinux.0.base vmlinux.1.refactor-base-paths
> > add/remove: 0/5 grow/shrink: 2/0 up/down: 77/-640 (-563)
> > Function                                     old     new   delta
> > sysctl_init_bases                             55     111     +56
> > init_fs_sysctls                               12      33     +21
> > vm_base_table                                128       -    -128
> > kernel_base_table                            128       -    -128
> > fs_base_table                                128       -    -128
> > dev_base_table                               128       -    -128
> > debug_base_table                             128       -    -128
> > Total: Before=3D21258215, After=3D21257652, chg -0.00%
> >=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > [mcgrof: modified to use register_sysctl_init() over register_sysctl()
> >  and add bloat-o-meter stats]
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> This needs a Fixes tag so it doesn't get backported by some weird fluke.
> Or you could just fold it in with the original patch which introduced
I folded it into the original patch

thx

Best
> the bug.
>=20
> Probably add a copy of the output from dmesg?  Maybe add some
> Reported-by tags?
>=20
> regards,
> dan carpenter
> >=20

--=20

Joel Granados

--s4khld4elb45pjku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRwiF4ACgkQupfNUreW
QU/Phgv/dM4OeXZoGMXjp7WJRASyGlFsDMvhxkoTWqze/5olOWjFw31231QWfvkr
VWqUxm5CPzLt7/x0UNg/jiT5NrF72kVJssTuYUNPW/01J7NYhNSoEX0gGB2d7LOU
DrHC+0LGLGYbvKIOg58xvQul3DPMk3sofThlyajSQVfH5zqJEZB7Pt9f8rrYAXZF
wJrs+5lTtQ0uJjfA1NGYfom5tDJH9c0ekVR8SjfpflswiHSf1ZXarN+x6qy0LBv4
wk6IDhCh4pZRrUSd3z6InRApXGnyFJpY4JrLVb7h9Beibs8QIBWBTQs1xIblAOKR
wZzGfMZrps4RJumsIxxU6tP+yb5NjKIhx8z7MZ761uLW5j8agKzGLT4fSprQ7/H3
WI29BR58yVyO0a5Kig3rmpqvR88KVCHy+1TEgJzMfL9wbEdxwX08iyRxNX/NhVs9
e4dVJSBXnZoUuc2iVOV7j77d3fTQ5S0MwRuYmss/WNV2s2q4fW7kkAo6b3tsvM98
LhlD2/fi
=uLjI
-----END PGP SIGNATURE-----

--s4khld4elb45pjku--
