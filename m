Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7732A521
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443409AbhCBLrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:36 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:39565 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441849AbhCBG7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:59:06 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210302065823epoutp02f3977d1fdb1cf1e78d6a78333037f145~odERmFz8e2152321523epoutp02B
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 06:58:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210302065823epoutp02f3977d1fdb1cf1e78d6a78333037f145~odERmFz8e2152321523epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614668303;
        bh=ro5ltOW//usS2b3pAkuEm/Xj2HGAyfHiEMleWfYf0tI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=vO3hh6vauhSvD+PmlK9q6mP15wQ4v+FRuNFP2x4ynU+5X+n5M46p70134oC7fCJCm
         PEheJtZREq6CAuO0Q51M4P83WVvPvTbE6V96J2bPqZXL86DM4YrqV4eeyn9nJZaohq
         9CxPmbXKl6R8wl6X8QnAxac6v/IsESXpIV+47jwI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210302065823epcas1p2c1394e538bab0ae4ae5517a0f37103c6~odERTF_X80548305483epcas1p21;
        Tue,  2 Mar 2021 06:58:23 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DqSdV3mGPz4x9QK; Tue,  2 Mar
        2021 06:58:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.55.10463.D02ED306; Tue,  2 Mar 2021 15:58:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210302065821epcas1p13e2a6d136316daa635e407f9216db505~odEPoOcnl0465604656epcas1p1B;
        Tue,  2 Mar 2021 06:58:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210302065821epsmtrp16c6a59a649be4bdabc4e1f71fb12f95d~odEPmVOnb2336823368epsmtrp1d;
        Tue,  2 Mar 2021 06:58:21 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-e4-603de20dc499
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.FE.08745.D02ED306; Tue,  2 Mar 2021 15:58:21 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210302065821epsmtip2b73dea60d54f4aceb132b34985e133a4~odEPavb9n1094410944epsmtip2Z;
        Tue,  2 Mar 2021 06:58:21 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        "'Chaitanya Kulkarni'" <chaitanya.kulkarni@wdc.com>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20210302050521.6059-3-hyeongseok@gmail.com>
