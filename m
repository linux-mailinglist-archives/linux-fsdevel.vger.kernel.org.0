Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D190793CB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbjIFMfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 08:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjIFMfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:35:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68341713;
        Wed,  6 Sep 2023 05:35:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230906123525euoutp01aef263d18f43afc5e0f456b68b34412b~CT2m_4MNh1721017210euoutp01T;
        Wed,  6 Sep 2023 12:35:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230906123525euoutp01aef263d18f43afc5e0f456b68b34412b~CT2m_4MNh1721017210euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694003725;
        bh=kSfDM2PxptQrTVQMPAG5rz9E3Gh0CgYjQq2vX1wh1u8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=m+6wDQ82ef/d8/4nlWMYTE9kfnIAoWlhMhdqHBBfihfqWuP8iM3eVNlzJjRaHltMU
         2l4lDxXybgq/aUTbfAyOFFW1c/WG3S6g0Slu0hR8E1wgIfPIBWUX5aRY9fX8h2g49x
         0RiNloUw+2A+/56qP9XBwg7AqfowYcMjmZDUd1vg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230906123525eucas1p15d5663db311f0d147c190276abfe8f84~CT2mw_TAz2306723067eucas1p1U;
        Wed,  6 Sep 2023 12:35:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5D.86.37758.C0278F46; Wed,  6
        Sep 2023 13:35:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230906123524eucas1p22d0bf30fe10ce0ee7ca45eca03ef3235~CT2mJczO42726327263eucas1p29;
        Wed,  6 Sep 2023 12:35:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906123524eusmtrp28aa6f6cde31078bfe52b8c173cbb675a~CT2mG2adp0571505715eusmtrp2L;
        Wed,  6 Sep 2023 12:35:24 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-38-64f8720cdaa5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.16.14344.C0278F46; Wed,  6
        Sep 2023 13:35:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906123524eusmtip2c81fad208fd37b2f2d78a8b26ceda34c~CT2ltQB-30461004610eusmtip2c;
        Wed,  6 Sep 2023 12:35:24 +0000 (GMT)
Received: from localhost (106.210.248.249) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 6 Sep 2023 13:35:23 +0100
Date:   Wed, 6 Sep 2023 14:35:21 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Alexey Gladkov <legion@kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Granados <joel.granados@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <rds-devel@oss.oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, <willy@infradead.org>,
        Jan Karcher <jaka@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Simon Horman <horms@verge.net.au>,
        Tony Lu <tonylu@linux.alibaba.com>,
        <linux-wpan@vger.kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        <mptcp@lists.linux.dev>, Heiko Carstens <hca@linux.ibm.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Will Deacon <will@kernel.org>, Julian Anastasov <ja@ssi.bg>,
        <netfilter-devel@vger.kernel.org>, Joerg Reuter <jreuter@yaina.de>,
        <linux-kernel@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        <linux-sctp@vger.kernel.org>, Xin Long <lucien.xin@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-hams@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        <coreteam@netfilter.org>, Ralf Baechle <ralf@linux-mips.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        <keescook@chromium.org>, Roopa Prabhu <roopa@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>, <josh@joshtriplett.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        <netdev@vger.kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        <linux-s390@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        <lvs-devel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        <bridge@lists.linux-foundation.org>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Mat Martineau <martineau@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [GIT PULL] sysctl changes for v6.6-rc1
