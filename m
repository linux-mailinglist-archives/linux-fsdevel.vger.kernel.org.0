Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B236A52D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 07:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjB1GLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 01:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1GLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:11:54 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEFD24494
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 22:11:51 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230228061149epoutp02aff611f26c6381d8a0b1a15d798d22c5~H6DclVxVJ1555615556epoutp02t
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 06:11:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230228061149epoutp02aff611f26c6381d8a0b1a15d798d22c5~H6DclVxVJ1555615556epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677564709;
        bh=tgj5+HikYBEGw+YbqWyCVeNBWAXjIBrB5hQQHKNaDEk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=OHkP3c6PNy1A/4Sx0BAj0MH7HVkzZGOprGkVkaMmogR+lsZM7AVgN0GZAdseqcgea
         lPFJunBZUAUFNT6IzCGpwnjse9nxyfgkT/M7HaMmewKQLeNjkjkX/+yPE5cowO9Z8b
         oIsnu8wpJUtXeiwowDAh/FdQr6mY+MY9imL9plJo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228061149epcas1p2239efb1e6b3348ce9dcbb1675ed3c9e1~H6DcMjJfj1250712507epcas1p2i;
        Tue, 28 Feb 2023 06:11:49 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.241]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PQn7n1r9sz4x9Q3; Tue, 28 Feb
        2023 06:11:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.0D.12562.02B9DF36; Tue, 28 Feb 2023 15:11:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230228061144epcas1p42b4459242309a88b6ce1d4a50db885a1~H6DX5eg3H0208802088epcas1p4f;
        Tue, 28 Feb 2023 06:11:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230228061144epsmtrp18fbca649b523c7a236a094e974f31623~H6DX42_MC2824128241epsmtrp1b;
        Tue, 28 Feb 2023 06:11:44 +0000 (GMT)
X-AuditID: b6c32a36-bfdff70000023112-3e-63fd9b20b87a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.2A.17995.02B9DF36; Tue, 28 Feb 2023 15:11:44 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230228061144epsmtip18a84bd8d9e8dcc2f8312d24c236d3f10~H6DXtqNb70100701007epsmtip1F;
        Tue, 28 Feb 2023 06:11:44 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     <linkinjeon@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB6316DF13B8E9FC79FD477A6C81AC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 0/3] exfat: fix and refine exfat_alloc_cluster()
