Return-Path: <linux-fsdevel+bounces-72313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD3FCED058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 14:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D9430351FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5BD2D0C84;
	Thu,  1 Jan 2026 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApUhpBQa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0239222560;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767272242; cv=none; b=n58Fr4tNWvwm4p/7pVuC64Zo3dL6SWFnu+q9aKNTunhuyVqladZYKFLScVEWT/EbYmH8nBzL4M2luX/hiigcmbE3bc0yKukZsAY41rbBsSl+LBLCyYqsYMW5QW/6mqSDcWq3pMJ38sYoY+f7hoMx+QYdtoec0RieYxyTyYPUlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767272242; c=relaxed/simple;
	bh=MLmvW6uK36t+JJxfWBoWzf/bqBLohJaUDaY7ZHy7af8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U72nkrP/Mys8oooytD+2bYPX1mD7oXwvxBkKbyckLkSlA9VEmVIwzw5Q6bEbkQ0beDEXdT/MSP7T1o6c1Nw/CYttqsPE27xmJnnMzfAAaIq7e/EyWghuEqA1bpc/Q6QMLIK8qNec5wGPIHGnzmhwEJT+Supx8M8oH1n4Sw7EqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApUhpBQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63720C2BCC4;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767272242;
	bh=MLmvW6uK36t+JJxfWBoWzf/bqBLohJaUDaY7ZHy7af8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ApUhpBQaOq8YyCi7OMU3/qJR6UBKuT5bNcZUGlgN7+q8yJNWLSDWx02bm3GxIIDOR
	 3z1UwoMjUKexXd2h5f05A2LUFndXd5VdF9fTaAuCgNObvyTc59c97nCL8vk1wlGfU+
	 oRg4TEnRa3KnafEALt51Ubuu5vHvg4FL4F+PPvbbkIZQlXKog1k6FH8SFF50cE7Rjb
	 v3It91cmyLaJpVS1a4TVXuBlpEEmQP/9CUX/5vOejsw+tqDYxbeSWZI5Nu0lSVmj8E
	 qaUuV4ar+dVplxJox0GX2iOcmUXJBQjw6ItsrkCStlA3cw1mUIysXNL9DKjHy0rzBz
	 Cnji/psFLmwsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7D9EED603;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 01 Jan 2026 13:57:13 +0100
Subject: [PATCH v2 9/9] sysctl: Update API function documentation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-jag-dovec_consolidate-v2-9-ff918f753ba9@kernel.org>
References: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
In-Reply-To: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5503;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=MLmvW6uK36t+JJxfWBoWzf/bqBLohJaUDaY7ZHy7af8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlWby/UXQzkiyGgh9B7trQiFm5F+QkfS5wJM
 M6D6j5PW81ZFYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpVm8vAAoJELqXzVK3
 lkFPSYYL/jnWyufot+4/mnYJl8EGrk+gJldfGAx28qgTR4Ca+IaFZgjzkm88ShG3yrHr4m5F4cQ
 Emw0s3zI7yhKNih4yyGICMsBWdtSRCIwW7/qCeiCO3ucepX43imHvQO70MHaYGkcP8/zcVbfb8e
 mKAKJFNf17PTMZIKDD4sjhjffCKJcydwnmTzs76FNHntCQW+vSBtsJQHJhSjqu3cP6b2tOKEbfW
 a4cO5kXrztx0GjQnIBVSNPOT6LNOJRRZGENEniv4NhgEOBvfYAjNJnZph8Kfc0UpdjW6TcYArzS
 3rvGnUDa35pF9OTqH11HrlR9AyJcAZqm3kCCf9BgULdPGXxZty3KowR1gDSH/ZMXI2mmD6/54Q1
 bOp8l6/a4uEKO8X0Xp2iOccHE6V5z7zTpBOZ04yVkdIEY3bUFUuc/YIbpWpNSoG44C/XtnarWCd
 gqdGy+PFGzZJ3WxHIkqA7KK4kR7w09I/o9czgJK9lLYrCRIgRZYCmNwwBeAAiuoXmt1Gb8Ijjz5
 O8=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add colon ":" after argument name where it is missing
Add doc for proc_int_conv and proc_dointvec_conv

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 60 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 09a5b2d86684cd09cbd6e9f074ecdb71ea9bf218..5ffa5c1bfdc929f16b59d178d0b253ebcac0f67b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -365,7 +365,7 @@ static void proc_put_char(void **buf, size_t *size, char c)
  * not NULL. Check that the values are less than UINT_MAX to avoid
  * having to support wrap around from userspace.
  *
