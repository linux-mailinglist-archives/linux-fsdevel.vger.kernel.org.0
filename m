Return-Path: <linux-fsdevel+bounces-71532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 201B1CC67B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A8B305D9A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC11338914;
	Wed, 17 Dec 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fakWr4MQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFC28314B;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958738; cv=none; b=fKx0iE6oVKPc3xx0zAxlv7J+kCwRL9WY6UeO20C+ll+5i2wrglsJERiaMInuvL5I2S2IziD3zz3+92PMo0/L6valXIIz2bWP+C8i9q7BU/+jTTSeSXygsNydBvMRRabPSRAD4cFmwufWoXuphWvVTjVKRJVvZ4CyTkj3F0U8LGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958738; c=relaxed/simple;
	bh=7AHWEkJrCgJf28XDy4+AhvRex/rKi4omNUzr0zBfAyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xt0OhAHMG+AEY7aJ20wQ3H+3Bfd1uPTCw9XPriXFYQ5daIE8M27qh0uK+kwHNh8SgNpfX4bcECN4rjLS43aRzIduhWwg25l/qV7XK4PE1yjuOWs7VFGqNCbtaoYCv4RQxuUMPGyVyk3NQMjBDZrBcnxODSJyUQwD1Y2zSZtjXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fakWr4MQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6431C4CEFB;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958737;
	bh=7AHWEkJrCgJf28XDy4+AhvRex/rKi4omNUzr0zBfAyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fakWr4MQafVnxXTxibv+0KGF3+HADsyn38JdzgXEd9x5TYI2i4LG0zSI1jPcA6q8f
	 7sA/yhYp8xHBUVJykgWqhnySdILlQ6O5m1EaAoVW1p0aIQxgcCKMX88cHAkbQ5qYMa
	 cEmCqYYQaqABlstmw1W31RJ/0t+gnxjXzUe8H+Z5SIk4y3oRFPZvQPCdx33VAhvYDf
	 5+qh6Cenysbv4n7Il61pxiIYazJggkPik+32VurtQrbJg4UVYogi8a0YFN5mH6T7Y2
	 0W78sygPB63l39He8XRzYA6G2CbDbb3ZRqbdOqzskvRMJ59Dhg0zwfNTSXG0znvuB4
	 WmiKw5oEybFUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A053D6408C;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 17 Dec 2025 09:04:40 +0100
Subject: [PATCH 2/7] sysctl: clarify proc_douintvec_minmax doc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-jag-no-macro-conv-v1-2-6e4252687915@kernel.org>
References: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
In-Reply-To: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=7AHWEkJrCgJf28XDy4+AhvRex/rKi4omNUzr0zBfAyY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlCZEprGYwzIjqFXNIzbqWohf9ZpLvRFjfwm
 TXFxj+CeH2EjIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQmRKAAoJELqXzVK3
 lkFPOZIL/RVW9aA+XJmXx7Nf94T6ge8FNJCBqAchqK2bJHb4Q4ij3CzzUn8blh6DGYEx9zo+rIX
 pIIpyJUcV80eSZpSIyRjSobeU18erTqwXcjINtnRBXqdEWsKcOzwRpp42ijWSNZg5eMlRyPf21D
 JKLkkzNYTncImpOjs9kKP02sN3R8UMLzQg0Laq40lG3LXXFcE+zW8nF1MTo0nZMNbtDka5VFDuI
 AeUI2Qt00UFQZYPyhBqNcZlnS4U/ySiOpQWCeyhoitMwbszHC3LQxIhK3aOg8zW+KF0FqyPBvpY
 87RPUF2nz9g5ZcaxK5qZm5vUjNl2Nu2y48+GmaxKY3LgtGTSnVWcUA/cP2sjj3Rv1l12cwghBhZ
 eiuPN3qP8vvBakBeRdsXj1+A6V+EN3tFTl6wp5krSf1Kc9VvoA8e8OZ6zY7N0ZpIT7h+nM9s/Va
 mDeHPRc8l6IGhG1Nvtmk8TdgoX9GahvIcBKYAJXtmfOhUo4fbvNvrQ1A0Lnx+wiXWCpJ7pxFt85
 0U=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Specify that the range check is only when assigning kernel variable

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 84ca24fb1965e97dc9e6f71f42a6c99c01aca3ee..e82716b7c13840cadc3b19a7c9d05b167abebcf6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -692,10 +692,10 @@ int proc_dointvec_minmax(const struct ctl_table *table, int dir,
  * values from/to the user buffer, treated as an ASCII string. Negative
  * strings are not allowed.
  *
- * This routine will ensure the values are within the range specified by
- * table->extra1 (min) and table->extra2 (max). There is a final sanity
- * check for UINT_MAX to avoid having to support wrap around uses from
- * userspace.
+ * When changing the kernel variable, this routine will ensure the values
+ * are within the range specified by table->extra1 (min) and table->extra2
+ * (max). And Check that the values are less than UINT_MAX to avoid having to
+ * support wrap around uses from userspace.
  *
  * Returns 0 on success or -ERANGE when range check failes and
  * SYSCTL_USER_TO_KERN(dir) == true

-- 
2.50.1



