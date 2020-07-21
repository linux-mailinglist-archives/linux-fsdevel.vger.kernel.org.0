Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1CA228080
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 15:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGUNCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 09:02:45 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47769 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgGUNCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:02:44 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200721130240epoutp045ea99a410cd1284b14dfca99f3e08082~jxiZP5s570260102601epoutp048
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 13:02:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200721130240epoutp045ea99a410cd1284b14dfca99f3e08082~jxiZP5s570260102601epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595336560;
        bh=NH9wpyCevd6tdTMAvvlpkRQBPadD95ZpMq4wOph5JTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=btNPpeMwXhJnouB83tJcCQ7pEwB4sr4E/YhXI7M9MAKqpTSnvp9kTjYrDtucCuzmV
         HZ/5DSOMQAvA9CopGpOp6eHcIORS1S63UcL/DKHEDA69yVfuWa5C22BXc0/r5XCWUh
         fI8X0tyRYRCr1UeyCpt67ffbqhWGLZfqIkq3QD0w=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200721130240epcas5p2d3e9666920e1e30be15033b708fe394e~jxiYl5LzM2146321463epcas5p2W;
        Tue, 21 Jul 2020 13:02:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.D8.09475.F67E61F5; Tue, 21 Jul 2020 22:02:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200721124642epcas5p1bce3e2aa2fa603240b41d75d28e23e0e~jxUcdcVIg0031300313epcas5p13;
        Tue, 21 Jul 2020 12:46:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200721124642epsmtrp212cff39b474e25fe7a53b21432fd79be~jxUccxVIH1310613106epsmtrp2M;
        Tue, 21 Jul 2020 12:46:42 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-c9-5f16e76f8c3f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.96.08303.2B3E61F5; Tue, 21 Jul 2020 21:46:42 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200721124641epsmtip29f9adff10d406ff1af92893b97e50306~jxUbbl0Ys1392513925epsmtip2W;
        Tue, 21 Jul 2020 12:46:41 +0000 (GMT)
Date:   Tue, 21 Jul 2020 18:13:43 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Message-ID: <20200721122724.GA17629@test-zns>
MIME-Version: 1.0
In-Reply-To: <20200720132118.10934-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7bCmlm7Bc7F4g2nbmCxW3+1ns2ht/8Zk
        sXL1USaLv133mCz23tK22LP3JIsDm8fls6Ueu282sHl83iTn0X6gmymAJYrLJiU1J7MstUjf
        LoEr483e24wFkyQqZt59xNTAeFKoi5GTQ0LARGJ2z0LmLkYuDiGB3YwSryY/h3I+MUp8XzaT
        DcL5zChxc8ZPJpiW1cvmskIkdjFKHFlzmAXCeQbkdHWAVbEIqEp0dewDSnBwsAloSlyYXAoS
        FhEwlrjyfSFYPbPACkaJMxMvs4MkhAUcJHYtWMMGYvMK6Eq8XXSJBcIWlDg58wmYzQlUs/lU
        FyOILSqgLHFg23EmkEESAh/ZJba/PcwCcZ6LROeTZjYIW1ji1fEt7BC2lMTnd3uh4sUSv+4c
        ZYZo7mCUuN4wE6rZXuLinr9gHzALZEo0dL6BapCVmHpqHVScT6L39xNoWPBK7JgHYytK3Jv0
        lBXCFpd4OGMJlO0hsfZLNzRUTzJK/F5zhHECo/wsJN/NQrIPwraS6PzQxDoLGHrMAtISy/9x
        QJiaEut36S9gZF3FKJlaUJybnlpsWmCcl1quV5yYW1yal66XnJ+7iRGcdrS8dzA+evBB7xAj
        EwfjIUYJDmYlEd6JPMLxQrwpiZVVqUX58UWlOanFhxilOViUxHmVfpyJExJITyxJzU5NLUgt
        gskycXBKNTCdDejVE7Gr4jl69o/F4brN/Jl8UoGqSyxcZ8eWW3LMn58yK0DB+iLvAr5f57iK
        r/ocsrvDtknU20YtPTnXcHa319sQ8zbWggtZwYnfZtz8tNjK7zTLE5mE/HU6J7+8YRVPZNlh
        /JI7/a6KcARX7fcMAxu9bR33y+U0RYJl4qSU532oejGpceKPc478Fl0BhffLzcs+B78XDF8T
        IutQn9xqzMZqxtwSFC+tpKWn+is0M7My78gW06q5m7Wn/LL+8CTz/eVdyhWxTl+kl1yUEw+U
        PHghSnPlySw7Cf4plo/N+Ffs+LEkZ5HyBZ8r9+Z4G/h9ZOn5VxIS6/PsyJlbk1T2+x07mHBI
        lWnprmW8SizFGYmGWsxFxYkAlxmwcKoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvO6mx2LxBve3sVusvtvPZtHa/o3J
        YuXqo0wWf7vuMVnsvaVtsWfvSRYHNo/LZ0s9dt9sYPP4vEnOo/1AN1MASxSXTUpqTmZZapG+
        XQJXxpKNFQUHRSvOPJ7H3sA4SaCLkZNDQsBEYvWyuaxdjFwcQgI7GCXuvv/EDpEQl2i+9gPK
        FpZY+e85O0TRE0aJ6zuuM4EkWARUJbo69rF0MXJwsAloSlyYXAoSFhEwlrjyfSELSD2zwApG
        iUN3r7OCJIQFHCR2LVjDBmLzCuhKvF10iQVi6ElGidarJ9ghEoISJ2c+YQGxmQXMJOZtfsgM
        soBZQFpi+T8OkDAn0JzNp7oYQWxRAWWJA9uOM01gFJyFpHsWku5ZCN0LGJlXMUqmFhTnpucW
        GxYY5aWW6xUn5haX5qXrJefnbmIEh7qW1g7GPas+6B1iZOJgPMQowcGsJMI7kUc4Xog3JbGy
        KrUoP76oNCe1+BCjNAeLkjjv11kL44QE0hNLUrNTUwtSi2CyTBycUg1Ml30Zvh+fvyu428OQ
        y/jON2v/r1cMWA7uFX9rO7Ffpaj22A5JIeUtcSIvp/8okZ7d4/8/oF9PaPm5WJPUOaFhlion
        Wqa1Jjgdv71snVFX01EpE+dl+5OSJ1a4m8wVmMm4/4a+8V3vnJjbGyNeFOa48T+6+u7IWzO7
        tC8Fe4Rkk2L0b05Rn7256GJ85I5ZtR8zc78dC+3+W/nbuu/pB0X9ntn989marulFLzSafV/F
        quhWZWaKruaJy3f+HgoyShWfpVdzX+XR1u0b5x+7N/9y8ITybb8mvn0hM/HiPYcHM52O7U68
        2ep6+MV2y4VNK2PW5Tf0hPTlaGtnX5mXvczk0oV67mNb1rR+e361waz7khJLcUaioRZzUXEi
        AAR9DvrkAgAA
