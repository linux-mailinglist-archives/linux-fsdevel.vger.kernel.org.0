Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC78B23054B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 10:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgG1IYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 04:24:09 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48748 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgG1IYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:24:07 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200728082403epoutp014f367d036f9e3516aa8501895ccfdc57~l3QHimkPy0633506335epoutp01g
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 08:24:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200728082403epoutp014f367d036f9e3516aa8501895ccfdc57~l3QHimkPy0633506335epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595924643;
        bh=lffFS9Qk7KyQhIt5idZnIw+cL7XP2ngNX4A36tfUE/E=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=KNilb2ZR8+G/UcIymCi8skSL8P3o0uPtosfBmyHGC+EIen5Tt8k7rW1yu6Nnemgz4
         uitykU3XG1dQKOZu53XrClZ417uTq4baeg3eJ4KtnpCGS0uOptsKUsB7yRY6pdFNUf
         oedzPBvuDWiIfoKXuBdinYxRSRHOD5nmf1wyzT8k=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200728082402epcas5p28795d7bdd17e9f01703f028ca02ee1a8~l3QHKB8JP2028320283epcas5p2P;
        Tue, 28 Jul 2020 08:24:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.96.09475.2A0EF1F5; Tue, 28 Jul 2020 17:24:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200728082402epcas5p333b3017f433ad9998564fbb8f3816f30~l3QGfRnz32645526455epcas5p3_;
        Tue, 28 Jul 2020 08:24:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200728082401epsmtrp26ec2661f02fd4598740d88b635619f6c~l3QGeXCrz2759827598epsmtrp2h;
        Tue, 28 Jul 2020 08:24:01 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-36-5f1fe0a2901b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.C1.08303.1A0EF1F5; Tue, 28 Jul 2020 17:24:01 +0900 (KST)
