Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA74B4443
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 09:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbiBNIgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 03:36:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiBNIgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:36:00 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFA125C7A;
        Mon, 14 Feb 2022 00:35:53 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220214083549epoutp0166504a6ec6c246ead4f88719420bb918~Tmh_qGFES1136711367epoutp01b;
        Mon, 14 Feb 2022 08:35:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220214083549epoutp0166504a6ec6c246ead4f88719420bb918~Tmh_qGFES1136711367epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644827749;
        bh=yjC6zWenkLUSwu5qpAM0es03QhJaWyze1YcezW23Qd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIszECcYVZDIIuHq3HCXWK/DLpBHZ4JviqIUxDOXpNhDZwTWDGk+99eBNkJD75YHJ
         3fzZG4ZK8M7ilhpJUItC5y1DnFqhqKdCyXdE1W5kpEqwZdre+rcIU8Wf6vBeYl1tVn
         Ma4CGOROIAkxCwPIu2mdr+KWNpAa6CXUrzFkwsRc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220214083549epcas5p2748eb531c83cc8bcc76037d15ed7a202~Tmh_JVqcQ0070900709epcas5p2Z;
        Mon, 14 Feb 2022 08:35:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JxyGl2mDgz4x9QY; Mon, 14 Feb
        2022 08:35:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.D6.06423.B541A026; Mon, 14 Feb 2022 17:35:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220214080620epcas5p364a6e5bbf5ade9d115945d7b0cb1b947~TmIOhqSJ31726917269epcas5p36;
        Mon, 14 Feb 2022 08:06:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220214080620epsmtrp2b82da63aa6f748b02e74cd5c9c23f0c3~TmIOfljmA2569425694epsmtrp2U;
        Mon, 14 Feb 2022 08:06:20 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-31-620a145becb2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.94.08738.B7D0A026; Mon, 14 Feb 2022 17:06:19 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220214080615epsmtip2a6c26a2edbfcb401039983a9d28e574e~TmIKDKmgP2389323893epsmtip2Q;
        Mon, 14 Feb 2022 08:06:15 +0000 (GMT)
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
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] block: Introduce a new ioctl for copy
Date:   Mon, 14 Feb 2022 13:29:54 +0530
Message-Id: <20220214080002.18381-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220214080002.18381-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxT2vfdyW0iKd4DdC4uxK1kGGoXO0r0wEJOhu37gHASz4ARKuRZC
        abt+TNzUIQiLKIIwCBSdoAhRUQQ2RKCgODCAfCzlSwWVAS6KIgIKpgJrvbD57znneZ5z3nPe
        HC7u0MFx4cYodYxGKVUISTui6pb7p2t3O9lFenakrUJlrc04qrs7ZYMuDaaTKGfiDY5e3By2
        QZnpuRxkGrFHxvF8G9Q1exhDwxULGKo7m4mhC5eaMPRPyTmAagtfWoiBKQ462taFobdDItS0
        8JxEmY29AI32GDBkvLcG1RlbCGSqOUWiM8WjHHSsr5pE9WNGHJXcnsdQh+EtiapHDgNUZT6D
        o1sPegh0ZewFgVLKXwGUfPwNB3XO3bbZ6EqburfRhoftJH0yaZxDXzcMcujOB+UEnVQwQNCm
        dj1dcfEoSVcW/Uxn9ZcAuvZuAkkn3mnC6dzJaZJOSxon6Zej9wj6RX0PuZMfGusbzUijGI2A
        UcpUUTFKuZ9wW3D4l+FeEk/RWpE3+lwoUErjGD9hwPadazfHKCxLFAp+kCr0ltROqVYr9Njg
        q1HpdYwgWqXV+QkZdZRCLVav00rjtHqlfJ2S0fmIPD0/87III2KjZ6/lEOr+j+NP9JwmE0D9
        R6nAlgspMTRXjhGpwI7rQNUCmHxjHLMSDtQkgEUZtiwxBeCz0cv4kqM78Q1giRoAU8xmkg2S
        MTjRkm5huFySWgPbFrhWgxNFwAszM4QV41QlB9blh1qxI+UPzXfLbayYoD6BHYZfgRXzKB/Y
        9uDPxWausHDo5juNLfUFvDFWgrOaD2BL3shizVUw6Y983PoGSGXbwbyrmTasOQAeqVngsNgR
        Pr39+yJ2gVPjRpI1HANw9s5DjA1yAUzKSCJZlT/8q24Os06DU+6wrMaDTa+E2a1XMLazPUwz
        j2Bsngerf1vCrrC0rGCxjDPsnTm8iGlYntNMsPs9AWDDc0UGEBjeG8jw3kCG/zsXAPwicGbU
        2jg5o/VSi5TMvv9+WaaKqwDvDmv1lmow+GhiXSPAuKARQC4udOKFtdtGOvCipPt/ZDSqcI1e
        wWgbgZdl4ydxlxUyleUylbpwkdjbUyyRSMTe6yUi4Ye8NvlVqQMll+qYWIZRM5olH8a1dUnA
        fLc2yfLsmydr97Tu7ig9EOzSfPBRll1DxfWggCf8gu/2HTLtKr4ZkbbstHEgtf/x0Pe/pIVs
        uu8f+TbeTcF3W75Hk3W2qUgzXDYndjqXH7uyN/j19P2WV6WCyJCrHv57V8TNizrT09f7DsXL
        gr2e+G5KiBRnycNcVQe/DTWJAq8suyf6W+Ie87QkfPbrZgWYSHzMf8rr3HvQiS4sZo5cTg9y
        fF06Hfa4vrZj+3nmfHDg8j6gL/IhGjc+/Olad9dxQV+hNsZPIDkQT58+VL91R+gO/vzykMTJ
        r+wbnrk5e0y7JxfF7KkaQru+ma8IlGX0TmzYHHFqTYrt2AC/r7tyY/b+AWOQkNBGS0WrcY1W
        +i+oMGJD4QQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA03SbUxTZxQH8D333t57aVK8VMVHjeiqBoIZk0mXJ7iBLzCfbGQxapzZkrlq
        rwVGS9daHRqzYrcZcU5FZHDxBV+AgC/YziHSFrAVTS0FJnZSR3FGGNMKBXEKUWQUYua3f87/
        l3O+HJaUlohmsRmarbxOo8iS0WKqximb+85OiXjT4jKrHFXfvE4im29IhM76D9CocGCERMGr
        D0Qo/0ARg9q7w5G9v0SE2oZzCfTAMkYg26l8AlWebSJQb8VpgKwnB8eLziEG7XW3Eejl/XjU
        NNZHo3zHHwD1eAUC2e8uQja7i0LtdUdpdKK8h0H77tTSqD5gJ1HFjVcEahFe0qi2Oxegmhcn
        SOTs8lLoQiBIoR/N/wL0w08jDGodvSFaNh+33/4EC/c8ND5k6mfwFcHP4NYuM4VNpZ0UbvcY
        sKVqL41/PfMdPtxRAbDVZ6Tx7uYmEhc9eUrj/aZ+Gg/23KVwsN5Lr478XPyBks/K2Mbr3k36
        Spw+fLmQ0na8/e3P3mO0EdTPzgNhLOQS4O3dIyAPiFkpVwvgrUETNVnMhOWj18jJPBVWvupl
        JpGJgIXujvGCZWluEXSPsSEzjaNg5fPnVMiQnJ+B5y9ZJhZN5ZLhC59ZFMoUtxC2CAUglCVc
        InR3vT4wH568f3XChHFLYWOgYmIuHTdFXgcz6SOgq7ibCt0luWhYfVwaGpPcXGj6rYQ8CCKE
        N5TwvxLeUKWArAIzea1erVLr47XvafjtcXqFWm/QqOI2Z6stYOJ/YmNrga1qIM4BCBY4AGRJ
        2TTJl56wTVKJUpGzg9dlb9QZsni9A8xmKdkMSVuea6OUUym28l/zvJbXvW4JNmyWkXCW1F0L
        H854ttYpT9QEoj3aDn9kIGXOLzhdt74gMb741PX3z1XtW11dtP1yi5Ky1qTU/b3Y2fBxapLl
        iWrts4up0w+Otu7YkPo0uiX/yCXDwz2bM8vvaPJMsoSRNLvL2HAh5eGCoTLjUt9RzzZXUqRK
        cFu/2OWzNczwh7vtrd2Zhs+Kg47S6GVT7tE6/OcS65qYdSuPHBqzM8kr6h8dtxUsjPmnLnmd
        +aNVt/oWwK6c8u/NW1TsORP6K8exR+0/NrBkXlpjc7N8Dm78NKr5wz7lzrSyrLf8Db1bOlfK
        RuU3s6N+P/ONPJgbY7uo1JIRG3atiMKZHm4goBCtP+9YnnD4sYzSpyviY0mdXvEft6Oxdq4D
        AAA=
