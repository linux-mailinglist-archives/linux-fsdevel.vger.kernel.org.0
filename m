Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B37BA179
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbjJEOm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjJEOhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:46 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1B4F6E3;
        Thu,  5 Oct 2023 07:02:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231005080158euoutp011c3547f1ffbdb40540ef68e628fb859c~LJ1I3wav22377823778euoutp01H;
        Thu,  5 Oct 2023 08:01:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231005080158euoutp011c3547f1ffbdb40540ef68e628fb859c~LJ1I3wav22377823778euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696492918;
        bh=Y16mqWiiF1Ml/3aKkx8nTtdUbLUtOaOZmW4GmHgY1kc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=nhsRfdOW7ZMip41bHEQ17AJ7UN7t6qFjKNsxnJ4UVKeikJNIoq9NI784OpkWmT3ZX
         8B/O3PwlZwOhwT7Z9NTV5mrkdhytAABTpjbWDLpOHah/8MV7z3L48K3PXouKbDMyJ7
         cONDsgwKxWZPJN2hX7vqr7YJd0P8AiU9+XpRzQ68=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231005080158eucas1p102cdc50de509517f32d6bf3c7c935e74~LJ1Iuaocj3067530675eucas1p1P;
        Thu,  5 Oct 2023 08:01:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4D.2C.37758.67D6E156; Thu,  5
        Oct 2023 09:01:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231005080158eucas1p1d516c391154165ff35a0e889b04f0791~LJ1IQrkXF3236132361eucas1p1I;
        Thu,  5 Oct 2023 08:01:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231005080158eusmtrp1fc51268bffe3074b8b11d622f1bfd11f~LJ1IQFSe62145521455eusmtrp1F;
        Thu,  5 Oct 2023 08:01:58 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-88-651e6d76ef08
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8A.43.10549.57D6E156; Thu,  5
        Oct 2023 09:01:57 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231005080157eusmtip28a306a52d700a1cc0fbd9d99e814b3d2~LJ1IETb8R2319523195eusmtip23;
        Thu,  5 Oct 2023 08:01:57 +0000 (GMT)