Message-ID: <20230906123521.xrqcmr3ilpvp2ze6@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="l5htxkzwtgg23zjg"
Content-Disposition: inline
In-Reply-To: <ZPhpedWW6RwTd9Hf@example.org>
X-Originating-IP: [106.210.248.249]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTZxjG851zelrQmkNh+gWMbhWJA1YBcb5TcJq4eWbMLon+ITNznZwg
        GRRtxcvYMqR4AUWr6JDikKorhRYYiFUqm1CUe7h4CzjUlYu6FgEHVcAAKxzYTPbf733f58n3
        PH98IlIyJvQWRSt2c0qFPEZKu1Pm6pHm98TK4cig5E4ExQ1/0WBNXAG28lQBdI1Zaag1/SGE
        fv0xBGNlh0k415xMQaHlIAE91Z1CMKcZEbRoXwrg6tNXNDiy8xEctc8H9RUngu4TnQK4qx+g
        4VSSGCZy4mDk+CzITFUT0Hg0Fvp/yiKgxXzc9ZDuEyjpui+A8t/qKLh/9SEBdyznaHhiTaNA
        o1OT0JPjEEBHup6CzqJ+AtTn/yZh1FAjgKa0CRIMjU8IaNP0IKg6/LsAGouShFCdMxc0hfUU
        vGzoRZDRe4+E2+W+UD80QUDT5UEBDJ5bAjZNMwXphlICrqcMC0FfVCCErldPaeg8/lwIBxrN
        QkjuWA6vh11h9GWfrgljTdkmxPY11SE225TAZiW2UuzoiD9bmtdOsGXah0LWXLGYzSmJZy8b
        /NkHjnC2JD+FZmvPvqbYW3kFLo3tA1ZzoQJ9vjDCPSySi4newymXrv7afUeLJoPceSh834GL
        Q2QiehWYitxEmAnF15+MEanIXSRhDAjrqh7T/DCE8FDFzGUQ4YkJu2DGoh1tJSdZwuQifK8r
        4F+R0Xqb4odShG2JxWhSRTG+uPZ29pSDZgJxc2/HFHsxfviaWjf1Hsmc8cCOvoEpgyezDDtt
        FmKSxcwKXFCpI3n2wHWZ3dQkk8w+fEF7yRVJ5GIfnDsumly7MQE4t+AgzSddhKvTOiief8D1
        pQ+m6mCmcDY+1n8L8Yd1uNpaOy3yxPaaUiHP8/FE2flpQzrCN8YHhPxgRFh/wEnwqlU4+W73
        tGMtvljsmEqEmTm47bkHH3QOPmXOIPm1GB85JOHVftj4qJfSoEXaN6pp36im/a8av5bhtjOn
        6f+tA7Be5yB5DseFhf1UDhLmo3lcvCo2ilMtU3B7ZSp5rCpeESXbHhdbgly/smG8xnkNGewv
        ZFZEiJAV+brMnb8aW5A3pYhTcFIvcd/Cl5EScaR8/3ecMm6bMj6GU1mRj4iSzhMHhNdtlzBR
        8t3ctxy3k1POXAmRm3cicWQT2ZrllfvxrK/ujZjMlpE567asvBz0y7Etf561+Szotvs3V/px
        ydmDs9XG8tnPdFLLl+Vh+z+KH2WCKnIUzo3GD+/c+GIkO3iBbeBsn8Ueu3d5iF/gBumjx+9U
        7nohS4pI+l42/+TW02t/zKxNGP2ssc/0VtahBTdfyMGwPjBgx/pvAol6OuyZ4bW6inHfuXpT
        8PJrlUdT1g6U7tofMuv9n0NjnIsS9jh8S6o898Rm2psyotZcqQ4VrZIMb8hTc/VP41OWPgse
        KqIXH34Usp2au3TzCVtD+Fi76ZJHiiX67ZWbQ51lTunWAaujR2bJ3xiavqR9W413WkKGm0/X
        Te1FFFH+LpZSqh3yYH9SqZL/Ax5eSy0QBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe1BUZRjG+845e3ZRseWSnCEamY1SgRZYbu8mUFNDHZoGo+lCpUObnECB
        XWYXMKxmkEXJ5RJeSlkJdjWXOySwrBCl4bCAIDdh0VyYuOyaQBIid5EW1yZn+u/3Pe/zPt/7
        fTMvB7fPZztz9omTGKlYFM8jNxAdD1uHX9okXYz2Pqeygwsdd0hoTguEkSYFC8ZWm0loq7jF
        hmlNNoLVhkwcCrozCKhqPIyBST/KhvqccgQ9ynkW6G4vkDBZWIYga8IF5No5BOPfjrKgX/M3
        CcfTbWFNJYGl3I2Qr5Bj0JmVANPfn8Ggpz7XcpE6DGrGDCxo+qWdAINuCIPrjQUkmJtzCMhT
        y3EwqSZZYDyhIWC0ehoDedE9HJZLWlnQlbOGQ0mnGYMbeSYEVzJ/ZUFndTob9KotkFd1lYD5
        jikEp6YGcOhrcoOr99cw6KqdZcFswXYYyesm4ERJHQY/H11kg6a6kg1jC7dJGM39iw2HOuvZ
        kGH0h5VFyzCahvBXg+iKwgpE3+1qR3RhxZf0mbRegl5ecqfrSm9idINyiE3XX36BVtUk07Ul
        7vTvk8F0TdlRkm47vULQLaWVFs+IkM47exm9s/VjfpBUkpzEuMZKZEnBvE98QMD3EQJf4Cfk
        +/gG7nlZ4M/zCgmKZuL3pTBSr5BP+bF9Vb0oMSP4C8UpLZaG5jwVyIZDcf0o5XIvrkAbOPbc
        84hauXGSsBZcqAv3B1hWdqAeGBSk1TSDKMW5Nsx6qEPU8K0ifN1FcN2otr7CR0xyPanuKeMj
        duS+SF2Uq8l1xrnf2VGDhanr7MD1peZGGrF1tuUGUpW/qR+PUYYo/eketrVgR7XnjxPW5hRK
        P2y2mDgWfpYqfshZl224HlRx5WHSOunzlD7H+PgFX1Ozq2aUhxyUTyQpn0hS/pdklT2pBq2R
        /J/sQWnUk7iVg6mqqmlChdhlyJFJliXEJMgEfJkoQZYsjuHvlSTUIMte1OuX6i6i0okZfjPC
        OKgZuVk6R38q70HOhFgiZniOtne3zkfb20aLUg8yUkmUNDmekTUjf8svHsOdn9krsSyZOCnK
        J8Db38cvQOjtLwzw5TnZhiV+I7LnxoiSmDiGSWSk//ZhHBvnNEw3Mag1eJmIoTT+/voIbceo
        3EDUptrsuOfE27gYodoWrg4TX/9sl3fR8ked+tTAOu2PuwpCU1C264htnF7CuSTYXp4dlxWy
        c6Bf0X/tUpYp5uSOA+Sfd/K3tHgLpJHHh4vVrV/5blp4/axGnhkujB7xHN49qBGmV8QYQx+4
        Dhue08VsZjb/sPa0yRwRa3hlv/nwW64BODqk2+PM//x9oX48NE4vPJg8E9BgVh6QyCvZbWJc
        IFY5XOkwvhfZEjldVpNZex5LfK194e0j4rgx08xiGjPbeUTUTqLoeB33g+53d/4R2FLU/+bN
        p8ort9nHhr3ROx7uEnVN6KRbbjv24W4PHiGLFfm441KZ6B9l6Qk3rAQAAA==
