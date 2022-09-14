Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F15B833D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 10:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiINIs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 04:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiINIsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:48:23 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6AC52DDF
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 01:48:16 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220914084811epoutp03a421a163f3677293dd22a546bef70779~UrdTLP3EJ0583705837epoutp03s
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 08:48:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220914084811epoutp03a421a163f3677293dd22a546bef70779~UrdTLP3EJ0583705837epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663145291;
        bh=GpenGdLc+Yz+N+RZI5HNax11+twVvZ4EXsMns6jJp9E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=msDh+/Qzu4+R32kq8GYoX4HvCxxHqiSaCcd57o2NNW5y2mHr4KqFxuaUjG/4HtdBt
         2A7sKldOoyCzxgLuTJ7sZdbOquvqULXjC/VjsOUMjSBbe/gYsmLIWsQS3f2bQ8nQ+h
         UJY+CF0Z2qAatmGp91ir9tibXtO4vd1j0Z3zB6Fw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220914084811epcas1p1b7860b3621183738f83f28b52ccf5b8a~UrdS8DNfm3035930359epcas1p1S;
        Wed, 14 Sep 2022 08:48:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.242]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MSDWH1Hxfz4x9Pt; Wed, 14 Sep
        2022 08:48:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.1F.18616.B4591236; Wed, 14 Sep 2022 17:48:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220914084810epcas1p4547a0dd24f463570451ed9994013b7ca~UrdR-m4gM0070000700epcas1p4E;
        Wed, 14 Sep 2022 08:48:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220914084810epsmtrp15e6e4ba273dc07563bcba8bfc469ed3e~UrdR_-Sp21418914189epsmtrp1C;
        Wed, 14 Sep 2022 08:48:10 +0000 (GMT)
X-AuditID: b6c32a38-6b9ff700000048b8-a6-6321954b0213
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.F2.18644.A4591236; Wed, 14 Sep 2022 17:48:10 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220914084810epsmtip23e4bdd554d33ccc44561b73b140870a0~UrdRyN1-w1960519605epsmtip2K;
        Wed, 14 Sep 2022 08:48:10 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Rover'" <739817562@qq.com>,
        "'linkinjeon'" <linkinjeon@kernel.org>
Cc:     "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <tencent_C77E59E94CE232025C1A0EA7642E22A9F708@qq.com>
Subject: RE: [PATCH v1] exfat: remove the code that sets FileAttributes when
 renaming
Date:   Wed, 14 Sep 2022 17:48:10 +0900
Message-ID: <000001d8c816$b7ad4010$2707c030$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJBluP1qAGmVhCZXr5YY9LBrskEeQIVjrm6rPxOW4A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmga73VMVkgxNLWS1aXu5gtZg4bSmz
        xZ69J1ksLu+aw2ax5d8RVgdWj02rOtk8bj1by+rRt2UVo8fnTXIBLFENjDaJRckZmWWpCql5
        yfkpmXnptkqhIW66FkoKGfnFJbZK0YaGRnqGBuZ6RkZGesaWsVZGpkoKeYm5qbZKFbpQvUoK
        RckFQLW5lcVAA3JS9aDiesWpeSkOWfmlIMfqFSfmFpfmpesl5+cqKZQl5pQCjVDST/jGmLH4
        1RLmgguCFT0bShsY+/m6GDk4JARMJCZ3xXQxcnEICexglNiy+j8LhPOJUeLyrKVQzmdGiUMN
        05i7GDnBOpbdfQGV2MUocfz8bWYI5yWjxLPd21hBqtgEdCWe3PgJ1iEi4CHx/m0LWAezQBOj
        xNXfJ5hAEpwCThJ/f7wHKxIWCJf4/2cFWDOLgKrEhM/X2UBsXgFLiYmrnrFC2IISJ2c+YQGx
        mQXkJba/nQN1koLE7k9HWSGWWUlc/vKfFaJGRGJ2ZxvYdRICnRwSLas+MEJ87SKxZIo6RK+w
        xKvjW9ghbCmJl/1tUHY3o8Sfc7wQvRMYJVrunGWFSBhLfPr8GWwOs4CmxPpd+hBhRYmdv+cy
        QtiCEqevdTND3MAn8e5rDyvEWl6JjjYhiBIVie8fdrJMYFSeheSzWUg+m4Xkg1kIyxYwsqxi
        FEstKM5NTy02LDBBju9NjOCUqmWxg3Hu2w96hxiZOBgPMUpwMCuJ8PaFKCQL8aYkVlalFuXH
        F5XmpBYfYkwGhvVEZinR5HxgUs8riTc0MTYwMAImQ3NLc2MihC0NTMyMTCyMLY3NlMR59bQZ
        k4UE0hNLUrNTUwtSi2C2MHFwSjUwzXAVTWrQWfIyeP7SGbZlnN8zFf/2MDKz/z69I0r0YWyS
        c3SN4iLmt1E6IiJcO2coXzHe//XSoarNvH4sPLsW9j254/Jy16FNM8s4ux32/G9/WX22z63A
        7P3phCTBXP7A3pjWKMZ96Z4KoYt9WSuXa/+IPCbb8HvX4da9Dg6/7nPEc4nam86V0Hm2okhz
        wcP//5wEVJfeWGPZ8C58XeS3GRJzHMzvmP07vc/x0NGApaY/bl/4zFhup7Jt6fKef24sV57P
        X7nfQqfWTl5PNH+/pfOjC0sSPC7EiMhn66elV5zU8rwhbhSYEvvQZJ5I38qmZwsXvtj33c/k
        rOf1lUv7Nvpt6Px9uDFNkuG7voOSEktxRqKhFnNRcSIAqMdr0WAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvK7XVMVkg/VHZC1aXu5gtZg4bSmz
        xZ69J1ksLu+aw2ax5d8RVgdWj02rOtk8bj1by+rRt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GYtfLWEuuCBY0bOhtIGxn6+LkZNDQsBEYtndFyxdjFwcQgI7GCWevtjB1MXIAZSQkji4TxPC
        FJY4fLgYouQ5o8ShW9vZQXrZBHQlntz4yQxSIyLgJbHifwlIDbNAC6PErMZnbBANkxklfu5q
        YgFp4BRwkvj74z0ziC0sECqxfXcbK4jNIqAqMeHzdTYQm1fAUmLiqmesELagxMmZT1hAFjAL
        6Em0bWQECTMLyEtsfzuHGeJ+BYndn46ClYsIWElc/vKfFaJGRGJ2ZxvzBEbhWUgmzUKYNAvJ
        pFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOFC2tHYx7Vn3QO8TIxMF4
        iFGCg1lJhLcvRCFZiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkm
        Dk6pBqYz//+9NTi40GD94VQWydDCsBJm/dNWXTIhu3dXf+D1W8a0sLZq+9P9k3RCGracWSf9
        sr3GsJr1/eZ/p3RlPzuv73l0Z86OHOkLYspvF/Nt/pbx5hBfMsfPBlvel7xTZ03edjWfv+qs
        sorQja7QVnvvyHOutRee7XaZuurLTOGkSZqxFQpbWtw7cqQNyvZpZTNpSerUJKqc3x/LdKFB
        4MlZq6ZPE/gWZS79te3XoxfMi4+LbK9dYt24Yv2U/oAplxjywiYbTVt2sfDslG/miidNBOYu
        fTkhdMvGUxN0tl87H6nqPi2ylX9tiUWbC5dcSzjTcdW7K7fNbRUsXryX7/k6ri0tbVpf3i0v
        YPu5R0VEiaU4I9FQi7moOBEAz1fHRQMDAAA=