X-CMS-MailID: 20200721124642epcas5p1bce3e2aa2fa603240b41d75d28e23e0e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----HLsVUhwo1NnMf0MkEybe_TfPnfOwGw2mguf7MLxPvWAMWj5A=_129dcd_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200720132131epcas5p390f6f8a13696a3f54ef906d8ce8cc0ea
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
        <CGME20200720132131epcas5p390f6f8a13696a3f54ef906d8ce8cc0ea@epcas5p3.samsung.com>
        <20200720132118.10934-3-johannes.thumshirn@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------HLsVUhwo1NnMf0MkEybe_TfPnfOwGw2mguf7MLxPvWAMWj5A=_129dcd_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:
>If we get an async I/O iocb with an O_APPEND or RWF_APPEND flag set,
>submit it using REQ_OP_ZONE_APPEND to the block layer.
>
>As an REQ_OP_ZONE_APPEND bio must not be split, this does come with an
>additional constraint, namely the buffer submitted to zonefs must not be
>bigger than the max zone append size of the underlying device. For
>synchronous I/O we don't care about this constraint as we can return short
>writes, for AIO we need to return an error on too big buffers.

I wonder what part of the patch implements that constraint on large
buffer and avoids short-write.
Existing code seems to trim iov_iter in the outset. 

        max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
        max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
        iov_iter_truncate(from, max);

This will prevent large-buffer seeing that error, and will lead to partial write.

>On a successful completion, the position the data is written to is
>returned via AIO's res2 field to the calling application.
>
>Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>---
> fs/zonefs/super.c  | 143 +++++++++++++++++++++++++++++++++++++++------
> fs/zonefs/zonefs.h |   3 +
> 2 files changed, 128 insertions(+), 18 deletions(-)
>
>diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>index 5832e9f69268..f155a658675b 100644
>--- a/fs/zonefs/super.c
>+++ b/fs/zonefs/super.c
>@@ -24,6 +24,8 @@
>
> #include "zonefs.h"
>
>+static struct bio_set zonefs_dio_bio_set;
>+
> static inline int zonefs_zone_mgmt(struct zonefs_inode_info *zi,
> 				   enum req_opf op)
> {
>@@ -700,16 +702,71 @@ static const struct iomap_dio_ops zonefs_write_dio_ops = {
> 	.end_io			= zonefs_file_write_dio_end_io,
> };
>
>+struct zonefs_dio {
>+	struct kiocb		*iocb;
>+	struct task_struct	*waiter;
>+	int			error;
>+	struct work_struct	work;
>+	size_t			size;
>+	u64			sector;
>+	struct completion	completion;
>+	struct bio		bio;
>+};

How about this (will save 32 bytes) - 
+struct zonefs_dio {
+       struct kiocb            *iocb;
+       struct task_struct      *waiter;
+       int                     error;
+	union {
+       	struct work_struct      work;   //only for async IO
+       	struct completion       completion; //only for sync IO
+	};
+       size_t                  size;
+       u64                     sector;
+       struct bio              bio;
+};
And dio->error field is not required.
I see it being used at one place -
+       ret = zonefs_file_write_dio_end_io(iocb, dio->size,
+                                          dio->error, 0);
Here error-code can be picked from dio->bio.

------HLsVUhwo1NnMf0MkEybe_TfPnfOwGw2mguf7MLxPvWAMWj5A=_129dcd_
Content-Type: text/plain; charset="utf-8"


------HLsVUhwo1NnMf0MkEybe_TfPnfOwGw2mguf7MLxPvWAMWj5A=_129dcd_--
