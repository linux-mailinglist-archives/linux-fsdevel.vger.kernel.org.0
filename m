Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217C61F3274
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 05:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgFIDDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 23:03:31 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:45172 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgFIDDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:03:30 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200609030326epoutp04cac973eb1add46170f039782f3272a35~WwRNDJCAt0381203812epoutp04e
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 03:03:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200609030326epoutp04cac973eb1add46170f039782f3272a35~WwRNDJCAt0381203812epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591671806;
        bh=BeT1xlAIijIndvT1qah/6fcb+xwbzKgECNiQabgHDn0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=czzu3JeQev+RxrVXGsmkS8NWyA59Pz7ZJSK/bOrdoF3xVmL+4RvdbA33xBOEiuv9Y
         +4RTDY/L3a2zClRRhdu+sVM+yUo1afM2UM9Ixxm3zVKxLguD6O2SQ8z7xTwodoigc2
         T3ALbZn3xlv1F2HGh38rhLMhZHjS5vZFHKUsCT1A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200609030326epcas1p38dc30484edb2a46cb38111b3cc14c47c~WwRMcn2Gn2638926389epcas1p3y;
        Tue,  9 Jun 2020 03:03:26 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49gw18399HzMqYkp; Tue,  9 Jun
        2020 03:03:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.EB.28581.AFBFEDE5; Tue,  9 Jun 2020 12:03:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200609030322epcas1p2f4b997fdf99781dfb1f7e226390285dc~WwRIl2Hnk1102811028epcas1p2Z;
        Tue,  9 Jun 2020 03:03:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200609030321epsmtrp2dddb44a265715b43fa633818d8682790~WwRIh9G_D2048820488epsmtrp2u;
        Tue,  9 Jun 2020 03:03:21 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-6f-5edefbfa2bcf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.A1.08303.9FBFEDE5; Tue,  9 Jun 2020 12:03:21 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200609030321epsmtip26dba53137516c171f2426def04db4d32~WwRIZpnWq2565825658epsmtip2C;
        Tue,  9 Jun 2020 03:03:21 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok.Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1591663760-6418-1-git-send-email-Hyeongseok@gmail.com>
