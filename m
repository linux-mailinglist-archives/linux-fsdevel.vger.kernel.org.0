Return-Path: <linux-fsdevel+bounces-72315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5119CCED05E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 14:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8D793036582
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1155A2D0C89;
	Thu,  1 Jan 2026 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpYfOt+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18A2264C9;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767272242; cv=none; b=pFVnqsxss+qsS951FyGbcBZgXlFBmaSedosMCnBYywJwcQBMfNOlfCy82MY6hlGF8+DTFWkmuztNDGaHRYOsAWWGIE8Bs7Ke4zst7asLO4PMU2kDKXhz/FiAMJNFSDuBWhu2pcfVUodWvfl2hyavztZp5C6+YmDEkTAn6DkVNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767272242; c=relaxed/simple;
	bh=PIAQtecICUqPpS+GwLLx44WXYsf3diE+/qtx8X2p5C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOpRtrpzz63fxSoP4VbAlNBPAE6R2cAiSKlnEhI5QhCchsXHyiAJpkq6aLkcPVSI9Sg12xSTU2m1LUYETwq7ZfW2gTAt5RxgDu8hQYAcSDu0kmvg/83aucDVEpo4yD+ZDLjwMZadoOIieZjzDxM0ndzJDs1amBypMqmUi4Nz3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpYfOt+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C980C2BC9E;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767272242;
	bh=PIAQtecICUqPpS+GwLLx44WXYsf3diE+/qtx8X2p5C0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fpYfOt+xzl1hYIZz5NQGsuSDLEP2raHrfupPMUQf7snK+IU3dXGBh9++lHAJ6cHV/
	 o/8AHY7K+M9LZ+6UU4ahXLOATbxYrOeZD6F1zivt4jxJdfx4GZ0Umb0PRkwE9/k5C1
	 b0LfFcxUp7bDuhtPvCeNXBXYxx9BJWjsApTm5V+q/vd7mjcU0kCyFDW6E/rT4mhm+V
	 Mx8A03xJgJu+rr4BdCvhdmvE4dPXzzxsDcq6cWNNtHEaWbLSZVDZdnBOrCepymnOYt
	 DBVfgWkGE6RzwxgHcaQ7MKjLwIrfR56IE7ezWkf3vn1wbiFkzYDfbJKL20kbxdyMHP
	 urdvxxZazN+hQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CCEEEB599;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 01 Jan 2026 13:57:11 +0100
Subject: [PATCH v2 7/9] sysctl: Group proc_handler declarations and
 document
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-jag-dovec_consolidate-v2-7-ff918f753ba9@kernel.org>
References: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
In-Reply-To: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8609;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=PIAQtecICUqPpS+GwLLx44WXYsf3diE+/qtx8X2p5C0=;
 b=owJ4nAHsARP+kA0DAAoBupfNUreWQU8ByyZiAGlWby4Vi5lAIxZP6HujaWUboPTqyKETi6mYN
 rVvVmiYApOxpIkBsgQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpVm8uAAoJELqXzVK3
 lkFPMBoL+ORiK+iFJAXM+evKOGujOUeFh5FzGL07It6KCm5eN2apg8w8EFSkVzn2ipOOSk53HLj
 ezKCPADMz8FBuGd//+XlXmBtgzfyggqvl10/v/L1dzhqUYw8CfqHppda9vSF3WQn1+3bWnOarF/
 MsN0GQrtQB4neUSzJYIh3sqQsTRwK8lq4bg5mz9x+QGjJCwilEfRdjIisk8hozkfalgslWdsEuc
 ojU/uZJ7YdhjBDq7tSuPbT9uhkjAcZoM8Tf8sqR3naHBIUzSFDO4iFCYpJqt3UpjhteC4c5rd02
 3Y8mPGIZJf2JeMd300iBwGY3x8f/Fn5mDA5hFQYOovKIIA+X3QSpq7sHB/ox4tBXm1QjykPWW7W
 ktj3meWyo03L6T1nYWepxLVPq6JBgD1W7/+EFLzmEPGovid8ZOEeHubb9rCygZLDF76vkX9Aem7
 Cuzh3pcqom5MII3/bOSv61ytynbl8TDRZxpoGDymkfXZKwTyxLDazEACw+EcqaYjiHQ3MhvV7mL
 Q==
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Make four groups in the sysctl header and document each group with an
example of how to use them.
1. proc_handler : All functions that can be passed to the proc_handler
   pointer in ctl_table
