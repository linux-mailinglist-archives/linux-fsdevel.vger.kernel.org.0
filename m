Return-Path: <linux-fsdevel+bounces-75530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFLGG+fPd2mxlQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:34:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1861F8D1CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA223014962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64992D592F;
	Mon, 26 Jan 2026 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zakz0lOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A42C235E;
	Mon, 26 Jan 2026 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459679; cv=none; b=DiNrGGaNWeDG2GrrjcBrturcSSAEAILr3AzaR+SsEAGgSVCsMzDnV6+PUVn8tssL4/gMUc8fkyG6LqU/lBMoli456TMiAx1cLFSMRRZ79fV7NJ2vJrGorYQ0DD3MrYi5pgolCKU9xmt+q2tjeZF6ximwAA7WK7JmQdq42t6Yzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459679; c=relaxed/simple;
	bh=XYzOIVDK9Hiw5DX88kWqHzlXjQD2WkQE20awTDOh21U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gd3f1FC32yl0AeFaD/ewZRMxMFYta185A9wGs7RYISUhSSAd1xZQ+9nCGO2bIxzcCXuXkzK5qItgPP6a7prqhhoqQEypUKdQs8JPOiAGoX7pCWv+YYwqaIj3/3/453+Q8fAjSbBWFTBqUO3hk1kn6zDLazNbCPKGz+Np7bmzQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zakz0lOj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QHLufI488946;
	Mon, 26 Jan 2026 20:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ntcWA+URbyQjfO49tYLE3SCQUzTTE
	F7CFX++Ypb2btU=; b=Zakz0lOjF9y59qHnT2nnMH6WIfbOnETmJ394Hx6/jaAbu
	QlGcboE350gSz2fluguNMZFm/Fa3YEuYg0OSPK0ANsf7Aic2WIt/4ULlPGa16O18
	8dCXuEFK6kd13+x33EqBcdWRoV8nEelAYhsjonEy3yDgSikfgiJX3MQd8Ld57RzU
	8XB2NY00e8CH6ErdIKoS8LdSM5sm9UJGOvhol/h1hYcXnDUZmtkML92/iuzsmEx+
	BbT+h5DaFwiiX+NXntRsqckBk/PZUMu0rQDf81FUIqsjB6na4r3EEcMT/1jMw65X
	eBX2r1HNVbshOnhIkOyyaWO37rQMmAQuV/XPaR0Lw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvn09jv2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 20:34:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QK2spm012842;
	Mon, 26 Jan 2026 20:34:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh8fkgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 20:34:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60QKYLPg027246;
	Mon, 26 Jan 2026 20:34:21 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmh8fkfv-1;
	Mon, 26 Jan 2026 20:34:21 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] NFSD: Enforce Timeout on Layout Recall and Integrate Lease Manager Fencing
Date: Mon, 26 Jan 2026 12:34:08 -0800
Message-ID: <20260126203417.382373-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260176
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE3NSBTYWx0ZWRfX2Y9VvuiBG6KZ
 amKLqBI3LbVg9Ki/Vbuo+mg32i5Buk7/BjLR2T/f5bp/0FfrvnK1B7/CZbC1qhWjw+i0+B82QXH
 1v8sMBatqfMcxvjOyTJn+UfQNoJmMCBgUNAWgNjP3SQZlsfdI5wv9Skf+ROxe9RaZD/uioZORE4
 sCQ8ys52z63yum6iIm4NW9jimmtG4JKWc2G0xdAR68QJNBTw4o0t8vNypd+C63VTwIPC+ZEJsQv
 yuOjYG+4gxbPjIf8FGZja37fYHuF2pyRkcFKXPUirq6bnwTg301olxv6ubNEhqLECHxQEMFQTtB
 4M9XCoe38dO7M7OHcMZoTSZ8KneLgWSBXIFqu1Omj/LkbxgcmUPns80SJrrtcsJNnV8438mS4m6
 RzVnXkHCSXiL44YXf+QcP3vqYA4PMdFd/Y4TmVcvuCvNpEd/ZcYZn2OD+fF5pZjy5FEwhZoC1Ed
 fp4vtTO6nRx99WSHplw==
X-Proofpoint-ORIG-GUID: al4pbRzUwq6CENLN6MmmW3vD9KHTuWIj
X-Authority-Analysis: v=2.4 cv=Rp7I7SmK c=1 sm=1 tr=0 ts=6977cfce cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wJgj6elaJi8SMsIUsgwA:9
X-Proofpoint-GUID: al4pbRzUwq6CENLN6MmmW3vD9KHTuWIj
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75530-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1861F8D1CA
X-Rspamd-Action: no action

When a layout conflict triggers a recall, enforcing a timeout is
necessary to prevent excessive nfsd threads from being blocked in
__break_lease ensuring the server continues servicing incoming
requests efficiently.

This patch introduces a new function to lease_manager_operations:

