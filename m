Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE92401DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 08:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgHJGKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 02:10:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14336 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgHJGKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:10:35 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200810061032epoutp01c8390acaa38b9a0c9b98065b225f7706~p00Qg-50-2683726837epoutp01b
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 06:10:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200810061032epoutp01c8390acaa38b9a0c9b98065b225f7706~p00Qg-50-2683726837epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597039832;
        bh=EQsNdLKwnUjV9oPhkjVIs8QrNi6n4zD2Ql/kkSq1qrk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=BN+xQ+3CGZXUHAEpETmzEn/aFdi9kq8ofM3iI7FqZBX+5VaPNsRzQg72ZbROySUjl
         N5U9x5aRvwGw4Xx9JMVCvMv7VDD2tm+2iwhpfZdtFcoRvucDDML6Taensc+OTkLY6g
         kRo9CpwdEJxeBVY/iP2nJj8S3UmIUmEljVKmKfCY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200810061026epcas1p342621fcbccd43ddb51c71c7294596c97~p00K8oZqI1286012860epcas1p3V;
        Mon, 10 Aug 2020 06:10:26 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BQ5DK2xRszMqYkr; Mon, 10 Aug
        2020 06:10:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.CC.29173.0D4E03F5; Mon, 10 Aug 2020 15:10:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200810061021epcas1p23084a8dfb142c2bd0d28c9df6f4c2a18~p00Ga2Wk_0930009300epcas1p2j;
        Mon, 10 Aug 2020 06:10:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200810061021epsmtrp1424818bf74796aa764f0f672892f3f0d~p00GXJy2m3271932719epsmtrp1r;
        Mon, 10 Aug 2020 06:10:21 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-60-5f30e4d0eca3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.18.08303.DC4E03F5; Mon, 10 Aug 2020 15:10:21 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200810061021epsmtip215fe198768fc4f6efc8b4d33467ec2ec~p00GNQfU-1390513905epsmtip2h;
        Mon, 10 Aug 2020 06:10:21 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806010229.24690-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v3] exfat: integrates dir-entry getting and validation
