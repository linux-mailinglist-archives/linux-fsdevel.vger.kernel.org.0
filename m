Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D762864AF95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 07:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiLMGGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 01:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiLMGGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:06:41 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C117A94
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 22:06:40 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221213060635epoutp024d7fd81e78bb73d2b6e19103dc3fb838~wRT5JCupd1974719747epoutp02i
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 06:06:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221213060635epoutp024d7fd81e78bb73d2b6e19103dc3fb838~wRT5JCupd1974719747epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670911595;
        bh=jXp+vX7rVAyMq/vBMAWOKcFxPyQtORN2x4GNSC7SbZo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=tqmn2nTQgak67wwF65B2QL3zdXfm+WXgpNHtYX7S1m0BOEnGQ2R+9EmJ/Yk4jmUNm
         voMIxmKE86EYTkQh2UfFTxc57wHNIOe6ZlBcVhnXAa0BcytGrRgew/Nthfdglyi26F
         LjSWSmDKMINSIFITzQ0EAk0SG5afv5LL58aM6zLI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221213060635epcas1p1583c4a337957ff6ef9a851a7ac7ea1ed~wRT41iPG01705317053epcas1p1Y;
        Tue, 13 Dec 2022 06:06:35 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.242]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NWSgH1BmMz4x9QC; Tue, 13 Dec
        2022 06:06:35 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.7E.20046.B6618936; Tue, 13 Dec 2022 15:06:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20221213060634epcas1p4a676afb07176433f37cda80713955173~wRT4VdChR0963309633epcas1p4h;
        Tue, 13 Dec 2022 06:06:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221213060634epsmtrp1a40980ff4bf04a60d7b5775dbc8141b7~wRT4UvhP33265732657epsmtrp1I;
        Tue, 13 Dec 2022 06:06:34 +0000 (GMT)
X-AuditID: b6c32a39-b6cf5a8000004e4e-19-6398166b5753
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.DC.18644.A6618936; Tue, 13 Dec 2022 15:06:34 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221213060634epsmtip1d6dbb751c082204149586c5ba41f1d2f~wRT4INVR92365423654epsmtip1J;
        Tue, 13 Dec 2022 06:06:34 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     <linkinjeon@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB6316B3802565F2A09DD0D47A81E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 0/7] exfat: code optimizations
