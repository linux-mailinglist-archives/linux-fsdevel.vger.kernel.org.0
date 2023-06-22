Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F9B73A2AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjFVOJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjFVOJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:09:20 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E13118;
        Thu, 22 Jun 2023 07:09:19 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230622140917euoutp0209c3af71a8e555075da71adff50e22be~rAG37Z84v1834418344euoutp02o;
        Thu, 22 Jun 2023 14:09:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230622140917euoutp0209c3af71a8e555075da71adff50e22be~rAG37Z84v1834418344euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687442957;
        bh=zaMeOOgNTUhWbrl//bfN8EJTtzCzEfB12QbiW80G2f4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fyMYAsX7SWYCvC721YkuDao9t6T+v9dW0/DNO3irMb5N3/+7mY+XC7PBmdIBgaAvs
         nwu4XyzztDaaiEJ4vpcLtdpxEmzEo+NC19qsW+0/HbTJr2EWYbhVKkuOS3DdtZRY7b
         95cqTsi+l2A2Sq2OBC3R9D8F7pdOR0ihbUkSZEHY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230622140917eucas1p28dc98c293572df0d551587904d58fff1~rAG3sfKOA1958219582eucas1p2p;
        Thu, 22 Jun 2023 14:09:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DC.B9.42423.D0654946; Thu, 22
        Jun 2023 15:09:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230622140916eucas1p122166fa1c1ee8fc1498c76af15e4ce52~rAG3Opb-I1423914239eucas1p1o;
        Thu, 22 Jun 2023 14:09:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230622140916eusmtrp1d20955f9b396aea7c60d7cdcf79f38fd~rAG3N_8ml1843218432eusmtrp1R;
        Thu, 22 Jun 2023 14:09:16 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-61-6494560d374d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.D2.14344.C0654946; Thu, 22
        Jun 2023 15:09:16 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230622140916eusmtip283cc06318a6e5b54077056f6bb1dd63f~rAG3DqvTB0784507845eusmtip2C;
        Thu, 22 Jun 2023 14:09:16 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 22 Jun 2023 15:09:16 +0100
Date:   Thu, 22 Jun 2023 16:09:15 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH 05/11] sysctl: Add a size arg to __register_sysctl_table
Message-ID: <20230622140915.top2p467qfd7slez@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="o5zo77jvou4wd4u7"
Content-Disposition: inline
In-Reply-To: <20230621135322.06b0ba2c@kernel.org>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7q8YVNSDL7MlLCYc76FxeLpsUfs
        Fme6cy0ubOtjtdiz9ySLxeVdc9gsbkx4ymhxbIGYxbfTbxgtlu30c+DymN1wkcVjy8qbTB4L
        NpV6bFrVyebxft9VNo/Pm+QC2KK4bFJSczLLUov07RK4Mg6e+8Fc8EmgovfUc8YGxqN8XYyc
        HBICJhJNmxeydjFycQgJrGCUOP1vDwtIQkjgC6NE98ogiMRnRol5vdNZYTr2v7vFCJFYzigx
        9cxEVriqsx8b2CGcLYwSCz73s4G0sAioSnSvOc4OYrMJ6Eicf3OHGcQWEVCRaNk8kwWkgVlg
        HZPE7uYdQEUcHMICPhJrF6mD1PAKmEss+nyMBcIWlDg58wmYzSxQIXF5+iQmkHJmAWmJ5f84
        QMKcAoYSfZcvsENcqiTx9U0v1NW1Eqe23GICWSUhsJlT4kPzYiaIhIvE9a7fzBC2sMSr41ug
        mmUkTk/uYYFomMwosf/fB3YIZzWjxLLGr1Dd1hItV55AdThKnLm/mRHkIgkBPokbbwUhDuWT
        mLRtOjNEmFeio00IolpNYvW9NywTGJVnIXltFpLXZiG8BhHWkViw+xMbhrC2xLKFr5khbFuJ
        devesyxgZF/FKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmOxO/zv+aQfj3Fcf9Q4xMnEw
        HmJUAWp+tGH1BUYplrz8vFQlEV7ZTZNShHhTEiurUovy44tKc1KLDzFKc7AoifNq255MFhJI
        TyxJzU5NLUgtgskycXBKNTC1s1/6klgdPelZbK3st1syasbV9yaEJouGMHnsjy5l3rJ4aurV
        7122maecbh7yP+3msX66IP+a2Y0Sk1sspN4f/rUyK2WT28aa7cuj7lSftDkZs+/hn2vRogIT
        JVVsFm30Ngt9YCXikD3NM2yPaSjftV0/tjYt3aL+Rfzcm0MbF5/8v/F2CNePwNPaRYe/XGKu
        OuryeMeaQGbVn+ec5HUmLNB+ZGq8z6rt9uE44UDvZcz7z25SUJ29eN1fgfWF4u2KVkfXTbX7
        JjfHyX6/7prta6Y8OHzezM53++cmpf8xJ5c03HvZFZp6TulZ+bxijt4uzr/z8z6HbUwMTjSU
        0Yus6uNT+BKVNoPJUbGCp2udEktxRqKhFnNRcSIAY2gQl/EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xe7o8YVNSDBZvtbCYc76FxeLpsUfs
        Fme6cy0ubOtjtdiz9ySLxeVdc9gsbkx4ymhxbIGYxbfTbxgtlu30c+DymN1wkcVjy8qbTB4L
        NpV6bFrVyebxft9VNo/Pm+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxM
        lfTtbFJSczLLUov07RL0Mlaffc1e8EGg4sirVYwNjIf5uhg5OSQETCT2v7vF2MXIxSEksJRR
        oqv5MxNEQkZi45errBC2sMSfa11sEEUfgYpWv2SHcLYwSjy5uwWsg0VAVaJ7zXF2EJtNQEfi
        /Js7zCC2iICKRMvmmSwgDcwC65gkdjfvACri4BAW8JFYu0gdpIZXwFxi0edjLBBDXzFK9O+7
        zAqREJQ4OfMJC4jNLFAmceTxHUaQXmYBaYnl/zhAwpwChhJ9ly+wQ1yqJPH1TS/U1bUSn/8+
        Y5zAKDwLyaRZSCbNQpgEEdaSuPHvJROGsLbEsoWvmSFsW4l1696zLGBkX8UoklpanJueW2yk
        V5yYW1yal66XnJ+7iREY89uO/dyyg3Hlq496hxiZOBgPMaoAdT7asPoCoxRLXn5eqpIIr+ym
        SSlCvCmJlVWpRfnxRaU5qcWHGE2BoTiRWUo0OR+YjPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoS
        hQTSE0tSs1NTC1KLYPqYODilGpiE03YZhJ6YeCGxJYNLsXDPPNEtYSx7maJkPzZMehjPIMp+
        6jyHEHehRhhzQaZivfF1Ro66CouNXh+fhv3I3jwr/cK0q1XuDz/cX/eq6shBu4UFau0CWwN3
        b/n7cIdl8zaOj9+mRqotSyn06Zm89kjWtZ08O2VrKw4mzrjb99HMINl15ec9000XZv0MyP/m
        oZH1JsNY4uydSd1Np7muVz1b180wRUB3jvZPb9/wryyG/T8OML6frF2SM31u8vk1nR/iJXWq
        Ji40kHzzIkkiysenOXcv55Ld29YcXLLs2pE1AuULZ/ub2PBcnKrC+Ev88YT8j+55WZ+KDl/8
        aiR38GhOLF8skyO748Km1kN3NXuVWIozEg21mIuKEwGi6m7QjgMAAA==