Date:   Tue, 28 Feb 2023 15:11:44 +0900
Message-ID: <1f5e01d94b3b$884335c0$98c9a140$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKFeAPq3M83LX42tYyQjFGf98HKUwErYjl6rYIrgsA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmga7i7L/JBmcvMFtMnLaU2WLP3pMs
        Flv+HWF1YPbYtKqTzaNvyypGj8+b5AKYoxoYbRKLkjMyy1IVUvOS81My89JtlUJD3HQtlBQy
        8otLbJWiDQ2N9AwNzPWMjIz0TI1irYxMlRTyEnNTbZUqdKF6lRSKkguAanMri4EG5KTqQcX1
        ilPzUhyy8ktBrtMrTswtLs1L10vOz1VSKEvMKQUaoaSf8I0x48/8E+wFv5krGru4Ghi7mLsY
        OTkkBEwkzkxfw9LFyMUhJLCDUeLwsd9MIAkhgU+MEu922UMkPjNKrN3zkxGm49Sx9WwQiV2M
        Ekfv9kM5Lxklzp2czAZSxSagK/Hkxk+wHSIC0hLzLk4BG8ssYCtx9sFfsBpOgViJ+Xc3gtUI
        C7hLdLU0gcVZBFQljsy5BBbnFbCUONtzlhXCFpQ4OfMJC8QceYntb+dA/aAgsfvTUaAaDqBd
        VhIXXspDlIhIzO5sYwa5TULgEbvE2tk/oepdJD717meCsIUlXh3fwg5hS0m87G9jh2joZpQ4
        /vEdC0RiBqPEkg4HCNteorm1mQ1kGbOApsT6XfoQYUWJnb/nQkNIUOL0tW5miCP4JN597QG7
        TUKAV6KjTQiiREXi+4edLBMYlWch+WwWks9mIXlhFsKyBYwsqxjFUguKc9NTiw0LjJCjexMj
        OGVqme1gnPT2g94hRiYOxkOMEhzMSiK8C2//SRbiTUmsrEotyo8vKs1JLT7EmAwM64nMUqLJ
        +cCknVcSb2hmZmlhaWRiaGxmaEhY2MTSwMTMyMTC2NLYTEmcV9z2ZLKQQHpiSWp2ampBahHM
        FiYOTqkGpoT/qV8mGK6K2X+ZvbJLXKb6pPaG4rlyU/0q4zu32cU8FcwsNpj88scTV7/kO+xR
        +f/DQ9w6dv2RSrM/nz3vWJFz+NpXFx47PT7TkvhvTq9g4eWwlxd+yyVIZIX7RpUFv+RWD+0r
        8p2VtLnnldqe1JXl39wnOZafry9ynHSrJ1/2VHOR89Xl22PylP237esqCT7G/p5/sXpydb74
        lAlLDLYX6oWW5s2/8bDFS733r/SnyS9Xmq15msWf13Y3kk/O+MOZiScnbrP7lX5kWlbhohtH
        os94rHnM8Kf1mu/ziUd4bfZsXFUZuaHrTMnb2s8Pl9uV/U0NKvmUP+tGS8GBg5+57J/Kum2z
        UDcqsz+kr8RSnJFoqMVcVJwIACfFsO1QBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnK7C7L/JBvP+qltMnLaU2WLP3pMs
        Flv+HWF1YPbYtKqTzaNvyypGj8+b5AKYo7hsUlJzMstSi/TtErgy/sw/wV7wm7misYurgbGL
        uYuRk0NCwETi1LH1bF2MXBxCAjsYJe6vmcraxcgBlJCSOLhPE8IUljh8uBii5DmjROPME2wg
        vWwCuhJPbvwEmyMiIC0x7+IUJhCbWcBe4vvWg0wQDesYJVavfsICkuAUiJWYf3cjWIOwgLtE
        V0sT2CAWAVWJI3MugcV5BSwlzvacZYWwBSVOzoToZRbQlnh68ymULS+x/e0cqAcUJHZ/Ogp2
        s4iAlcSFl/IQJSISszvbmCcwCs9CMmkWkkmzkEyahaRlASPLKkbJ1ILi3PTcYsMCo7zUcr3i
        xNzi0rx0veT83E2M4GjQ0trBuGfVB71DjEwcjIcYJTiYlUR4F97+kyzEm5JYWZValB9fVJqT
        WnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDE/Op+KY17/9cCLycx2f3NrU36+Dp
        ylnNLUdTD52qvKG0orpK5g+D9eQ5CTM3nslr+7Js9oz8MBHJee47VJ693L7E7aeYJVPp7oqz
        uj8mf4+fxrX8t7RCf+OZd23Mh8uVflh0HpKcvuSyovL/Wfs/B/TtWHsgbHlxt4CYskAof/Nc
        Jh/3KZvv8Wnsms/ivHhZk0XGQgkJvex9Aes8w/p0D03h3RktcDH5lm3hu1t736t+3XzMzfTv
        9GvyuZaly012//KM47gsLria5zJfit7kcLUdLudz0t58qrzjXyZk753PqHvf1Mu8VPat7f+k
        29OvZXf/klkqf3TKgveX7FdfsosOT93QKN9/6Gnb03/i9UosxRmJhlrMRcWJADJrFBL1AgAA
X-CMS-MailID: 20230228061144epcas1p42b4459242309a88b6ce1d4a50db885a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230228060728epcas1p1fdcc8ccf4b2a7a90fc8b3376af3fcd0f
References: <CGME20230228060728epcas1p1fdcc8ccf4b2a7a90fc8b3376af3fcd0f@epcas1p1.samsung.com>
        <PUZPR04MB6316DF13B8E9FC79FD477A6C81AC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Changes for v2:
>   [2/3] do not return error if hint_cluster invalid
> 
> Yuezhang Mo (3):
>   exfat: remove unneeded code from exfat_alloc_cluster()
>   exfat: don't print error log in normal case
>   exfat: fix the newly allocated clusters are not freed in error
>     handling

Looks good. Thanks.
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> 
>  fs/exfat/fatent.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> --
> 2.25.1

