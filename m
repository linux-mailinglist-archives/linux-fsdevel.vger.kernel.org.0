Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099532EEA44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 01:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbhAHATy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 19:19:54 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51446 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAHATx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:19:53 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210108001910epoutp01b1efb17ed9efe216aaa66f552d4eca6e~YGbkz-sem2981029810epoutp01a
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 00:19:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210108001910epoutp01b1efb17ed9efe216aaa66f552d4eca6e~YGbkz-sem2981029810epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610065150;
        bh=4IAh21c7ctKZM+3rO63f8TGFaI+JvS/NfziN71CbbZ0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JBfHWbtn3EzptoVqk7/vndlmU2KZ+z2YIHjl0tcNbydiVK9WfubhkditJgNEXrZp/
         SHWuXs5X0Ap3uOqWMoWoETwyWZj1+uZ3U7qsuSP0GwpDodT4v1CaRYpN5HXCOtahH/
         t0i3j4ha+vWV9baAroNbuEsMp/q01ncfN9WDz0f8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210108001908epcas1p27b3f8fc72c758ad50b3332bdc41b20a0~YGbj2bS7q2613626136epcas1p2b;
        Fri,  8 Jan 2021 00:19:08 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DBkHH6qNzz4x9Pt; Fri,  8 Jan
        2021 00:19:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.94.10463.BF4A7FF5; Fri,  8 Jan 2021 09:19:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210108001907epcas1p14efadb9a6997cf3db9ea070fe2d86a0e~YGbiVt2H52543325433epcas1p1Z;
        Fri,  8 Jan 2021 00:19:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210108001907epsmtrp100e377301c2edd8b3c9dd70a6343ebe6~YGbiU6Mdh2226622266epsmtrp1W;
        Fri,  8 Jan 2021 00:19:07 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-f0-5ff7a4fb494b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.20.08745.BF4A7FF5; Fri,  8 Jan 2021 09:19:07 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210108001907epsmtip1889c7a78fe3920f4cab7c8e80e75e901~YGbiJK_NI0320603206epsmtip1_;
        Fri,  8 Jan 2021 00:19:07 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Hyeongseok Kim'" <hyeongseok@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <244001d6e4bd$a18072f0$e48158d0$@samsung.com>
Subject: RE: [PATCH] exfat: improve performance of exfat_free_cluster when
 using dirsync mount option
