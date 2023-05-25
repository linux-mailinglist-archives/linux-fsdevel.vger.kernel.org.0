Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01C71072D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 10:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbjEYIT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEYIT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 04:19:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FFEE44;
        Thu, 25 May 2023 01:19:17 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230525081912euoutp01d5f4fb60178b69f801cb177fbc394bd9~iVROGwMBV0448504485euoutp01D;
        Thu, 25 May 2023 08:19:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230525081912euoutp01d5f4fb60178b69f801cb177fbc394bd9~iVROGwMBV0448504485euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685002752;
        bh=f9fcQC7PEyGgRLe4Ita8t7S6+I39+aoehkVzcsRbnfI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=MVOaLfn3oQF1RQBE3W87B4z42V3N3UzWF5CeinutLfKQ1lLZwi7VgorRDRCT3PVBe
         HcC1G6HPS2Fy/1wsJC+VpaywUkL3PppMJi0BDvt54AAl7RGJP4LC5aICmC6G4f6mgD
         6QvXO0cil9heLDaTnoHSaZzsVKIu3NSsGaSPVFeM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230525081912eucas1p1b68f3b87d7ecea082a2ca105c4399413~iVRN3mDqK0556205562eucas1p1w;
        Thu, 25 May 2023 08:19:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 28.E8.11320.00A1F646; Thu, 25
        May 2023 09:19:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230525081912eucas1p24062878f24235930402dab922d5215a7~iVRNY-nDH1056910569eucas1p2O;
        Thu, 25 May 2023 08:19:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230525081912eusmtrp2faedeafcd15cf836dd38b43e03263928~iVRNYJicy0871308713eusmtrp2g;
        Thu, 25 May 2023 08:19:12 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-a0-646f1a00003c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 27.30.14344.FF91F646; Thu, 25
        May 2023 09:19:12 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230525081911eusmtip26353ce7c14a164bfd559540f09b3e93b~iVRNJh7gz1761617616eusmtip2u;
        Thu, 25 May 2023 08:19:11 +0000 (GMT)
Received: from localhost (106.210.248.84) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 25 May 2023 09:19:11 +0100
Date:   Thu, 25 May 2023 10:19:09 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <lkft-triage@lists.linaro.org>,
        chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: LTP: syscalls: statx06.c:138: TFAIL: Modified time > after_time