Received: from localhost (106.210.248.116) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 5 Oct 2023 09:01:57 +0100
Date:   Thu, 5 Oct 2023 09:50:17 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Frank Scheiner <frank.scheiner@web.de>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        =?utf-8?B?VG9tw6HFoQ==?= Glozar <tglozar@gmail.com>
Subject: Re: [PATCH v3 0/7] sysctl: Remove sentinel elements from arch
Message-ID: <20231005075017.auwwtxr4mcxyw3k6@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="yt2unrzgxtxhxy2p"
Content-Disposition: inline
In-Reply-To: <d43037ee-bb7f-0cdc-a14d-8cddca8bb373@web.de>
X-Originating-IP: [106.210.248.116]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7pluXKpBlPuylrMbbnFZrFn70kW
        iw8d71gtzn9ewOTA4rFz1l12j8+b5DxuP9vGEsAcxWWTkpqTWZZapG+XwJXR+Gwte8ElpYr+
        TQvYGhjbpbsYOTkkBEwk/k2az9LFyMUhJLCCUWLVi/fsEM4XRok7B39BZT4zSkz8OYcVpuXi
        8ylQVcsZJRbc+M0IV/Vy2yyoli2MEqdOLWECaWERUJFYOakTzGYT0JE4/+YOM4gtIqAl8X3Z
        c7A4s0CFxIxnP9lAbGEBN4mZn0CmcnLwCphL7H25hwXCFpQ4OfMJC0z9h+6NQGdwANnSEsv/
        cYCEOQWsJCb+mMkGcamyxKUbJ9gh7FqJU1tuMYHcJiHwhUPi8q5dUAkXiR33J0PZwhKvjm+B
        smUkTk/uYYFomMwosf/fB3YIZzWjxLLGr0wQVdYSLVeegF0hIeAosfZqAYTJJ3HjrSDEnXwS
        k7ZNZ4YI80p0tAlBNKpJrL73hmUCo/IsJJ/NQvLZLITPIMI6Egt2f2LDENaWWLbwNTOEbSux
        bt17lgWM7KsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECU9Ppf8e/7mBc8eqj3iFGJg7G
        Q4wqQM2PNqy+wCjFkpefl6okwpveIJMqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFfb9mSykEB6
        YklqdmpqQWoRTJaJg1OqgWmCNEt3xOm3ARquG93qL/oI8B3dMZlXOPyIzMT4dx1HfGIiuqIP
        Lz7f1NB665S//sGwg4kLOpLlbwvrFpbJfP8yyWZKtYfT5htHtk26OlMpWMvfR1T839WoM4eP
        d3ebVpWJmOypqvjuOeX0YYkaGb946zOT1f3cFxnWuQgK3d87OSzn2Fv7VPZ5or9ZvqR8ULQw
        yex+75JRJ1FTbrNIpvWCAF9rVcgamcqcy1Fz5y5c90f06bTCTXlnv/g4hN3R8CzKSle4tFDr
        H4u41cqNn2enX3rKrSm9bfuqSKdXZil7Zs46tfi55KNqvzD2kFdf//w0k9tluvT0tNylKsHz
        T5m2nL6fk3+9vXGG6vZDy5VYijMSDbWYi4oTAQg0V5XIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xe7qluXKpBk39VhZzW26xWezZe5LF
        4kPHO1aL858XMDmweOycdZfd4/MmOY/bz7axBDBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZ
        mVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GUsuLaTseCCUsWhdTvZGxhbpbsYOTkkBEwkLj6f
        wt7FyMUhJLCUUeJs6wxGiISMxMYvV1khbGGJP9e62EBsIYGPjBIve4wgGrYwSmzaMo0dJMEi
        oCKxclInE4jNJqAjcf7NHWYQW0RAS+L7sudgcWaBCokZz36CDRIWcJOY+ek32DJeAXOJvS/3
        sEAMvcUo0fuwjwkiIShxcuYTFojmMokjE9YDNXAA2dISy/9xgIQ5BawkJv6YyQZxqLLEpRsn
        2CHsWonPf58xTmAUnoVk0iwkk2YhTIIIa0nc+PeSCUNYW2LZwtfMELatxLp171kWMLKvYhRJ
        LS3OTc8tNtQrTswtLs1L10vOz93ECIzPbcd+bt7BOO/VR71DjEwcjIcYVYA6H21YfYFRiiUv
        Py9VSYQ3vUEmVYg3JbGyKrUoP76oNCe1+BCjKTAUJzJLiSbnAxNHXkm8oZmBqaGJmaWBqaWZ
        sZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk43uVZ1dV385Hv72rZu72chtmY7unWmWt0pv
        qs6/IXv9Q4Xd9nf3107Ryn55dtaO/mUauxe9V/tZdlxk2ttYNvNCv/oPWlfnHVzRraBxz3KO
        XRwf+7yCKpFevcd/Z5itWxi05+GfJrN46dV6HQ4Xdumddo+dsFy8TzO+QG7zbMv1E3/ufbZ0
        ovMfRvXqnRrO28NPBX9/c3iNyk3pFbknN8xee6OYN50rxt+w5IbzzsjEWWf9OTfIRM94dfdg
        ht5sdtHOh1qZnxtjrr80yJ0SlLdhSk9RzVkx59ayuI03oj6/6VsysaD1XezpTUceSrHyPpTV
        9Pp7Z+2CGOlF/yyqggUWzUs5pm95ctrbXkYLt5NKLMUZiYZazEXFiQA0+ROkZAMAAA==
