Return-Path: <linux-fsdevel+bounces-19046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA18BF9C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666031C22378
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603278C98;
	Wed,  8 May 2024 09:47:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989163613C;
	Wed,  8 May 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161673; cv=none; b=i2rvEAZtf0xihFM91of3Fi0iKDsHLpOrdoFDrfmMmoeQ3bRVaFl7A0Svf2GDr5xHkDexCIpY+fUaljOI+skW07cH4Cfjz6/Rbn2/WTbqIvN8DeiDh5CHNgNJ7UVF6OPDC6zXKe6YNCNPNP1PumCDsTZ7yt35hoX4kmqqlpodK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161673; c=relaxed/simple;
	bh=Smsc/UzDl3/jK/dEYNi0KPrzkpNTVo3i0D8H9H66qB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SbNRd7YlgBgLYa+o69gNre0oAbUN618esnjc1Ub9gSN0uTviLXLFOBxtBBZ19qr3kX5jAlYFkNUnCmGpPxXDg9ehpLv6wgli8/aSHu4YC/2eCyfKfcDnQpM5BLChydY717KPz0y5wTpuHEOH5lt11qColU8OcBV4SDfWuE/yHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-cc-663b4a3b893a
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v14 27/28] dept: Add documentation for Dept
Date: Wed,  8 May 2024 18:47:24 +0900
Message-Id: <20240508094726.35754-28-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/Pc8/zdHU8O8yjTHYklAjx8dtseLQZ4y9seNRTHV3soh82
	W+mH/Dgrdv04jX7tahVXd02F45yVTlOpUFRLNbR+ka5JkSv889lrn89r78/njw9DyMslrowy
	7JyoDhNCFZSUlA64ZK/c4r85aHW+YRakXF8N9pEkEjINxRQ03C9CUFwWi6G3ag+8G+1HMP6q
	noA0bQOC7I/tBJRVdyAwF1yioKlnJjTbhyiwaa9REJdroOB13wSGttSbGIqM+6A2OQeDZewz
	CWm9FNxOi8OO8gXDmL6QBn2MB3QV6GiY+OgLto63EjC/94KMO20UPDbbSKiu6MLQ9DCTgo7i
	SQnUVteQ0JCikcC9wRwK+kb1BOjtQzQ0WrIwlMQ7ghK//5bAC40FQ2JeKYbm1kcIniR1YjAW
	v6Xgub0fg8moJeBnfhWCrhsDNCRcH6PhduwNBNcSUkmIb/OD8R+Z1I6N/PP+IYKPN0Xy5tEs
	kn+Zw/GVunaaj3/ynuazjOd5U8EKPvdxL+azh+0S3lh4heKNwzdp/upAM+YH6+poviZ9nOR7
	mtPwAdcj0i2BYqgyQlSv2nZCGvIyxY7OfjOhKEvqLRyDLHHoKnJiOHYdV2/vlvznou671BRT
	rCfX0jJGTPEcdhFn0nyadgi2X8rl1e2e4tnsZu7Du+/TPsl6cI1NyeQUy9j13FB6N/03050r
	KrFM5zg5+q2fB6f3ylk/7lGczuFIHc4kw1kN+f8Oms89K2ghk5EsC80oRHJlWIRKUIau8wmJ
	DlNG+QScURmR4530FyeOVqDhhkNWxDJI4SKzzNsUJJcIEeHRKiviGEIxR1Z1eUOQXBYoRF8Q
	1WeOq8+HiuFW5MaQinmyNaORgXI2WDgnnhbFs6L6/xQzTq4xyH//129rnWxzy0fSvQ8+PeWt
	a889jp3F9JMrO+WXUkvvPNi7U1je5bb7TWZbY6e8JrDSM1hbxh2MYDI2qjZ5LbBVsrG+USfN
	i/Nm+6z5vUszvj326IMyrXbJz8u/ApDOO+DNha3uSxeaa5dpBPPkfmvrMa/Xns6qakPlroTD
	eLF7r4IMDxF8VxDqcOEP/Yf+h0oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe573NmeLl2X5pkGxkGphF9I6NIsoyIeg6EMRVGSrXnWkJluu
	7ELW1K6Ky6ZlatNkiTOtLWilk6Fo2sWWjrxkUna1zFE60ZTKGX05/Pifw+//5Ugo+XUmRKJJ
	OiJqk9QJClZKS7eqDOGqzarY5R+9EWC8vBx8w+dpKKyuZMFdZUVQef8Mhv7GaOgYGUAw/vwF
	BfkmN4KSd28ouN/Ui8BZfpaF9g8zwOPzstBiusSC4VY1Cy+/TWDoybuCwWrbAk9zSjG4xj7T
	kN/Pwo18A54cXzCMWSo4sKSFQV95AQcT71ZAS+8rBhqKWhhwdi+B68U9LNQ6W2hocvRhaH9U
	yEJv5R8GnjY10+A2ZjFwZ7CUhW8jFgosPi8HbS4zhrvpk7bMod8MPM5yYcgsu4fB01WDoO78
	Wwy2ylcsNPgGMNhtJgp+3W5E0Jf9nYOMy2Mc3DiTjeBSRh4N6T2RMD5ayK5fQxoGvBRJtx8l
	zhEzTZ6UCuRhwRuOpNd1c8RsSyH2ciW5VduPSclPH0NsFRdYYvt5hSMXv3swGWxt5UjztXGa
	fPDk422hu6RRB8UEjV7ULlu3Txr/xOhDyT/s6JgrLxenIZcBXUQBEoGPEKzvb7J+ZvmFQmfn
	GOXnIH6+YM/6xPiZ4gekQlnrJj/P5FXC646hqXuaDxPa2nNoP8v4VYL32nvun3OeYL3rmvIE
	TOZdnwenuuR8pFBjKOBykNSMplWgIE2SPlGtSYhcqjsUn5qkObb0wOFEG5p8GMupCaMDDbdH
	1yNeghTTZW5WFStn1HpdamI9EiSUIkjWeG51rFx2UJ16XNQejtGmJIi6ehQqoRXBss07xX1y
	Pk59RDwkismi9v8WSwJC0tDtq6mkNSNQ/gyq5yzu9LpPmxpTZKfXXp2rLNtj5O9F6T8y8aPm
	cGUyc+518979P3bME9doNm4w5Xm2x9i/nsjujt5bFPjYrS+hdbtXOnK1Qw/0Ef21+uC1q61t
	YbnKUKGquG2WIyrSaV0ZNlvpkBToZ5ctyIwLPrnoxPpZ0xY0KGhdvHqFktLq1H8BjgJwCiwD
	AAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

