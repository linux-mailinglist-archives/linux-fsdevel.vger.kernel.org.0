Return-Path: <linux-fsdevel+bounces-12251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A381685D4E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC8128CA37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033E864CE6;
	Wed, 21 Feb 2024 09:50:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABD35823C;
	Wed, 21 Feb 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509012; cv=none; b=fKhI1kznNddmLqpfHop+N4q99eDpL6ti3EWnWWVqlvZxwEBuSSBgKMg+Y+v/d90eKr5sxnnFbE0sUtUXBqn28cRTif5DHhIp4pvgtBJWvAiZMTUkD8H2Ofxr5AKwzaRpNvBPW7ip680XuraIR2d2s4TMVolJ2g/9eg2gjG55f+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509012; c=relaxed/simple;
	bh=1CF3fT+0y7rY0XzqAKz8iCCaEnPZ1j3P7N8n5p5eJns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UjKn5dBPkqjWzWosd3qQ3Z35QmJazWgKpQUkD0AKLlxAtI1VYpdMVPnw/9EeXqsWvgH0mhPirrOxCn93jTTCrydl7N8E8gN8KF73iqnYJLEVZv10PeLJhOQ/DTG7R5T9fV10e6QtnxjoA7r084Jk/W91Do/mGAcNVpYikuIdREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-39-65d5c73b28e7
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
	viro@zeniv.linux.org.uk,
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
Subject: [PATCH v12 27/27] dept: Add 'Dept' documentation
Date: Wed, 21 Feb 2024 18:49:33 +0900
Message-Id: <20240221094933.36348-28-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfZ73SrX4ppr4Tkw0TRSnUUFBj4aZGW+PRqOJyT64LVrlVRoL
	aLlZEw1qqaUV4yUFFdQCpnaFTXyLERQMQgCRqKDlogGizKjEIhfXuo46bDF+Ofnl/z/n9+nw
	lKqamclrU9IlfYpGp2YVtGJwSvGihOYOKSZQo4Bzp2PA94+ZhqKb5Sy0/VWGoLzyOIaBxo3Q
	5fciGHv8lIICWxuC4te9FFQ29SGodZ5g4fmbSPD4hlhosVlZOFl6k4X2D0EMPfnnMZTJW6H1
	bAmGusA7GgoGWCgsOIlD4z2GgMPFgSN7LvQ7L3MQfB0LLX2dDNS+XAiXrvawUFPbQkNTVT+G
	53eLWOgrH2egtekhDW3n8hj482MJCx/8DgocviEOntXZMVQYQyLTp/8ZaM6rw2C6fguD58U9
	BPfNrzDI5Z0sNPi8GNyyjYL/bjQi6D8zyEHO6QAHhcfPILDm5NPw9EszA8aeeBj7t4j9eRVp
	8A5RxOjOIrV+O00elYik+nIvR4z3X3LELmcQt3MBKa0ZwKR41McQ2ZXLEnn0PEcsgx5MPj55
	wpGHF8do8sZTgLdH7VQkJEo6baakX7J6tyLJbsvhDl5JOFz2aYzKRv75FhTBi0Kc+O5EF2tB
	/AT33tgVjlkhWuzuDlBhni7MEd15bxkLUvCUcGqy6Bx+zIaLacJKsaG7kQkzLcwV3WYbFfYo
	heXiSNDwTT9bLKuom/BEhOI/Cr0T6yohXuxov02FnaJgjRCDX4LMt4MfxAfObvosUtrRJBdS
	aVMykzVaXdziJEOK9vDivanJMgo9lONo8NcqNNq2ox4JPFJPUSbd8UgqRpOZZkiuRyJPqacr
	6axQpEzUGI5I+tRd+gydlFaPonhaPUO51J+VqBL2a9KlA5J0UNJ/bzEfMTMbWa3pOuO63MgX
	yzrhWK7DZP5pXqTBFF3zi4tq31waG1c1Lm8iK9S/Y8ucuGXT/OmpFZptJRuK46fuyV+zNnl9
	QsaI9UhFx7PhWzuv7Zv/+ULPYGrr+G8xZmZ0+Me/7V3qjspFs2YsbdZbho9dz66WmY2ZnUf3
	ZXk/LxyZbDrkitqSqKbTkjSxCyh9muYrda9QDUwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/L/xxXi8M0PHShGEplZUZab2jXD3WIjAgqsg866uCW17ay
	DALzUmZZai0tLTarZWqlm91TlkvnutjMeUnU0qQSV+u2kWmXLejLy8Pvefh9ellSVkpPZVXJ
	e0V1siJRjiWUZGNk1oJIa4cYVtAdAoUnwsD9PZeCspvVGOw3qhBU1x0mYLhpHXR5nAjGnr8g
	oVhrR6Af6COhrrkfQX1FJob2ocngcLsw2LTHMWRduomhbWScgN6zRQRUGaPhaUE5AebR9xQU
	D2MoLc4ivOcDAaOGSgYMGcEwWHGegfGBRWDr76TBcsFGQ33PPDh3sRfDw3obBc13Bwlov1+G
	ob/6Dw1Pm1sosBfm03D9UzmGEY+BBIPbxcBLs46Ammyv7ci33zRY880EHLlcS4Dj1QMEDblv
	CDBWd2KwuJ0EmIxaEn5ebUIwePIjAzknRhkoPXwSwfGcsxS8+GWlIbs3AsZ+lOFVkYLF6SKF
	bNN+od6jo4Qn5bxw73wfI2Q39DCCzrhPMFWECJceDhOC/qubFoyVx7Bg/FrECHkfHYTwqbWV
	EVpKxihhyFFMbJoeI4naJSaq0kT1whVxEqVOm8OkXog6UPVtjMxAnjl5iGV5Lpzvuxqbh/xY
	zM3mu7tHSV8O4Gbxpvx3dB6SsCR3dCJf8fk59hX+3DLe0t1E+zLFBfOmXC3p80i5JfyX8XQf
	5rmZfFWN+Z/Hz4uvlTr/zWVcBN/RdossQBIdmlCJAlTJaUkKVWJEqCZBmZ6sOhC6MyXJiLwv
	Yzg0XngXfW9f14g4FsknSZV3HKKMVqRp0pMaEc+S8gAptd+LpLsU6QdFdUqsel+iqGlE01hK
	Hihdv02Mk3Hxir1igiimiur/LcH6Tc1At/ccTIr3hEWx5dH2GF2tNefU0pYdrctbn1Hro+ML
	uWDnmgHuypTw0BlKw7z78wNjUiKCFk/yo3dbA7Uul/6aJXBD0Gv/npIZNtPcrCsjAz+3rDwz
	f1rDlu2bM1eTRTsrgx6/HXqvV5q/RIfiTP3prV11a2NluCShJffBoyZ7nP8POaVRKhaFkGqN
	4i+4H0qqLgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