X-CMS-MailID: 20220214080620epcas5p364a6e5bbf5ade9d115945d7b0cb1b947
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080620epcas5p364a6e5bbf5ade9d115945d7b0cb1b947
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080620epcas5p364a6e5bbf5ade9d115945d7b0cb1b947@epcas5p3.samsung.com>
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

Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
to one or more destination in a device. COPY ioctl accepts a 'copy_range'
structure that contains no of range, a reserved field , followed by an
array of ranges. Each source range is represented by 'range_entry' that
contains source start offset, destination start offset and length of
source ranges (in bytes)

MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.

Example code, to issue BLKCOPY:
/* Sample example to copy three entries with [dest,src,len],
* [32768, 0, 4096] [36864, 4096, 4096] [40960,8192,4096] on same device */

int main(void)
{
	int i, ret, fd;
	unsigned long src = 0, dst = 32768, len = 4096;
	struct copy_range *cr;
	cr = (struct copy_range *)malloc(sizeof(*cr)+
					(sizeof(struct range_entry)*3));
	cr->nr_range = 3;
	cr->reserved = 0;
	for (i = 0; i< cr->nr_range; i++, src += len, dst += len) {
		cr->range_list[i].dst = dst;
		cr->range_list[i].src = src;
		cr->range_list[i].len = len;
		cr->range_list[i].comp_len = 0;
	}
	fd = open("/dev/nvme0n1", O_RDWR);
	if (fd < 0) return 1;
	ret = ioctl(fd, BLKCOPY, cr);
	if (ret != 0)
	       printf("copy failed, ret= %d\n", ret);
	for (i=0; i< cr->nr_range; i++)
		if (cr->range_list[i].len != cr->range_list[i].comp_len)
			printf("Partial copy for entry %d: requested %llu, completed %llu\n",
								i, cr->range_list[i].len,
								cr->range_list[i].comp_len);
	close(fd);
	free(cr);
	return ret;
}

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
---
 block/ioctl.c           | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h |  9 +++++++++
 2 files changed, 41 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e4..a2dc2cfbae6d 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -124,6 +124,36 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	return err;
 }
 
