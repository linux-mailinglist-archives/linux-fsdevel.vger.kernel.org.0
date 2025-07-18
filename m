Return-Path: <linux-fsdevel+bounces-55404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C09B09CFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 09:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C3F7AD21D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04FE2949E5;
	Fri, 18 Jul 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3JJsSPi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUWXlenx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5509292B50;
	Fri, 18 Jul 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825166; cv=none; b=BhbMPqGwE5zAa7QW7o9mmEo7/zpz1QMRyI1mXrUI9f2H9vwRRvYkKQ0omM3VoatKgtdNgS1bYeSMDm3u1Saj4s9ZTX0mjDHWEcThu21C2e0ljKpYPaWN8jHOY0a+vkSz9zTz9eYdk9vFqJxmMY4zq/ajqNi6aLhuI8JhhZT7juU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825166; c=relaxed/simple;
	bh=If6nvlARjBBLLOjsIdWNzsD8ZBKZ++97S3/OQnhAMe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqM+o5wf4GqNDLSjo2+2MeVAGZuLPJly9rDLD5c12xbHrxn36F5YVcTAnt6nQoNF0SuGjEIgISOP2OpApIEzwPVOI3Y/9VigwTWg6mi9MXaIP5gYprT9pBJTpKsibOfL4Q5s82ZajIqhJxvT3n7QD6VyOUINdHjHm8xwpoC75BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3JJsSPi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUWXlenx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752825161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2AY1K2KFKiGv6RYEA/Ls+yWTzlUHJhYLFDSPddq6Xs=;
	b=a3JJsSPi/3WFT8Wnw6e1gLP0QLbAqrnggabFYoK0peqeCglNET5tCLW5OlHMhmT9KlQWAb
	kk4qWhqBnpnAK22Q3sPVPS3L6UNwiw/IaNnKlP5kfltdg74xUGDonLAozbdoS41qsf31R7
	Bpm+z7EmIm9kM7LlBlKCkH3nxPKCrcD/mVfuvn+HV5BPuVB/jubyX6rFPnc4EGaRUPtezJ
	Jl8GMlLUa0YTmZPTgGLNLJ6dzR+EHGSWxujXjoM/fX73VW5W3RQRq1X4VKPcAJVI0lBHWd
	PLMyOH9kG5YHg1F/UdRmJIMjpQrVVVwECzSRdzb2sNEfg7VK5mrVZ3OvpQ8SBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752825161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2AY1K2KFKiGv6RYEA/Ls+yWTzlUHJhYLFDSPddq6Xs=;
	b=MUWXlenxwlncp7WJg4OzcK1dPrvJqGvcUVBVjrPUVpimWr3RMvIRo7JDnTqw35Ve2HoHzd
	tRFnSYD8TRyyWeAw==
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Khazhismel Kumykov <khazhy@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Date: Fri, 18 Jul 2025 09:52:29 +0200
Message-Id: <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
In-Reply-To: <cover.1752824628.git.namcao@linutronix.de>
References: <cover.1752824628.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ep_events_available() checks for available events by looking at ep->rdllist
and ep->ovflist. However, this is done without a lock, therefore the
returned value is not reliable. Because it is possible that both checks on
ep->rdllist and ep->ovflist are false while ep_start_scan() or
ep_done_scan() is being executed on other CPUs, despite events are
available.

This bug can be observed by:

  1. Create an eventpoll with at least one ready level-triggered event

  2. Create multiple threads who do epoll_wait() with zero timeout. The
     threads do not consume the events, therefore all epoll_wait() should
     return at least one event.

If one thread is executing ep_events_available() while another thread is
executing ep_start_scan() or ep_done_scan(), epoll_wait() may wrongly
return no event for the former thread.

This reproducer is implemented as TEST(epoll65) in
tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c

Fix it by skipping ep_events_available(), just call ep_try_send_events()
directly.

epoll_sendevents() (io_uring) suffers the same problem, fix that as well.

There is still ep_busy_loop() who uses ep_events_available() without lock,
but it is probably okay (?) for busy-polling.

Fixes: c5a282e9635e ("fs/epoll: reduce the scope of wq lock in epoll_wait()=
")
Fixes: e59d3c64cba6 ("epoll: eliminate unnecessary lock for zero timeout")
Fixes: ae3a4f1fdc2c ("eventpoll: add epoll_sendevents() helper")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 fs/eventpoll.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0fbf5dfedb24..541481eafc20 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2022,7 +2022,7 @@ static int ep_schedule_timeout(ktime_t *to)
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		   int maxevents, struct timespec64 *timeout)
 {
-	int res, eavail, timed_out =3D 0;
+	int res, eavail =3D 1, timed_out =3D 0;
 	u64 slack =3D 0;
 	wait_queue_entry_t wait;
 	ktime_t expires, *to =3D NULL;
@@ -2041,16 +2041,6 @@ static int ep_poll(struct eventpoll *ep, struct epol=
l_event __user *events,
 		timed_out =3D 1;
 	}
=20
-	/*
-	 * This call is racy: We may or may not see events that are being added
-	 * to the ready list under the lock (e.g., in IRQ callbacks). For cases
-	 * with a non-zero timeout, this thread will check the ready list under
-	 * lock and will add to the wait queue.  For cases with a zero
-	 * timeout, the user by definition should not care and will have to
-	 * recheck again.
-	 */
-	eavail =3D ep_events_available(ep);
-
 	while (1) {
 		if (eavail) {
 			res =3D ep_try_send_events(ep, events, maxevents);
@@ -2496,9 +2486,7 @@ int epoll_sendevents(struct file *file, struct epoll_=
event __user *events,
 	 * Racy call, but that's ok - it should get retried based on
 	 * poll readiness anyway.
 	 */
-	if (ep_events_available(ep))
-		return ep_try_send_events(ep, events, maxevents);
-	return 0;
+	return ep_try_send_events(ep, events, maxevents);
 }
=20
 /*
--=20
2.39.5


