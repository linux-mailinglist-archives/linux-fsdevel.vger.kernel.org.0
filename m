Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284126DAA11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjDGI3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjDGI3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:29:06 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6332E7ED0
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 01:29:03 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230407082859epoutp04333aeb0004610f080b84a199d5eb56fc~TmcDynlnl1631816318epoutp04B
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 08:28:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230407082859epoutp04333aeb0004610f080b84a199d5eb56fc~TmcDynlnl1631816318epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680856139;
        bh=uxz7nQG0Usod/LqLFz4nWYoLIIAAWKbo3Z2+zic6Ook=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p9Dctoqq5/92SPJXpzRR5vL5Gau5QftRUiXCr+46UIl5ih23b15x3wTgdRePN1Awk
         hIlIRujIJn77HOYNSIOt3Auy7PNOWDBQRlGZl/r4axWaVHlCjRFN+6M2mSHL2XTcqp
         mTJTuEqlDKpXCBHYcdpTvOCGSx/Mfhr5YzzqFbkM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230407082859epcas5p152c60b10104257fb2f170a2ce37984aa~TmcDny6bI3162431624epcas5p1d;
        Fri,  7 Apr 2023 08:28:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PtBNV3T85z4x9Q2; Fri,  7 Apr
        2023 08:28:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.56.10528.944DF246; Fri,  7 Apr 2023 17:28:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230407082718epcas5p4f500a6e00dbbd189fbfed87bf47d6ad1~Tmalv7B6f1119611196epcas5p4Y;
        Fri,  7 Apr 2023 08:27:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230407082718epsmtrp22748219895a485c5f9da6f5966fe44bd~Tmalu1F5h1287712877epsmtrp21;
        Fri,  7 Apr 2023 08:27:18 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-41-642fd449a9ac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.7D.18071.6E3DF246; Fri,  7 Apr 2023 17:27:18 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230407082716epsmtip1f21b7f3a7f2d50a7b3f1ab3e1c40c08c~TmajOpZbd1209712097epsmtip1D;
        Fri,  7 Apr 2023 08:27:15 +0000 (GMT)
Date:   Fri, 7 Apr 2023 13:56:27 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: remove unnecessary goto
Message-ID: <20230407082627.oh2l4lfltmxy52nx@green5>
MIME-Version: 1.0
In-Reply-To: <20230406195615.80078-1-frank.li@vivo.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTS9fzin6KwbnN7BYTj8xgstiz9ySL
        xeVdc9gsnu3eyOzA4rFi2kUmj8+b5Dw2fOpgDmCOyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
        NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqmpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
        Si1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO2Ll2HmPBQ86Kvb22DYwLOLoYOTgkBEwk
        Vk8P7WLk4hAS2M0osW7HbXYI5xOjxO3N59ggnG+MEtt/NrF0MXKCdfyY3sUEkdjLKNH9ZiUz
        hPOEUeLeyZdMIFUsAioSTyadYwTZwSagLXH6PwdIWERASeL7vpmMIDazQKrEqZa1YOXCAkYS
        k1e8BbN5gRZcnL6JBcIWlDg58wmYzSlgLvH38h12EFtUQEZixtKvYHslBK6xS7xtWcQEcZ2L
        xJE1vawQtrDEq+Nb2CFsKYnP7/ayQdjlEiunrGCDaG5hlJh1fRYjRMJeovVUPzPEdRkS2z8v
        Z4aIy0pMPbWOCSLOJ9H7+wnUMl6JHfNgbGWJNesXQC2QlLj2vZENEsAeEq23ayEB1MUoMeHF
        CpYJjPKzkDw3C8k6CNtKovNDE+ssoHZmAWmJ5f84IExNifW79Bcwsq5ilEwtKM5NTy02LTDM
        Sy2Hx3dyfu4mRnBa1PLcwXj3wQe9Q4xMHIyHGCU4mJVEeC/X6aUI8aYkVlalFuXHF5XmpBYf
        YjQFxtVEZinR5HxgYs4riTc0sTQwMTMzM7E0NjNUEudVtz2ZLCSQnliSmp2aWpBaBNPHxMEp
        1cAkX92dXHhg5WvV7rhCtrKseVv4LHdElNZ2yM1iWexeck9dQ65NaZbT5E8TLnuJdyxcO/fh
        geZrXIoumWphyw6XC6kkzVZr4nvjUSkUmdH4MaE2y9ZhWkn2NS4Ow+kCCwuFDbVeLVl8u7nz
        5vLtgv82P36T/TDPZqnx//+ek0J065+67pvmxvt5s8KPs8ffH/bQ7ZRsETgdxXeu6uBrpqd3
        t9Uuyth9u+3+N5U7r4r0JzRmmBnxzDtVzP39D5+M98qSWXs6HogFliWH7F+f9HmB2t0V++/v
        q7kRHMjzPfoU4wHOzc3nJybNWP3ZplVZqnDzBf9nLWfKPnWWrQqX/snyT/hCw7FS8dQPuk+z
        fOYqsRRnJBpqMRcVJwIAzTn0vBQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSnO6zy/opBrOmm1lMPDKDyWLP3pMs
        Fpd3zWGzeLZ7I7MDi8eKaReZPD5vkvPY8KmDOYA5issmJTUnsyy1SN8ugSvj7YpPrAWT2Ss+
        zHzF3sD4hrWLkZNDQsBE4sf0LqYuRi4OIYHdjBLnJ0xlgkhISiz7e4QZwhaWWPnvOTtE0SNG
        idvNR8ESLAIqEk8mnWPsYuTgYBPQljj9nwMkLCKgJPF930xGEJtZIFXiVMtasJnCAkYSk1e8
        BbN5gRZfnL6JBcQWEjCT+NP+lAUiLihxcuYTFoheM4l5mx8yg4xnFpCWWP4PbDyngLnE38t3
        2EFsUQEZiRlLvzJPYBSchaR7FpLuWQjdCxiZVzFKphYU56bnFhsWGOallusVJ+YWl+al6yXn
        525iBIezluYOxu2rPugdYmTiYDzEKMHBrCTCe7lOL0WINyWxsiq1KD++qDQntfgQozQHi5I4
        74Wuk/FCAumJJanZqakFqUUwWSYOTqkGJpNv4uw9Tszvv/2PU7GSMjV5byX0syPggTmHXsMM
        Sf7E32sr2hfMWmi/2WXukQnTu442rffo7hETfBXS/uhNgNNNOdV8RaE21vW89S9W8n345fz1
        Ss2mK23y9/cq7FZUlHBdcNBl5iEW/y3fLZ6kBV7cI/PiT2OvRa3OBAc+c5X1woYMed+nbhDq
        UN5moZPbcTd8hv7Za1P+u3lx81X0OTLMLbsauUSz9IYfD9PGoJ0J/1/wXatKzDesFk3u9V1R
        Pd0sNEzb5GC/mnZj8a6GTwxd1csXx2w4f1VAqO+dh43RnhtcXw9c31amK5jpZ6Z96EZAm0Gp
        NvdRh19P7kyNjTn10ib5aE7WJctbHw4rsRRnJBpqMRcVJwIAcbUM4tYCAAA=
