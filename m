Return-Path: <linux-fsdevel+bounces-745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB23E7CF822
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42034B2164C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E034225B2;
	Thu, 19 Oct 2023 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fxu1rWjB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F2225A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:54 +0000 (UTC)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473972103
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:28 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231019120418epoutp032a315555a265b96063a301585f07e8d2~PgKuWeof72900729007epoutp03v
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231019120418epoutp032a315555a265b96063a301585f07e8d2~PgKuWeof72900729007epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717059;
	bh=1M3rppJEeb1Hb0d/CfRhd346wXXsHkpIV1s1W43J98s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fxu1rWjByozeBoeo1Z4wvwjzYYOhfAB4mXL4uXG+SC4jC33y1Mq30Y8jUhs5b+Wan
	 Qv35gw78AXkNU3r53prwE7SyVKdTLN7qYJrG1Lt6iJIxHF8S1jD6HK3It3m1xeCH0S
	 DJtTQQuXjRPKbvxMBv/EkWmT86qeUZfYqXH8xDgs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231019120418epcas5p3e463315f81450788c658628417955a9c~PgKt8ealE2680326803epcas5p31;
	Thu, 19 Oct 2023 12:04:18 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SB5wx2nBJz4x9Pv; Thu, 19 Oct
	2023 12:04:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.DB.19369.14B11356; Thu, 19 Oct 2023 21:04:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231019110935epcas5p2f956b8376cdb5ff2f5afe8791cd9d490~Pfa8sWl6O2430724307epcas5p2k;
	Thu, 19 Oct 2023 11:09:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231019110935epsmtrp1f326a512658c3218b7d34cb950579947~Pfa8rJSnD2693626936epsmtrp1N;
	Thu, 19 Oct 2023 11:09:35 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-10-65311b41eeb9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.88.08817.F6E01356; Thu, 19 Oct 2023 20:09:35 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110932epsmtip1586db37cacc1620b684c422cd6806447~Pfa5dYO9l2755627556epsmtip17;
	Thu, 19 Oct 2023 11:09:32 +0000 (GMT)
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
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 08/12] nvmet: add copy command support for bdev and file
 ns