X-CMS-MailID: 20230906123524eucas1p22d0bf30fe10ce0ee7ca45eca03ef3235
X-Msg-Generator: CA
X-RootMTR: 20230906115909eucas1p2fcf08f26861b318571224dad6bf5e864
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230906115909eucas1p2fcf08f26861b318571224dad6bf5e864
References: <ZO5Yx5JFogGi/cBo@bombadil.infradead.org>
        <CGME20230906115909eucas1p2fcf08f26861b318571224dad6bf5e864@eucas1p2.samsung.com>
        <ZPhpedWW6RwTd9Hf@example.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--l5htxkzwtgg23zjg
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 01:58:49PM +0200, Alexey Gladkov wrote:
> On Tue, Aug 29, 2023 at 01:44:55PM -0700, Luis Chamberlain wrote:
> > The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fb=
aaa5:
> >=20
> >   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/=
sysctl-6.6-rc1
> >=20
> > for you to fetch changes up to 53f3811dfd5e39507ee3aaea1be09aabce8f9c98:
> >=20
> >   sysctl: Use ctl_table_size as stopping criteria for list macro (2023-=
08-15 15:26:18 -0700)
> >=20
> > ----------------------------------------------------------------
> > sysctl-6.6-rc1
> >=20
> > Long ago we set out to remove the kitchen sink on kernel/sysctl.c array=
s and
> > placings sysctls to their own sybsystem or file to help avoid merge con=
flicts.
> > Matthew Wilcox pointed out though that if we're going to do that we mig=
ht as
> > well also *save* space while at it and try to remove the extra last sys=
ctl
> > entry added at the end of each array, a sentintel, instead of bloating =
the
> > kernel by adding a new sentinel with each array moved.
> >=20
> > Doing that was not so trivial, and has required slowing down the moves =
of
> > kernel/sysctl.c arrays and measuring the impact on size by each new mov=
e.
> >=20
> > The complex part of the effort to help reduce the size of each sysctl i=
s being
> > done by the patient work of el se=F1or Don Joel Granados. A lot of this=
 is truly
