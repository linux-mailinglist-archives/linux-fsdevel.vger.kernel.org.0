Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6684EEB55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiDAKee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245329AbiDAKec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:34:32 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A722662C0
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 03:32:40 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220401103234epoutp033cb0057696ff40384cf54d263d66d0c6~hvzC44YGQ0625206252epoutp03-
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 10:32:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220401103234epoutp033cb0057696ff40384cf54d263d66d0c6~hvzC44YGQ0625206252epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648809154;
        bh=42yAgoKbStlp0tOCsXncg4kUZdgyRwCErNvhKINbR6M=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=J0+TGYGOnEhNI1kM3DF0uVpdowFD13UCYr7xemuF64WbW3txPA7L4RlJuZAteT/VA
         8idn3LcDep3ugQP4LXJAEHrGz1MoImHPa93ybhLWxsY2aoAx1Jp+bPURwNcw2NZ9pD
         SOvTxtGXdTMuUW49rgPLg1Ni5hmW5qizhh0Psx3s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220401103233epcas1p4fdf8119f4639b68a50134a18f7148b5e~hvzCT20Fa3255632556epcas1p4v;
        Fri,  1 Apr 2022 10:32:33 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.222]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KVGhJ5tGsz4x9Q2; Fri,  1 Apr
        2022 10:32:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.E6.09592.0C4D6426; Fri,  1 Apr 2022 19:32:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220401103231epcas1p17e488f48a4a5776530c6f341fe67bdf2~hvzAaBI2G1377813778epcas1p1x;
        Fri,  1 Apr 2022 10:32:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220401103231epsmtrp1166958c4507707bc3382341bc3202899~hvzAZYkf82355823558epsmtrp1c;
        Fri,  1 Apr 2022 10:32:31 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-ad-6246d4c0bcfb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.47.03370.FB4D6426; Fri,  1 Apr 2022 19:32:31 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220401103231epsmtip1d980d5a22e33ea82b8b79cb0d681d5b7~hvzANGGKJ0297802978epsmtip1A;
        Fri,  1 Apr 2022 10:32:31 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Subject: RE: [PATCH 1/2] exfat: fix referencing wrong parent directory
 information after renaming
