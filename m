Return-Path: <linux-fsdevel+bounces-75397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN+oFo+XdmnmSgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 23:22:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4082AD1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAB6E3001CD3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 22:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E930E0E4;
	Sun, 25 Jan 2026 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yl55GXEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC64126BF7;
	Sun, 25 Jan 2026 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379715; cv=none; b=NK9psiHsXxm70OAEsav/tndoAJyxoWxJojc6bQXmOQR3szdsnfW4Kw+yGPLAc9ePj9zQIyVNzIaXwtkwlLuNcHSTsfqyWPf0SeZ7M84/Mg8K6dNw703dA9o3U2xowMzp9aXk9PObYskh3OqBYpk2I9YTqur2OD9p7SXk5CcCIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379715; c=relaxed/simple;
	bh=qTKD/obKyJmuBJ1ljckJXEsKhZLW2V92qN2K8c+sqw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQ/1MUij+BE2MbQE0rejuMjdW/OURLrxiI+9Poon8eRAiFktKqdkGMGzRebhxHPZOgBZwIbajwY3MyUW3jiGY1hiBxhupA83cCfOKN6TMFLxHRMpZ8N/C35fQw9167tBTfjtcEUbl3iE1liI5GOHUakDpWoGt4nz+tS8Tl4cmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yl55GXEt; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PLsAfA143970;
	Sun, 25 Jan 2026 22:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=f60AmFUSyRP+wfDbv1Yl9hqiM8J1R
	tYQK8SpRkbfJ0g=; b=Yl55GXEtygXdp2RfNUgsXZAnMcgyHjp0Q8itEw16ILXSK
	0IPKVb1u1buT/FTeC5+GAeJKx0lI8v6JsHWma3vSGacftUY2XddbJzQjysR3RjpY
	EYUUpOzAKN/pALvrWoALT0nV1KrHnig5+8XB5H4b1bOkDHniMK8bkOx50WIaPwQw
	xI8udctndp0Jba+xwyyG5TMmi/lDXbFjodUO6fs3Sc7CJbHUztpmR9vKBM2zEpMK
	QaQzXbTKVxGZQs4UxqsD4c1rvHOQKlG2ripzzCV97MsWj0o75dbbkc37CpUfnfiG
	iuiYxkRFVgqqyH2ucBdAeghmnKyi2JGyClUIhiwzQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmv2s62c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Jan 2026 22:21:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60PIuuJ4036089;
	Sun, 25 Jan 2026 22:21:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhkmk2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Jan 2026 22:21:33 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60PMKq4l017946;
	Sun, 25 Jan 2026 22:21:33 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhkmk2p-1;
	Sun, 25 Jan 2026 22:21:33 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: Enforce Timeout on Layout Recall and Integrate Lease Manager Fencing
Date: Sun, 25 Jan 2026 14:21:17 -0800
Message-ID: <20260125222129.3855915-1-dai.ngo@oracle.com>
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
 definitions=2026-01-25_05,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601250188
X-Proofpoint-ORIG-GUID: h6bRGVYpjmimGPfP-82QkPJ0TwUVVar2
X-Proofpoint-GUID: h6bRGVYpjmimGPfP-82QkPJ0TwUVVar2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDE4OCBTYWx0ZWRfX3setnvUKSyf4
 kkfZ9Tte/GaHwKqgsKEPMh4Gddwa1M3b2I3odobkNHsbHR6Rai2/vYbW1wf8Xx3yj5w8g1eZJKE
 gJfbKkIe7Fg7mH3Bxn1/j80cD4t2zH0LDuYnpfynEkCOZZd521YWwEQpdu3gDPHNJGTONdKOQWD
 7modWE2chdRNf9mNWdJwknFAQguZU9DLT3g8S3JrHneH+XD0pyDwYIwxJpQnHi8gZApb9vMAQ29
 Zw0B8Xvs0DqX6Z9j5aKd5pvU+YiRwYBqr1V/Bi/OOHAtHjwMIFYLlg081CIwaQcLHQ3lGH5uqah
 6ixo0SWbFtGP+fgNAWE+CEIb7JxSLtqSy7adMJhfRITXBcngjeqBppncCryVfWeAHGa7sy4qM5Y
 w96WGQQ0Hy/maRmkxaftBL+lft2I9sQszUzcNBIlk9TZdyTcyURgT4k0gwQtOA2g4OTz2aoCpcs
 xS1miIqUsmlVIbNtMX72ByO6wMMRevxufUlrh/sA=
X-Authority-Analysis: v=2.4 cv=cPLtc1eN c=1 sm=1 tr=0 ts=6976976e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UtARU5AvJtErEQ0kr80A:9 cc=ntf awl=host:12104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75397-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 49C4082AD1
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

Fencing operation is done asynchronously using a system worker. This
is to allow lease_modify to trigger the fencing opeation when layout
recall timed out.

