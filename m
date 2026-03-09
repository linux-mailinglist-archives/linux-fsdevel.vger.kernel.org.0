Return-Path: <linux-fsdevel+bounces-79824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCImKQgFr2knLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:36:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8EF23DB4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04B4E303102A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232183ED127;
	Mon,  9 Mar 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W4zTE2pB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083B3CB2D2;
	Mon,  9 Mar 2026 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077713; cv=none; b=YdTzg9fEoOqGlJCuFC4w4Lwx3fujNoQs/95cKXkDjQDQpRxcFUF9/aW7hCctQun8q0a4ymUnCHUXcOes3mk8MUdMfleVG9TunH5wVcztiDAT4xjS9fKvEDNglLBuRDGfROpW6jP9u61/GFkc2/8c3+NnwX+C12EIaLS5LU9f4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077713; c=relaxed/simple;
	bh=KNiQ4vnzohPD+CrKJKVDWAoXtCdhGhunzA7SJz+O6NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmQYsq3qvf6IyEiWhi2PR/BTD1E9kVZPC837S9fofzd/xf8raUcDgTiNYpYaSYoNRny8qp6YySiFw7Hf/YP34D55u864ELm9PQHeqLOjiTPWuH7Hy2ealQztTGU0AwWKRapnLjM2KNr7leS7I4IhpdUg0g306jqtdoCpdYmbyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W4zTE2pB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629AkKQT044856;
	Mon, 9 Mar 2026 17:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ifAE0POzZsjI18sPi
	X8ZSNOuCtZhBlQEf3fIV0DMNsE=; b=W4zTE2pBu/VqPoykfBdfG1x9ubjAJBpR+
	ORDrunBIyA7XqPODxTpBFjkb2zZbnO1A6eGgE6WZUY6nLjltc+78dOdYfwCrsVj2
	R3FCVwLjwLABv1LDPpJ30VBtoSshKw9iLxe7PWBENJuPtiZKU7XZKdCY0k0YxKVr
	nHzXAQn1XNFSq886hZ+9hqGo5qtyb12V+E/G0MMFALX8pRfu+WSZW+i6b7X3Oj6O
	UvrbUeDXaoubGR6Znm1TNH/VOQ3u0gqAzc/GsVwRp6f7pGdUM/lXD0/Mg582qcti
	ZD43MVEB4VdGcNlqj7QYO8YDYU6gHZZi4flves/B/7L7o7pW100GQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun7fvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 17:34:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629Fdof6015720;
	Mon, 9 Mar 2026 17:34:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs121wn5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 17:34:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629HYetV29819198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 17:34:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C668920043;
	Mon,  9 Mar 2026 17:34:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFA6520040;
	Mon,  9 Mar 2026 17:34:37 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.68])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 17:34:37 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz,
        Luis Chamberlain <mcgrof@kernel.org>, dgc@kernel.org, tytso@mit.edu,
        p.raghav@samsung.com, andres@anarazel.de, linux-kernel@vger.kernel.org
Subject: [RFC 1/3] iomap: Support buffered RWF_WRITETHROUGH via async dio backend
Date: Mon,  9 Mar 2026 23:04:31 +0530
Message-ID: <c84ddc3f864f840d646b6aa19fd9b3e83e079c0b.1773076216.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: dduAG9BTT7gAC04i-iqqdmylaljNW0qx
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69af04b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9M3kuzUYvA3a-4gWJSYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1OCBTYWx0ZWRfX7jnDfmWWx895
 gFP2VYLvK+LCRTQMBxdh+2bBnC9aK13qZK8Fr8v+rDMZCWgxbriu0eI2NSYu3O6vrhUq/03ygYm
 8nDyRtt7553ykmT5F+xnMvxBB300YtuyKRyvvPI4qCfONExP+8hgXzSVH1F/BwScLZ8qxPmesIY
 Wax0JbkDLsXYNc4b4Un1iDcebSDi8P8xBlqESHFyjQ5osNQVW2MEpc03x54zQCnOgTCt6fQwW6w
 lr1+agzgVtf3xdFWtWiol8S/EP/PpjsrlVX0nKAyjnO9Y51YR+cAcn4+Xji7Fa2ZxdpBxOYDjk8
 pPrbtQa+rR4UIzpCv2kSrhRdrDORA+sOJMkivUwodckSYeWX9+QTU8K5qsU1/9SjOp3paD0GQdW
 gEjR2vWkt34qWyT4HudALAiMdhnGHq0fu1LeZVg3ep4zPmDsBk+Hw8pHG6cXGccwNljlELBW11Z
 SZvErFtRwh3UeDt3MLw==
