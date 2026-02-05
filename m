Return-Path: <linux-fsdevel+bounces-76484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHbfNO/9hGl47QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 21:30:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E0F7280
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 21:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A3C301E3E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FD02F0C7E;
	Thu,  5 Feb 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KttzHsKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F7191;
	Thu,  5 Feb 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323431; cv=none; b=YcU4xOghSwaojNZWYZd/87DEwHmIUK9yjYzkP39uvASulqXEGft5Ltdzh1fyz76Ggl1MGTY60z/4L8omVMlrogJsmW6hZl4izwpOiKdT+r0bmeCk+NTRP1Ugo2Wxuz0oUEHCcfIrRqqJWU1m0IMNb7U5WuLk4W4SAj79eMY601g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323431; c=relaxed/simple;
	bh=1lwDDZ0u2KPLYYsOR9Db1J3qEtOzpTF63nQzI6NUvt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/t4fyeOPDKjvEZb0gxUTDD50UaqT629uqQbgjFS7c85bHyeX98HRFRheUR5jORgylLYkThbAJcUQ8pr3Wdh9FpMiSqRqDHGdApdB7y6awGGekxwR8krEB9DbDENOWCcOPoRpT7SFBZMrOZpFVjYzxQuCD/1C73xjHzAQNotsWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KttzHsKb; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615FtvZQ482317;
	Thu, 5 Feb 2026 20:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=jPHVDUK7iFLx/1ctCKYeDGprQ2PFS
	XtHNmQKKEFTXjA=; b=KttzHsKbIp7Q6Y276zwXYF5LcDVuRbKD5MgttQQ+XAv6M
	7ZPyVA+y7SqaTtSXxkdZcswCVkm/oel53gl92wCJK8xVjOo2FYukB8irpfCYUDBK
	nhe/fnPigrvbHF3DHmXLeTE/cQ/5ZE3/fxUF2yNCZQ1CzrtJywn6r/x0XEWBqZIh
	OFBd1Wkq30dCyPCb0R0uxv1bj4WTHWZKdgepL73vf0pYCkWcsOGNfwFO9+GZ7KPr
	erG166SqdLC9q3iu7bIsFnqUz4Dtq4MTr4htv7ZvwlVnoTzKnaIMH3ebcf31fUk/
	V+HBPwzFGIin+6mRNvNWOg4dlnH93ZTEQnsC/H5Bg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb4f0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 20:29:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615KQZ6e017284;
	Thu, 5 Feb 2026 20:29:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186r8u39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 20:29:33 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615KTX3c025992;
	Thu, 5 Feb 2026 20:29:33 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186r8u27-1;
	Thu, 05 Feb 2026 20:29:33 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/1] NFSD: Enforce timeout on layout recall and integrate lease manager fencing
Date: Thu,  5 Feb 2026 12:29:21 -0800
Message-ID: <20260205202929.879846-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE1NSBTYWx0ZWRfXwfOlx919M2Ti
 dV15c+GfstD3Xz29ZWM3zzxPjeimyzkp9yMZCM8+5E8Nq2AowYwJFgSPWB07w6m4Ov6fPddyvJz
 XkZrYOBqrX4YlABf+RbxWbJvBhaFc+R59e13fhO9yoDa5xnOiEnMpZRIfS9IDesI4NU+x0K6GOb
 /6DGI+qYIn24TFBTM1pAlAX7Skggmn2zFsYUC7IJ7V/bwsJmPe9W1F8j6Xo7gEHP1xvVK5MhpBf
 xCzb09DStcnjIRusFiisX+BsB4pZVod9pOgsgI8yWFdgYByd3skUcWbosvWVkJ0UATv8OzyKXMi
 wdGs6KPbLplZV8Hs0Rp0VpEgqg/YL4yt+0BJPl1M3HhrJWvClxUWOc6sf8HWcrmvPcnF8NftSRi
 ErHQ+00sGyUOeiyWMpTqF69XBf+JkzHt3PLJNLiIl4AfczXc6VGs2ALZ38teNWUANbFWxNh0Z2j
 UCMIctKYy6UYWlraivybdLsl+1JHpb0rnUVCW6/o=
X-Proofpoint-ORIG-GUID: 1Q2YhO43r0JI4yKxm-xO2HzHBSUe-Apm
X-Proofpoint-GUID: 1Q2YhO43r0JI4yKxm-xO2HzHBSUe-Apm
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=6984fdb0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=mRSHgJJP_-3tRj_g7iAA:9 cc=ntf awl=host:12104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76484-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 398E0F7280
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
 Documentation/filesystems/locking.rst |   2 +
 fs/locks.c                            |  15 +++-
 fs/nfsd/blocklayout.c                 |  41 ++++++++--
 fs/nfsd/nfs4layouts.c                 | 113 +++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c                   |   1 +
 fs/nfsd/pnfs.h                        |   2 +-
 fs/nfsd/state.h                       |   8 ++
 include/linux/filelock.h              |   1 +
 8 files changed, 169 insertions(+), 14 deletions(-)

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
v4:
    . only increment ls_fence_retry_cnt after successfully
      schedule new work in nfsd4_layout_lm_breaker_timedout.