X-CMS-MailID: 20230407082718epcas5p4f500a6e00dbbd189fbfed87bf47d6ad1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Zd.sqB5Rrz_NXAV9fsVjIXI9mlljbjA9yzE-aJOBfPlcmgnB=_21e39_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230407082718epcas5p4f500a6e00dbbd189fbfed87bf47d6ad1
References: <20230406195615.80078-1-frank.li@vivo.com>
        <CGME20230407082718epcas5p4f500a6e00dbbd189fbfed87bf47d6ad1@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------Zd.sqB5Rrz_NXAV9fsVjIXI9mlljbjA9yzE-aJOBfPlcmgnB=_21e39_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/04/07 03:56AM, Yangtao Li wrote:
>In this case, the error code can be returned directly.
>
>Signed-off-by: Yangtao Li <frank.li@vivo.com>
>---
> fs/fuse/inode.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>index d66070af145d..56efcf160513 100644
>--- a/fs/fuse/inode.c
>+++ b/fs/fuse/inode.c
>@@ -1921,10 +1921,8 @@ static int fuse_sysfs_init(void)
> 	int err;
>
> 	fuse_kobj = kobject_create_and_add("fuse", fs_kobj);
>-	if (!fuse_kobj) {
>-		err = -ENOMEM;
>-		goto out_err;
>-	}
>+	if (!fuse_kobj)
>+		return -ENOMEM;
>
> 	err = sysfs_create_mount_point(fuse_kobj, "connections");
> 	if (err)
>@@ -1934,7 +1932,6 @@ static int fuse_sysfs_init(void)
>
>  out_fuse_unregister:
> 	kobject_put(fuse_kobj);
>- out_err:
> 	return err;
> }
>
>-- 
>2.35.1
>
Reviewed by: Nitesh Shetty <nj.shetty@samsung.com>

------Zd.sqB5Rrz_NXAV9fsVjIXI9mlljbjA9yzE-aJOBfPlcmgnB=_21e39_
Content-Type: text/plain; charset="utf-8"


------Zd.sqB5Rrz_NXAV9fsVjIXI9mlljbjA9yzE-aJOBfPlcmgnB=_21e39_--