Date:   Fri, 8 Jan 2021 09:19:07 +0900
Message-ID: <031e01d6e553$e0ef3e30$a2cdba90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE9l3LMTUKYLRjlfrko2bpokujgCAI4/HcfAgq90CSrLVrJsA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmvu7vJd/jDeb+MrX4O/ETk8WevSdZ
        LC7vmsNmseXfEVYHFo+ds+6ye/RtWcXo8XmTXABzVI5NRmpiSmqRQmpecn5KZl66rZJ3cLxz
        vKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtA2JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmt
        UmpBSk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsbTjq3MBUd5K25cfMjSwDiRs4uRk0NC
        wERi+vQnTF2MXBxCAjsYJS5cmsUC4XxilHi15QhU5jOjxI3561hgWk63LmGHSOxilOhe2wjV
        8pJRYuG8WcwgVWwCuhL//uxnA7FFBKIk9i57xwRiMws4Sxy+cQqshlPASuLx8z4wW1ggXaLx
        4nqwehYBFYnFd3aygti8ApYSG/4tYYSwBSVOznzCAjFHXmL72znMEBcpSPx8uowVYpeTxIMH
        E6F2iUjM7mxjBjlOQuAru8TbZVNYIRpcJP7tngTVLCzx6vgWdghbSuJlfxuQzQFkV0t83A9V
        0sEo8eK7LYRtLHFz/QZWkBJmAU2J9bv0IcKKEjt/z2WEWMsn8e5rDyvEFF6JjjYhiBJVib5L
        h5kgbGmJrvYP7BMYlWYheWwWksdmIXlgFsKyBYwsqxjFUguKc9NTiw0LTJAjexMjOCVqWexg
        nPv2g94hRiYOxkOMEhzMSiK8Fse+xAvxpiRWVqUW5ccXleakFh9iNAUG9URmKdHkfGBSziuJ
        NzQ1MjY2tjAxMzczNVYS500yeBAvJJCeWJKanZpakFoE08fEwSnVwCS253TV1O47WQmnUs21
        GiZomzZlz/VWaGC5ulE4Yu7/oGNzeZQTlATn3n/dl9/zhXlKvfTr6sqilTuKbx5NPC0k43RG
        tXez5vIvzRuEtxVVLVUMm7K+XzVszQH5Jb0a82d/W3zc6P+Wgh3Wu/aK/2fe1Mch1sC3xHvJ
        9XtBp4rivpzp6d0t5z1ByjFiPU/B66vFvvZ7C54tm7Lius4pvvtW+18Hai7LVfYT+6x77FfS
        eZ2KjjsavjmRdp5z457tNTA69t/KYZ/+zy0pqhMigkS2+X1kV/lhylj1a83iG1+2Hrybvsrx
        mIjmlECLr3OVZhycknM7ab/gTJ9VcTbCG60WLA5azdlzJX561v9jRoxKLMUZiYZazEXFiQDe
        Qvk7EgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnO7vJd/jDdrm8lr8nfiJyWLP3pMs
        Fpd3zWGz2PLvCKsDi8fOWXfZPfq2rGL0+LxJLoA5issmJTUnsyy1SN8ugSvjacdW5oKjvBU3
        Lj5kaWCcyNnFyMkhIWAicbp1CXsXIxeHkMAORolnHeeZIBLSEsdOnGHuYuQAsoUlDh8uhqh5
        zijRcqcfrIZNQFfi35/9bCC2iECUxLnjZ8BsZgFXifnPV4PZQgI7GSXeNfqA2JwCVhKPn/cx
        g9jCAqkSe5/OAathEVCRWHxnJyuIzStgKbHh3xJGCFtQ4uTMJywQM7Uleh+2MkLY8hLb385h
        hrhTQeLn02WsEDc4STx4MJEJokZEYnZnG/MERuFZSEbNQjJqFpJRs5C0LGBkWcUomVpQnJue
        W2xYYJSXWq5XnJhbXJqXrpecn7uJERwbWlo7GPes+qB3iJGJg/EQowQHs5IIr8WxL/FCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MFW73gx6wWWiuHnR
        8zlH8kNmTN88OVNb32HVotbp8T4To+6tuS90tuLBOx2Br8VzDiuGT/bZfPmC6SyrhTNz/yss
        45eYe+3w8pWBLqGHcpdWmahHz/r44qeHuPtynb0fm9j0paeH1X+MktrQWMexmnddtcKEiRMm
        l3/jCFt1XdB0267rHxu0BIuOaaS+V5MyepgcYnqhuSwj6mzKZf6ZrL4i30wj2pRNN/V2+0ys
        eLs1jeGm74n/f17YnbJJaym/8nDyKUvrNQxmfXe0f5ttMC1WuhQuqzEp9/afZTc5tmcen3Io
        4l1juNyC/p9Ga+WZPfnUbk7RV3yd8T/tyVWdIzd0FKcHyu12OCb0c92ml+5KLMUZiYZazEXF
        iQCo3pak/AIAAA==
X-CMS-MailID: 20210108001907epcas1p14efadb9a6997cf3db9ea070fe2d86a0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210106044038epcas1p2d3488531b0a63c122f7401d4d56b03a8
References: <CGME20210106044038epcas1p2d3488531b0a63c122f7401d4d56b03a8@epcas1p2.samsung.com>
        <20210106043945.36546-1-hyeongseok@gmail.com>
        <244001d6e4bd$a18072f0$e48158d0$@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > There are stressful update of cluster allocation bitmap when using
> > dirsync mount option which is doing sync buffer on every cluster bit clearing.
> > This could result in performance degradation when deleting big size file.
> > Fix to update only when the bitmap buffer index is changed would make
> > less disk access, improving performance especially for truncate operation.
> >
> > Testing with Samsung 256GB sdcard, mounted with dirsync option (mount
> > -t exfat /dev/block/mmcblk0p1 /temp/mount -o dirsync)
> >
> > Remove 4GB file, blktrace result.
> > [Before] : 39 secs.
> > Total (blktrace):
> >  Reads Queued:      0,        0KiB	 Writes Queued:      32775,
> 16387KiB
> >  Read Dispatches:   0,        0KiB	 Write Dispatches:   32775,
> 16387KiB
> >  Reads Requeued:    0		         Writes Requeued:        0
> >  Reads Completed:   0,        0KiB	 Writes Completed:   32775,
> 16387KiB
> >  Read Merges:       0,        0KiB	 Write Merges:           0,
> 0KiB
> >  IO unplugs:        2        	     Timer unplugs:          0
> >
> > [After] : 1 sec.
> > Total (blktrace):
> >  Reads Queued:      0,        0KiB	 Writes Queued:         13,
> 6KiB
> >  Read Dispatches:   0,        0KiB	 Write Dispatches:      13,
> 6KiB
> >  Reads Requeued:    0		         Writes Requeued:        0
> >  Reads Completed:   0,        0KiB	 Writes Completed:      13,
> 6KiB
> >  Read Merges:       0,        0KiB	 Write Merges:           0,
> 0KiB
> >  IO unplugs:        1        	     Timer unplugs:          0
> >
> > Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> 
> Looks good.
> Thanks for your work!
> 
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied. Thanks!


