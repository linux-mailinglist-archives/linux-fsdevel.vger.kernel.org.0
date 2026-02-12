Return-Path: <linux-fsdevel+bounces-77060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDO2CyRTjmmlBgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:24:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 948B4131829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46DAB304B748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C9F2E8B82;
	Thu, 12 Feb 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FhynO2Ll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8227703C;
	Thu, 12 Feb 2026 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935067; cv=none; b=Z+7MsPxS50tytsSvQY2x0hZ5lFTwOUiL1mnfyuYeB4FonmgyHbg3KXSiqz4pqMXZBsmSh6qB8kaibdK8VCyW2rxB6VswXmT2bV1xmIuh+rVRRBUZV9grPdNnF7ONjSBoJKjQucjS3YU/N8cLx5QbqU8ZW51arNqUYPvOmRRkb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935067; c=relaxed/simple;
	bh=syv189DGllnksMTI9QzasKLhVkyJzoTICaAO9NPyLsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUpDPW+CVE6LOLPI9UmPIlu4RqUgdDTnjYJXwdUXb0bwx4upq2fwJyhTITF62IOnEEGwcQkCHNaTOTVI9NsveaLWVdlzaupBgStK69UlgrVxoiqZowlKwp7LZlJr7J9M2rPoDqbAh6zkir2jplz5QWEsCLudwDESOJ2g/H6GefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FhynO2Ll; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CGNFjj964591;
	Thu, 12 Feb 2026 22:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7VajcZTUilVaRm9Sj/s5ckmdSovOu
	TeVRNt2ODnhXjw=; b=FhynO2Ll0Vnbc5rqjquEQnj+ymlh8cimBUQoMEgAS+TQx
	MqPv7X8AVIHUP0uvb+M+UyK93idWU5qedHTrc9WCeWs66/UZnYbC50U2aC9lnQL2
	Y6cCI9zajd+FhUg6oR7VpqfbiSxvlBnkZxEIOOwm0Ll2scSi7YySfi2XU8ARXY+d
	b3EMUg53KytJX2uGZ5yy/7wbLUB4yDBKJG0Rp7AV1MklVmGg872hgm7F3/T3fJ1Q
	lzV1ggAHATFHGsKUh1deS1dA03LtqeYYbnUYceNLZKp4ZNbHi5JG4xeVmvRkx7j4
	RoDR3B4k+lLNLyadUz3oLaViR7G1hQZrw2lPayn1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c7rxu5qcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 22:24:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61CKAW7t033605;
	Thu, 12 Feb 2026 22:24:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c824897f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 22:24:06 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61CMO5ju011822;
	Thu, 12 Feb 2026 22:24:05 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c824897ep-1;
	Thu, 12 Feb 2026 22:24:05 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v11 1/1] NFSD: Enforce timeout on layout recall and integrate lease manager fencing
Date: Thu, 12 Feb 2026 14:23:43 -0800
Message-ID: <20260212222403.3305141-1-dai.ngo@oracle.com>
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
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602120173
X-Proofpoint-GUID: 4WaaDaBNnYyT9-22gu6Rn1GQFdh-Rfc8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE3NCBTYWx0ZWRfX8L/DbJT1Ue3T
 pGjNG/GviqPSWk1dByoX67tpE3ybeDY3IDAnuGl2PO34nRNVXjStn9+KvmMvJBfXUAInLQNhCjJ
 Eqr/SC2mBBA/s3Yefl1NZSeCQZXmr6+7oLmZwKCF5cRIwDMpPcDVwOjj7gyc8oP5oOsibU57N2S
 rZYXTxtEZhyHzM22wsF1Xi544KgoNb0lgIvNApGyKrTr1YuUmYSazohh4ux2I/TFei7ovEtolFA
 EsejYqfb75TTTNqlW9PFISTrsC+l+g1cSV7dakAhKbhosu/h19ITFEfcY9px7sGj36204dXnKfb
 uj9rgUGpaVcTnQfxAU6vLSeHYLqd4kH0LOQK8I844GtKQyusNuI+63EDnw0i8HMD6Wk1g3HWvJr
 UYI1Hy1rvmcJZbUOfrvmME6TVWQTXmP/oEfPYH1iBD7r1ytAXI89pbsKCkJ5Jnawbkic+IGqeLm
 lWKV+KmjuE5bCuKlrZA==
