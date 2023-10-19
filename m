Return-Path: <linux-fsdevel+bounces-739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ACA7CF810
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59831B21553
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC042031A;
	Thu, 19 Oct 2023 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hNMIyW0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A031EB25
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:24 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F1AD67
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:03:58 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231019120353epoutp02e9ac6626fd9068eb748c8e21aae542c9~PgKW9jFss2730527305epoutp02Z
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:03:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231019120353epoutp02e9ac6626fd9068eb748c8e21aae542c9~PgKW9jFss2730527305epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717033;
	bh=Pnjs48GpM2fNI5vQ32r+zx38m0Ym/uFN2UPMQUh9Xn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNMIyW0Oq3/gGpQGpRI0tjVbaNSM8+QLf+o4o1288jicIa1X8wQILVUQAJvaciOaD
	 aEKXBw4RwrQUWomhnd7uF8jLaUY/k+CW5yt0ej7pWd/73OnIYvYX3h2ASNGOkR3Nha
	 ySdBTyi0kSuTFBsaGUV8dC+oFdQnbxj9JK3DdXKM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231019120353epcas5p2c3d376275f88aa749617249515d4aaba~PgKWSn9ME0651406514epcas5p2_;
	Thu, 19 Oct 2023 12:03:53 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SB5wR2W7jz4x9Ps; Thu, 19 Oct
	2023 12:03:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	41.78.10009.72B11356; Thu, 19 Oct 2023 21:03:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231019110822epcas5p4e09aab7295e48ef885f82dbd0576a584~PfZ4p1gfs2520825208epcas5p4Q;
	Thu, 19 Oct 2023 11:08:22 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019110822epsmtrp23bd0179aca24fb5d4f8cc84fff709c52~PfZ4oxCrn1571815718epsmtrp27;
	Thu, 19 Oct 2023 11:08:22 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-f5-65311b271e9e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.57.07368.62E01356; Thu, 19 Oct 2023 20:08:22 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110819epsmtip16145c708b1f5884719ace0f791f0c46c~PfZ1SRj0v0329303293epsmtip1W;
	Thu, 19 Oct 2023 11:08:19 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Date: Thu, 19 Oct 2023 16:31:29 +0530
