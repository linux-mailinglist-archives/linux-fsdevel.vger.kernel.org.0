Return-Path: <linux-fsdevel+bounces-33924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F29C0BC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 17:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6BC2835CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504D8216E08;
	Thu,  7 Nov 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNgqU/Nu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F10212D22;
	Thu,  7 Nov 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997312; cv=none; b=FQ9Xx+rPVGRggPibceqJ9OsRSpIqO1AP2MeO8P60ObNDG/67oSVUH0ZPLcn9bwdxuCpgNWovEx3RfA+JZWOT/oOWhkYgNeJX1E3/djGxUtwojAijuKi/lIbBc9+KS+y5GLLYeeqm00cs1gJr1nJ8xvRJJS9jMbh7gXViK8CNXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997312; c=relaxed/simple;
	bh=4DveGDMZgs7lCoOyvHyj8q8j4M1x/bD6dp6XNYVbKTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYHvHJD3WCcACCLNVGhDfWdC8ZSZ42k+OVIDDggoG0Dy8Ne2gtYDDKIBbdsAuwFGkpExr10OnzmNrGk1UMrmyYHLBLDT0KwW9ifx0Db+74Ufij2R/3plDSLeJfEeykv1b6ggvYakDaXii/6EIjpI+G76fHW2N0EdHHAc3fW8nCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNgqU/Nu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730997310; x=1762533310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4DveGDMZgs7lCoOyvHyj8q8j4M1x/bD6dp6XNYVbKTM=;
  b=KNgqU/NuMq8Kg73Sig6K+Bd9yCJPcFMyM0EPmBseU6dPJvhobdwC2uLb
   0glzEoe6p3t2/M5zTODg4ftHgExuDRwyOTVGc/Yk4F/FzjT0lxwcoqFIh
   qAmow77DUvrHKWz3cSDfvTBIQtW2ijOhosbqDU+hNASaNTuEYx/nqqM5k
   hHOH3xWsyBMH9HwZ/xOG6I8lhgmIREP8sHvZQ9itk9Ux5eQ0XK7BB8A4x
   am+3rlTIb26hFGYG8jq2xe2YaHfzL5jqsqjfzUFqbF8CmZfi+6pwCc5AW
   PUKf3ZNiu95HJX8nOBIR51Gntm6m3twAOBMpgXwaaTCKwheylawHdjdSk
   A==;
X-CSE-ConnectionGUID: jsBBQyIxSL+KEqnJDZ26Xg==
X-CSE-MsgGUID: DYjrkIXkTDSJnYFCzX7d+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="18480139"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="18480139"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:35:10 -0800
X-CSE-ConnectionGUID: doG/WlBBQIChIKsPv8x1Nw==
X-CSE-MsgGUID: h0TCrU8AQDOPX/IPx066NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="89797021"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.2.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:35:07 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] libfs: Provide simple_read_from|write_to_iomem()
Date: Thu,  7 Nov 2024 17:34:46 +0100
Message-Id: <20241107163448.2123-3-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20241107163448.2123-1-michal.wajdeczko@intel.com>
References: <20241107163448.2123-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New functions are similar to simple_read_from|write_to_buffer()
but work on the I/O memory instead. Will allow wider code reuse.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/libfs.c         | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  5 +++
 2 files changed, 83 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 46966fd8bcf9..0e4f0d50d4f3 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1095,6 +1095,84 @@ void simple_release_fs(struct vfsmount **mount, int *count)
 }
 EXPORT_SYMBOL(simple_release_fs);
 
+/**
+ * simple_read_from_iomem() - copy data from the I/O memory to user space
+ * @to: the user space buffer to read to
+ * @count: the maximum number of bytes to read
+ * @ppos: the current position in the buffer
+ * @from: the I/O memory to read from
+ * @available: the size of the iomem memory
+ *
+ * The simple_read_from_iomem() function reads up to @count bytes from the
+ * I/O memory @from at offset @ppos into the user space address starting at @to.
+ *
+ * Return: On success, the number of bytes read is returned and the offset
+ * @ppos is advanced by this number, or negative value is returned on error.
+ */
+ssize_t simple_read_from_iomem(void __user *to, size_t count, loff_t *ppos,
+			       const void __iomem *from, size_t available)
+{
+	struct iov_iter iter;
+	loff_t pos = *ppos;
+	size_t copied;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available || !count)
+		return 0;
+	if (count > available - pos)
+		count = available - pos;
+	if (import_ubuf(ITER_DEST, to, count, &iter))
+		return -EFAULT;
+
+	copied = copy_iomem_to_iter(from, pos, count, &iter);
+	if (!copied)
+		return -EFAULT;
+
+	*ppos = pos + copied;
+	return copied;
+}
+EXPORT_SYMBOL(simple_read_from_iomem);
+
+/**
+ * simple_write_to_iomem() - copy data from user space to the I/O memory
+ * @to: the I/O memory to write to
+ * @available: the size of the I/O memory
+ * @ppos: the current position in the buffer
+ * @from: the user space buffer to read from
+ * @count: the maximum number of bytes to read
+ *
+ * The simple_write_to_iomem() function reads up to @count bytes from the user
+ * space address starting at @from into the I/O memory @to at offset @ppos.
+ *
+ * Return: On success, the number of bytes written is returned and the offset
+ * @ppos is advanced by this number, or negative value is returned on error.
+ */
+ssize_t simple_write_to_iomem(void __iomem *to, size_t available, loff_t *ppos,
+			      const void __user *from, size_t count)
+{
+	struct iov_iter iter;
+	loff_t pos = *ppos;
+	size_t copied;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available || !count)
+		return 0;
+	if (count > available - pos)
+		count = available - pos;
+	if (import_ubuf(ITER_SOURCE, (void __user *)from, count, &iter))
+		return -EFAULT;
+
+	copied = copy_iomem_from_iter(to, pos, count, &iter);
+	if (!copied)
+		return -EFAULT;
+
+	*ppos = pos + copied;
+	return copied;
+}
+EXPORT_SYMBOL(simple_write_to_iomem);
+
 /**
  * simple_read_from_buffer - copy data from the buffer to user space
  * @to: the user space buffer to read to
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..2cc73c5961b0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3426,6 +3426,11 @@ extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
+ssize_t simple_read_from_iomem(void __user *to, size_t count, loff_t *ppos,
+			       const void __iomem *from, size_t available);
+ssize_t simple_write_to_iomem(void __iomem *to, size_t available, loff_t *ppos,
+			      const void __user *from, size_t count);
+
 struct offset_ctx {
 	struct maple_tree	mt;
 	unsigned long		next_offset;
-- 
2.43.0