Date: Thu, 19 Oct 2023 16:31:36 +0530
Message-Id: <20231019110147.31672-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+5tL4UNvRQ2DiVz7CLbgEBbge6AVvGReRcXBnFs6tywoTcU
	gbbrYzA2M9AVByLlHel4iQSBgtWWR0VAg1EGaNiCohLFSIDAAB8oTsJwo7Ru/vf5fvP7ne/5
	/U4OB+eWOfE4iXINo5JLkinChdV22T8gaKu3kBEUZ3ORqf8qjp4sLLHQ4fxlHBnv6Qk0c3ke
	oPFLRwGqrqlgoTuXzmOos6YQQw3GKxgq7BkGaOKmAUNdI4HoZFYtC3V29bHQUEc5garqJpzQ
	sVtWAp3ufYmh2/kTAFnHMwFqW6rC0ZmZRyz024g3GlzuZUd60ecN95zowdFzLHroupY2N2YT
	tKX2J3rKUgboC3cyCPpUXhGbPn7kIUE/mRhh0Y+6bxJ0XksjoC0DP9BPzeto8/gcFr12X9Im
	GSORMiofRh6vkCbKE8TUrt1x2+PCRAJhkDAcfUT5yCUpjJja8Wl00MeJySvboHy+kyRrV6xo
	iVpN8TdvUim0GsZHplBrxBSjlCYrQ5XBakmKWitPCJYzmgihQLAhbKXwQJLM0mAklKadabU1
	R0EGKNqYA5w5kAyFlVazUw5w4XDJTgAv/PGAsIt5AEdzOxziOYDD7cVYDuCstvRc/MLudwFY
	057FtgsdBvOyFglbEUEGwoF/ODbfg9Th8OLdWWATOFmJQ8tYL2YLdydj4C8TdWwbs0g/2Pw0
	e5VdyQj4eMhA2NP4UH/fzWY7kxvh2WM1uL3EDfaVjbNsjJPvwiOtv+K28yFpcoa5k2PAPtwO
	mGkxO9gd/tnb4mRnHpzWZzk4FTYU1xP25p8BNNwyOBq2QF2/HrddAif9oamDb7ffgSX9ZzB7
	8Bp4fGkcs/uu0Fr5in1hk6masLMXHP4r08E0nNPrHMvOA/ClboGdD3wMrw1keG0gw//R1QBv
	BDxGqU5JYOLDlMIgOZP63zvHK1LMYPWPBERbgfHscnAPwDigB0AOTnm4+tEChusqlXyfzqgU
	cSptMqPuAWErGy/AeW/FK1Y+mVwTJwwNF4SKRKLQ8BCRkPJ0ndFVSLlkgkTDJDGMklG96sM4
	zrwM7MP96sjI7n2NnMFWub5ufZqxpD496kBnSOD+/ODSwjqmKHKZa9zyuKw4fDJ8urt18xyu
	EsgkbaKhqB/7eMZSULroIZY08apO7SmHO/vChN/+ndvRtNWHr37b95lsdoz6Joo1uBBDeaSm
	1baPnP7yq99n4/2LX1Q8/0RrLXnvwcBtWfPnOUx6wd6WWI4LbhIvuzPlbfB6TNJVl/ujh66g
	gy9G1+zKmi7r2j1gPuTnOYX5d468eeON9wMWY/nYtmsfnAgJjrj2tarELeKzmHMDG+ZPeuV5
	uRWwY+92tU0VcpZPeK2Tpk7fsBxMOby2FveOohJ81z/cs/fZpGeHOKKZ37C9nmKpZRJhAK5S
	S/4F6Qv4K6wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnG4+n2GqwfPpmhbrTx1jtvj49TeL
	RdOEv8wWq+/2s1m8PvyJ0eLJgXZGiwWL5rJY3Dywk8liz6JJTBYrVx9lsph06BqjxdOrs5gs
	9t7StljYtoTFYs/ekywWl3fNYbOYv+wpu0X39R1sFsuP/2OyuDHhKaPFjieNjBbbfs9ntlj3
	+j2LxYlb0hbn/x5ndZD02DnrLrvH+XsbWTwuny312LSqk81j85J6jxebZzJ67L7ZwOaxuG8y
	q0dv8zs2j49Pb7F4vN93lc2jb8sqRo/Np6s9Pm+S89j05C1TAH8Ul01Kak5mWWqRvl0CV8bm
	lavZCta7VyxZ1M7YwDjZuouRg0NCwETi0P6wLkYuDiGB3YwSB47NYO5i5ASKS0os+3sEyhaW
	WPnvOTtEUTOTxM7Di1lBmtkEtCVO/+cAiYsI9DNLvPs7nQmkgVlgDbPElrm8IDXCAv4SK3tt
	QMIsAqoSaz93soLYvAJWEh8uz2KDuEFfov++IEiYU8BaYkP3IrC1QkAlDxY8ZocoF5Q4OfMJ
	C8R0eYnmrbOZJzAKzEKSmoUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnB8
	a2ntYNyz6oPeIUYmDsZDjBIczEoivKoeBqlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb+97k0R
	EkhPLEnNTk0tSC2CyTJxcEo1MPF+PZC7Pn3JQhlNr9CpxSwBD5LZ5QNdWr78X5M/Kzlzy/IN
	ubUTnqoXn0roWMa0qaBaYduj3wqsPw0d2kXijpT4f9Zoztu5uCas8us9EzbtVZ6LvmhVL2iq
	baza5leuwJMc/uvULNlvD27J3W03mNyTwC5p9WjOnSx/I+Y3b9r//5F8lXRFTyOA9cK29b1G
	G/KPtu9bpRz6f9Vb1ofXm5WK24/NXxwfEhnG0bYxjWt/9QZXc/24qUwL/kw5ePvoXlnhfyUn
	3cXKty74GHO2J+eb6gtOt9KXpd/9veoWz2wRXis4p9km3rrt0i3hBbJLE8M/2L8S4nwdIznB
	iElSI7eUc2c4x5xz6Wpzu1d1KrEUZyQaajEXFScCAA9/0a9eAwAA
