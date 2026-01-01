Return-Path: <linux-fsdevel+bounces-72311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFD8CED054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 14:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27DDE30334CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0468C2D0C7F;
	Thu,  1 Jan 2026 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyndZou4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92735221F2F;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767272242; cv=none; b=eTuKBwOm3NTDVfsGZlPFbg81XQNXceFsFv5vW00EZSI9mFAuhMiEvx25mqPgSLyWEfQIaiPuTvL9HCvLGzLcav5XeD0O0MogLw+bpvBI7X1WGeRFrVx+AHLRMD5ylSan+tOHsP5L7e7eT1DNy6qI/I7NTQ0gBh639N26b5Bb89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767272242; c=relaxed/simple;
	bh=MzMUFtw28DFdEAcmgt575DTHAbUX+7Aak8PJgw2U3n4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfrgrnyzMpgrXQhypVcqEQIMrwvOIs5SkGb/t/qwjFhU4Zp3ZELaiSD06JQs41+HxU7lQM7q/EZidEiOmJAEAsrmyt4pPT0K+Z4Lp23hfN8b4VHWpc19N6d3oKcbPlqvwfJXOB6FauHlWzlvB+A3JunLiuwVTmh801OWAjGZZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyndZou4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57EFEC19425;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767272242;
	bh=MzMUFtw28DFdEAcmgt575DTHAbUX+7Aak8PJgw2U3n4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SyndZou4tbT1LasI5kmCc8zmclPPZ4hnE9urZrt294qyYPTaZVqhh3VL+Uoq76O/i
	 h2hNlmzgMN8xgdZ7bvAOiXwRNRfYk+uQJV1Z5X7WMnMz0x9jhojqLkxhU8IvWps4NB
	 8j8DZxX3F1oRRHYBEJm1WBSH8n4xFhWAEQuzJryojoeUL7c2H9HLJ0a5LKWat47YtA
	 Bbq0a0SGy8zBgQACEglCeGvvbUEfLloDuwBKAwiEpeKJxRobXm4N9cJXsHrk4Zwt/2
	 Wey3NMrxLbK08mXN8q2ifAgb3f8darZNpwHYxxAFkIoQHIAswZnKI0xQAcPQ2iEp1V
	 D/B9Xx2MCeexg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B8EED605;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 01 Jan 2026 13:57:12 +0100
Subject: [PATCH v2 8/9] sysctl: Rename proc_doulongvec_minmax_conv to
 proc_doulongvec_conv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-jag-dovec_consolidate-v2-8-ff918f753ba9@kernel.org>
References: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
In-Reply-To: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3589;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=MzMUFtw28DFdEAcmgt575DTHAbUX+7Aak8PJgw2U3n4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlWby6lDubJMgEskL1wDLPHDk5KSnhJZgPc4
 vSgLbx0hQ4/34kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpVm8uAAoJELqXzVK3
 lkFPxk4L/1bSJ0ctDiLoni3Tsfm2wdh+HwAQGuPZl6Gizt2Il9DMUGAfeQtyCrB9RhRhvJ4z1Ao
 7WCoPBjFgxrkZrbU6rzIvE5k1Q+zza5bc4WHur6NeJc592IFEwOhU1U2D6hl/cp/ayqR358hN5P
 aCA915kXSEg37URh+V2XDb8t+VDFy5m2GMrcS2IBd2atxoDz9tC1BQQuc/x7anXdVBcHqvSC7ib
 UsweMJ3EDcO7sA36ZCCzDxuMtd90GgNZSw48PHh56mtHFTsbw7NR5jmjtsvJvRJNpLL1HTW5NJp
 lpZf/5UUF9J2smMgdZi2MsOfjPETxOZdg/WTZOMiiYrizH/klPTZMkkkYErf9PaOe5Xc2+volRC
 rkUg+F2N9GCZKVThtLfPmMzYChFgTzSRG4NPgINQnmsfYUYSQq3IwyForqZBCs/iOkIKWVu4dCN
 +Rc/z5lCErQ/69oO/W+Z1JGsKow6dtquAOBfNORkr3I3GgUX7H8xJw0+jFziYxT/IGEmv980Wr8
 Eo=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove "_minmax" from proc_doulongvec_minmax_conv as it does not enforce
min/max limits but serves as a generic converter for unsigned long
vectors. Update function declaration in sysctl.h, definition in
sysctl.c, and caller in jiffies.c accordingly.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h | 8 ++++----
 kernel/sysctl.c        | 6 +++---
 kernel/time/jiffies.c  | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ad268dfd9e79f5540a4a85a9a439819fb3172640..39cf1bf9703fc66a3c9c3360ca081b5590339caa 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -121,10 +121,10 @@ int proc_douintvec_conv(const struct ctl_table *ctl, int dir, void *buf,
 			size_t *lenp, loff_t *ppos,
 			int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
 				    int dir, const struct ctl_table *ctl));
-int proc_doulongvec_minmax_conv(const struct ctl_table *ctl, int dir, void *buf,
-				size_t *lenp, loff_t *ppos,
-				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
-					    int dir, const struct ctl_table *ctl));
+int proc_doulongvec_conv(const struct ctl_table *ctl, int dir, void *buf,
+			 size_t *lenp, loff_t *ppos,
+			 int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
+				     int dir, const struct ctl_table *ctl));
 
 /*
  * bi-directional converter functions
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b90924944ad52bcd3347cf5ca7c87ac9455eb70d..09a5b2d86684cd09cbd6e9f074ecdb71ea9bf218 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -961,7 +961,7 @@ static int do_proc_ulong_conv(bool *negp, ulong *u_ptr, ulong *k_ptr, int dir,
 }
 
 /**
- * proc_doulongvec_minmax_conv - read a vector of unsigned longs with a custom converter
+ * proc_doulongvec_conv - read a vector of unsigned longs with a custom converter
  *
  * @table: the sysctl table
  * @dir: %TRUE if this is a write to the sysctl file
@@ -976,7 +976,7 @@ static int do_proc_ulong_conv(bool *negp, ulong *u_ptr, ulong *k_ptr, int dir,
  *
  * Returns: 0 on success
  */
-int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
+int proc_doulongvec_conv(const struct ctl_table *table, int dir,
 				void *buffer, size_t *lenp, loff_t *ppos,
 				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
 					    int dir, const struct ctl_table *table))
@@ -1241,7 +1241,7 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 	return -ENOSYS;
 }
 
-int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
+int proc_doulongvec_conv(const struct ctl_table *table, int dir,
 				void *buffer, size_t *lenp, loff_t *ppos,
 				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
 					    int dir, const struct ctl_table *table))
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 57ed5f363f94bd566aa53c061f20d3f4f2a05944..38a654e79b731956748c5ff9b476fb2adea58d7b 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -337,8 +337,8 @@ int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos,
-					   do_proc_ulong_conv_ms_jiffies);
+	return proc_doulongvec_conv(table, dir, buffer, lenp, ppos,
+				    do_proc_ulong_conv_ms_jiffies);
 }
 EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
 

-- 
2.50.1



