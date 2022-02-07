Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8074AC209
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387620AbiBGOxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390892AbiBGOcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:32:09 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04F5C0401C3
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:32:08 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220207142301epoutp0392a6588c747a99c7cdc4cf160494361e~RhwIDDgO90919709197epoutp03q
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:23:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220207142301epoutp0392a6588c747a99c7cdc4cf160494361e~RhwIDDgO90919709197epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243781;
        bh=ZToRjRwJn34ZzyDg3GTI5a5frORbDpzvx2HVQIjtABY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEVBNja8g2Gsq0NRGnigEkZ/bb60s9RB3315Lau2+9XNb9OZbKKhmvvJsFjFE8rG7
         N1I7Twwr6KhFUUPYpv+JHT8JyT9ifEkWV9mue9UooWQ+kjYpOWWX021sw1BGjHydYH
         ZBgPZ+i0h3YC1oCAL5CLy5DWIbCqtnv3NN0P/WAw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220207142300epcas5p12234e1ca79163589c3076cd92d89717c~RhwHTuydG0954809548epcas5p1y;
        Mon,  7 Feb 2022 14:23:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JspJc28mZz4x9Px; Mon,  7 Feb
        2022 14:22:56 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.C5.05590.5FA21026; Mon,  7 Feb 2022 23:21:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220207141930epcas5p2bcbff65f78ad1dede64648d73ddb3770~RhtDWlMgg1158611586epcas5p2M;
        Mon,  7 Feb 2022 14:19:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220207141930epsmtrp21b9db411c3a7e6b4f999cb91f5d68f68~RhtDVVysP0696106961epsmtrp2U;
        Mon,  7 Feb 2022 14:19:30 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-76-62012af5077e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.43.08738.27A21026; Mon,  7 Feb 2022 23:19:30 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141926epsmtip102d2e45931c03e67130238beb97316d9~Rhs-lY_vs0283802838epsmtip1d;
        Mon,  7 Feb 2022 14:19:26 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     mpatocka@redhat.com
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nj.shetty@samsung.com
Subject: [PATCH v2 05/10] block: add emulation for copy
Date:   Mon,  7 Feb 2022 19:43:43 +0530
Message-Id: <20220207141348.4235-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220207141348.4235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTfd2+5LSTAHY/0k2kk100jhELH64MILoh6N+YkcZpFJ1jgCgxo
        m5ai6JaBnVFggLDgsGxaBMczQoAVxjOUMQKUBcZLmMwhOB1gQWCjPAYrvZ3zv9853+93fuec
        L4eH21VxnXix4kRGJhbFU4QVR9Oxf5/bXy4gwqOjhUDNY0sWqGIim0A3F1ZxNN8+ZYFys/O5
        aHDaBrXoCyxQvyEVQ1M1WxhqvpuLobKKTgw9LSkCKK23H0Mbk0LUufWcQLnaEYBaxl1Rc0s3
        B9357gkXZYw2EKh1tgVHJV2bGMq5Poyhn1UbBNKs38FRx2/DHFSxgdDVL1e5aKYt7J1d9OBQ
        CJ2j1HNppfohhx7sU9A15WkEXVv8Of3VgxJAN42lEPQVXSdO5y8uE/Sorh6jM5V6gn7xZJxD
        ayYzufR86zBBZ9WVg1CH03EHYhhRFCNzZsSRkqhYcXQAFXIi/FC4t4+H0E3oh3wpZ7EogQmg
        gt8PdTsSG29cEuWcJIpXGFOhIrmccg88IJMoEhnnGIk8MYBipFHxUi+pQC5KkCvE0QIxk+gv
        9PB429tIPBcXU9dzXKqmLpYOfANSQMkb6cCSB0kvONWfR6QDK54d2QTgr6szgA0WAUx7vsZl
        gyUA5364a5EOeCZJaXckm28EcFM1gbPBVQz+VNCHbZMI0hX2bvG2LRxIPtzo15iq4uQSB46M
        qrjbD/akLyxqHTNhDvkWXOju5Wxja9IPDui7Mba/PbBwst1iG1uS/vDvjZtmzuuw+9a0CePk
        bqj8vsDUBCTHLeEXhU1mcTD8c7rSjO3hTFcdl8VOcEnfQrCCDAANukcYG+QDqLyhJFjWQTjQ
        /I9pHJzcD6sa3dn0LpjXcx9jnW1g5vq02cAaNtyeftl1ZZXaXGYHHFlJNWMaZn3bxmHXNWTc
        9sRTzg3grHplItUrE6n+t1YDvBzsYKTyhGhG7i31FDMXXn5zpCShBpguxyWkATz+fUGgBRgP
        aAHk4ZSD9c6MLZGddZQo+RIjk4TLFPGMXAu8jSvPwZ0cIyXG0xMnhgu9/Dy8fHx8vPw8fYQU
        37onulpkR0aLEpk4hpEysv90GM/SKQU7qsuyr68endN6NH7mdqx2ZRN/YTi1Nz/nXnbcwQ8W
        bR88qqF+3Dor0SaUVrcmh5R38nuG6pK4XJtPu/gnl08f1swarvvWHgry5tD2r0lLYorVmbub
        jzTlwSESZZY9DLKNSHL/xL908dnX89SxwLV2R9c3e2eBwCpK88dy4AKa+viocH1dnXL58tyl
        gYiMD/uqYt7VD0ZHPLMpCP7IxxCmWOnx25N6IVVxsidsn9Ps5rWiRV1Rh8PY4aCL1mPUL15t
        J9pCiqnhMJWbgHveYi//Mb978egZ22vvXQleZc4OClIjz6m154/fu6XrTe5fK6w8M3NKbRDw
        lz1vx9XvdBy7j5VRHHmMSOiCy+SifwG2PN8jwgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCSnG6RFmOSwe7zohZ7bn5mtVh9t5/N
        YtqHn8wW7w8+ZrWY1D+D3eLyEz6Lve9ms1pc+NHIZPF4038miz2LJjFZrFx9lMni+fLFjBad
        py8wWfx5aGhx9P9bNotJh64xWuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaL5cf/MVlM7LjK
        ZHFu1h82i22/5zNbHL53lcVi9R8Li9aen+wWr/bHOch6XL7i7TGx+R27R/OCOywel8+Wemxa
        1cnmsXlJvcfkG8sZPXbfbGDzaDpzlNljxqcvbB7Xz2xn8uhtfsfm8fHpLRaPbQ972T3e77vK
        5tG3ZRVjgEgUl01Kak5mWWqRvl0CV8aWU/4FC5QqVlycw9jAuFy6i5GDQ0LARGLFyeQuRi4O
        IYEdjBI7vu5n7WLkBIpLSiz7e4QZwhaWWPnvOTuILSTQzCSx9ZI5SC+bgLbE6f8cIGERAXGJ
        Pxe2MYLMYRaYzirRcOoyE0hCWMBcYvG+m2C9LAKqEh9OnmYBsXkFLCUuvjvJBDFfWWLhw4Ng
        ezkFrCS+/ZnGAnFQA6NEw7kVrBANghInZz4Ba2YWkJdo3jqbeQKjwCwkqVlIUgsYmVYxSqYW
        FOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSnAy2tHYx7Vn3QO8TIxMF4iFGCg1lJhFem+3+i
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUx5crHi3+8+
        fhthHJAWGPz/3eUVmi128RHH63sV5x7/VeS2eEeU98HWZWwf71ye99HmhU2Or9W/4qB7R5rv
        L2Y9OnvZpfbJ7uf/H3e9uJWx9+hE7bMC6ffKz347dLFk9e21kQ3TFqU/1mF7l5V7bcvGefcW
        3PHZ16xmxxEV8KfN2M5SSXull2f2GoYCa5HX0zS9v1w0sn6S7sTO+zpLL31r+DHt4+zRtecv
        Tg+oj56terVF6uP36zNYn2fZ/w2fXce1aell/ZkfS24/yfvIHG85eea67yybGhMP/vD6q5DY
        //NLwp/TTvskXwhV7G6urbzR07dcumx57L6eVv6ycMPVPuI1dw57am/Pn1V8+26DEktxRqKh
        FnNRcSIANdWiInYDAAA=