X-CMS-MailID: 20231019110935epcas5p2f956b8376cdb5ff2f5afe8791cd9d490
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110935epcas5p2f956b8376cdb5ff2f5afe8791cd9d490
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110935epcas5p2f956b8376cdb5ff2f5afe8791cd9d490@epcas5p2.samsung.com>

Add support for handling nvme_cmd_copy command on target.

For bdev-ns if backing device supports copy offload we call device copy
offload (blkdev_copy_offload).
In case of absence of device copy offload capability, we use copy emulation
(blkdev_copy_emulation)

For file-ns we call vfs_copy_file_range to service our request.

Currently target always shows copy capability by setting
NVME_CTRL_ONCS_COPY in controller ONCS.

loop target has copy support, which can be used to test copy offload.
trace event support for nvme_cmd_copy.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/target/admin-cmd.c   |  9 +++-
 drivers/nvme/target/io-cmd-bdev.c | 71 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 50 ++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  1 +
 drivers/nvme/target/trace.c       | 19 +++++++++
 5 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 39cb570f833d..4e1a6ca09937 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -433,8 +433,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
-			NVME_CTRL_ONCS_WRITE_ZEROES);
-
+			NVME_CTRL_ONCS_WRITE_ZEROES | NVME_CTRL_ONCS_COPY);
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
 
@@ -536,6 +535,12 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	if (req->ns->bdev)
 		nvmet_bdev_set_limits(req->ns->bdev, id);
+	else {
+		id->msrc = (__force u8)to0based(BIO_MAX_VECS - 1);
+		id->mssrl = cpu_to_le16(BIO_MAX_VECS <<
+					(PAGE_SHIFT - SECTOR_SHIFT));
+		id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl));
+	}
 
 	/*
 	 * We just provide a single LBA format that matches what the
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 468833675cc9..e51978514546 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,6 +46,18 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->npda = id->npdg;
 	/* NOWS = Namespace Optimal Write Size */
 	id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
+
+	if (bdev_max_copy_sectors(bdev)) {
+		id->msrc = id->msrc;
+		id->mssrl = cpu_to_le16((bdev_max_copy_sectors(bdev) <<
+				SECTOR_SHIFT) /	bdev_logical_block_size(bdev));
+		id->mcl = cpu_to_le32((__force u32)id->mssrl);
+	} else {
+		id->msrc = (__force u8)to0based(BIO_MAX_VECS - 1);
+		id->mssrl = cpu_to_le16((BIO_MAX_VECS << PAGE_SHIFT) /
+					bdev_logical_block_size(bdev));
+		id->mcl = cpu_to_le32((__force u32)id->mssrl);
+	}
 }
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
@@ -449,6 +461,61 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_bdev_copy_endio(void *private, int status,
+					    ssize_t copied)
+{
+	struct nvmet_req *rq = (struct nvmet_req *)private;
+	u16 nvme_status;
+
+	if (copied == rq->copy_len)
+		rq->cqe->result.u32 = cpu_to_le32(1);
+	else
+		rq->cqe->result.u32 = cpu_to_le32(0);
+
+	nvme_status = errno_to_nvme_status(rq, status);
+	nvmet_req_complete(rq, nvme_status);
+}
+
+/*
+ * At present we handle only one range entry, since copy offload is aligned with
+ * copy_file_range, only one entry is passed from block layer.
+ */
+static void nvmet_bdev_execute_copy(struct nvmet_req *rq)
+{
+	struct nvme_copy_range range;
+	struct nvme_command *cmd = rq->cmd;
+	ssize_t ret;
+	off_t dst, src;
+
+	u16 status;
+
+	status = nvmet_copy_from_sgl(rq, 0, &range, sizeof(range));
+	if (status)
+		goto err_rq_complete;
+
+	dst = le64_to_cpu(cmd->copy.sdlba) << rq->ns->blksize_shift;
+	src = le64_to_cpu(range.slba) << rq->ns->blksize_shift;
+	rq->copy_len = (range.nlb + 1) << rq->ns->blksize_shift;
+
+	if (bdev_max_copy_sectors(rq->ns->bdev)) {
+		ret = blkdev_copy_offload(rq->ns->bdev, dst, src, rq->copy_len,
+					  nvmet_bdev_copy_endio,
+					  (void *)rq, GFP_KERNEL);
+	} else {
+		ret = blkdev_copy_emulation(rq->ns->bdev, dst,
+					    rq->ns->bdev, src, rq->copy_len,
+					    nvmet_bdev_copy_endio,
+					    (void *)rq, GFP_KERNEL);
+	}
+	if (ret == -EIOCBQUEUED)
+		return;
+
+	rq->cqe->result.u32 = cpu_to_le32(0);
+	status = errno_to_nvme_status(rq, ret);
+err_rq_complete:
+	nvmet_req_complete(rq, status);
+}
+
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 {
 	switch (req->cmd->common.opcode) {
@@ -467,6 +534,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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
index 2d068439b129..4524cfffa4c6 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -322,6 +322,47 @@ static void nvmet_file_dsm_work(struct work_struct *w)
 	}
 }
 
