Return-Path: <linux-fsdevel+bounces-71741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E6CCFC13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E90A43066651
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745333B95B;
	Fri, 19 Dec 2025 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa0EwxxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C55339860;
	Fri, 19 Dec 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146572; cv=none; b=tWoGi5yvtsXsAFFReqFmKJAJf/OUr1p+zWrbrIZQXdjiefvaa4i74Tn2fxUIXauVZ9mtVdT2D7pXyDDYMU3tFjJwkQpCZ+syPcTtEmxGd8O4c+JNM0AxyHcmwt9qDw1HCjfRItaMhNUF2mJpYHoP5cAuGr6CVxgdys2+z85r7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146572; c=relaxed/simple;
	bh=eyaAlhT7GvJk0qhWteiivwFW9DszaFjDaDK9NOAWZr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NjD+zEh/4Nwf0oinFojViQgLwIpC1QlDesRj/qxfdIKcCasEIIFarUeiEcOhU59iTUO/qOKYoCKoFenOTDpS4qfl0xhtsybzbW1JytdyA8wEW3ZvlCpUCD1LRThkan+QJNLNEx0t0RpxIywyRjMCIMd8gGLPfBDrSJxdrvuq9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa0EwxxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 051B7C19424;
	Fri, 19 Dec 2025 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766146572;
	bh=eyaAlhT7GvJk0qhWteiivwFW9DszaFjDaDK9NOAWZr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Aa0EwxxRe0j5hQaNpDvdrTmbVhOglobliWIxJaEyfeEOPTVeowDhGVl4WeYtiCsEk
	 3EtRZ7H6fZrss/icW+dprbYu+lCE6lIGa2Ak0DUPQoxNd/HtKXHtMG6xsLy2sAFN1q
	 pgwi2F8PB+B6RrR//FAJIpWWfsYGgnDNsxbujUgNvJGIcZPZXIh/A+gFxR96mzZz8l
	 LV4XSvl49q8GRc+IDzBv5f78PCt9XdY0dDNGQRgiN/GIJ8y+yTGVCLVP227vT4TBIJ
	 q+Z7QIZEgzoN7bsmm8GvmgU6A764gclbHJiPpa8yXWGL2vtH7XHrG1HBqqY+U0QPj4
	 I0MCCbQa/MiEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24CBD78767;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 19 Dec 2025 13:16:00 +0100
Subject: [PATCH 9/9] sysctl: Update API function documentation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-jag-dovec_consolidate-v1-9-1413b92c6040@kernel.org>
References: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
In-Reply-To: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5503;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=eyaAlhT7GvJk0qhWteiivwFW9DszaFjDaDK9NOAWZr0=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlFQgl2j/tke9WV5lXX1Z5qLslstlVwvskoc
 H6HywWfCJe4E4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpRUIJAAoJELqXzVK3
 lkFPjyYL/0itMb/Er52OShWAef0GqQNRxocv7a4GVmiUHriWBBws1KMmOSYjzVpRaZPquXhK7Zo
 fpEhAEtuWEJiTIRKqibGbFsInUCrl3s8zoK5ZYAZFfQ1cVVHN2pxyQrJnO1M7Ef0RKan0oIOJZj
 3+aS13Awg0i4ewXAJNcY521XcppJkp5Ej2dSKw+Jj/SSslteBDpMTJLw50HsIb5+mQDY+x3isWo
 1Bmb/1QTdEBrOs21pmZ3cjIwTv2Ngcyci4MZmwi3nd39K5jRp5NdkcMPYUDnKU1DLWJQTAu35sw
 ZOXS/BNkA15KGxRR+yBeiQzyb+DWJRVttyP4kGYSx5ISN2IhsiG6KFqZ4qYtybJuEL3dPXscVdV
 LukowPs/md5D3knbOGzS7YrvJPzhjzBIhGkvK+EOE9qR71fmRTXuIVzrubj4ECvJXfE58OGTtrd
 O8LMTJhHz7xVDQY+JEZRBi4LejAo6W/q+txenZeSUYjmUaPeejNmX4IpsKs1UbYTxAfy7l/w2l3
 3w=
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
index 3fa59ef77f931c2753584ed03006f3ff9f5a1d0e..0965ea1212b4097fb21158b08007cf550815a19f 100644
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
@@ -910,7 +927,7 @@ int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
  * Uses WRITE_ONCE to assign value to k_ptr. Executes u_ptr_op if
  * not NULL.
  *
- * returns: 0 on success.
+ * Returns: 0 on success.
  */
 int proc_ulong_u2k_conv_uop(const ulong *u_ptr, ulong *k_ptr,
 			    ulong (*u_ptr_op)(const ulong))
@@ -936,7 +953,7 @@ static int proc_ulong_u2k_conv(const ulong *u_ptr, ulong *k_ptr)
  * Uses READ_ONCE to assign value to u_ptr. Executes k_ptr_op if
  * not NULL.
  *
- * returns: 0 on success.
+ * Returns: 0 on success.
  */
 int proc_ulong_k2u_conv_kop(ulong *u_ptr, const ulong *k_ptr,
 			    ulong (*k_ptr_op)(const ulong))
@@ -1005,6 +1022,21 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
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



