Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC994AC1FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386505AbiBGOxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392422AbiBGOad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:30:33 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BECC0401C3
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:30:30 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220207142308epoutp0254dc74d05f9a5a89783034803362dbd2~RhwOAPCHz0538505385epoutp02l
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:23:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220207142308epoutp0254dc74d05f9a5a89783034803362dbd2~RhwOAPCHz0538505385epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243788;
        bh=HTaZWIGmZSgDIwXrdNcbOMljT8UJ4PNyqwb/y538jAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+zGlmkpdBA+RIrC2d2OMq84T2xLhFOOVBoY6kprpx1k21RzWbbRLWZugZ3YnWPjs
         EJx0EJLKOCqOGNTfMtEoCt4XnMYljMbslGBO+gPGox6w7gcyD9JU/iuFIh7mbhFgSN
         ofACZa61fH40Q99NSEWRhlmuOMlpNnqOLmAjC1Hw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220207142307epcas5p1ea5221d70a6d67ea16351b95bd5eede6~RhwNJHKRJ2310823108epcas5p1G;
        Mon,  7 Feb 2022 14:23:07 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JspJk1cm1z4x9Pv; Mon,  7 Feb
        2022 14:23:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.2E.46822.99A21026; Mon,  7 Feb 2022 23:20:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220207141942epcas5p4bda894a5833513c9211dcecc7928a951~RhtOt2OtL0820008200epcas5p4d;
        Mon,  7 Feb 2022 14:19:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220207141942epsmtrp12a9df6a5d2073decd4c26f6df1d2aac9~RhtOszPKB0877208772epsmtrp1H;
        Mon,  7 Feb 2022 14:19:42 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-58-62012a999863
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.43.08738.E7A21026; Mon,  7 Feb 2022 23:19:42 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141938epsmtip173d4efad3407143d4b76e1665d0f99c3~RhtK6zwn30284102841epsmtip1n;
        Mon,  7 Feb 2022 14:19:38 +0000 (GMT)
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
Subject: [PATCH v2 07/10] nvmet: add copy command support for bdev and file
 ns
