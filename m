Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D1B59B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 04:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfIRCfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 22:35:13 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10517 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfIRCfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 22:35:13 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190918023511epoutp02db0e8ff679a5324e9d35523246313ead~FZ74X1K590370003700epoutp02Z
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 02:35:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190918023511epoutp02db0e8ff679a5324e9d35523246313ead~FZ74X1K590370003700epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568774111;
        bh=Z8B4t6x2SThW7y10AxlkdXvg/95O7AxZFmJlnEcGh/E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=V1xa2vhAHd2HeXrf8KlughqQfLSj4soigQcNIBfwqP/6T9MioVCPypQLRsq4FnUmr
         x1Mx9CmK4y8f5FW7JW9soR5LVfBcesSGkuFu2yzcs/S3H1/56Wh8vjMzTup/vddxLN
         hbIW5ijOEfHyXeWxa64T5lA4budaFHMO/7lxAaLs=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190918023510epcas1p2a0ad8f9794f47da39fdaf11820901605~FZ73tUebs1969819698epcas1p2s;
        Wed, 18 Sep 2019 02:35:10 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46Y3ws3mHjzMqYkf; Wed, 18 Sep
        2019 02:35:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.27.04088.DD7918D5; Wed, 18 Sep 2019 11:35:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190918023508epcas1p1940b2b59fce55f7c1332b7d2aefd2bd4~FZ72DcvP52200622006epcas1p1j;
        Wed, 18 Sep 2019 02:35:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190918023508epsmtrp289a18dc9cc88b153781a6a2d0f3be25b~FZ72CnLmL0361903619epsmtrp2b;
        Wed, 18 Sep 2019 02:35:08 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-42-5d8197dd36d8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.C4.03706.CD7918D5; Wed, 18 Sep 2019 11:35:08 +0900 (KST)
