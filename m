Return-Path: <linux-fsdevel+bounces-61788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DBAB59DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3984E5B68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F8231E883;
	Tue, 16 Sep 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DrvgrNFT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DyLDMbzc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1462F2612;
	Tue, 16 Sep 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040405; cv=none; b=mM8d2QFtG6N6anE9dvCdyeDQv37/GACKuityKo6vxPQhSEesaAWBCOxkoF+Md4o1RgeEnwrAf/cGqpqTNvE2QXgLj7VSKgWl6efkt7u/MWrI7/09jYWAfXhGb8pUL8pcFY2iX+35pkV4qNmLOwwv45V8ExkfqblVlij2wOiEDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040405; c=relaxed/simple;
	bh=/E1ackxbc77ZJbDwQp8PQvOGdLQElttCXc0w52nzIRA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ya5fjsvy/tBU5BLRG3MCOJKSiAI8TSuxHrqN9eujuxxTI4elZf5bPlA5bZgyhGKb9PjNxf3vOObcwXw1MZeg/nGCdmSLXLOb1kI6kogmeNwjiM47mhyq5Yab7WzXvsDolmjA5lwhByO8Qmy5/TI22TZIzEGZznuodABFWUn6Zks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DrvgrNFT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DyLDMbzc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250916163252.354989948@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758040400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W1zu4x4fa5rvVrKhE+/ECo02MeVuSwO/q/d1on1UR7Q=;
	b=DrvgrNFTGKmj1+43NZd+59JIHNOiW1+82xk29dQVGLRESoUBR427aucz0yd06GAO3ZXTsJ
	eU1LF2RodVVnrqxgxb+ojC6o0Spr5OQPrmUX81VtyKrcjbcu3MvDyY6CET6AU1FiRnOjGQ
	gggVYH+wPfA6u4HcUJwelw7Nho73XXrTRQfLwWrdu8ySB6rlCfhk/3xQzq6qfedP2AmJqk
	qm6MzFyTfWdB9+/4pGAeP9hN5siip8u1dFcMwnFE3hWsK60oZLHpsB3xZzMr48q/Q3/mRm
	Cgdk0L33jkVzqfhm2CqTT8ELZcXFn8JmWRYqwzIBMiQJJKPIgCwiNsdavmz7Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758040400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W1zu4x4fa5rvVrKhE+/ECo02MeVuSwO/q/d1on1UR7Q=;
	b=DyLDMbzcLtTlwrEoG8vlXwT6jPbP+53jHDPa6qdnCJa8xkn/9bwrAuXgUVftBZAoFY0j+B
	f4sxKunptF6qF8BA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 x86@kernel.org
Subject: [patch V2 6/6] select: Convert to scoped masked user access
References: <20250916163004.674341701@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 18:33:19 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Replace the open coded implementation with the scoped masked user access
mechanism.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/select.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)
---
--- a/fs/select.c
+++ b/fs/select.c
@@ -776,18 +776,12 @@ static inline int get_sigset_argpack(str
 {
 	// the path is hot enough for overhead of copy_from_user() to matter
 	if (from) {
-		if (can_do_masked_user_access())
-			from = masked_user_access_begin(from);
-		else if (!user_read_access_begin(from, sizeof(*from)))
-			return -EFAULT;
-		unsafe_get_user(to->p, &from->p, Efault);
-		unsafe_get_user(to->size, &from->size, Efault);
-		user_read_access_end();
+		scoped_masked_user_rw_access(from, return -EFAULT, {
+			scoped_get_user(to->p, &from->p);
+			scoped_get_user(to->size, &from->size);
+		});
 	}
 	return 0;
-Efault:
-	user_read_access_end();
-	return -EFAULT;
 }
 
 SYSCALL_DEFINE6(pselect6, int, n, fd_set __user *, inp, fd_set __user *, outp,