This document describes the concept of Dept.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 Documentation/dependency/dept.txt | 283 ++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)
 create mode 100644 Documentation/dependency/dept.txt

diff --git a/Documentation/dependency/dept.txt b/Documentation/dependency/dept.txt
new file mode 100644
index 000000000000..7efe3bc59b2d
--- /dev/null
+++ b/Documentation/dependency/dept.txt
@@ -0,0 +1,283 @@
+DEPT(DEPendency Tracker)
+========================
+
+Started by Byungchul Park <max.byungchul.park@sk.com>
+
+How lockdep works
+-----------------
+
+Lockdep tries to detect a deadlock by checking lock acquisition order.
+For example, consider a graph built by lockdep like:
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
+runtime. For example, 'E -> C' will be added when it's recognized that
+the two locks have been acquired in that order like:
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
+Lockdep reports it as a deadlock on detection of a loop.
+
+CONCLUSION
+
+Lockdep detects a deadlock by checking if a loop has been created after
+expanding the graph.
+
+
+Limitation of lockdep
+---------------------
+
+Lockdep works on typical lock e.g. spinlock and mutex, that are supposed
+to be released within the acquisition context. However, a deadlock by
+folio lock or other synchronization mechanisms cannot be detected by
+lockdep that basically tracks lock acquisition order.
+
+Can we detect the following deadlock?
+
+   CONTEXT X	   CONTEXT Y	   CONTEXT Z
+
+		   mutex_lock A
+   folio_lock B
+		   folio_lock B
+				   mutex_lock A /* DEADLOCK */
+				   folio_unlock B
+		   folio_unlock B
+		   mutex_unlock A
+				   mutex_unlock A
+
+No, we can't. What about the following?
+
+   CONTEXT X		   CONTEXT Y
+
+			   mutex_lock A
+   mutex_lock A
+			   wait_for_complete B /* DEADLOCK */
+   complete B
+			   mutex_unlock A
+   mutex_unlock A
+
+No, we can't.
+
+CONCLUSION
+
+Given the limitation, lockdep cannot detect a deadlock by folio lock or
+other synchronization mechanisms.
+
+
+What leads a deadlock
+---------------------
+
+A deadlock occurs when one or multi contexts are waiting for events that
+will never happen. For example:
+
+   CONTEXT X	   CONTEXT Y	   CONTEXT Z
+
+   |		   |		   |
+   v		   |		   |
+   (1) wait for A  v		   |
+   .		   (2) wait for C  v
+   event C	   .		   (3) wait for B
+		   event B	   .
+				   event A
+
+Event C cannot be triggered because context X is stuck at (1), event B
+cannot be triggered because context Y is stuck at (2), and event A
+cannot be triggered because context Z is stuck at (3). All the contexts
+are stuck. We call the situation a *deadlock*.
+
+If an event occurrence is a prerequisite to reaching another event, we
+call it *dependency*. In the example above:
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
+Dependencies in a graph look like:
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
+A circular dependency leads a deadlock.
+
+
+Introduce DEPT
+--------------
+
+DEPT(DEPendency Tracker) tracks wait and event instead of lock
+acquisition order so as to recognize the following situation:
+
+   CONTEXT X	   CONTEXT Y	   CONTEXT Z
+
+   |		   |		   |
+   v		   |		   |
+   wait for A	   v		   |
+   .		   wait for C	   v
+   event C	   .		   wait for B
+		   event B	   .
+				   event A
+
+and builds up a dependency graph in runtime, similar to lockdep. The
+graph would look like:
+
+    -> C -> A -> B -
+   /                \
+   \                /
+    ----------------
+
+   where 'A -> B' means that event A depends on event B.
+
+DEPT keeps adding each new dependency into the graph in runtime. For
+example, 'B -> D' will be added when it's recognized that event D
+occurrence is a prerequisite to reaching event B, in other words, event
+B depends on event D like:
+
+   |
+   v
+   wait for D
+   .
+   event B
+
+After adding 'B -> D' dependency into the graph, the graph would look
+like:
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
+Let's take a look how DEPT works with an example that was mentioned in
+the section 'Limitation of lockdep'.
+
+   CONTEXT X	   CONTEXT Y	   CONTEXT Z
+
+		   mutex_lock A
+   folio_lock B
+		   folio_lock B
+				   mutex_lock A /* DEADLOCK */
+				   folio_unlock B
+		   folio_unlock B
+		   mutex_unlock A
+				   mutex_unlock A
+
+Add comments to describe DEPT's view using terms of wait and event.
+
+   CONTEXT X	   CONTEXT Y	   CONTEXT Z
+
+		   mutex_lock A
+		   /* start to take into account event A context */
+   folio_lock B
+   /* start to take into account event B context */
+
+		   folio_lock B
+		   /* wait for B */
+		   (1)
+				   mutex_lock A /* DEADLOCK */
+				   /* wait for A */
+				   (2)
+
+				   folio_unlock B
+				   /* event B */
+		   folio_unlock B
+		   /* not interest until reaching (1) */
+
+		   mutex_unlock A
+		   /* event A */
+				   mutex_unlock A
+				   /* not interest until reaching (2) */
+
+Focusing on wait and event, the example can be simplified like:
+
+   CONTEXT X	   CONTEXT Y	   CONTEXT Z
+
+		   |		   |
+		   |		   |
+		   v		   |
+		   wait for B	   v
+		   .		   wait for A
+		   .		   .
+		   .		   event B
+		   event A
+
+Event A occurrence is a prerequisite to reaching event B, and event B
+occurrence is a prerequisite to reaching event A.
+
+In terms of dependency:
+
+   Event B depends on event A.
+   Event A depends on event B.
+
+Dependencies in the dependency graph look like:
+
+    -> A -> B -
+   /           \
+   \           /
+    -----------
+
+   where 'A -> B' means that event A depends on event B.
+
+A loop has been created. So DEPT can report it as a deadlock.
+
+CONCLUSION
+
+DEPT works well with any synchronization mechanisms by focusing on wait
+and event.
-- 
2.17.1