Received: from alimakhtar02 (unknown [107.111.84.49]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200728082400epsmtip2aeb1eebe4e35d5115587fdb564990b7b~l3QEpektJ1407014070epsmtip2O;
        Tue, 28 Jul 2020 08:23:59 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Randy Dunlap'" <rdunlap@infradead.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        <broonie@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-next@vger.kernel.org>, <mhocko@suse.cz>,
        <mm-commits@vger.kernel.org>, <sfr@canb.auug.org.au>,
        "'linux-scsi'" <linux-scsi@vger.kernel.org>,
        "'Seungwon Jeon'" <essuuj@gmail.com>
In-Reply-To: <c99c3cef-1b03-0adf-62a6-373e692425b5@infradead.org>
Subject: RE: mmotm 2020-07-27-18-18 uploaded (drivers/scsi/ufs/:
 SCSI_UFS_EXYNOS)
Date:   Tue, 28 Jul 2020 13:53:58 +0530
Message-ID: <000001d664b8$72cbd790$586386b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH6RHqNssVmezboDnOhfcuciV9AnAIQbK05Ag8N1j2os+oSEA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7bCmlu6iB/LxBvMvKFvMWb+GzWLqwyds
        FssvLGGy2LP3JIvF5V1z2CzurfnPanFwYRujRff1HWwWr5q/s1q8nniB1eLtneksFlv3XmV3
        4PFovHGDzWPnrLvsHptXaHlsWtXJ5rHp0yR2jxMzfrN4nFlwhN3j8ya5AI4oLpuU1JzMstQi
        fbsErowv+z+zFVzkr7jS18zWwPiPp4uRk0NCwESi4ec1FhBbSGA3o8TXv7xdjFxA9idGiS0T
        zjJCOJ8ZJS6ceMwE03FsXS9UYhejxJOVr1khnFeMEh+eHGUHqWIT0JXYsbiNDSQhItDNLPH5
        YwsbSIJTwFHi2LVNYKOEBYIl9s4+zwxiswioSkzc+xPM5hWwlHg8eSsjhC0ocXLmE7ADmQW0
        JZYtfM0McYaCxM+ny1hBbBEBJ4nnS0+wQ9SISxz92cMMslhC4AiHxK75ExkhGlwk3vR2skLY
        whKvjm9hh7ClJD6/2wt0HAeQnS3Rs8sYIlwjsXTeMRYI217iwJU5LCAlzAKaEut36UOs4pPo
        /f2ECaKTV6KjTQiiWlWi+d1VqE5piYnd3VBLPSR6evugYXWaUWJ6SzPjBEaFWUi+nIXky1lI
        vpmFsHkBI8sqRsnUguLc9NRi0wLjvNRyveLE3OLSvHS95PzcTYzgtKblvYPx0YMPeocYmTgY
        DzFKcDArifByi8rEC/GmJFZWpRblxxeV5qQWH2KU5mBREudV+nEmTkggPbEkNTs1tSC1CCbL
        xMEp1cDkoBKWt9yjoVpCRTJjLsvXGzeTmc9rNZ/7UmbwQ6nL02nDto6in8liF+8r6jKnfpjZ
        aCt+tbJH6/uH65ETWlqWzC6f8T3FcqpF2lIRTwGvA37KE7n+euyfOvvAaaPFTD/a0s39Eiz1
        +i6/ygrYm9PBvjvrwULp/cJmzHMyDjhfsLr75lRliEzir+ZXDK/sVmYVJQtHdGmfPDzfvN3u
        +ww25y0cvWJ3JixbHm147+nnQ1ZHex6orXybc4DNL3HvDi9n7t02s2IX5Zs6NP4qUM28GmN9
        tbalbcc67RlnzDoTxM+1bHBX+MfXsm9KlWTYTpfNv36wWYjYPHmb/fje6kutri7P6iOU7H6L
        l/g2dSmxFGckGmoxFxUnAgChHnJk2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSvO7CB/LxBmtvGlvMWb+GzWLqwyds
        FssvLGGy2LP3JIvF5V1z2CzurfnPanFwYRujRff1HWwWr5q/s1q8nniB1eLtneksFlv3XmV3
        4PFovHGDzWPnrLvsHptXaHlsWtXJ5rHp0yR2jxMzfrN4nFlwhN3j8ya5AI4oLpuU1JzMstQi
        fbsErox9D/rZC97zVaz4sYmpgXEBTxcjJ4eEgInEsXW9jF2MXBxCAjsYJRYu62KCSEhLXN84
        gR3CFpZY+e85O0TRC0aJ8/u3soAk2AR0JXYsbmMDSYgITGeW+DHpOjNE1XFGiWmv1oCN4hRw
        lDh2bROQzcEhLBAosWqnK0iYRUBVYuLen8wgNq+ApcTjyVsZIWxBiZMzn4AtYBbQlnh68ymc
        vWzha2aIixQkfj5dxgpiiwg4STxfeoIdokZc4ujPHuYJjEKzkIyahWTULCSjZiFpWcDIsopR
        MrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgOtbR2MO5Z9UHvECMTB+MhRgkOZiURXm5R
        mXgh3pTEyqrUovz4otKc1OJDjNIcLErivF9nLYwTEkhPLEnNTk0tSC2CyTJxcEo1MLXOk19S
        IlLVqlhmdz3GobpbUWr9or+ij643Kr24u8LJaZ/MCr0fNYn+P4M8BfZHO4Xs8T7u9J77/Wff
        Rfckph3byNAvNZu7b97MipeZhkKKFt+2iJ7sjijl+e/GlLN6stavI8tOtOdwbbb+nxrTv/9k
        vod74ZslN3tlb51zuNKW/yVN8lx7iYSRptzqi0GvotqkuiXmPGJrtDziJLTGb8KPjRbvojqK
        8gstLa984J7E86NSsbg/MylH/6jt5u/7ll072HXJ/rm4y6x3rdIbf9XtiJFt7Dy30Tl/zb0T
        91wKPT+2Kj78FDllvtlkDfO3zXI/Das7OyrZGcXnNhV+nWPT+fvJRq+epA8eJU/WK7EUZyQa
        ajEXFScCAH7AEroyAwAA
X-CMS-MailID: 20200728082402epcas5p333b3017f433ad9998564fbb8f3816f30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200728032310epcas5p27226ae967b93325ca145e70a14a8bdf8
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
        <CGME20200728032310epcas5p27226ae967b93325ca145e70a14a8bdf8@epcas5p2.samsung.com>
        <c99c3cef-1b03-0adf-62a6-373e692425b5@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Randy,

> -----Original Message-----
> From: Randy Dunlap <rdunlap=40infradead.org>
> Sent: 28 July 2020 08:53
> To: Andrew Morton <akpm=40linux-foundation.org>; broonie=40kernel.org; li=
nux-
> fsdevel=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-mm=40kva=
ck.org;
> linux-next=40vger.kernel.org; mhocko=40suse.cz; mm-commits=40vger.kernel.=
org;
> sfr=40canb.auug.org.au; linux-scsi <linux-scsi=40vger.kernel.org>; Alim A=
khtar
> <alim.akhtar=40samsung.com>; Seungwon Jeon <essuuj=40gmail.com>
> Subject: Re: mmotm 2020-07-27-18-18 uploaded (drivers/scsi/ufs/:
> SCSI_UFS_EXYNOS)
>=20
> On 7/27/20 6:19 PM, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2020-07-27-18-18 has been uploaded to
> >
> >    http://www.ozlabs.org/=7Eakpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/=7Eakpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random
> > hopefully more than once a week.
> >
> > You will need quilt to apply these patches to the latest Linus release
> > (5.x or 5.x-rcY).  The series file is in broken-out.tar.gz and is
> > duplicated in http://ozlabs.org/=7Eakpm/mmotm/series
> >
>=20
> on i386:
>=20
> when CONFIG_OF is not set/enabled:
>=20
> WARNING: unmet direct dependencies detected for PHY_SAMSUNG_UFS
>   Depends on =5Bn=5D: OF =5B=3Dn=5D && (ARCH_EXYNOS =7C=7C COMPILE_TEST =
=5B=3Dy=5D)
>   Selected by =5Bm=5D:
>   - SCSI_UFS_EXYNOS =5B=3Dm=5D && SCSI_LOWLEVEL =5B=3Dy=5D && SCSI =5B=3D=
y=5D &&
> SCSI_UFSHCD_PLATFORM =5B=3Dm=5D && (ARCH_EXYNOS =7C=7C COMPILE_TEST =5B=
=3Dy=5D)
>=20
Have already posted a fix for this =5B1=5D
=5B1=5D https://www.spinics.net/lists/linux-scsi/msg144970.html

>=20
> Full randconfig file is attached.
>=20
Thanks for config file, I can reproduce it and confirm that =5B1=5D above f=
ixes this Warning.

>=20
> --
> =7ERandy
> Reported-by: Randy Dunlap <rdunlap=40infradead.org>

