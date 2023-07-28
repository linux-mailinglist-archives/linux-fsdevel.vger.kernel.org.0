Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9502A76719C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjG1QME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 12:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjG1QL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:11:59 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3A4491;
        Fri, 28 Jul 2023 09:11:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230728161155euoutp024c2f985958ab3dc48bf45de8c23bfa4a~2FAOYQ7fT1469614696euoutp02Q;
        Fri, 28 Jul 2023 16:11:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230728161155euoutp024c2f985958ab3dc48bf45de8c23bfa4a~2FAOYQ7fT1469614696euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690560715;
        bh=eAmwzUMQ5gPdm35DDKA6i4Maz+X0BOtsb1A4OG93Vbs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=HPpPDNH8sflRf/x84Necy7RuA8aJZrgy2uQGRBnhVhP007mLvn0if2fVTH+Udpf4U
         H1U5SzGcM1VNtetY2NPjEb0rhhVPaG1TzG+qdUIv6Q08LhXPlOfGesMRs7wRgoSwCS
         lw/NzlzExmiDCLyBOhqagW0ApEq3a3cxrxhxa8Rw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230728161155eucas1p191fe84e53d902c08153de81d704e8eba~2FAOLxIrl2478124781eucas1p1o;
        Fri, 28 Jul 2023 16:11:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7A.F7.37758.BC8E3C46; Fri, 28
        Jul 2023 17:11:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230728161155eucas1p1164d12914aa49a72987b1a6c2b979cd4~2FAN2Nd532934229342eucas1p15;
        Fri, 28 Jul 2023 16:11:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230728161155eusmtrp1ff8b89022ed31a83237329352568ae0f~2FAN1rpMt0293702937eusmtrp1S;
        Fri, 28 Jul 2023 16:11:55 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-f7-64c3e8cb9ab1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.9C.14344.BC8E3C46; Fri, 28
        Jul 2023 17:11:55 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230728161155eusmtip154f2375e2315fef61902c39f8d9723a1~2FANriBRG0692406924eusmtip1N;
        Fri, 28 Jul 2023 16:11:55 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 28 Jul 2023 17:11:54 +0100
Date:   Fri, 28 Jul 2023 18:11:53 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Simon Horman <horms@kernel.org>
CC:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, <willy@infradead.org>,
        <josh@joshtriplett.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 07/14] sysctl: Add size arg to __register_sysctl_init
Message-ID: <20230728161153.7pnkyj65mcjetrsy@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="wlctx25u52rcazx2"
Content-Disposition: inline
In-Reply-To: <ZMOe5FE3VETYsmdX@kernel.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87qnXxxOMfj7UsbiUf8JNov/C/It
        znTnWuzZe5LF4vKuOWwWNyY8ZbT4/QPIWrbTz4HDY3bDRRaPBZtKPTav0PK49drWY9OqTjaP
        z5vkAtiiuGxSUnMyy1KL9O0SuDJ6/k5hLugSqnjQOpWpgXErfxcjJ4eEgIlEU/ss5i5GLg4h
        gRWMEl37PzBBOF8YJc7dOcQMUiUk8JlR4tZvfZiOv5s+QHUsZ5R43XAFygEqevfhJCOEs5VR
        YuaZX0wgLSwCqhLz51xjA7HZBHQkzr+5AzZWREBZ4uzcFrB9zAKXGCU2nnnMCpIQFvCU6Jm5
        FMzmFTCXaJ58gB3CFpQ4OfMJC4jNLFAh8eH2G6A4B5AtLbH8HwdImFNAS2L76RZWiFOVJQ4u
        +c0OYddKnNpyC2yXhMB8Tonld64zQSRcJD59WsQMYQtLvDq+BapBRuL05B4WiIbJjBL7/31g
        h3BWM0osa/wK1W0t0XLlCdgVEgKOEksPKUGYfBI33gpC3MknMWnbdGaIMK9ER5sQRKOaxOp7
        b1gmMCrPQvLZLCSfzUL4DCKsI7Fg9yc2DGFtiWULXzND2LYS69a9Z1nAyL6KUTy1tDg3PbXY
        OC+1XK84Mbe4NC9dLzk/dxMjMKmd/nf86w7GFa8+6h1iZOJgPMSoAtT8aMPqC4xSLHn5ealK
        IrynAg6lCPGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamCK
        sO6rEV42g6m5zfzWcZblgjsPTH5m67Z55ok27usfOCfJ//dvNbrMOqFl2YHFrywufF3JrnBv
        YuqhAud5vA3c3EK/fkgIJK48eX3+sbSu3dP8Zm5bp9V1+Nwk4VUvzsrPMKnSfmrg943FNtq7
        YZ/SnX/sPkvq86eutrQNm5PyYFr0yUM3nc5U/LlzWlk5SkbHZJZmU2D0BC2RGykeU6acfl2R
        fazcYNp80Yr2Yy/j/FgnrGNXWDFlwibOVI86CYMtbaoy7YsF+8T8tpxvNphyp08rvJ7dkem2
        a6h3p0UA/5q27RNDb7ZP3f7AVe0fR+sEo2tPXl0KerVnedi+y8tUF/g/TP9w4HXCzbrve2dc
        VGIpzkg01GIuKk4EAI0/k/blAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7qnXxxOMVg+k9PiUf8JNov/C/It
        znTnWuzZe5LF4vKuOWwWNyY8ZbT4/QPIWrbTz4HDY3bDRRaPBZtKPTav0PK49drWY9OqTjaP
        z5vkAtii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S
        9DLuPVnFUtAhVPGz9QBzA+Nm/i5GTg4JAROJv5s+MHcxcnEICSxllPjzYhobREJGYuOXq6wQ
        trDEn2tdbBBFHxklTrzdzgjhbGWU2P9pGjtIFYuAqsT8OdfAutkEdCTOv7nDDGKLCChLnJ3b
        wgTSwCxwiVFi45nHYGOFBTwlemYuBbN5BcwlmicfYIeY+pRR4k7rZ6iEoMTJmU9YQGxmgTKJ
        r2v6gGwOIFtaYvk/DpAwp4CWxPbTLVCnKkscXPKbHcKulfj89xnjBEbhWUgmzUIyaRbCJIiw
        lsSNfy+ZMIS1JZYtfM0MYdtKrFv3nmUBI/sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwOje
        duznlh2MK1991DvEyMTBeIhRBajz0YbVFxilWPLy81KVRHhPBRxKEeJNSaysSi3Kjy8qzUkt
        PsRoCgzGicxSosn5wLSTVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TB
        KdXAlLTWX3Dhi5hLKdxizebun9b8eyIkaDbt1cv1SXtP37G62isgP7ll2XaBCYezl06t6rCp
        4Mr9NbtvGnuR1rtnE7QnZH7YtbEv8fqx+9M0p0z7psrc8OTSsc7o7t9n9GYY6uQJnrjM+lVm
        1r7riUJrVOdyaZ+YrHTyiyB/VnDrp+2e9uzOum8n5h183Jf6dLUzU/BCsfCpMfc/LJD4c3Zu
        2fktP7i8fx4ReeLGyD///CSlrVtSXW8m3Dnslqp11W5P8Z+ZtT3pUXNsmlmXbbg46etl65da
        Nn0d0ho7n0/os7f/7rP7W7tVKb/S+6JaeT7Tor1x9gWHL0opPBNSDzOzbXy+9fn72ECWKzue
        Gy9b3qPEUpyRaKjFXFScCACb12HGgwMAAA==