X-Proofpoint-ORIG-GUID: 4WaaDaBNnYyT9-22gu6Rn1GQFdh-Rfc8
X-Authority-Analysis: v=2.4 cv=Y6f1cxeN c=1 sm=1 tr=0 ts=698e5307 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=qEu-IRwdT1xVvaKju64A:9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	TAGGED_FROM(0.00)[bounces-77060-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 948B4131829
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
 .../admin-guide/nfs/pnfs-block-server.rst     |  29 ++++
 .../admin-guide/nfs/pnfs-scsi-server.rst      |  30 ++++
 Documentation/filesystems/locking.rst         |   2 +
 fs/locks.c                                    |  24 ++-
 fs/nfsd/blocklayout.c                         |  42 +++++-
 fs/nfsd/nfs4layouts.c                         | 139 +++++++++++++++++-
 fs/nfsd/nfs4state.c                           |   2 +
 fs/nfsd/pnfs.h                                |   2 +-
 fs/nfsd/state.h                               |   9 ++
 include/linux/filelock.h                      |   1 +
 10 files changed, 264 insertions(+), 16 deletions(-)


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
v6:
   . unlock the lease as soon as the fencing is done, so that
     tasks waiting on it can proceed.

v7:
   . Change to retry fencing on error forever by default.
   . add module parameter option to allow the admim to specify
     the maximun number of retries before giving up.

v8:
   . reinitialize 'remove' inside the loop.
   . remove knob to stop fence worker from retrying forever.
   . use exponential back off when retrying fence operation.
   . Fix nits.

v9:
   . limit fence worker max delay to 3 minutes.
   . fix fence worker's delay argument from seconds to jiffies.
   . move INIT_DELAYED_WORK to nfsd4_alloc_layout_stateid().
   . remove ls_fence_inprogress, use delayed_work_pending() instead.

v10:
   . fix initial delay of fence worker from 1 jiffies to 1 second.

v11:
   . add recover procedure in pnfs-block-server.rst and
     nfs-scsi-server.rst.
   . include unique client identifier in fence log message.
   . limit logging of message when fencing fail to once.
   . add logging of successful fencing operation.
   . handle expired of fl_break_time when retry in__break_time.
   . removed unused 'dispose' list in nfsd4_layout_fence_worker.
   . simplify compute for ls_fence_delay in nfsd4_layout_fence_worker.
   . add description for MAX_FENCE_DELAY.

diff --git a/Documentation/admin-guide/nfs/pnfs-block-server.rst b/Documentation/admin-guide/nfs/pnfs-block-server.rst
index 20fe9f5117fe..bc8d4ce10c10 100644
--- a/Documentation/admin-guide/nfs/pnfs-block-server.rst
+++ b/Documentation/admin-guide/nfs/pnfs-block-server.rst
@@ -40,3 +40,32 @@ how to translate the device into a serial number from SCSI EVPD 0x80::
 
 	echo "fencing client ${CLIENT} serial ${EVPD}" >> /var/log/pnfsd-fence.log
 	EOF
+
+If the nfsd server needs to fence a non-responding client and the
+fencing operation fails, the server logs a warning message in the
+system log with the following format:
+
+    FENCE failed client[IP_address] clid[#n] device[dev_t]
+
+    Where:
+
+    IP_address: refers to the IP address of the affected client.
+    clid[#n]: indicates the unique client identifier.
+    device[dev_t]: specifies the device related to the fencing attempt.
+
+The server will repeatedly retry the operation indefinitely. During
+this time, access to the affected file is restricted for all other
+clients. This is to prevent potential data corruption if multiple
+clients access the same file simultaneously.
+
+To restore access to the affected file for other clients, the admin
+needs to take the following actions:
+
+    . shutdown or power off the client being fenced.
+    . manually expire the client to release all its state on the server:
+
+      echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
+
+      Where:
+
+      clid: is the unique client identifier displayed in the system log.
diff --git a/Documentation/admin-guide/nfs/pnfs-scsi-server.rst b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
index b2eec2288329..b691a03e3d33 100644
--- a/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
+++ b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
@@ -22,3 +22,33 @@ option and the underlying SCSI device support persistent reservations.
 On the client make sure the kernel has the CONFIG_PNFS_BLOCK option
 enabled, and the file system is mounted using the NFSv4.1 protocol
 version (mount -o vers=4.1).
+
+If the nfsd server needs to fence a non-responding client and the
+fencing operation fails, the server logs a warning message in the
+system log with the following format:
+
+    FENCE failed client[IP_address] clid[#n] device[dev_t]
+
+    Where:
+
+    IP_address: refers to the IP address of the affected client.
+    clid[#n]: indicates the unique client identifier.
+    device[dev_t]: specifies the device related to the fencing attempt.
+
+The server will repeatedly retry the operation indefinitely. During
+this time, access to the affected file is restricted for all other
+clients. This is to prevent potential data corruption if multiple
+clients access the same file simultaneously.
+
+To restore access to the affected file for other clients, the admin
+needs to take the following actions:
+
+    . shutdown or power off the client being fenced.
+    . manually expire the client to release all its state on the server:
+
+      echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
+
+      Where:
+
+      clid: is the unique client identifier displayed in the system log.
+
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
index 46f229f740c8..42ae59eda068 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
 	struct file_lease *fl, *tmp;
+	bool remove;
 
 	lockdep_assert_held(&ctx->flc_lock);
 
@@ -1531,8 +1532,19 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 		trace_time_out_leases(inode, fl);
 		if (past_time(fl->fl_downgrade_time))
 			lease_modify(fl, F_RDLCK, dispose);
-		if (past_time(fl->fl_break_time))
-			lease_modify(fl, F_UNLCK, dispose);
+
+		remove = true;
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
 
@@ -1660,8 +1672,12 @@ int __break_lease(struct inode *inode, unsigned int flags)
 restart:
 	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
 	break_time = fl->fl_break_time;
-	if (break_time != 0)
-		break_time -= jiffies;
+	if (break_time != 0) {
+		if (time_after(jiffies, break_time))
+			break_time = jiffies + lease_break_time * HZ;
+		else
+			break_time -= jiffies;
+	}
 	if (break_time == 0)
 		break_time++;
 	locks_insert_block(&fl->c, &new_fl->c, leases_conflict);
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 7ba9e2dd0875..5c52a90a0c7f 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -297,6 +297,7 @@ static inline int nfsd4_scsi_fence_insert(struct nfs4_client *clp,
 		ret = 0;
 	}
 	xa_unlock(xa);
+	clp->cl_fence_retry_warn = false;
 	return ret;
 }
 
@@ -443,15 +444,33 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
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
@@ -470,13 +489,22 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
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
index ad7af8cfcf1f..e21baa3cb42b 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -27,6 +27,8 @@ static struct kmem_cache *nfs4_layout_stateid_cache;
 static const struct nfsd4_callback_ops nfsd4_cb_layout_ops;
 static const struct lease_manager_operations nfsd4_layouts_lm_ops;
 
+static void nfsd4_layout_fence_worker(struct work_struct *work);
+
 const struct nfsd4_layout_ops *nfsd4_layout_ops[LAYOUT_TYPE_MAX] =  {
 #ifdef CONFIG_NFSD_FLEXFILELAYOUT
 	[LAYOUT_FLEX_FILES]	= &ff_layout_ops,
@@ -177,6 +179,13 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 
 	trace_nfsd_layoutstate_free(&ls->ls_stid.sc_stateid);
 
+	spin_lock(&ls->ls_lock);
+	if (delayed_work_pending(&ls->ls_fence_work)) {
+		spin_unlock(&ls->ls_lock);
+		cancel_delayed_work_sync(&ls->ls_fence_work);
+	} else
+		spin_unlock(&ls->ls_lock);
+
 	spin_lock(&clp->cl_lock);
 	list_del_init(&ls->ls_perclnt);
 	spin_unlock(&clp->cl_lock);
@@ -271,6 +280,10 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	list_add(&ls->ls_perfile, &fp->fi_lo_states);
 	spin_unlock(&fp->fi_lock);
 
+	ls->ls_fenced = false;
+	ls->ls_fence_delay = 0;
+	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
+
 	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
 	return ls;
 }
@@ -747,11 +760,9 @@ static bool
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
@@ -782,10 +793,130 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
 	return 0;
 }
 
+static void
+nfsd4_layout_fence_worker(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct nfs4_layout_stateid *ls = container_of(dwork,
+			struct nfs4_layout_stateid, ls_fence_work);
+	struct nfsd_file *nf;
+	struct block_device *bdev;
+	struct nfs4_client *clp;
+	struct nfsd_net *nn;
+	LIST_HEAD(dispose);
+
+	spin_lock(&ls->ls_lock);
+	if (list_empty(&ls->ls_layouts)) {
+		spin_unlock(&ls->ls_lock);
+dispose:
+		/* unlock the lease so that tasks waiting on it can proceed */
+		nfsd4_close_layout(ls);
+
+		ls->ls_fenced = true;
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
+	clp = ls->ls_stid.sc_client;
+	net_generic(clp->net, nfsd_net_id);
+	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
+		/* fenced ok */
+		nfsd_file_put(nf);
+		pr_warn("%s: FENCED client[%pISpc] clid[%d] to device[0x%x]\n",
+			__func__, (struct sockaddr *)&clp->cl_addr,
+			clp->cl_clientid.cl_id - nn->clientid_base,
+			bdev->bd_dev);
+		goto dispose;
+	}
+	/* fence failed */
+	bdev = nf->nf_file->f_path.mnt->mnt_sb->s_bdev;
+	nfsd_file_put(nf);
+
+	if (!clp->cl_fence_retry_warn) {
+		pr_warn("%s: FENCE failed client[%pISpc] clid[%d] device[0x%x]\n",
+			__func__, (struct sockaddr *)&clp->cl_addr,
+			clp->cl_clientid.cl_id - nn->clientid_base,
+			bdev->bd_dev);
+		clp->cl_fence_retry_warn = true;
+	}
+	/*
+	 * The fence worker retries the fencing operation indefinitely to
+	 * prevent data corruption. The admin needs to take the following
+	 * actions to restore access to the file for other clients:
+	 *
+	 *  . shutdown or power off the client being fenced.
+	 *  . manually expire the client to release all its state on the server;
+	 *    echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
+	 *
+	 *    The value of 'clid' is displayed in the warning message above.
+	 */
+	if (!ls->ls_fence_delay)
+		ls->ls_fence_delay = HZ;
+	else if (ls->ls_fence_delay < MAX_FENCE_DELAY)
+		ls->ls_fence_delay <<= 1;
+	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, ls->ls_fence_delay);
+}
+
+/**
+ * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
+ * @fl: file to check
+ *
+ * If the layout type supports a fence operation, schedule a worker to
+ * fence the client from accessing the block device.
+ *
+ * This function runs under the protection of the spin_lock flc_lock.
+ * At this time, the file_lease associated with the layout stateid is
+ * on the flc_list. A reference count is incremented on the layout
+ * stateid to prevent it from being freed while the fence worker is
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
+	if (delayed_work_pending(&ls->ls_fence_work))
+		return false;
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
index 98da72fc6067..ec9c430813f2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2387,6 +2387,8 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 #endif
 #ifdef CONFIG_NFSD_SCSILAYOUT
 	xa_init(&clp->cl_dev_fences);
+	mutex_init(&clp->cl_fence_mutex);
+	clp->cl_fence_retry_warn = false;
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
index 713f55ef6554..a607fe62671a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -529,6 +529,8 @@ struct nfs4_client {
 	time64_t		cl_ra_time;
 #ifdef CONFIG_NFSD_SCSILAYOUT
 	struct xarray		cl_dev_fences;
+	struct mutex		cl_fence_mutex;
+	bool			cl_fence_retry_warn;
 #endif
 };
 
@@ -738,8 +740,15 @@ struct nfs4_layout_stateid {
 	stateid_t			ls_recall_sid;
 	bool				ls_recalled;
 	struct mutex			ls_mutex;
+
+	struct delayed_work		ls_fence_work;
+	unsigned int			ls_fence_delay;
+	bool				ls_fenced;
 };
 
+/* Cap exponential backoff between fence retries at 3 minutes */
+#define	MAX_FENCE_DELAY		(180 * HZ)
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


