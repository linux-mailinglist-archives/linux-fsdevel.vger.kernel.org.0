Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C01FFDB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 06:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfKRFEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 00:04:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37159 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfKRFEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 00:04:21 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191118050416epoutp01e51966e34e662777f7e440226607c9ae~YKUd6GKO51815018150epoutp014
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2019 05:04:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191118050416epoutp01e51966e34e662777f7e440226607c9ae~YKUd6GKO51815018150epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574053456;
        bh=e3uf2DbfI6TPAGk560nhGnj317VihdUrSG7FSQ29AwM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=TcMEdUM/h4bPUXfWNjbJhkB/27NIU/vuCPo7lIUX3Acw5Qokw9BPjTHTg5L6YJMGH
         qdbsUdGuIKNvjv8g0/cE4/IjTUbdk19plZZ4AHUe8b53YxWSLQ/rl+YPaeZsXzIw/Y
         a3oBG9GeFkhzQYFXgJ+IyxZ31br+OjLM7xWNXmBs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191118050416epcas1p227c92a11b1e8ca015fd8b4ccecb3830b~YKUdeY7fQ0257802578epcas1p2P;
        Mon, 18 Nov 2019 05:04:16 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47GcLl4tjKzMqYm6; Mon, 18 Nov
        2019 05:04:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.2A.04235.E4622DD5; Mon, 18 Nov 2019 14:04:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191118050413epcas1p4d4512de494fe8572858febacd0c93146~YKUbDsOEK2912629126epcas1p4R;
        Mon, 18 Nov 2019 05:04:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191118050413epsmtrp168071bf016e17768a49e1e999bba2bd4~YKUbC-0_B0499804998epsmtrp1I;
        Mon, 18 Nov 2019 05:04:13 +0000 (GMT)
X-AuditID: b6c32a36-defff7000000108b-f8-5dd2264e5aa1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.58.03814.D4622DD5; Mon, 18 Nov 2019 14:04:13 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191118050413epsmtip295d72ca8d0ec4a40d40d8f3ea9464ceb~YKUa6BlpK2706427064epsmtip2G;
        Mon, 18 Nov 2019 05:04:13 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Markus Elfring'" <Markus.Elfring@web.de>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        =?UTF-8?Q?'Valdis_Kl=C4=93tnieks'?= <valdis.kletnieks@vt.edu>,
        <linkinjeon@gmail.com>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <82520012-9940-7f2b-3bac-bea5c2396ccd@web.de>
Subject: RE: [PATCH 03/13] exfat: add inode operations
Date:   Mon, 18 Nov 2019 14:04:13 +0900
Message-ID: <00bc01d59dcd$9ecbf1c0$dc63d540$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIQCFpoHpuwgXe5hAooxf3JBm1kowBeym9fAivdLa+nBzSvUA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmga6f2qVYg4VvOCyaF69ns1i5+iiT
        xdZb0hbX795ittiz9ySLxeVdc9gs/s96zmqx5d8RVotL7z+wOHB67Jx1l91j/9w17B67bzaw
        efRtWcXo8XmTnMeh7W/YPG4/28YSwB6VY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGto
        aWGupJCXmJtqq+TiE6DrlpkDdJmSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQ
        oECvODG3uDQvXS85P9fK0MDAyBSoMiEn433/G5aCOTwV76d/ZWpg/MjdxcjJISFgIvFz1We2
        LkYuDiGBHYwSr+Y3skA4nxglTh7uhMp8Y5R4//EiI0zL9MMXWSESexkltk77yQqSEBJ4xShx
        +rwNiM0moCvx789+NhBbREBPYtKbw2ANzAInmSS+LT7O3MXIwcEpYCWxbaMhSI2wgJnErf52
        FhCbRUBVYse2+WC9vAKWEu+3vGOEsAUlTs58AlbDLKAtsWzha2aIgxQkdpx9zQgyUkTASeLq
        QhuIEhGJ2Z1tzCBrJQSa2SUu7m6EesBFou1pGxuELSzx6vgWdghbSuJlfxs7yBwJgWqJj/uh
        xncwSrz4bgthG0vcXL+BFaSEWUBTYv0ufYiwosTO33MZIdbySbz72sMKMYVXoqNNCKJEVaLv
        0mEmCFtaoqv9A/sERqVZSP6aheSvWUgemIWwbAEjyypGsdSC4tz01GLDAiPkqN7ECE6zWmY7
        GBed8znEKMDBqMTD+6D8YqwQa2JZcWXuIUYJDmYlEV6/RxdihXhTEiurUovy44tKc1KLDzGa
        AoN9IrOUaHI+MAfklcQbmhoZGxtbmJiZm5kaK4nzcvwAmiOQnliSmp2aWpBaBNPHxMEp1cCY
        st5X4+OLc5umhuf5KNje8D8X9PaiRfBat/Nn3x83makzeaXTqoJIwUh9fhabqy2ZNvdOWqzi
        bhY/aGOxSz51vqnQkeln11dw393Q8P53u+jFpBhvP7P11SrZN3krdLQuv7n9JmJfUaJ7mlXE
        csbStHMNqVdPad4zb3/zlcd3+79zd4yVphYpsRRnJBpqMRcVJwIA3jLmN8kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSvK6v2qVYgwNNqhbNi9ezWaxcfZTJ
        YustaYvrd28xW+zZe5LF4vKuOWwW/2c9Z7XY8u8Iq8Wl9x9YHDg9ds66y+6xf+4ado/dNxvY
        PPq2rGL0+LxJzuPQ9jdsHrefbWMJYI/isklJzcksSy3St0vgytg24Q97wWqOiruPljM3MJ5i
        62Lk5JAQMJGYfvgiaxcjF4eQwG5GiZ6prVAJaYljJ84wdzFyANnCEocPF4OEhQReMEo8/SIJ
        YrMJ6Er8+7MfrFxEQE9i0pvDYHOYBc4zSRyecJERbujL3T1MIIM4Bawktm00BGkQFjCTuNXf
        zgJiswioSuzYNh9sEK+ApcT7Le8YIWxBiZMzn4DVMAtoS/Q+bGWEsZctfM0McaeCxI6zrxlB
        xosIOElcXWgDUSIiMbuzjXkCo/AsJJNmIZk0C8mkWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcr
        TswtLs1L10vOz93ECI44La0djCdOxB9iFOBgVOLhfVB+MVaINbGsuDL3EKMEB7OSCK/fowux
        QrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhh1fOcHynBM
        XZx/iTVT6d0tsYsbIm/d6hNXay7QO6nh/jZPJNb4lzITv88j33KtovuvNM0CFFI4XHU9Jutn
        GYbM6TjcOsXqmd3WJwt+skYEXcuazat4JDIgY/6KleqGnwtbOCfd883k/tWb9/JUpJxhYGT1
        nl8r1mfdCWw4rOSV8lSq6cenRiWW4oxEQy3mouJEAFurdsm0AgAA
