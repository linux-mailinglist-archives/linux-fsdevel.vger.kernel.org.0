Return-Path: <linux-fsdevel+bounces-79822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Cb5DDUFr2lwLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:36:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AEC23DB72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F176305A8BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1DC2F49F6;
	Mon,  9 Mar 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YAOI/wZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07943C1970;
	Mon,  9 Mar 2026 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077712; cv=none; b=r1dSfIGyPYTqn0JaEPmCAY7997CXFjrCb71sdstAqF+rB4bcKUPolWpI0CPLBCmKXx5QS9WY2C8dI+pfRB+VVnYVq2FdXJ8qMFYz1MPIF4NK7JIgeVu98MsL69WCYEbfoTPPMxVk9xOg0sR/SX7E1nOpXpoElCaStiZsDqcaZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077712; c=relaxed/simple;
	bh=lafVXzuhV61RjmVrewetl0LZjUOWGKV1axCa+l3Yj6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNg6LxnbnU3HkA4mvP73rVMmJhLhaKnQb7wRwMcRh+fRd64tx4YRNoUrjqVG6EimvgpfCQZcXDVZ/EftKu3+IEYNPlRAprYFUNxXHW8RZfQIt6jx7T2xCy6aZmSpP7FLZWooR16A2pVV9FcvYK8S9/f69p8A98HXQHSsMqKevPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YAOI/wZ/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629F56jS1503836;
	Mon, 9 Mar 2026 17:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vtlhm0EQ1xSG1AnmV
	kTMbebOcFrwSxiUsQY+cdkOjVQ=; b=YAOI/wZ/8OimsXaDvDlPxjpki1Qjx3RMx
	L9nQRWJiI0jZtrxRDQE96kPt337TMSiVItEqwuTsY5QpTQYlLUWbKpF2a43WEYl7
	FNztpE4e0Ijpj2egonKXqjaFNgh8x+9PmM4FkDPAJK80yG/LkVvrTMDJFFuGXKId
	qjaPm8fgWCC4RP/xdSK0foNoTKnaDM04wepXcR5/BWebtYGRIsge17aTWyPW8JnD
	+M5Hm/tcKKJc6jPfmIPNi7Esv5tt5M612ZxImQ75AZQ610pD0N+mHMZo/tbCmV/x
	q1Z58gCSyxAK5ztqpHI8zX9dsPKtp6qqDyVi+WFE593PSwdm1Zz8w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr7gp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 17:34:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629DjNq9029356;
	Mon, 9 Mar 2026 17:34:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6ujjk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 17:34:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629HYhfM52036046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 17:34:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7F7A20043;
	Mon,  9 Mar 2026 17:34:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35B7920040;
	Mon,  9 Mar 2026 17:34:41 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.68])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 17:34:40 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz,
        Luis Chamberlain <mcgrof@kernel.org>, dgc@kernel.org, tytso@mit.edu,
        p.raghav@samsung.com, andres@anarazel.de, linux-kernel@vger.kernel.org
Subject: [RFC 2/3] iomap: Enable stable writes for RWF_WRITETHROUGH inodes
Date: Mon,  9 Mar 2026 23:04:32 +0530
Message-ID: <3704b81046b11f8b8da0367c7c8ad8767f42e5df.1773076216.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773076216.git.ojaswin@linux.ibm.com>
References: <cover.1773076216.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1OCBTYWx0ZWRfX68f8wx7XIu53
 Enl2neocfxBMLdQx+ZNIosXumzEksznAo0zQPvxkB2sH7/dCFSjMK04u1XoHgnpbjIWfloY1uiI
 9e71XuWVW467n/4EJZMh0YVIQnobX/RkXZFI2VDV1WYlFY1Xr6r30lITlPEPfzNCi5LSe+Nwpqg
 NtQIi0NDrdC69DQxKiyRQPg5IpHK/F2srqYia4BkeVC4cdan0G+vzZlZODDSj6P8cJ4WYtsEjd3
 dTQbqXLPzs9xt0DBVO420BcIJYRol37p9RncpFpZsphcydFiQUEBP9fwoE3jNXKHDvI5c4t/gM8
 V6djGyo4MMhRrXmjAnaLin1kFUEVMKKozb+r598nLVDVG3UGR04gZkkd6FlQ2dZbmEL3BHDCkuF
 UoE9PiRsN3BD3qOTEVDsjeExNhsZL2tPmn0HB9ycn+TEkRbsyBWE0BZVMOYAeMjVk80UsdOhdQy
 c9G1JgOtZDVLkj88SZQ==
X-Proofpoint-GUID: Vhmub7mEpm-eBb32uRGgmbNM8WjTJQmQ
X-Proofpoint-ORIG-GUID: qyic1gUoH0EE9xn4Ec68tZhCv1zerRtP
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69af04b7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SyJQyBQOrdvXXMiPuw4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090158
X-Rspamd-Queue-Id: 91AEC23DB72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,infradead.org,lst.de,gmail.com,suse.cz,mit.edu,samsung.com,anarazel.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79822-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:email,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Currently, RWF_WRITETHROUGH writes wait for writeback to complete
on a folio before performing the writethrough. This serializes
writethrough with each other and the writeback path. However, it is also
desirable have similar guarantees between RWF_WRITETHROUGH and non
writethrough writes.

