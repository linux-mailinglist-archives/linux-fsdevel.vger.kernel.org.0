Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3662532CB13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 04:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhCDDom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 22:44:42 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:45334 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhCDDoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:44:19 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210304034338epoutp03e2f8653a209314027691797c64c356ff~pBszVi9Qa0689806898epoutp03K
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 03:43:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210304034338epoutp03e2f8653a209314027691797c64c356ff~pBszVi9Qa0689806898epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614829418;
        bh=xz/N1IYmDAPJsmtztTVuH+rwAP7Ga3ZX6IrYa8UqZfI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=c6xsDoab+2E/OD4Jxa5NFWdP8eWaI3QFkf1O2R3NDBuAYtesZMbRDr1aPULu+K0ej
         ZtrCNUmA7CthfiAGO3CAwPyy+HDsL3+V3zq6V/DdwQ3OBePYAeq6eDaeiOzPNawtHC
         WW1SPSew4d8/V05Bpug+VmiOprobus++eOAFiBnE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210304034337epcas1p4a7ec01be07efbf298d5b883af9dbf803~pBszDRTBT0309603096epcas1p4n;
        Thu,  4 Mar 2021 03:43:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DrcCr6t9Pz4x9Pv; Thu,  4 Mar
        2021 03:43:36 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.ED.10463.86750406; Thu,  4 Mar 2021 12:43:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210304034336epcas1p3d36927ab291bc5814a43f75a3f5ef9eb~pBsx2yd2J1226012260epcas1p3C;
        Thu,  4 Mar 2021 03:43:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210304034336epsmtrp2f0cfc05d96b145b356c4858bc2a9fff3~pBsx2NNCB2741027410epsmtrp2y;
        Thu,  4 Mar 2021 03:43:36 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-d0-604057686c2d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.99.08745.86750406; Thu,  4 Mar 2021 12:43:36 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210304034336epsmtip24bce12b84e298e9bc97270a44af9999d~pBsxqU6qm2398223982epsmtip2K;
        Thu,  4 Mar 2021 03:43:36 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>, <sj1557.seo@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20210302050521.6059-1-hyeongseok@gmail.com>