Message-Id: <20231019110147.31672-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPfe2t4UMvKDEw2Mb6eIMGGgLLRxA3IZs3Lm5sJltkcRAR69A
	oKX0wWNEBZGRoTzksYVO3qCzbMAAGQ87CKxDIQRN5TmtQ1uDMvGFLAjCWq5s/vf5fc/vffLj
	4s4VHDduglxNK+WSJB5hz+oc9PL22eUupAV9xtdQy/AfOHr8bIWFThS/wFHTzSICzQ8+Acjc
	nwdQTV0lC033d2PoUl0Jhi40GTBkWH9AoJKBCYAs41oM6Wd2o9pvGljokv4KCxl7zhKo+pyF
	g05NdhHo/NAahqaKLQB1mbMB6lypxlHz/EMWujzjjsZeDLHfdaO6tTc51JjpFxZlHNVQbbpv
	Caq94Tg1114BqN7pLIKqLyxlUwU5CwT12DLDoh7+Nk5QhR06QLWPZFJP296g2swPsMitUYl7
	4mmJlFZ60vLYZGmCPC6U99HB6H3R4gCB0EcYhAJ5nnKJjA7lhX8c6fNBQpJ1JTzPVEmSxipF
	SlQqHn/vHmWyRk17xier1KE8WiFNUogUviqJTKWRx/nKaXWwUCDwE1sdYxLjFwuPKvJC042l
	XVgW6PDPB3ZcSIrgdfP3bBs7k70Arpjs84G9lZ8A2FBgZDPGEoBL8yfYmxHZc6dx5kEPYOl1
	I4cxcjFYdOZnkA+4XILcDUfWuTZ9O5mLw74bfwObgZODODTU3iZsqbaRh+E1XS3LxixyJzy/
	vr5RwoEMhrrFCY4tEST5sOiWk022I0Ng66k6nHFxglcqzBuhOPkmzLn4A85012sH524cYTgc
	3mpaAAxvg/eHOjgMu8GnC3qC4TR4oexHwtYbJE8CqJ3Uvgx4B+YOF+G2HnDSC7b08Bn5dVg+
	3IwxdR1hwYoZY3QH2FW1yW/Bn1pqXuZ3hRP/ZBPMKBS89quMWXUhgJ1lMcXAU/vKNNpXptH+
	X7gG4DrgSitUsjhaJVb4yem0/744NlnWBjZuxHt/F5j965HvAMC4YABALs7b7rCTEtDODlJJ
	xte0MjlaqUmiVQNAbN32GdzNJTbZemRydbRQFCQQBQQEiIL8A4S8HQ7zuZVSZzJOoqYTaVpB
	KzfjMK6dWxb2SeJ7xzLGAqdNgdPL1fYHx5Pq6QgQM2gWHPuiLurstL7xHsfv7mBeS6X45LJv
	rirlfZf8xv0iOHDo9NUD/Zfl37X0e/eIQ6bTymcMRepnLL7Hc3VV+fA5wYe3W8M8UiJ+t+Ol
	uejxYFeZwvGuMGdf5dU7zWt7/1yV10RPugateFlmY3UGfmoZ5vXoXubUVxxhRv9ShiakJHNh
	6lPp0P1JpUxbuMAbVWRUGcq2fnbEaa1wzDLL9rCw3zbZOzaOHz4eMdPa1jdSZxLVL0fJF1dz
	/MJGy74U+aZWrzr5hx+6M7ZlKDh+hyw0rDhFpVz4fNfRuAPpfGV3uqn7+Zb8MveL+TyWKl4i
	9MaVKsm/7stzqawEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSnK4an2GqQcMHdYv1p44xW3z8+pvF
	omnCX2aL1Xf72SxeH/7EaPHkQDujxYJFc1ksbh7YyWSxZ9EkJouVq48yWRz9/5bNYtKha4wW
	T6/OYrLYe0vbYmHbEhaLPXtPslhc3jWHzWL+sqfsFt3Xd7BZLD/+j8nixoSnjBY7njQyWmz7
	PZ/ZYt3r9ywWJ25JW5z/e5zVQcpj56y77B7n721k8bh8ttRj06pONo/NS+o9Xmyeyeix+2YD
	m8fivsmsHr3N79g8Pj69xeLxft9VNo++LasYPTafrvb4vEnOY9OTt0wB/FFcNimpOZllqUX6
	dglcGV/6agvabSsuT97B1MC4xbiLkZNDQsBEovFFD3MXIxeHkMBuRomlx36yQyQkJZb9PcIM
	YQtLrPz3nB2iqJlJ4tnx30AJDg42AW2J0/85QOIiAv3MEu/+TmcCcZgFLjNLTFt4hBGkSFgg
	WuL/WkOQQSwCqhLL//9nBbF5BawkVn25xg5SIiGgL9F/XxAkzClgLbGhexHYXiGgkgcLHrND
	lAtKnJz5hAXEZhaQl2jeOpt5AqPALCSpWUhSCxiZVjFKphYU56bnJhsWGOallusVJ+YWl+al
	6yXn525iBMe6lsYOxnvz/+kdYmTiYDzEKMHBrCTCq+phkCrEm5JYWZValB9fVJqTWnyIUZqD
	RUmc13DG7BQhgfTEktTs1NSC1CKYLBMHp1QD08mbnuafNYTf982rcOHdHagd3H95gYJsesr3
	hfq3hXc1/vU7HLX162/tysQNHyXmPTzPoXAzi2vx4urV/bJ+i3y6z/K7TVhq0v78pZpS+myW
	pN/vlerfrln6JyepOuN3fKucenOhwtSb/w7//rxv6zWz+BOSLxJ7PnnZpO7Yd/9LfPbbJcoH
	fs/x4Z+t2r88q1/J3XJPoFIvb3fhyY+TZx1e9WVTSndvl8K9WUvsP757ECC+mmFHkw9n/rRg
	0Xv/LTzSD8acrPx2fJaToceJc0+dbXetkfO8WGMpuU6fdYGj8cXWdVsWBp2bKWlv7cqZ9zy2
	58JqXzd1r8zVRbF5swPf8z+0Xy0bc//QTS0mbSWW4oxEQy3mouJEAF6pBXxkAwAA
X-CMS-MailID: 20231019110822epcas5p4e09aab7295e48ef885f82dbd0576a584
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110822epcas5p4e09aab7295e48ef885f82dbd0576a584
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110822epcas5p4e09aab7295e48ef885f82dbd0576a584@epcas5p4.samsung.com>

Add device limits as sysfs entries,
	- copy_max_bytes (RW)
	- copy_max_hw_bytes (RO)

Above limits help to split the copy payload in block layer.
copy_max_bytes: maximum total length of copy in single payload.
copy_max_hw_bytes: Reflects the device supported maximum limit.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 Documentation/ABI/stable/sysfs-block | 23 ++++++++++++++++++
 block/blk-settings.c                 | 24 +++++++++++++++++++
 block/blk-sysfs.c                    | 36 ++++++++++++++++++++++++++++
 include/linux/blkdev.h               | 13 ++++++++++
 4 files changed, 96 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b..96ba701e57da 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -155,6 +155,29 @@ Description:
 		last zone of the device which may be smaller.
 
 
