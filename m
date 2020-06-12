Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A641F7556
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 10:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFLIew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 04:34:52 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56509 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLIev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:34:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200612083448epoutp03f661f67f02e6f3edce383783809e5b0e~XvuYSGaX41210612106epoutp03-
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 08:34:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200612083448epoutp03f661f67f02e6f3edce383783809e5b0e~XvuYSGaX41210612106epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591950888;
        bh=gAAldD/B9B3N4Tw0s7+MAFW/ThmYfm6H+aM1y5UC4+I=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=J6oeIKdTxKxSk1Lq4insvt7UUvQZGQIzWOc2Cp0Wuj3fxUD4zMlV1dbkyemccxgNT
         guRsdHl/BuJWLkJ4moDDc4bF6ydV+C1UGzvIND2iOk7h1NbXGJIIVJ65fGqj7rAl+W
         zvGtlPV4jUb5AY0tvtoS3eoJxaBCJchmd8PWCL7I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200612083448epcas1p24f83d90677700e9a4702dad87f7bbe53~XvuX86sjL1023310233epcas1p2P;
        Fri, 12 Jun 2020 08:34:48 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49jvD71hGqzMqYm0; Fri, 12 Jun
        2020 08:34:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.51.29173.72E33EE5; Fri, 12 Jun 2020 17:34:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200612083446epcas1p1595422de7bf3dc820cd062870ebef384~XvuWcKk6x1836618366epcas1p19;
        Fri, 12 Jun 2020 08:34:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200612083446epsmtrp2f24b60e4b5f796ca6e85201960f3bbac~XvuWbd_2V0401604016epsmtrp2i;
        Fri, 12 Jun 2020 08:34:46 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-ce-5ee33e275b6b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.D0.08303.62E33EE5; Fri, 12 Jun 2020 17:34:46 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200612083446epsmtip2cd48bd17cd3212574f7eb8469b45d78b~XvuWPiA681677716777epsmtip2E;
        Fri, 12 Jun 2020 08:34:46 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200612012834.13503-1-kohada.t2@gmail.com>
Subject: RE: [PATCH] exfat: remove EXFAT_SB_DIRTY flag
Date:   Fri, 12 Jun 2020 17:34:46 +0900
Message-ID: <219a01d64094$5418d7a0$fc4a86e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJnvEdqdI23glRQ63sAxRdAmHabxwH6sMC1p6HGlLA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmga663eM4g2mN7BY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwReXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0
        MDAyBapMyMmYtcOyYKdAxZ0+5QbGVt4uRk4OCQETicNP2hm7GLk4hAR2MEpM2HqUHcL5xCgx
        e85GqMxnRomJM16ywbR82LiaFSKxi1Fi2ds2NgjnJaPEyyePmUGq2AR0JZ7c+AlmiwjoSZw8
        eR2sm1mgkUnixMtsEJtTwFJi6oLNLCC2sICZxNKuvWA2i4CqRPvF02A2L1DN86mnmCBsQYmT
        M5+wQMyRl9j+dg4zxEUKErs/HWWF2GUlsej0I0aIGhGJ2Z1tzCDHSQjM5JBYsfY6I0SDi8S7
        29tYIWxhiVfHt7BD2FISn9/thXqzXmL3qlMsEM0NjBJHHi1kgUgYS8xvWQg0lQNog6bE+l36
        EGFFiZ2/50It5pN497WHFaREQoBXoqNNCKJEReL7h50sMKuu/LjKNIFRaRaS12YheW0Wkhdm
        ISxbwMiyilEstaA4Nz212LDAGDmyNzGCk6mW+Q7GaW8/6B1iZOJgPMQowcGsJMIrKP4wTog3
        JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbnA9N5Xkm8oamRsbGxhYmZuZmpsZI4r6/VhTghgfTE
        ktTs1NSC1CKYPiYOTqkGJvbLR6XX3Jm9Zp8iw/Utx07/zn/a6c0m46q2jm/elLRZLw0evHFP
        +z9zzpf3s6POMFcf0BZojc0XEa5yXalQ9s0jf9mJGVV3NivtMdnz79Uc/0+v1rTM4fO55BPA
        Yvs/VvHoPgP/fzs3tbzkkJkcyXBoVdwxkVQWJrllCir1Tr1VmcsEslclzD7bql8kfPfD1zqf
        w8wrPfu7eqf8uvsoNo//3FsZ3jsOG77x8btNm6t0dv5dxj/KjUvnT/+YP9tfaFX4x2c14ebc
        toKl501twn9rqz99V7WzN3PFr1Z7SX/1CQyq+puFrxQtOXBtndjSDq/rF3VS+ie2lvYo72NZ
        +Ieh9uwxtflllivvcXL61CixFGckGmoxFxUnAgC3CbnRLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJXlfN7nGcweRFShY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlzNphWbBToOJOn3IDYytvFyMnh4SAicSHjatZuxi5OIQE
        djBKLHh/AsjhAEpISRzcpwlhCkscPlwMUfKcUWLex5dsIL1sAroST278ZAaxRQT0JE6evM4G
        UsQs0Mwk0fqlmQkkISTQxSjxapkiiM0pYCkxdcFmFhBbWMBMYmnXXjCbRUBVov3iaTCbF6jm
        +dRTTBC2oMTJmU9YQI5gBlrQtpERJMwsIC+x/e0cZoj7FSR2fzrKCnGDlcSi04+gakQkZne2
        MU9gFJ6FZNIshEmzkEyahaRjASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4GjS
        0trBuGfVB71DjEwcjIcYJTiYlUR4BcUfxgnxpiRWVqUW5ccXleakFh9ilOZgURLn/TprYZyQ
        QHpiSWp2ampBahFMlomDU6qBKW+jQeD1CUz3kn9KufM9MCyVEf3k1aPULcqWq/jJo2lq2rJu
        f/fTPYyLZyos/f00/uVKEWE5o4ea0zOf23nfS/nzPzigQu/XUW67ZckfTlh567mcLYlR7Il1
        +z3povYuTmXf8tNODjNfJ17tZmfbtLfTjnuzgFfWfsOT2h+su/n5f0lIlCyPU+R2Ldyuav11
        8wNpno0SIop1wlVSi082GOxhkN7Vf9B8Yv6LyBsrFNQPH2hS9mwU1cl6sFt5mkBWbvXSZV++
        C03IlJr/78pVpZfnv3Jpr/JL/fehef5x+YcSWV6HJtpa//Aqu7BKi9M2/r7GntbqZTm3gx33
        NT/tPC873cX3X3EL65y35+crsRRnJBpqMRcVJwIAlRYz3xUDAAA=
