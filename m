Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B2F1C8026
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 04:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgEGCu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 22:50:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53553 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgEGCuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 22:50:25 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200507025022epoutp0336b7aeb3077c3d9af4a2ad1938108f47~MnzXmcMfn0906009060epoutp03D
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 02:50:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200507025022epoutp0336b7aeb3077c3d9af4a2ad1938108f47~MnzXmcMfn0906009060epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588819822;
        bh=YyLMH25O/wiRsw+XqQLJyHrmX9TPc1OpQ9UO4aIwdRo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oMgYHgyJJvJeJ0a9aTO+UtjPtbkFqIwt+03ZFKYz0JVGuIs0eBMa8HX98NPzbpp9B
         WYfc1tgH2b8pJ989co9mtb2R0CvI4plcJdRdAFZIuIhOY0yvb29LQTrL1RJKxDXGyT
         uT9odrmahiggDF5lI7lG8mTAZMpQIGZ+d8EFmWMY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200507025021epcas1p345de9dc55ea6cd1b311f41843ee51837~MnzWyuxSd0315903159epcas1p3x;
        Thu,  7 May 2020 02:50:21 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49HdHJ0W16zMqYlv; Thu,  7 May
        2020 02:50:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.F0.04648.96773BE5; Thu,  7 May 2020 11:50:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200507025017epcas1p1daafe1a44960ebddfab157040fb968ac~MnzTIkm0X0426804268epcas1p1N;
        Thu,  7 May 2020 02:50:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200507025017epsmtrp149546de963a85481b515604867959cd5~MnzTH-UMU2195221952epsmtrp16;
        Thu,  7 May 2020 02:50:17 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff70000001228-40-5eb37769de04
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.90.18461.96773BE5; Thu,  7 May 2020 11:50:17 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200507025017epsmtip10c1dbf0db4521a5d7257de2ffdeefa63~MnzS8P3n52544125441epsmtip1_;
        Thu,  7 May 2020 02:50:17 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Wei Yongjun'" <weiyongjun1@huawei.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <20200506142554.123748-1-weiyongjun1@huawei.com>