X-Proofpoint-ORIG-GUID: EdOgrduV7i6XDahiFR55NJnYo8tGL1zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090158
X-Rspamd-Queue-Id: 1F8EF23DB4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,infradead.org,lst.de,gmail.com,suse.cz,mit.edu,samsung.com,anarazel.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79824-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,suse.cz:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

This adds initial support for performing buffered RWF_WRITETHROUGH write.
The rough flow for a writethrough write is as follows:

1. Acquire inode lock and call iomap begin to get an allocated mapping.
2. Acquire folio lock.
3. Perform a memcpy from user buffer to the folio and mark it dirty
4. Wait for any current writeback to complete and then call folio_mkclean()
   to prevent mmap writes from changing it.
5. Start writeback on the folio
6. Use dio codepath to send an asynchronous dio. We use the
   inode_dio_begin/end() logic for writethrough as well to serialize
   against paths like truncate.
7. Once the IO is queued, the write syscall is free to unlock folio and
   return.
8. In the endio path, cleanup resources, record any errors and clear
   writeback on folio.

Few things to note in the design:

1. Folio handling note: We might be writing through a partial folio so
we need to be careful to not clear the folio dirty bit unless there are
no dirty blocks in the folio after the writethrough.

2. we call iomap_begin() twice, one at the start and the other is within
the iomap_dio_rw(). Functionally this should be okay since the second
call should just return whatever the first call allocated. This
redundancy is kept as a tradeoff to avoid churning too much code for
the initial PoC.

3. Along with the writeback bit, we also use inode_dio_begin() to
synchronize against paths like truncate. This might be too restrictive
but we can look into this in next revisions.

4. Freezing support is a WIP. Check the comment on top of
iomap_writethrough_iter()

Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Dave Chinner <dgc@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/iomap/buffered-io.c  | 383 ++++++++++++++++++++++++++++++++++++++++
 fs/iomap/direct-io.c    |  62 ++++---
 include/linux/fs.h      |   7 +
 include/linux/iomap.h   |  32 ++++
 include/uapi/linux/fs.h |   5 +-
 5 files changed, 466 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3cf93ab2e38a..ab169daa1126 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -9,6 +9,7 @@
 #include <linux/swap.h>
 #include <linux/migrate.h>
 #include <linux/fserror.h>
+#include <linux/rmap.h>
 #include "internal.h"
 #include "trace.h"
 
