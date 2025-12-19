Return-Path: <linux-fsdevel+bounces-71740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C6CCFBD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2655303125E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1533333B955;
	Fri, 19 Dec 2025 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP2Tl4+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E3339702;
	Fri, 19 Dec 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146572; cv=none; b=d4s0mKrjkXKhlQu1A1VJcUURq7bCh32V3Vgd0S3O/YdFf9nXeT5dWlm1ne+Gksex+KLSxjkW2djnIvzIegXe+hTrOzoOk0ct9O7hp21TU47Qw6eZf3Se+jWpsReQRq8SiWJwh39x8tc9Up4muZaGKGudOrgtydq2OEaeiK2h9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146572; c=relaxed/simple;
	bh=LYKepGhVVod321kzN+GP9Noclko65wxhv2Cran/BQS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHqjU+ORpyzd7HbvddDducNbly6qyCaWr2ArGlKHuN0RJ3Jg5YownruY1Q2a1wdeYeU16s2CLNzrBqr0F9Z/7RvvZ9p5dOWNlKQ4LtyhaVVHX/8+xzx0/m5Kr+bu+0LFLvfB3x/9Wz0A8HkhbxPbT3bVzPpvqw61j6NUXcCFaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP2Tl4+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9104C2BCB2;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766146571;
	bh=LYKepGhVVod321kzN+GP9Noclko65wxhv2Cran/BQS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QP2Tl4+m1JHMi/kvR/FWYel0xmuWjsOGSxYo7/3c4nMV3MN5EOwf1VLa2oguZrvNx
	 QYY/4ICVGHWAyrvRIQA+01DqoA80J4LrZtHgDFQsQ14QoJ5cYAKB5HpLJlB6S2UXG7
	 C/txLB4SwMVxs+swg5fjk9yULZXnCFWfacQCeOEAp6EcDEaU2S2E7z6WbJin4MZLZ4
	 UdBoiV+kYtDksV63Ndh82aaSYukdnvmAa77LHjhK8J0J6IuVZrJqzUh2vJhV4Ecbmq
	 RRNB758MJAIshdGLbB1Ii9/WzJW7Z6+pYPyOsMjdi/o9jYV0GE05HsSTDpzc6LRL5H
	 O8C3SDoQB3VYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DBDD767EE;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 19 Dec 2025 13:15:57 +0100
Subject: [PATCH 6/9] sysctl: Rename do_proc_dotypevec macro to
 do_proc_typevec
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-jag-dovec_consolidate-v1-6-1413b92c6040@kernel.org>
References: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
In-Reply-To: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4776;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=LYKepGhVVod321kzN+GP9Noclko65wxhv2Cran/BQS8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlFQgcfKfOWlIi7CTIxyVY3Be7pqiRaPV1kP
 BTBu0Fdipie3okBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpRUIHAAoJELqXzVK3
 lkFPlc4L/iBNaUhX7uiypmBB+40uRz4gu0pYBJAuxOJJo+PEurNQGznaNBuf2zfxg6GYRYUcPfd
 sbjXOfbOp3S0TpWivzVnwCiv6ZZrmtGASPqMed1yfYXXOeOBaJLhZ7MoM6ABa/u8xAwCTNymORV
 IUu/SZ/FA06UPc2KLrPWGQOjwN9JAhpR6EbtDpGfmw7zasg3XxXgDKCjX34kEcRa4ywFgMQqFZm
 9+8sRhBH2UncZMZOMRMC6ohyJyoZj79MOGDzLO+LHPbRAjELtcRYucu4VAwyi83zyFL8GcU08F0
 pNZnyxlTZtldzwp6UGSbSE2dbtokK0HwVlachS2zab1suiJmQ9FuquD+41wE/69GbZItQojBOCk
 KnJQToCyk7xrw5rFYvPpgP07bMdOFQeTjMMJ4zyq4KhISaxfHP1twVJUqdUn9rJrZJekdACytk1
 F16asKUzQF3fEm9gffB+cDyyBVcQFmH1buMdSWh2Bn0nBqRXaFhLYesmDbnoweyNK5aTC2yyTP4
 gg=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove the do..do from the proc vector functions. The redundant "do"