v5:
    . take reference count on layout stateid before starting
      fence worker.
    . restore comments in nfsd4_scsi_fence_client and the
      code that check for specific errors.
    . cancel fence worker before freeing layout stateid.
    . increase fence retry from 5 to 20.

NOTE:
    I experimented with having the fence worker handle lease
    disposal after fencing the client. However, this requires
    the lease code to export the lease_dispose_list function,
    and for the fence worker to acquire the flc_lock in order
    to perform the disposal. This approach adds unnecessary
    complexity and reduces code clarity, as it exposes internal
    lease code details to the nfsd worker, which should not
    be the case.

    Instead, the lm_breaker_timedout operation should simply
    notify the lease code about how to handle a lease that
    times out during a lease break, rather than directly
    manipulating the lease list.

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 04c7691e50e0..79bee9ae8bc3 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -403,6 +403,7 @@ prototypes::
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
         bool (*lm_lock_expirable)(struct file_lock *);
         void (*lm_expire_lock)(void);
+        bool (*lm_breaker_timedout)(struct file_lease *);
 
 locking rules:
 
@@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
 lm_lock_expirable	yes		no			no
 lm_expire_lock		no		no			yes
 lm_open_conflict	yes		no			no
+lm_breaker_timedout     yes             no                      no
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index 46f229f740c8..0e77423cf000 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
 	struct file_lease *fl, *tmp;
+	bool remove = true;
 
 	lockdep_assert_held(&ctx->flc_lock);
 
@@ -1531,8 +1532,18 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 		trace_time_out_leases(inode, fl);
 		if (past_time(fl->fl_downgrade_time))
 			lease_modify(fl, F_RDLCK, dispose);
-		if (past_time(fl->fl_break_time))
-			lease_modify(fl, F_UNLCK, dispose);
+
+		if (past_time(fl->fl_break_time)) {
+			/*
+			 * Consult the lease manager when a lease break times
+			 * out to determine whether the lease should be disposed
+			 * of.
+			 */
+			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
+				remove = fl->fl_lmops->lm_breaker_timedout(fl);
+			if (remove)
+				lease_modify(fl, F_UNLCK, dispose);
+		}
 	}
 }
 
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 7ba9e2dd0875..b7030c91964c 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -443,15 +443,33 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
 	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
 }
 
-static void
+/*
+ * Perform the fence operation to prevent the client from accessing the
+ * block device. If a fence operation is already in progress, wait for
+ * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
+ * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
+ * update the layout stateid by setting the ls_fenced flag to indicate
+ * that the client has been fenced.
+ *
+ * The cl_fence_mutex ensures that the fence operation has been fully
+ * completed, rather than just in progress, when returning from this
+ * function.
+ *
+ * Return true if client was fenced otherwise return false.
+ */
+static bool
 nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 	int status;
+	bool ret;
 
-	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
-		return;
+	mutex_lock(&clp->cl_fence_mutex);
+	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
+		mutex_unlock(&clp->cl_fence_mutex);
+		return true;
+	}
 
 	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp),
@@ -470,13 +488,22 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
 	 * retry loop.
 	 */
-	if (status < 0 ||
-	    status == PR_STS_PATH_FAILED ||
-	    status == PR_STS_PATH_FAST_FAILED ||
-	    status == PR_STS_RETRY_PATH_FAILURE)
+	switch (status) {
+	case 0:
+	case PR_STS_IOERR:
+	case PR_STS_RESERVATION_CONFLICT:
+		ret = true;
+		break;
+	default:
+		/* retry-able and other errors */
+		ret = false;
 		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
+		break;
+	}
+	mutex_unlock(&clp->cl_fence_mutex);
 
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
+	return ret;
 }
 
 const struct nfsd4_layout_ops scsi_layout_ops = {
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index ad7af8cfcf1f..e8589c20f95c 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -177,6 +177,13 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 
 	trace_nfsd_layoutstate_free(&ls->ls_stid.sc_stateid);
 
+	spin_lock(&ls->ls_lock);
+	if (ls->ls_fence_in_progress) {
+		spin_unlock(&ls->ls_lock);
+		cancel_delayed_work_sync(&ls->ls_fence_work);
+	} else
+		spin_unlock(&ls->ls_lock);
+
 	spin_lock(&clp->cl_lock);
 	list_del_init(&ls->ls_perclnt);
 	spin_unlock(&clp->cl_lock);
@@ -271,6 +278,9 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	list_add(&ls->ls_perfile, &fp->fi_lo_states);
 	spin_unlock(&fp->fi_lock);
 
+	ls->ls_fence_in_progress = false;
+	ls->ls_fenced = false;
+	ls->ls_fence_retries = 0;
 	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
 	return ls;
 }