lm_breaker_timedout: Invoked when a lease recall times out and is
about to be disposed of. This function enables the lease manager
to inform the caller whether the file_lease should remain on the
flc_list or be disposed of.

For the NFSD lease manager, this function now handles layout recall
timeouts. If the layout type supports fencing and the client has not
been fenced, a fence operation is triggered to prevent the client
from accessing the block device.

While the fencing operation is in progress, the conflicting file_lease
remains on the flc_list until fencing is complete. This guarantees
that no other clients can access the file, and the client with
exclusive access is properly blocked before disposal.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst |  2 +
 fs/locks.c                            | 10 +++-
 fs/nfsd/blocklayout.c                 | 38 ++++++-------
 fs/nfsd/nfs4layouts.c                 | 77 ++++++++++++++++++++++++---
 fs/nfsd/nfs4state.c                   |  1 +
 fs/nfsd/state.h                       |  6 +++
 include/linux/filelock.h              |  1 +
 7 files changed, 108 insertions(+), 27 deletions(-)

v2:
    . Update Subject line to include fencing operation.
    . Allow conflicting lease to remain on flc_list until fencing
      is complete.
    . Use system worker to perform fencing operation asynchronously.
    . Use nfs4_stid.sc_count to ensure layout stateid remains
      valid before starting the fencing operation, nfs4_stid.sc_count
      is released after fencing operation is complete.
    . Rework nfsd4_scsi_fence_client to:
         . wait until fencing to complete before exiting.
         . wait until fencing in progress to complete before
           checking the NFSD_MDS_PR_FENCED flag.
    . Remove lm_need_to_retry from lease_manager_operations.
v3:
    . correct locking requirement in locking.rst.
    . add max retry count to fencing operation.
    . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
    . remove special-casing of FL_LAYOUT in lease_modify.
    . remove lease_want_dispose.
    . move lm_breaker_timedout call to time_out_leases.

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 04c7691e50e0..a339491f02e4 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -403,6 +403,7 @@ prototypes::
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
         bool (*lm_lock_expirable)(struct file_lock *);
         void (*lm_expire_lock)(void);
+        void (*lm_breaker_timedout)(struct file_lease *);
 
 locking rules:
 
@@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
 lm_lock_expirable	yes		no			no
 lm_expire_lock		no		no			yes
 lm_open_conflict	yes		no			no
+lm_breaker_timedout     yes             no                      no
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index 46f229f740c8..1b63aa704598 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
 	struct file_lease *fl, *tmp;
+	bool remove = true;
 
 	lockdep_assert_held(&ctx->flc_lock);
 
@@ -1531,8 +1532,13 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 		trace_time_out_leases(inode, fl);
 		if (past_time(fl->fl_downgrade_time))
 			lease_modify(fl, F_RDLCK, dispose);
-		if (past_time(fl->fl_break_time))
-			lease_modify(fl, F_UNLCK, dispose);
+
+		if (past_time(fl->fl_break_time)) {
+			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
+				remove = fl->fl_lmops->lm_breaker_timedout(fl);
+			if (remove)
+				lease_modify(fl, F_UNLCK, dispose);
+		}
 	}
 }
 
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 7ba9e2dd0875..69d3889df302 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
 	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
 }
 
+/*
+ * Perform the fence operation to prevent the client from accessing the
+ * block device. If a fence operation is already in progress, wait for
+ * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
+ * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
+ * update the layout stateid by setting the ls_fenced flag to indicate
+ * that the client has been fenced.
+ */
 static void
 nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
@@ -450,31 +458,23 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 	int status;
 
-	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
+	mutex_lock(&clp->cl_fence_mutex);
+	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
+		ls->ls_fenced = true;
+		mutex_unlock(&clp->cl_fence_mutex);
+		nfs4_put_stid(&ls->ls_stid);
 		return;
+	}
 
 	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp),
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
-	/*
-	 * Reset to allow retry only when the command could not have
-	 * reached the device. Negative status means a local error
-	 * (e.g., -ENOMEM) prevented the command from being sent.
-	 * PR_STS_PATH_FAILED, PR_STS_PATH_FAST_FAILED, and
-	 * PR_STS_RETRY_PATH_FAILURE indicate transport path failures
-	 * before device delivery.
-	 *
-	 * For all other errors, the command may have reached the device
-	 * and the preempt may have succeeded. Avoid resetting, since
-	 * retrying a successful preempt returns PR_STS_IOERR or
-	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
-	 * retry loop.
-	 */
-	if (status < 0 ||
-	    status == PR_STS_PATH_FAILED ||
-	    status == PR_STS_PATH_FAST_FAILED ||
-	    status == PR_STS_RETRY_PATH_FAILURE)
+	if (status)
 		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
+	else
+		ls->ls_fenced = true;
+	mutex_unlock(&clp->cl_fence_mutex);
+	nfs4_put_stid(&ls->ls_stid);
 
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index ad7af8cfcf1f..1e0d023ed015 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -222,6 +222,29 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 	return 0;
 }
 
