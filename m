Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FEE6C6C94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 16:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjCWPvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjCWPu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:50:58 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2C6F976
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 08:50:53 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230323155051euoutp0295ea1994b5e7097c269c22190f9969a9~PFyk3aDsM0866108661euoutp02H
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 15:50:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230323155051euoutp0295ea1994b5e7097c269c22190f9969a9~PFyk3aDsM0866108661euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679586651;
        bh=/ekrNC/98zX45M7YfQc5hSeXdmJtYi6b5R1JvXDqOBk=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=ocSEb6p4hh61NbC/5ACww2W12aIgY3AkXTCCmaphcN2wcqLN9sAouTRQY8epJ3mFL
         8KjBdv9OBQfsP9yM7w4UuWkJ3/oOuyWUfqNFZXKwyDYFI8o0Hvmj2eiehBxxil18nE
         bi87kLF/jgxpe8mTuDLxuRWGwROWRot0EVhtj83Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230323155051eucas1p11664caa8946ccba8d8d09c03772f7e9d~PFykjdNzW0552105521eucas1p1F;
        Thu, 23 Mar 2023 15:50:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8E.BB.09503.B557C146; Thu, 23
        Mar 2023 15:50:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230323155051eucas1p141ba678c9ff021ed5b8075447879f123~PFykP72XP1724117241eucas1p11;
        Thu, 23 Mar 2023 15:50:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230323155051eusmtrp1332bdf7acf83a8330bca787dfa1047c0~PFykPO6sr3076630766eusmtrp1Y;
        Thu, 23 Mar 2023 15:50:51 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-78-641c755b97a3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F8.DF.09583.B557C146; Thu, 23
        Mar 2023 15:50:51 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230323155050eusmtip12838d70fdd58c1b862205d365f7d9583~PFykEVamh3252432524eusmtip1e;
        Thu, 23 Mar 2023 15:50:50 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 23 Mar 2023 15:50:49 +0000
