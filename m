Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743B437B2CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 01:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKXyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 19:54:22 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63713 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKXyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 19:54:21 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210511235313epoutp01750ffc7472ee240870d830ccd048c2c1~_KEUSybBR3076330763epoutp01P
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 23:53:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210511235313epoutp01750ffc7472ee240870d830ccd048c2c1~_KEUSybBR3076330763epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620777193;
        bh=yrvxC7jDdramzpK6UTY0r2mdnpereMUhAni+ES+Zrx8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ch2tA6WdxpNgVQvuNFYA2VUzrZQUr/CxeJKo/BeQY6AXX5BcRgH6QxJMXfxgFDKI6
         X+vrMWUjUYhnNdLgf8brRsAYsjbA2lEUEXPFuc9V3+B9vV4YTxLNoOVuSBYhkgLn4C
         JooQfthldSUiLCBzfOGzqxoJCdUxnFXA10u7mURI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210511235312epcas1p1a761717c7bead30b0eab5e60e8692323~_KET6PZsy1557215572epcas1p1J;
        Tue, 11 May 2021 23:53:12 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Ffvr745L1z4x9Q1; Tue, 11 May
        2021 23:53:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.79.09578.7E81B906; Wed, 12 May 2021 08:53:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210511235311epcas1p16cf9bab6edeae2b9e82abd17da36e3b7~_KESkDCht0344803448epcas1p13;
        Tue, 11 May 2021 23:53:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210511235311epsmtrp1b3cd921ec5d0d578cb6b9e7f8170a919~_KESjL_L91563815638epsmtrp1T;
        Tue, 11 May 2021 23:53:11 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-21-609b18e74e59
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.9F.08637.7E81B906; Wed, 12 May 2021 08:53:11 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210511235310epsmtip11afe7e6ca61491f15906ae7f5c356b01~_KESZG7Uc0916709167epsmtip17;
        Tue, 11 May 2021 23:53:10 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'Pavel Reichl'" <preichl@redhat.com>,
        <chritophe.vu-brugier@seagate.com>,
        "'Hyeoncheol Lee'" <hyc.lee@gmail.com>
In-Reply-To: <276da0be-a44b-841e-6984-ecf3dc5da6f0@sandeen.net>
Subject: RE: problem with exfat on 4k logical sector devices
Date:   Wed, 12 May 2021 08:53:10 +0900
Message-ID: <001201d746c0$cc8da8e0$65a8faa0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQEo2/DaJy0YUotfQpay9jtmd1bcWAIfpTVmAa7BVgkB2ON5bawOjtlg
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmge5zidkJBsvuSlm0LZ3PZnHt/nt2
        i4nTljJb7Nl7ksVi5kE3i9YrWg5sHjtn3WX32LSqk83j/b6rbB5bFj9k8mg//I3F4/MmuQC2
        qBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAjlBTK
        EnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJ
        ORkTfsoWbBKoeNDxk72BsZW3i5GTQ0LAROJlzwLmLkYuDiGBHYwS89f2s0E4nxglPp/bzQjh
        fGOUuPHlLCtMy+Yp+9khEnsZJb42d0D1v2CU2PzoABNIFZuArsS/P/vZQGwRgVCJxk9rwUYx
        C6xhlJhx/iMzSIJTwF5i/oIfQEUcHMICNhItZ6pAwiwCqhL/Hn9jB7F5BSwlFqxvZYKwBSVO
        znzCAmIzC8hLbH87hxniIgWJn0+XsULERSRmd7YxQ+x1k3j+ZjUryF4JgZkcEjd/rYBqcJG4
        9XYiC4QtLPHq+BZ2CFtK4mV/G5RdLnHi5C8mCLtGYsO8fewgd0oIGEv0vCgBMZkFNCXW79KH
        qFCU2Pl7LiPECXwS7772sEJU80p0tAlBlKhK9F06DDVQWqKr/QP7BEalWUgem4XksVlInpmF
        sGwBI8sqRrHUguLc9NRiwwJD5LjexAhOn1qmOxgnvv2gd4iRiYPxEKMEB7OSCO/c+lkJQrwp
        iZVVqUX58UWlOanFhxhNgUE9kVlKNDkfmMDzSuINTY2MjY0tTMzMzUyNlcR5052rE4QE0hNL
        UrNTUwtSi2D6mDg4pRqYru8XtntgKnGGNUJY5NUGh4R/PGksAn6rv3etlZ/MeHFOcc6el4u8
        7j0+ki/WIdjm2t73p0GpMnxi2v4Dd9TfTgmtn/or726ylZt8Z4mg0ANvhV8uuxYUqHOWHtbU
        WPza9cfb/5X19e/t1h3tLfNazlpolrYx0z7ENMzs0LW/Cgqqs5lDZiWGLd6iuebu5dxVTZaV
        JZs2+25kebSu+Gcte6o6/6fnSZe+1F+53P1OcHLmxApnp1eL/3+bxibxLrU+OvihQaJ0UZN8
        6rUl5b98Dq/m17u6XYEx9kUq27YqxadOjfs+6Tdm5ypdaPO5+KmCdWJ04LeHRYuTt1VKPlDu
        5+Wwd9F78VV06YKF4VlKLMUZiYZazEXFiQA4SMMJKAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJTve5xOwEg46/LBZtS+ezWVy7/57d
        YuK0pcwWe/aeZLGYedDNovWKlgObx85Zd9k9Nq3qZPN4v+8qm8eWxQ+ZPNoPf2Px+LxJLoAt
        issmJTUnsyy1SN8ugStjwk/Zgk0CFQ86frI3MLbydjFyckgImEhsnrKfvYuRi0NIYDejxIv3
        yxghEtISx06cYe5i5ACyhSUOHy6GqHnGKLHqZyMrSA2bgK7Evz/72UBsEYFQiWltv9lAipgF
        1jFKPDq4jQ2io4NJ4uueL8wgVZwC9hLzF/xgA5kqLGAj0XKmCiTMIqAq8e/xN3YQm1fAUmLB
        +lYmCFtQ4uTMJywgNrOAtkTvw1ZGCFteYvvbOcwQhypI/Hy6jBUiLiIxu7ONGeIgN4nnb1az
        TmAUnoVk1Cwko2YhGTULSfsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBkaSl
        uYNx+6oPeocYmTgYDzFKcDArifDOrZ+VIMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB
        9MSS1OzU1ILUIpgsEwenVANT4JLPfY0GXgW75LkWNq9VveF0wWFW6HNZLd3Db1UdFtdmJdzp
        eWpXI7jIVtTHvYDDSeBle5r6lrL9dv86OjmvZsoHSOp/nPyl1z7YuubQKVErgb0h0sxSDze6
        hDk3PFnJcl1j3v+3f7wa7lTwr1rMOOXfI4bVWvpROz/pMi77Hh9ekaHN1Tf1svpG5ovdB/mv
        6HmU+rQsmPul/87+1j1NO1/dVNZ+cz3x7KGb7TZ/13VsMsh7Yye/UOs0R4Pd72j5M0f/sUfu
        bi1NVXrL3ip4LP5EVGx71C+d2weaT2y2/dHrEy1eEprlzqsrtFZB3jVt3oXXbjGNz76s+dQQ
        Jj71h/8h7y7Pa+u6jy7dqqbEUpyRaKjFXFScCAAk/z1KEwMAAA==
