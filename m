Return-Path: <linux-fsdevel+bounces-75996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HfOEiozfmmcWQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 17:51:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C717CC3165
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 17:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C02303FF2C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69AD31B107;
	Sat, 31 Jan 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="f8YayG76"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160131ED72;
	Sat, 31 Jan 2026 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769878271; cv=none; b=jYYQul9mWmrIE2cLfV5EEHn0O4RzLPnzd9ZeKFgEEvVVXv4+h4yOZuVY4RKO9SwChIrkPEQnhB+C7eAAXC8Xai8zX1Zzp1v6MBYIIH4c6sFUXXT57X64ci8jbFIEKCEkTKBK1rSh7lzs9zohBm7HA723wSYC4CGjoKFmlVGWmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769878271; c=relaxed/simple;
	bh=1pB3xVKmTi/9urPLDQemXLVFxJpImBO61ub0yv1/erA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gzQaBclLr7kqhXsxISlZ8fGBnbtKdAKJ1efOZCl9dOBxkmst3cPued4QXyacU1Q7lpawAKCKz58K5SD1NxFv6TmXG4CM+NMJse4gSTJsbFoGUahytU/wwK18TNfM1ywm4tMb2C3e7fTQgzfx2w5DpqBrTAYX2KqInRYi3yNQcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=f8YayG76; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769878270; x=1801414270;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GmhRYW6qU3+QhzqPh44mvwS3jvmlzkH4CEdYPWoDgYc=;
  b=f8YayG762D/L2rl/cRZr7ywDONhArbwb7++gNdsphR1oWTSBFS28Kwym
   n8WZtXl6U38JIE27O7VI+WYwGBmUreCvxapBz7FcFMBxqW+SdkAWFXObs
   3Vp9wfPJq5LmJpOl1kPfgSV+dZe0nwI7zgLW4sxbnk17v86zb4FoiI6Ln
   6gEk+NxPGm1KgVvocCN4SByYIxCdQ203sya/ECyrS4p5hbvVACTD5GYAI
   lzU92gk5xO1+J8HcvhXGn5Q+Vw69QGagyLSjtQGP0ixQCogHfRFAFgVWR
   7ULITPkxSE1K6YFxVZp+yzZMcXtxiGsvE/5t6t4LS3ZvPHHnZttWfyVK8
   g==;
X-CSE-ConnectionGUID: kTTpri7pT8SMSx9nzr2mRA==
X-CSE-MsgGUID: pOdRVR1uRTu5RNCegeW/Gg==
X-IronPort-AV: E=Sophos;i="6.21,265,1763424000"; 
   d="scan'208";a="11799763"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 16:51:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:13317]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.174:2525] with esmtp (Farcaster)
 id 9ba76695-441a-4387-b836-f7efc0ed5c4c; Sat, 31 Jan 2026 16:51:07 +0000 (UTC)
X-Farcaster-Flow-ID: 9ba76695-441a-4387-b836-f7efc0ed5c4c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Sat, 31 Jan 2026 16:51:07 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Sat, 31 Jan 2026 16:51:06 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yuto
 Ohnuki" <ytohnuki@amazon.com>
Subject: [PATCH] fuse: update atime on DAX read
Date: Sat, 31 Jan 2026 16:50:56 +0000
Message-ID: <20260131165056.94142-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75996-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C717CC3165
X-Rspamd-Action: no action

Address the TODO comment in fuse_dax_read_iter() which has been present
since the initial DAX implementation in commit c2d0ad00d948 ("virtiofs:
implement dax read/write operations").

Simply calling file_accessed() is insufficient for FUSE, as it only
updates the local inode without notifying the server.

This patch introduces fuse_flush_atime() to explicitly send atime
updates to the server via SETATTR, followed by fuse_invalidate_atime()
to invalidate the attribute cache.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/fuse/dax.c    |  4 +++-
 fs/fuse/dir.c    | 20 ++++++++++++++++++++
 fs/fuse/fuse_i.h |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ac6d4c1064cc..da7aa60c308a 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -688,7 +688,9 @@ ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	ret = dax_iomap_rw(iocb, to, &fuse_iomap_ops);
 	inode_unlock_shared(inode);
 
-	/* TODO file_accessed(iocb->f_filp) */
+	file_accessed(iocb->ki_filp);
+	fuse_flush_atime(inode);
+	fuse_invalidate_atime(inode);
 	return ret;
 }
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff..a919dc1ac6bc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2113,6 +2113,26 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 	return fuse_simple_request(fm, &args);
 }
 
+/*
+ * Flush inode->i_atime to the server
+ */
+int fuse_flush_atime(struct inode *inode)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	struct fuse_setattr_in inarg;
+	struct fuse_attr_out outarg;
+
+	memset(&inarg, 0, sizeof(inarg));
+	memset(&outarg, 0, sizeof(outarg));
+
+	inarg.valid = FATTR_ATIME | FATTR_ATIME_NOW;
+
+	fuse_setattr_fill(fm->fc, &args, inode, &inarg, &outarg);
+
+	return fuse_simple_request(fm, &args);
+}
+
 /*
  * Set attributes, and at the same time refresh them.
  *
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..553195ce707f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1467,6 +1467,7 @@ int fuse_dev_release(struct inode *inode, struct file *file);
 bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written);
 
 int fuse_flush_times(struct inode *inode, struct fuse_file *ff);
+int fuse_flush_atime(struct inode *inode);
 int fuse_write_inode(struct inode *inode, struct writeback_control *wbc);
 
 int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




