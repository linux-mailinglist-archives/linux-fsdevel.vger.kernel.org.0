Return-Path: <linux-fsdevel+bounces-75557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLtPEesLeGl3ngEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:50:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D608E8B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C57D2301CCD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3511F0991;
	Tue, 27 Jan 2026 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gij8zeRg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084D3B2BA;
	Tue, 27 Jan 2026 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475041; cv=none; b=pAfA/kInYHTAm6I7JnVrWDgV0kLZl+BQtwCJ/f6HZyTEERwqqzbCGKBqTOGTpt+cfKOQBz0s1F5BY0QMwHLc8hSUu9FeoPGJpK2VI4aGshB6zsuZR4TD20tkb9ZfVMToTnca6aYojDL+tDTXe1VSgW2eAPYmnDvGI3h7BE+i+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475041; c=relaxed/simple;
	bh=ysYWCDKOIHe/V3IqO027N2C/wWrUItyeT4kMAVb2PK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGA9EspTvqRuh8S5cZ9ikksJEW2i97numRRKzi/SjS7UHZfhAaMCCX9BlRbifqf+6xd8qB0M6rLUrDV+57NBt5arnZHSC04lo03LgoHXTQpe4Ak7jMs6/3R2aSOFZ6VPa2x74EnPBQaliVKMPKaG+YKwhEwHuztrqKK50Qrayoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gij8zeRg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QHHhGs843262;
	Tue, 27 Jan 2026 00:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=mCs1WJcJCXJxVhOKCJbRGGc5yVS2T
	1xguJRT884EAfc=; b=gij8zeRgHT2pfLS8wk1dWZmrqNFzWksvkLnnogDk6MYUI
	5ri+7KH6RO4csi6S9mLCvIydB9wqQZPJypKJalkAABrZ83/+DBV4HztHhKDaPg6q
	C29DHBLOM5utpRGrWd23b9at1NNHJv0+LnCSMJvlp52rI2NrGHwls7DXGfhPMqmu
	RTZqRYfd/G8VjhTK3w7VQSolBEyNbHTI/UEPjYxZhDBEKqXdjHJoJaZ8aEGih/z1
	mMtiz4CdDHTQ8p+c9KiYm5YKiNb/vNXQ/zuvXxwlhma2Foy60K/nV9DnyPeppNhV
	vr2yaywvugwKq3NfEaK+BFTJY7xWhmHm6lrTmL3Rw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvnpsb66v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 00:50:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QMZPXC033453;
	Tue, 27 Jan 2026 00:50:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh8phrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 00:50:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60R0oHZv006635;
	Tue, 27 Jan 2026 00:50:17 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmh8phr2-1;
	Tue, 27 Jan 2026 00:50:17 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/1] NFSD: Enforce Timeout on Layout Recall and Integrate Lease Manager Fencing
Date: Mon, 26 Jan 2026 16:50:06 -0800
Message-ID: <20260127005013.552805-1-dai.ngo@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270005
X-Authority-Analysis: v=2.4 cv=dY2NHHXe c=1 sm=1 tr=0 ts=69780bca b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wJgj6elaJi8SMsIUsgwA:9
X-Proofpoint-GUID: hC-cbpoiYRhmqznRWuMl2t4Lf4BW1mTT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAwNCBTYWx0ZWRfX9Z0vz3ksaHRW
 8MJXke7a+eMSlEmSrSfAsLhLFN+1jpta1KAlMyB5mBazhX0ctQOy6g983GubuEswSuNhtBqtGmk
 QvEjmrl/aIMu403xxG8HPEfatkzxAqGdXUnTB9N4xoBILEUB43U3AbO5Mbd0pwQyKHorqV5zqg4
 IVgPNypyU1byoYOBIkhmtJrYykjBwonYcDSapyeH3aNzv2lGFj9Cloo4KsIMoiQYtwH1wRvgL+Z
 PDqQrWC9jEVMRJ1Xgm8MlpTAiNY3KWtaaFcOud5YV8JJ06Kpa8YTUclh5EtG+67a0r3vjjDUf/W
 29l1SiUmuYf2SugzmuTJBfsrcXFu27Zark7BxEYqomcREWbsWXQsqiICaApxqJA1WEDtcykpgk1
 mOVzwlJtzes+gCg1yq/dWomyZil339+YqeTOmn8jcxsaZaBcUHzKjJbN6//oewbVCDAb53Anwsa
 7Hb11nkyX6qSO9Ourfg==
X-Proofpoint-ORIG-GUID: hC-cbpoiYRhmqznRWuMl2t4Lf4BW1mTT
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
	TAGGED_FROM(0.00)[bounces-75557-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 91D608E8B6
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
 fs/nfsd/nfs4layouts.c                 | 79 +++++++++++++++++++++++++--
 fs/nfsd/nfs4state.c                   |  1 +
 fs/nfsd/state.h                       |  6 ++
 include/linux/filelock.h              |  1 +
 7 files changed, 110 insertions(+), 27 deletions(-)

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
index ad7af8cfcf1f..1c498f3cd059 100644
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
@@ -782,10 +808,51 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
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
+	if (ls->ls_fenced || ls->ls_fence_retry_cnt >= LO_MAX_FENCE_RETRY)
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
+		++ls->ls_fence_retry_cnt;
+		return true;
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