Date:   Mon, 10 Aug 2020 15:10:21 +0900
Message-ID: <003c01d66edc$edbb1690$c93143b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH6G9isXEQ9sMxkt33jRW4ItYjr3QIF0gSvqNlP5GA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmvu6FJwbxBvOvKVv8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYrHl3xFWB3aPL3OOs3u0Tf7H7tF8bCWbx85Zd9k9+ras
        YvT4vEkugC0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
        LTMH6BYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6V
        oYGBkSlQZUJOxu+DVQWvWCs6371mb2C8z9LFyMEhIWAi8abTtouRi0NIYAejxIdXl5kgnE+M
        En+3/mPvYuQEcj4zSnxZWAhigzQ0ndjLBlG0i1Hi0Yt+dgjnJaNE65rNTCBVbAK6Ev/+7GcD
        sUUE9CROnrwO1sEs0MgksfzEF2aQBKeApcSpe/9YQe4QFvCSmNcrBRJmEVCVaN52iAkkzAtU
        suekGEiYV0BQ4uTMJywgNrOAvMT2t3OYIQ5SkPj5dBkrxCoriQWzfzFB1IhIzO5sYwZZKyGw
        lEPix5LDUC+7SFxqjoPoFZZ4dXwLO4QtJfGyv40doqRa4uN+qPEdjBIvvttC2MYSN9dvADuY
        WUBTYv0ufYiwosTO33MZIbbySbz72sMKMYVXoqNNCKJEVaLv0mEmCFtaoqv9A/sERqVZSP6a
        heSvWUjun4WwbAEjyypGsdSC4tz01GLDAmPkeN7ECE6iWuY7GKe9/aB3iJGJg/EQowQHs5II
        r91d/Xgh3pTEyqrUovz4otKc1OJDjKbAgJ7ILCWanA9M43kl8YamRsbGxhYmZuZmpsZK4rwP
        bynECwmkJ5akZqemFqQWwfQxcXBKNTCJtG18Gs42qfa4QG9T5IJU6bw3e0TtwmZdOSZ20rOe
        Q9d2yrVH87VYm3dOqLTz4Oe6ryu6gXdOTfKs9cIb9399VMYz+bnx5qUn3p1m1lp28s2ahNJD
        20x5fop4dLh2OE+8U+15sTd3y/wptx7t+dBpffHXwcufpN5MtGJ2Npu1+7fvvjlbe+8e+FMt
        x3p5/jG2vcwVXgaqnscsGV4d1yhsObi0ZknNZEsN4Z+XfjAb2Gk8Ybd6/o67I0hrsUqygLxb
        xNWdr6WtvgW2FRTlBmV2l2p3bmia+mTN+Z5bJvtbv2c/Z2Kdw1VUdHzXYZc54gu2xmtqfT5T
        pnhuxlrm6v+H51g78ifO2pGTWpl/UvO7EktxRqKhFnNRcSIAue1VaisEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXvfsE4N4g5W3ZC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBbFZZOSmpNZllqkb5fAlfH7YFXBK9aKznev2RsY77N0MXJySAiYSDSd2MvWxcjF
        ISSwg1Hiyp4PUAlpiWMnzjB3MXIA2cIShw8XQ9Q8Z5SYsHAqWA2bgK7Evz/72UBsEQE9iZMn
        r4MNYhZoZpL49mwJM0hCSKCLUWLpdXYQm1PAUuLUvX+sIEOFBbwk5vVKgYRZBFQlmrcdYgIJ
        8wKV7DkpBhLmFRCUODnzCQtImBlofNtGRpAws4C8xPa3c5ghrlSQ+Pl0GSvEBVYSC2b/YoKo
        EZGY3dnGPIFReBaSSbMQJs1CMmkWko4FjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNz
        NzGC40lLawfjnlUf9A4xMnEwHmKU4GBWEuG1u6sfL8SbklhZlVqUH19UmpNafIhRmoNFSZz3
        66yFcUIC6YklqdmpqQWpRTBZJg5OqQYmSxOhTVs8tK4cNMwqP/86LOxfqmbv4sm797AHWU47
        /uNL4VNtFZ51Oyw1WrtvKb/ZJvRnd+P/Vx5qv007FDOvpifPNF61UWBxzvXAPWZnD36S+j39
        5h+L9FU/n6v7bGr52y4ivcFi19l4pw0q7W/38R3R3mSzInBlUPC2t6drrBmkvrxbudD7gNJU
        ZSWuCYfEOP6tVPLdb/04e0Lb6ZthJfPtZqnnbfrYvlTxqJlWzKGdbwVvvrH/q+Y+bdeRK6e/
        pa3O2X4y0Ptdz5NLVzN/aUfd/f+srS6RcZlY2Z6EltCkS+enOE+dazGj/trfNVZH14k9WK6y
        xDhC9GBLtPPJ3VZHWTquqJ6ytpx0Y/JsuTlKLMUZiYZazEXFiQCrEuqBFgMAAA==
X-CMS-MailID: 20200810061021epcas1p23084a8dfb142c2bd0d28c9df6f4c2a18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806010250epcas1p482847d6d906fbf0ccd618c7d1cacd12e
References: <CGME20200806010250epcas1p482847d6d906fbf0ccd618c7d1cacd12e@epcas1p4.samsung.com>
        <20200806010229.24690-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> +#define TYPE_PRIMARY		(TYPE_CRITICAL_PRI | TYPE_BENIGN_PRI)
> +#define TYPE_SECONDARY		(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)
> +
>  #define MAX_CHARSET_SIZE	6 /* max size of multi-byte character */
>  #define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
>  #define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)
> @@ -171,7 +174,9 @@ struct exfat_entry_set_cache {
>  	unsigned int start_off;
>  	int num_bh;
>  	struct buffer_head *bh[DIR_CACHE_SIZE];
> -	unsigned int num_entries;
> +	int num_entries;
> +	struct exfat_de_file *de_file;
> +	struct exfat_de_stream *de_stream;
I prefer to assign validated entries to **de and use it using enum value.
	struct exfat_dentry **de;
>  };

