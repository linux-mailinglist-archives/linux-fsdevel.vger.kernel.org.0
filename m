Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295677BB1A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 08:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjJFGmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 02:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjJFGmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:42:53 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC46E8
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 23:42:51 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231006064249epoutp04a069203eea1075ac276730eca9a59355~LcZUGyNbD0814908149epoutp04i
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 06:42:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231006064249epoutp04a069203eea1075ac276730eca9a59355~LcZUGyNbD0814908149epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696574569;
        bh=/cAeG/bMuIgdRRxWPTC5pd+l14+v5NFpX+2n/8g8scw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V6A+NZzTa3f5DgrpFuSXAt9k480HqRNhHlbeaMJfItYO9EhNANN4WAapPTFHahA35
         zHDfwe6I06ETWyDdEENu7/JNJWYZZPEw9QacL8f9IiaSGzsySqbbrkAvIoami3Tfxk
         fPCcWN+dR7BicuLjbLWwXD7Y+oLl+P65T/3Z4VA8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231006064248epcas5p4918072182f12a8ebc807e5acd3ef8ed2~LcZTMhWLM2647126471epcas5p4b;
        Fri,  6 Oct 2023 06:42:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4S1zPy50cBz4x9QC; Fri,  6 Oct
        2023 06:42:46 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.E8.09949.66CAF156; Fri,  6 Oct 2023 15:42:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231006064245epcas5p2a2809e2b1db77426d681819c0bcb1a82~LcZQy2f5a0379003790epcas5p2V;
        Fri,  6 Oct 2023 06:42:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231006064245epsmtrp1d3e96565aee9de0309de71ef2eac3dfd~LcZQyGb831630416304epsmtrp1W;
        Fri,  6 Oct 2023 06:42:45 +0000 (GMT)
X-AuditID: b6c32a49-bd9f8700000026dd-93-651fac66645c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.8B.08742.56CAF156; Fri,  6 Oct 2023 15:42:45 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231006064244epsmtip2ae32d627040c3a6cbd3ae39a78f6890d~LcZPAp-bY0607406074epsmtip2l;
        Fri,  6 Oct 2023 06:42:43 +0000 (GMT)
Date:   Fri, 6 Oct 2023 12:06:40 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 02/15] blk-ioprio: Modify fewer bio->bi_ioprio bits
Message-ID: <20231006063640.GB3862@green245>
MIME-Version: 1.0
In-Reply-To: <20231005194129.1882245-3-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmhm7aGvlUgxWb1Sxe/rzKZrH6bj+b
        xbQPP5ktVj0It3iw395i5eqjTBZzzjYwWey9pW2xZ+9JFovu6zvYLJYf/8dk8eDPY3YHHo/L
        V7w9ds66y+5x+Wypx6ZVnWweu282sHl8fHqLxaNvyypGj8+b5DzaD3QzBXBGZdtkpCampBYp
        pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2rpFCWmFMKFApILC5W
        0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOOLzlFnPBFv6K
        k9uvMjcw/uPpYuTkkBAwkehetJO9i5GLQ0hgN6PE//mfmCGcT4wSM65ch3K+MUo8+DyTtYuR
        A6zlz0lhiPheoPja9Swgo4QEnjFKLLuWBGKzCKhIfDh0jxGknk1AU+LC5FKQsIiAhsS3B8tZ
        QHqZBbqZJV5O3sgEkhAW8JK4eGEtmM0roCOxZ2obO4QtKHFy5hOw+ZwCVhKrfv9hA7FFBZQl
        Dmw7zgQySEJgB4fE1DWz2SH+cZFYeXk5E4QtLPHq+BaouJTEy/42KDtZ4tLMc1A1JRKP9xyE
        su0lWk/1M4PYzAIZEo8X72OHsPkken8/YYJ4nleio00IolxR4t6kp6wQtrjEwxlLoGwPiZZj
        85ngAbT5+kb2CYxys5D8MwvJCgjbSqLzQxPrLKAVzALSEsv/cUCYmhLrd+kvYGRdxSiZWlCc
        m55abFpgmJdaDo/j5PzcTYzgBKzluYPx7oMPeocYmTgYDzFKcDArifCmN8ikCvGmJFZWpRbl
        xxeV5qQWH2I0BcbPRGYp0eR8YA7IK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUg
        tQimj4mDU6qByTfmhC3rfA7vdHadFK1VYfa3L6w/8HpV8E7zR3cnH7z0Sb9pmXpK/eRfe/Zl
        siy5xqjpor5UKIfj2opTdY7lstlFv5LCvaqZDr6oTIorXHzG9aXEpqcpdlIJF5Tk49y61s/7
        6TkheeYuqecbb4j/ui7UoXprcfRbjd7blf/eT/oWKG/t7RrcFluuEp058/uLM+tuCt2b1XZA
        9szu3UUP7xafFGQKTGXKM5iXIztn/j2pJTFP8zer+Kufm5NzeZNH+bV9JbMlXkhuz8vPP8b8
        dttCDve7eTVej7btff/JLzU00qTjbt8v/Tm7ctaGruts9lb+W1krsu2a116lHS7NvdvFVosu
        D93oWhBS8F/kkhJLcUaioRZzUXEiAJe6e9tJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXjd1jXyqwbNLJhYvf15ls1h9t5/N
        YtqHn8wWqx6EWzzYb2+xcvVRJos5ZxuYLPbe0rbYs/cki0X39R1sFsuP/2OyePDnMbsDj8fl
        K94eO2fdZfe4fLbUY9OqTjaP3Tcb2Dw+Pr3F4tG3ZRWjx+dNch7tB7qZAjijuGxSUnMyy1KL
        9O0SuDIe3SsteMZTseZCC3sD4ymuLkYODgkBE4k/J4W7GLk4hAR2M0p0/W1j72LkBIqLSzRf
        +wFlC0us/PecHaLoCaPEwU1/mEASLAIqEh8O3WMEGcQmoClxYXIpSFhEQEPi24PlLCD1zAL9
        zBLtL4+D1QsLeElcvLAWzOYV0JHYM7UNauheRokL+36wQSQEJU7OfMICYjMLmEnM2/yQGWQB
        s4C0xPJ/HCBhTgEriVW//4CViwooSxzYdpxpAqPgLCTds5B0z0LoXsDIvIpRMrWgODc9t9iw
        wDAvtVyvODG3uDQvXS85P3cTIziitDR3MG5f9UHvECMTB+MhRgkOZiUR3vQGmVQh3pTEyqrU
        ovz4otKc1OJDjNIcLErivOIvelOEBNITS1KzU1MLUotgskwcnFINTKYPz+fM0LyeXZ6eIXLJ
        46G90qSEWLs85ltLHu7/6XQ8T7t95kK5+U/mvni6OdWRzYT1V2+fXJTX2Y6KI12qScpJz2+c
        e9ozp9j162zxTx5z97cHeVX0zRToszqRnbBU+7LaycAo/d233ZtEUsoCEyKCu1e0aSa2pbe6
        X1E6elhv8jWr+jl/J3/dJyDzdMO1qOeXX3K5Bcp0aFcnRi5ZKNX40ELOU/lPd2v7ieVeXc/d
        016uuL2I5dnCwqRvF4oV2e948i147NKw78W5qmXWFyXMvRUmKPg6zXEtLQ1nZqoI9z9gfKxo
        x+H5PRn5Owqm8sdJCYWaS/j3/NmwLVHodcFSs/9cB9m/OlvJzzBUYinOSDTUYi4qTgQARpyO
        0xcDAAA=