+static void nvmet_file_copy_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	int nr_range = req->cmd->copy.nr_range + 1;
+	u16 status = 0;
+	int src, id;
+	ssize_t len, ret;
+	loff_t pos;
+
+	pos = le64_to_cpu(req->cmd->copy.sdlba) << req->ns->blksize_shift;
+	if (unlikely(pos + req->transfer_len > req->ns->size)) {
+		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
+		return;
+	}
+
+	for (id = 0 ; id < nr_range; id++) {
+		struct nvme_copy_range range;
+
+		status = nvmet_copy_from_sgl(req, id * sizeof(range), &range,
+					     sizeof(range));
+		if (status)
+			break;
+
+		src = (le64_to_cpu(range.slba) << (req->ns->blksize_shift));
+		len = (le16_to_cpu(range.nlb) + 1) << (req->ns->blksize_shift);
+		ret = vfs_copy_file_range(req->ns->file, src, req->ns->file,
+					  pos, len, 0);
+		pos += ret;
+		if (ret != len) {
+			req->cqe->result.u32 = cpu_to_le32(id);
+			if (ret < 0)
+				status = errno_to_nvme_status(req, ret);
+			else
+				status = errno_to_nvme_status(req, -EIO);
+			break;
+		}
+	}
+
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_file_execute_dsm(struct nvmet_req *req)
 {
 	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
@@ -330,6 +371,12 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
 	queue_work(nvmet_wq, &req->f.work);
 }
 
+static void nvmet_file_execute_copy(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_file_copy_work);
+	queue_work(nvmet_wq, &req->f.work);
+}
+
 static void nvmet_file_write_zeroes_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
@@ -376,6 +423,9 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute = nvmet_file_execute_copy;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cfd60f3b564..395f3af28413 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -393,6 +393,7 @@ struct nvmet_req {
 	struct device		*p2p_client;
 	u16			error_loc;
 	u64			error_slba;
+	size_t			copy_len;
 };
 
 #define NVMET_MAX_MPOOL_BVEC		16
diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index bff454d46255..551fdf029381 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -92,6 +92,23 @@ static const char *nvmet_trace_dsm(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvmet_trace_copy(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 sdlba = get_unaligned_le64(cdw10);
+	u8 nr_range = get_unaligned_le16(cdw10 + 8);
+	u16 control = get_unaligned_le16(cdw10 + 10);
+	u32 dsmgmt = get_unaligned_le32(cdw10 + 12);
+	u32 reftag = get_unaligned_le32(cdw10 +  16);
+
+	trace_seq_printf(p,
+		"sdlba=%llu, nr_range=%u, ctrl=1x%x, dsmgmt=%u, reftag=%u",
+		sdlba, nr_range, control, dsmgmt, reftag);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvmet_trace_common(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -129,6 +146,8 @@ const char *nvmet_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvmet_trace_read_write(p, cdw10);
 	case nvme_cmd_dsm:
 		return nvmet_trace_dsm(p, cdw10);
+	case nvme_cmd_copy:
+		return nvmet_trace_copy(p, cdw10);
 	default:
 		return nvmet_trace_common(p, cdw10);
 	}
-- 
2.35.1.500.gb896f729e2


