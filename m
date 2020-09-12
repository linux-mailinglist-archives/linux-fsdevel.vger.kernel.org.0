Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A709B2677F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 07:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgILFBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 01:01:37 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19832 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgILFBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 01:01:30 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200912050127epoutp045a55a30b4b9f0aba63e85e9bb0beec73~z8KWsln1s2205122051epoutp04-
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2020 05:01:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200912050127epoutp045a55a30b4b9f0aba63e85e9bb0beec73~z8KWsln1s2205122051epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599886887;
        bh=AxBVPTU8AbLYZzSkcTnTQ4nud6bHkJME3V0iWvSIZ0s=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=M9PFk++UmUkkB70ID/epHztma/UTXKiPkLMEQmeXDi/UOp/2fzWXcX9FQ0y9Oc0qT
         xCISOChvRuIoBXT9IpbMfd9Sj1NTh8D96+PfkTld5he1VoZCeb5zghdCUDikqeReGi
         Yqv/O60xRCIXNwTf9Ak6w87ppvreHDHEi55SI7VA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200912050126epcas1p22456b7eba3010425a120bf3e5df29ffe~z8KWXeH9J2866828668epcas1p2_;
        Sat, 12 Sep 2020 05:01:26 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BpL7T22XFzMqYkY; Sat, 12 Sep
        2020 05:01:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.DE.20696.5265C5F5; Sat, 12 Sep 2020 14:01:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200912050124epcas1p16bf94dde8d7bcd82eddda68f26f583d1~z8KUmtnkz0136601366epcas1p1N;
        Sat, 12 Sep 2020 05:01:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200912050124epsmtrp1b5d1ee4f6ffb0a60ce93460743f3b3d0~z8KUmC2Qn2868328683epsmtrp1D;
        Sat, 12 Sep 2020 05:01:24 +0000 (GMT)
X-AuditID: b6c32a39-ed5ff700000050d8-46-5f5c56254fd4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.0D.08303.4265C5F5; Sat, 12 Sep 2020 14:01:24 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200912050124epsmtip154c97b341ad7ce0878606dfa0d3a735d~z8KUVhNTk2844028440epsmtip1O;
        Sat, 12 Sep 2020 05:01:24 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200909075652.11203-1-kohada.t2@gmail.com>