X-CMS-MailID: 20200612083446epcas1p1595422de7bf3dc820cd062870ebef384
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200612012902epcas1p4194d6fa3b3f7c46a8becb9bb6ce23d56
References: <CGME20200612012902epcas1p4194d6fa3b3f7c46a8becb9bb6ce23d56@epcas1p4.samsung.com>
        <20200612012834.13503-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> remove EXFAT_SB_DIRTY flag and related codes.
> 
> This flag is set/reset in exfat_put_super()/exfat_sync_fs() to avoid
> sync_blockdev().
> However ...
> - exfat_put_super():
> Before calling this, the VFS has already called sync_filesystem(), so sync
> is never performed here.
> - exfat_sync_fs():
> After calling this, the VFS calls sync_blockdev(), so, it is meaningless
> to check EXFAT_SB_DIRTY or to bypass sync_blockdev() here.
> Not only that, but in some cases can't clear VOL_DIRTY.
> ex:
> VOL_DIRTY is set when rmdir starts, but when non-empty-dir is detected,
> return error without setting EXFAT_SB_DIRTY.
> If performe 'sync' in this state, VOL_DIRTY will not be cleared.
> 
> Remove the EXFAT_SB_DIRTY check to ensure synchronization.
> And, remove the code related to the flag.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/balloc.c   |  4 ++--
>  fs/exfat/dir.c      | 16 ++++++++--------
>  fs/exfat/exfat_fs.h |  5 +----
>  fs/exfat/fatent.c   |  7 ++-----
>  fs/exfat/misc.c     |  3 +--
>  fs/exfat/namei.c    | 12 ++++++------
>  fs/exfat/super.c    | 11 +++--------
>  7 files changed, 23 insertions(+), 35 deletions(-)
> 
[snip]
> 
> @@ -62,11 +59,9 @@ static int exfat_sync_fs(struct super_block *sb, int
> wait)
> 
>  	/* If there are some dirty buffers in the bdev inode */
>  	mutex_lock(&sbi->s_lock);
> -	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state)) {
> -		sync_blockdev(sb->s_bdev);
> -		if (exfat_set_vol_flags(sb, VOL_CLEAN))
> -			err = -EIO;
> -	}

I looked through most codes related to EXFAT_SB_DIRTY and VOL_DIRTY.
And your approach looks good because all of them seem to be protected by
s_lock.

BTW, as you know, sync_filesystem() calls sync_fs() with 'nowait' first,
and then calls it again with 'wait' twice. No need to sync with lock twice.
If so, isn't it okay to do nothing when wait is 0?

> +	sync_blockdev(sb->s_bdev);
> +	if (exfat_set_vol_flags(sb, VOL_CLEAN))
> +		err = -EIO;
>  	mutex_unlock(&sbi->s_lock);
>  	return err;
>  }
> --
> 2.25.1