X-CMS-MailID: 20231005080158eucas1p1d516c391154165ff35a0e889b04f0791
X-Msg-Generator: CA
X-RootMTR: 20231004151227eucas1p1a93116702f7a12c34a8b38bb4a959068
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231004151227eucas1p1a93116702f7a12c34a8b38bb4a959068
References: <20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com>
        <CGME20231004151227eucas1p1a93116702f7a12c34a8b38bb4a959068@eucas1p1.samsung.com>
        <d43037ee-bb7f-0cdc-a14d-8cddca8bb373@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--yt2unrzgxtxhxy2p
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 05:12:17PM +0200, Frank Scheiner wrote:
> Dear Joel,
>=20
> On 02.10.23 13:30, Joel Granados via B4 Relay wrote:
> > [...]
>=20
> I successfully "Build-n-Boot-to-login" tested the following patchset
> (together with the ia64 patch from V2 changed to:
>=20
> ```
> diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
> index 88b3ce3e66cd..65b0781f83ab 100644
> --- a/arch/ia64/kernel/crash.c
> +++ b/arch/ia64/kernel/crash.c
> @@ -232,7 +232,6 @@ static struct ctl_table kdump_ctl_table[] =3D {
>  		.mode =3D 0644,
>  		.proc_handler =3D proc_dointvec,
>  	},
> -	{ }
>  };
>  #endif
>=20
> ```
>=20
> ...) on top of v6.6-rc4 on my rx2620. I also applied the measurement
> patch (commented the printk in `new_dir` and uncommented the if
> conditional).
>=20
> I used a bash arithmetic expression (`accum=3D$(( accum + n ))`) in your
> script to calculate the total memory savings, because `calc` is not
> available as package for Debian on ia64.
>=20
> There are no memory savings for this configuration.
>=20
> But using the measurement patch with the printk in `new_dir` uncommented
> and the if conditional also uncommented I see the following savings (I
> assume this is the same as your measurement patch because the other
> configuration didn't yield any savings):
>=20
> ```
> root@rx2620:~/bin# ./check-mem-savings.bash
> 64
> [...]
> 64
> 5888
> ```
Thankyou very much for all this verification, but the ia64 patch was
dropped from the set. Please see https://lore.kernel.org/all/20230921115034=
=2E5461f62f@canb.auug.org.au

Best

>=20
> > Joel Granados (7):
> >        S390: Remove now superfluous sentinel elem from ctl_table arrays
> >        arm: Remove now superfluous sentinel elem from ctl_table arrays
> >        arch/x86: Remove now superfluous sentinel elem from ctl_table ar=
rays
> >        x86/vdso: Remove now superfluous sentinel element from ctl_table=
 array
> >        riscv: Remove now superfluous sentinel element from ctl_table ar=
ray
> >        powerpc: Remove now superfluous sentinel element from ctl_table =
arrays
> >        c-sky: Remove now superfluous sentinel element from ctl_talbe ar=
ray
> >=20
> >   arch/arm/kernel/isa.c                     | 4 ++--
> >   arch/arm64/kernel/armv8_deprecated.c      | 8 +++-----
> >   arch/arm64/kernel/fpsimd.c                | 2 --
> >   arch/arm64/kernel/process.c               | 1 -
> >   arch/csky/abiv1/alignment.c               | 1 -
> >   arch/powerpc/kernel/idle.c                | 1 -
> >   arch/powerpc/platforms/pseries/mobility.c | 1 -
> >   arch/riscv/kernel/vector.c                | 1 -
> >   arch/s390/appldata/appldata_base.c        | 4 +---
> >   arch/s390/kernel/debug.c                  | 1 -
> >   arch/s390/kernel/topology.c               | 1 -
> >   arch/s390/mm/cmm.c                        | 1 -
> >   arch/s390/mm/pgalloc.c                    | 1 -
> >   arch/x86/entry/vdso/vdso32-setup.c        | 1 -
> >   arch/x86/kernel/cpu/intel.c               | 1 -
> >   arch/x86/kernel/itmt.c                    | 1 -
> >   drivers/perf/arm_pmuv3.c                  | 1 -
> >   17 files changed, 6 insertions(+), 25 deletions(-)
> > ---
> > base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
> > change-id: 20230904-jag-sysctl_remove_empty_elem_arch-81db0a6e6cc4
>=20
> Tested-by: Frank Scheiner <frank.scheiner@web.de> # ia64
>=20
> Cheers,
> Frank

--=20

Joel Granados

--yt2unrzgxtxhxy2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmUeargACgkQupfNUreW
QU92dQv+J4DAjxrrIdVXYrkrhhxkqv+78kbZ+qe6DaEXu55FYtVLgX7BLg2axB9w
QTjVNl4ObPYh/3+uS3Yf0RPTr8zSHvuVJTNz2dQ/vVv3mZUs3yUsyZ8pYFVWCtQS
b6m+FhxLWr09bkZtu0CiB8bpZ4xjhW9ka5EkLwcAWC4CJF50xkk1WovnKhBFZW7h
/cziNc3JnfaZTLpI6+C618Yo/O9I22KrWgdVqj4jRjRXr11XHfDg7R/8hMIcQ68j
FIpSsdOf/9lBot9RgUtx8ZsbvZMxQZowCbycjN3KYSyn/QdxhmQadzjCj9L7DjD5
sz725qR0WGV+ouNbRgcCA8dkrxeautkxywefyxV5DOfHOh/JCi0ORmZw7PUWMQ6h
g7L3Ni4iXYfDeDTfyhxqvEuG9BrqeBq5bidgODhaPT8GT/DkKHbMMMQX2J0gOSz2
7wg7A2zcXLshv9iUQcrKM4HMbpzjLhvRFuquybO8IRmDg3H2lsD9WimkMneTgF3f
w1bFb7Z2
=3pKJ
-----END PGP SIGNATURE-----

--yt2unrzgxtxhxy2p--
