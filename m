Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8901EE026
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 10:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgFDIvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 04:51:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25795 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgFDIvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:51:00 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200604085057epoutp02bb09ecf445e46a220be1d334af6a0a79~VSyM3Ruyx2523125231epoutp028
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2020 08:50:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200604085057epoutp02bb09ecf445e46a220be1d334af6a0a79~VSyM3Ruyx2523125231epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591260658;
        bh=eiT4zE4N6qghyI855X8EhhmPspbo3UGb2HMr2ZZW5wo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=unLw/TYYkAYPRzdoq2DI4zzo2Qv3GjnWE6W2VsLDS+2KVoGIa2kd3h3hL7rzylNFd
         7eiQxTfLLd0mMmIV6zErIC2C/fRncN3IchzsL8mhWoQuVO1qRDA4HT1jCz84BBMw5P
         rqY0wFlMwvPbNsBZsow4zkHqc3HDIg4aMfZTMQRo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200604085057epcas1p181942811ffecaa1d9a279d924f3259f3~VSyMf6_Wl3236232362epcas1p1R;
        Thu,  4 Jun 2020 08:50:57 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49czyS5RrDzMqYls; Thu,  4 Jun
        2020 08:50:56 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.0B.18978.FE5B8DE5; Thu,  4 Jun 2020 17:50:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200604085055epcas1p13ad755de0025882cf5b02a5d692d1bf2~VSyKO218x3236232362epcas1p1M;
        Thu,  4 Jun 2020 08:50:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200604085055epsmtrp21974bb76d2aecfaba2d600fb12313d92~VSyKOTBLK1455114551epsmtrp2k;
        Thu,  4 Jun 2020 08:50:55 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-1a-5ed8b5ef36d6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.B2.08303.FE5B8DE5; Thu,  4 Jun 2020 17:50:55 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200604085054epsmtip16bd26357139f7c7bd9e1a34863f448de~VSyKFD-rn2388823888epsmtip1B;
        Thu,  4 Jun 2020 08:50:54 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'hyeongseok.kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1591246468-32426-1-git-send-email-hyeongseok@gmail.com>
Subject: RE: [PATCH] exfat: fix range validation error in alloc and free
 cluster