> > painful code refactoring and testing and then trying to measure the sav=
ings of
> > each move and removing the sentinels. Although Joel already has code wh=
ich does
> > most of this work, experience with sysctl moves in the past shows is we=
 need to
> > be careful due to the slew of odd build failures that are possible due =
to the
> > amount of random Kconfig options sysctls use.
> >=20
> > To that end Joel's work is split by first addressing the major housekee=
ping
> > needed to remove the sentinels, which is part of this merge request. Th=
e rest
> > of the work to actually remove the sentinels will be done later in futu=
re
> > kernel releases.
>=20
> This is very interesting for me. I'm also refactoring sysctl based on
> discussion with Linus a while ago.
>=20
> Could you please add me to the Cc in the next patches?
I just sent the next batch for this set for review. You can see it here
https://lore.kernel.org/all/20230906-jag-sysctl_remove_empty_elem_arch-v1-0=
-3935d4854248@samsung.com/
Will add you for the next ones.

Best

>=20
> > At first I was only going to send his first 7 patches of his patch seri=
es,
> > posted 1 month ago, but in retrospect due to the testing the changes ha=
ve
> > received in linux-next and the minor changes they make this goes with t=
he
> > entire set of patches Joel had planned: just sysctl house keeping. Ther=
e are
> > networking changes but these are part of the house keeping too.
> >=20
> > The preliminary math is showing this will all help reduce the overall b=
uild
> > time size of the kernel and run time memory consumed by the kernel by a=
bout
> > ~64 bytes per array where we are able to remove each sentinel in the fu=
ture.
> > That also means there is no more bloating the kernel with the extra ~64=
 bytes