only adds confusion to the already large amount of functions in sysctl.c

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4fa26b913f59c60a5b4fbc2d66d5d99c641eecba..aecb46bdf4cafc134f83f2014e89a209efc8c10d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -576,8 +576,8 @@ static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
  * Do not export this macro outside the sysctl subsys.
  * It is meant to generate static functions only
  */
-#define do_proc_dotypevec(T) \
-static int do_proc_do##T##vec(const struct ctl_table *table, int dir, \
+#define do_proc_typevec(T) \
+static int do_proc_##T##vec(const struct ctl_table *table, int dir, \
 		  void *buffer, size_t *lenp, loff_t *ppos, \
 		  int (*conv)(bool *negp, ulong *u_ptr, T *k_ptr, \
 			      int dir, const struct ctl_table *table)) \
@@ -647,9 +647,9 @@ out: \
 	return err; \
 }
 
-do_proc_dotypevec(int)
-do_proc_dotypevec(ulong)
-do_proc_dotypevec(uint)
+do_proc_typevec(int)
+do_proc_typevec(ulong)
+do_proc_typevec(uint)
 
 /**
  * proc_douintvec_conv - read a vector of unsigned ints with a custom converter
@@ -676,7 +676,7 @@ int proc_douintvec_conv(const struct ctl_table *table, int dir, void *buffer,
 	if (!conv)
 		conv = do_proc_uint_conv;
 
-	return do_proc_douintvec(table, dir, buffer, lenp, ppos, conv);
+	return do_proc_uintvec(table, dir, buffer, lenp, ppos, conv);
 }
 
 /**
@@ -735,7 +735,7 @@ int proc_dobool(const struct ctl_table *table, int dir, void *buffer,
 int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 		  size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos, do_proc_int_conv);
+	return do_proc_intvec(table, dir, buffer, lenp, ppos, do_proc_int_conv);
 }
 
 /**
@@ -754,8 +754,7 @@ int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
-	return do_proc_douintvec(table, dir, buffer, lenp, ppos,
-				 do_proc_uint_conv);
+	return do_proc_uintvec(table, dir, buffer, lenp, ppos, do_proc_uint_conv);
 }
 
 /**
@@ -778,8 +777,8 @@ int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-				do_proc_int_conv_minmax);
+	return do_proc_intvec(table, dir, buffer, lenp, ppos,
+			      do_proc_int_conv_minmax);
 }
 
 /**
@@ -805,8 +804,8 @@ int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 int proc_douintvec_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_douintvec(table, dir, buffer, lenp, ppos,
-				 do_proc_uint_conv_minmax);
+	return do_proc_uintvec(table, dir, buffer, lenp, ppos,
+			       do_proc_uint_conv_minmax);
 }
 
 /**
@@ -849,8 +848,8 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 		tmp.extra2 = (unsigned int *) &max;
 
 	val = READ_ONCE(*data);
-	res = do_proc_douintvec(&tmp, dir, buffer, lenp, ppos,
-				do_proc_uint_conv_minmax);
+	res = do_proc_uintvec(&tmp, dir, buffer, lenp, ppos,
+			      do_proc_uint_conv_minmax);
 	if (res)
 		return res;
 	if (SYSCTL_USER_TO_KERN(dir))
@@ -980,7 +979,7 @@ int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
 				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
 					    int dir, const struct ctl_table *table))
 {
-	return do_proc_doulongvec(table, dir, buffer, lenp, ppos, conv);
+	return do_proc_ulongvec(table, dir, buffer, lenp, ppos, conv);
 }
 
 /**
@@ -1002,8 +1001,8 @@ int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
 int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_doulongvec(table, dir, buffer, lenp, ppos,
-				  do_proc_ulong_conv);
+	return do_proc_ulongvec(table, dir, buffer, lenp, ppos,
+				do_proc_ulong_conv);
 }
 
 int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
@@ -1013,7 +1012,7 @@ int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 {
 	if (!conv)
 		conv = do_proc_int_conv;
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos, conv);
+	return do_proc_intvec(table, dir, buffer, lenp, ppos, conv);
 }
 
 /**

-- 
2.50.1