X-CMS-MailID: 20230728161155eucas1p1164d12914aa49a72987b1a6c2b979cd4
X-Msg-Generator: CA
X-RootMTR: 20230726140700eucas1p1e6b16e884362ebec50f6712b3f11a533
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140700eucas1p1e6b16e884362ebec50f6712b3f11a533
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140700eucas1p1e6b16e884362ebec50f6712b3f11a533@eucas1p1.samsung.com>
        <20230726140635.2059334-8-j.granados@samsung.com>
        <ZMOe5FE3VETYsmdX@kernel.org>
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

--wlctx25u52rcazx2
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 12:56:36PM +0200, Simon Horman wrote:
> On Wed, Jul 26, 2023 at 04:06:27PM +0200, Joel Granados wrote:
> > This is part of the effort to remove the sentinel element from the
> > ctl_table array at register time. We add a size argument to
> > __register_sysctl_init and modify the register_sysctl_init macro to
> > calculate the array size with ARRAY_SIZE. The original callers do not
> > need to be updated as they will go through the new macro.
> >=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  fs/proc/proc_sysctl.c  | 11 ++---------
> >  include/linux/sysctl.h |  5 +++--
> >  2 files changed, 5 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index c04293911e7e..6c0721cd35f3 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -1444,16 +1444,9 @@ EXPORT_SYMBOL(register_sysctl_sz);
> >   * Context: if your base directory does not exist it will be created f=
or you.
> >   */
> >  void __init __register_sysctl_init(const char *path, struct ctl_table =
*table,
> > -				 const char *table_name)
> > +				 const char *table_name, size_t table_size)
>=20
> Hi Joel,
>=20
> in the same vein as my comment on another patch.
> Please add table_size to the kernel doc for this function.
Will do.

--=20

Joel Granados

--wlctx25u52rcazx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTD6MkACgkQupfNUreW
QU+MPgv+LmG3mJTdshAQxBXXg7KMFtpbvUmWS+AzZ+HRUrMsc8c+onHYjk4Zx7E5
B9ByxmzodqvwN1TTxUhfcyxADg+1foqcwnYTq6ILtsoE1KhO4Lw4nbl6wFrinGWG
3w4yLmfkFsLZr5sBnHUlzIDAzsHpJuI0UbIEgrglb+AsGZYSIaATGKVdLYLFIiXn
hcCKxSQySCY6UA2gfR8xhpBDZHHnJJD6REqCA4f7T80cUWp8mNRKDvwkCNg28pyr
ZOrqW6T3hHtt7/AbHbkJh76A9YnkttOlOP+pGr/nDucMHO3vuZzhSUsNJNNjfFJu
3x3j1VjuOha2tEYZafgYfLyogJDcdKIrgEwIR9PijZl7tFo9vYu5+/ppWCtlmQHq
BoGMtsnglysJgvSkFoutjN/zBs/hOqDBtL6Q1Xig+iXqbM2wB5NwHR3mqu4U67GP
gwJCYN+cFAEj9V+xET9+QjPsIPFUNM961E6h6x9ykNDn9/QE1ehKkH5wyBiVTXG2
ZB2zXWpb
=Mn8H
-----END PGP SIGNATURE-----

--wlctx25u52rcazx2--
