Return-Path: <linux-fsdevel+bounces-742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08B7CF818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5701C20FBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D629C225B3;
	Thu, 19 Oct 2023 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i11LTIcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB621375
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:33 +0000 (UTC)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCC81708
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:05 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231019120403epoutp03adce92f130e0c950982791a5a22cb0e5~PgKf29yNW2900429004epoutp03p
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231019120403epoutp03adce92f130e0c950982791a5a22cb0e5~PgKf29yNW2900429004epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717043;
	bh=co+9TgP5yUjiGDtqASAf2IAo56nzxtAjKELuu/tyfJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i11LTIcM5cFi8sl1rOqX7OBe1SuPTR/HuZ25TftuVYcUq5TGdQX3t/Lgr3qEN3rsD
	 kRS4N9aYhro6+jNVT5w+O7M/eOj59jFuNiSsBPvS5eWueENS9rfSCHUGBR9mIjKaYb
	 WDTFkl1+/2Q3Tb9tiDq9sdwnbLBMezlzPZshX7y0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231019120402epcas5p464d0e2b3f29e245840d41a609a9d8fc9~PgKfVJbXe0467704677epcas5p4r;
	Thu, 19 Oct 2023 12:04:02 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SB5wd1Hxhz4x9Py; Thu, 19 Oct
	2023 12:04:01 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.78.10009.13B11356; Thu, 19 Oct 2023 21:04:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231019110853epcas5p42d50a676bb3168956edc4b87f3dd80c2~PfaVrxnb-2742527425epcas5p45;
	Thu, 19 Oct 2023 11:08:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019110853epsmtrp280eadbad3ddb1c91c5ea10419eb3cc7c~PfaVq3v5O1571815718epsmtrp2d;
	Thu, 19 Oct 2023 11:08:53 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-14-65311b31649f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F8.C9.08755.54E01356; Thu, 19 Oct 2023 20:08:53 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110850epsmtip15c04b58c22d3d2d4eeac6a0963c066f0~PfaSfSIGK2856028560epsmtip1G;
	Thu, 19 Oct 2023 11:08:50 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Vincent Fu
	<vincent.fu@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 04/12] block: add emulation for copy