X-CMS-MailID: 20220207141930epcas5p2bcbff65f78ad1dede64648d73ddb3770
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141930epcas5p2bcbff65f78ad1dede64648d73ddb3770
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141930epcas5p2bcbff65f78ad1dede64648d73ddb3770@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the devices which does not support copy, copy emulation is
added. Copy-emulation is implemented by reading from source ranges
into memory and writing to the corresponding destination synchronously.

TODO: Optimise emulation.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-lib.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3ae2c27b566e..05c8cd02fffc 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -272,6 +272,65 @@ int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
 	return cio_await_completion(cio);
 }
 
+int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
+				sector_t sector, unsigned int op, gfp_t gfp_mask)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio, *parent = NULL;
+	sector_t max_hw_len = min_t(unsigned int, queue_max_hw_sectors(q),
+			queue_max_segments(q) << (PAGE_SHIFT - SECTOR_SHIFT)) << SECTOR_SHIFT;
+	sector_t len, remaining;
+	int ret;
+
+	for (remaining = buf_len; remaining > 0; remaining -= len) {
+		len = min_t(int, max_hw_len, remaining);
+retry:
+		bio = bio_map_kern(q, buf, len, gfp_mask);
+		if (IS_ERR(bio)) {
+			len >>= 1;
+			if (len)
+				goto retry;
+			return PTR_ERR(bio);
+		}
+
+		bio->bi_iter.bi_sector = sector >> SECTOR_SHIFT;
+		bio->bi_opf = op;
+		bio_set_dev(bio, bdev);
+		bio->bi_end_io = NULL;
+		bio->bi_private = NULL;
+
+		if (parent) {
+			bio_chain(parent, bio);
+			submit_bio(parent);
+		}
+		parent = bio;
+		sector += len;
+		buf = (char *) buf + len;
+	}
+	ret = submit_bio_wait(bio);
+	bio_put(bio);
+
+	return ret;
+}
+
+static void *blk_alloc_buf(sector_t req_size, sector_t *alloc_size, gfp_t gfp_mask)
+{
+	int min_size = PAGE_SIZE;
+	void *buf;
+
+	while (req_size >= min_size) {
+		buf = kvmalloc(req_size, gfp_mask);
+		if (buf) {
+			*alloc_size = req_size;
+			return buf;
+		}
+		/* retry half the requested size */
+		req_size >>= 1;
+	}
+
+	return NULL;
+}
+
 static inline int blk_copy_sanity_check(struct block_device *src_bdev,
 		struct block_device *dst_bdev, struct range_entry *rlist, int nr)
 {
@@ -297,6 +356,64 @@ static inline int blk_copy_sanity_check(struct block_device *src_bdev,
 	return 0;
 }
 
+static inline sector_t blk_copy_max_range(struct range_entry *rlist, int nr, sector_t *max_len)
+{
+	int i;
+	sector_t len = 0;
+
+	*max_len = 0;
+	for (i = 0; i < nr; i++) {
+		*max_len = max(*max_len, rlist[i].len);
+		len += rlist[i].len;
+	}
+
+	return len;
+}
+
+/*
+ * If native copy offload feature is absent, this function tries to emulate,
+ * by copying data from source to a temporary buffer and from buffer to
+ * destination device.
+ */
+static int blk_copy_emulate(struct block_device *src_bdev, int nr,
+		struct range_entry *rlist, struct block_device *dest_bdev, gfp_t gfp_mask)
+{
+	void *buf = NULL;
+	int ret, nr_i = 0;
+	sector_t src, dst, copy_len, buf_len, read_len, copied_len, max_len = 0, remaining = 0;
+
+	copy_len = blk_copy_max_range(rlist, nr, &max_len);
+	buf = blk_alloc_buf(max_len, &buf_len, gfp_mask);
+	if (!buf)
+		return -ENOMEM;
+
+	for (copied_len = 0; copied_len < copy_len; copied_len += read_len) {
+		if (!remaining) {
+			rlist[nr_i].comp_len = 0;
+			src = rlist[nr_i].src;
+			dst = rlist[nr_i].dst;
+			remaining = rlist[nr_i++].len;
+		}
+
+		read_len = min_t(sector_t, remaining, buf_len);
+		ret = blk_submit_rw_buf(src_bdev, buf, read_len, src, REQ_OP_READ, gfp_mask);
+		if (ret)
+			goto out;
+		src += read_len;
+		remaining -= read_len;
+		ret = blk_submit_rw_buf(dest_bdev, buf, read_len, dst, REQ_OP_WRITE,
+				gfp_mask);
+		if (ret)
+			goto out;
+		else
+			rlist[nr_i - 1].comp_len += read_len;
+		dst += read_len;
+	}
+out:
+	kvfree(buf);
+	return ret;
+}
+
 static inline bool blk_check_copy_offload(struct request_queue *src_q,
 		struct request_queue *dest_q)
 {
@@ -346,6 +463,8 @@ int blkdev_issue_copy(struct block_device *src_bdev, int nr,
 
 	if (blk_check_copy_offload(src_q, dest_q))
 		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
+	else
+		ret = blk_copy_emulate(src_bdev, nr, rlist, dest_bdev, gfp_mask);
 
 	return ret;
 }
-- 
2.30.0-rc0