To ensure layout stateid remains valid while the fencing operation is
in progress, a reference count is added to layout stateid before
schedule the system worker to do the fencing operation. The reference
count is released after the fencing operation is complete. 

While the fencing operation is in progress, the conflicting file_lease
remains on the flc_list until fencing is complete. This guarantees
that no other clients can access the file, and the client with exclusive
access is properly blocked before disposal.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst |  2 +
 fs/locks.c                            | 29 ++++++++++-
 fs/nfsd/blocklayout.c                 | 19 ++++++-
 fs/nfsd/nfs4layouts.c                 | 74 ++++++++++++++++++++++++---
 fs/nfsd/nfs4state.c                   |  1 +
 fs/nfsd/state.h                       |  3 ++
 include/linux/filelock.h              |  2 +
 7 files changed, 122 insertions(+), 8 deletions(-)

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

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 04c7691e50e0..f7fe2c1ee32b 100644
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
+lm_breaker_timedout     no              no                      yes
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index 46f229f740c8..28e63aa87f74 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1487,6 +1487,25 @@ static void lease_clear_pending(struct file_lease *fl, int arg)
 	}
 }
 
+/*
+ * A layout lease is about to be disposed. If the disposal is
+ * due to a layout recall timeout, consult the lease manager
+ * to see whether the operation should continue.
+ *
+ * Return true if the lease should be disposed else return
+ * false.
+ */
+static bool lease_want_dispose(struct file_lease *fl)
+{
+	if (!(fl->c.flc_flags & FL_BREAKER_TIMEDOUT))
+		return true;
+
+	if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout &&
+		(!fl->fl_lmops->lm_breaker_timedout(fl)))
+		return false;
+	return true;
+}
+
 /* We already had a lease on this file; just change its type */
 int lease_modify(struct file_lease *fl, int arg, struct list_head *dispose)
 {
@@ -1494,6 +1513,11 @@ int lease_modify(struct file_lease *fl, int arg, struct list_head *dispose)
 
 	if (error)
 		return error;
+
+	if ((fl->c.flc_flags & FL_LAYOUT) && (arg == F_UNLCK) &&
+			(!lease_want_dispose(fl)))
+		return 0;
+
 	lease_clear_pending(fl, arg);
 	locks_wake_up_blocks(&fl->c);
 	if (arg == F_UNLCK) {
@@ -1531,8 +1555,11 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 		trace_time_out_leases(inode, fl);
 		if (past_time(fl->fl_downgrade_time))
 			lease_modify(fl, F_RDLCK, dispose);
-		if (past_time(fl->fl_break_time))
+
+		if (past_time(fl->fl_break_time)) {
+			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
 			lease_modify(fl, F_UNLCK, dispose);
+		}
 	}
 }
 
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 7ba9e2dd0875..05ddff5a4005 100644
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
@@ -450,8 +458,13 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
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
@@ -475,6 +488,10 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	    status == PR_STS_PATH_FAST_FAILED ||
 	    status == PR_STS_RETRY_PATH_FAILURE)
 		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
+	else
+		ls->ls_fenced = true;
+	mutex_unlock(&clp->cl_fence_mutex);
+	nfs4_put_stid(&ls->ls_stid);
 
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index ad7af8cfcf1f..4a11ccd5b0a5 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -222,6 +222,27 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
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
+	if (!nf)
+		return;
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
@@ -271,6 +292,9 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	list_add(&ls->ls_perfile, &fp->fi_lo_states);
 	spin_unlock(&fp->fi_lock);
 
+	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
+	ls->ls_fenced = false;
+
 	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
 	return ls;
 }
@@ -708,9 +732,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
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
@@ -747,11 +772,9 @@ static bool
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
@@ -782,10 +805,49 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
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
+	if (ls->ls_fenced)
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
index 713f55ef6554..d9a3c966a35f 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -529,6 +529,7 @@ struct nfs4_client {
 	time64_t		cl_ra_time;
 #ifdef CONFIG_NFSD_SCSILAYOUT
 	struct xarray		cl_dev_fences;
+	struct mutex		cl_fence_mutex;
 #endif
 };
 
@@ -738,6 +739,8 @@ struct nfs4_layout_stateid {
 	stateid_t			ls_recall_sid;
 	bool				ls_recalled;
 	struct mutex			ls_mutex;
+	struct delayed_work		ls_fence_work;
+	bool				ls_fenced;
 };
 
 static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 2f5e5588ee07..6939952f2088 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -17,6 +17,7 @@
 #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
 #define FL_LAYOUT	2048	/* outstanding pNFS layout */
 #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
+#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
@@ -50,6 +51,7 @@ struct lease_manager_operations {
 	void (*lm_setup)(struct file_lease *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lease *);
 	int (*lm_open_conflict)(struct file *, int);
+	bool (*lm_breaker_timedout)(struct file_lease *fl);
 };
 
 struct lock_manager {
-- 
2.47.3