@@ -747,11 +757,9 @@ static bool
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
@@ -782,10 +790,107 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
 	return 0;
 }
 
+static void
+nfsd4_layout_fence_worker(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct nfs4_layout_stateid *ls = container_of(dwork,
+			struct nfs4_layout_stateid, ls_fence_work);
+	struct nfsd_file *nf;
+	LIST_HEAD(dispose);
+
+	spin_lock(&ls->ls_lock);
+	if (list_empty(&ls->ls_layouts)) {
+		spin_unlock(&ls->ls_lock);
+dispose:
+		ls->ls_fenced = true;
+		ls->ls_fence_in_progress = false;
+		nfs4_put_stid(&ls->ls_stid);
+		return;
+	}
+	spin_unlock(&ls->ls_lock);
+
+	rcu_read_lock();
+	nf = nfsd_file_get(ls->ls_file);
+	rcu_read_unlock();
+	if (!nf)
+		goto dispose;
+
+	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
+		/* fenced ok */
+		nfsd_file_put(nf);
+		goto dispose;
+	}
+	/* fence failed */
+	nfsd_file_put(nf);
+
+	/* should we retry forever? */
+	if (++ls->ls_fence_retries >= LO_MAX_FENCE_RETRY) {
+		pr_warn("%s: failed to FENCE client[%pISpc]\n", __func__,
+			(struct sockaddr *)&ls->ls_stid.sc_client);
+		goto dispose;
+	}
+	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 1);
+}
+
+/**
+ * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
+ *
+ * @fl: file to check
+ *
+ * If the layout type supports a fence operation, schedule a worker to
+ * fence the client from accessing the block device.
+ *
+ * This function runs under the protection of the spin_lock flc_lock.
+ * At this time, the file_lease associated with the layout stateid is
+ * on the flc_list. A reference count is incremented on the layout
+ * stateid to prevent it from being freed while the fence orker is
+ * executing. Once the fence worker finishes its operation, it releases
+ * this reference.
+ *
+ * The fence worker continues to run until either the client has been
+ * fenced or the layout becomes invalid. The layout can become invalid
+ * as a result of a LAYOUTRETURN or when the CB_LAYOUT recall callback
+ * has completed.
+ *
+ * Return true if the file_lease should be disposed of by the caller;
+ * otherwise, return false.
+ */
+static bool
+nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
+{
+	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
+
+	if ((!nfsd4_layout_ops[ls->ls_layout_type]->fence_client) ||
+			ls->ls_fenced)
+		return true;
+	if (ls->ls_fence_in_progress)
+		return false;
+
+	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
+
+	/*
+	 * Make sure layout has not been returned yet before
+	 * taking a reference count on the layout stateid.
+	 */
+	spin_lock(&ls->ls_lock);
+	if (list_empty(&ls->ls_layouts)) {
+		spin_unlock(&ls->ls_lock);
+		return true;
+	}
+	refcount_inc(&ls->ls_stid.sc_count);
+	ls->ls_fence_in_progress = true;
+	spin_unlock(&ls->ls_lock);
+
+	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
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
index 98da72fc6067..bad91d1bfef3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2387,6 +2387,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 #endif
 #ifdef CONFIG_NFSD_SCSILAYOUT
 	xa_init(&clp->cl_dev_fences);
+	mutex_init(&clp->cl_fence_mutex);
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index db9af780438b..3a2f9e240e85 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -38,7 +38,7 @@ struct nfsd4_layout_ops {
 			struct svc_rqst *rqstp,
 			struct nfsd4_layoutcommit *lcp);
 
-	void (*fence_client)(struct nfs4_layout_stateid *ls,
+	bool (*fence_client)(struct nfs4_layout_stateid *ls,
 			     struct nfsd_file *file);
 };
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 713f55ef6554..64f5c1d24d60 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -529,6 +529,7 @@ struct nfs4_client {
 	time64_t		cl_ra_time;
 #ifdef CONFIG_NFSD_SCSILAYOUT
 	struct xarray		cl_dev_fences;
+	struct mutex		cl_fence_mutex;
 #endif
 };
 
@@ -738,8 +739,15 @@ struct nfs4_layout_stateid {
 	stateid_t			ls_recall_sid;
 	bool				ls_recalled;
 	struct mutex			ls_mutex;
+
+	struct delayed_work		ls_fence_work;
+	int				ls_fence_retries;
+	bool				ls_fence_in_progress;
+	bool				ls_fenced;
 };
 
+#define	LO_MAX_FENCE_RETRY		20
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


