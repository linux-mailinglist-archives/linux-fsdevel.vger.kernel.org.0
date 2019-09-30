Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709A9C1AB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 06:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfI3EZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 00:25:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48246 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfI3EZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 00:25:20 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190930042516epoutp01522adf2f8a67aaa3427ba40fdad9c19d~JHLbYvhgk2623626236epoutp01c
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2019 04:25:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190930042516epoutp01522adf2f8a67aaa3427ba40fdad9c19d~JHLbYvhgk2623626236epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569817516;
        bh=nVneqrk5OtQyfdwPW2jy83LD/8hRdMLPttKZv89DwO4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=P14Ylkfquq13esnEC0kOvoCh1oBNVKfnY6gQ5YAZ3c1JjTb4m1JxLJSr5Nly3ZkQ4
         aNAEvpkdHXp9Zd1AcY1rESZnHdznv9bODLZWSgUPBaJswg1fk0t3GyF0RQdow/UaFT
         15J24DMn9+BWswsQktVuOqyhe/PZgo8eD9mT/xbQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190930042516epcas1p18b18c31dfdfb2227362ca637555ac350~JHLa2H1uo3267932679epcas1p14;
        Mon, 30 Sep 2019 04:25:16 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 46hTpL49QtzMqYkl; Mon, 30 Sep
        2019 04:25:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.B3.04224.AA3819D5; Mon, 30 Sep 2019 13:25:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190930042514epcas1p2c78cc8af0a5010cd8ec4cd163d43f778~JHLZFJc0l1630216302epcas1p2U;
        Mon, 30 Sep 2019 04:25:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190930042514epsmtrp289a4f3a26c19b527615b04d65a847d41~JHLZEaRk40526005260epsmtrp2H;
        Mon, 30 Sep 2019 04:25:14 +0000 (GMT)
X-AuditID: b6c32a38-d43ff70000001080-31-5d9183aa41ed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.02.03889.AA3819D5; Mon, 30 Sep 2019 13:25:14 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190930042514epsmtip124614efe1392bd87f24f39ed4f2e609c~JHLY1lwkx3163431634epsmtip1T;
        Mon, 30 Sep 2019 04:25:14 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Dan Carpenter'" <dan.carpenter@oracle.com>,
        "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <devel@driverdev.osuosl.org>, <linkinjeon@gmail.com>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky.work@gmail.com>,
        <linux-kernel@vger.kernel.org>, <alexander.levin@microsoft.com>,
        <sergey.senozhatsky@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>, "'Ju Hyung Park'" <qkrwngud825@gmail.com>