2. proc handler aggregators: Functions to create proc handlers with
   custom converters
3. bi-directional converters: Functions to create read/write custom
   converters. Can be passed to proc handler aggregators
4. uni-directional converters: Functions to create read or write custom
   converters. Can be passed as args to bi-directional converters

Use just one naming convention in the declarations: 'write' becomes
'dir' and 'buffer' becomes 'buf'.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h | 128 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 41 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 8f8e357b1f4d377a0891fbc85d34073cd30469b1..ad268dfd9e79f5540a4a85a9a439819fb3172640 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -74,63 +74,109 @@ extern const int sysctl_vals[];
 
 extern const unsigned long sysctl_long_vals[];
 
-typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-
-int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dobool(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
+typedef int proc_handler(const struct ctl_table *ctl, int dir, void *buf,
+			 size_t *lenp, loff_t *ppos);
 
-int proc_dointvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dointvec_minmax(const struct ctl_table *table, int dir, void *buffer,
+/* proc_handler functions */
+int proc_dostring(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
+		  loff_t *ppos);
+int proc_dobool(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
+		loff_t *ppos);
+int proc_dointvec(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
+		  loff_t *ppos);
+int proc_dointvec_minmax(const struct ctl_table *ctl, int dir, void *buf,
 			 size_t *lenp, loff_t *ppos);
-int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
+int proc_douintvec(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
+		   loff_t *ppos);
+int proc_douintvec_minmax(const struct ctl_table *ctl, int dir, void *buf,
+			  size_t *lenp, loff_t *ppos);
+int proc_dou8vec_minmax(const struct ctl_table *ctl, int dir, void *buf,
+			size_t *lenp, loff_t *ppos);
+int proc_doulongvec_minmax(const struct ctl_table *ctl, int dir, void *buf,
+			   size_t *lenp, loff_t *ppos);
+int proc_do_large_bitmap(const struct ctl_table *ctl, int dir, void *buf,
+			 size_t *lenp, loff_t *ppos);
+int proc_do_static_key(const struct ctl_table *ctl, int dir, void *buf,
+		       size_t *lenp, loff_t *ppos);
+
+/*
+ * proc_handler aggregators
+ *
+ * Create a proc_handler with a custom converter. Use when the user space
+ * value is a transformation of the kernel value. Cannot be passed as
+ * proc_handlers.
+ *
+ * Example of creating your custom proc handler:
+ * int custom_converter(bool *negp, ulong *u_ptr, uint *k_ptr,
+ *                      int dir, const struct ctl_table *ctl) {...}
+ * int custom_proc_handler(const struct ctl_table *ctl, int dir,
+ *                         void *buf, size_t *lenp, loff_t *ppos
+ * { return proc_dointvec_conv(ctl, dir, buf, lenp, ppos, custom_converter); }
+ */
+int proc_dointvec_conv(const struct ctl_table *ctl, int dir, void *buf,
 		       size_t *lenp, loff_t *ppos,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
-				   int dir, const struct ctl_table *table));
-int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
-			  ulong (*k_ptr_op)(const ulong));
-int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
-			  ulong (*u_ptr_op)(const ulong));
+				   int dir, const struct ctl_table *ctl));
+int proc_douintvec_conv(const struct ctl_table *ctl, int dir, void *buf,
+			size_t *lenp, loff_t *ppos,
+			int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
+				    int dir, const struct ctl_table *ctl));
+int proc_doulongvec_minmax_conv(const struct ctl_table *ctl, int dir, void *buf,
+				size_t *lenp, loff_t *ppos,
+				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
+					    int dir, const struct ctl_table *ctl));
+
+/*
+ * bi-directional converter functions
+ *
+ * Specify the converter function for both directions (user to kernel & kernel
+ * to user). Use when you want to change the value of the variable before
+ * assignment. Used to create custom proc_handler aggregators.
+ *
+ * Example of creating your custom bi-directional converter:
+ * int custom_u2k(ulong *u_ptr, const uint *k_ptr) { ... }
+ * int custom_converter(bool *negp, ulong *u_ptr, uint *k_ptr,
+ *                      int dir, const struct ctl_table *ctl)
+ * { return proc_uint_conv(u_ptr, k_ptr, dir, ctl, true,
+ *                         custom_u2k, proc_uint_k2u_conv}
+ */
 int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
 		  const struct ctl_table *tbl, bool k_ptr_range_check,
 		  int (*user_to_kern)(const bool *negp, const ulong *u_ptr, int *k_ptr),
 		  int (*kern_to_user)(bool *negp, ulong *u_ptr, const int *k_ptr));