X-CMS-MailID: 20231006064245epcas5p2a2809e2b1db77426d681819c0bcb1a82
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----IKYw8rt4xsi0beZH_Imxy96mvZbFJ64oQ.XZqp2ZTk-1zWLz=_4709d_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231005194154epcas5p2060a3b8cc46eee71e6dd73f1a8b20ab4
References: <20231005194129.1882245-1-bvanassche@acm.org>
        <CGME20231005194154epcas5p2060a3b8cc46eee71e6dd73f1a8b20ab4@epcas5p2.samsung.com>
        <20231005194129.1882245-3-bvanassche@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------IKYw8rt4xsi0beZH_Imxy96mvZbFJ64oQ.XZqp2ZTk-1zWLz=_4709d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Thu, Oct 05, 2023 at 12:40:48PM -0700, Bart Van Assche wrote:
>A later patch will store the data lifetime in the bio->bi_ioprio member
>before the blk-ioprio policy is applied. Make sure that this policy doesn't
>clear more bits than necessary.
>
>Cc: Damien Le Moal <dlemoal@kernel.org>
>Cc: Niklas Cassel <niklas.cassel@wdc.com>
>Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>---
> block/blk-ioprio.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
>index 4051fada01f1..2db86f153b6d 100644
>--- a/block/blk-ioprio.c
>+++ b/block/blk-ioprio.c
>@@ -202,7 +202,8 @@ void blkcg_set_ioprio(struct bio *bio)
> 		 * to achieve this.
> 		 */
> 		if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) != IOPRIO_CLASS_RT)
>-			bio->bi_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 4);
>+			ioprio_set_class_and_level(&bio->bi_ioprio,
>+					IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 4));
> 		return;
> 	}
>
>@@ -213,10 +214,10 @@ void blkcg_set_ioprio(struct bio *bio)
> 	 * If the bio I/O priority equals IOPRIO_CLASS_NONE, the cgroup I/O
> 	 * priority is assigned to the bio.
> 	 */
>-	prio = max_t(u16, bio->bi_ioprio,
>+	prio = max_t(u16, bio->bi_ioprio & IOPRIO_CLASS_LEVEL_MASK,
> 			IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));

All 9 bits (including CDL) are not taking part in this decision making
now. Maybe you want to exclude only lifetime bits.

>-	if (prio > bio->bi_ioprio)
>-		bio->bi_ioprio = prio;
>+	if (prio > (bio->bi_ioprio & IOPRIO_CLASS_LEVEL_MASK))
>+		ioprio_set_class_and_level(&bio->bi_ioprio, prio);

Same as above.


------IKYw8rt4xsi0beZH_Imxy96mvZbFJ64oQ.XZqp2ZTk-1zWLz=_4709d_
Content-Type: text/plain; charset="utf-8"


------IKYw8rt4xsi0beZH_Imxy96mvZbFJ64oQ.XZqp2ZTk-1zWLz=_4709d_--