> > per array moved as no new sentinels are created.
> >=20
> > Most of this has been in linux-next for about a month, the last 7 patch=
es took
> > a minor refresh 2 week ago based on feedback.
> >=20
> > ----------------------------------------------------------------
> > Joel Granados (14):
> >       sysctl: Prefer ctl_table_header in proc_sysctl
> >       sysctl: Use ctl_table_header in list_for_each_table_entry
> >       sysctl: Add ctl_table_size to ctl_table_header
> >       sysctl: Add size argument to init_header
> >       sysctl: Add a size arg to __register_sysctl_table
> >       sysctl: Add size to register_sysctl
> >       sysctl: Add size arg to __register_sysctl_init
> >       sysctl: Add size to register_net_sysctl function
> >       ax.25: Update to register_net_sysctl_sz
> >       netfilter: Update to register_net_sysctl_sz
> >       networking: Update to register_net_sysctl_sz
> >       vrf: Update to register_net_sysctl_sz
> >       sysctl: SIZE_MAX->ARRAY_SIZE in register_net_sysctl
> >       sysctl: Use ctl_table_size as stopping criteria for list macro
> >=20
> >  arch/arm64/kernel/armv8_deprecated.c    |  2 +-
> >  arch/s390/appldata/appldata_base.c      |  2 +-
> >  drivers/net/vrf.c                       |  3 +-
> >  fs/proc/proc_sysctl.c                   | 90 +++++++++++++++++--------=
--------
> >  include/linux/sysctl.h                  | 31 +++++++++---
> >  include/net/ipv6.h                      |  2 +
> >  include/net/net_namespace.h             | 10 ++--
> >  ipc/ipc_sysctl.c                        |  4 +-
> >  ipc/mq_sysctl.c                         |  4 +-
> >  kernel/ucount.c                         |  5 +-
> >  net/ax25/sysctl_net_ax25.c              |  3 +-
> >  net/bridge/br_netfilter_hooks.c         |  3 +-
> >  net/core/neighbour.c                    |  8 ++-
> >  net/core/sysctl_net_core.c              |  3 +-
> >  net/ieee802154/6lowpan/reassembly.c     |  8 ++-
> >  net/ipv4/devinet.c                      |  3 +-
> >  net/ipv4/ip_fragment.c                  |  3 +-
> >  net/ipv4/route.c                        |  8 ++-
> >  net/ipv4/sysctl_net_ipv4.c              |  3 +-
> >  net/ipv4/xfrm4_policy.c                 |  3 +-
> >  net/ipv6/addrconf.c                     |  3 +-
> >  net/ipv6/icmp.c                         |  5 ++
> >  net/ipv6/netfilter/nf_conntrack_reasm.c |  3 +-
> >  net/ipv6/reassembly.c                   |  3 +-
> >  net/ipv6/route.c                        |  9 ++++
> >  net/ipv6/sysctl_net_ipv6.c              | 16 ++++--
> >  net/ipv6/xfrm6_policy.c                 |  3 +-
> >  net/mpls/af_mpls.c                      |  6 ++-
> >  net/mptcp/ctrl.c                        |  3 +-
> >  net/netfilter/ipvs/ip_vs_ctl.c          |  8 ++-
> >  net/netfilter/ipvs/ip_vs_lblc.c         | 10 ++--
> >  net/netfilter/ipvs/ip_vs_lblcr.c        | 10 ++--
> >  net/netfilter/nf_conntrack_standalone.c |  4 +-
> >  net/netfilter/nf_log.c                  |  7 +--
> >  net/rds/tcp.c                           |  3 +-
> >  net/sctp/sysctl.c                       |  4 +-
> >  net/smc/smc_sysctl.c                    |  3 +-
> >  net/sysctl_net.c                        | 26 +++++++---
> >  net/unix/sysctl_net_unix.c              |  3 +-
> >  net/xfrm/xfrm_sysctl.c                  |  8 ++-
> >  40 files changed, 222 insertions(+), 113 deletions(-)
>=20
> --=20
> Rgrds, legion
>=20

--=20

Joel Granados

--l5htxkzwtgg23zjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmT4cgkACgkQupfNUreW
QU9+Cwv+PGlN6idIMQ5c8C0f+ZfC5w4Z+JE4kmlQCz1bP2MeE/pPTaPtyWYqpG8L
fCfed2PJj3OndPFVZ8htgmNw43rVuzq+FLpoXoS6A+GQTwt+oFYhkmEHImix1EHY
LgHQwS53MI/8uswyrLCgFK1wB3oWOl2iSsNmafe2N9DNQnjtNMHWA45X9zejzEu3
yIroWgdeLsDjCje7bCASIxWYMQ0mLCcHYnHhLi9t3oLmtCxrfqz/YvUoAtuUGJId
EsmlWY0oVOSbUnAv7/CUX6Vh0zXFxtT91spcvDNl8S1araoo1HlooVdK96Odh/Ly
hiP9KFjySgIdD5HpsT1tSMbEgdx/r1Iv8z4HWJDcpoz4vXeBJRTrdu+H4XJcvXlB
r9R97zixnSmMaNnAIsNh37llJAYe2pmy9I9/lXAB12U/Z/WQ47aMUZCzIHcuyX8F
RTLOFn64GT9n7pWmFNOllKMnkTWbxeCJhzmDbbndW5RhtVt5XbxCBYL8RZ9ne9PD
fMmoGngO
=CaN7
-----END PGP SIGNATURE-----

--l5htxkzwtgg23zjg--
