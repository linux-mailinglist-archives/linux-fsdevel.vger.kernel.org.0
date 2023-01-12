Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411A66670D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 12:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjALL0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 06:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjALLZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:25:21 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0D2F08
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 03:15:14 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230112111512epoutp01b3b76d2ee8d650f7b719e32fcc6addaf~5i36mPifq0797207972epoutp011
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 11:15:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230112111512epoutp01b3b76d2ee8d650f7b719e32fcc6addaf~5i36mPifq0797207972epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673522112;
        bh=jIM7dQctGOHeg2tzdodYlSVJ+2w2J1xh6J97G5q1E44=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WzcJ5bIRR3tUYiWZ9UL8n06eg3WfsKMRcXexIQdNuNG6LiKiS0YmBMZ6T89cjjqu9
         N3hc2K2/GFQ+QhropPMc2SZuHJDa0HyYH7muVfkp+9FtctqJR6bWA7AFZsKOJQCM2e
         nwR2vfE+O8PNMigihez/E8GAp0tgcTXv4kY8StRs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230112111512epcas1p44e925d5c84445b6a2af4df9d958d65b0~5i36LuYT71959419594epcas1p4M;
        Thu, 12 Jan 2023 11:15:12 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.227]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Nt25X0bPyz4x9Pv; Thu, 12 Jan
        2023 11:15:12 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.7E.38305.FBBEFB36; Thu, 12 Jan 2023 20:15:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230112111511epcas1p1ca8831de7d7e8f9b538c6073d4b96af5~5i35smKwg0767107671epcas1p1a;
        Thu, 12 Jan 2023 11:15:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230112111511epsmtrp2b02ce91decab10ad412df3b607cbb392~5i35r9Qgq0191201912epsmtrp23;
        Thu, 12 Jan 2023 11:15:11 +0000 (GMT)
X-AuditID: b6c32a36-1fdff700000095a1-c0-63bfebbf738c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.43.02211.FBBEFB36; Thu, 12 Jan 2023 20:15:11 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230112111511epsmtip2ab900dbb8a3e5607938ffe8e482ba6cf~5i35jVtwc2320323203epsmtip2N;
        Thu, 12 Jan 2023 11:15:11 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Cc:     <sj1557.seo@samsung.com>,
        =?utf-8?Q?'Bar=C3=B3csi_D=C3=A9nes'?= <admin@tveger.hu>