@@ -1091,6 +1092,351 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
+static void iomap_writethrough_endio(struct kiocb *iocb, long ret)
+{
+	struct iomap_writethrough_ctx *wt_ctx =
+		container_of(iocb, struct iomap_writethrough_ctx, iocb);
+	struct inode *inode = wt_ctx->inode;
+
+	/*
+	 * NOTE: Is ret always < 0 for short writes? ioend_writeback_end_io
+	 * seems to suggest so.
+	 */
+	if (ret < 0) {
+		mapping_set_error(inode->i_mapping, ret);
+		pr_err_ratelimited(
+			"%s: writeback error on inode %lu, offset %lld",
+			inode->i_sb->s_id, inode->i_ino, iocb->ki_pos);
+	}
+
+	fput(iocb->ki_filp);
+	folio_end_writeback(wt_ctx->folio);
+	kfree(wt_ctx->bvec);
+	kfree(wt_ctx);
+}
+
+/*
+ * Check the pos and length of writethrough satisfy the constraints.
+ * Returns false if checks fail, else true.
+ */
+static bool iomap_writethrough_checks(struct kiocb *iocb, size_t off, loff_t len,
+				      struct folio *folio)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	int bs = i_blocksize(inode);
+	loff_t start = iocb->ki_pos;
+	loff_t end = start + len;
+	loff_t folio_end = folio_pos(folio) + folio_size(folio);
+
+	/*
+	 * start and length should be algned to block size.
+	 */
+	if (WARN_ON((start | len) & (bs - 1)))
+		return false;
+
+	/*
+	 * We modified start as well as offset in folio, so make sure they are
+	 * still in sync
+	 */
+	if (WARN_ON(off != offset_in_folio(folio, start)))
+		return false;
+
+	/*
+	 * Range should be contained in folio
+	 */
+	if (WARN_ON(start < folio_pos(folio) || end > folio_end))
+		return false;
+
+	return true;
+}
+
+/*
+ * With writethrough, we might potentially be writing through a partial
+ * folio hence we don't clear the dirty bit (yet)
+ */
+static void folio_prepare_writethrough(struct folio *folio)
+{
+	if (folio_test_writeback(folio))
+		folio_wait_writeback(folio);
+
+	/*
+	 * TODO: We are trying to avoid folio_mkclean() usages but we need it
+	 * here to serialize against mmap writes. Is there a better way?
+	 */
+	if (folio_mkclean(folio))
+		/* Refer folio_clear_dirty_for_io() for why this is needed */
+		folio_mark_dirty(folio);
+
+}
+
+/**
+ * iomap_writethrough_begin - prepare the various structures for writethrough
+ * @iocb:
+ * @folio:
+ * @iter:
+ * @wt_ctx: holds context needed during IO and endio
+ * @iov_wt: (output) will hold the iov_iter that can be passed to dio
+ * @wt_off: (input/output) holds the offset of write. Upon return, will hold the
+ *          aligned offset
+ * @wt_len: (input/output) holds the len of write. Upon return, will hold the
+ *          aligned len
+ *
+ * This function does the major preparation work needed before starting the
+ * writethrough. The main task is to prepare folio for writeththrough (by
+ * setting writeback on it) and to ensure the offset and len are block aligned
+ * so that dio doesn't complain.
+ *
+ * In case an error is encountered, the folio writeback wont be started and the
+ * range under write through would still be dirty.
+ */
+static int iomap_writethrough_begin(struct kiocb *iocb, struct folio *folio,
+				    struct iomap_iter *iter,
+				    struct iomap_writethrough_ctx *wt_ctx,
+				    struct iov_iter *iov_wt, size_t offset,
+				    u64 len)
+{
+	int bs = i_blocksize(iter->inode);
+
+	size_t off_aligned = round_down(offset, bs);
+	u64 len_aligned = round_up(len, bs);
+	u64 pos_aligned = round_down(iter->pos, bs);
+	bool fully_written;
+	u64 zero = 0;
+
+	folio_prepare_writethrough(folio);
+
+	wt_ctx->bvec = kmalloc(sizeof(struct bio_vec), GFP_KERNEL | GFP_NOFS);
+	if (!wt_ctx->bvec)
+		return -ENOMEM;
+
+	bvec_set_folio(wt_ctx->bvec, folio, len_aligned, off_aligned);
+	iov_iter_bvec(iov_wt, ITER_SOURCE, wt_ctx->bvec, 1, len_aligned);
+
+	kiocb_clone(&wt_ctx->iocb, iocb, iocb->ki_filp);
+	wt_ctx->iocb.ki_pos = pos_aligned;
+	wt_ctx->iocb.ki_complete = iomap_writethrough_endio;
+	wt_ctx->folio = folio;
+	wt_ctx->inode = iter->inode;
+	wt_ctx->orig_pos = iter->pos;
+	wt_ctx->orig_len = len;
+
+	if (!iomap_writethrough_checks(
+			&wt_ctx->iocb, off_aligned,
+			iov_iter_count(iov_wt), folio)) {
+		/* This should never happen */
+		WARN_ON_ONCE(true);
+
+		kfree(wt_ctx->bvec);
+		return -EINVAL;
+	}
+
+	get_file(wt_ctx->iocb.ki_filp);
+
+	/*
+	 * We might either write through the complete folio or a partial folio
+	 * writethrough might result in all blocks becoming non-dirty, so we need to
+	 * check and mark the folio clean if that is the case.
+	 */
+	fully_written = (off_aligned == 0 && len_aligned == folio_size(folio));
+
+	iomap_clear_range_dirty(folio, off_aligned, len_aligned);
+	if (fully_written ||
+	    !iomap_find_dirty_range(folio, &zero, folio_size(folio)))
+		folio_clear_dirty(folio);
+
+	folio_start_writeback(folio);
+
+	return 0;
+}
+
+/**
+ * iomap_writethrough_iter - perform RWF_WRITETHROUGH buffered write
+ * @iocb: kernel iocb struct
+ * @iter: iomap iter holding mapping information
+ * @i: iov_iter for write
+ * @wt_ops: the fs callbacks needed for writethrough
+ *
+ * This function copies the user buffer to folio similar to usual buffered
+ * IO path, with the difference that we immediately issue the IO. For this we
+ * utilize the async dio machinery. While issuing the async IO, we need to be
+ * careful to clone the iocb so that it doesnt get destroyed underneath us
+ * incase the syscall exits before endio() is triggered.
+ *
+ * Folio handling note: We might be writing through a partial folio so we need
+ * to be careful to not clear the folio dirty bit unless there are no dirty blocks
+ * in the folio after the writethrough.
+ *
+ * TODO: Filesystem freezing during ongoing writethrough writes is currently
+ * buggy. We call file_start_write() once before taking any lock but we can't
+ * just simply call the corresponding file_end_write() in endio because single
+ * RWF_WRITETHROUGH might be split into many IOs leading to multiple endio()
+ * calls. Currently we are looking into the right way to synchronise with
+ * freeze_super().
+ */
+static int iomap_writethrough_iter(struct kiocb *iocb, struct iomap_iter *iter,
+				   struct iov_iter *i,
+				   const struct iomap_writethrough_ops *wt_ops)
+{
+	ssize_t total_written = 0;
+	int status = 0;
+	struct address_space *mapping = iter->inode->i_mapping;
+	size_t chunk = mapping_max_folio_size(mapping);
+	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
+
+	if (!(iter->flags & IOMAP_WRITETHROUGH))
+		return -EINVAL;
+
+	do {
+		struct folio *folio;
+		loff_t old_size;
+		size_t offset;		/* Offset into folio */
+		u64 bytes;		/* Bytes to write to folio */
+		size_t copied;		/* Bytes copied from user */
+		u64 written;		/* Bytes have been written */
+		loff_t pos;
+		bool noretry = false;
+
+		bytes = iov_iter_count(i);
+retry:
+		offset = iter->pos & (chunk - 1);
+		bytes = min(chunk - offset, bytes);
+		status = balance_dirty_pages_ratelimited_flags(mapping,
+							       bdp_flags);
+		if (unlikely(status))
+			break;
+
+		if (bytes > iomap_length(iter))
+			bytes = iomap_length(iter);
+
+		/*
+		 * Bring in the user page that we'll copy from _first_.
+		 * Otherwise there's a nasty deadlock on copying from the
+		 * same page as we're writing to, without it being marked
+		 * up-to-date.
+		 *
+		 * For async buffered writes the assumption is that the user
+		 * page has already been faulted in. This can be optimized by
+		 * faulting the user page.
+		 */
+		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
+			status = -EFAULT;
+			break;
+		}
+
+		status = iomap_write_begin(iter, wt_ops->write_ops, &folio,
+					   &offset, &bytes);
+		if (unlikely(status)) {
+			iomap_write_failed(iter->inode, iter->pos, bytes);
+			break;
+		}
+		if (iter->iomap.flags & IOMAP_F_STALE)
+			break;
+
+		pos = iter->pos;
+
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_folio(folio);
+
+		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
+		written = iomap_write_end(iter, bytes, copied, folio) ?
+			  copied : 0;
+
+		/*
+		 * Update the in-memory inode size after copying the data into
+		 * the page cache.  It's up to the file system to write the
+		 * updated size to disk, preferably after I/O completion so that
+		 * no stale data is exposed.  Only once that's done can we
+		 * unlock and release the folio.
+		 */
+		old_size = iter->inode->i_size;
+		if (pos + written > old_size) {
+			i_size_write(iter->inode, pos + written);
+			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
+		}
+
+		if (!written)
+			goto put_folio;
+
+		/*
+		 * The copy-to-folio operation succeeded. Lets use the dio
+		 * machinery to send the writethrough IO.
+		 */
+		if (written) {
+			struct iomap_writethrough_ctx *wt_ctx;
+			int dio_flags = IOMAP_DIO_BUF_WRITETHROUGH;
+			struct iov_iter iov_wt;
+
+			wt_ctx = kzalloc(sizeof(struct iomap_writethrough_ctx),
+					GFP_KERNEL | GFP_NOFS);
+			if (!wt_ctx) {
+				status = -ENOMEM;
+				written = 0;
+				goto put_folio;
+			}
+
+			status = iomap_writethrough_begin(iocb, folio, iter,
+							  wt_ctx, &iov_wt,
+							  offset, written);
+			if (status < 0) {
+				if (status != -ENOMEM)
+					noretry = true;
+				written = 0;
+				kfree(wt_ctx);
+				goto put_folio;
+			}
+
+			/* Dont retry for any failures in writethrough */
+			noretry = true;
+
+			status = iomap_dio_rw(&wt_ctx->iocb, &iov_wt,
+					      wt_ops->ops, wt_ops->dio_ops,
+					      dio_flags, NULL, 0);
+
+			/*
+			 * If IO is queued, then we will do all the cleanup
+			 * during ioend so just unlock the folio.
+			 */
+			if (status == -EIOCBQUEUED)
+				goto put_folio;
+
+			/*
+			 * We either encountered an error or IO completed. In
+			 * either case, it is now safe to free up resources and
+			 * end writeback.
+			 */
+			if (status < 0)
+				written = 0;
+
+			iomap_writethrough_endio(&wt_ctx->iocb, status);
+		}
+put_folio:
+		__iomap_put_folio(iter, wt_ops->write_ops, written, folio);
+
+		if (old_size < pos)
+			pagecache_isize_extended(iter->inode, old_size, pos);
+
+		cond_resched();
+		if (unlikely(written == 0)) {
+			iomap_write_failed(iter->inode, pos, bytes);
+			iov_iter_revert(i, copied);
+
+			if (noretry)
+				break;
+			if (chunk > PAGE_SIZE)
+				chunk /= 2;
+			if (copied) {
+				bytes = copied;
+				goto retry;
+			}
+		} else {
+			total_written += written;
+			iomap_iter_advance(iter, written);
+		}
+	} while (iov_iter_count(i) && iomap_length(iter));
+
+	return total_written ? 0 : status;
+}
+
 static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		const struct iomap_write_ops *write_ops)
 {
@@ -1227,6 +1573,43 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
+ssize_t iomap_file_writethrough_write(struct kiocb *iocb, struct iov_iter *i,
+				      const struct iomap_writethrough_ops *wt_ops,
+				      void *private)
+{
+	struct iomap_iter iter = {
+		.inode		= iocb->ki_filp->f_mapping->host,
+		.pos		= iocb->ki_pos,
+		.len		= iov_iter_count(i),
+		.flags		= IOMAP_WRITE,
+		.private	= private,
+	};
+	ssize_t ret;
+
+	/*
+	 * For now we don't support any other flag with WRITETHROUGH
+	 */
+	if (!(iocb->ki_flags & IOCB_WRITETHROUGH))
+		return -EINVAL;
+	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_DONTCACHE))
+		return -EINVAL;
+
+	iter.flags |= IOMAP_WRITETHROUGH;
+
+	while ((ret = iomap_iter(&iter, wt_ops->ops)) > 0) {
+		WARN_ON(iter.iomap.type != IOMAP_UNWRITTEN &&
+			iter.iomap.type != IOMAP_MAPPED);
+		iter.status = iomap_writethrough_iter(iocb, &iter, i, wt_ops);
+	}
+
+	if (unlikely(iter.pos == iocb->ki_pos))
+		return ret;
+	ret = iter.pos - iocb->ki_pos;
+	iocb->ki_pos = iter.pos;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iomap_file_writethrough_write);
+
 static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c24d94349ca5..f4d8ff08a83a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -713,7 +713,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->i_size = i_size_read(inode);
 	dio->dops = dops;
 	dio->error = 0;