Message-ID: <20230525081909.4c3qb32dbruhnfgv@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="e3447msvdpt5chjl"
Content-Disposition: inline
In-Reply-To: <784b9a90-9d56-4e53-8f92-676e76e49665@kili.mountain>
X-Originating-IP: [106.210.248.84]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7djP87oMUvkpBpu2KFncmvKbyeLvpGPs
        Fq8Pf2K0mP7iKJvFh3mt7BZ79p5ksbi8aw6bxdZ709gtVnzfwWhx6xO/xY9bN1gszv89zurA
        4/H71yRGj02rOtk87lzbw+Zx+99jZo99v9exepxZcITd4/MmOY9NT94yBXBEcdmkpOZklqUW
        6dslcGWs/feFqeCIVsX5rlbGBsatKl2MnBwSAiYSc9tmMXUxcnEICaxglHhxZxcjhPOFUeL0
        reVQmc+MEh8nP2aDaXnUtoANIrGcUWLW3mcIVeuPH2WBcLYwSvQ3HWMBaWERUJVY/egYE4jN
        JqAjcf7NHWYQWwTI/vd3MlgDs0Afs8TrpmdgO4QFfCSuz/nCDmLzCphLrH3bxwJhC0qcnPkE
        zGYWqJC4uecckM0BZEtLLP/HARLmFHCU+DF1NhPEqUoSuz80Qtm1Eqe23IKyL3FK7DnvAmG7
        SOz5Mo8RwhaWeHV8CzuELSPxf+d8sM8kBCYzSuz/94EdwlnNKLGs8SvUJGuJlitPoDocJb5M
        +sgIcpCEAJ/EjbeCEHfySUzaNp0ZIswr0dEmBFGtJrH63huWCYzKs5B8NgvJZ7MQPoMI60gs
        2P2JDUNYW2LZwtfMELatxLp171kWMLKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEyO
        p/8d/7KDcfmrj3qHGJk4GA8xqgA1P9qw+gKjFEtefl6qkgjvifLsFCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1M095fX8TS1Syr+MfjyeKDh74eMLM5
        ZHpMlpv7oZXmJKkzLyV2HmB67fq+jtd6h3j1h7zZlqZcIvlKOmobU9b9aFS/tZD3tPPelcEL
        v65WMQ28cmtDicTaqIi5ieVvTklULL3kf+jKnWjug21mbE2bVp1Q13zHkue0UPcow3p7Zp4J
        L40dbHx6veRK1UI+3T8UHc6gwM76rPjiGePqT7+0duQs4zL5O+2X9/+T+39aZfNsu7jx5xyF
        5/+Vnjpd+Ki65OC5bInpx9n+fuu28NN4+nd5qUrap/BgjY8ZCeuOvWEKXBc6e3HEP5t7j4IM
        v8x0alyten7F42DT9MyUiYzPxT2zrnUEJVy4G28e82uriBJLcUaioRZzUXEiABaRGccJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t/xe7oMUvkpBqvXMVncmvKbyeLvpGPs
        Fq8Pf2K0mP7iKJvFh3mt7BZ79p5ksbi8aw6bxdZ709gtVnzfwWhx6xO/xY9bN1gszv89zurA
        4/H71yRGj02rOtk87lzbw+Zx+99jZo99v9exepxZcITd4/MmOY9NT94yBXBE6dkU5ZeWpCpk
        5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV8fXKcseCQVkX/1r/M
        DYybVboYOTkkBEwkHrUtYAOxhQSWMkp865KGiMtIbPxylRXCFpb4c60LqIYLqOYjo8SUs8+Z
        IZwtjBLdJ/cxgVSxCKhKrH50DMxmE9CROP/mDjOILQJk//s7mQWkgVmgj1li3akjYAlhAR+J
        63O+sIPYvALmEmvf9rFATL3NKPHh4A5miISgxMmZT4ASHEDdZRJzJhRAmNISy/9xgFRwCjhK
        /Jg6mwniUiWJ3R8aoexaic9/nzFOYBSehWTQLIRBsxAGgVQwC2hJ3Pj3kglDWFti2cLXzBC2
        rcS6de9ZFjCyr2IUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAhMDtuO/dyyg3Hlq496hxiZOBgP
        MaoAdT7asPoCoxRLXn5eqpII74ny7BQh3pTEyqrUovz4otKc1OJDjKbAQJzILCWanA9MW3kl
        8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwzMk1O/5pz9Bx7SrmG
        xGbV7Ybyb6wjmfb4sQr23Yq5aqMitX6LYOnm0xuX2YSua9rofW/2jDSR1xmb8nXN5DZ0y963
        5lz1bEbil/aT1pGfDlSrKrrJrp6x8Zu+yofIlFld/qfPuWtsuS/uyemSv0ilb5Hr1I2PLDsj
        jiXIzfxTVrmU98b0G2LbJ1mv52EWrVxlyj194iSP8/a3ow0WK5ytu55fFOMrYhke25I8MXVu
        +7Un6/o3cT4v5V9g/nSfy4+y2K2MyxyufMso1mNLOn2vOWaeSNGsznML7n3fW9t4cvrxzUnW
        aRP7L4ZKvrl6plxYfKKIKdPLKx0dtyWEpj9lUBJxDK7cFlLl2heqd02JpTgj0VCLuag4EQB3
        Q2RNowMAAA==
