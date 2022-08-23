Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E727959CF7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 05:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiHWD1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 23:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbiHWD1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:27:01 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EDE5C9DB
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 20:26:55 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220823032648epoutp01126bb622addf37adf5038ab8e692c7d8~N24ap61sv1360313603epoutp01f
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 03:26:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220823032648epoutp01126bb622addf37adf5038ab8e692c7d8~N24ap61sv1360313603epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661225209;
        bh=wu3Cnj8Fp1juOHjYlwRWg41SHZwT1ZvVX893xsYvjpk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=loPdNlyJBzQgOShW1FTWT0EDmOHvt1KTj+UqqvnVy+wzMTPpwE8KOWQOKiKZ5Zj0o
         hyj4IDK/SdVYfcZ8rf+TEWOP/6EnQaWTlRHybUdff3bfaVF/s40BTnHuYHd6ltdeOX
         41jFFNfxW3x0Y92WVWW3hOL9PajPMa2gOKIG15bI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220823032648epcas1p3a531fdeabb31319f6d9c9b444a925f48~N24aYfTzz1314613146epcas1p3Y;
        Tue, 23 Aug 2022 03:26:48 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.250]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MBZQc2WX3z4x9Q0; Tue, 23 Aug
        2022 03:26:48 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.51.18616.8F844036; Tue, 23 Aug 2022 12:26:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220823032647epcas1p4494b5b8db3c800e3393733a74213a0b7~N24Zq-Rz90558005580epcas1p4o;
        Tue, 23 Aug 2022 03:26:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220823032647epsmtrp2ac63c6a93b52b20af52fbaf596adc47b~N24ZqaJpC3037730377epsmtrp25;
        Tue, 23 Aug 2022 03:26:47 +0000 (GMT)
X-AuditID: b6c32a38-6cfff700000048b8-59-630448f83197
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.53.14392.7F844036; Tue, 23 Aug 2022 12:26:47 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823032647epsmtip165c1a86d97c7868116895cc255f83ffa~N24Zg5SHs2501825018epsmtip1G;
        Tue, 23 Aug 2022 03:26:47 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <PUZPR04MB63161D3BE9104FF48BD298DE81719@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH] exfat: fix overflow for large capacity partition