This document describes the concept of Dept.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 Documentation/dependency/dept.txt | 735 ++++++++++++++++++++++++++++++
 1 file changed, 735 insertions(+)
 create mode 100644 Documentation/dependency/dept.txt

diff --git a/Documentation/dependency/dept.txt b/Documentation/dependency/dept.txt
new file mode 100644
index 000000000000..5dd358b96734
--- /dev/null
+++ b/Documentation/dependency/dept.txt
@@ -0,0 +1,735 @@
+DEPT(DEPendency Tracker)
+========================
+
+Started by Byungchul Park <max.byungchul.park@sk.com>
+
+How lockdep works
+-----------------
+
+Lockdep detects a deadlock by checking lock acquisition order. For
+example, a graph to track acquisition order built by lockdep might look
+like:
+
+   A -> B -
+           \
+            -> E
+           /
+   C -> D -
+
+   where 'A -> B' means that acquisition A is prior to acquisition B
+   with A still held.
+
+Lockdep keeps adding each new acquisition order into the graph in
+runtime. For example, 'E -> C' will be added when the two locks have
+been acquired in the order, E and then C. The graph will look like:
+
+       A -> B -
+               \
+                -> E -
+               /      \
+    -> C -> D -        \
+   /                   /
+   \                  /
+    ------------------
+
+   where 'A -> B' means that acquisition A is prior to acquisition B
+   with A still held.
+
+This graph contains a subgraph that demonstrates a loop like:
+
+                -> E -
+               /      \
+    -> C -> D -        \
+   /                   /
+   \                  /
+    ------------------
+
+   where 'A -> B' means that acquisition A is prior to acquisition B
+   with A still held.
+
+Lockdep reports it as a deadlock on detection of a loop and stops its
+working.
+
+CONCLUSION
+
+Lockdep detects a deadlock by checking if a loop has been created after
+adding a new acquisition order into the graph.
+
+
+Limitation of lockdep
+---------------------
+
+Lockdep deals with a deadlock by typical lock e.g. spinlock and mutex,
+that are supposed to be released within the acquisition context. However,
+when it comes to a deadlock by folio lock that is not supposed to be
+released within the acquisition context or other general synchronization
+mechanisms, lockdep doesn't work.
+
+Can lockdep detect the following deadlock?
+
+   context X	   context Y	   context Z
+
+		   mutex_lock A
+   folio_lock B
+		   folio_lock B <- DEADLOCK
+				   mutex_lock A <- DEADLOCK
+				   folio_unlock B
+		   folio_unlock B
+		   mutex_unlock A
+				   mutex_unlock A
+
+No. What about the following?
+
+   context X		   context Y
+
+			   mutex_lock A
+   mutex_lock A <- DEADLOCK
+			   wait_for_complete B <- DEADLOCK
+   complete B
+			   mutex_unlock A
+   mutex_unlock A
+
+No.
+
+CONCLUSION
+
+Lockdep cannot detect a deadlock by folio lock or other general
+synchronization mechanisms.
+
+
+What leads a deadlock
+---------------------
+
+A deadlock occurs when one or multi contexts are waiting for events that
+will never happen. For example:
+
+   context X	   context Y	   context Z
+
+   |		   |		   |
+   v		   |		   |
+   1 wait for A    v		   |
+   .		   2 wait for C    v
+   event C	   .		   3 wait for B
+		   event B	   .
+				   event A
+
+Event C cannot be triggered because context X is stuck at 1, event B
+cannot be triggered because context Y is stuck at 2, and event A cannot
+be triggered because context Z is stuck at 3. All the contexts are stuck.
+We call this *deadlock*.
+
+If an event occurrence is a prerequisite to reaching another event, we
+call it *dependency*. In this example:
+
+   Event A occurrence is a prerequisite to reaching event C.
+   Event C occurrence is a prerequisite to reaching event B.
+   Event B occurrence is a prerequisite to reaching event A.
+
+In terms of dependency:
+
+   Event C depends on event A.
+   Event B depends on event C.
+   Event A depends on event B.
+
+Dependency graph reflecting this example will look like:
+
+    -> C -> A -> B -
+   /                \
+   \                /
+    ----------------
+
+   where 'A -> B' means that event A depends on event B.
+
+A circular dependency exists. Such a circular dependency leads a
+deadlock since no waiters can have desired events triggered.
+
+CONCLUSION
+
+A circular dependency of events leads a deadlock.
+
+
+Introduce DEPT
+--------------
+
+DEPT(DEPendency Tracker) tracks wait and event instead of lock
+acquisition order so as to recognize the following situation:
+
+   context X	   context Y	   context Z
+
+   |		   |		   |
+   v		   |		   |
+   wait for A	   v		   |
+   .		   wait for C	   v
+   event C	   .		   wait for B
+		   event B	   .
+				   event A
+
+and builds up a dependency graph in runtime that is similar to lockdep.
+The graph might look like:
+
+    -> C -> A -> B -
+   /                \
+   \                /
+    ----------------
+
+   where 'A -> B' means that event A depends on event B.
+
+DEPT keeps adding each new dependency into the graph in runtime. For
+example, 'B -> D' will be added when event D occurrence is a
+prerequisite to reaching event B like:
+
+   |
+   v
+   wait for D
+   .
+   event B
+
+After the addition, the graph will look like:
+
+                     -> D
+                    /
+    -> C -> A -> B -
+   /                \
+   \                /
+    ----------------
+
+   where 'A -> B' means that event A depends on event B.
+
+DEPT is going to report a deadlock on detection of a new loop.
+
+CONCLUSION
+
+DEPT works on wait and event so as to theoretically detect all the
+potential deadlocks.
+
+
+How DEPT works
+--------------
+
+Let's take a look how DEPT works with the 1st example in the section
+'Limitation of lockdep'.
+
+   context X	   context Y	   context Z
+
+		   mutex_lock A
+   folio_lock B
+		   folio_lock B <- DEADLOCK
+				   mutex_lock A <- DEADLOCK
+				   folio_unlock B
+		   folio_unlock B
+		   mutex_unlock A
+				   mutex_unlock A
+
+Adding comments to describe DEPT's view in terms of wait and event:
+
+   context X	   context Y	   context Z
+
+		   mutex_lock A
+		   /* wait for A */
+   folio_lock B
+   /* wait for A */
+   /* start event A context */
+
+		   folio_lock B
+		   /* wait for B */ <- DEADLOCK
+		   /* start event B context */
+
+				   mutex_lock A
+				   /* wait for A */ <- DEADLOCK
+				   /* start event A context */
+
+				   folio_unlock B
+				   /* event B */
+		   folio_unlock B
+		   /* event B */
+
+		   mutex_unlock A
+		   /* event A */
+				   mutex_unlock A
+				   /* event A */
+
+Adding more supplementary comments to describe DEPT's view in detail:
+
+   context X	   context Y	   context Z
+
+		   mutex_lock A
+		   /* might wait for A */
+		   /* start to take into account event A's context */
+		   /* 1 */
+   folio_lock B
+   /* might wait for B */
+   /* start to take into account event B's context */
+   /* 2 */
+
+		   folio_lock B
+		   /* might wait for B */ <- DEADLOCK
+		   /* start to take into account event B's context */
+		   /* 3 */
+
+				   mutex_lock A
+				   /* might wait for A */ <- DEADLOCK
+				   /* start to take into account
+				      event A's context */
+				   /* 4 */
+
+				   folio_unlock B
+				   /* event B that's been valid since 2 */
+		   folio_unlock B
+		   /* event B that's been valid since 3 */
+
+		   mutex_unlock A
+		   /* event A that's been valid since 1 */
+
+				   mutex_unlock A
+				   /* event A that's been valid since 4 */
+
+Let's build up dependency graph with this example. Firstly, context X:
+
+   context X
+
+   folio_lock B
+   /* might wait for B */
+   /* start to take into account event B's context */
+   /* 2 */
+
+There are no events to create dependency. Next, context Y:
+
+   context Y
+
+   mutex_lock A
+   /* might wait for A */
+   /* start to take into account event A's context */
+   /* 1 */
+
+   folio_lock B
+   /* might wait for B */
+   /* start to take into account event B's context */
+   /* 3 */
+
+   folio_unlock B
+   /* event B that's been valid since 3 */
+
+   mutex_unlock A
+   /* event A that's been valid since 1 */
+
+There are two events. For event B, folio_unlock B, since there are no
+waits between 3 and the event, event B does not create dependency. For
+event A, there is a wait, folio_lock B, between 1 and the event. Which
+means event A cannot be triggered if event B does not wake up the wait.
+Therefore, we can say event A depends on event B, say, 'A -> B'. The
+graph will look like after adding the dependency:
+
+   A -> B
+
+   where 'A -> B' means that event A depends on event B.
+
+Lastly, context Z:
+
+   context Z
+
+   mutex_lock A
+   /* might wait for A */
+   /* start to take into account event A's context */
+   /* 4 */
+
+   folio_unlock B
+   /* event B that's been valid since 2 */
+
+   mutex_unlock A
+   /* event A that's been valid since 4 */
+
+There are also two events. For event B, folio_unlock B, there is a
+wait, mutex_lock A, between 2 and the event - remind 2 is at a very
+start and before the wait in timeline. Which means event B cannot be
+triggered if event A does not wake up the wait. Therefore, we can say
+event B depends on event A, say, 'B -> A'. The graph will look like
+after adding the dependency:
+
+    -> A -> B -
+   /           \
+   \           /
+    -----------
+
+   where 'A -> B' means that event A depends on event B.
+
+A new loop has been created. So DEPT can report it as a deadlock. For
+event A, mutex_unlock A, since there are no waits between 4 and the
+event, event A does not create dependency. That's it.
+
+CONCLUSION
+
+DEPT works well with any general synchronization mechanisms by focusing
+on wait, event and its context.
+
+
+Interpret DEPT report
+---------------------
+
+The following is the example in the section 'How DEPT works'.
+
+   context X	   context Y	   context Z
+
+		   mutex_lock A
+		   /* might wait for A */
+		   /* start to take into account event A's context */
+		   /* 1 */
+   folio_lock B
+   /* might wait for B */
+   /* start to take into account event B's context */
+   /* 2 */
+
+		   folio_lock B
+		   /* might wait for B */ <- DEADLOCK
+		   /* start to take into account event B's context */
+		   /* 3 */
+
+				   mutex_lock A
+				   /* might wait for A */ <- DEADLOCK
+				   /* start to take into account
+				      event A's context */
+				   /* 4 */
+
+				   folio_unlock B
+				   /* event B that's been valid since 2 */
+		   folio_unlock B
+		   /* event B that's been valid since 3 */
+
+		   mutex_unlock A
+		   /* event A that's been valid since 1 */
+
+				   mutex_unlock A
+				   /* event A that's been valid since 4 */
+
+We can Simplify this by replacing each waiting point with [W], each
+point where its event's context starts with [S] and each event with [E].
+This example will look like after the replacement:
+
+   context X	   context Y	   context Z
+
+		   [W][S] mutex_lock A
+   [W][S] folio_lock B
+		   [W][S] folio_lock B <- DEADLOCK
+
+				   [W][S] mutex_lock A <- DEADLOCK
+				   [E] folio_unlock B
+		   [E] folio_unlock B
+		   [E] mutex_unlock A
+				   [E] mutex_unlock A
+
+DEPT uses the symbols [W], [S] and [E] in its report as described above.
+The following is an example reported by DEPT for a real problem.
+
+   Link: https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
+   Link: https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
+
+   ===================================================
+   DEPT: Circular dependency has been detected.
+   6.2.0-rc1-00025-gb0c20ebf51ac-dirty #28 Not tainted
+   ---------------------------------------------------
+   summary
+   ---------------------------------------------------
+   *** DEADLOCK ***
+
+   context A
+       [S] lock(&ni->ni_lock:0)
+       [W] folio_wait_bit_common(PG_locked_map:0)
+       [E] unlock(&ni->ni_lock:0)
+
+   context B
+       [S] (unknown)(PG_locked_map:0)
+       [W] lock(&ni->ni_lock:0)
+       [E] folio_unlock(PG_locked_map:0)
+
+   [S]: start of the event context
+   [W]: the wait blocked
+   [E]: the event not reachable
+   ---------------------------------------------------
+   context A's detail
+   ---------------------------------------------------
+   context A
+       [S] lock(&ni->ni_lock:0)
+       [W] folio_wait_bit_common(PG_locked_map:0)
+       [E] unlock(&ni->ni_lock:0)
+
+   [S] lock(&ni->ni_lock:0):
+   [<ffffffff82b396fb>] ntfs3_setattr+0x54b/0xd40
+   stacktrace:
+         ntfs3_setattr+0x54b/0xd40
+         notify_change+0xcb3/0x1430
+         do_truncate+0x149/0x210
+         path_openat+0x21a3/0x2a90
+         do_filp_open+0x1ba/0x410
+         do_sys_openat2+0x16d/0x4e0
+         __x64_sys_creat+0xcd/0x120
+         do_syscall_64+0x41/0xc0
+         entry_SYSCALL_64_after_hwframe+0x63/0xcd
+
+   [W] folio_wait_bit_common(PG_locked_map:0):
+   [<ffffffff81b228b0>] truncate_inode_pages_range+0x9b0/0xf20
+   stacktrace:
+         folio_wait_bit_common+0x5e0/0xaf0
+         truncate_inode_pages_range+0x9b0/0xf20
+         truncate_pagecache+0x67/0x90
+         ntfs3_setattr+0x55a/0xd40
+         notify_change+0xcb3/0x1430
+         do_truncate+0x149/0x210
+         path_openat+0x21a3/0x2a90
+         do_filp_open+0x1ba/0x410
+         do_sys_openat2+0x16d/0x4e0
+         __x64_sys_creat+0xcd/0x120
+         do_syscall_64+0x41/0xc0
+         entry_SYSCALL_64_after_hwframe+0x63/0xcd
+
+   [E] unlock(&ni->ni_lock:0):
+   (N/A)
+   ---------------------------------------------------
+   context B's detail
+   ---------------------------------------------------
+   context B
+       [S] (unknown)(PG_locked_map:0)
+       [W] lock(&ni->ni_lock:0)
+       [E] folio_unlock(PG_locked_map:0)
+
+   [S] (unknown)(PG_locked_map:0):
+   (N/A)
+
+   [W] lock(&ni->ni_lock:0):
+   [<ffffffff82b009ec>] attr_data_get_block+0x32c/0x19f0
+   stacktrace:
+         attr_data_get_block+0x32c/0x19f0
+         ntfs_get_block_vbo+0x264/0x1330
+         __block_write_begin_int+0x3bd/0x14b0
+         block_write_begin+0xb9/0x4d0
+         ntfs_write_begin+0x27e/0x480
+         generic_perform_write+0x256/0x570
+         __generic_file_write_iter+0x2ae/0x500
+         ntfs_file_write_iter+0x66d/0x1d70
+         do_iter_readv_writev+0x20b/0x3c0
+         do_iter_write+0x188/0x710
+         vfs_iter_write+0x74/0xa0
+         iter_file_splice_write+0x745/0xc90
+         direct_splice_actor+0x114/0x180
+         splice_direct_to_actor+0x33b/0x8b0
+         do_splice_direct+0x1b7/0x280
+         do_sendfile+0xb49/0x1310
+
+   [E] folio_unlock(PG_locked_map:0):
+   [<ffffffff81f10222>] generic_write_end+0xf2/0x440
+   stacktrace:
+         generic_write_end+0xf2/0x440
+         ntfs_write_end+0x42e/0x980
+         generic_perform_write+0x316/0x570
+         __generic_file_write_iter+0x2ae/0x500
+         ntfs_file_write_iter+0x66d/0x1d70
+         do_iter_readv_writev+0x20b/0x3c0
+         do_iter_write+0x188/0x710
+         vfs_iter_write+0x74/0xa0
+         iter_file_splice_write+0x745/0xc90
+         direct_splice_actor+0x114/0x180
+         splice_direct_to_actor+0x33b/0x8b0
+         do_splice_direct+0x1b7/0x280
+         do_sendfile+0xb49/0x1310
+         __x64_sys_sendfile64+0x1d0/0x210
+         do_syscall_64+0x41/0xc0
+         entry_SYSCALL_64_after_hwframe+0x63/0xcd
+   ---------------------------------------------------
+   information that might be helpful
+   ---------------------------------------------------
+   CPU: 1 PID: 8060 Comm: a.out Not tainted
+	6.2.0-rc1-00025-gb0c20ebf51ac-dirty #28
+   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
+	BIOS Bochs 01/01/2011
+   Call Trace:
+    <TASK>
+    dump_stack_lvl+0xf2/0x169
+    print_circle.cold+0xca4/0xd28
+    ? lookup_dep+0x240/0x240
+    ? extend_queue+0x223/0x300
+    cb_check_dl+0x1e7/0x260
+    bfs+0x27b/0x610
+    ? print_circle+0x240/0x240
+    ? llist_add_batch+0x180/0x180
+    ? extend_queue_rev+0x300/0x300
+    ? __add_dep+0x60f/0x810
+    add_dep+0x221/0x5b0
+    ? __add_idep+0x310/0x310
+    ? add_iecxt+0x1bc/0xa60
+    ? add_iecxt+0x1bc/0xa60
+    ? add_iecxt+0x1bc/0xa60
+    ? add_iecxt+0x1bc/0xa60
+    __dept_wait+0x600/0x1490
+    ? add_iecxt+0x1bc/0xa60
+    ? truncate_inode_pages_range+0x9b0/0xf20
+    ? check_new_class+0x790/0x790
+    ? dept_enirq_transition+0x519/0x9c0
+    dept_wait+0x159/0x3b0
+    ? truncate_inode_pages_range+0x9b0/0xf20
+    folio_wait_bit_common+0x5e0/0xaf0
+    ? filemap_get_folios_contig+0xa30/0xa30
+    ? dept_enirq_transition+0x519/0x9c0
+    ? lock_is_held_type+0x10e/0x160
+    ? lock_is_held_type+0x11e/0x160
+    truncate_inode_pages_range+0x9b0/0xf20
+    ? truncate_inode_partial_folio+0xba0/0xba0
+    ? setattr_prepare+0x142/0xc40
+    truncate_pagecache+0x67/0x90
+    ntfs3_setattr+0x55a/0xd40
+    ? ktime_get_coarse_real_ts64+0x1e5/0x2f0
+    ? ntfs_extend+0x5c0/0x5c0
+    ? mode_strip_sgid+0x210/0x210
+    ? ntfs_extend+0x5c0/0x5c0
+    notify_change+0xcb3/0x1430
+    ? do_truncate+0x149/0x210
+    do_truncate+0x149/0x210
+    ? file_open_root+0x430/0x430
+    ? process_measurement+0x18c0/0x18c0
+    ? ntfs_file_release+0x230/0x230
+    path_openat+0x21a3/0x2a90
+    ? path_lookupat+0x840/0x840
+    ? dept_enirq_transition+0x519/0x9c0
+    ? lock_is_held_type+0x10e/0x160
+    do_filp_open+0x1ba/0x410
+    ? may_open_dev+0xf0/0xf0
+    ? find_held_lock+0x2d/0x110
+    ? lock_release+0x43c/0x830
+    ? dept_ecxt_exit+0x31a/0x590
+    ? _raw_spin_unlock+0x3b/0x50
+    ? alloc_fd+0x2de/0x6e0
+    do_sys_openat2+0x16d/0x4e0
+    ? __ia32_sys_get_robust_list+0x3b0/0x3b0
+    ? build_open_flags+0x6f0/0x6f0
+    ? dept_enirq_transition+0x519/0x9c0
+    ? dept_enirq_transition+0x519/0x9c0
+    ? lock_is_held_type+0x4e/0x160
+    ? lock_is_held_type+0x4e/0x160
+    __x64_sys_creat+0xcd/0x120
+    ? __x64_compat_sys_openat+0x1f0/0x1f0
+    do_syscall_64+0x41/0xc0
+    entry_SYSCALL_64_after_hwframe+0x63/0xcd
+   RIP: 0033:0x7f8b9e4e4469
+   Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
+   89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
+   3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
+   RSP: 002b:00007f8b9eea4ef8 EFLAGS: 00000202 ORIG_RAX: 0000000000000055
+   RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b9e4e4469
+   RDX: 0000000000737562 RSI: 0000000000000000 RDI: 0000000020000000
+   RBP: 00007f8b9eea4f20 R08: 0000000000000000 R09: 0000000000000000
+   R10: 0000000000000000 R11: 0000000000000202 R12: 00007fffa75511ee
+   R13: 00007fffa75511ef R14: 00007f8b9ee85000 R15: 0000000000000003
+    </TASK>
+
+Let's take a look at the summary that is the most important part.
+
+   ---------------------------------------------------
+   summary
+   ---------------------------------------------------
+   *** DEADLOCK ***
+
+   context A
+       [S] lock(&ni->ni_lock:0)
+       [W] folio_wait_bit_common(PG_locked_map:0)
+       [E] unlock(&ni->ni_lock:0)
+
+   context B
+       [S] (unknown)(PG_locked_map:0)
+       [W] lock(&ni->ni_lock:0)
+       [E] folio_unlock(PG_locked_map:0)
+
+   [S]: start of the event context
+   [W]: the wait blocked
+   [E]: the event not reachable
+
+The summary shows the following scenario:
+
+   context A	   context B	   context ?(unknown)
+
+				   [S] folio_lock(&f1)
+   [S] lock(&ni->ni_lock:0)
+   [W] folio_wait_bit_common(PG_locked_map:0)
+
+		   [W] lock(&ni->ni_lock:0)
+		   [E] folio_unlock(&f1)
+
+   [E] unlock(&ni->ni_lock:0)
+
+Adding supplementary comments to describe DEPT's view in detail:
+
+   context A	   context B	   context ?(unknown)
+
+				   [S] folio_lock(&f1)
+				   /* start to take into account context
+				      B heading for folio_unlock(&f1) */
+				   /* 1 */
+   [S] lock(&ni->ni_lock:0)
+   /* start to take into account this context heading for
+      unlock(&ni->ni_lock:0) */
+   /* 2 */
+
+   [W] folio_wait_bit_common(PG_locked_map:0) (= folio_lock(&f1))
+   /* might wait for folio_unlock(&f1) */
+
+		   [W] lock(&ni->ni_lock:0)
+		   /* might wait for unlock(&ni->ni_lock:0) */
+
+		   [E] folio_unlock(&f1)
+		   /* event that's been valid since 1 */
+
+   [E] unlock(&ni->ni_lock:0)
+   /* event that's been valid since 2 */
+
+Let's build up dependency graph with this report. Firstly, context A:
+
+   context A
+
+   [S] lock(&ni->ni_lock:0)
+   /* start to take into account this context heading for
+      unlock(&ni->ni_lock:0) */
+   /* 2 */
+
+   [W] folio_wait_bit_common(PG_locked_map:0) (= folio_lock(&f1))
+   /* might wait for folio_unlock(&f1) */
+
+   [E] unlock(&ni->ni_lock:0)
+   /* event that's been valid since 2 */
+
+There is one interesting event, unlock(&ni->ni_lock:0). There is a
+wait, folio_lock(&f1), between 2 and the event. Which means
+unlock(&ni->ni_lock:0) is not reachable if folio_unlock(&f1) does not
+wake up the wait. Therefore, we can say unlock(&ni->ni_lock:0) depends
+on folio_unlock(&f1), say, 'unlock(&ni->ni_lock:0) -> folio_unlock(&f1)'.
+The graph will look like after adding the dependency:
+
+   unlock(&ni->ni_lock:0) -> folio_unlock(&f1)
+
+   where 'A -> B' means that event A depends on event B.
+
+Secondly, context B:
+
+   context B
+
+   [W] lock(&ni->ni_lock:0)
+   /* might wait for unlock(&ni->ni_lock:0) */
+
+   [E] folio_unlock(&f1)
+   /* event that's been valid since 1 */
+
+There is also one interesting event, folio_unlock(&f1). There is a
+wait, lock(&ni->ni_lock:0), between 1 and the event - remind 1 is at a
+very start and before the wait in timeline. Which means folio_unlock(&f1)
+is not reachable if unlock(&ni->ni_lock:0) does not wake up the wait.
+Therefore, we can say folio_unlock(&f1) depends on unlock(&ni->ni_lock:0),
+say, 'folio_unlock(&f1) -> unlock(&ni->ni_lock:0)'. The graph will look
+like after adding the dependency:
+
+    -> unlock(&ni->ni_lock:0) -> folio_unlock(&f1) -
+   /                                                \
+   \                                                /
+    ------------------------------------------------
+
+   where 'A -> B' means that event A depends on event B.
+
+A new loop has been created. So DEPT can report it as a deadlock! Cool!
+
+CONCLUSION
+
+DEPT works awesome!
-- 
2.17.1


