Return-Path: <linux-fsdevel+bounces-71354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C8ACBECC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52523301B2FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774592D738A;
	Mon, 15 Dec 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSu+d8Mp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81514A60C;
	Mon, 15 Dec 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813981; cv=none; b=i2a2wLj3hXZ6GMCCypueqnKzOhJO29bEirBMdRsl1Sjt74sBMGA0BwtltsjH6MrEEgE6xtchQVotdVgGbJuZ36Onvm3BqtBuGy4+EBUo64GhP4Bq304gjmbadjzRy/JNTBnIJfJIBhHLkXS3doCbttumvrkLCNsF0V9UI4/QNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813981; c=relaxed/simple;
	bh=VcO7f0f3cXa0FqqirX5IIydQhcsrKaS4ABTZrgP1kuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dPq4emM6UiqBTJQaVoHRZ7vutwfBJyq6NqQPhyIiDVyx8yUbiTpkZWJdGDUUvI0YL1V/q0CX2ZNI0BsZ6IZOyFUugBX4DDng64SVMIyLY/YHH4nFizKnaEPw+rFYGggbR0wOGNyLR+oku+ab8DWShlAmNskOO9D1t/zdZY+qCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSu+d8Mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAD61C4CEF5;
	Mon, 15 Dec 2025 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765813981;
	bh=VcO7f0f3cXa0FqqirX5IIydQhcsrKaS4ABTZrgP1kuk=;
	h=From:Date:Subject:To:Cc:From;
	b=ZSu+d8MpymKj+fBAOpdr9STGc4BPwYeXn1pbaJ2bVWhKtmyAa6HbOlqpXJFUu/v0v
	 0iKlwYUrGvdLqd1fzQwsCvBGgC42e9mxut4lXykrY/4mXCqk5t0yNxDOFxNQ/GcfPM
	 cnmyqcvxLke0H3K/WZNLhV3UbTV+3newJORkTOfqRXdW4ah1dtTvVeB+eTwufr/qAQ
	 NA4FtPJ2bwgVNnl74SD8tvpH3xsoB7f/Ds/LY/u5nQFUfs4aqV7oCaFHqWPFA16IiV
	 dvUpBy7VSAzk2Ep7xsOSaNih7uccZ+FFWXbn/qFUImEV5M4gtfyNPEyxGRtNXUDcYx
	 zspBJJ+0KN/Jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983CCD5B16C;
	Mon, 15 Dec 2025 15:53:01 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 15 Dec 2025 16:52:58 +0100
Subject: [PATCH] sysctl: Add missing kernel-doc for proc_dointvec_conv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-jag-sysctl-doc-v1-1-2099a2dcd894@kernel.org>
X-B4-Tracking: v=1; b=H4sIANkuQGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0NT3azEdN3iyuLkkhzdlPxk3RTj5CTTpBRDEzNLSyWgpoKi1LTMCrC
 B0bG1tQCzwredYAAAAA==
X-Change-ID: 20251215-jag-sysctl-doc-d3cb5bd14699
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=VcO7f0f3cXa0FqqirX5IIydQhcsrKaS4ABTZrgP1kuk=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlALtyXDqaqBtEPoxduLEil1bMKjXvp/3ryv
 P1I42OuFU8a3okBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQC7cAAoJELqXzVK3
 lkFPbhUMAIUSCj7MTbSsvZKpRl2gjfsyUusMZIhcJyb+OpL9kHyzqqXPvOHtGJbZ8Z8KQroSP/j
 JFmoQ2F70IxzZHs243SZTydeoyhTTIX0s+32dWqZi579UE7AXrL2kUf/2Wjoe9IFqCOQBHMv7AL
 +94dr1WJ8y5QgfNdZdVFXZtM7pmbHB4qjSUbTIUo9MtAQ9RTM4W2E2G27dmghytkJzSGsSkwwU3
 07PjnKaUonerZBnBgEUU8B0hxTAVUfoe1oopbdktvzW8A2lG5Hljm/eccHBWrwK4tyLRzLTrr/8
 ZzVgXoIi9tQQvkCg5x5ssT7M66YqD22xXJ9WkrIGMqIEAxwJkkVbFokbiVUnlWvVZRt4nQ/qiEe
 GmMIloX/dm7y9BE+fLPPmnu86f3XTc763aPPQtEUOvO9+aV+W/xywduHB4FdlLAgE9GLEXc3/q9
 MM3z2XzWXoZPeVoZIDG0+au66QbfEM6IF2TUskMR4fNnKQLJ25GBORIklZU84mDvqRmLOJPpbE6
 Zk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add kernel-doc documentation for the proc_dointvec_conv function to
describe its parameters and return value.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2cd767b9680eb696efeae06f436548777b1b6844..b589f50d62854985c4c063232c95bd7590434738 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -862,6 +862,22 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos, 1l, 1l);
 }
 
+/**
+ * proc_dointvec_conv - read a vector of ints with a custom converter
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ * @conv: Custom converter call back
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) unsigned integer
+ * values from/to the user buffer, treated as an ASCII string. Negative
+ * strings are not allowed.
+ *
+ * Returns 0 on success
+ */
+
 int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 		       size_t *lenp, loff_t *ppos,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251215-jag-sysctl-doc-d3cb5bd14699

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