Message-ID: <8adb0770-6124-e11f-2551-6582db27ed32@samsung.com>
Date:   Thu, 23 Mar 2023 16:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.8.0
Subject: Re: [RFC v2 1/5] zram: remove zram_page_end_io function
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     <senozhatsky@chromium.org>, <viro@zeniv.linux.org.uk>,
        <axboe@kernel.dk>, <willy@infradead.org>, <brauner@kernel.org>,
        <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <hubcap@omnibond.com>, <martin@omnibond.com>, <mcgrof@kernel.org>,
        <devel@lists.orangefs.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZBwrfT8TA5GC5+RH@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djPc7rRpTIpBg9WSFnMWb+GzWL13X42
        i9eHPzFa7N88hcni9IRFTBbtd/uYLPbe0rbYs/cki8XlXXPYLO6t+c9qcXL9f2aLGxOeMlos
        +/qe3WL3xkVsFuf/Hme1+P1jDpuDgMfshossHptXaHlcPlvqsWlVJ5vHpk+T2D1OzPjN4tEw
        9Rabx6/bd1g9Pm+S89j05C1TAFcUl01Kak5mWWqRvl0CV8bBB93MBRe5KxZu/cTUwDiVs4uR
        k0NCwETiysQrzF2MXBxCAisYJdau/8EO4XxhlLj6+B0bhPOZUeLgrRvsMC1/901igUgsZ5Ro
        Oj+RCa7qyNOjUP07GSWaV79hA2nhFbCT+HT9LyOIzSKgKvF06hZmiLigxMmZT4BGcXCICkRJ
        vHhdBhIWFnCQWNH0DqycWUBc4taT+UwgtoiApsSt5e1gxzILLGWWuNH5jxWkl01AS6KxE+w6
        TgFdib61O5khejUlWrf/Zoew5SW2v53DDPGBosSkm+9ZIexaiVNbboE9ICHwilNi3dN37CAz
        JQRcJG4uqIeoEZZ4dXwL1PcyEqcn97BA2NUST2/8ZobobWGU6N+5ng2i11qi70wOhOkosXWl
        DoTJJ3HjrSDENXwSk7ZNZ57AqDoLKRxmIXl4FpIHZiF5YAEjyypG8dTS4tz01GLDvNRyveLE
        3OLSvHS95PzcTYzAVHj63/FPOxjnvvqod4iRiYPxEKMEB7OSCK8bs0SKEG9KYmVValF+fFFp
        TmrxIUZpDhYlcV5t25PJQgLpiSWp2ampBalFMFkmDk6pBib/radVnr9byBmle/D4s4IMjQIh
        xjefFr5arLOUTdHq49+qO8pZWxnVv8e5/py2KOHBccvik8GdZ+fanJlQPGlLy9OWa9f8Vs/0
        Me6bYKnws8vswE2unYHxZ9oW/3eS+LHxezD/rrrTbSVinKXVb5QWyLVkVB+7MPu3d+Kep5o7
        wzVPvY23eT2rSF/b69xM0Ws3Tc7YzpjeyMHvN/vZtu45Vb9nlx76up2x07pzu5hv48F5yrYS
        PVcEl8oYS4SJBCytzhFOvpU8c+ea5xf+vYtimMJ2IPNUx4IrjTIisUVxG+bNmXE/z/zS40aJ
        yQzTn62+XFymsEu0RFUmVKRcaOFk81mfZzR+kep8JzlHqbtIiaU4I9FQi7moOBEAQFPE3/QD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t/xu7rRpTIpBre/sljMWb+GzWL13X42
        i9eHPzFa7N88hcni9IRFTBbtd/uYLPbe0rbYs/cki8XlXXPYLO6t+c9qcXL9f2aLGxOeMlos
        +/qe3WL3xkVsFuf/Hme1+P1jDpuDgMfshossHptXaHlcPlvqsWlVJ5vHpk+T2D1OzPjN4tEw
        9Rabx6/bd1g9Pm+S89j05C1TAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWR
        qZK+nU1Kak5mWWqRvl2CXsbBB93MBRe5KxZu/cTUwDiVs4uRk0NCwETi775JLF2MXBxCAksZ
        JbY828oEkZCR+HTlIzuELSzx51oXG0TRR0aJGbOnMoMkhAR2MkosnJIAYvMK2El8uv6XEcRm
        EVCVeDp1CzNEXFDi5MwnLCC2qECUxNM7h8DiwgIOEiua3oHVMwuIS9x6Mh9ssYiApsSt5e3M
        IMuYBRYzS0ye3wJ13iNGiedvrwA5HBxsAloSjZ1g13EK6Er0rd3JDDFIU6J1+292CFteYvvb
        OcwQHyhKTLr5nhXCrpX4/PcZ4wRG0VlI7puF5I5ZSEbNQjJqASPLKkaR1NLi3PTcYiO94sTc
        4tK8dL3k/NxNjMAksu3Yzy07GFe++qh3iJGJg/EQowQHs5IIrxuzRIoQb0piZVVqUX58UWlO
        avEhRlNgIE1klhJNzgemsbySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4m
        Dk6pBqa8jI7DStu3FW+fw3IqNHe/e5ZPg3pURE+2+YWOCtvlkbcnc0smHdnyTaXfqc5oNYtL
        8GFX95dt99onFqgbVdhG8Rp0RRVe0Kssmhj47PjZR+oR+5PbN0moLJGomnuscmKygWbXkzSR
        uTefXr468erniqsXnioslopJivCWY98/R2eTVPFm4dRGabvipQrvTCenBOisWCyuelzH6aeO
        547jT94LTj99OdA47lL5zveMqoWZs4tLNacy/3JcYFEQL36zVzC0etLdFW+blwWq88SETn7J
        1Xl6QunL08GfZzGdXKhUMPtljvjLzm4Ru9MT//d/25cv63Xl1Uujtw9enTz/6drHS3Zfp06p
        e/XFWF6JpTgj0VCLuag4EQDHxP5hqwMAAA==
X-CMS-MailID: 20230323155051eucas1p141ba678c9ff021ed5b8075447879f123
X-Msg-Generator: CA
X-RootMTR: 20230322135015eucas1p1bd186e83b322213cc852c4ad6eb47090
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135015eucas1p1bd186e83b322213cc852c4ad6eb47090
References: <20230322135013.197076-1-p.raghav@samsung.com>
        <CGME20230322135015eucas1p1bd186e83b322213cc852c4ad6eb47090@eucas1p1.samsung.com>
        <20230322135013.197076-2-p.raghav@samsung.com>
        <ZBwrfT8TA5GC5+RH@infradead.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-23 11:35, Christoph Hellwig wrote:
> On Wed, Mar 22, 2023 at 02:50:09PM +0100, Pankaj Raghav wrote:
>> -	if (!parent)
>> -		bio->bi_end_io = zram_page_end_io;
>> -	else
>> +	if (parent)
> 
> I don't think a non-chained bio without and end_io handler can work.

Hmm. Is it because in the case of non-chained bio, zram driver owns the bio,
and it is the responsibility of the driver to call bio_put in the end_io handler?

> This !parent case seems to come from writeback_store, and as far as
> I can tell is broken already in the current code as it just fires
> off an async read without ever waiting for it, using an on-stack bio
> just to make things complicated.
> 
> The bvec reading code in zram is a mess, but I have an idea how
> to clean it up with a little series that should also help with
> this issue.
Sounds good.

As a part of this series, should I just have an end_io which has a
call to bio_put then?

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b7bb52f8dfbd..faa78fce327e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -608,10 +608,6 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)

 static void zram_page_end_io(struct bio *bio)
 {
-       struct page *page = bio_first_page_all(bio);
-
-       page_endio(page, op_is_write(bio_op(bio)),
-                       blk_status_to_errno(bio->bi_status));
        bio_put(bio);
 }