Date:   Mon,  7 Feb 2022 19:43:45 +0530
Message-Id: <20220207141348.4235-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220207141348.4235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzOube9LUTwDjo4EJhN1WzieFQBD6Q8DAQv6DKWhS3Zw3Khd0Cg
        j7RlMBcc2OgGDOUxCZSIvCYBnAxEJLwUtAMFEYSCsOFoAFGcoGJE5DXgwuZ/33d+3+985/ed
        /Pi4VTXPnh+j0DJqBR0nIsw59Tf2ODnnO4EIt+F7Tqh5eI6LqkbPECj32QKOZtvGuSj7TB4P
        9U9YopaZAi7qfZ2CofHaVQw1l2RjqKLKgKGp8lKAUrt6MbRkEiPD6lMCZbcPAtQyshc1t9zi
        oPMXJnkofaiBQK1PWnBU3rGCoayfjBjq0S8RqH7xPI5uPDByUNUSQid/XuCh6WtH/R2p/oHD
        VJZuhkfpiv7iUP134qnaylSCulz2A5VzvxxQTcPJBHWi24BTeS9eEtRQ91WMytDNENTzyREO
        VW/K4FGzrUaCOl1XCUIFX8RKohlaxqiFjCJSKYtRRPmIDn8qDZB6eLqJncVe6IBIqKDljI8o
        8Eioc1BM3FpIIuG3dFz82lEordGIXH0lamW8lhFGKzVaHxGjksWp3FUuGlquiVdEuSgYrbfY
        zW2fx5owPDa6tuI6pupEiXer7nGSQbJrGjDjQ9Id9qTl4GnAnG9FNgH4/M1DLkteADjXWMZj
        yRyAZ+ebuVstxozrBFtoBHD0QSFgyUkMFp0zrVX4fILcC7tW+esNAtIWLvXWb2hwco4DB4f0
        vPWCNRkKr7S14euYQ+6GRVP3ueu9FqQXXHwsZ812wmJT24axGekNXy3lctaxBfkOvJU/sYFx
        cgfUXSnAWf2IGZzoCGRxIJyeTOGw2BpOd9TxWGwPH585tTEZJNMBfN39N8aSPAB1mTqCVfnB
        vuZlbP1BOLkHVjduBuYIz96+hLHGljBjcQJjzy1gQ+EW3gkvVhdtXmMHB+dTNjEF026nYmxY
        AwAa+jp4mUCof2sg/VsD6f+3LgJ4JbBjVBp5FKPxUO1TMAn/fXOkUl4LNjbHKaQBmMaeubQD
        jA/aAeTjIoGFQ/oqbWUho787xqiVUnV8HKNpBx5rgWfh9u9GKtdWT6GVit293Nw9PT3dvfZ7
        ikW2Fl1Rv9NWZBStZWIZRsWot/owvpl9MlYTXtP1SeQ3hdbFuV+7mnhJF5MyPw5cNAWcSzp0
        UH88PCdoWeIWoTTvQhL/paTEhCnhn4/Ksh4Kj5zWDBfotjkc1Nr02FTW+OrHl+eDr36vE9Td
        /MgY4vWeIeIynafCvowtOcUNRteajgt21QpeeUg9Ru9mHJsinO/0+/4yV3rJeEE6kWSctans
        iu5Wff5bqSzfr2aoffuv709vmzPf5Rzi2/lEI+EOLvgN+OeuxNoekB6VhQXfnN1BdAZ9JZiP
        2//m0Ycf2OUOSALGWrPnuYawvkbD9mbvp52y5ZomR/k/NicSLHWJI3Tnjy/z//isXl5c4VyS
        XRMkEVXlcVb4Y2EOu0UijiaaFjvhag39Lyt+ue3CBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWy7bCSnG6dFmOSwbPbChZ7bn5mtVh9t5/N
        YtqHn8wW7w8+ZrWY1D+D3eLyEz6Lve9ms1pc+NHIZPF4038miz2LJjFZrFx9lMni+fLFjBad
        py8wWfx5aGhx9P9bNotJh64xWuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaL5cf/MVlM7LjK
        ZHFu1h82i22/5zNbHL53lcVi9R8Li9aen+wWr/bHOch6XL7i7TGx+R27R/OCOywel8+Wemxa
        1cnmsXlJvcfkG8sZPXbfbGDzaDpzlNljxqcvbB7Xz2xn8uhtfsfm8fHpLRaPbQ972T3e77vK
        5tG3ZRVjgEgUl01Kak5mWWqRvl0CV8amlQeYCk5YVJxffYmlgbFBv4uRk0NCwETiau8BNhBb
        SGAHo8T8o2YQcUmJZX+PMEPYwhIr/z1n72LkAqppZpKYt/4HaxcjBwebgLbE6f8cIDUiAuIS
        fy5sYwSpYRaYzirRcOoyE0hCWMBP4vivBjCbRUBVYsHzG2C9vAKWEr9f5kLMV5ZY+PAgK4jN
        KWAl8e3PNBaIXQ2MEg3nVoAleAUEJU7OfMICYjMLyEs0b53NPIFRYBaS1CwkqQWMTKsYJVML
        inPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYITgpbWDsY9qz7oHWJk4mA8xCjBwawkwivT/T9R
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbwv0oxDqWH
        K6qlWq9FuS/4stXTdpaByYywlHKfrwovdKdbfLRZqijxYdLUdHWmU8lHKhvFN5atS5K7wcd8
        UX6x8uzDU1sLdh5c77H2VajFnprjpTfWtwv2/Juds30G3+ODQakL+dt3FFdPWRYWt0RSJnfl
        LOPHbMW5FS3/lqksFJafun2e/I1V0p7q5yaWeKdxLfq24b721l+ydqaxSwuX+O/lexbp31e2
        bdPuyUxnvXWztyQ92lVg+7R+17R1qr9bMy9x/i2Xfrnx/8+q9Qceawt32T4q2c7/flXP81lr
        zxv5LZBLX16uwXnAzKqhaN+LFPZZfqun/ljQEGdUemzt76DZjgY/3wltco23t5iqxFKckWio
        xVxUnAgAhrGrMXcDAAA=
X-CMS-MailID: 20220207141942epcas5p4bda894a5833513c9211dcecc7928a951
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141942epcas5p4bda894a5833513c9211dcecc7928a951
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141942epcas5p4bda894a5833513c9211dcecc7928a951@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnav Dawn <arnav.dawn@samsung.com>

Add support for handling target command on target.
For bdev-ns we call into blkdev_issue_copy, which the block layer
completes by a offloaded copy request to backend bdev or by emulating the
request.

For file-ns we call vfs_copy_file_range to service our request.

Currently target always shows copy capability by setting
NVME_CTRL_ONCS_COPY in controller ONCS.

Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/target/admin-cmd.c   |  8 +++-
 drivers/nvme/target/io-cmd-bdev.c | 66 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 48 ++++++++++++++++++++++
 3 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..cbb967344d1d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -431,8 +431,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
-			NVME_CTRL_ONCS_WRITE_ZEROES);
-
+			NVME_CTRL_ONCS_WRITE_ZEROES | NVME_CTRL_ONCS_COPY);
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
 
@@ -530,6 +529,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	if (req->ns->bdev)
 		nvmet_bdev_set_limits(req->ns->bdev, id);
+	else {
+		id->msrc = to0based(BIO_MAX_VECS);
+		id->mssrl = cpu_to_le32(BIO_MAX_VECS << (PAGE_SHIFT - SECTOR_SHIFT));
+		id->mcl = cpu_to_le64(le32_to_cpu(id->mssrl) * BIO_MAX_VECS);
+	}
 
 	/*
 	 * We just provide a single LBA format that matches what the
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 95c2bbb0b2f5..9b403f394f21 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,6 +46,30 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->npda = id->npdg;
 	/* NOWS = Namespace Optimal Write Size */
 	id->nows = to0based(ql->io_opt / ql->logical_block_size);