+static void
+nfsd4_layout_fence_worker(struct work_struct *work)
+{
+	struct nfsd_file *nf;
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct nfs4_layout_stateid *ls = container_of(dwork,
+			struct nfs4_layout_stateid, ls_fence_work);
+	u32 type;
+
+	rcu_read_lock();
+	nf = nfsd_file_get(ls->ls_file);
+	rcu_read_unlock();
+	if (!nf) {
+		nfs4_put_stid(&ls->ls_stid);
+		return;
+	}
+
+	type = ls->ls_layout_type;
+	if (nfsd4_layout_ops[type]->fence_client)
+		nfsd4_layout_ops[type]->fence_client(ls, nf);
+	nfsd_file_put(nf);
+}
+
 static struct nfs4_layout_stateid *
 nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 		struct nfs4_stid *parent, u32 layout_type)
@@ -271,6 +294,10 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	list_add(&ls->ls_perfile, &fp->fi_lo_states);
 	spin_unlock(&fp->fi_lock);
 
+	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
+	ls->ls_fenced = false;
+	ls->ls_fence_retry_cnt = 0;
+
 	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
 	return ls;
 }
@@ -708,9 +735,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 		rcu_read_unlock();
 		if (fl) {
 			ops = nfsd4_layout_ops[ls->ls_layout_type];
-			if (ops->fence_client)
+			if (ops->fence_client) {
+				refcount_inc(&ls->ls_stid.sc_count);
 				ops->fence_client(ls, fl);
-			else
+			} else
 				nfsd4_cb_layout_fail(ls, fl);
 			nfsd_file_put(fl);
 		}
@@ -747,11 +775,9 @@ static bool
 nfsd4_layout_lm_break(struct file_lease *fl)
 {
 	/*
-	 * We don't want the locks code to timeout the lease for us;
-	 * we'll remove it ourself if a layout isn't returned
-	 * in time:
+	 * Enforce break lease timeout to prevent NFSD
+	 * thread from hanging in __break_lease.
 	 */
-	fl->fl_break_time = 0;
 	nfsd4_recall_file_layout(fl->c.flc_owner);
 	return false;
 }
@@ -782,10 +808,49 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
 	return 0;
 }
 
+/**
+ * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
+ * If the layout type supports a fence operation, schedule a worker to
+ * fence the client from accessing the block device.
+ *
+ * @fl: file to check
+ *
+ * Return true if the file lease should be disposed of by the caller;
+ * otherwise, return false.
+ */
+static bool
+nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
+{
+	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
+	bool ret;
+
+	if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
+		return true;
+	if (ls->ls_fenced || (++ls->ls_fence_retry_cnt > LO_MAX_FENCE_RETRY))
+		return true;
+
+	if (work_busy(&ls->ls_fence_work.work))
+		return false;
+	/* Schedule work to do the fence operation */
+	ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
+	if (!ret) {
+		/*
+		 * If there is no pending work, mod_delayed_work queues
+		 * new task. While fencing is in progress, a reference
+		 * count is added to the layout stateid to ensure its
+		 * validity. This reference count is released once fencing
+		 * has been completed.
+		 */
+		refcount_inc(&ls->ls_stid.sc_count);
+	}
+	return false;
+}
+
 static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
 	.lm_break		= nfsd4_layout_lm_break,
 	.lm_change		= nfsd4_layout_lm_change,
 	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
+	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
 };
 
 int
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 583c13b5aaf3..a57fa3318362 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 #endif
 #ifdef CONFIG_NFSD_SCSILAYOUT
 	xa_init(&clp->cl_dev_fences);
+	mutex_init(&clp->cl_fence_mutex);
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 713f55ef6554..57e54dfb406c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -529,6 +529,7 @@ struct nfs4_client {
 	time64_t		cl_ra_time;
 #ifdef CONFIG_NFSD_SCSILAYOUT
 	struct xarray		cl_dev_fences;
+	struct mutex		cl_fence_mutex;
 #endif
 };
 
@@ -738,8 +739,13 @@ struct nfs4_layout_stateid {
 	stateid_t			ls_recall_sid;
 	bool				ls_recalled;
 	struct mutex			ls_mutex;
+	struct delayed_work		ls_fence_work;
+	bool				ls_fenced;
+	int				ls_fence_retry_cnt;
 };
 
+#define	LO_MAX_FENCE_RETRY		5
+
 static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
 {
 	return container_of(s, struct nfs4_layout_stateid, ls_stid);
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 2f5e5588ee07..13b9c9f04589 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -50,6 +50,7 @@ struct lease_manager_operations {
 	void (*lm_setup)(struct file_lease *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lease *);
 	int (*lm_open_conflict)(struct file *, int);
+	bool (*lm_breaker_timedout)(struct file_lease *fl);
 };
 
 struct lock_manager {
-- 
2.47.3