Date: Thu, 19 Oct 2023 16:31:32 +0530
Message-Id: <20231019110147.31672-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPb23l6KruzzUA2SuqzGbdkDLgB1QNl8zFzUGppnJYgYNvaEI
	tE1bEM2moKtbgQIKE6gIDGFCmYDASC0UtCAVFmCGCchTpWxsaDt8LUCYayls/vf5fX/v38lh
	Ye55Lt6sOImSlkuECVxiNd7UvuVdX4GPgOZbq5motrsTQ7MvFnB0JmcRQ9Vj2QSaaX8KkOXm
	NwCVll3G0f2bNxioqvo2A10wDQA0dU/LQMZhHvr+XDmOWoxdOOo3FBGo5IcpF5QxqCfQVfM/
	DDSUMwWQ3pIGUNNCCYZqZmw4ujPsgyYzvgWob9HM3OFF3dCOuVB949dxqr8niarXqQmqofw0
	Nd1QCKjm+6kEdSUrl0lpzloJanZqGKdsrfcIKqtRB6hn9RupessTRsTaz+O3i2mhiJZzaEmM
	VBQniQ3j7j8UtTsqKJgv8BWEoA+5HIkwkQ7j7jkQ4bs3LsF+CS4nWZiQZJcihAoF1/+j7XJp
	kpLmiKUKZRiXlokSZIEyP4UwUZEkifWT0MpQAZ8fEGQPjI4X320fYsoGdqX80TqCp4K5oHTg
	yoJkINRPZjIc7E42A7hgpNPBajs/BXCwvgVzGi8BnFfn4isZxfPtyw4jgPmlNbjTUDHgYnEe
	Mx2wWATJgz+/Yjl0T1KFwbbRx8BhYOQVDBrHSwhHKQ8SwRFr/hLj5GY4fmeS6WA2GQr7VY+W
	CkHSH2ZPuDlkV3IbrMsow5whbrCr0LI0EUa+Dc/+dGlpIkg2uMLe8qblUffAqq4SppM94J/m
	Rhcne8NnViPh5OOwKq+ScCZ/DaB2UAucjo+hqjsbcwyBkVtgrcHfKb8Fv+uuYTgbr4WaBQvD
	qbOhvniFN8Efa0uX63vBgb/TlpmC8x3NhPNaWQC+/M1I5ACO9rWFtK8tpP2/dSnAdMCLlikS
	Y2lFkCxAQh//75ljpIn1YOl7bN2nBw8f/OVnAgwWMAHIwrie7M0Un3Zni4QnTtJyaZQ8KYFW
	mECQ/eDnMe91MVL7/5IoowSBIfzA4ODgwJAPggXcDewZ1WWROxkrVNLxNC2j5St5DJardyrj
	Ypdp94k1oV35jS8CK0reuVZ4e81GtN7cfKT/kDWnA12fv2hIzT2g958Vp7QWnpHd7VXlH1P/
	fvjRfJuuQJy2/trzVx5jB8c0LRONxziqUV3y2VMmdpX5dLpqOvFhd8Wq0VMF3ofDSt7jf2Ky
	dY5Yej/NA0XhX/R0FvLq0E7145PRBpedojptbum+UVaxuOBBWuQ57oVW9dyi5tav+ls6W8fR
	zKGjdRk+G0RvVBoaeb+YP2sNf1/9ZHZG+eY6S6TLV2V7iYUj+vOeZZeE2zQBKVfbNDF6GD5t
	GGnaMeyW3MMrmPpyrmKitjLEylvM3JQ/EWk7iFU9twVFW4m+0VVF+zO4uEIsFGzF5Arhv0uY
	BAynBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCSnK4rn2GqwfkPxhbrTx1jtvj49TeL
	RdOEv8wWq+/2s1m8PvyJ0eLJgXZGiwWL5rJY3Dywk8li5eqjTBaTDl1jtHh6dRaTxd5b2hYL
	25awWOzZe5LF4vKuOWwW85c9Zbfovr6DzWL58X9MFjcmPGW02PGkkdFi2+/5zBbrXr9nsThx
	S9ricXcHo8X5v8dZHSQ9ds66y+5x/t5GFo/LZ0s9Nq3qZPPYvKTe48XmmYweu282sHks7pvM
	6tHb/I7N4+PTWywe7/ddZfPo27KK0ePzJjmPTU/eMgXwRXHZpKTmZJalFunbJXBlXDx8g7Xg
	mlPFy323WRoYf5p2MXJySAiYSMz7dZi5i5GLQ0hgN6PEp+3bWCESkhLL/h5hhrCFJVb+e84O
	YgsJNDNJdJ0P72Lk4GAT0JY4/Z8DpFdEoJ9Z4t3f6UwgNcwCG5klLh0zA7GFBSwkbr+bzgZi
	swioStw78RhsPq+AlcTl1kesIHMkBPQl+u8LgoQ5BawlNnQvYoZYZSXxYMFjdohyQYmTM5+w
	QIyXl2jeOpt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEe2
	luYOxu2rPugdYmTiYDzEKMHBrCTCq+phkCrEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQ
	QHpiSWp2ampBahFMlomDU6qByfXKjztLdp+1F1p+OPbU/fzHNRN0RJKfL5xyb4PlbIEOgwyF
	F7eu3VVk4HHjnseUwTv15MHTsTZT9O/0edW4LN+ZviVTet7jTz6bv3DcuSjw+fZS43xVRZ1f
	fyP/tMZsOMm6WqkyPWqp+QWneRH+WZy39JKsTK46zt6d2b1T/sNi9iDVhI1r5vdZOpht4mH5
	nK1YXNJ92vHrhSOd0pxr2/91dDzZUXspZMeyxlgj4ZVnCtRdt07S2eBdySO74kH+VTFT13WL
	VVYx6YXcZb/Yc4/xUHDkqX9Wko+CwvMC/pxzcumbZVF6SO174Rnz15tOBr5f9j5q8qHDVQlt
	opZxNcZn3/4zXThnx4UXKzQnOiqxFGckGmoxFxUnAgCMYAK4WwMAAA==
X-CMS-MailID: 20231019110853epcas5p42d50a676bb3168956edc4b87f3dd80c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110853epcas5p42d50a676bb3168956edc4b87f3dd80c2
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110853epcas5p42d50a676bb3168956edc4b87f3dd80c2@epcas5p4.samsung.com>

