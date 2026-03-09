Return-Path: <linux-fsdevel+bounces-79735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNoIKQRcrmkMCgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 06:35:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4E233F10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 06:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFAAD3006084
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 05:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE9314B6B;
	Mon,  9 Mar 2026 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JO/Y8BGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DA6317174
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773034489; cv=none; b=fcm0Fyqd/WqSBQLVPf9PaD3k/2bG1ykYg8Q/TYE7+Q1y7Nwul0yM5+N2+B/hX8e71/B8ud1Fw/9DP1nT79y3oE0RtJlnboMHPhO1BBUpTMZKvOmgZFmSUQjEy+tCpCVpkfel4+mZ5ptIZBWF/DkwFqGHFiIXQQrj0LsREIH6f48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773034489; c=relaxed/simple;
	bh=gjoh2aBUmwpTg5oa9Gc8Nq6R9oc6b3jqB6391/6635A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Iu7n+DHBshxPQsbM9CySBBxVLoQUxQK+uG94hgcmFRTAn7HDfskg19Y5Fxt9Jyp5rVYtWVWaQkkJ+EPFa29fJ7SfPutSkqmGHsoA0lJfTXl46xw7GlkE1UhX/R72l6nh6zeLnX3TJCKm24TnTZn62l9rZRwweXXxg2pKCXvPP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JO/Y8BGu; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260309053439epoutp034cffe5a96da1d00b7efa90ba82b17264~bFXb49ewr2509525095epoutp03h
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 05:34:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260309053439epoutp034cffe5a96da1d00b7efa90ba82b17264~bFXb49ewr2509525095epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773034479;
	bh=NFPEB0YbFwrkO2+cZ3PSAuT4sZuEeXUeB09VRdcM7/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JO/Y8BGuFUShVXyEl8s6r7F+wwiHTvSFtd0ge91XgjqpHSf9XoHxAyMGwkCgZEUl9
	 82YK3DT45WhI4oWAdIO3m1zl9RXBlG//h1TQyrCqkzo9UyvNmSEZsmI0xY7htfLiP+
	 4KUR75zqmlmq5UYGYLdom6kHsT15Wa9GHRDNl9mg=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260309053438epcas5p4dd91c5b1eef04d3ac2fbaac41e6d9785~bFXbZy6un1828218282epcas5p4B;
	Mon,  9 Mar 2026 05:34:38 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fTm0s3j8Cz3hhT9; Mon,  9 Mar
	2026 05:34:37 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260309053436epcas5p3cdfff99c945032dc50503774770f4317~bFXZug-bU3071830718epcas5p3R;
	Mon,  9 Mar 2026 05:34:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260309053434epsmtip204ca109b3b8216661863d102f25395e1~bFXXyxbiv1941719417epsmtip2k;
	Mon,  9 Mar 2026 05:34:34 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: brauner@kernel.org, hch@lst.de, djwong@kernel.org, jack@suse.cz,
	cem@kernel.org, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 5/5] xfs: introduce software write streams
Date: Mon,  9 Mar 2026 10:59:44 +0530
Message-Id: <20260309052944.156054-6-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260309052944.156054-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260309053436epcas5p3cdfff99c945032dc50503774770f4317
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260309053436epcas5p3cdfff99c945032dc50503774770f4317
References: <20260309052944.156054-1-joshi.k@samsung.com>
	<CGME20260309053436epcas5p3cdfff99c945032dc50503774770f4317@epcas5p3.samsung.com>
X-Rspamd-Queue-Id: B4F4E233F10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79735-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.935];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Even when the underlying block device does not advertise write streams,
XFS can choose do so as write-stream based AG allocation can improve the
concurrency and reduce interleaving of concurrent block allocation as well
as logical fragmentation.

Use a simple 3-tier (low/medium/high) AG count based heuristic to
publish streams. This enables logical spatial isolation for standard
storage, execluding rotational media and rtvolume.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/xfs/xfs_inode.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index e93141d2cd8b..6c26cf03a261 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -44,7 +44,7 @@
 #include "xfs_xattr.h"
 #include "xfs_inode_util.h"
 #include "xfs_metafile.h"
-
+#define XFS_MAX_WRITE_STREAMS			(32)
 struct kmem_cache *xfs_inode_cache;
 
 int
@@ -53,6 +53,8 @@ xfs_inode_max_write_streams(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct block_device	*bdev;
+	int			hw_streams, sw_streams;
+	xfs_agnumber_t		nr_ags;
 
 	if (XFS_IS_REALTIME_INODE(ip))
 		bdev = mp->m_rtdev_targp ? mp->m_rtdev_targp->bt_bdev : NULL;
@@ -62,7 +64,22 @@ xfs_inode_max_write_streams(
 	if (!bdev)
 		return 0;
 
-	return bdev_max_write_streams(bdev);
+	hw_streams = bdev_max_write_streams(bdev);
+	if (hw_streams > 0)
+		return hw_streams;
+	/* fallback to software-only write streams, excluding some cases */
+	if (bdev_rot(bdev) || XFS_IS_REALTIME_INODE(ip))
+		return 0;
+	nr_ags = mp->m_sb.sb_agcount;
+	/* heuristic: 3-tier (large/mid/small) split of AGs into streams */
+	if (nr_ags >= 32)
+		sw_streams = nr_ags / 4;
+	else if (nr_ags >= 8)
+		sw_streams = nr_ags / 2;
+	else
+		sw_streams = nr_ags;
+
+	return min_t(int, sw_streams, XFS_MAX_WRITE_STREAMS);
 }
 
 uint8_t
-- 
2.25.1