Subject: RE: [PATCH] exfat: clear filename field before setting initial name
Date:   Tue, 9 Jun 2020 12:03:21 +0900
Message-ID: <000001d63e0a$88a83b50$99f8b1f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIaR7nlruHlYoYAFufzYvF3kOuM3AGb8AD6qDqfwFA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmru6v3/fiDPo/KVj8nfiJyWLP3pMs
        Fj+m1zswe+ycdZfdo2/LKkaPz5vkApijcmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgPYoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoM
        DQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMk5eLy04xF5x+vlDlgbGNrYuRk4OCQETifVzJwPZ
        XBxCAjsYJR5vWsUM4XxilJiy/SsThPOZUWLRjNXsXYwcYC0/9/tAxHcxStye9w+q/SWjxKtp
        c5lB5rIJ6Eo8ufETzBYR8JA4evcEG0gzs4CyxMovwSAmp4CLxNxpISAVwgI+Ek17J7GA2CwC
        KhJfd50Es3kFLCXOr5vKDGELSpyc+QQsziwgL7H97RxmiA8UJHZ/OsoKsclKYtnh7cwQNSIS
        szvbwJ6REHjELnHq1XdGiAYXiX+zt0E1C0u8Or6FHcKWkvj8bi80WOoldq86xQLR3MAoceTR
        QhaIhLHE/JaFzBC/aEqs36UPEVaU2Pl7LiPEYj6Jd197WCFhxSvR0SYEUaIi8f3DThaYVVd+
        XGWawKg0C8lrs5C8NgvJC7MQli1gZFnFKJZaUJybnlpsWGCCHNWbGMEpUMtiB+Pctx/0DjEy
        cTAeYpTgYFYS4a1+cCdOiDclsbIqtSg/vqg0J7X4EKMpMLAnMkuJJucDk3BeSbyhqZGxsbGF
        iZm5mamxkjjvSasLcUIC6YklqdmpqQWpRTB9TBycUg1M8+02lX/hMP+yXe3Ybrsq38ZO35PK
        r615Eh/O0hP26/0822GG6MUFG67Fz87O6/ka5/XBMH+TZtD5u2sXhE42eGsd+lJRasfN80t/
        2Tv+mr/ahmuVOJstp0uoq0Gn04eN3rqz1VPVDT+K66gw1HyVkP10JfRhTNfWd1tilhffbhO2
        mzBD9QDTPP0DhctNGJW3x7V7TIp79481/djl+7y+OS+f+vpJiZ9mZeT3TG9ftOdMkOtk3x4H
        7eOqM8L7zVZvtCg0dO+5bK/Gq7fjbuRn/fPx3urHvzzREd49Y3lF1SrTu6mTRKfWip/MarZP
        6ng+tb1/YVWBGZdr/Dv5FxwtGw/0Kc+Ivm96/UfDpuNKLMUZiYZazEXFiQDdWdGzCgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvO7P3/fiDHYvNrP4O/ETk8WevSdZ
        LH5Mr3dg9tg56y67R9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGWcvF5acIi94vTzhywNjG1s
        XYwcHBICJhI/9/t0MXJxCAnsYJSY9v82K0RcSuLgPk0IU1ji8OFiiJLnjBL3N3xh7GLk5GAT
        0JV4cuMnM4gtIuAlcXLhSRaQemYBZYmVX4Ih6qcySnx/NR9sFaeAi8TcaSEg5cICPhJNeyex
        gNgsAioSX3edBLN5BSwlzq+bygxhC0qcnPkEaqSeRNtGsK3MAvIS29/OASuREFCQ2P3pKCvE
        BVYSyw5vZ4aoEZGY3dnGPIFReBaSSbMQJs1CMmkWko4FjCyrGCVTC4pz03OLDQuM8lLL9YoT
        c4tL89L1kvNzNzGCY0BLawfjnlUf9A4xMnEwHmKU4GBWEuGtfnAnTog3JbGyKrUoP76oNCe1
        +BCjNAeLkjjv11kL44QE0hNLUrNTUwtSi2CyTBycUg1MTs90zVObol24du2sLb0yY/m9eMMp
        P/3beIRtZkVdPf+mcLdzd8TtYBP7y0x/fx4UjXxcJc9W5Z/VlZJx5fFCTW+tqXqMB516Ar58
        NKu3mBrTuHvOLHEtw5e9Mg0bV+VMU5P7LS5oYa9xe9dGgQjZ7Jdy3IYaD69d3GzFpx+Z90zQ
        MFWfr7574vndAocXHdVxCzr5znyrVaOmDY+Z6De5A8z1r1tS827ctMlhu1rms/T2MvZ7z0/O
        P5s+84Vk48WvlyqbX++7OEPh8p35b4ufXfs9p5DfgYn9paYU24XncXXPnXcd3Xd0clTbF1GZ
        +gMLHvD/DHM4Iv77zK2g+S1LE5IE7n+en1S77P+VlX8blViKMxINtZiLihMBp1irDvACAAA=
X-CMS-MailID: 20200609030322epcas1p2f4b997fdf99781dfb1f7e226390285dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609004931epcas1p3aa54bf8fdf85e021beab20d402226551
References: <CGME20200609004931epcas1p3aa54bf8fdf85e021beab20d402226551@epcas1p3.samsung.com>
        <1591663760-6418-1-git-send-email-Hyeongseok@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Some fsck tool complain that padding part of the FileName Field is not set
> to the value 0000h. So let's follow the filesystem spec.

As I know, it's specified as not "shall" but "should".
That is, it is not a mandatory for compatibility.
Have you checked it on Windows?

> 
> Signed-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
> ---
>  fs/exfat/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index de43534..6c9810b 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -424,6 +424,9 @@ static void exfat_init_name_entry(struct exfat_dentry
> *ep,
>  	exfat_set_entry_type(ep, TYPE_EXTEND);
>  	ep->dentry.name.flags = 0x0;
> 
> +	memset(ep->dentry.name.unicode_0_14, 0,
> +		sizeof(ep->dentry.name.unicode_0_14));
> +
>  	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
>  		ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
>  		if (*uniname == 0x0)
> --
> 2.7.4