Hence, ensure stable writes are enabled on an inode's mapping as
long as a writethrough write is ongoing. This way, all paths will
wait for RWF_WRITETHROUGH to complete on a folio before proceeding.

To track inflight writethrough writes, we use an atomic counter in the
inode->i_mapping. This struct was chosen because (i) writethrough is an
operation on the folio and (ii) we don't want to add bloat to struct
inode.

Suggested-by: Dave Chinner <dgc@kernel.org>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/inode.c             |  1 +
 fs/iomap/buffered-io.c | 35 +++++++++++++++++++++++++++++++++--
 fs/iomap/direct-io.c   |  2 ++
 include/linux/fs.h     |  2 ++
 include/linux/iomap.h  |  2 ++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index cc12b68e021b..5b779c112ff8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -280,6 +280,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	mapping->flags = 0;
 	mapping->wb_err = 0;
 	atomic_set(&mapping->i_mmap_writable, 0);
+	atomic_set(&mapping->i_wt_count, 0);
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
 	atomic_set(&mapping->nr_thps, 0);
 #endif
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ab169daa1126..9d4d459af1a0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1150,11 +1150,41 @@ static bool iomap_writethrough_checks(struct kiocb *iocb, size_t off, loff_t len
 	return true;
 }
 
+/**
+ * inode_writethrough_begin - signal start of a RWF_WRITETHROUGH request
+ * @inode: inode the writethrough happens on
+ *
+ * This is called when we are about to start a writethrough on an inode.
+ * If it is the first writethrough, set the mapping as stable to ensure
+ * other folio operations wait for writeback to finish.
+ *
+ * To avoid a race, just set the mapping stable first and then increment
+ * writethrough count, so that the stable writes are enforced as soon as
+ * writethrough count becomes non zero.
+ */
+inline void inode_writethrough_begin(struct inode *inode)
+{
+	mapping_set_stable_writes(inode->i_mapping);
+	atomic_inc(&inode->i_mapping->i_wt_count);
+}
+
+/**
+ * inode_writethrough_end - signal finish of a RWF_WRITETHROUGH request
+ * @inode: inode the writethrough I/O happened on
+ *
+ * This is called once we've finished processing a writethrough request
+ */
+inline void inode_writethrough_end(struct inode *inode)
+{
+	if (atomic_dec_and_test(&inode->i_mapping->i_wt_count))
+		mapping_clear_stable_writes(inode->i_mapping);
+}
+
 /*
  * With writethrough, we might potentially be writing through a partial
  * folio hence we don't clear the dirty bit (yet)
  */
-static void folio_prepare_writethrough(struct folio *folio)
+static void folio_prepare_writethrough(struct inode *inode, struct folio *folio)
 {
 	if (folio_test_writeback(folio))
 		folio_wait_writeback(folio);
@@ -1167,6 +1197,7 @@ static void folio_prepare_writethrough(struct folio *folio)
 		/* Refer folio_clear_dirty_for_io() for why this is needed */
 		folio_mark_dirty(folio);
 
+	inode_writethrough_begin(inode);
 }
 
 /**
@@ -1203,7 +1234,7 @@ static int iomap_writethrough_begin(struct kiocb *iocb, struct folio *folio,
 	bool fully_written;
 	u64 zero = 0;
 
-	folio_prepare_writethrough(folio);
+	folio_prepare_writethrough(iter->inode, folio);
 
 	wt_ctx->bvec = kmalloc(sizeof(struct bio_vec), GFP_KERNEL | GFP_NOFS);
 	if (!wt_ctx->bvec)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f4d8ff08a83a..12680d97d765 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -140,6 +140,8 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 		kiocb_invalidate_post_direct_write(iocb, dio->size);
 
 	inode_dio_end(file_inode(iocb->ki_filp));
+	if (dio->flags & IOMAP_DIO_BUF_WRITETHROUGH)
+		inode_writethrough_end(file_inode(iocb->ki_filp));
 
 	if (ret > 0) {
 		iocb->ki_pos += ret;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ca291957140e..6b7491fdd51a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -456,6 +456,7 @@ extern const struct address_space_operations empty_aops;
  *   memory mappings.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
  * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
+ * @i_wt_count: Number of RWF_WRITETHROUGH writes ongoing in mapping.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -474,6 +475,7 @@ struct address_space {
 	struct rw_semaphore	invalidate_lock;
 	gfp_t			gfp_mask;
 	atomic_t		i_mmap_writable;
+	atomic_t		i_wt_count;
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
 	/* number of thp, only for non-shmem files */
 	atomic_t		nr_thps;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b96574bb2918..6d08b966ceaf 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -630,6 +630,8 @@ struct iomap_writethrough_ops {
 ssize_t iomap_file_writethrough_write(struct kiocb *iocb, struct iov_iter *i,
 				      const struct iomap_writethrough_ops *wt_ops,
 				      void *private);
+inline void inode_writethrough_begin(struct inode *inode);
+inline void inode_writethrough_end(struct inode *inode);
 
 #ifdef CONFIG_SWAP
 struct file;
-- 
2.52.0


