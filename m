Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A917695B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGaMK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGaMK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:10:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E848010FA;
        Mon, 31 Jul 2023 05:10:20 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230731121018euoutp0164f11e623595bb2e700f756c093d6e70~28pH6ylmL2061420614euoutp01C;
        Mon, 31 Jul 2023 12:10:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230731121018euoutp0164f11e623595bb2e700f756c093d6e70~28pH6ylmL2061420614euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690805418;
        bh=D3O35ZrqXqoSGtgeerUxSg5GGfQo9xVWButL9ENDv9k=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=qs9su8/t7gVJD+aWle+cjWkGhtuuZFwGVogwSjqTBSGzh2UmwprbZ0YnWzHnxHJ50
         LWs3zk/paKhCsam+p1IPskxXjAJ7ZQCxuMiRhorQ8+kUSC0MhN1fUvihsD7ktVhUTw
         iTMb5P7JIrQDw1a7iEUKwZxDfKcaBSIf356oy42M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230731121018eucas1p27a6d9ff8bdd28f8a725a41e8a5697932~28pHcwZqW0934909349eucas1p2a;
        Mon, 31 Jul 2023 12:10:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F3.94.42423.AA4A7C46; Mon, 31
        Jul 2023 13:10:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230731121018eucas1p2a86803ebc2cf0111d3498409b0320c5e~28pHIX1oa1017210172eucas1p24;
        Mon, 31 Jul 2023 12:10:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230731121018eusmtrp2b138cee218d1aa25f1c2c22e629a3b89~28pHHtrWt2859628596eusmtrp2G;
        Mon, 31 Jul 2023 12:10:18 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-4c-64c7a4aa3bb2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.C2.14344.9A4A7C46; Mon, 31
        Jul 2023 13:10:17 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230731121017eusmtip1536934459f6d0d293169c4cf5c9dd954~28pG3kQ6G1837818378eusmtip1c;
        Mon, 31 Jul 2023 12:10:17 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 31 Jul 2023 13:10:16 +0100
Date:   Mon, 31 Jul 2023 14:10:15 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Simon Horman <horms@kernel.org>
CC:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, <willy@infradead.org>,
        <josh@joshtriplett.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/14] sysctl: Add ctl_table_size to ctl_table_header