Date:   Fri, 1 Apr 2022 19:32:31 +0900
Message-ID: <818a01d845b3$cb1a2360$614e6a20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJSbKznm5dqk7yvnouxemc+9Ari2QGAI9zYq9qMO0A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmvu6BK25JBucO6VhMnLaU2WLP3pMs
        Fpd3zWGz2PLvCKsDi8emVZ1sHn1bVjF6fN4kF8AclW2TkZqYklqkkJqXnJ+SmZduq+QdHO8c
        b2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKr
        lFqQklNgVqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsfnHLcaCK9wVm6c9YGtgXMPZxcjJISFg
        ItH26xAjiC0ksINRYvf5tC5GLiD7E6PE7aXv2CESnxklfm7w6mLkAGvY98MYomYXo0TXjJ1Q
        zS8ZJTpeWILYbAK6Ek9u/GQGqRcR0Ja4/yIdJMwsEC+xe1ofWDmnQKzEgaUrmEBsYYFkif5L
        31hAbBYBFYnX516BreUVsJRYu3AHK4QtKHFy5hMWiDnyEtvfzmGGuF9BYveno2A1IgJWEjeP
        vGGCqBGRmN3Zxgxyp4TAW3aJtnMdUA0uEre+72KEsIUlXh3fwg5hS0m87G+DspsZJZobjSDs
        DkaJpxtlIX63l3h/yQLEZBbQlFi/Sx+iQlFi5++5jBBr+STefe1hhajmlehoE4IoUZH4/mEn
        C8yiKz+uMk1gVJqF5LFZSB6bheSBWQjLFjCyrGIUSy0ozk1PLTYsMIbHc3J+7iZGcBrUMt/B
        OO3tB71DjEwcjIcYJTiYlUR4r8a6JgnxpiRWVqUW5ccXleakFh9iNAUG9URmKdHkfGAiziuJ
        NzSxNDAxMzKxMLY0NlMS51017XSikEB6YklqdmpqQWoRTB8TB6dUAxPD3TKOC4vNPz5ztdkt
        uUNNqjBN2eBo/fQZvjKFWdonzH8lh/75efbWSqeOEHZhq4jMN8eLefeVfe6f8tSSV+d+ScMm
        GZtbbx6872bS02mO7/SReyRW8O/+hj6mOQLqG3nMnzY+cvL+sfRq0ENO3eth7JZnlZTsxF+e
        tdgQm2TUff3m1IxpaqWh01i2Pef0ZNnjEvBvQWW28/SGZYLR0w6m+23eHPZ34cVXd3962Ig4
        TbnUk9BjvERZKZbl4BOumKVbj104vfiP3PxNim/tyudmz/BIZlHYcFVMIihQzabWQ1x2Xs08
        HolPx76yehs/rSq/Hq2Xd90vP+3Fi0eJJx+c3dnHnS2zZqGDA7P4ESWW4oxEQy3mouJEAHMo
        pjoMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSnO7+K25JBttX61tMnLaU2WLP3pMs
        Fpd3zWGz2PLvCKsDi8emVZ1sHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJWx+cctxoIr3BWb
        pz1ga2Bcw9nFyMEhIWAise+HcRcjF4eQwA5GibN7fzNDxKUkDu7ThDCFJQ4fLoYoeQ5Ucv0P
        WxcjJwebgK7Ekxs/wcpFBLQl7r9IBwkzCyRKNH+5xARiCwmsY5T48NUUxOYUiJU4sHQFWFwY
        qObU9zOsIDaLgIrE63Ov2EFsXgFLibULd7BC2IISJ2c+YYGYqS3R+7CVEcKWl9j+dg4ziC0h
        oCCx+9NRsHoRASuJm0feMEHUiEjM7mxjnsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OL
        DQuM8lLL9YoTc4tL89L1kvNzNzGCo0JLawfjnlUf9A4xMnEwHmKU4GBWEuG9GuuaJMSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANTGm9mqgm3mLebm8q9
        z1rLMmT+5ecy8HywqV4hy8YpeDFsYWjfx6I3YfN/mnIazPPVtP4o6pAbsFV7kVqdMK9xxsre
        til7V1/d9cWiQFzncGzksbUG/R6F0ls3R94K919qGpBnxsaUrXstWTuVnbny0PPMX5fj/s7m
        mqn/eXvV0yxRDo6QT3KvU8Or80/EnMtMuGTLuH6/4fSZrqa20g8escwp9lNjl5CMfXv3oxB7
        Ynby9xQd513VN6e9v2Sfeu37z87n2tfywm8WnAxblJXu3CRoqiWcV890eNpK/uodW+5NOfTU
        1meGz8U/Ajv838TMejPxd3CR9Zezs6SMtHaEtPzdwhnygU/Be7reeSWW4oxEQy3mouJEAP2a
        7e/5AgAA
X-CMS-MailID: 20220401103231epcas1p17e488f48a4a5776530c6f341fe67bdf2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220325094229epcas1p194e9008627d718a444253c1c7e58b2b8
References: <CGME20220325094229epcas1p194e9008627d718a444253c1c7e58b2b8@epcas1p1.samsung.com>
        <HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> During renaming, the parent directory information maybe updated. But the
> file/directory still references to the old parent directory information.
> 
> This bug will cause 2 problems.
> 
> (1) The renamed file can not be written.
> 
>     [10768.175172] exFAT-fs (sda1): error, failed to bmap (inode : 7afd50e4
> iblock : 0, err : -5)
>     [10768.184285] exFAT-fs (sda1): Filesystem has been set read-only
>     ash: write error: Input/output error
> 
> (2) Some dentries of the renamed file/directory are not set
>     to deleted after removing the file/directory.
> 
> fixes: 5f2aa075070c ("exfat: add inode operations")
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>

Looks good!
Thanks for your patch!
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/namei.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index
> a02a04a993bf..e7adb6bfd9d5 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -1080,6 +1080,7 @@ static int exfat_rename_file(struct inode *inode,
> struct exfat_chain *p_dir,
> 
>  		exfat_remove_entries(inode, p_dir, oldentry, 0,
>  			num_old_entries);
> +		ei->dir = *p_dir;
>  		ei->entry = newentry;
>  	} else {
>  		if (exfat_get_entry_type(epold) == TYPE_FILE) {
> --
> 2.25.1