+What:		/sys/block/<disk>/queue/copy_max_bytes
+Date:		August 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This is the maximum number of bytes that the block layer
+		will allow for a copy request. This is always smaller or
+		equal to the maximum size allowed by the hardware, indicated by
+		'copy_max_hw_bytes'. An attempt to set a value higher than
+		'copy_max_hw_bytes' will truncate this to 'copy_max_hw_bytes'.
+		Writing '0' to this file will disable offloading copies for this
+		device, instead copy is done via emulation.
+
+
+What:		/sys/block/<disk>/queue/copy_max_hw_bytes
+Date:		August 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This is the maximum number of bytes that the hardware
+		will allow for single data copy request.
+		A value of 0 means that the device does not support
+		copy offload.
+
+
 What:		/sys/block/<disk>/queue/crypto/
 Date:		February 2022
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f..4441711ac364 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,8 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->max_copy_hw_sectors = 0;
+	lim->max_copy_sectors = 0;
 }
 
 /**
@@ -82,6 +84,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_copy_hw_sectors = UINT_MAX;
+	lim->max_copy_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -183,6 +187,22 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
+/*
+ * blk_queue_max_copy_hw_sectors - set max sectors for a single copy payload
+ * @q:	the request queue for the device
+ * @max_copy_sectors: maximum number of sectors to copy
+ */
+void blk_queue_max_copy_hw_sectors(struct request_queue *q,
+				   unsigned int max_copy_sectors)
+{
+	if (max_copy_sectors > (BLK_COPY_MAX_BYTES >> SECTOR_SHIFT))
+		max_copy_sectors = BLK_COPY_MAX_BYTES >> SECTOR_SHIFT;
+
+	q->limits.max_copy_hw_sectors = max_copy_sectors;
+	q->limits.max_copy_sectors = max_copy_sectors;
+}
+EXPORT_SYMBOL_GPL(blk_queue_max_copy_hw_sectors);
+
 /**
  * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
  * @q:  the request queue for the device
@@ -578,6 +598,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
 
+	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
+	t->max_copy_hw_sectors = min(t->max_copy_hw_sectors,
+				     b->max_copy_hw_sectors);
+
 	t->misaligned |= b->misaligned;
 
 	alignment = queue_limit_alignment_offset(b, start);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 63e481262336..4840e21adefa 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -199,6 +199,37 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
 	return queue_var_show(0, page);
 }
 
+static ssize_t queue_copy_hw_max_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%llu\n", (unsigned long long)
+		       q->limits.max_copy_hw_sectors << SECTOR_SHIFT);
+}
+
+static ssize_t queue_copy_max_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%llu\n", (unsigned long long)
+		       q->limits.max_copy_sectors << SECTOR_SHIFT);
+}
+
+static ssize_t queue_copy_max_store(struct request_queue *q, const char *page,
+				    size_t count)
+{
+	unsigned long max_copy;
+	ssize_t ret = queue_var_store(&max_copy, page, count);
+
+	if (ret < 0)
+		return ret;
+
+	if (max_copy & (queue_logical_block_size(q) - 1))
+		return -EINVAL;
+
+	max_copy >>= SECTOR_SHIFT;
+	q->limits.max_copy_sectors = min_t(unsigned int, max_copy,
+					   q->limits.max_copy_hw_sectors);
+
+	return count;
+}
+
 static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(0, page);
@@ -517,6 +548,9 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
+QUEUE_RO_ENTRY(queue_copy_hw_max, "copy_max_hw_bytes");
+QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
+
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
@@ -633,6 +667,8 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_copy_hw_max_entry.attr,
+	&queue_copy_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f25982..7548f1685ee9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -309,6 +309,9 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned int		max_copy_hw_sectors;
+	unsigned int		max_copy_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -893,6 +896,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
 extern void blk_queue_max_discard_segments(struct request_queue *,
 		unsigned short);
+extern void blk_queue_max_copy_hw_sectors(struct request_queue *q,
+					  unsigned int max_copy_sectors);
 void blk_queue_max_secure_erase_sectors(struct request_queue *q,
 		unsigned int max_sectors);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
@@ -1211,6 +1216,14 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 	return bdev_get_queue(bdev)->limits.discard_granularity;
 }
 
+/* maximum copy offload length, this is set to 128MB based on current testing */
+#define BLK_COPY_MAX_BYTES		(1 << 27)
+
+static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
+{
+	return bdev_get_queue(bdev)->limits.max_copy_sectors;
+}
+
 static inline unsigned int
 bdev_max_secure_erase_sectors(struct block_device *bdev)
 {
-- 
2.35.1.500.gb896f729e2


