Return-Path: <linux-fsdevel+bounces-67650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 001F7C45AFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 421D34EB34C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F393002DE;
	Mon, 10 Nov 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDJeMr+h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vItDkgjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8583002D8;
	Mon, 10 Nov 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767540; cv=none; b=PurYG7/U2RE4d6mLV6Gl0lNepBNbGZWMLEAJo+xk5fGocIg6O+fVjUYi/GtpjTCniH7fJUZPbjX4ralWnJAcDEvFPy+bpVfXipA2tCcfwBQ99lDw0yGrf0gnt8ZZ05sJ8alWdCmla3CbJPK/HZ4bgKxsru/RbPYi+Q4NROmebG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767540; c=relaxed/simple;
	bh=vkQbQL+fJLDoQe1yfJrWlSGuxIfP4tu1ti+GMV7LTmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqyBKtiQCMiMysI2djQKjVEn3kGCh1QP8jRtUevZGJiVYejHDyc0NxBSH0ejyJmDUQh0y8k8uDi9DLKqjxuwjO7lXo9ylZKXVhzCQOw54PeMLGue1+IfSzYfloHQBkwkeMvneSAJ4sMFv84A6TfFAekHiZpkKnFD2Z6vupmuhQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDJeMr+h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vItDkgjN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762767535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THBOENMBX3/kGNmeeescI7EjAzMQdi8L4W9xrwS6vPU=;
	b=LDJeMr+hSTLr9uGlHydNJHaUV667Y+iv9eec8/42GssXcHNFA3VcC+q9P3WN43qoCBw036
	Hj93QhPbzYBSRfgPnc/WbI8ZK+ZCKoqJIlVP+ux5gTdm4jNRMBxvRKubKbWEnlO2HcEuLe
	NtnGy2VtVp7gLtNzIOSwbKQOxczPzt9Wq+ipn0qiNGlkzY4hgqeAe8dmDpNVcekHzNISph
	n2cwJuv5Gux5BTmLubUuSloFNKfQwAZerXDpIqPXYAL3jiU4VYAyYxZhsj16i/fbP8uNYC
	5fDTpgnY1z8+ljT98JxCdwAqaCeqHEUIb/3N/wHXxD3fPeMgIoSPGVWE61vcKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762767535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THBOENMBX3/kGNmeeescI7EjAzMQdi8L4W9xrwS6vPU=;
	b=vItDkgjNDxT7W4bHtaw8mEs4X8IMyxwxTBJDAVJj8uDKi8BYhXBu4giNwnSKQbCh2Qtqrm
	3OaOomVpwvu0/lDg==
Date: Mon, 10 Nov 2025 10:38:52 +0100
Subject: [PATCH 2/3] futex: Store time as ktime_t in restart block
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-restart-block-expiration-v1-2-5d39cc93df4f@linutronix.de>
References: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
In-Reply-To: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762767533; l=1576;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vkQbQL+fJLDoQe1yfJrWlSGuxIfP4tu1ti+GMV7LTmE=;
 b=IXUzglx4ZSMgLN+0iO4o150g7yd2qJM5tgWVF7kL12Hx3YTdkUzE2KAOVjRWzaa43BgPVXHQd
 x6lmblEpeZPANxpQeHqnO32HujDMnpVqOc8V5cSq4Wci9AMZu7uCsuu
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The futex core uses ktime_t to represent times,
use that also for the restart block.

This also allows the simplification of the accessors.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/restart_block.h | 2 +-
 kernel/futex/waitwake.c       | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 0798a4ae67c6c75749c38c4673ab8ea012261319..3c2bd13f609120a8a914f6e738ffea97bf72c32d 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -33,7 +33,7 @@ struct restart_block {
 			u32 val;
 			u32 flags;
 			u32 bitset;
-			u64 time;
+			ktime_t time;
 			u32 __user *uaddr2;
 		} futex;
 		/* For nanosleep */
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index e2bbe5509ec27a18785227358d4ff8d8f913ddc1..1c2dd03f11ec4e5d34d1a9f67ef01e05604b3bac 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -738,12 +738,11 @@ int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time
 static long futex_wait_restart(struct restart_block *restart)
 {
 	u32 __user *uaddr = restart->futex.uaddr;
-	ktime_t t, *tp = NULL;
+	ktime_t *tp = NULL;
+
+	if (restart->futex.flags & FLAGS_HAS_TIMEOUT)
+		tp = &restart->futex.time;
 
-	if (restart->futex.flags & FLAGS_HAS_TIMEOUT) {
-		t = restart->futex.time;
-		tp = &t;
-	}
 	restart->fn = do_no_restart_syscall;
 
 	return (long)futex_wait(uaddr, restart->futex.flags,

-- 
2.51.0