+
+	/*Copy limits*/
+	if (ql->max_copy_sectors) {
+		id->mcl = cpu_to_le64((ql->max_copy_sectors << 9) / ql->logical_block_size);
+		id->mssrl = cpu_to_le32((ql->max_copy_range_sectors << 9) /
+				ql->logical_block_size);
+		id->msrc = to0based(ql->max_copy_nr_ranges);
+	} else {
+		if (ql->zoned == BLK_ZONED_NONE) {
+			id->msrc = to0based(BIO_MAX_VECS);
+			id->mssrl = cpu_to_le32(
+					(BIO_MAX_VECS << PAGE_SHIFT) / ql->logical_block_size);
+			id->mcl = cpu_to_le64(le32_to_cpu(id->mssrl) * BIO_MAX_VECS);
+#ifdef CONFIG_BLK_DEV_ZONED
+		} else {
+			/* TODO: get right values for zoned device */
+			id->msrc = to0based(BIO_MAX_VECS);
+			id->mssrl = cpu_to_le32(min((BIO_MAX_VECS << PAGE_SHIFT),
+					ql->chunk_sectors) / ql->logical_block_size);
+			id->mcl = cpu_to_le64(min(le32_to_cpu(id->mssrl) * BIO_MAX_VECS,
+						ql->chunk_sectors));
+#endif
+		}
+	}
 }
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
@@ -433,6 +457,44 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_bdev_execute_copy(struct nvmet_req *req)
+{
+	struct nvme_copy_range range;
+	struct range_entry *rlist;
+	struct nvme_command *cmnd = req->cmd;
+	sector_t dest, dest_off = 0;
+	int ret, id, nr_range;
+
+	nr_range = cmnd->copy.nr_range + 1;
+	dest = le64_to_cpu(cmnd->copy.sdlba) << req->ns->blksize_shift;
+	rlist = kmalloc_array(nr_range, sizeof(*rlist), GFP_KERNEL);
+
+	for (id = 0 ; id < nr_range; id++) {
+		ret = nvmet_copy_from_sgl(req, id * sizeof(range), &range, sizeof(range));
+		if (ret)
+			goto out;
+
+		rlist[id].dst = dest + dest_off;
+		rlist[id].src = le64_to_cpu(range.slba) << req->ns->blksize_shift;
+		rlist[id].len = (le16_to_cpu(range.nlb) + 1) << req->ns->blksize_shift;
+		rlist[id].comp_len = 0;
+		dest_off += rlist[id].len;
+	}
+	ret = blkdev_issue_copy(req->ns->bdev, nr_range, rlist, req->ns->bdev, GFP_KERNEL,
+			0);
+	if (ret) {
+		for (id = 0 ; id < nr_range; id++) {
+			if (rlist[id].len != rlist[id].comp_len) {
+				req->cqe->result.u32 = cpu_to_le32(id);
+				break;
+			}
+		}
+	}
+out:
+	kfree(rlist);
+	nvmet_req_complete(req, errno_to_nvme_status(req, ret));
+}
+
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 {
 	switch (req->cmd->common.opcode) {
@@ -451,6 +513,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute = nvmet_bdev_execute_copy;
+		return 0;
+
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 6be6e59d273b..665baa221a43 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -347,6 +347,46 @@ static void nvmet_file_dsm_work(struct work_struct *w)
 	}
 }
 
+static void nvmet_file_copy_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	int nr_range;
+	loff_t pos;
+	struct nvme_command *cmnd = req->cmd;
+	int ret = 0, len, src, id;
+
+	nr_range = cmnd->copy.nr_range + 1;
+	pos = le64_to_cpu(req->cmd->copy.sdlba) << req->ns->blksize_shift;
+	if (unlikely(pos + req->transfer_len > req->ns->size)) {
+		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
+		return;
+	}
+
+	for (id = 0 ; id < nr_range; id++) {
+		struct nvme_copy_range range;
+
+		ret = nvmet_copy_from_sgl(req, id * sizeof(range), &range,
+					sizeof(range));
+		if (ret)
+			goto out;
+
+		len = (le16_to_cpu(range.nlb) + 1) << (req->ns->blksize_shift);
+		src = (le64_to_cpu(range.slba) << (req->ns->blksize_shift));
+		ret = vfs_copy_file_range(req->ns->file, src, req->ns->file, pos, len, 0);
+out:
+		if (ret != len) {
+			pos += ret;
+			req->cqe->result.u32 = cpu_to_le32(id);
+			nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) :
+					errno_to_nvme_status(req, -EIO));
+			return;
+
+		} else
+			pos += len;
+}
+	nvmet_req_complete(req, ret);
+
+}
 static void nvmet_file_execute_dsm(struct nvmet_req *req)
 {
 	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
@@ -355,6 +395,11 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
 	schedule_work(&req->f.work);
 }
 
+static void nvmet_file_execute_copy(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_file_copy_work);
+	schedule_work(&req->f.work);
+}
 static void nvmet_file_write_zeroes_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
@@ -401,6 +446,9 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute = nvmet_file_execute_copy;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
-- 
2.30.0-rc0

