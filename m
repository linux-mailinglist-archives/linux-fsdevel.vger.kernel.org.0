Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4C70BB7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjEVLRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjEVLPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:15:46 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA510D4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 04:10:52 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230522111051epoutp0341c2b6b1c24c9e6b3fde34f8f81ddead~hcrOMj1NJ1227912279epoutp03w
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 11:10:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230522111051epoutp0341c2b6b1c24c9e6b3fde34f8f81ddead~hcrOMj1NJ1227912279epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684753851;
        bh=1P2BJZZ/eKH4o2N5bmfZBmLKhHrfzdv6MvJHTRtfiUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLE+yCJo8rvze8zKIR8qt3EOxKGuGd03XPUXqBHnhPs1YE3N0sLxRcSK2P5eWlrjq
         4wd+Du4UGcQIEuOHc9pL7PX+sxhrubgdkZMF78VBXxodKUC5dBvyGzVjcXWjgLSjNQ
         9m96fpyinsxILizzTk/Bie6+VYhmXsBYJgPpWARQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230522111050epcas5p21210becde80901bedfb5279ff1dc37df~hcrNhmLR22481324813epcas5p20;
        Mon, 22 May 2023 11:10:50 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QPvrS5yCpz4x9Q2; Mon, 22 May
        2023 11:10:48 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.03.54880.8BD4B646; Mon, 22 May 2023 20:10:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230522104648epcas5p2286a988d89b1befdb49984ebbefb25fd~hcWON8qBh1654016540epcas5p2X;
        Mon, 22 May 2023 10:46:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230522104647epsmtrp2f54f4efe0a6063ed075b8ef1db5011c5~hcWOMewuQ3249732497epsmtrp2V;
        Mon, 22 May 2023 10:46:47 +0000 (GMT)
X-AuditID: b6c32a49-8c5ff7000001d660-e1-646b4db84c65
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.FF.28392.7184B646; Mon, 22 May 2023 19:46:47 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230522104643epsmtip2f74158f3b9d3a6a02b917f21da70e2c6~hcWKbW10-1645716457epsmtip23;
        Mon, 22 May 2023 10:46:43 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v11 7/9] dm: Add support for copy offload
Date:   Mon, 22 May 2023 16:11:38 +0530
Message-Id: <20230522104146.2856-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230522104146.2856-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOd045LWQdR8DsA6MrNQsD5VIs3VeFMQcxB5kRtmXJbikdPdAO
        elkvwkg2uekyGPdJZsVxW5Q7chnBAtPVaLnI2GSANOEyUqYTBVuygWmQFQ5u/nve532f5718
        +Ti4Vxfbj6NQ6WmtSprOJzxYPTcCA4J7T6TJwizzwah9+BaOqtpbCJRbuoGj5pkSAi3dcABU
        +fgJjuavRaOB5QtuaPr6VQz115VjqLH5JoY6Sjior9aOoZubjwhUbp4EaHHCiKEB6wHUPzDE
        QuOmKgLNtmy6oepLi2xUONVLoMuWpxgyV+RhqNeWA1CPsxpHbUsrLDRo3YPGNixuyLleRbyx
        jxr/PZ4yzo0S1FXjDJsam+1gUZXlwwTV1RBEjY8aqM6mrwmq01HOpga/c7Korh9OU33T2QRV
        lLdMUPZFK4ta+WmCoIq7m0CC9wdpkXJaKqO1PFqVrJYpVKlR/Ph3JDGSCFGYIFggRq/xeSqp
        ko7ix76VEHxMke66FJ93SppucFEJUp2OH/p6pFZt0NM8uVqnj+LTGlm6RqgJ0UmVOoMqNURF
        6w8LwsLCI1yFSWlyW3090HT7ZS7cH8SzgWl3AeBwICmEFbPHC4AHx4vsA/CPvAIWEzgAzLWv
        4kywCuDI5ogr476t6OyZIJiECcC6jvkdyRkMNhSbiS1fgjzgUnC2eB/ShsNHpofbVjhpwWHp
        pSF8q8ibFMOLDUe2XFnkK/DsrI3YwlwX7VzKZjPzhcKSuV1btDt5GN7/zYgzJbvg0Hnb9kA4
        +TLM+/HCtj0kre6w/O88wEwaC2dMcwSDveEDSzebwX5wdXlgh8+Ajd82EIw4H0DjlHFHHA3P
        DJdsz4mTgbDdFMrQe+G54TaMafwiLHLaMIbnwt7vn+H9sKW9ZsffF06u5exgCl4ZzQbMsYoA
        bB7oxEsBz/jcQsbnFjL+37oG4E3Al9bolKm0LkIjUNEZ/71yslrZCbZ/T1BcL5iZfxxiBhgH
        mAHk4HwfbmJxssyLK5N+nkVr1RKtIZ3WmUGE6+BluN/uZLXr+6n0EoFQHCYUiURC8SGRgP8S
        NyBqKNmLTJXq6TSa1tDaZzqM4+6XjbFb1XFvn1dc7MhsXKuozyJjJIX9eyYcnu8FfLGwiEWm
        3Lu7Ul+zz6JcJBf//CRJVY3Nm86K162Zp0v/Wm+w/nziTjTt7xdbebtKQ7w/9+mdUVvWUYX8
        BSV3qqIsUSiqqxB+lOCWlfPVUenkA3sbf/7Jl0v9q85aedX0kbZ7ilNlYebjafkHr3mghZMG
        n2NLI++mhPs74vsCp1Kk6zGv2mvF/p9x6/4xrG2A5F8Syk46UmMPDufg+YmHHp5T1uR+Yw5v
        tP+693ZnvU3PI64kZTUO1zSlf4yI2rU3PVsLUyRuyylDXdefxo2Jl1vd+i/n5qbdpTm+nhmJ
        CV23rCsf+vtb+CydXCoIwrU66b+C/c1ixgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxiAc+65Pb1tbHYtLhyozqXGmcAG07h4pmaQuZmzEXVsfscEG7gB
        AoWuBRGdUq1zW5kUixi9lLhVg1BQIiArApUUlOJHWkTU8rk5GBiiAi4ZlCCzwyX+e/M8z/v+
        ejmoHGHDudSMLEGfoUlXIzlb36pe+kEoTUv6sGzkI1J96yYktuoqRI4WzkJS2W9BZKx1EpDT
        49OQ/H49hjQ/K5EQf0sDQ5rsVoZUVN5gyBULRxp/nWDIjbmniFjdDwAZ7hYZ0twTSZqaO1jS
        dc2GyEDVnIScKxuWkvyHTkQutr9kiLvIxBDn0BFA6mfOQXJ57DlLPD0q4p1tl5CZKRuKfYd2
        3Y+j4uBdRBvEfin1Dlxh6WnrLURryyNo191sWuP4CdGaSauUes7MsLT2Qh5t9BsRPWF6hujE
        cA9Ln7u6ES2oc4CvQnbL1ycJ6an7BH30J3vlKUPnzwNdXfj+x6MeaATX3jYDGYf51bimvhuZ
        gZxT8k6AS1weOC/CcNls2+s5BFe8HJHORyYGn3L+xZoBxyE+Et+e44J8ET8OcXWdHQQXIN8L
        cf3DncEmhP8Yl5avC2KWX46PDwyh4Kx4hWfGjNJggvlobBlcGMQyfi0e7RRhECtfJYVlq+br
        hbjj7BA7f3wpNl0tgYWAF99Q4hvqF8A4QJigM2iTtYaVulUZQk6UQaM1ZGckRyVmamvAf78Q
        EeEETY7xKDdgOOAGmIPqRYr4gsQkpSJJk3tA0Gcm6LPTBYMbqDhWHarwmTsSlHyyJktIEwSd
        oP/fMpws3MjkS9Y3+r++VHgk50fNFicf6MaPmh+FlbgKVNAnk8E/59r+8cZuMm1cdu/yVjuc
        2FXeN+rc9eVJ3b2EkRfvxuRsPbnG8NbqS1x82zd/L3O7OzYuMG0JfV+ieLDkhbI1zlGMHw/q
        i/fkLn6y7kRfnmyxTdX03W3UcrMoIM93icdO7XXHBIpyI9c2lF/Pq+3foFnzaZXecfhoWq+r
        9z2Zjynt82pt8Snx49/emUr94ucfVkz64zZb4wKJxb2+YZNYamy3+4ySCf/n0xd/s6dFWjot
        nSvaLfe37cjpjF1waEfFweh9Kteh2emsxpbM/YG6zxo8ZGr7btGrvTMt5oWaK0u//0PNGlI0
        KyOg3qD5F3kRmWl6AwAA