In-Reply-To: 
Subject: RE: [PATCH] staging: exfat: add exfat filesystem code to
Date:   Mon, 30 Sep 2019 13:25:13 +0900
Message-ID: <042701d57747$0e200320$2a600960$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGT5RAmYrUvbIdPV5wSdu6UWeOkRAHEPqcjASg+jxcBWaTXGQHGgTvdAmfpepEChGr/QAIs0XV3AVAC8PIBuUjzQAFD/owypymulmCAEXiQ0A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmge6q5omxBkduKVjsm/6U2eL1v+ks
        FnvO/GK3aF68ns3i+t1bzBZ79p5ksbi8aw6bxdHHC9ksHk2YxGSx9vNjdost/46wWlx6/4HF
        gcfj3r7DLB47Z91l99g/dw27R+uOv+weH5/eYvHo27KK0ePzJjmPQ9vfsAVwROXYZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCdq6RQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0MDAyBapMyMl4vPkje8Fh
        roqG7k7WBsZFHF2MnBwSAiYSp5q+sXUxcnEICexglLi66QgThPOJUeLo1LksIFVCAt8YJf5d
        CILp2HtxKitE0V5Gid17zkC1v2KUWLZ/LStIFZuArsS/P/uBEhwcIgIxEl2P3UFqmAW+MklM
        WDyRHSTOKcArMeGfNUi5sICjxI/LB5hAbBYBVYkN5y6AjeEVsJT4OWs+lC0ocXLmE7CDmAXk
        Jba/ncMMcZCCxI6zrxlBbBGBOolNB88xQdSISMzubGMG2SshsIld4kzDTEaIBheJv1+7WCFs
        YYlXx7ewQ9hSEp/f7QW7WUKgWuLjfqj5HYwSL77bQtjGEjfXb2AFKWEW0JRYv0sfIqwosfP3
        XEaItXwS7772sEJM4ZXoaBOCKFGV6Lt0mAnClpboav/APoFRaRaSx2YheWwWkgdmISxbwMiy
        ilEstaA4Nz212LDABDmqNzGCE7KWxQ7GPed8DjEKcDAq8fA+YJ4YK8SaWFZcmXuIUYKDWUmE
        V5xhQqwQb0piZVVqUX58UWlOavEhRlNguE9klhJNzgdmi7ySeENTI2NjYwsTM3MzU2MlcV6P
        9IZYIYH0xJLU7NTUgtQimD4mDk6pBsYg2bnTclf8itkaF33oliRT2b/vkybV/9R5uv5Gz8dH
        /AKrlkVXp5WWPp1d9T/HTri17EHxifI65ns75qY5zpxdtXjBinM+0UquL/VFOrd6vzIu2GWl
        9S+s3MuVy/Kkv83Ho+y+JUGtK89o3/WZeCq1TfDZ/CMhqut2Ct4/xNDd2/ln4xmBXA8lluKM
        REMt5qLiRADxJUew3gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSnO6q5omxBuu/cljsm/6U2eL1v+ks
        FnvO/GK3aF68ns3i+t1bzBZ79p5ksbi8aw6bxdHHC9ksHk2YxGSx9vNjdost/46wWlx6/4HF
        gcfj3r7DLB47Z91l99g/dw27R+uOv+weH5/eYvHo27KK0ePzJjmPQ9vfsAVwRHHZpKTmZJal
        FunbJXBlPN78kb3gMFdFQ3cnawPjIo4uRk4OCQETib0Xp7J2MXJxCAnsZpS4dvETC0RCWuLY
        iTPMXYwcQLawxOHDxRA1Lxglnh3azgZSwyagK/Hvz342kBoRgRiJE5cEQGqYBf4ySUzsesQG
        0TCdRWLn51awIk4BXokJ/6xBeoUFHCV+XD7ABGKzCKhKbDh3gRXE5hWwlPg5az6ULShxcuYT
        FpBWZgE9ibaNjCBhZgF5ie1v5zBDnKkgsePsa7C4iECdxKaD55ggakQkZne2MU9gFJ6FZNIs
        hEmzkEyahaRjASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4MjU0trBeOJE/CFG
        AQ5GJR7eB8wTY4VYE8uKK3MPMUpwMCuJ8IozTIgV4k1JrKxKLcqPLyrNSS0+xCjNwaIkziuf
        fyxSSCA9sSQ1OzW1ILUIJsvEwSnVwOgq6miu8ymsejrP7topk/+LTNhRs3BHrGx3+mqNl2fO
        Xxd/yLhukn1o6DXb4JpLp9nVp+QW5XOs6Ii4aHp/irXenYtvu5ytH715EGMb4rv5n/zZl/fD
        M58lndyxUanud+aFVA3NeS0dd1xMrDu0TTNCNBm2dJwz+JwVdHnF61e58urFdleZNyuxFGck
        GmoxFxUnAgCETFiryAIAAA==
X-CMS-MailID: 20190930042514epcas1p2c78cc8af0a5010cd8ec4cd163d43f778
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a
References: <8998.1568693976@turing-police>
        <20190917053134.27926-1-qkrwngud825@gmail.com>
        <20190917054726.GA2058532@kroah.com>
        <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
        <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
        <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
        <20190918061605.GA1832786@kroah.com> <20190918063304.GA8354@jagdpanzerIV>
        <20190918082658.GA1861850@kroah.com>
        <CAD14+f24gujg3S41ARYn3CvfCq9_v+M2kot=RR3u7sNsBGte0Q@mail.gmail.com>
        <20190918092405.GC2959@kadam> 
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> [..]
> > Put it in drivers/staging/sdfat/.
> >
> > But really we want someone from Samsung to say that they will treat
> > the staging version as upstream.  It doesn't work when people apply
> > fixes to their version and a year later back port the fixes into
> > staging.  The staging tree is going to have tons and tons of white space
> > fixes so backports are a pain.  All development needs to be upstream
> > first where the staging driver is upstream.  Otherwise we should just
> > wait for Samsung to get it read to be merged in fs/ and not through the
> > staging tree.
> Quite frankly,
> This whole thing came as a huge-huge surprise to us, we did not initiate
> upstreaming of exfat/sdfat code and, as of this moment, I'm not exactly
> sure that we are prepared for any immediate radical changes to our internal
> development process which people all of a sudden want from us. I need to
> discuss with related people on internal thread.
> please wait a while:)
We decide to contribute sdfat directly and treat upstream exfat.
Perhaps more time is needed for patch preparation(exfat rename + vfat removal
+ clean-up) and internal processes. After contributing sdfat v2.2.0 as the base,
We will also provide change-set of sdfat v2.3.0 later.

Thanks!
> 
> Thanks!
> >
> > regards,
> > dan carpenter
> >