X-CMS-MailID: 20191118050413epcas1p4d4512de494fe8572858febacd0c93146
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191117141554epcas1p16bea365f1667a39e1d28a1f799396567
References: <20191113081800.7672-4-namjae.jeon@samsung.com>
        <CGME20191117141554epcas1p16bea365f1667a39e1d28a1f799396567@epcas1p1.samsung.com>
        <82520012-9940-7f2b-3bac-bea5c2396ccd@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> =E2=80=A6=0D=0A>=20>=20+++=20b/fs/exfat/inode.c=0D=0A>=20=E2=80=A6=0D=0A>=
=20>=20+static=20int=20exfat_create(struct=20inode=20*dir,=20struct=20dentr=
y=20*dentry,=20umode_t=0D=0A>=20mode,=0D=0A>=20>=20+=09=09bool=20excl)=0D=
=0A>=20>=20+=7B=0D=0A>=20=E2=80=A6=0D=0A>=20+out:=0D=0A>=20+=09mutex_unlock=
(&EXFAT_SB(sb)->s_lock);=0D=0A>=20=0D=0A>=20Can=20the=20label=20=E2=80=9Cun=
lock=E2=80=9D=20be=20more=20appropriate?=0D=0AYep,=20Will=20change=20it.=0D=
=0A>=20=0D=0A>=20=0D=0A>=20>=20+static=20struct=20dentry=20*exfat_lookup(st=
ruct=20inode=20*dir,=20struct=20dentry=0D=0A>=20*dentry,=0D=0A>=20>=20+=09=
=09unsigned=20int=20flags)=0D=0A>=20>=20+=7B=0D=0A>=20=E2=80=A6=0D=0A>=20>=
=20+error:=0D=0A>=20>=20+=09mutex_unlock(&EXFAT_SB(sb)->s_lock);=0D=0A>=20=
=0D=0A>=20Would=20you=20like=20to=20use=20the=20label=20=E2=80=9Cunlock=E2=
=80=9D=20also=20at=20this=20place=20(and=20similar=0D=0A>=20ones)?=0D=0AYep=
,=20Will=20change=20all=20ones.=0D=0A=0D=0A>=20=0D=0A>=20=0D=0A>=20>=20+sta=
tic=20int=20exfat_search_empty_slot(struct=20super_block=20*sb,=0D=0A>=20>=
=20+=09=09struct=20exfat_hint_femp=20*hint_femp,=20struct=20exfat_chain=20*=
p_dir,=0D=0A>=20>=20+=09=09int=20num_entries)=0D=0A>=20>=20+=7B=0D=0A>=20=
=E2=80=A6=0D=0A>=20>=20+out:=0D=0A>=20>=20+=09kfree(clu);=0D=0A>=20=0D=0A>=
=20How=20do=20you=20think=20about=20to=20rename=20the=20label=20to=20=E2=80=
=9Cfree_clu=E2=80=9D?=0D=0AYep,=20Will=20change=20it=20on=20V2.=0D=0A=0D=0A=
Thanks=20for=20your=20review=21=0D=0A>=20=0D=0A>=20Regards,=0D=0A>=20Markus=
=0D=0A=0D=0A