X-CMS-MailID: 20230522104648epcas5p2286a988d89b1befdb49984ebbefb25fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230522104648epcas5p2286a988d89b1befdb49984ebbefb25fd
References: <20230522104146.2856-1-nj.shetty@samsung.com>
        <CGME20230522104648epcas5p2286a988d89b1befdb49984ebbefb25fd@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before enabling copy for dm target, check if underlying devices and
dm target support copy. Avoid split happening inside dm target.
Fail early if the request needs split, currently splitting copy
request is not supported.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-table.c         | 41 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  7 ++++++
 include/linux/device-mapper.h |  5 +++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 1398f1d6e83e..b3269271e761 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1867,6 +1867,39 @@ static bool dm_table_supports_nowait(struct dm_table *t)
 	return true;
 }
 
+static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
+				      sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !blk_queue_copy(q);
+}
+
+static bool dm_table_supports_copy(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	for (i = 0; i < t->num_targets; i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->copy_offload_supported)
+			return false;
+
+		/*
+		 * target provides copy support (as implied by setting
+		 * 'copy_offload_supported')
+		 * and it relies on _all_ data devices having copy support.
+		 */
+		if (!ti->type->iterate_devices ||
+		     ti->type->iterate_devices(ti,
+			     device_not_copy_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -1949,6 +1982,14 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->limits.discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_copy(t)) {
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
+		q->limits.max_copy_sectors = 0;
+		q->limits.max_copy_sectors_hw = 0;
+	} else {
+		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
+	}
+
 	if (!dm_table_supports_secure_erase(t))
 		q->limits.max_secure_erase_sectors = 0;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3b694ba3a106..ab9069090a7d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1720,6 +1720,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	if (unlikely(ci->is_abnormal_io))
 		return __process_abnormal_io(ci, ti);
 
+	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
+			max_io_len(ti, ci->sector) < ci->sector_count)) {
+		DMERR("Error, IO size(%u) > max target size(%llu)\n",
+			ci->sector_count, max_io_len(ti, ci->sector));
+		return BLK_STS_IOERR;
+	}
+
 	/*
 	 * Only support bio polling for normal IO, and the target io is
 	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index a52d2b9a6846..04016bd76e73 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -398,6 +398,11 @@ struct dm_target {
 	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
 	 */
 	bool needs_bio_set_dev:1;
+
+	/*
+	 * copy offload is supported
+	 */
+	bool copy_offload_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.35.1.500.gb896f729e2