X-CMS-MailID: 20230525081912eucas1p24062878f24235930402dab922d5215a7
X-Msg-Generator: CA
X-RootMTR: 20230524112328eucas1p1a0de123f5b54245bfe167308352de194
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230524112328eucas1p1a0de123f5b54245bfe167308352de194
References: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
        <CGME20230524112328eucas1p1a0de123f5b54245bfe167308352de194@eucas1p1.samsung.com>
        <784b9a90-9d56-4e53-8f92-676e76e49665@kili.mountain>
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

--e3447msvdpt5chjl
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 02:23:16PM +0300, Dan Carpenter wrote:
> I am pretty sure this is caused by commit 7eec88986dce ("sysctl:
> Refactor base paths registrations").  Add Joel to the CC list.
>=20
> Before we used to use register_sysctl_table() to register that table.
>=20
> regards,
> dan carpenter
>=20
> On Wed, May 24, 2023 at 04:18:42PM +0530, Naresh Kamboju wrote:
> > LTP syscalls statx06 fails on NFS mounted devices using external hard d=
rives
> > for testing and running on Linux next 6.4.0-rc3-next-20230524.
> >=20
> > Test case fails on x86_64, i386 and arm64 Juno-r2.
> >=20
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >=20
> >=20
> > Linux version 6.4.0-rc3-next-20230524 (tuxmake@tuxmake)
> > (x86_64-linux-gnu-gcc (Debian 11.3.0-12) 11.3.0, GNU ld (GNU Binutils
> > for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1684908723
> > ...
> >=20
> > [    1.396191] Mountpoint-cache hash table entries: 32768 (order: 6,
> > 262144 bytes, linear)
> > [    1.397234] sysctl table check failed: kernel/usermodehelper Not a f=
ile
> > [    1.398166] sysctl table check failed: kernel/usermodehelper No proc=
_handler
> > [    1.399165] sysctl table check failed: kernel/usermodehelper bogus .=
mode 0555
> > [    1.400166] sysctl table check failed: kernel/keys Not a file
> > [    1.401165] sysctl table check failed: kernel/keys No proc_handler
> > [    1.402165] sysctl table check failed: kernel/keys bogus .mode 0555
This should all be fixed with
https://lore.kernel.org/all/20230523122220.1610825-1-j.granados@samsung.com/

> > [    1.403166] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> > 6.4.0-rc3-next-20230524 #1
> > [    1.404165] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.5 11/26/2020
> > [    1.404165] Call Trace:
> > [    1.404165]  <TASK>
> > [    1.404165]  dump_stack_lvl+0x72/0x90
> > [    1.404165]  dump_stack+0x14/0x20
> > [    1.404165]  __register_sysctl_table+0x570/0x840
> > [    1.404165]  __register_sysctl_init+0x29/0x60
> > [    1.404165]  sysctl_init_bases+0x27/0x80
> > [    1.404165]  proc_sys_init+0x37/0x40
> > [    1.404165]  proc_root_init+0x7b/0x90
> > [    1.404165]  start_kernel+0x403/0x6a0
> > [    1.404165]  x86_64_start_reservations+0x1c/0x30
> > [    1.404165]  x86_64_start_kernel+0xcb/0xe0
> > [    1.404165]  secondary_startup_64_no_verify+0x179/0x17b
> > [    1.404165]  </TASK>
> > [    1.404165] failed when register_sysctl kern_table to kernel
> >=20
> > ....
> > ./runltp -f syscalls -d /scratch
> >=20
> > ...
> >=20
> > [ 1192.088987] loop0: detected capacity change from 0 to 614400
> > tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts=3D'-I 256'
> > extra opts=3D''
> > mke2fs 1.46.5 (30-Dec-2021)
> > [ 1192.337350] EXT4-fs (loop0): mounted filesystem
> > dfe9283c-5d2f-43f8-840e-a2bbbff5b202 r/w with ordered data mode. Quota
> > mode: none.
> > tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
> >=20
> > statx06.c:140: TPASS: Birth time Passed
> > statx06.c:138: TFAIL: Modified time > after_time
> > statx06.c:140: TPASS: Access time Passed
> > statx06.c:140: TPASS: Change time Passed
> >=20
> >=20
> > links,
> >  - https://protect2.fireeye.com/v1/url?k=3Dcdaccb27-acd761af-cdad4068-7=
4fe4860018a-69c3d7b272f81ebe&q=3D1&e=3D6d71a9ab-f4cd-4235-b09a-35fa9af4bdc2=
&u=3Dhttps%3A%2F%2Fqa-reports.linaro.org%2Flkft%2Flinux-next-master%2Fbuild=
%2Fnext-20230524%2Ftestrun%2F17171892%2Fsuite%2Fltp-syscalls%2Ftest%2Fstatx=
06%2Flog
> >  - https://protect2.fireeye.com/v1/url?k=3D04c58bbf-65be2137-04c400f0-7=
4fe4860018a-ee117eefec304706&q=3D1&e=3D6d71a9ab-f4cd-4235-b09a-35fa9af4bdc2=
&u=3Dhttps%3A%2F%2Fqa-reports.linaro.org%2Flkft%2Flinux-next-master%2Fbuild=
%2Fnext-20230524%2Ftestrun%2F17171892%2Fsuite%2Fltp-syscalls%2Ftest%2Fstatx=
06%2Fhistory%2F
> >  - https://protect2.fireeye.com/v1/url?k=3Db2e23b58-d39991d0-b2e3b017-7=
4fe4860018a-6ee7cd6348bd7aa8&q=3D1&e=3D6d71a9ab-f4cd-4235-b09a-35fa9af4bdc2=
&u=3Dhttps%3A%2F%2Fqa-reports.linaro.org%2Flkft%2Flinux-next-master%2Fbuild=
%2Fnext-20230524%2Ftestrun%2F17171892%2Fsuite%2Fltp-syscalls%2Ftest%2Fstatx=
06%2Fdetails%2F
> >=20
> >=20
> > --
> > Linaro LKFT
> > https://protect2.fireeye.com/v1/url?k=3Df45a98bf-95213237-f45b13f0-74fe=
4860018a-bc1dde58624c2012&q=3D1&e=3D6d71a9ab-f4cd-4235-b09a-35fa9af4bdc2&u=
=3Dhttps%3A%2F%2Flkft.linaro.org%2F

--=20

Joel Granados

--e3447msvdpt5chjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRvGfsACgkQupfNUreW
QU9Aegv/WC6bHh+3MHVye5XXDiIY3ko3R5fL51wZZV0H7jAosMVDqIny+vQCDtM6
porYKQSr3kwLAEkiobUPkf/zb2VboFsmMdHn/+3x347QhiotMjNtJu5m7h3Q6SZx
f6zKZ9WT46mTawbS/LMMe7nFU6sNGcvBwolZvlEmHKzroOzlwoXVHc5eMclglzL6
vCn+eUFYiD5UaMAPgL3qkRaalh1mnCEnkhmtcoUc0KBbsmLn4qSg0HJwCdi8QRW2
lGX2fjR/gtqH3uur2I3hKw9U8iZxZfOhZTPxAYM3J1Y3QolNZXQ8PAi7JbR6U77Y
odsBIS/JhGX2EQAVwvUkHXYF0wf73CX5c3XF57gDgTicrglfj/UZmxfridhNqKs8
cZTw6nvh0Ktczk/hVH2hF7y5qUkKUpzgDDO9aJO36y8s14v8ok6WpBo5qQIbEIQe
i48IUamgShFK7FOQnsVfj+rb6hzu/LgRLHOIzua6deRNov1lmaYSaxCwaFXxw0fo
z6dGzCRf
=iaM3
-----END PGP SIGNATURE-----

--e3447msvdpt5chjl--