-	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED | IOMAP_DIO_BOUNCE);
+	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED | IOMAP_DIO_BOUNCE |
+				  IOMAP_DIO_BUF_WRITETHROUGH);
 	dio->done_before = done_before;
 
 	dio->submit.iter = iter;
@@ -747,8 +748,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (iocb->ki_flags & IOCB_ATOMIC)
 			iomi.flags |= IOMAP_ATOMIC;
 
-		/* for data sync or sync, we need sync completion processing */
-		if (iocb_is_dsync(iocb)) {
+		/*
+		 * for data sync or sync, we need sync completion processing.
+		 * for buffered writethrough, sync is handled in buffered IO
+		 * path so not needed here
+		 */
+		if (iocb_is_dsync(iocb) &&
+		    !(dio->flags & IOMAP_DIO_BUF_WRITETHROUGH)) {
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
 
 		       /*
@@ -765,35 +771,47 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/*
-		 * i_size updates must to happen from process context.
+		 * i_size updates must to happen from process context. For
+		 * buffered writetthrough, caller might have already changed the
+		 * i_size but still needs endio i_size handling. We can't detect
+		 * this here so just use process context unconditionally.
 		 */
-		if (iomi.pos + iomi.len > dio->i_size)
+		if ((iomi.pos + iomi.len > dio->i_size) ||
+		    dio_flags & IOMAP_DIO_BUF_WRITETHROUGH)
 			dio->flags |= IOMAP_DIO_COMP_WORK;
 
 		/*
 		 * Try to invalidate cache pages for the range we are writing.
 		 * If this invalidation fails, let the caller fall back to
 		 * buffered I/O.
+		 *
+		 * The execption is if we are using dio path for buffered
+		 * RWF_WRITETHROUGH in which case we cannot inavlidate the pages
+		 * as we are writing them through and already hold their
+		 * folio_lock. For the same reason, disable end of write invalidation
 		 */
-		ret = kiocb_invalidate_pages(iocb, iomi.len);
-		if (ret) {
-			if (ret != -EAGAIN) {
-				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
-								iomi.len);
-				if (iocb->ki_flags & IOCB_ATOMIC) {
-					/*
-					 * folio invalidation failed, maybe
-					 * this is transient, unlock and see if
-					 * the caller tries again.
-					 */
-					ret = -EAGAIN;
-				} else {
-					/* fall back to buffered write */
-					ret = -ENOTBLK;
+		if (!(dio_flags & IOMAP_DIO_BUF_WRITETHROUGH)) {
+			ret = kiocb_invalidate_pages(iocb, iomi.len);
+			if (ret) {
+				if (ret != -EAGAIN) {
+					trace_iomap_dio_invalidate_fail(inode, iomi.pos,
+									iomi.len);
+					if (iocb->ki_flags & IOCB_ATOMIC) {
+						/*
+						* folio invalidation failed, maybe
+						* this is transient, unlock and see if
+						* the caller tries again.
+						*/
+						ret = -EAGAIN;
+					} else {
+						/* fall back to buffered write */
+						ret = -ENOTBLK;
+					}
 				}
+				goto out_free_dio;
 			}
-			goto out_free_dio;
-		}
+		} else
+			dio->flags |= IOMAP_DIO_NO_INVALIDATE;
 	}
 
 	if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25e..ca291957140e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -346,6 +346,7 @@ struct readahead_control;
 #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
 #define IOCB_DONTCACHE		(__force int) RWF_DONTCACHE
 #define IOCB_NOSIGNAL		(__force int) RWF_NOSIGNAL
+#define IOCB_WRITETHROUGH	(__force int) RWF_WRITETHROUGH
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -1985,6 +1986,8 @@ struct file_operations {
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
 /* File system supports uncached read/write buffered IO */
 #define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
+/* File system supports write through buffered IO */
+#define FOP_WRITETHROUGH	((__force fop_flags_t)(1 << 8))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
@@ -3436,6 +3439,10 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 		if (IS_DAX(ki->ki_filp->f_mapping->host))
 			return -EOPNOTSUPP;
 	}
+	if (flags & RWF_WRITETHROUGH)
+		/* file system must support it */
+		if (!(ki->ki_filp->f_op->fop_flags & FOP_WRITETHROUGH))
+			return -EOPNOTSUPP;
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 531f9ebdeeae..b96574bb2918 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -209,6 +209,7 @@ struct iomap_write_ops {
 #endif /* CONFIG_FS_DAX */
 #define IOMAP_ATOMIC		(1 << 9) /* torn-write protection */
 #define IOMAP_DONTCACHE		(1 << 10)
+#define IOMAP_WRITETHROUGH	(1 << 11)
 
 struct iomap_ops {
 	/*
@@ -475,6 +476,15 @@ struct iomap_writepage_ctx {
 	void			*wb_ctx;	/* pending writeback context */
 };
 
+struct iomap_writethrough_ctx {
+	struct kiocb iocb;
+	struct folio *folio;
+	struct inode *inode;
+	struct bio_vec *bvec;
+	loff_t orig_pos;
+	loff_t orig_len;
+};
+
 struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
 		loff_t file_offset, u16 ioend_flags);
 struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
@@ -590,6 +600,14 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_BOUNCE		(1 << 4)
 
+/*
+ * Set when we are using the dio path to perform writethrough for
+ * RWF_WRITETHROUGH buffered write. The ->endio handler must check this
+ * to perform any writethrough related cleanup like ending writeback on
+ * a folio.
+ */
+#define IOMAP_DIO_BUF_WRITETHROUGH	(1 << 5)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
@@ -599,6 +617,20 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 void iomap_dio_bio_end_io(struct bio *bio);
 
+/*
+ * In writethrough, we copy user data to folio first and then send the folio
+ * to writeback via dio path. To achieve this, we need callbacks from iomap_ops,
+ * iomap_write_ops and iomap_dio_ops. This struct packs them together.
+ */
+struct iomap_writethrough_ops {
+	const struct iomap_ops *ops;
+	const struct iomap_write_ops *write_ops;
+	const struct iomap_dio_ops *dio_ops;
+};
+ssize_t iomap_file_writethrough_write(struct kiocb *iocb, struct iov_iter *i,
+				      const struct iomap_writethrough_ops *wt_ops,
+				      void *private);
+
 #ifdef CONFIG_SWAP
 struct file;
 struct swap_info_struct;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 70b2b661f42c..dec78041b0cf 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -435,10 +435,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* prevent pipe and socket writes from raising SIGPIPE */
 #define RWF_NOSIGNAL	((__force __kernel_rwf_t)0x00000100)
 
+/* buffered IO that is asynchronously written through to disk after write */
+#define RWF_WRITETHROUGH	((__force __kernel_rwf_t)0x00000200)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
-			 RWF_DONTCACHE | RWF_NOSIGNAL)
+			 RWF_DONTCACHE | RWF_NOSIGNAL | RWF_WRITETHROUGH)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
-- 
2.52.0