Subject: RE: [PATCH v4 0/2] Add FITRIM ioctl support for exFAT filesystem
Date:   Thu, 4 Mar 2021 12:43:36 +0900
Message-ID: <003001d710a8$8eb27850$ac1768f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJHsQEWbOBopBEJvn3/+Fchao77+gGcWnf6qYUL/RA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmrm5GuEOCwdYuC4u/Ez8xWezZe5LF
        4vKuOWwWW/4dYXVg8dg56y67R9+WVYwenzfJBTBH5dhkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZDxZ+IC9oJW74t2F3+wNjDc5uhg5OSQE
        TCSWTzzOCGILCexglHg9j7mLkQvI/sQo0fP8KiuE85lR4su7HcwwHS3/+qESuxgluq7cZ4Jw
        XjJKbH+6kh2kik1AV+Lfn/1sILaIgLvErnc9YDuYBZwlOi+eZgWxOQUsJZY9Pw5Uz8EhLOAp
        0bFeG8RkEVCROH3PH6SCF6hiac8ndghbUOLkzCcsEFPkJba/nQN1j4LEz6fLWCE2WUm0ztrJ
        BFEjIjG7sw3sGwmBj+wSj/bsYINocJF48O0JK4QtLPHq+BZ2CFtK4vO7vWwgN0gIVEt83A81
        v4NR4sV3WwjbWOLm+g2sICXMApoS63fpQ4QVJXb+ngv1IJ/Eu689rBBTeCU62oQgSlQl+i4d
        ZoKwpSW62j+wT2BUmoXksVlIHpuF5IFZCMsWMLKsYhRLLSjOTU8tNiwwQY7pTYzgZKhlsYNx
        7tsPeocYmTgYDzFKcDArifCKv7RNEOJNSaysSi3Kjy8qzUktPsRoCgzpicxSosn5wHScVxJv
        aGpkbGxsYWJmbmZqrCTOm2TwIF5IID2xJDU7NbUgtQimj4mDU6qBifH/+m3beWdf/PW7OZgj
        59Em1eWSHw8eK7rusj1q+uPCyZunet9ZJd+1pVmteU1HNXfrObt/7yOD+FbbTHOe9qk/h//Z
        kajXaX9SD89QKHzQ2W1otiprb2DxpgfGu94n/AyYwXOmxW1x62v5P6vfrt4zuegLN/P/3ONC
        19dvXsA776RIu0mtlmsBJ1dV9tnXP6ZqxbztEPvw56bGOe3Lyjvtnk3VqHYSSXih6jT9UU38
        oi07d0xn8jWu/md8S9ZPe/3u42fq4l+2eAWeVJauu+a1VHOX7bRnHhwb33myp8sWMSTv51x5
        Vlkv9tDM+8HFj6eGxSxQj6owyYlU5unQMrto8XPdTle2g/ob+Rk2zlJiKc5INNRiLipOBAAa
        3wXXDwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvG5GuEOCwftdchZ/J35istiz9ySL
        xeVdc9gstvw7wurA4rFz1l12j74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mp4svABe0Erd8W7
        C7/ZGxhvcnQxcnJICJhItPzrZ+1i5OIQEtjBKPGj5yU7REJa4tiJM8xdjBxAtrDE4cPFEDXP
        GSValy5mBqlhE9CV+PdnPxuILSLgKbHi4AomEJtZwFWi7cURqKFdjBIt/+8xgiQ4BSwllj0/
        zg4yVBiooWO9NojJIqAicfqeP0gFL1DF0p5P7BC2oMTJmU9YQEqYBfQk2jYyQkyXl9j+dg4z
        xJUKEj+fLmOFuMBKonXWTqgLRCRmd7YxT2AUnoVk0iyESbOQTJqFpGMBI8sqRsnUguLc9Nxi
        wwKjvNRyveLE3OLSvHS95PzcTYzgqNDS2sG4Z9UHvUOMTByMhxglOJiVRHjFX9omCPGmJFZW
        pRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBUonB9cmbr69ddE6+x
        M3NY9r6IPZww6fDn1Qd8f1+T+F311O/j3qi1M3nX8FXN6NR42PAn/u6uDb+kDV43SPWWMeY9
        sZkqnHbG7tGLp/l57dtulTFPOf3kWwUvx52ICcduCCya++7OhOOMK+czfd8hyz3L3nqDinSl
        47dJ06sfVoqtkH9x4OF0qZBXBh5XNh09EPzDwbqFu/5YrPdbS80MRQafLRNvFwdPNPw4hdFT
        O31uoW0Kiz+j8NzNmqVchjkiz1PX5CuouxoEac3VrDqTbMC2VadvY08TT2bDooOLnrv1Jgkc
        P9ohoRYmPvO0ndkjdZnn11esFH75y0NekH1vfVvZHGeWOwtumHGmVrIrsRRnJBpqMRcVJwIA
        +upXtvkCAAA=
X-CMS-MailID: 20210304034336epcas1p3d36927ab291bc5814a43f75a3f5ef9eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210302050548epcas1p2ccec84f5de16f0971fc0479abe64ec3e
References: <CGME20210302050548epcas1p2ccec84f5de16f0971fc0479abe64ec3e@epcas1p2.samsung.com>
        <20210302050521.6059-1-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This is for adding FITRIM ioctl functionality to exFAT filesystem.
> Firstly, because the fstrim is long operation, introduce bitmap_lock to narrow the lock range to
> prevent read operation stall.
> After that, add generic ioctl function and FITRIM handler.
> 
> Changelog
> =========
> v3->v4:
> - Introduce bitmap_lock mutex to narrow the lock range for bitmap access
>   and change to use bitmap_lock instead of s_lock in FITRIM handler to
>   prevent read stall while ongoing fstrim.
> - Minor code style fix
> 
> v2->v3:
> - Remove unnecessary local variable
> - Merge all changes to a single patch
> 
> v1->v2:
> - Change variable declaration order as reverse tree style.
> - Return -EOPNOTSUPP from sb_issue_discard() just as it is.
> - Remove cond_resched() in while loop.
> - Move ioctl related code into it's helper function.
> 
> Hyeongseok Kim (2):
>   exfat: introduce bitmap_lock for cluster bitmap access
>   exfat: add support ioctl and FITRIM function
Applied. Thanks for your patches!

> 
>  fs/exfat/balloc.c   | 80 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/exfat/dir.c      |  5 +++
>  fs/exfat/exfat_fs.h |  5 +++
>  fs/exfat/fatent.c   | 37 ++++++++++++++++-----
>  fs/exfat/file.c     | 53 ++++++++++++++++++++++++++++++
>  fs/exfat/super.c    |  1 +
>  6 files changed, 173 insertions(+), 8 deletions(-)
> 
> --
> 2.27.0.83.g0313f36