Subject: RE: [PATCH] exfat: remove 'rwoffset' in exfat_inode_info
Date:   Sat, 12 Sep 2020 14:01:23 +0900
Message-ID: <000001d688c1$c329cad0$497d6070$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMi4/VQwbYo/U4C9ybSoLj7f91ObgIeTeE0prrBLkA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmvq5qWEy8wZM3XBY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwReXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0
        MDAyBapMyMm48bqLteASR8XEhjamBsZnbF2MnBwSAiYST1ZvYu5i5OIQEtjBKDHnyVNGCOcT
        o8Tdb4eYIJzPjBITLl4GynCAtVy6qgMR38Uo8aNpLVT7S0aJM70HWUHmsgnoSjy58ZMZxBYR
        0JM4efI62D5mgUYmiRMvs0FsTgFLie8fDrKD2MICjhK/2u+B1bMIqErsP9gNFucFqpn56RGU
        LShxcuYTFog58hLb385hhvhBQWL3p6OsELusJLb09zBB1IhIzO5sg6qZySHRtskLwnaR6N+9
        jBHCFpZ4dXwLO4QtJfGyvw3Krpf4P38tO8hjEgItjBIPP21jgvjeXuL9JQsQk1lAU2L9Ln2I
        ckWJnb/nMkKs5ZN497WHFaKaV6KjTQiiRAXo250sMJuu/LjKNIFRaRaSx2YheWwWkgdmISxb
        wMiyilEstaA4Nz212LDAFDmuNzGCU6mW5Q7G6W8/6B1iZOJgPMQowcGsJMKblB8ZL8SbklhZ
        lVqUH19UmpNafIjRFBjUE5mlRJPzgck8ryTe0NTI2NjYwsTM3MzUWEmc9+EthXghgfTEktTs
        1NSC1CKYPiYOTqkGphw/ldifQpq6z557f9Bqu8Ec8EIh5yL77WVPFxzY/rkg+EZz7PzL99Xf
        uq1wsmEvWfeUc5rqBsMoLqeDvwVe/FGQ2GE4VXl9aNTskCSNAMGjr1+kbrqztLuquko5enXA
        6pU8X8vfCB+X8Vuo/KgmWC7xR/Bc8/yWVJMDEieXn3pr9j7upcwdz5Ip+5/eKXFrLNnDxraB
        T3WD5Gnd2kSmkxnbNh7QDVEMvbUvsG2N3Su5yw8EgrImTNzZ1ZNSavqs07XmrIBNX3p3fecH
        Cf2jt/9u3vz0T6WexdE7O3YsVZi79rqkUECMyL/j0p/m9Ivu+M1xVbxj2ruM+UufVqU+Yoh7
        9d3P33aNydPpRnbHQpVYijMSDbWYi4oTAUocaNQuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTlclLCbe4MIBJYsfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLH5Mr3dg9/gy5zi7R9vkf+wezcdWsnnsnHWX3aNvyypG
        j8+b5ALYorhsUlJzMstSi/TtErgybrzuYi24xFExsaGNqYHxGVsXIweHhICJxKWrOl2MXBxC
        AjsYJa6vWsEKEZeSOLhPE8IUljh8uBii5DmjxPrWqexdjJwcbAK6Ek9u/GQGsUUE9CROnrzO
        BlLELNDMJNH6pZkJoqOLUWLNGRCHk4NTwFLi+4eDYN3CAo4Sv9rvgXWzCKhK7D/YDRbnBaqZ
        +ekRlC0ocXLmExaQK5iBNrRtZAQJMwvIS2x/OwesVUJAQWL3p6OsEEdYSWzp72GCqBGRmN3Z
        xjyBUXgWkkmzECbNQjJpFpKOBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgiNK
        S2sH455VH/QOMTJxMB5ilOBgVhLhTcqPjBfiTUmsrEotyo8vKs1JLT7EKM3BoiTO+3XWwjgh
        gfTEktTs1NSC1CKYLBMHp1QDk4six4JHxwSW6f+fG5Q5f/r2LP3Xeza8ZCk5v7c3uODBl+o3
        PomVbk4fWRbeM+OM8u+ykZP22OJi1Jkz60e1Z9BtHd/ZSu3hGRsbjv45rrRgWaYJX1vbvdVf
        /765PrPyrt/RyKOVH1gcvC5lbS45/cs80ZTpV0OQSGvyD+PSqlrptq2R30/9XZ3J5LG42iXe
        cTWX8poJV0/Gpgt6OTfsW9XfHPqjd8rXpg0TD3zMtlnjdqj+ceSDd74VYTv7FzSdPhnDabJ3
        9eqJoiuXz576Y/MTq3N9x6znrdrTvpH1Po9F9/kgbS+2/s06uz8K3tLO22rxyfcp++Nlpccj
        LE7E1l5SZHcvO3XCa5Wst/rHE0osxRmJhlrMRcWJAOy826EXAwAA
X-CMS-MailID: 20200912050124epcas1p16bf94dde8d7bcd82eddda68f26f583d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200909075713epcas1p44c2503251f78baa2fde0ce4351bf936d
References: <CGME20200909075713epcas1p44c2503251f78baa2fde0ce4351bf936d@epcas1p4.samsung.com>
        <20200909075652.11203-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Remove 'rwoffset' in exfat_inode_info and replace it with the
> parameter(cpos) of exfat_readdir.
> Since rwoffset of  is referenced only by exfat_readdir, it is not
> necessary a exfat_inode_info's member.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/dir.c      | 16 ++++++----------
>  fs/exfat/exfat_fs.h |  2 --
>  fs/exfat/file.c     |  2 --
>  fs/exfat/inode.c    |  3 ---
>  fs/exfat/super.c    |  1 -
>  5 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> a9b13ae3f325..fa5bb72aa295 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
[snip]
> sector @@ -262,13 +260,11 @@ static int exfat_iterate(struct file *filp,
> struct dir_context *ctx)
>  		goto end_of_dir;
>  	}
> 
> -	cpos = EXFAT_DEN_TO_B(ei->rwoffset);
> -
>  	if (!nb->lfn[0])
>  		goto end_of_dir;
> 
>  	i_pos = ((loff_t)ei->start_clu << 32) |
> -		((ei->rwoffset - 1) & 0xffffffff);
> +		(EXFAT_B_TO_DEN(cpos-1) & 0xffffffff);

Need to fix the above line to be:
(EXFAT_B_TO_DEN(cpos)-1)) & 0xffffffff);