Message-ID: <20230731121015.i7vhfsyx7nzw7kpc@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="6ovbsbc6ix5fuye3"
Content-Disposition: inline
In-Reply-To: <ZMOc/+Q0PT48ed0G@kernel.org>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7qrlhxPMdi7V9TiUf8JNov/C/It
        znTnWuzZe5LF4vKuOWwWNyY8ZbT4/QPIWrbTz4HDY3bDRRaPBZtKPTav0PK49drWY9OqTjaP
        z5vkAtiiuGxSUnMyy1KL9O0SuDKaFv5iL7ioWLH18STWBsbd0l2MnBwSAiYSvxuWsHYxcnEI
        CaxglNhzaxEzhPOFUeLEvSZ2COczo0Tn0yeMMC0bfvxhgkgsZ5T48X8LQtXMi3OhMlsYJT7N
        PsMK0sIioCqx599VZhCbTUBH4vybO2C2iICyxNm5LWANzAKXGCU2nnkM1iAs4Cmx8dN1dhCb
        V8BcYuHFb8wQtqDEyZlPWEBsZoEKiUP3e4BqOIBsaYnl/zhATE4BLYk/K5ghLlWS+PqmlxXC
        rpU4teUW2CoJgfmcEq2bzrFBJFwk/m2ZwQJhC0u8Or6FHcKWkfi/cz5Uw2RGif3/PrBDOKsZ
        JZY1fmWCqLKWaLnyBOwICQFHidsXCyFMPokbbwUhzuSTmLRtOjNEmFeio00IolFNYvW9NywT
        GJVnIXlsFpLHZiE8BhHWkViw+xMbhrC2xLKFr5khbFuJdevesyxgZF/FKJ5aWpybnlpsmJda
        rlecmFtcmpeul5yfu4kRmNRO/zv+aQfj3Fcf9Q4xMnEwHmJUAWp+tGH1BUYplrz8vFQlEd5T
        AYdShHhTEiurUovy44tKc1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTB1JHle
        l/AxnlYxZ3dpk/QbWeNFjn21Gp3yoQoJEdEH16w5ff3SugDNpp+vDKNX/lqm0r3uyqpV14uP
        8OkbH41U7vivI1Oy5fkl7pgfO1do3TdhlZywRaRG9Jf05RoxC7UdZa3p25b+yTh3UuuDSMmr
        ossijz5EXRf8NUnNpeFcsXyW+OFEp7YzdTMDuSZNXNbZqmpcl9iZ2V2SHnZk7vcbprGbdwjP
        OLb155vZG3uu3Z0lVS90sORAxPo6j60JNhL/q891KgvENk688WSD/vO32wz3cfYJHi26UTBh
        YXHiuze3Xf/sYn3I/nCf97xPNb/9n4Ycu6XttvLaB6ZiUbUGKcOcw/5Btx48lXWIMhZVYinO
        SDTUYi4qTgQAMAVQJOUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7orlxxPMZizydziUf8JNov/C/It
        znTnWuzZe5LF4vKuOWwWNyY8ZbT4/QPIWrbTz4HDY3bDRRaPBZtKPTav0PK49drWY9OqTjaP
        z5vkAtii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S
        9DLmN+xmKTivWNH36Sp7A+NO6S5GTg4JAROJDT/+MHUxcnEICSxllDi4dRsLREJGYuOXq6wQ
        trDEn2tdbBBFHxklbm5dywiSEBLYwijx/QkHiM0ioCqx599VZhCbTUBH4vybO2C2iICyxNm5
        LWAbmAUuMUpsPPMYbKqwgKfExk/X2UFsXgFziYUXvzFDbHjKKNF+6D8zREJQ4uTMJ2AnMQuU
        Saxb9hqomQPIlpZY/o8DxOQU0JL4s4IZ4lAlia9veqGOrpX4/PcZ4wRG4VlIBs1CMmgWwiCI
        sJbEjX8vmTCEtSWWLXzNDGHbSqxb955lASP7KkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMDI
        3nbs55YdjCtffdQ7xMjEwXiIUQWo89GG1RcYpVjy8vNSlUR4TwUcShHiTUmsrEotyo8vKs1J
        LT7EaAoMxYnMUqLJ+cCUk1cSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fE
        wSnVwJR54clmh5k3OzlmsDeHKR/y0jvA2b9knYOLvfDxtCytetXJTzld93Lv5RfwaeQUO57s
        Ee+y+nz2DPOGJ4fup15bMrNeR818jprvo3nSM4yZ3RJLhV4vcmPRXX98dbwq46fQhy8jPwrY
        Jax8EPI9RqRI/mT0px+SM+bNfrtp4bXLps7eTfYnlvyY5m5foX229fMj1W9fcz8rNMZ90v0s
        Nm+yP6vr49+2qz9fCvqjemRZ9QTPGZ+PG9S+dTe7l8U8rdw+Om/RVQunzXWMm6dlnrU9td6Y
        Z/4nzxMnnkvcSeexDvivGf3hHvuer+y6Kt8n5zxqqrcT+nLojGzexOkzrnssnyezV3TlsikS
        fzZuMLigxFKckWioxVxUnAgAoDzQbIEDAAA=
X-CMS-MailID: 20230731121018eucas1p2a86803ebc2cf0111d3498409b0320c5e
X-Msg-Generator: CA
X-RootMTR: 20230726140653eucas1p2e234b7cd0af5dc506bd27399b84292a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140653eucas1p2e234b7cd0af5dc506bd27399b84292a6
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140653eucas1p2e234b7cd0af5dc506bd27399b84292a6@eucas1p2.samsung.com>
        <20230726140635.2059334-4-j.granados@samsung.com>
        <ZMOc/+Q0PT48ed0G@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--6ovbsbc6ix5fuye3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 12:48:31PM +0200, Simon Horman wrote:
> On Wed, Jul 26, 2023 at 04:06:23PM +0200, Joel Granados wrote:
> > The new ctl_table_size element will hold the size of the ctl_table
> > contained in the header. This value is passed by the callers to the
> > sysctl register infrastructure.
> >=20
> > This is a preparation commit that allows us to systematically add
> > ctl_table_size and start using it only when it is in all the places
> > where there is a sysctl registration.
> >=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  include/linux/sysctl.h | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > index 59d451f455bf..33252ad58ebe 100644
> > --- a/include/linux/sysctl.h
> > +++ b/include/linux/sysctl.h
> > @@ -159,12 +159,22 @@ struct ctl_node {
> >  	struct ctl_table_header *header;
> >  };
> > =20
> > -/* struct ctl_table_header is used to maintain dynamic lists of
> > -   struct ctl_table trees. */
> > +/**
> > + * struct ctl_table_header - maintains dynamic lists of struct ctl_tab=
le trees
> > + * @ctl_table: pointer to the first element in ctl_table array
> > + * @ctl_table_size: number of elements pointed by @ctl_table
> > + * @used: The entry will never be touched when equal to 0.
> > + * @count: Upped every time something is added to @inodes and downed e=
very time
> > + *         something is removed from inodes
> > + * @nreg: When nreg drops to 0 the ctl_table_header will be unregister=
ed.
> > + * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc=
_sysctl ->d_compare()"
> > + *
> > + */
>=20
> Please consider documenting all fields of struct ctl_table_header.
> ./scripts/kernel-doc complains that the following are missing:
>=20
>   unregistering
>   ctl_table_arg
>   root
>   set
>   parent
>   node
>   inodes

This one I'm unsure about as things go in and then get changed without upda=
ting the docs
I have tried to follow the changes from the point of introduction, but as I=
 said, I'm
unsure if I missed something.

diff --git i/include/linux/sysctl.h w/include/linux/sysctl.h
index 09d7429d67c0..fc0461f2a0c8 100644
--- i/include/linux/sysctl.h
+++ w/include/linux/sysctl.h
@@ -168,7 +168,13 @@ struct ctl_node {
  *         something is removed from inodes
  * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
  * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sys=
ctl ->d_compare()"
- *
+ * @unregistering: Holds the completion when dropping (un-registering) a c=
tl_table
+ * @ctl_table_arg: The ctl_table array that was passed to register_sysctl_=
paths
+ * @root: The root of a sysctl namespace
+ * @set: Set of sysctls
+ * @parent: Pointer to the ctl_dir of the parent directory
+ * @node: Pointer to the rbtree node for this header
+ * @inodes: head for proc_inode->sysctl_inodes
  */
 struct ctl_table_header {
        union {
@@ -187,7 +193,7 @@ struct ctl_table_header {
        struct ctl_table_set *set;
        struct ctl_dir *parent;
        struct ctl_node *node;
-       struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
+       struct hlist_head inodes;
 };

 struct ctl_dir {
~
--=20

Joel Granados

--6ovbsbc6ix5fuye3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTHpKAACgkQupfNUreW
QU/qlwv+MlG8TreakrSppIrnoXkCT+YrDZ7s9HE9mCscBl7xuPoUS2xkZMURzIz4
Gt3lUfBk20ckTGGNg61kdqM8LNAcdvHgfzwI25FyNrZw74H7Re3dHPcqua4av+MX
INs75cyX9ClHyxneBBARvzB2ZRTlvuVfgzFgahLQDp+gmiyUMFxMcUqGGj9B57IT
O+9gWEZtKXuFPcGvSxMEfO7++SEKHsuQeyEubtIr/wcDCNvs8mOJboEq65+hIYed
kBVP9OjCE8hzbDZHlm54L8CISn2/XJhP3s3kLCommnAD3HiWae+a6B2smyDOc2GT
NL8zSL4us77JcEv10Fu/gqFIEDenBBBRJ3T2sLdOthb89O+xkN+3qTAkVWAick28
QAVnTlV7M0B5B9dCTej7XokUQhGqH40JhOLPmJ+DfHVpvc5khimJRNtf+1ro7pW0
BEFJDJoC5Wx/bEtuQVUCGcR05hC6XS0wxwZcE89lpikfzv5t37y3dV0DLcz+30JO
Lg0ZqGX6
=EkIB
-----END PGP SIGNATURE-----

--6ovbsbc6ix5fuye3--