-
-int proc_douintvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-int proc_douintvec_conv(const struct ctl_table *table, int write, void *buffer,
-			size_t *lenp, loff_t *ppos,
-			int (*conv)(bool *negp, ulong *lvalp, uint *valp,
-				    int write, const struct ctl_table *table));
-int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr);
-int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
-			   ulong (*u_ptr_op)(const ulong));
 int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
 		   const struct ctl_table *tbl, bool k_ptr_range_check,
 		   int (*user_to_kern)(const ulong *u_ptr, uint *k_ptr),
 		   int (*kern_to_user)(ulong *u_ptr, const uint *k_ptr));
-
-int proc_dou8vec_minmax(const struct ctl_table *table, int write, void *buffer,
-			size_t *lenp, loff_t *ppos);
-int proc_doulongvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
-				void *buffer, size_t *lenp, loff_t *ppos,
-				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
-					    int dir, const struct ctl_table *table));
-int proc_do_large_bitmap(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_do_static_key(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-
-int proc_ulong_u2k_conv_uop(const ulong *u_ptr, ulong *k_ptr,
-			    ulong (*u_ptr_op)(const ulong));
-int proc_ulong_k2u_conv_kop(ulong *u_ptr, const ulong *k_ptr,
-			    ulong (*k_ptr_op)(const ulong));
 int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
 		    const struct ctl_table *tbl, bool k_ptr_range_check,
 		    int (*user_to_kern)(const ulong *u_ptr, ulong *k_ptr),
 		    int (*kern_to_user)(ulong *u_ptr, const ulong *k_ptr));
+
+/*
+ * uni-directional converter functions
+ *
+ * Specify the converter function for one directions (user to kernel or
+ * kernel to user). Use to call the actual value conversion. Used to Create
+ * bi-directional converters.
+ *
+ * Example of creating a uni-directional converter:
+ * ulong op(const ulong val) { ... }
+ * int custom_unidir_conv(ulong *u_ptr, const uint *k_ptr)
+ * { return proc_uint_k2u_conv_kop(u_ptr, k_ptr, op); }
+ */
+int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
+			  ulong (*k_ptr_op)(const ulong));
+int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
+			  ulong (*u_ptr_op)(const ulong));
+int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr);
+int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
+			   ulong (*u_ptr_op)(const ulong));
+int proc_ulong_u2k_conv_uop(const ulong *u_ptr, ulong *k_ptr,
+			    ulong (*u_ptr_op)(const ulong));
+int proc_ulong_k2u_conv_kop(ulong *u_ptr, const ulong *k_ptr,
+			    ulong (*k_ptr_op)(const ulong));
+
 /*
  * Register a set of sysctl names by calling register_sysctl
  * with an initialised array of struct ctl_table's.

-- 
2.50.1