In-Reply-To: <20230111135630.8836-1-linkinjeon@kernel.org>
Subject: RE: [PATCH] exfat: handle unreconized benign secondary entries
Date:   Thu, 12 Jan 2023 20:15:11 +0900
Message-ID: <000501d92677$2305d9d0$69118d70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJ/fUOQxXr4B+CiiL7NTM/JGh50ZwIRQPNYrT1joxA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOJsWRmVeSWpSXmKPExsWy7bCmvu7+1/uTDdQtrrx7zWYxcdpSZos9
        e0+yWGz5d4TVgcVj06pONo++LasYPd4tmMDi8XmTXABLVAOjTWJRckZmWapCal5yfkpmXrqt
        UmiIm66FkkJGfnGJrVK0oaGRnqGBuZ6RkZGesWWslZGpkkJeYm6qrVKFLlSvkkJRcgFQbW5l
        MdCAnFQ9qLhecWpeikNWfinIlXrFibnFpXnpesn5uUoKZYk5pUAjlPQTGpkzdj0/zlKwg6vi
        xPKzjA2M/RxdjJwcEgImEo+O/WHrYuTiEBLYwShxt+kZK4TziVGiacoBRgjnG6PEzhfd7DAt
        bS+eQFXtZZR4/OsWlPOSUaL1SQ9YFZuArsSTGz+ZQWwRAR+JKV/+g8WZBcIlmr6uYgOxOQWs
        JP4d/sAEYgsLuEtM624Cq2cRUJVY+X4nWD2vgKXE1NXtjBC2oMTJmU9YIObIS2x/O4cZ4iIF
        id2fjrJC7LKSmPf1JRNEjYjE7M42ZpDjJAR+skssu/ScEaLBReJxXyfUO8ISr45vgbKlJD6/
        28sG0dDNKHH84zsWiMQMRoklHQ4Qtr1Ec2szUBEH0AZNifW79CHCihI7f8+Fmi8ocfpaNzPE
        EXwS7772sIKUSwjwSnS0CUGUqEh8/7CTZQKj8iwkr81C8tosJC/MQli2gJFlFaNYakFxbnpq
        sWGBEXKMb2IEJ1Itsx2Mk95+0DvEyMTBeIhRgoNZSYR3z9H9yUK8KYmVValF+fFFpTmpxYcY
        JzICQ3sis5Rocj4wmeeVxBuamVlaWBqZGBqbGRoSFjYxNjAwAqZbc0tzYyKELQ1MzIxMLIwt
        jc2UxHltItYlCwmkJ5akZqemFqQWwRzFxMEp1cCkWX2kVt9V0y1rJt+dl39+26T0vN6rodAj
        sCcuO8zh05ZVKy83rDZQiOnZPl2zrFFJcZPmyeRr0eclnmw5V3jnnKPVKc7zeqkvDgTd7BPi
        Nu++FjRl3+V/2jtZN8j/93RP3b1Zd3XcgqN6fg07G2+nhj41W//cXu/qT6VDL9e2PL8hF/lA
        /NYxyYCUqtnTXY83Grx7++KXtfqhBb/VNLZ1Bu5PSFQuVElYt+SM1vcHkksWc+g+23CJ+8/n
        YA6x++d0D9/RXXtoyipJn9PKfyVfMcnckzK7H80odv18//MCvXR+W7mY5VkS1unWD/xPX40P
        3jf/tOMLzzK7CzN57tTvv3mNu2GtRUKJnt3iXRcmKrEUZyQaajEXFScCAMBy/4+KBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvO7+1/uTDW4uVba48u41m8XEaUuZ
        LfbsPcliseXfEVYHFo9NqzrZPPq2rGL0eLdgAovH501yASxRXDYpqTmZZalF+nYJXBm7nh9n
        KdjBVXFi+VnGBsZ+ji5GTg4JAROJthdPWLsYuTiEBHYzSvw4d4q5i5EDKCElcXCfJoQpLHH4
        cDFEyXNGidkdN1hAetkEdCWe3PjJDGKLCPhJXD51ECzOLBAuserkbTYQW0igm1Fi5nRpEJtT
        wEri3+EPTCC2sIC7xLTuJrBeFgFViZXvd7KD2LwClhJTV7czQtiCEidnPoGaqS3x9OZTKFte
        YvvbOcwQ9ytI7P50lBXiBiuJeV9fMkHUiEjM7mxjnsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVT
        C4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCY0RLcwfj9lUf9A4xMnEwHmKU4GBWEuHdc3R/
        shBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MPf8qGvsW
        X4+eoPLq5ZLbLmcPlPbNWDeRgz3g8/kJC6c8Ft4x5/vGrcdzWhrKHtv0GsabW7SXNHCXb2C9
        UXLSJfdYn/CDM352DXtqzRkboyJ+M7mdf3rDdplI5SO7y5Z3b/WZLpltX9dTJVVoXH10Q/qj
        R8u+qgrU52+Inb+x5NuDuBXfKtiWuoXebTxQOdF98rr4v+0xUZleFSkrJx9mqM9qi5177Ob3
        vdu8D8u8LjCd9bKA7csZ1mer1aLbLhkmzsvJYX90rKxggv3KdvcDb/O6RQwzT01Y8mPZtKB9
        DLuiFML1byUG8G/xbmW5KxDN0aDgP/e0i4vx/CsKOkc5IsRmxXea3f326+RrnZA5SizFGYmG
        WsxFxYkAorTuOQADAAA=
X-CMS-MailID: 20230112111511epcas1p1ca8831de7d7e8f9b538c6073d4b96af5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230111135745epcas1p19a027cb2092e0fe3a05457ff52a6c75c
References: <CGME20230111135745epcas1p19a027cb2092e0fe3a05457ff52a6c75c@epcas1p1.samsung.com>
        <20230111135630.8836-1-linkinjeon@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -567,12 +579,30 @@ int exfat_remove_entries(struct inode *inode, struct
> exfat_chain *p_dir,
>  	int i;
>  	struct exfat_dentry *ep;
>  	struct buffer_head *bh;
> +	int type;
> 
>  	for (i = order; i < num_entries; i++) {
>  		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh);
>  		if (!ep)
>  			return -EIO;
> 
> +		type = exfat_get_entry_type(ep);
> +		if (type & TYPE_BENIGN_SEC) {
> +			struct exfat_chain dir;
> +			unsigned int start_clu =
> +				le32_to_cpu(ep-
> >dentry.generic_secondary.start_clu);
> +			u64 size = le64_to_cpu(ep-
> >dentry.generic_secondary.size);
> +			unsigned char flags = ep-
> >dentry.generic_secondary.flags;
> +
> +			if (!(flags & ALLOC_FAT_CHAIN) || !start_clu || !size)
> +				continue;

Oops, this BENIGN_SECONDARY entry should be removed regardless of
its cluster allocation.

> +
> +			exfat_chain_set(&dir, start_clu,
> +					EXFAT_B_TO_CLU_ROUND_UP(size,
> EXFAT_SB(sb)),
> +					flags);
> +			exfat_free_cluster(inode, &dir);
> +		}
> +
>  		exfat_set_entry_type(ep, TYPE_DELETED);
>  		exfat_update_bh(bh, IS_DIRSYNC(inode));
>  		brelse(bh);
> @@ -741,6 +771,7 @@ enum exfat_validate_dentry_mode {
>  	ES_MODE_GET_STRM_ENTRY,
>  	ES_MODE_GET_NAME_ENTRY,
>  	ES_MODE_GET_CRITICAL_SEC_ENTRY,
> +	ES_MODE_GET_BENIGN_SEC_ENTRY,
>  };
> 