For the devices which does not support copy, copy emulation is added.
It is required for in-kernel users like fabrics, where file descriptor is
not available and hence they can't use copy_file_range.
Copy-emulation is implemented by reading from source into memory and
writing to the corresponding destination.
At present in kernel user of emulation is fabrics.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c        | 223 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   4 +
 2 files changed, 227 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 0c5763095f7b..25cba4878517 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -26,6 +26,20 @@ struct blkdev_copy_offload_io {
 	loff_t offset;
 };
 
+/* Keeps track of single outstanding copy emulation IO */
+struct blkdev_copy_emulation_io {
+	struct blkdev_copy_io *cio;
+	struct work_struct emulation_work;
+	void *buf;
+	ssize_t buf_len;
+	loff_t pos_in;
+	loff_t pos_out;
+	ssize_t len;
+	struct block_device *bdev_in;
+	struct block_device *bdev_out;
+	gfp_t gfp;
+};
+
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
@@ -319,6 +333,215 @@ ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
 }
 EXPORT_SYMBOL_GPL(blkdev_copy_offload);
 
+static void *blkdev_copy_alloc_buf(ssize_t req_size, ssize_t *alloc_size,
+				   gfp_t gfp)
+{
+	int min_size = PAGE_SIZE;
+	char *buf;
+
+	while (req_size >= min_size) {
+		buf = kvmalloc(req_size, gfp);
+		if (buf) {
+			*alloc_size = req_size;
+			return buf;
+		}
+		req_size >>= 1;
+	}
+
+	return NULL;
+}
+
+static struct bio *bio_map_buf(void *data, unsigned int len, gfp_t gfp)
+{
+	unsigned long kaddr = (unsigned long)data;
+	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = kaddr >> PAGE_SHIFT;
+	const int nr_pages = end - start;
+	bool is_vmalloc = is_vmalloc_addr(data);
+	struct page *page;
+	int offset, i;
+	struct bio *bio;
+
+	bio = bio_kmalloc(nr_pages, gfp);
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, 0);
+
+	if (is_vmalloc) {
+		flush_kernel_vmap_range(data, len);
+		bio->bi_private = data;
+	}
+
+	offset = offset_in_page(kaddr);
+	for (i = 0; i < nr_pages; i++) {
+		unsigned int bytes = PAGE_SIZE - offset;
+
+		if (len <= 0)
+			break;
+
+		if (bytes > len)
+			bytes = len;
+
+		if (!is_vmalloc)
+			page = virt_to_page(data);
+		else
+			page = vmalloc_to_page(data);
+		if (bio_add_page(bio, page, bytes, offset) < bytes) {
+			/* we don't support partial mappings */
+			bio_uninit(bio);
+			kfree(bio);
+			return ERR_PTR(-EINVAL);
+		}
+
+		data += bytes;
+		len -= bytes;
+		offset = 0;
+	}
+
+	return bio;
+}
+
+static void blkdev_copy_emulation_work(struct work_struct *work)
+{
+	struct blkdev_copy_emulation_io *emulation_io = container_of(work,
+			struct blkdev_copy_emulation_io, emulation_work);
+	struct blkdev_copy_io *cio = emulation_io->cio;
+	struct bio *read_bio, *write_bio;
+	loff_t pos_in = emulation_io->pos_in, pos_out = emulation_io->pos_out;
+	ssize_t rem, chunk;
+	int ret = 0;
+
+	for (rem = emulation_io->len; rem > 0; rem -= chunk) {
+		chunk = min_t(int, emulation_io->buf_len, rem);
+
+		read_bio = bio_map_buf(emulation_io->buf,
+				       emulation_io->buf_len,
+				       emulation_io->gfp);
+		if (IS_ERR(read_bio)) {
+			ret = PTR_ERR(read_bio);
+			break;
+		}
+		read_bio->bi_opf = REQ_OP_READ | REQ_SYNC;
+		bio_set_dev(read_bio, emulation_io->bdev_in);
+		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		read_bio->bi_iter.bi_size = chunk;
+		ret = submit_bio_wait(read_bio);
+		kfree(read_bio);
+		if (ret)
+			break;
+
+		write_bio = bio_map_buf(emulation_io->buf,
+					emulation_io->buf_len,
+					emulation_io->gfp);
+		if (IS_ERR(write_bio)) {
+			ret = PTR_ERR(write_bio);
+			break;
+		}
+		write_bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
+		bio_set_dev(write_bio, emulation_io->bdev_out);
+		write_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+		write_bio->bi_iter.bi_size = chunk;
+		ret = submit_bio_wait(write_bio);
+		kfree(write_bio);
+		if (ret)
+			break;
+
+		pos_in += chunk;
+		pos_out += chunk;
+	}
+	cio->status = ret;
+	kvfree(emulation_io->buf);
+	kfree(emulation_io);
+	blkdev_copy_endio(cio);
+}
+
+static inline ssize_t queue_max_hw_bytes(struct request_queue *q)
+{
+	return min_t(ssize_t, queue_max_hw_sectors(q) << SECTOR_SHIFT,
+		     queue_max_segments(q) << PAGE_SHIFT);
+}
+/*
+ * @bdev_in:	source block device
+ * @pos_in:	source offset
+ * @bdev_out:	destination block device
+ * @pos_out:	destination offset
+ * @len:	length in bytes to be copied
+ * @endio:	endio function to be called on completion of copy operation,
+ *		for synchronous operation this should be NULL
+ * @private:	endio function will be called with this private data,
+ *		for synchronous operation this should be NULL
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ *
+ * For synchronous operation returns the length of bytes copied or error
+ * For asynchronous operation returns -EIOCBQUEUED or error
+ *
+ * Description:
+ *	If native copy offload feature is absent, caller can use this function
+ *	to perform copy.
+ *	We store information required to perform the copy along with temporary
+ *	buffer allocation. We async punt copy emulation to a worker. And worker
+ *	performs copy in 2 steps.
+ *	1. Read data from source to temporary buffer
+ *	2. Write data to destination from temporary buffer
+ */
+ssize_t blkdev_copy_emulation(struct block_device *bdev_in, loff_t pos_in,
+			      struct block_device *bdev_out, loff_t pos_out,
+			      size_t len, void (*endio)(void *, int, ssize_t),
+			      void *private, gfp_t gfp)
+{
+	struct request_queue *in = bdev_get_queue(bdev_in);
+	struct request_queue *out = bdev_get_queue(bdev_out);
+	struct blkdev_copy_emulation_io *emulation_io;
+	struct blkdev_copy_io *cio;
+	ssize_t ret;
+	size_t max_hw_bytes = min(queue_max_hw_bytes(in),
+				  queue_max_hw_bytes(out));
+
+	ret = blkdev_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
+	if (ret)
+		return ret;
+
+	cio = kzalloc(sizeof(*cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+
+	cio->waiter = current;
+	cio->copied = len;
+	cio->endio = endio;
+	cio->private = private;
+
+	emulation_io = kzalloc(sizeof(*emulation_io), gfp);
+	if (!emulation_io)
+		goto err_free_cio;
+	emulation_io->cio = cio;
+	INIT_WORK(&emulation_io->emulation_work, blkdev_copy_emulation_work);
+	emulation_io->pos_in = pos_in;
+	emulation_io->pos_out = pos_out;
+	emulation_io->len = len;
+	emulation_io->bdev_in = bdev_in;
+	emulation_io->bdev_out = bdev_out;
+	emulation_io->gfp = gfp;
+
+	emulation_io->buf = blkdev_copy_alloc_buf(min(max_hw_bytes, len),
+						  &emulation_io->buf_len, gfp);
+	if (!emulation_io->buf)
+		goto err_free_emulation_io;
+
+	schedule_work(&emulation_io->emulation_work);
+
+	if (cio->endio)
+		return -EIOCBQUEUED;
+
+	return blkdev_copy_wait_for_completion_io(cio);
+
+err_free_emulation_io:
+	kfree(emulation_io);
+err_free_cio:
+	kfree(cio);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_emulation);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5405499bcf22..e0a832a1c3a7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1046,6 +1046,10 @@ ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
 			    loff_t pos_out, size_t len,
 			    void (*endio)(void *, int, ssize_t),
 			    void *private, gfp_t gfp_mask);
+ssize_t blkdev_copy_emulation(struct block_device *bdev_in, loff_t pos_in,
+			      struct block_device *bdev_out, loff_t pos_out,
+			      size_t len, void (*endio)(void *, int, ssize_t),
+			      void *private, gfp_t gfp);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.35.1.500.gb896f729e2


