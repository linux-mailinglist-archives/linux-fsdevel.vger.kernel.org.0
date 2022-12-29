Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257F86588A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 03:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiL2C2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Dec 2022 21:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiL2C2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:28:31 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7068412748
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Dec 2022 18:28:29 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221229022827epoutp02fe324b925986d8d2ed42d1d45240909c~1IqApZMIu3007830078epoutp02l
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 02:28:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221229022827epoutp02fe324b925986d8d2ed42d1d45240909c~1IqApZMIu3007830078epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672280907;
        bh=B/5YBfWgnCkRecqs7NGGcqjwzt+UYfoqtf1L2CsmvII=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=T4ECNvOQLtrLkfsYqayGK+YcvBdCwRvtfeFD95uM8F0Y+SdHYsVIBCf3H+bsJRIIz
         f5q66MzPOfLrjKeAbfUDYHHvUOxqPHKDWdrlWWbs29XsKz94H5AaBZ8NA0y3YbwPr+
         kQeO7NaLgeoB2y364gWukj3WiO4bnGPgl9/XnaKk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221229022827epcas1p1eebface5cb2a0ed7871081c13649bade~1IqAZlGFn0283202832epcas1p1A;
        Thu, 29 Dec 2022 02:28:27 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.223]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NjC4C2BpBz4x9Q0; Thu, 29 Dec
        2022 02:28:27 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.70.02461.B4BFCA36; Thu, 29 Dec 2022 11:28:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221229022826epcas1p2cdc22486ee5080e220a15286cff5dbd2~1Ip-j2-yX3187131871epcas1p2O;
        Thu, 29 Dec 2022 02:28:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221229022826epsmtrp2d86d41ff34ce2e1ea5ebd73bcd4896e3~1Ip-jO3Sx0564305643epsmtrp2U;
        Thu, 29 Dec 2022 02:28:26 +0000 (GMT)
X-AuditID: b6c32a37-adffd7000000099d-2b-63acfb4b53e6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.F3.02211.A4BFCA36; Thu, 29 Dec 2022 11:28:26 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221229022826epsmtip11bb862b4e83422ce8e9ce44156c95b4b~1Ip-bykXT0383203832epsmtip1B;
        Thu, 29 Dec 2022 02:28:26 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     <linkinjeon@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB6316579893496BC54C4FE96F81EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1] exfat: fix reporting fs error when reading dir
 beyond EOF