+static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
+		unsigned long arg)
+{
+	struct copy_range crange, *ranges = NULL;
+	size_t payload_size = 0;
+	int ret;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
+		return -EFAULT;
+
+	if (unlikely(!crange.nr_range || crange.reserved || crange.nr_range >= MAX_COPY_NR_RANGE))
+		return -EINVAL;
+
+	payload_size = (crange.nr_range * sizeof(struct range_entry)) + sizeof(crange);
+
+	ranges = memdup_user((void __user *)arg, payload_size);
+	if (IS_ERR(ranges))
+		return PTR_ERR(ranges);
+
+	ret = blkdev_issue_copy(bdev, ranges->nr_range, ranges->range_list, bdev, GFP_KERNEL);
+	if (copy_to_user((void __user *)arg, ranges, payload_size))
+		ret = -EFAULT;
+
+	kfree(ranges);
+	return ret;
+}
+
 static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
@@ -455,6 +485,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKSECDISCARD:
 		return blk_ioctl_discard(bdev, mode, arg,
 				BLKDEV_DISCARD_SECURE);
+	case BLKCOPY:
+		return blk_ioctl_copy(bdev, mode, arg);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 55bca8f6e8ed..190911ea4311 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -78,6 +78,14 @@ struct range_entry {
 	__u64 comp_len;
 };
 
+struct copy_range {
+	__u64 nr_range;
+	__u64 reserved;
+
+	/* Range_list always must be at the end */
+	struct range_entry range_list[];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -199,6 +207,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKCOPY _IOWR(0x12, 129, struct copy_range)
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.30.0-rc0

