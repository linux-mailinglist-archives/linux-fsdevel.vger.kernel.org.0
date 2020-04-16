Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771E61AB816
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 08:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408080AbgDPGew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 02:34:52 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58379 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407924AbgDPGep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:34:45 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200416063438epoutp0473b2562883443794f0a03161b9b82e1b~GOUMHz6cV2081920819epoutp04g
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 06:34:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200416063438epoutp0473b2562883443794f0a03161b9b82e1b~GOUMHz6cV2081920819epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587018878;
        bh=ypbsvyhjVcYP3b7mJXEBHON652dLD6LimgwxQLEbcVg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rtGQAc6KaLvW+YsdH2BqVy2f+H0q97O7WSiuOk59Ko9pKwl8oYr0lHc4fLcJ9uNa5
         PnlIMlL11oGvBRomJzRlA+6h/hlsTGJhhEoRiUBNpjERS2LGXKtWQ2aQCzYD4WJWrO
         GZbUtdqlXwBO2DZdZZL3fJ65SpXD9H/btmyvI9aE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200416063438epcas1p19ed71eb6f5562220caa12ba0c522daaf~GOUL2lWLk1555415554epcas1p1m;
        Thu, 16 Apr 2020 06:34:38 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 492qFn2THczMqYkp; Thu, 16 Apr
        2020 06:34:37 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.E2.04402.A7CF79E5; Thu, 16 Apr 2020 15:34:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200416063434epcas1p3465ee3316a5d55ab11cfe6d056cd4825~GOUHt8b3c2907429074epcas1p3I;
        Thu, 16 Apr 2020 06:34:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200416063434epsmtrp121f998f476051f5253b7296bd7dddb3c~GOUHs3KOH2862128621epsmtrp11;
        Thu, 16 Apr 2020 06:34:34 +0000 (GMT)
X-AuditID: b6c32a35-76bff70000001132-53-5e97fc7a9dab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.4A.04158.97CF79E5; Thu, 16 Apr 2020 15:34:33 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200416063433epsmtip22dd791dee7908fa564fb4d2b9b37af0b~GOUHgt-mx1229512295epsmtip2d;
        Thu, 16 Apr 2020 06:34:33 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Jason Yan'" <yanaijie@huawei.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20200414120225.35540-1-yanaijie@huawei.com>
Subject: RE: [PATCH] exfat: remove the assignment of 0 to bool variable
Date:   Thu, 16 Apr 2020 15:34:33 +0900
Message-ID: <003f01d613b9$17864000$4692c000$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHfREGer/8Wwi5J5+kbn3sveF3gFwD0yP6kqGFCiRA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTV7fqz/Q4g1fHxS327D3JYnF51xw2
        iy3/jrBaLNrTyezA4tFy5C2rR9+WVYwenzfJBTBH5dhkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZJx+O4Gp4DBbxdFjyxkbGKexdjFycEgI
        mEjsuqDTxcjFISSwg1Hi0qz3bBDOJ0aJxdcWMEM43xglms6uAXI4wTp27H7PApHYyygx5+tR
        KOclo8TPya9ZQKrYBHQl/v3ZzwZiiwioS7SvvckOYjMLxEss3nEcLM4pYCkx99gusHphAXeJ
        WzvXMoHYLAKqEq8eHmEEsXmBaiY1XGKHsAUlTs58wgIxR15i+9s5UBcpSPx8uowVYpeVxMdT
        cxkhakQkZne2gb0gIXCCTaJz2jFGiAYXiW2/P7ND2MISr45vgbKlJF72t7FDAqZa4uN+qPkd
        jBIvvttC2MYSN9dvAIcds4CmxPpd+hBhRYmdv2HW8km8+9oDDV5eiY42IYgSVYm+S4eZIGxp
        ia72D+wTGJVmIXlsFpLHZiF5YBbCsgWMLKsYxVILinPTU4sNCwyR43oTIzghapnuYJxyzucQ
        owAHoxIPr8HLaXFCrIllxZW5hxglOJiVRHh3+E+PE+JNSaysSi3Kjy8qzUktPsRoCgz3icxS
        osn5wGSdVxJvaGpkbGxsYWJmbmZqrCTOO/V6TpyQQHpiSWp2ampBahFMHxMHp1QDY9H9zDNm
        2vWGexbm5tnKqEu8UVGJ7yxOcqvxCmuqYj7s7cEjePkHw+EzCU96ZKL1y7vfGGjGh3yWO3fp
        V0bIzDsHWTLW70tincut5/Vtup/7/8Jd/2fuXmKsf/F48M7v5kuOhrK/2LxL4KTYxAdxec/+
        yHycYnC++G5/vO6jN3bqp2Wi7j0SVWIpzkg01GIuKk4EAD4pbHeeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvG7ln+lxBv8Xm1ns2XuSxeLyrjls
        Flv+HWG1WLSnk9mBxaPlyFtWj74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mo4/XYCU8Fhtoqj
        x5YzNjBOY+1i5OSQEDCR2LH7PUsXIxeHkMBuRom7j09DJaQljp04w9zFyAFkC0scPlwMUfOc
        UaJ/zTFGkBo2AV2Jf3/2s4HYIgLqEu1rb7KD2MwCiRJnlrSxQjR0MUrsmNYINpRTwFJi7rFd
        LCC2sIC7xK2da5lAbBYBVYlXD4+ADeUFqpnUcIkdwhaUODnzCQvIEcwCehJtGxkh5stLbH87
        hxniTgWJn0+XsULcYCXx8dRcqBoRidmdbcwTGIVnIZk0C2HSLCSTZiHpWMDIsopRMrWgODc9
        t9iwwCgvtVyvODG3uDQvXS85P3cTIzgytLR2MJ44EX+IUYCDUYmHt+P1tDgh1sSy4srcQ4wS
        HMxKIrw7/KfHCfGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCU
        amBU+jRXk01edUPEi9xpH5z15bN3ztPeseVqwo6X2YF2vV1vgzvXNL7/Zuiv9WDquhWbZWxS
        Jn3vUtF5KissrXg1hXveg/q6X4mW751OdH07IO4syfFvLQvr9iese24L65i914u6tsW6MWHC
        Crc7K1bdlhJY4acU4amnfqKR+bn29Fv/JJN8vr1XYinOSDTUYi4qTgQAnm1OdIgCAAA=
X-CMS-MailID: 20200416063434epcas1p3465ee3316a5d55ab11cfe6d056cd4825
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200414113819epcas1p4eafa861bec639fcdcb931fb68c1086ce
References: <CGME20200414113819epcas1p4eafa861bec639fcdcb931fb68c1086ce@epcas1p4.samsung.com>
        <20200414120225.35540-1-yanaijie@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> There is no need to init 'sync' in exfat_set_vol_flags().
> This also fixes the following coccicheck warning:
> 
> fs/exfat/super.c:104:6-10: WARNING: Assignment of 0/1 to bool variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
Pushed it to exfat dev.

Thanks for your patch!
> ---
>  fs/exfat/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index
> 16ed202ef527..b86755468904 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -101,7 +101,7 @@ int exfat_set_vol_flags(struct super_block *sb,
> unsigned short new_flag)  {
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct pbr64 *bpb;
> -	bool sync = 0;
> +	bool sync;
> 
>  	/* flags are not changed */
>  	if (sbi->vol_flag == new_flag)
> --
> 2.21.1