Subject: RE: [PATCH v4 2/2] exfat: add support ioctl and FITRIM function
Date:   Tue, 2 Mar 2021 15:58:20 +0900
Message-ID: <04aa01d70f31$6de160a0$49a421e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGcWnf6BTkYMyzP2LJXG6KPoRfNLgF8rXkvAXOJ+PyqzitREA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTX5f3kW2CwdVFhhazbr9msfg78ROT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gd2Dx2zrrL7tG3ZRWjx+dNch7tB7qZAliicmwyUhNTUosU
        UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
        9O1sivJLS1IVMvKLS2yVUgtScgoMDQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMrae/M9acJyt
        ouXjSaYGxpWsXYycHBICJhLr799j6mLk4hAS2MEo8WTdS1YI5xOQ09oPViUk8JlRYvnaPJiO
        Vz/fQxXtYpToPbmVHcJ5yShx8cVHFpAqNgFdiSc3fjKD2CICHhKPm46B7WAWmMYo8evcc7Cx
        nAKWErd2HAazhYGKtq49ygRiswioSDzauhZsEC9QzaYDDxghbEGJkzOfgMWZBeQltr+dwwxx
        koLE7k9HWSGWOUlcvnKSEaJGRGJ2ZxszyGIJgU4OicnLH7FANLhI/Ls7GapZWOLV8S3sELaU
        xMv+Nii7XuL//LXsEM0tjBIPP20Duo4DyLGXeH/JAsRkFtCUWL9LH6JcUWLn77lQe/kk3n3t
        YYWo5pXoaBOCKFGR+P5hJwvMpis/rjJNYFSaheSzWUg+m4Xkg1kIyxYwsqxiFEstKM5NTy02
        LDBBju1NjOCEqWWxg3Hu2w96hxiZOBgPMUpwMCuJ8J78bJkgxJuSWFmVWpQfX1Sak1p8iNEU
        GNYTmaVEk/OBKTuvJN7Q1MjY2NjCxMzczNRYSZw3yeBBvJBAemJJanZqakFqEUwfEwenVAPT
        9O+2mQbGF2LPZcgYJu07y9tc+lBn9fG+JS++im7h7lz8ye3agT023b/Ox0lU/DSZFPjg2uzG
        aw6a3xqVGFZdPDiFk7GwPyJS42T85Jt2CVyTl0d+b43dWiD5xzU/TOqLbuenXbtUw79F+p4V
        Wvbe/+DUx4yz/2Xfseddfvb8zNUiLx9Y3jmvdnHT5Z9unxx7H3pOPl/yMYpb3evGh8ifvO0L
        DsQuDpOUfXn+5T3Fw3LrpdSURLeW3Tr/cYO86IolHWff6xhWcT65vbtXxedTj7R6jEZNvUyX
        55IDAWr/bz1/tzZh4w8WxxAhW+7qozKtmf1R677JCmvrzxS/+Xx5WH3FvLpGzqaJmfX7bbre
        K7EUZyQaajEXFScCABqf4IEhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvC7vI9sEg43XhCxm3X7NYvF34icm
        iz17T7JYXN41h83ix/R6iy3/jrA6sHnsnHWX3aNvyypGj8+b5DzaD3QzBbBEcdmkpOZklqUW
        6dslcGVsPfmfteA4W0XLx5NMDYwrWbsYOTkkBEwkXv18D2RzcQgJ7GCUON5ygL2LkQMoISVx
        cJ8mhCkscfhwMUTJc0aJczc6GEF62QR0JZ7c+MkMYosIeEnsb3rNDlLELDCDUWLTgllQQ7cz
        Svxsm8cGUsUpYClxa8dhsM3CAh4SW9ceZQKxWQRUJB5tXcsCYvMC1Ww68IARwhaUODnzCQvI
        FcwCehJtG8HCzALyEtvfzmGGeEBBYveno6wQRzhJXL5yEqpGRGJ2ZxvzBEbhWUgmzUKYNAvJ
        pFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOGi2tHYx7Vn3QO8TIxMF4
        iFGCg1lJhPfkZ8sEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
        ODilGpiYvkuGOzVEmfznmTbng3vtgTM9eg8vNp5YxTJl74M1GxhsPk1T07nqMGvrPdMi6aQ0
        HaNLO15vyb9i9euC4ITNIvsO3fsjfj1RgreQ88nKqb27VH1NDp84cOvl/5W7Nkx31TzaoX9Q
        k/uT4/dbXi1p4vvXVPjXP852Ot+e4LL70y4+95kcbM/fPufZfbHG/eX8I/+uu7jsXdXSPN32
        RU/NolP9Ckwmsa80AzW3CDfUbTk4Z3lYX9nCjSJaiZK1Pru5pv5+cnW2Uil3K1//q0ilFzuP
        yM0TPtv7a/k+R4OdDd+WfVebLaq3n/Xuepk4F4n+0G2Ht337+E/BNPzpyT1WM0zzHix/vU/m
        sZbRh6aTGUosxRmJhlrMRcWJAJkda+gJAwAA
X-CMS-MailID: 20210302065821epcas1p13e2a6d136316daa635e407f9216db505
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210302050556epcas1p2f830c64b70cbc1bbd6f48292d3556802
References: <20210302050521.6059-1-hyeongseok@gmail.com>
        <CGME20210302050556epcas1p2f830c64b70cbc1bbd6f48292d3556802@epcas1p2.samsung.com>
        <20210302050521.6059-3-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Add FITRIM ioctl to enable discarding unused blocks while mounted.
> As current exFAT doesn't have generic ioctl handler, add empty ioctl
> function first, and add FITRIM handler.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> ---
>  fs/exfat/balloc.c   | 80 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/exfat/dir.c      |  5 +++
>  fs/exfat/exfat_fs.h |  4 +++
>  fs/exfat/file.c     | 53 ++++++++++++++++++++++++++++++
>  4 files changed, 142 insertions(+)
> 

It looks better than v3.
Thanks for your work!

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

BTW, there is still a problem that the alloc/free cluster operation waits
until the trimfs operation is finished.
Any ideas for improvement in the future are welcome. :)

