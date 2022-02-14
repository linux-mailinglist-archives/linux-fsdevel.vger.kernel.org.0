Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EBD4B444B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 09:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbiBNIgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 03:36:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbiBNIgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:36:15 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1C25C7F;
        Mon, 14 Feb 2022 00:36:08 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220214083606epoutp039281e2ae9164ad7dc8fe15768b7721ce~TmiOXmiKu0830708307epoutp03l;
        Mon, 14 Feb 2022 08:36:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220214083606epoutp039281e2ae9164ad7dc8fe15768b7721ce~TmiOXmiKu0830708307epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644827766;
        bh=Z9Nyys2UP6FAeY8io8HElJ9II7fdwdaF85FhVinN+aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHL0Zc8+sFoTXtvQXuRrNTTwq9Ym+GmzpryJ9ItD4dLE7o0PA+ePB8qH3N3rtCGlQ
         /bCY5WSUwmFYuoebXOB/cmeKDfdaPvOpLc4uDyaDW+FKalINzRHhtn2I0ut147I+C+
         mcEm5MK5SiGr2j/VFVUEs+ozZ4MUk0ozaMk9jtU0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220214083606epcas5p4e61537cf556f825454c8696b45416828~TmiN73zh02392823928epcas5p4z;
        Mon, 14 Feb 2022 08:36:06 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JxyH50264z4x9QT; Mon, 14 Feb
        2022 08:36:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.46.05590.E641A026; Mon, 14 Feb 2022 17:35:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220214080641epcas5p4662e8d0c86f93d525032067cc039c7af~TmIix_KqB1267812678epcas5p4L;
        Mon, 14 Feb 2022 08:06:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220214080641epsmtrp1fac2e9de9dda32a0897d456a1ecab2ca~TmIixC6dL3265432654epsmtrp1P;
        Mon, 14 Feb 2022 08:06:41 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-b4-620a146e47e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.F1.29871.19D0A026; Mon, 14 Feb 2022 17:06:41 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220214080636epsmtip2516464898b02ee0a0722eb6af56da7cb~TmIeTvagw2207122071epsmtip2b;
        Mon, 14 Feb 2022 08:06:36 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] nvmet: add copy command support for bdev and file
 ns
Date:   Mon, 14 Feb 2022 13:29:57 +0530
Message-Id: <20220214080002.18381-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220214080002.18381-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTVxj1vvfyXsIU5hFQL1RbGsYfbCHRBC8C1lrbeVNah0oHOs60NMAb
        QEOSJqF0mSlbgbLJ0qIxMGy2ZUTLJiqVgIKlbIJSDAgjULaqZQoIlX0pIdj673zfPedbzp2P
        i/PbKHtuhELLqhUyuYC0IK7ddnJ2U9haBItaz1Goov03HBn65zjo0mAmic7OLOFounGMg3Iy
        dRTqGbdC9VN5HHRvMQ5DY9UbGDKU5GDo4qVmDD0qvQBQXfFTDKV03MPQ6ogYNW/8TaKcpl6A
        Jox6DNUPuCBDfRuBem7kk6jwpwkKpfXVkqhhsh5HpS3rGOrSr5KodjwOoGsrhTi6PWQkUPnk
        NIGSqp4BlJi+RKG7ay2cIwKm574vox/uJJnshCmK+UU/SDF3h6oIJqHoIcH0dEYx1WUpJHPl
        hxjmuwelgKnrjyWZ+DvNOKOb/YdkMhKmSObpxADBTDcYSb9dJ097h7OyUFbtwCpClKERijAf
        ga9/0JtBUg+R2E3siQ4KHBSySNZHcOxdP7e3I+Sb/gkcPpPJozZTfjKNRuB+2FutjNKyDuFK
        jdZHwKpC5SqJSqiRRWqiFGFCBas9JBaJ9ks3iZ+cDn+gM2CqZvR5ycMkMhbEuqcCHhfSEljV
        vkSlAgsun64DMMswsx3MArhcnrcdzAO4Hr9MpALulqRrVWRS8+l6AH8sOmzmJGKw0zCPmTgk
        7QI7Nrgmji1NwIsLC4SJg9NzJGy9vIKZHmxoP3h2ZgiY+AS9D27MWpvSlvQhmF7Yi5unc4TF
        I40cE+bRXvDWZClu5ljDtvPjhAnj9Ksw4WoebqoP6XUeXC8s45jFx2CT7jFpxjbwr5Yayozt
        4ZPMJMosSANw8c4wZg50ACZkJWwrXofdhrWtbXDaCVbc2PZrL8xtL8fMna1gxso4Zs5bwtqC
        59gRXq4o2i5jB3sX4rYxA1PapzGzW2cAXHm0RmUBB/0LG+lf2Ej/f+sigJcBO1aliQxjNVLV
        AQUb/d8vhygjq8HWTTn71oLRP2aETQDjgiYAubjA1vLjTl4w3zJU9sWXrFoZpI6Ss5omIN10
        PBu33xmi3DxKhTZILPEUSTw8PCSeBzzEgt2W7WGVMj4dJtOyp1lWxaqf6zAuzz4WO5dcMKbw
        5v2edD5gR55d2oXv73/06ZnK6517ONf9vYKMfL834oKv3vwwv8VmeG7eIv9kn9Ao/XntzwIB
        vtY+F/9sYV9c1/GvOl0wF4k8O+be5I3dy6FRrmX7p2PmR6yTuwkv/+5TRwffGxFmnBh8P/CV
        mAp5vJNTs2//qQIdle9uDR3LjcG/RqBm7h7nxqQa6VuK3NG+hcBiZZPVS6uB/Y+Nw+NdFTW3
        PuC97J9e8FpGMWzYeURU6rrr4DvflI5Gh2sle68vduTmq6sjM3U1A99ODgiT4YkAvntF8c0r
        cvViZXWQ6/HZ5fTlDlFx71G/6AZL6knq1wGt6zlCrESayB/ZMSkgNOEysTOu1sj+BarE1/3c
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTdxjG/d5d747O6lGcHCjBtHObGgtNzPZma4hhsN1CdIvGZYoTC9yq
        WwtNC7Iti1abmVDZEBpNV1RQHB2YzQAb4qCNlBVEKeBqKYo/QtqOuAJFGHFs0M7Klvjfk+fz
        ed6/XhoXR4hk+mBRCa8rUqolpJBo65akbq4SCfPTz/a8DJdv9ODQeWdWAJfuV5Jwenoeh3CX
        XwDVlRYKPIEVYJ+qEcDQX0cx8LdEMei8UI1B4yUXBuO2egQd5x9jUH5zCIOFMTm4opMkVDuH
        EQS9VgzsdzdBp72PAM8vZ0iobQhScMLXToIjZMfB1hvBYMC6QEJ74CiCtn9qceh+4CXgx1CY
        gOPNcwi+qpinYHCxV7BVwnlu53DWh26SqzJOUdxV632KG3zQTHDGunsE53GXci1N5STXevEI
        Zx6xIa7jjoHkjvW7cM4y8yfJfW2cIrnHwbsEF3Z4yfdX7xEqCnn1wUO8Li1jv/DAiKUT07rg
        swv3jpMGZEgzIZpmmS3swEK6CQlpMdOB2Ed1bZgJxT3tk9iGxV/xpZzANkbGqSXJiLEz5h+w
        2JhkNrE3o3TMWcUQbOOTJ0TMwZmzFNsf6qdiIIHZzi6af0cxn2DWs9GZ+FgtYt5gK2qH/7sv
        Zc+PdQliOY55k70Wsj3rxU8di9dJLfnxbN+3ASKWcSaVNf5cg59EjPU5ZH0O1SGsCSXxWr1G
        pdHLtfIivkymV2r0pUUqWUGxpgU9e5GNG9rRlaZpmRNhNHIilsYlq0T73HH5YlGh8vMveF1x
        nq5UzeudaA1NSBJFQ6a+PDGjUpbwn/K8ltf9TzE6LtmAnTLkwLV3LX8k1q/J/d5ZUKnrojIH
        opt3jbs/woZXz7/30jnTbNb60bd0BaorJx4OHjaH1oU25Obv/HJlSnyaY4tvbRntfPGVlMnM
        Vs9oYjjv48EjjX5bMDJHLZMaXl++2/uCipe6R65Pjmzf31pf9SgQLHitZPK7rPZ1/mBSCAve
        +O2Dd5QTY9yMVqQ+LPPIPxErak65WoqvR5oNb+f8tGJZctc2/7Gdy31lubd93bOwUmp2nFzr
        zgxPZKSl1/elZGdIHbpRX8eub3YXV/w9NZyg6W34MBvfpx4/NLdXlmXP3nE10pp3KyAeMhY2
        T29T7N060dOtuLVQMletUqTqXy2XEPoDSvlGXKdX/guGWMx7kQMAAA==