Date:   Thu, 4 Jun 2020 17:50:54 +0900
Message-ID: <3b5501d63a4d$4213b950$c63b2bf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHxYN2oYYNEwgPUPKVHj0TzywX0XwKkTEp7qHy0/4A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmvu77rTfiDD68ULD4O/ETk8WevSdZ
        LH5Mr3dg9tg56y67R9+WVYwenzfJBTBH5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
        WlqYKynkJeam2iq5+AToumXmAO1RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQY
        GhToFSfmFpfmpesl5+daGRoYGJkCVSbkZLyZcpS9YCJXxbaPp9gbGHs4uhg5OSQETCSurZ3G
        3sXIxSEksINRYv29jWwQzidGiWMTn7BAOJ8ZJa7u388O03Ll43RmiMQuoMTGB1D9LxklJn6Z
        xQxSxSagK/Hkxk8wW0TAQ2Lrs/9Aozg4mAWUJVZ+CQYxOQVcJf7PNgOpEBYIkujc3wxWzSKg
        InH0zW8wm1fAUuLTr/csELagxMmZT8BsZgF5ie1v5zBD3KMgsfvTUVaITVYSf/r7mSFqRCRm
        d7aB3Skh8JJd4t6qc+wgeyUEXCSap3JC9ApLvDq+BeovKYnP7/ayQdj1ErtXnWKB6G1glDjy
        aCELRMJYYn7LQmaIVzQl1u/ShwgrSuz8PZcRYi+fxLuvPawQq3glOtqEIEpUJL5/2MkCs+rK
        j6tMExiVZiH5bBaSz2Yh+WAWwrIFjCyrGMVSC4pz01OLDQsMkeN6EyM4CWqZ7mCc+PaD3iFG
        Jg7GQ4wSHMxKIrxWstfihHhTEiurUovy44tKc1KLDzGaAsN6IrOUaHI+MA3nlcQbmhoZGxtb
        mJiZm5kaK4nzistciBMSSE8sSc1OTS1ILYLpY+LglGpgyjPMr/pt8YxjktR51i0HJuaYB3vK
        mk3wl1iz8MopZ/Hepbsmp5y9eGByiorR46ebO858PbxixeqMkrcrFkt6bPTO7Jv12GTqO/s9
        Ai+Fwp501F+fM73pnPg9lX3Mc+RY30YsVxZmVTQLnrqP65u8tGVXqPEV/kna4Q7qcXsbvd8n
        2DRu1eAQTd0XwNq44fIJgbB9upPWhRZJi/Wwrlp7ktXOJX7j/LcOtn/Fe1TLBWyEW/8laf5/
        t97+nq+Cc0MPU9GziAld536/U+76pRJin2ym2DBB1mHK5Jwqez5fh49735Zd0Vhy5dxGQa3W
        7u5f+5VN7brsdKO3TjwvKPtji9qPrZ9P3ox99TdnQ2qEEktxRqKhFnNRcSIAowlyQAsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO77rTfiDHrOMlv8nfiJyWLP3pMs
        Fj+m1zswe+ycdZfdo2/LKkaPz5vkApijuGxSUnMyy1KL9O0SuDLeTDnKXjCRq2Lbx1PsDYw9
        HF2MnBwSAiYSVz5OZ+5i5OIQEtjBKHG5FcThAEpISRzcpwlhCkscPlwMUfKcUWJbw3oWkF42
        AV2JJzd+MoPYIgJeEks7ToO1MgsoS6z8EgxRP41R4u/RJjaQOKeAq8T/2WYg5cICARI/T2xn
        BbFZBFQkjr75DTaGV8BS4tOv9ywQtqDEyZlPWCBG6km0bWQECTMLyEtsfzuHGeJ6BYndn46y
        QlxgJfGnv58ZokZEYnZnG/MERuFZSCbNQpg0C8mkWUg6FjCyrGKUTC0ozk3PLTYsMMpLLdcr
        TswtLs1L10vOz93ECI4DLa0djHtWfdA7xMjEwXiIUYKDWUmE10r2WpwQb0piZVVqUX58UWlO
        avEhRmkOFiVx3q+zFsYJCaQnlqRmp6YWpBbBZJk4OKUamKyyO1g/Hg2akX3jRPy5o8vqNUOD
        s0q6VA3mveyrl5h8fdEa3s462Z1vmeJv/H270/NsjVXWz5l2Nyzefaly96tIvDm3JXBt9LPZ
        Onsle7tPdMiw2e1YeGfl0n1Rl3+tufI/9Or1m1uCTi69+mN1OFdz/dXJy69smHrfojTCs3Sp
        nUuf6pF/yo1nZ0feVFLPqgtu+30mv8Bh600zqU93i+1f/Xjh4sIt/YffhV3o27FXzubxHEbW
        d22Paee+i7rmXSCguNPNYrbX4sjLFyatD0mpuNbB3ht4M2if/K7J7x7vbV+VVRDa2Hlr9e4F
        fx2Zuf+tqa8JOHC34pV9/zm/9SsXO2Xzupw4XdawztZS+oYSS3FGoqEWc1FxIgDNsMdG8gIA
        AA==
X-CMS-MailID: 20200604085055epcas1p13ad755de0025882cf5b02a5d692d1bf2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200604045437epcas1p17180ef9b61d8ff1d4877c49755e766a2
References: <CGME20200604045437epcas1p17180ef9b61d8ff1d4877c49755e766a2@epcas1p1.samsung.com>
        <1591246468-32426-1-git-send-email-hyeongseok@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> There is check error in range condition that can never be entered even
> with invalid input.
> Replace incorrent checking code with already existing valid checker.
> 
> Signed-off-by: hyeongseok.kim <hyeongseok@gmail.com>

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

Looks good. Thank you!

> ---
>  fs/exfat/fatent.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c index 267e5e0..4e5c5c9
> 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -169,7 +169,7 @@ int exfat_free_cluster(struct inode *inode, struct
> exfat_chain *p_chain)
>  		return 0;
> 
>  	/* check cluster validation */
> -	if (p_chain->dir < 2 && p_chain->dir >= sbi->num_clusters) {
> +	if (!is_valid_cluster(sbi, p_chain->dir)) {
>  		exfat_err(sb, "invalid start cluster (%u)", p_chain->dir);
>  		return -EIO;
>  	}
> @@ -346,7 +346,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned
> int num_alloc,
>  	}
> 
>  	/* check cluster validation */
> -	if (hint_clu < EXFAT_FIRST_CLUSTER && hint_clu >= sbi->num_clusters)
> {
> +	if (!is_valid_cluster(sbi, hint_clu)) {
>  		exfat_err(sb, "hint_cluster is invalid (%u)",
>  			hint_clu);
>  		hint_clu = EXFAT_FIRST_CLUSTER;
> --
> 2.7.4