X-CMS-MailID: 20220914084810epcas1p4547a0dd24f463570451ed9994013b7ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220909033708epcas1p23af4e173c0594a578b52cc59bcbeaacc
References: <CGME20220909033708epcas1p23af4e173c0594a578b52cc59bcbeaacc@epcas1p2.samsung.com>
        <tencent_C77E59E94CE232025C1A0EA7642E22A9F708@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Rover,

This patch seems to violate the exFAT specification below.
Please refer to the description for ATTR_ARCHIVE in FAT32 Spec.

* Archive
This field is mandatory and conforms to the MS-DOS definition.

* ATTR_ARCHIVE
This attribute supports backup utilities. This bit is set by the FAT file
system driver when a file is created, renamed, or written to. Backup
utilities may use this attribute to indicate which files on the volume
have been modified since the last time that a backup was performed.

Thanks.
B.R.

Sungjong Seo

> When renaming, FileAttributes remain unchanged, do not need to be
> set, so the code that sets FileAttributes is unneeded, remove it.
> 
> Signed-off-by: rover &lt;739817562@qq.com&gt;
> ---
>  fs/exfat/namei.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index b617bebc3d0f..5ffaf553155e 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -1031,10 +1031,6 @@ static int exfat_rename_file(struct inode *inode,
> struct exfat_chain *p_dir,
>  			return -EIO;
> 
>  		*epnew = *epold;
> -		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
> -			epnew-&gt;dentry.file.attr |=
> cpu_to_le16(ATTR_ARCHIVE);
> -			ei-&gt;attr |= ATTR_ARCHIVE;
> -		}
>  		exfat_update_bh(new_bh, sync);
>  		brelse(old_bh);
>  		brelse(new_bh);
> @@ -1063,10 +1059,6 @@ static int exfat_rename_file(struct inode *inode,
> struct exfat_chain *p_dir,
>  		ei-&gt;dir = *p_dir;
>  		ei-&gt;entry = newentry;
>  	} else {
> -		if (exfat_get_entry_type(epold) == TYPE_FILE) {
> -			epold-&gt;dentry.file.attr |=
> cpu_to_le16(ATTR_ARCHIVE);
> -			ei-&gt;attr |= ATTR_ARCHIVE;
> -		}
>  		exfat_update_bh(old_bh, sync);
>  		brelse(old_bh);
>  		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
> @@ -1112,10 +1104,6 @@ static int exfat_move_file(struct inode *inode,
> struct exfat_chain *p_olddir,
>  		return -EIO;
> 
>  	*epnew = *epmov;
> -	if (exfat_get_entry_type(epnew) == TYPE_FILE) {
> -		epnew-&gt;dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
> -		ei-&gt;attr |= ATTR_ARCHIVE;
> -	}
>  	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
>  	brelse(mov_bh);
>  	brelse(new_bh);
> --
> 2.25.1