- * returns 0 on success.
+ * Returns: 0 on success.
  */
 int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
 			   ulong (*u_ptr_op)(const ulong))
@@ -386,7 +386,7 @@ int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
  *
  * Uses READ_ONCE to assign value to u_ptr.
  *
- * returns 0 on success.
+ * Returns: 0 on success.
  */
 int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr)
 {
@@ -460,16 +460,16 @@ static int do_proc_uint_conv_minmax(bool *negp, ulong *u_ptr, uint *k_ptr,
 
 /**
  * proc_int_k2u_conv_kop - Assign kernel value to a user space pointer
- * @u_ptr - pointer to user space variable
- * @k_ptr - pointer to kernel variable
- * @negp - assigned %TRUE if the converted kernel value is negative;
+ * @u_ptr: pointer to user space variable
+ * @k_ptr: pointer to kernel variable
+ * @negp: assigned %TRUE if the converted kernel value is negative;
  *         %FALSE otherweise
- * @k_ptr_op - execute this function before assigning to u_ptr
+ * @k_ptr_op: execute this function before assigning to u_ptr
  *
  * Uses READ_ONCE to get value from k_ptr. Executes k_ptr_op before assigning
  * to u_ptr if not NULL. Does **not** check for overflow.
  *
- * returns 0 on success.
+ * Returns: 0 on success.
  */
 int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
 			  ulong (*k_ptr_op)(const ulong))
@@ -488,15 +488,15 @@ int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
 
 /**
  * proc_int_u2k_conv_uop - Assign user value to a kernel pointer
- * @u_ptr - pointer to user space variable
- * @k_ptr - pointer to kernel variable
- * @negp - If %TRUE, the converted user value is made negative.
- * @u_ptr_op - execute this function before assigning to k_ptr
+ * @u_ptr: pointer to user space variable
+ * @k_ptr: pointer to kernel variable
+ * @negp: If %TRUE, the converted user value is made negative.
+ * @u_ptr_op: execute this function before assigning to k_ptr
  *
  * Uses WRITE_ONCE to assign value to k_ptr. Executes u_ptr_op if
  * not NULL. Check for overflow with UINT_MAX.
  *
- * returns 0 on success.
+ * Returns: 0 on success.
  */
 int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
 			  ulong (*u_ptr_op)(const ulong))
@@ -515,6 +515,23 @@ int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
 	return 0;
 }
 
+/**
+ * proc_int_conv - Change user or kernel pointer based on direction
+ *
+ * @negp: will be passed to uni-directional converters
+ * @u_ptr: pointer to user variable
+ * @k_ptr: pointer to kernel variable
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @tbl: the sysctl table
+ * @k_ptr_range_check: Check range for k_ptr when %TRUE
+ * @user_to_kern: Callback used to assign value from user to kernel var
+ * @kern_to_user: Callback used to assign value from kernel to user var
+ *
+ * When direction is kernel to user, then the u_ptr is modified.
+ * When direction is user to kernel, then the k_ptr is modified.
+ *
+ * Returns: 0 on success
+ */
 int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
 		  const struct ctl_table *tbl, bool k_ptr_range_check,
 		  int (*user_to_kern)(const bool *negp, const ulong *u_ptr, int *k_ptr),
@@ -912,7 +929,7 @@ int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
  * Uses WRITE_ONCE to assign value to k_ptr. Executes u_ptr_op if
  * not NULL.
  *
- * returns: 0 on success.
+ * Returns: 0 on success.
  */
 int proc_ulong_u2k_conv_uop(const ulong *u_ptr, ulong *k_ptr,
 			    ulong (*u_ptr_op)(const ulong))
@@ -938,7 +955,7 @@ static int proc_ulong_u2k_conv(const ulong *u_ptr, ulong *k_ptr)
  * Uses READ_ONCE to assign value to u_ptr. Executes k_ptr_op if
  * not NULL.
  *
- * returns: 0 on success.
+ * Returns: 0 on success.
  */
 int proc_ulong_k2u_conv_kop(ulong *u_ptr, const ulong *k_ptr,
 			    ulong (*k_ptr_op)(const ulong))
@@ -1007,6 +1024,21 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 				do_proc_ulong_conv);
 }
 
+/**
+ * proc_dointvec_conv - read a vector of ints with a custom converter
+ *
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ * @conv: Custom converter call back. Defaults to do_proc_int_conv
+ *
+ * Reads/writes up to table->maxlen/sizeof(int) integer values from/to the
+ * user buffer, treated as an ASCII string.
+ *
+ * Returns: 0 on success
+ */
 int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 		       size_t *lenp, loff_t *ppos,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,

-- 
2.50.1



