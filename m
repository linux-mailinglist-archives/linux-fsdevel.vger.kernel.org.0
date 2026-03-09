Return-Path: <linux-fsdevel+bounces-79734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ9mLCFcrmkMCgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 06:35:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B75233F35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 06:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA94303A6E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 05:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E23233E8;
	Mon,  9 Mar 2026 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nJxAHDcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712B320A0E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773034485; cv=none; b=uogFd8jLZ3ocFpuxo2UamS6B7FyBx0i1TguNnKaInlGaDTbOX1yNvq8y9nmuRUesfu4vyN/kUntXleYR46ouDbrlH5epcRT+Hkm4IX44OVOiiTzsNYRccJ3uo8InbrPxyJcu0fPvYan5qVE243DGU3mkVyzZ08AdzjHepc10p3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773034485; c=relaxed/simple;
	bh=rzGFEpLJFzySK8rHx1StVCs5K8SPI0X6GoN0/XmTUf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=UhgSx4r+puWQNIu6y1kT6wmJMGbRQZr0IS7m3e4geCVSijCzs/MCOx7vKmCzjJkdTJIOKI6VhAEKhbKf50JD5WlU0hTiJxLk2K+s2UNVVOt35aE9j4sNysAg4dtA9ax+KRzhf4PLBX8KEyjyQxPDYp6eI5E5v/pC627klGNAhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nJxAHDcv; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260309053434epoutp0169cd4f9c5c9e83cca906a4482400b16b~bFXXmGx4Y0931009310epoutp01P
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 05:34:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260309053434epoutp0169cd4f9c5c9e83cca906a4482400b16b~bFXXmGx4Y0931009310epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773034474;
	bh=L3GfgS6uBzkeWFGmf4ErU97q3uCbzml5uA0RZsd4Qzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJxAHDcvJKmIgWv2Ppk9Zwd0XgdJz8xNdv6Z/GWC3DW6GBJmYAVPX9vYKTH+eKJOx
	 Tu7brDL/TL5+oE4N69xpDcUBDE9xx85rCUa4eKV6Dg9TIlUpfGUmn8uiMBI1t5q22+
	 x9N4B40QttGQSeNag7WY0DjS9SBync4f6CTQktFE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260309053433epcas5p13dadf44f23555ec07fbd0796686bb7ea~bFXXFh2511924119241epcas5p19;
	Mon,  9 Mar 2026 05:34:33 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fTm0m5Kyzz3hhTG; Mon,  9 Mar
	2026 05:34:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260309053432epcas5p48e0273c8829a735ed987d1a02fcccac4~bFXViBW7m0527605276epcas5p4S;
	Mon,  9 Mar 2026 05:34:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260309053430epsmtip28ebe7b14f0768fe2df2c3e02f4477329~bFXT3K6nk1941819418epsmtip2k;
	Mon,  9 Mar 2026 05:34:30 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: brauner@kernel.org, hch@lst.de, djwong@kernel.org, jack@suse.cz,
	cem@kernel.org, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 3/5] xfs: implement write-stream management support
Date: Mon,  9 Mar 2026 10:59:42 +0530
Message-Id: <20260309052944.156054-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260309052944.156054-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260309053432epcas5p48e0273c8829a735ed987d1a02fcccac4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260309053432epcas5p48e0273c8829a735ed987d1a02fcccac4
References: <20260309052944.156054-1-joshi.k@samsung.com>
	<CGME20260309053432epcas5p48e0273c8829a735ed987d1a02fcccac4@epcas5p4.samsung.com>
X-Rspamd-Queue-Id: 53B75233F35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79734-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:dkim,samsung.com:email,samsung.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.933];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Implement support for FS_IOC_WRITE_STREAM ioctl.

For FS_WRITE_STREAM_OP_GET_MAX, available write streams are reported
based on the capability of the underlying block device.
For FS_WRITE_STREAM_OP_{SET/GET}, add a new i_write_stream field in xfs
inode. This value is propagated to the iomap during block mapping.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/xfs/xfs_icache.c |  1 +
 fs/xfs/xfs_inode.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.h  |  6 ++++++
 fs/xfs/xfs_ioctl.c  | 34 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.c  |  1 +
 5 files changed, 88 insertions(+)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index a7a09e7eec81..2ad8d02152f4 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -130,6 +130,7 @@ xfs_inode_alloc(
 	spin_lock_init(&ip->i_ioend_lock);
 	ip->i_next_unlinked = NULLAGINO;
 	ip->i_prev_unlinked = 0;
+	ip->i_write_stream = 0;
 
 	return ip;
 }
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 50c0404f9064..9b88b2d1cf9a 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -47,6 +47,52 @@
 
 struct kmem_cache *xfs_inode_cache;
 
