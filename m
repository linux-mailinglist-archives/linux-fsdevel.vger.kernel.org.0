Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3199A70502F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 16:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjEPOGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 10:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjEPOGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 10:06:47 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A03A1FFB;
        Tue, 16 May 2023 07:06:45 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230516140643euoutp01d9f94a30892fb2c851be360d70e6d5ea~fpND4rRuC0754807548euoutp01C;
        Tue, 16 May 2023 14:06:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230516140643euoutp01d9f94a30892fb2c851be360d70e6d5ea~fpND4rRuC0754807548euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684246003;
        bh=VTC7tt6v4o4GcRMMdqLk8G9pcGby296CT1KmS+z8Euc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=cpBtrJK41msqG6lc8+gunDpviY3C81y0WPj4clrY03LTW+8FZ/zhABmmmljn3ftr4
         oCpp0gV+C1B3yyyiH8K6L47gHFEYV8cmS9uYBRraemsNuKnER+KBr9Lfz+zZdipVjH
         tYsvoveIHH90HfKavadTYpYvUesl9msY4j2DDD8g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230516140642eucas1p24a6e9aba5ac11ac73c9f58dab9ad5dd2~fpNDuOSIp0299202992eucas1p2L;
        Tue, 16 May 2023 14:06:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4A.EF.37758.2FD83646; Tue, 16
        May 2023 15:06:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230516140642eucas1p22bc04df60607b08e7689e5abf78a1af8~fpNDZ-DZK1997719977eucas1p2n;
        Tue, 16 May 2023 14:06:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516140642eusmtrp1e8e83216ba7826f53423b3a5607fc6e2~fpNDYOXu22736227362eusmtrp1h;
        Tue, 16 May 2023 14:06:42 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-28-64638df22e73
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.A4.10549.2FD83646; Tue, 16
        May 2023 15:06:42 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516140642eusmtip15f9a46fe456f26af095742991c896e86~fpNDO1N_D1910719107eusmtip1T;
        Tue, 16 May 2023 14:06:42 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 15:06:41 +0100
Date:   Tue, 16 May 2023 16:06:40 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/6] sysctl: Remove register_sysctl_table from parport
Message-ID: <20230516140640.il6w54hpbj3zq7lo@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="z4i2cvxpia5dzh6m"
Content-Disposition: inline
In-Reply-To: <ZGKU5vP8Anmfeen0@bombadil.infradead.org>
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djP87qfepNTDN4sNbY4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1issmJTUn
        syy1SN8ugStj9fKnLAXTBCt2fzrK3MB4nq+LkYNDQsBEouOBfBcjF4eQwApGif0f25khnC+M
        EntfHIVyPjNK3Lj5g6WLkROsY9O8tcwgtpDAckaJVec44Yq+bloA1bGFUeLf2ydsIFUsAqoS
        q65OYgKx2QR0JM6/uQPWLSKgIbFvQi8TSAOzwG5GiW8HJrOCJIQFvCQeLmwDK+IVMJeYu+82
        O4QtKHFy5hOwM5gFKiQm3HrFDPIEs4C0xPJ/HCBhTgEziUlL+6EuVZJon/iAFcKulTi15RbY
        LgmBfk6Jx3M3skMkXCROdt+CKhKWeHV8C1RcRuL05B4WiIbJwJD594EdwlnNKLGs8SsTRJW1
        RMuVJ1AdjhIbdx1mhwQrn8SNt4IQh/JJTNo2nRkizCvR0SYEUa0msfreG5YJjMqzkLw2C8lr
        sxBegwjrSCzY/YkNQ1hbYtnC18wQtq3EunXvWRYwsq9iFE8tLc5NTy02zkst1ytOzC0uzUvX
        S87P3cQITF6n/x3/uoNxxauPeocYmTgYDzGqADU/2rD6AqMUS15+XqqSCG/7zPgUId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzatieThQTSE0tSs1NTC1KLYLJMHJxSDUxZRUyXbm1usJ+z1eZa
        4ckLteHypY62yo8iC376XGbtScnjjp/TbVO5d6mR7h/hzbyPmhS+fp50zOHorZfez41mvJ0a
        5DzjSgiz55fJuh1bFdXmLdlcf/aBrkEo313nt5zF/8IUv7y2Kv3UmvijRuw+x0bWxxUcvRsm
        pOzavnbiZ+ML7T57rLY88SzdpCfRmGW9yPzwufJdvvuSig8tFdn7Zpe3OAv7hnlLHY9POf5V
        gfvWPp+DG2qFp8zeOSfA+VQyj7eRjeO9drUXGw9ttfh1d6JizYQ2c1eWDQZxU3UVGHnYdAot
        3JwP+Mmdjtrrt39h6DEVg9J2ZZYFsxda/syb3XacU+qazP78dU+4YpyUWIozEg21mIuKEwEH
        zvTM2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7qfepNTDPrPyFqc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AapWdTlF9a
        kqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexvOMka8EUwYqd
        i84yNTCe5eti5OSQEDCR2DRvLXMXIxeHkMBSRonHS36wQyRkJDZ+ucoKYQtL/LnWxQZR9JFR
        4uGXo6wQzhZGiT2PnzGBVLEIqEqsujoJzGYT0JE4/+YOM4gtIqAhsW9CLxNIA7PAbkaJbwcm
        g40VFvCSeLiwDayIV8BcYu6+2+wQU/cySmyetwcqIShxcuYTFhCbWaBM4tj8fUB3cADZ0hLL
        /3GAhDkFzCQmLe1ngThVSaJ94gOos2slPv99xjiBUXgWkkmzkEyahTAJIqwlcePfSyYMYW2J
        ZQtfM0PYthLr1r1nWcDIvopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwircd+7l5B+O8Vx/1
        DjEycTAeYlQB6ny0YfUFRimWvPy8VCUR3vaZ8SlCvCmJlVWpRfnxRaU5qcWHGE2BwTiRWUo0
        OR+YXvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjy5vU3Lg58
        Zzir33vxbyHBtII5f/nP3q2++ODvgpR+1kQ//zru34zqs0Ld/8ftWJKq86v27u+P8n5aYurC
        aZbBanPdF64vevBk9qn/24vfHprho6Dt/92ofKaltI9hu1NMmdYhQYN6uUvLHoqbFD3cvHpR
        d93p6KubtmtM3fLz1DqDCtM/5Vm+B8JvSrmf+nVD2/6U1g5hlY+H/HfMVbz040+UXJbZ93rd
        TxcuJv5ROr/brbcufembGfvSRFNzNhRNF3wfteNu8++++sWpp44oLyzqVN4eWliz70eXmemW
        dyr2sfpOiqulDISjmjgrpogdPt7lPqte9DL3tSl+XRkXVqQUJV/30d44ad/yhyxKLMUZiYZa
        zEXFiQAX5FwodwMAAA==