Date:   Tue, 13 Dec 2022 15:06:34 +0900
Message-ID: <11ef301d90eb9$0d9a3990$28ceacb0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFudLtrOaxngaEJdxHnDHYK+qVAswGhgxb+rzN8JwA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJsWRmVeSWpSXmKPExsWy7bCmnm622Ixkgzt9LBYTpy1lttiz9ySL
        xeVdc9gstvw7wurA4rFpVSebR9+WVYwenzfJBTBHNTDaJBYlZ2SWpSqk5iXnp2TmpdsqhYa4
        6VooKWTkF5fYKkUbGhrpGRqY6xkZGekZW8ZaGZkqKeQl5qbaKlXoQvUqKRQlFwDV5lYWAw3I
        SdWDiusVp+alOGTll4KcqFecmFtcmpeul5yfq6RQlphTCjRCST+hkTnj+o5rbAU/2SseXHzI
        0sC4ka2LkZNDQsBE4tndHtYuRi4OIYEdjBInv05ghHA+MUrM6NnNBuF8ZpT4/e0lM0xLT/9J
        FojELkaJ81NXQlW9ZJR4deEYC0gVm4CuxJMbP8E6RASkJeZdnMIEYjMLxEss3nEcbDmnQKzE
        0m2XwGxhAVOJWx2zwHpZBFQlvl1oB4vzClhJLJ51kh3CFpQ4OfMJC8QceYntb+dAXaQgsfvT
        UVaIXVYSt9YsZ4aoEZGY3dnGDHKchMBHdonpXQfZIRpcJHY2rWCFsIUlXh3fAhWXknjZ3wZl
        dzNK/DnHC9E8gVGi5c5ZqAZjiU+fPwNDiQNog6bE+l36EGFFiZ2/5zJC2IISp691Qx3BJ/Hu
        KyiEOYDivBIdbUIQJSoS3z/sZJnAqDwLyWuzkLw2C8kLsxCWLWBkWcUollpQnJueWmxYYIoc
        45sYwSlUy3IH4/S3H/QOMTJxMB5ilOBgVhLhVdWYlizEm5JYWZValB9fVJqTWnyIcSIjMLQn
        MkuJJucD03heSbyhmZmlhaWRiaGxmaEhYWETYwMDI2C6Nbc0NyZC2NLAxMzIxMLY0thMSZx3
        +pSOZCGB9MSS1OzU1ILUIpijmDg4pRqYDuYfjp/bGX0/9Ip7DOPuANFTfGs2lwWqaN790VV9
        PH/KFCGnYw2MW6MO/5wt3tx3zOHzlfQw5RCPev7P6o2F3le3zvDdaMuSFvWFIXZZy499M5IT
        yjZGvlJblugeymsrbRi+t64yhEHE5GPInPSfs8/afopwnvLk9hrflFUXbm+05zjXe+oh1/W2
        k/eOq23yuNaUcslaMyzkRPGB1efOHYs69mvr4pUXFQ+kfLK/lzKxz+3Z9szIU+dlnf9skbx/
        NUuJxTeRUXCGoEzPtSv58WYajQcexqXWm9keXxnT9L6jaFHUrr8eRnIcmfN0xTgunJUqvHct
        pD57gvqTNA3v991Mc7bM8n7jnRVz/M5dJZbijERDLeai4kQAlrxJT4cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnG6W2Ixkg569ShYTpy1lttiz9ySL
        xeVdc9gstvw7wurA4rFpVSebR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGVc33GNreAne8WD
        iw9ZGhg3snUxcnJICJhI9PSfZOli5OIQEtjBKLFm5iGgBAdQQkri4D5NCFNY4vDhYoiS54wS
        s55dZQbpZRPQlXhy4yeYLSIgLTHv4hQmEJtZIFHizJI2VhBbSGAdo8SnjyIgNqdArMTSbZfA
        9goLmErc6pjFAmKzCKhKfLvQDhbnFbCSWDzrJDuELShxcuYTFoiZ2hK9D1sZIWx5ie1v5zBD
        3K8gsfvTUVaIG6wkbq1ZzgxRIyIxu7ONeQKj8Cwko2YhGTULyahZSFoWMLKsYpRMLSjOTc8t
        Niwwykst1ytOzC0uzUvXS87P3cQIjgwtrR2Me1Z90DvEyMTBeIhRgoNZSYRXVWNashBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MBv5fFCuXbUv/xXLC
        y6bl4KRYHdeyDJ23FYJ2yaUP1nsF9kgJ/nnseb23r3i+vcRGV7WqNQ5RbHMPfdk8eZ5EZ2WB
        yW/d5UUSHvdTogOKV+smHtxjYdDWYj3vaiy7lpe06GHt9DMlyW/ftG38NHvvioyMo3sfhX71
        6720M8qpJcRU/1hwYMhetv1MJ/YeOGdw69Knjaa1ZQxzk1Y8XuI6w7Vsy7FKrVSuqiOhJrFa
        ypdiDTomLu8xN37k/0VJ3TLtzpRzLh0vZ9+I/lR6MLW9t+VU8sUVWyKtPRbemt708L9NRM6Z
        w7t4zwjrL3M6XXqA93pqpc+kT9fr/Hd0ltiu2d4tdtF2hsTDCer/sg4osRRnJBpqMRcVJwIA
        A2k71vsCAAA=
X-CMS-MailID: 20221213060634epcas1p4a676afb07176433f37cda80713955173
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221213023709epcas1p2076929f25729ec924f96d191cd025de4
References: <CGME20221213023709epcas1p2076929f25729ec924f96d191cd025de4@epcas1p2.samsung.com>
        <PUZPR04MB6316B3802565F2A09DD0D47A81E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This patchset is some minor code optimizations, no functional changes.
> 
> Changes for v2:
>   - [6/7] [7/7] Fix return value type of exfat_sector_to_cluster()

Looks good. Thanks.
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> 
> Yuezhang Mo (7):
>   exfat: remove call ilog2() from exfat_readdir()
>   exfat: remove unneeded codes from __exfat_rename()
>   exfat: remove unnecessary arguments from exfat_find_dir_entry()
>   exfat: remove argument 'size' from exfat_truncate()
>   exfat: remove i_size_write() from __exfat_truncate()
>   exfat: fix overflow in sector and cluster conversion
>   exfat: reuse exfat_find_location() to simplify exfat_get_dentry_set()
> 
>  fs/exfat/dir.c      | 38 +++++++++++++++-----------------------
>  fs/exfat/exfat_fs.h | 19 ++++++++++++-------
>  fs/exfat/file.c     | 12 +++++-------
>  fs/exfat/inode.c    |  4 ++--
>  fs/exfat/namei.c    | 19 +++----------------
>  5 files changed, 37 insertions(+), 55 deletions(-)
> 
> --
> 2.25.1