X-CMS-MailID: 20210511235311epcas1p16cf9bab6edeae2b9e82abd17da36e3b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2
References: <372ffd94-d1a2-04d6-ac38-a9b61484693d@sandeen.net>
        <CAKYAXd_5hBRZkCfj6YAgb1D2ONkpZMeN_KjAQ_7c+KxHouLHuw@mail.gmail.com>
        <CGME20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2@epcas1p3.samsung.com>
        <276da0be-a44b-841e-6984-ecf3dc5da6f0@sandeen.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 5/11/21 4:21 PM, Namjae Jeon wrote:
> >> Hi Namjae -
> > Hi Eric,
> >>
> >> It seems that exfat is unhappy on 4k logical sector size devices:
> > Thanks for your report!
> > We have got same report from Christophe Vu-Brugier. And he sent us the
> > patch(https://protect2.fireeye.com/v1/url?k=ac8f77ef-f3144ef5-ac8efca0
> > -000babff24ad-8b7be88b031de920&q=1&e=0e9634f8-7ff9-4eb8-b5af-2316b62e9
> > 236&u=https%3A%2F%2Fgithub.com%2Fexfatprogs%2Fexfatprogs%2Fpull%2F164)
> > to fix it yesterday.(Thanks Christophe!), I will check it today
> 
> Oh, good timing! ;)
> 
> gI'll try to look at that in more depth. It does seem to make everything work for me, and resolves a
> couple other misunderstandings I may have had, and they seem to match with the spec.
> 
> For example, I now see that boot sector signature does go at the end of 512 for the primary boot
> sector, and at the end of $SECTOR_SIZE for the extended boot sector.
Thanks for your check:)

> 
> One other thing that I ran across is that fsck seems to validate an image against the sector size of
> the device hosting the image rather than the sector size found in the boot sector, which seems like
> another issue that will come up:
> 
> # fsck/fsck.exfat /dev/sdb
> exfatprogs version : 1.1.1
> /dev/sdb: clean. directories 1, files 0
> 
> # dd if=/dev/sdb of=test.img
> 524288+0 records in
> 524288+0 records out
> 268435456 bytes (268 MB) copied, 1.27619 s, 210 MB/s
> 
> # fsck.exfat test.img
> exfatprogs version : 1.1.1
> checksum of boot region is not correct. 0, but expected 0x3ee721 boot region is corrupted. try to
> restore the region from backup. Fix (y/N)? n
> 
> Right now the utilities seem to assume that the device they're pointed at is always a block device,
> and image files are problematic.
Okay, Will fix it.
> 
> Also, as an aside, it might be useful to have a "set sector size" commandline option at least for
> testing, or to create 4k images that could be transferred to a 4k device.
Agreed, We will add that option:)

Thanks!
> 
> Thanks,
> -Eric