Date:   Tue, 23 Aug 2022 12:26:47 +0900
Message-ID: <55c001d8b6a0$2d1ce2c0$8756a840$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQG6AHnoKzk4PaiInYFNxiio1tIcSQKsUsP/rePcS3A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmnu4PD5ZkgzNt/BYTpy1lttiz9ySL
        xeVdc9gcmD02repk8/i8SS6AKaqB0SaxKDkjsyxVITUvOT8lMy/dVik0xE3XQkkhI7+4xFYp
        2tDQSM/QwFzPyMhIz9gy1srIVEkhLzE31VapQheqV0mhKLkAqDa3shhoQE6qHlRcrzg1L8Uh
        K78U5DC94sTc4tK8dL3k/FwlhbLEnFKgEUr6Cd8YM74uOc1eMJuz4u6O6AbG7exdjJwcEgIm
        EhOb/rOA2EICOxglmpcmdTFyAdmfGCU23P/NBOF8A0os2sQK0/H33htWiMReRomvjy6wQzgv
        GSXW//7KBlLFJqAr8eTGT+YuRg4OEQFtifsv0kHCzAIZEhtnfgBbzSkQK/Hi9RqwocICrhLv
        nu5iBrFZBFQlJq1uAIvzClhKnGk4zg5hC0qcnPmEBWKOvMT2t3OYIQ5SkNj96ShYvYiAlUTb
        vn9MEDUiErM725hBbpMQuMcusbftCBtEg4vEhJXboWxhiVfHt0DDQkri87u9UPFuRok/53gh
        micwSrTcOQv1vrHEp8+fGUEeYxbQlFi/Sx8irCix8/dcRghbUOL0tW5miCP4JN597WEFKZcQ
        4JXoaBOCKFGR+P5hJ8sERuVZSF6bheS1WUhemIWwbAEjyypGsdSC4tz01GLDAhPk6N7ECE6U
        WhY7GOe+/aB3iJGJg/EQowQHs5IIb/VFhmQh3pTEyqrUovz4otKc1OJDjMnAwJ7ILCWanA9M
        1Xkl8YYmxgYGRsBUaG5pbkyEsKWBiZmRiYWxpbGZkjivnjZjspBAemJJanZqakFqEcwWJg5O
        qQam+cc/fQw9UZDKttG4+0r7xPefJ+3nTmezfL6UuYHr1IWUJ2nR105sNpwYw8z5MS/jw7rz
        7RE1lZVrMlmzj6R2S//KWB3F3LN+ZcRvebeLfA4TeP8KbyhPirGNPdUh6nfxyuc0xi8n04QT
        9Zz86i9N8v1Ry3fKXulWyKYNxx7qFa7iyn+7+fLWO2FBy0JXihcKHbzq4rPYIe2G8k+dhZwH
        Jge4i+78kd22JcEm9Py/ydurfpW03ly6xtiwK7e14/CFr9M3Z5/kC9x4XONUptiMDVx7GtZd
        Tr17h1lIeMv+KbFBYs4ey+5UtM6aojE9vfXOBp+i0+nSrz+/k9hmOr05bPeTd6s9GTacnjr7
        9LU3d5RYijMSDbWYi4oTAfBCPPVLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnO53D5ZkgzdbTSwmTlvKbLFn70kW
        i8u75rA5MHtsWtXJ5vF5k1wAUxSXTUpqTmZZapG+XQJXxtclp9kLZnNW3N0R3cC4nb2LkZND
        QsBE4u+9N6wgtpDAbkaJb72KXYwcQHEpiYP7NCFMYYnDh4u7GLmAKp4zSty51MAMUs4moCvx
        5MZPZpAaEQFtifsv0kHCzAIZErN2bGGDqF/HKPFz30GwVZwCsRIvXq8BWyUs4Crx7ukusDks
        AqoSk1Y3gMV5BSwlzjQcZ4ewBSVOznzCAjFUW6L3YSsjhC0vsf3tHGaI8xUkdn86CtYrImAl
        0bbvHxNEjYjE7M425gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4
        NC9dLzk/dxMjOAK0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe6osMyUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwnT5a82+fy4IbWT/uPjNbl+w5f9G0rUKb
        ViivXm0R/S9CavrSSBHXZSabq6O6IzYkabP+m/FMOrRQ5NeKyUvclBeZa6r0/qwMOpzaOefJ
        2ZMSN88eDnqnXHfuU8uhvY7LV9/cv/TzRIUH/acT+74JhwprZr+LtRGbZRXD8PSGg9u1+ZYz
        nK0clBdz95X2fz5S2SdoxSGRmHfedoOqbKz/Ekv5r6rKj/9tvFH/xHvnmjD9VquY6E//8lb+
        +Xu0+OznOEYhfUcWNrN6Zr4Isfc8lRffnnU+8ss0TO23wjuLK5mzl0f9CL2z4NbKDfb7Lp01
        d7l6cA3THGvBwrtLgzXLbh79dtXvjavHrgS9B3lWkkosxRmJhlrMRcWJAMG7oFDvAgAA
X-CMS-MailID: 20220823032647epcas1p4494b5b8db3c800e3393733a74213a0b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220822022538epcas1p1466d16f6f21532d35b0b2caed3079ef6
References: <CGME20220822022538epcas1p1466d16f6f21532d35b0b2caed3079ef6@epcas1p1.samsung.com>
        <PUZPR04MB63161D3BE9104FF48BD298DE81719@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Using int type for sector index, there will be overflow in a large
> capacity partition.
> 
> For example, if storage with sector size of 512 bytes and partition
> capacity is larger than 2TB, there will be overflow.
> 
> Fixes: 1b6138385499 ("exfat: reduce block requests when zeroing a cluster")
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>

Looks good!
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> 
> ---
>  fs/exfat/fatent.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c index
> ee0b7cf51157..41ae4cce1f42 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -270,8 +270,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned
> int clu)
>  	struct super_block *sb = dir->i_sb;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct buffer_head *bh;
> -	sector_t blknr, last_blknr;
> -	int i;
> +	sector_t blknr, last_blknr, i;
> 
>  	blknr = exfat_cluster_to_sector(sbi, clu);
>  	last_blknr = blknr + sbi->sect_per_clus;
> --
> 2.25.1