X-CMS-MailID: 20230516140642eucas1p22bc04df60607b08e7689e5abf78a1af8
X-Msg-Generator: CA
X-RootMTR: 20230515071448eucas1p111c55b7078f1541f487c9dfb1a9f9c15
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071448eucas1p111c55b7078f1541f487c9dfb1a9f9c15
References: <CGME20230515071448eucas1p111c55b7078f1541f487c9dfb1a9f9c15@eucas1p1.samsung.com>
        <20230515071446.2277292-1-j.granados@samsung.com>
        <ZGKU5vP8Anmfeen0@bombadil.infradead.org>
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

--z4i2cvxpia5dzh6m
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 01:24:06PM -0700, Luis Chamberlain wrote:
> On Mon, May 15, 2023 at 09:14:40AM +0200, Joel Granados wrote:
> > This is part of the general push to deprecate register_sysctl_paths and
> > register_sysctl_table. Parport driver uses the "CHILD" pointer
> > in the ctl_table structure to create its directory structure. We move to
> > the newer register_sysctl call and remove the pointer madness.
>=20
> Nice! Thanks for doing this and unwinding the sysctl use case which
> takes the cake for the obfuscation use case of sysctls.
Indeed. They were being very creative :)

>=20
> > I have separated the parport into 5 patches to clarify the different
> > changes needed for the 3 calls to register_sysctl_paths. I can squash
> > them together if need be.
>=20
> I think it makes sense to keep them that way.
Fine by me :).

>=20
> > We no longer export the register_sysctl_table call as parport was the
> > last user from outside proc_sysctl.c. Also modified documentation sligh=
tly
> > so register_sysctl_table is no longer mentioned.
>=20
> We can go further, but I'll explain in patch review on the patches.
ok

>=20
> > I'm waiting on the 0-day tests results.
>=20
> Nice!
>=20
>   Luis

--=20

Joel Granados

--z4i2cvxpia5dzh6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRjjfAACgkQupfNUreW
QU/apwwAg1fuMok7nkAiCaY++GdY6b9U/1rpdFHO4ttj+YPS26tqAzR/1s52LbD8
UwuxPXQJN4EHdKb+mleFu4KJpx/LKynzwDcggTEFHvPI3m6+1XFB9rLE76B4lIEl
Qaxj6RgZjl5V8/Bz3ibw1ITe+zFrIhjfa04G8cwMMry7l08cwnun2lYXt3I7Vj9+
yR+TqISb8aIwdDxLlQqXFWjDnxXsiQv49lmc6vrSa1T65cI2GM7gI02m7nP77ZFo
uYt+5yar4PrMWimQB1NjcnG6Kzc0e6HhdAbfATSerkZdqDMK0dIKCEJ00MvTGPIo
EkrF7lP0Og4Piv+FE6g77l53eKyV6Jtcjzu97IOZc9B1S89b1UagTYW3TZJNIjOa
gTSlmOdYuPmMjEYndvhYEp9+ZeGJleUnb4LuFfV5xs4vY5ECuFOVKcmseGXvUg8A
mbV+58JsFiDaovPVcqPdpjoaPrC+/gn8Of0Zg6hUIBrTlkEdmZonH+k5d55AtZrf
CmojlNeQ
=RUEv
-----END PGP SIGNATURE-----

--z4i2cvxpia5dzh6m--
