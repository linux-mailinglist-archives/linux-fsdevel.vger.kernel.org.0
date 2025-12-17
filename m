Return-Path: <linux-fsdevel+bounces-71534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB25CC67BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B2E43061D5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE4338F25;
	Wed, 17 Dec 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQshEOuA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62331B132;
	Wed, 17 Dec 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958738; cv=none; b=SryiyOh7weeMvAprQrvEOhLtmpJiGmomjBPsZ/ZxfoBsn6Dn4lRUJO5u+XHmJW/ertt5cL8yLCYL29iBcd+1mCDjn7Lty3aWfiUZjh0BOvckjFgBz8wzMS7no7MWgunKF1rakM1WSLlnCcZOhNNJImUUp6mRmqaIOiw0Nq922T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958738; c=relaxed/simple;
	bh=YsUYwAE1O8XtejvUjAcafWn1iQWbLefNUgR/xrWQ3dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mnvfc9+lYcNO4DotPgyb+oPLAoGD2XAQdSFl0tPm4cOIQ59lnyjx7qN+bh31Sz70hezfrrTVZLvQu6OZA0/XR0LrdWjrADFWWhI3EKe8YH6GzSuYkYqZeG69XderH2cRZ5xpMrQ9hADatt9q6gO90AhP0225HJFWN3Ub9F3hmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQshEOuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D24C2C2BCAF;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958737;
	bh=YsUYwAE1O8XtejvUjAcafWn1iQWbLefNUgR/xrWQ3dg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HQshEOuAaE5ZfS3lj3VpTrQk5znRIPpjCyoV7MEEB8LsFlhsb3tALcz8gnsNb/50F
	 KY2oCo4sghcytI+9mcUuOgkL3Lbdb0SYxhcUVRskx6Ubil4AOK9DvlnyGsYRDUcJD/
	 rI8iaw9bgpn7QJkR8vAZfTNLQNZZDNwchVe8LPi05uaCLEMkcp7fyuDKedVX+Dr4uL
	 WF3VbR1qeW4yajTnpqNcey6pa6nQsyakkJi2jrb7acxXMxNnUq/HnXleSvprpjEha+
	 gJJmIkZm6lOWsiGPdS/68qBTSjdXTHztajwoAcED6tYGpxEjKOxsuYZL8H2/Bih4vr
	 W+DPiVo8do1kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB68ED6408B;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 17 Dec 2025 09:04:43 +0100
Subject: [PATCH 5/7] sysctl: Add kernel doc to proc_douintvec_conv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-jag-no-macro-conv-v1-5-6e4252687915@kernel.org>
References: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
In-Reply-To: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=YsUYwAE1O8XtejvUjAcafWn1iQWbLefNUgR/xrWQ3dg=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlCZEzOIecMN2mx42bK519i1J7nELTWI7sEL
 8vcQkkuMTMRdIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQmRMAAoJELqXzVK3
 lkFPi0UL/3vdQEWjv9RF3GwEf0C6oGVt6CvLyQAEKEz5hafDHtD/ACZ6McjNPiSJuqNQ9RJaD9D
 rh5pttf2Gmw3oQxQJaFCHnqo9pqbsQcJ2vNMI+FFkgsLa/scTH0ZVcGzkyc7GHcJCWRQlbgk55X
 xRUlXR/tqA6QXbgwKAHpqgJ2Hx29l1UoQlNylceBRQextBkYIAC9/ObZlNEe/1dSBU4v71aQ2bg
 rsfJFljvsxvL4wqvMRBH1oGm8Aw47oznvDupXlpDPgi9R1+MlNlpvDKHU5px2R6XoQcDIOlQZPn
 Hq+fMnmG9kjegim7sBRG2vejBq2eD07VeDDJXh7ufwYzeWRya88hb/gqqFUJMGSwp9IGSWf+0DM
 BTghw5eiXfa9/VZQ/J02ne44FUL9tlJ+lrvC4foQrhSYStRVmE4SMjxUaYVx4p+3RmVtmOTAyJW
 hvznxv0s8MoGLjfCNYIXEKGbafKLeiqCuui5tzJeqcNkefGqqygjTcyHX0jOxb0Cc1bTc/lw1U4
 KQ=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

This commit is making sure that all the functions that are part of the
API are documented.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5901196a52f98cdd5aba4f50899a58d9bd9d10f9..ed2701acc89821e724b5697665f8a795dff8097d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -656,6 +656,22 @@ static int do_proc_douintvec(const struct ctl_table *table, int dir,
 	return do_proc_douintvec_r(table, buffer, lenp, ppos, conv);
 }
 
+/**
+ * proc_douintvec_conv - read a vector of unsigned ints with a custom converter
+ *
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
 int proc_douintvec_conv(const struct ctl_table *table, int dir, void *buffer,
 			size_t *lenp, loff_t *ppos,
 			int (*conv)(unsigned long *u_ptr, unsigned int *k_ptr,

-- 
2.50.1