X-CMS-MailID: 20230622140916eucas1p122166fa1c1ee8fc1498c76af15e4ce52
X-Msg-Generator: CA
X-RootMTR: 20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0@eucas1p1.samsung.com>
        <20230621091000.424843-6-j.granados@samsung.com>
        <20230621135322.06b0ba2c@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--o5zo77jvou4wd4u7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 01:53:22PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Jun 2023 11:09:54 +0200 Joel Granados wrote:
> > In order to remove the end element from the ctl_table struct arrays, we
> > explicitly define the size when registering the targets.
> > __register_sysctl_table is the first function to grow a size argument.
> > For this commit to focus only on that function, we temporarily implement
> > a size calculation in register_net_sysctl, which is an indirection call
> > for all the network register calls.
>=20
> You didn't CC the cover letter to netdev so replying here.
>=20
> Is the motivation just the size change? Does it conflict with changes
> queued to other trees?
I will clarify the motivation in V2. But I have sent out this
https://lore.kernel.org/all/20230622135922.xtvaiy3isvq576hw@localhost/
to give some perspective.

>=20
> It'd be much better if you could figure out a way to push prep into=20
> 6.5 and then convert subsystems separately.
One of my objectives for V2 is to reduce the amount of subsystems that
the patch actually touches. So this might not even be an issue.
I'll keep that separation possibility in mind; thx for the idea.

Best

--=20

Joel Granados

--o5zo77jvou4wd4u7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSUVgoACgkQupfNUreW
QU/wFwv+I8rMRjL5RDsrOsrUjqzDKtrDPejfagT1jhJAcwL4IvU3nVVGwTFqxkvO
cnZKV1OObDzEXv5igpdn86TvJbvDYYh3Ad+6zi0tO4qRI1o0xjb5CFLty3YJwzw3
UU2aT3yXyhdiOqLiaaorTVrq5sdyEZ9slJxHJIZiVisfHiEQKjC1nnxA/M7RKwfA
iKuQlfADEDAbuI5eDcJ0RZHeYi2wzgMNms7OaprSbrNG/UgmZWFEnYVpeHZpaPoJ
DI83GtQHBSHjobRqkYBscDWA9CP3JwpeZBSvo8UIiBnYukgm+aNR5SROaCxm/nce
TPjW3zmWx174Ld/akYZtrxkCsqLHzwDJW+kL36xVTnGTgFZ9JBqNHW/2jMJ5Nr6q
kzo85lXqPUjLSflhAq+Rw6Am8+NLXx4RfXjKow+YYJEvvtWNC5uIDv/1dmHmGMyM
YaQRAfXnbwNSMkSlioBD5BymBUeGR50GVUoOSlAZKJENS5ddU7fjU7n5pd1/Tfy5
pAyKSHHf
=xBkN
-----END PGP SIGNATURE-----

--o5zo77jvou4wd4u7--