X-CMS-MailID: 20220214080641epcas5p4662e8d0c86f93d525032067cc039c7af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080641epcas5p4662e8d0c86f93d525032067cc039c7af
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080641epcas5p4662e8d0c86f93d525032067cc039c7af@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
 drivers/nvme/target/io-cmd-bdev.c | 65 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 48 +++++++++++++++++++++++
 3 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..3577e8af8003 100644
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
+		id->mssrl = cpu_to_le16(BIO_MAX_VECS << (PAGE_SHIFT - SECTOR_SHIFT));
+		id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl) * BIO_MAX_VECS);
+	}
 
 	/*
 	 * We just provide a single LBA format that matches what the
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 95c2bbb0b2f5..47504aec20ce 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,6 +46,30 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->npda = id->npdg;
 	/* NOWS = Namespace Optimal Write Size */
 	id->nows = to0based(ql->io_opt / ql->logical_block_size);
+
+	/*Copy limits*/
+	if (ql->max_copy_sectors) {
+		id->mcl = cpu_to_le32((ql->max_copy_sectors << 9) / ql->logical_block_size);
+		id->mssrl = cpu_to_le16((ql->max_copy_range_sectors << 9) /
+				ql->logical_block_size);
+		id->msrc = to0based(ql->max_copy_nr_ranges);
+	} else {
+		if (ql->zoned == BLK_ZONED_NONE) {
+			id->msrc = to0based(BIO_MAX_VECS);
+			id->mssrl = cpu_to_le16(
+					(BIO_MAX_VECS << PAGE_SHIFT) / ql->logical_block_size);
+			id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl) * BIO_MAX_VECS);
+#ifdef CONFIG_BLK_DEV_ZONED
+		} else {
+			/* TODO: get right values for zoned device */
+			id->msrc = to0based(BIO_MAX_VECS);
+			id->mssrl = cpu_to_le16(min((BIO_MAX_VECS << PAGE_SHIFT),
+					ql->chunk_sectors) / ql->logical_block_size);
+			id->mcl = cpu_to_le32(min(le16_to_cpu(id->mssrl) * BIO_MAX_VECS,
+						ql->chunk_sectors));
+#endif
+		}
+	}
 }
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
@@ -433,6 +457,43 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
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
+	ret = blkdev_issue_copy(req->ns->bdev, nr_range, rlist, req->ns->bdev, GFP_KERNEL);
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
@@ -451,6 +512,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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
index 6be6e59d273b..cf51169cd71d 100644
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
+	int ret = 0, len = 0, src, id;
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