+int
+xfs_inode_max_write_streams(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct block_device	*bdev;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		bdev = mp->m_rtdev_targp ? mp->m_rtdev_targp->bt_bdev : NULL;
+	else
+		bdev = mp->m_ddev_targp->bt_bdev;
+
+	if (!bdev)
+		return 0;
+
+	return bdev_max_write_streams(bdev);
+}
+
+uint8_t
+xfs_inode_get_write_stream(
+	struct xfs_inode	*ip)
+{
+	uint8_t		stream_id;
+
+	xfs_ilock(ip, XFS_ILOCK_SHARED);
+	stream_id = ip->i_write_stream;
+	xfs_iunlock(ip, XFS_ILOCK_SHARED);
+
+	return stream_id;
+}
+
+int
+xfs_inode_set_write_stream(
+	struct xfs_inode	*ip,
+	uint8_t			stream_id)
+{
+	if (stream_id > xfs_inode_max_write_streams(ip))
+		return -EINVAL;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	ip->i_write_stream =  stream_id;
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	return 0;
+}
+
 /*
  * These two are wrapper routines around the xfs_ilock() routine used to
  * centralize some grungy code.  They are used in places that wish to lock the
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bd6d33557194..9f6cab729924 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -38,6 +38,9 @@ typedef struct xfs_inode {
 	struct xfs_ifork	i_df;		/* data fork */
 	struct xfs_ifork	i_af;		/* attribute fork */
 
+	/* Write stream information */
+	uint8_t			i_write_stream;
+
 	/* Transaction and locking information. */
 	struct xfs_inode_log_item *i_itemp;	/* logging information */
 	struct rw_semaphore	i_lock;		/* inode lock */
@@ -676,4 +679,7 @@ int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
 		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
 		struct xfs_dquot **pdqpp);
 
+int xfs_inode_max_write_streams(struct xfs_inode *ip);
+uint8_t xfs_inode_get_write_stream(struct xfs_inode *ip);
+int xfs_inode_set_write_stream(struct xfs_inode *ip, uint8_t stream_id);
 #endif	/* __XFS_INODE_H__ */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index facffdc8dca8..091d6a8b5f57 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1160,6 +1160,38 @@ xfs_ioctl_fs_counts(
 	return 0;
 }
 
+static int
+xfs_ioc_write_stream(
+	struct file		*filp,
+	void __user		*arg)
+{
+	struct inode		*inode = file_inode(filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct fs_write_stream	ws = { };
+
+	if (copy_from_user(&ws, arg, sizeof(ws)))
+		return -EFAULT;
+
+	switch (ws.op_flags) {
+	case FS_WRITE_STREAM_OP_GET_MAX:
+		ws.max_streams = xfs_inode_max_write_streams(ip);
+		goto copy_out;
+	case FS_WRITE_STREAM_OP_GET:
+		ws.stream_id = xfs_inode_get_write_stream(ip);
+		goto copy_out;
+	case FS_WRITE_STREAM_OP_SET:
+		return xfs_inode_set_write_stream(ip, ws.stream_id);
+	default:
+		return -EINVAL;
+	}
+	return 0;
+
+copy_out:
+	if (copy_to_user(arg, &ws, sizeof(ws)))
+		return -EFAULT;
+	return 0;
+}
+
 /*
  * These long-unused ioctls were removed from the official ioctl API in 5.17,
  * but retain these definitions so that we can log warnings about them.
@@ -1425,6 +1457,8 @@ xfs_file_ioctl(
 		return xfs_ioc_health_monitor(filp, arg);
 	case XFS_IOC_VERIFY_MEDIA:
 		return xfs_ioc_verify_media(filp, arg);
+	case FS_IOC_WRITE_STREAM:
+		return xfs_ioc_write_stream(filp, arg);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index be86d43044df..7988c9e16635 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -148,6 +148,7 @@ xfs_bmbt_to_iomap(
 	else
 		iomap->bdev = target->bt_bdev;
 	iomap->flags = iomap_flags;
+	iomap->write_stream = ip->i_write_stream;
 
 	/*
 	 * If the inode is dirty for datasync purposes, let iomap know so it
-- 
2.25.1