Date:   Thu, 29 Dec 2022 11:28:26 +0900
Message-ID: <019301d91b2d$3b3c0dd0$b1b42970$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHGf8/eNee1lFo92Y4FqX1qCBeMTAHRB6CHrprSKTA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJsWRmVeSWpSXmKPExsWy7bCmrq737zXJBufe8llMnLaU2WLP3pMs
        Fpd3zWGz2PLvCKsDi8emVZ1sHn1bVjF6fN4kF8Ac1cBok1iUnJFZlqqQmpecn5KZl26rFBri
        pmuhpJCRX1xiqxRtaGikZ2hgrmdkZKRnbBlrZWSqpJCXmJtqq1ShC9WrpFCUXABUm1tZDDQg
        J1UPKq5XnJqX4pCVXwpyol5xYm5xaV66XnJ+rpJCWWJOKdAIJf2ERuaMYz+usRS85KmYf+YO
        UwPjEq4uRk4OCQETidf9j1i7GLk4hAR2MEocW7CdCcL5xCjxZcMnVpAqIYFvjBIPppnDdPxp
        vwQV38so8eKJI0TDS0aJjgvb2EESbAK6Ek9u/GQGsUUEpCXmXZzCBGIzC8RLLN5xnA3E5hSI
        lZh9ZwMLiC0sECzxa9lqRhCbRUBVYvWLjWA2r4ClxNbbk9kgbEGJkzOfsEDMkZfY/nYOM8RB
        ChK7Px1lhdhlJdFz8xEbRI2IxOzONmaQ4yQEvrJLTDgNsUxCwEVi8aUZUM3CEq+Ob2GHsKUk
        Pr/bywbR0M0ocfzjO6iGGYwSSzocIGx7iebWZqAiDqANmhLrd+lDhBUldv6eywhhC0qcvtbN
        DHEEn8S7rz2sIOUSArwSHW1CECUqEt8/7GSZwKg8C8lrs5C8NgvJC7MQli1gZFnFKJZaUJyb
        nlpsWGCMHN+bGMHpU8t8B+O0tx/0DjEycTAeYpTgYFYS4dU4uzpZiDclsbIqtSg/vqg0J7X4
        EONERmBoT2SWEk3OB6bwvJJ4QzMzSwtLIxNDYzNDQ8LCJsYGBkbAVGtuaW5MhLClgYmZkYmF
        saWxmZI4b/7+RclCAumJJanZqakFqUUwRzFxcEo1MIW47/49++imuhN5td/Pi6047nbure7Z
        ELlJDNMEWDOr43hWhwfXxF746OrEZbj9+gG1jZukVQUWB///UOL3dtLEpWV8a1N4ZsUqmqWL
        njRSPJlwza36/qnfPlkF8iqH5JaHzRI7Pd9lmmHn1OxpqtndShVRwud+vOp4FOzc/c7KWLmG
        J4VPy2T9zEUHXRl0/5j+uZ8ae+3Qvr+8ouzx6rdu7LKpq7344P/0irxyjs92hed/zLokM2P7
        zc1tv/ed7eWdYHWd74Nhk9FNN/PKmMjK+WpR8zZ+nfDvpugzo0OB6gfX6R+xNkqw0eGxvTL/
        udmDw4fUGx8+WGF0pu2S0ZzsgMT/qnlih66nNzOZsCmxFGckGmoxFxUnAgB/Nlv8hQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnK7X7zXJBkt/aVlMnLaU2WLP3pMs
        Fpd3zWGz2PLvCKsDi8emVZ1sHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJVx7Mc1loKXPBXz
        z9xhamBcwtXFyMkhIWAi8af9EmsXIxeHkMBuRonXl54xdzFyACWkJA7u04QwhSUOHy6GKHnO
        KLH8wXkmkF42AV2JJzd+MoPYIgLSEvMuTgGLMwskSpxZ0gY1cx2jxNrZT8GKOAViJWbf2cAC
        YgsLBEpM3PyfDcRmEVCVWP1iIyOIzStgKbH19mQ2CFtQ4uTMJywQQ7Uleh+2MkLY8hLb385h
        hnhAQWL3p6OsEEdYSfTcfMQGUSMiMbuzjXkCo/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3P
        LTYsMMxLLdcrTswtLs1L10vOz93ECI4NLc0djNtXfdA7xMjEwXiIUYKDWUmEV+Ps6mQh3pTE
        yqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamE6wzypdaKqxn3lF
        gZbP/6gfrhXM1uze9gyPVgnt9S2PdAv8d3pdOMt3hckp27PNlR7e5n/RcdfQa8bFBIWOx7s9
        J3VdScuoutTFlCfm8bZ4xXvex4ntRQd+tvReunX49+bO7eEbHd7G7jqce/pAgeCCJe7S08s3
        SD/bc/7wce/F+4LXpN3yzDcpblCfIdyj9YVj4tdre2OKnLTWCsXf1ZpfXWyu9KX0auuF97lx
        kxja/iZI+10R22P0kWth8OyPpx/6T7aSOrqV7bFZussGkSKhjxK7ZA7bV/IuM3cOvnpl9rap
        j3dJRCfZzpuXNKu99YuEevxPYcW9mT639lqulGnkNEmwnDXP6tmrn2F31iixFGckGmoxFxUn
        AgCMvNqu/AIAAA==
X-CMS-MailID: 20221229022826epcas1p2cdc22486ee5080e220a15286cff5dbd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221226072355epcas1p102afc2f21ff427877c8b34f650f9cb97
References: <CGME20221226072355epcas1p102afc2f21ff427877c8b34f650f9cb97@epcas1p1.samsung.com>
        <PUZPR04MB6316579893496BC54C4FE96F81EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Since seekdir() does not check whether the position is valid, the
> position may exceed the size of the directory. We found that for
> a directory with discontinuous clusters, if the position exceeds
> the size of the directory and the excess size is greater than or
> equal to the cluster size, exfat_readdir() will return -EIO,
> causing a file system error and making the file system unavailable.
> 
> Reproduce this bug by:
> 
> seekdir(dir, dir_size + cluster_size);
> dirent = readdir(dir);
> 
> The following log will be printed if mount with 'errors=remount-ro'.
> 
> [11166.712896] exFAT-fs (sdb1): error, invalid access to FAT (entry
> 0xffffffff)
> [11166.712905] exFAT-fs (sdb1): Filesystem has been set read-only
> 
> Fixes: 1e5654de0f51 ("exfat: handle wrong stream entry size in
> exfat_readdir()")
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>

Looks good. Thanks.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 1122bee3b634..158427e8124e 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -100,7 +100,7 @@ static int exfat_readdir(struct inode *inode, loff_t
> *cpos, struct exfat_dir_ent
>  			clu.dir = ei->hint_bmap.clu;
>  		}
> 
> -		while (clu_offset > 0) {
> +		while (clu_offset > 0 && clu.dir != EXFAT_EOF_CLUSTER) {
>  			if (exfat_get_next_cluster(sb, &(clu.dir)))
>  				return -EIO;
> 
> --
> 2.25.1