Subject: RE: [PATCH -next] exfat: fix possible memory leak in exfat_find()
Date:   Thu, 7 May 2020 11:50:17 +0900
Message-ID: <004801d6241a$3d8da150$b8a8e3f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQH5CkYLOhJgAZJkKEDNo0PB2a9z1QJArZWfqEQXUWA=
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm85yzHcPVcWq9TMp1MEJrurmmU1wUmoj2Qwz80UU96UFHZxfO
        mZb1xyjmtaWQQTPLCqykmJnmBe8XxKDAyEKhCCxphZHdvCZtnkn+e96H533f5/m+l8TkFRIF
        aTTbWN7McLRkC/5sOEKlMp59mq1uGEjUt0+H6nt6x3F929oIoR/+1S05hKdeHpkjUh1tzSj1
        Z+uuDOw4l1jIMvksr2TNeZZ8o7nAQKcfy0nK0cWqNSpNvD6OVpoZE2ugk49mqFKMnGcZrSxm
        uCIPlcEIAh19MJG3FNlYZaFFsBlo1prPWTVqa5TAmIQic0FUnsWUoFGrY3QeZS5XONm+gFvH
        JOcuvpv2K0VOohL5k0AdgK6uJWkl2kLKqU4EV+pf4GLxA0GDfRGJxR8EpY73+EbLyq1RX0sv
        gp6RYZ/KjaDL5ZZ6VRJKBWur/RIvDqb2w8yvmvVujBLAtVi7zvtTBnjwvdajJ8kgKg2WG3O9
        EKfCocOt9ypkVDzcWViUijgQxm989E0Jg465m5joRwlLn5oIkQ+G+go7Jm5NgNLOZcxrDajf
        Upicv+0LkAzv7j+WiDgIvoy1SUWsAPdV+7odoC7AfL9vfjmCzwsGEWthytVCeCUYFQGu7miR
        3g1dKw1ItLAVvv2uJsQpMii3y0XJHnC8GvYTcShUln2X1iDauSmYc1Mw56Ywzv/LGhHejLaz
        VsFUwAoaq3bzV7ei9TOMjOtELS+PDiGKRHSAbKCpNVtOMMVCiWkIAYnRwbKAxSfZclk+U3Ke
        5S05fBHHCkNI53n2WkwRkmfxHLXZlqPRxWi1Wv2B2LhYnZbeIat7y2XLqQLGxp5hWSvLb/T5
        kf6KUhT+aNbePpGmDKk5rQ5MOrJqSAqJ7AuYeD5CyMteB16/91dSdXhvfHNmymD7Z8ds30BY
        8cNG3tXzpiVr8u5Jh6JttDZ59Zrxg8ySWPHVxhnc1b0nApx9xGzdKjuXkNYxNa1Pdt7t2Llj
        fuYKP3hqSJPZ0rvvkl91bNah9IzwKmEbjQuFjCYS4wXmH0ERePScAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnG5m+eY4g55eOYutt6Qt9uw9yWKx
        5d8RVovDX3axObB4tBx5y+rRt2UVo8fnTXIBzFFcNimpOZllqUX6dglcGVe3fmcpOM5W0Xj3
        FlMD4yzWLkZODgkBE4nf846ydzFycQgJ7GaUeD2/mREiIS1x7MQZ5i5GDiBbWOLw4WKImueM
        EvuvNrCB1LAJ6Er8+7MfzBYR0JF4/GUCC4jNLFAq0XruHBNEQx+jxNcpf9lBEpwCthIrPkxk
        BxkqLOAl8WtBAojJIqAisf2lBUgFr4ClxMLvP9ghbEGJkzOfsICUMAvoSbRtZISYLi+x/e0c
        ZogrFSR+Pl3GChEXkZjd2cYMcY2VRMOOX8wTGIVnIZk0C2HSLCSTZiHpXsDIsopRMrWgODc9
        t9iwwDAvtVyvODG3uDQvXS85P3cTIzgmtDR3MG5f9UHvECMTB+MhRgkOZiURXp4fG+OEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ894oXBgnJJCeWJKanZpakFoEk2Xi4JRqYAr/G9No2B6xuGiP
        J3dl3eRH14O2LRH32+TY/XjDrO+Lug5M1/pub11wTJIncrLZg1lTfB8I6Sod+duuVDvjwvr2
        OIWfIUkxWYuvG7gLdJ/XrmD4tls67NOsIklJtXnvfaLzgo58OvErfoI1K2dTZcXWher+oTas
        q3K/3d6869UFJ5EPlwLKShlr1VJaDA/VbPDlTkw8FeF2bjHjrgt5V36Jr0n/k6O0/5HYiTTr
        3NrP61xsGCWnXEnfbWXww6z7RO0JfsbDdZPPnSwu+uF/VuCABsOhpqgWwa9bux89aNa4+dV3
        MY/rY/V7ufUK5yRUPy/eJMVkXhDb9SnzxjKZZ+ZvZ+7Z9feJ7MK+T9uitimxFGckGmoxFxUn
        AgDpdiM4+AIAAA==
X-CMS-MailID: 20200507025017epcas1p1daafe1a44960ebddfab157040fb968ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506142203epcas1p1f805af350b11786d9771fb5bd12bfdd6
References: <CGME20200506142203epcas1p1f805af350b11786d9771fb5bd12bfdd6@epcas1p1.samsung.com>
        <20200506142554.123748-1-weiyongjun1@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 'es' is malloced from exfat_get_dentry_set() in exfat_find() and should be freed before leaving from
> the error handling cases, otherwise it will cause memory leak.
> 
> Fixes: 5f2aa075070c ("exfat: add inode operations")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Applied.
Thanks!
> ---
>  fs/exfat/namei.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index c241dd177f1a..48f4df883f3b 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -681,6 +681,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
>  			exfat_fs_error(sb,
>  				"non-zero size file starts with zero cluster (size : %llu, p_dir : %u,
> entry : 0x%08x)",
>  				i_size_read(dir), ei->dir.dir, ei->entry);
> +			kfree(es);
>  			return -EIO;
>  		}
> 
> 