Received: from DONAMJAEJEO06 (unknown [10.88.104.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190918023508epsmtip103e760208fab5fe6118943268f992655~FZ71387dc3265732657epsmtip1k;
        Wed, 18 Sep 2019 02:35:08 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Ju Hyung Park'" <qkrwngud825@gmail.com>,
        "'Greg KH'" <gregkh@linuxfoundation.org>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>
Cc:     <devel@driverdev.osuosl.org>, <linkinjeon@gmail.com>,
        <linux-kernel@vger.kernel.org>, <alexander.levin@microsoft.com>,
        <sergey.senozhatsky@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
Subject: RE: [PATCH] staging: exfat: add exfat filesystem code to
Date:   Wed, 18 Sep 2019 11:35:08 +0900
Message-ID: <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGT5RAmYrUvbIdPV5wSdu6UWeOkRAHEPqcjASg+jxcBWaTXGQHGgTvdp4Nh1VA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01TWUwTURTNY9qZQqx5VMRLTbSO4UMj2KEWBwPELWaIxGD8MSqpE5i0hG52
        WiMYYxULAu5LxApG8MMlGggSrChLwCUQVAJG1Agad1FxAXdFp50a+Tv33nPuPfctKkLTSmpV
        eXa34LLzVpqMUjR2zEpMGDiyLVt/ujGWbTnynGCvdP+g2KKTtSTbP/BACps7FWxfUyXJXnta
        TbLnR55SbMPYVSXb+/6DYmEUN9jSoeAu+QcorrXqHMX5Ar8pbk/DWcSN1E/j2i++JbOoNdZU
        i8DnCi6dYM9x5ObZzWn08lWmJSZjsp5JYFLY+bTOztuENHppZlbCsjyr5I/WbeStHimVxYsi
        PTc91eXwuAWdxSG602jBmWt1MnpnosjbRI/dnJjjsC1g9Poko8Rcb7Uc9Q4SztIZm3ZUPCK8
        qCauDEWqAM+D7y87I8pQlEqDAwj+eL3h4BOC4Y8V4eALguPl9Yp/Ep+vm5ALzQgOj/YogwUN
        HkLQ25QRxCROgLFfrWSQFINLEVwuv6wMBgR+gODr6DAKsiLxSmipbAqpJ+FF8K2vLSKIFTge
        GlveUUGsxinQ96REKeNo6Dz6LGSDwNPh4rtKQrakg8DNN6GeMXgF/PAdJGVODBwrLQ5ZBbyX
        gsf+IkoWLIXdgwfD4kkwdKMhnNfCyHCzJFZJeDN8bA1TdiJ49TVNxga4X1unDFIIPAtqm+bK
        6Rlw6WcVksdOhOHPu5RyFzXsLNbIlHjY09sRIeOpUFbygdqHaP+4xfzjFvOPW8D/f9gJpDiL
        YgWnaDMLIuNkxt92PQo93tnGADp0K7MdYRWiJ6jhpjdbo+Q3igW2dgQqgo5RZ23Zmq1R5/IF
        hYLLYXJ5rILYjozSue8ntJNzHNJXsLtNjDHJYDCw85LnJxsN9BQ1Z5b6YDPvFvIFwSm4/uki
        VJFaL1pQXHKhKuXcAX9PYeWK8rGJkTWmfh+Xaquv+xYdZyF9p3YXBl4M7f9SvWn1J+0Ep2P5
        4q7E6qk1a69Pi5vye3AkI920t2JHz7qcz0xbXeztwLU7PeaMzDNzGpO2d42emf42n79379X5
        As+VaEdg5kM+fZ3tLj49Z8PJ1wP9Re/Tb3e30QrRwjOzCZfI/wVKHiGF0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSnO6d6Y2xBicaDCz2TX/KbLHnzC92
        i+bF69ksrt+9BeTuPclicXnXHDaLo48Xslms/fyY3WLLvyOsFpfef2Bx4PK4t+8wi8fOWXfZ
        PfbPXcPu0brjL7tH35ZVjB6fN8l5HNr+hi2APYrLJiU1J7MstUjfLoErY2bDPeaCTsWKlhn3
        mRsYF0l2MXJySAiYSLS2nmHuYuTiEBLYzSixdvleFoiEtMSxEyAJDiBbWOLw4WKImheMElfa
        PzGB1LAJ6Er8+7OfDSQhItANlJj7mAXEYRZ4wCjxds8UdoiWaUwSH1u2g7VwCgRK7JuzixXE
        FhZwlPhx+QBYnEVAVWLbvrfsIDavgKXE5UftrBC2oMTJmU/ATmIW0JbofdjKCGHLS2x/O4cZ
        4lQFiR1nX4PFRQT8JH61TmaDqBGRmN3ZxjyBUXgWklGzkIyahWTULCQtCxhZVjFKphYU56bn
        FhsWGOallusVJ+YWl+al6yXn525iBEehluYOxstL4g8xCnAwKvHwHjjVECvEmlhWXJl7iFGC
        g1lJhDegtj5WiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6p
        BsZIUW22xo1y6XavUyapa7xQzdzRxzsrv4351JS4zc7liyv4d573bNQoOZRuu+DpJbdVL6Wq
        inRfl1aWh1lM05ij+ZXPjeHjm+89rf4cCYcmHGn6+KstoLJ0y005/tB5Zx9q/FRor266l9/7
        KmL3zKjHffkrb8zKV4nVdAjqu6Pyuu7m4xz5YCWW4oxEQy3mouJEADULHNW+AgAA
X-CMS-MailID: 20190918023508epcas1p1940b2b59fce55f7c1332b7d2aefd2bd4
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've summarized some of the big differences between sdfat and exfat
in linux-next.

1. sdfat has been refactored to improve compatibility, readability and
to be linux friendly.(included support mass storages larger than 2TB.)

2. sdfat has been optimized for the performance of SD-cards.
  - Support SD-card friendly block allocation and delayed allocation
    for vfat-fs only.
  - Support aligned_mpage_write for both vfat-fs and exfat-fs

3. sdfat has been optimized for the performance of general operations
    like create,lookup and readdir.

4. Fix many critical and minor bugs
 - Handle many kinds of error conditions gracefully to prevent panic.
 - Fix critical bugs related to rmdir, truncate behavior and so on...

5. Fix NLS functions

Note, that Samsung is still improving sdfat driver. For instance,
what will be realeased soon is sdfat v2.3.0, which will include support
for "UtcOffset" of "File Directory Entry", in order to satisfy
exFAT specification 7.4.

Thanks!

> -----Original Message-----
> From: Ju Hyung Park [mailto:qkrwngud825@gmail.com]
> Sent: Tuesday, September 17, 2019 3:04 PM
> To: Greg KH; namjae.jeon@samsung.com; Valdis Kletnieks
> Cc: devel@driverdev.osuosl.org; linkinjeon@gmail.com; linux-
> kernel@vger.kernel.org; alexander.levin@microsoft.com;
> sergey.senozhatsky@gmail.com; linux-fsdevel@vger.kernel.org
> Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
> 
> On Tue, Sep 17, 2019 at 2:47 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > It's the fact that it actually was in a form that could be merged, no
> > one has done that with the sdfat code :)
> 
> Well, I'm more than happy to help if you guys are happy with merging
> the new base.
> 
> > What fixes?  That's what I'm asking here.
> 
> I gave this as an example in my previous email:
> https://github.com/MotorolaMobilityLLC/kernel-msm/commit/7ab1657
> 
> > How do we "know" that this is better than what we currently have today?
> > We don't, so it's a bit hard to tell someone, "delete the work you did
> > and replace it with this other random chunk of code, causing you a bunch
> > more work in the process for no specific reason other than it looks
> > 'newer'." :(
> 
> The new sdFAT base I'm suggesting, is just as "random" as the one
> staging tree is based on.
> 
> If exFAT gets merged to Torvald's tree, there will be a lot more eyes
> interested in it.
> If there's a better base, we better switch to it now and prevent
> further headaches long-term.
> 
> It's really hard to compare those 2 drivers base and extract
> meaningful changelogs.
> 
> But regardless, here are some diff stats:
> <Full diff stat>
>  Kconfig      |   79 +-
>  Makefile     |   46 +-
>  api.c        |  423 ----
>  api.h        |  310 ---
>  blkdev.c     |  409 +---
>  cache.c      | 1142 ++++-----
>  config.h     |   49 -
>  core.c       | 5583 ++++++++++++++++++++++++--------------------
>  core.h       |  196 --
>  core_exfat.c | 1553 ------------
>  exfat.h      | 1309 +++++++----
>  exfat_fs.h   |  417 ----
>  extent.c     |  351 ---
>  fatent.c     |  182 --
>  misc.c       |  401 ----
>  nls.c        |  490 ++--
>  super.c      | 5103 +++++++++++++++++++++-------------------
>  upcase.c     |  740 ++++++
>  upcase.h     |  407 ----
>  version.h    |   29 -
>  xattr.c      |  136 --
>  21 files changed, 8186 insertions(+), 11169 deletions(-)
> 
> <diff-filter=M>
>  Kconfig  |   79 +-
>  Makefile |   46 +-
>  blkdev.c |  409 +---
>  cache.c  | 1142 +++++-----
>  core.c   | 5583 ++++++++++++++++++++++++++----------------------
>  exfat.h  | 1309 ++++++++----
>  nls.c    |  490 ++---
>  super.c  | 5103 ++++++++++++++++++++++---------------------
>  8 files changed, 7446 insertions(+), 6715 deletions(-)
> 
> > I recommend looking at what we have in the tree now, and seeing what is
> > missing compared to "sdfat".  I know a lot of places in the exfat code
> > that needs to be fixed up, odds are they are the same stuff that needs
> > to be resolved in sdfat as well.
> 
> Would there be any more data that I can provide?
> It's really hard to go through the full diff :(
> 
> Thanks.

