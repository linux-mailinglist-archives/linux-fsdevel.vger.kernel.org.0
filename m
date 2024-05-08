Return-Path: <linux-fsdevel+bounces-19061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFBF8BFA44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552681F24099
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B584A3B;
	Wed,  8 May 2024 10:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE237E798;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162585; cv=none; b=dP40uGGjHnAG9+WWDoVE8FD6i/nm1CUFDFp1I+ov4j7IFuog8eq2JT+yc04tg0ulxqhsZDspMj34fUjgHBIRJpKZmNieW4Zgx7qsCMMWB3s+vh7W08DiQjwHm/RZj+tuLfY4gh6iFDuVxfqSlnjksjrLFv9bA4PfMZD9nu4Ox7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162585; c=relaxed/simple;
	bh=ILOiGypKonBszEM01cavkBhnNff7lLqOK+UDeJBRKwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eS2SVNf9L06G5r0Lo1KQ/t1JMY19dmgZWNe4HvCdc2+AOz6d36EvJW0H+OIIeBNL1bGDgSYNp6vmzaEjplH9U1Y3mluR4q0r4KJqPB7LGhfINkHHCC+7KksI2zh6QCxncPVTW93EqVaQHMGcCHKZfhtmWZrYdchOCJJrJJo/Wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-d9-663b4a3c0e6c
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
Subject: [PATCH v14 28/28] dept: Add documentation for Dept's APIs
Date: Wed,  8 May 2024 18:47:25 +0900
Message-Id: <20240508094726.35754-29-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe97rXK5eltCrkdUggsLKyDqVRBTYUxEUXakPNdprG02TmbdA
	0rxU3khDV9NELdbS1Wzbhy5qa+F0hTbLcuaFNMssLzSbaNplKn45/Pif8/99OiJSaqWDRKro
	C4ImWq6WMWJKPORfHhK+d1vkemtXMOTnrAfvr6sUlJiMDLgeViEwWlMJGKjfDW1jgwgmm96Q
	oC10ISjv6SLB6uhGUGu4zMC7vgXQ6h1hwFmYzUDaHRMDLT+mCOgsKiCgyrwfXl+vIMA20U+B
	doCBYm0a4RvfCJjQV7KgT1kJvQYdC1M9oeDs/kBD7cc1cKu0k4GaWicFjse9BLx7WsJAt/Ef
	Da8djRS48nNpeDBcwcCPMT0Jeu8IC29tZQRUp/tEmaN/aWjItRGQefcRAa3tzxDUXf1EgNn4
	gYGX3kECLOZCEn7fq0fQmzfEQkbOBAvFqXkIsjOKKEjvDIPJ8RJmxxb8cnCExOmWBFw7Vkbh
	VxU8fqLrYnF63UcWl5njsMWwGt+pGSBwucdLY3PlNQabPQUszhpqJfBwczOLG29OUrivVUsc
	CDohDlcIalW8oFm3/bRYmeFsYGNKZYnVTXEpKH9JFvIT8dxG/vZvDzXHn0tHZ5jhVvFu9wQ5
	zQHcct6S+5WeZpIbFPN3myOmeRG3k3eMvkfTTHEr+Uxny0xXwm3ibxQ40KxzGV9VbZvx+Pny
	9v7hmVzKhfHP0nRsFhL7bsZFfNv7Unq2EMi/MLip60hShuZVIqkqOj5KrlJvXKtMilYlrj1z
	PsqMfL+kT546+Rh5XIfsiBMhmb/EtnhrpJSWx8cmRdkRLyJlAZL6K5sjpRKFPOmioDl/ShOn
	FmLtaImIki2WbBhLUEi5s/ILwjlBiBE0c1tC5BeUghbWdeh0l1YcW3E4yjQQY+l4eON5VlNa
	oNq41G21NR9pbDsuDrbYU/ECuX2n64i/OnENV4PF24wJ88e/7/H2L/t1tNPzpd2rLtocv+5+
	Y9fPlojiP3/CziWHK4cK9yqGtR2mE3k5+9zKgIN1ZGVoiJX793RX7iVTgMKQ3XD/SYhURsUq
	5aGrSU2s/D9L025kRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzH+36fX9ets2dX41nZ4qYh82sTHw4zjEfGzGxt/UGH53TrKu4q
	Yua4fqhkLurIlZOcVofcxUJnt9LltE6UiLRKQ6SsuubU0GX+ee+192ef119vESEtokJFqqQU
	QZOkUMtoMSneKdcvlkfLlct6ateC4dwy8I6dJcF010pD650qBNaa0xgGGrfCm/FBBBMtLwgw
	FrYiuN77gYAaVzcCR8UZGtr6Z0C7d5gGd2EeDfobd2l4+W0SQ1dRAYYq2w5ovlCGwen7TIJx
	gIarRj2eii8YfJZKBiy6COirKGZgsnc5uLs7KGgocVPgeLcIrpR20VDncJPgqu3D0PbIREO3
	9Q8Fza5nJLQa8im4PVRGw7dxCwEW7zADr5xmDNUZU7as0d8UNOU7MWSV38PQ3vkYwZOzPRhs
	1g4aGryDGOy2QgJ+3WpE0Hf+OwOZ53wMXD19HkFeZhEJGV1RMPHTRG9YwzcMDhN8hv0o7xg3
	k/zzMo5/WPyB4TOevGN4sy2Vt1dE8jfqBjB/fcRL8bbKHJq3jRQwfO73dswPeTwM/+zyBMn3
	txvxrrBY8dqDglqVJmiWro8Tx2e6m5jDpbJj1S2pOmQIy0WBIo5dwX0sHSX9TLPzubdvfYSf
	Q9g5nD3/E+Vngh0Uc+WeLX4OZjdyrtHXyM8kG8FluV9O/0rYldzFAhf65wznqqqd057Aqb7z
	89B0L2WjuMf6YuYCEptRQCUKUSWlJSpU6qgl2oT49CTVsSUHkhNtaGotlpOThlo01ra1HrEi
	JAuStNJypZRSpGnTE+sRJyJkIZLG7FVKqeSgIv24oEnep0lVC9p6FCYiZbMk0TFCnJQ9pEgR
	EgThsKD5f8WiwFAduo+jT62brDPFlji/apqRY6ZhZPX28pBkpUd35URTV9jCH+qle/eXa3cH
	xW3y3Nx81O7bWLvN2p+84dFs/dwOpTEgRnvtgfip0hTckmBeMOxInRP1/ogqeN7TyEvyrEs1
	KfNMtj1ljLM6r8cVtG/Px/zeJnN2drhWt+tAjmyd/EyJjNTGK5ZHEhqt4i/zXmBuKQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

This document describes the APIs of Dept.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 Documentation/dependency/dept_api.txt | 117 ++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/dependency/dept_api.txt

diff --git a/Documentation/dependency/dept_api.txt b/Documentation/dependency/dept_api.txt
new file mode 100644
index 000000000000..8e0d5a118a46
--- /dev/null
+++ b/Documentation/dependency/dept_api.txt
@@ -0,0 +1,117 @@
+DEPT(DEPendency Tracker) APIs
+=============================
+
+Started by Byungchul Park <max.byungchul.park@sk.com>
+
+SDT(Single-event Dependency Tracker) APIs
+-----------------------------------------
+Use these APIs to annotate on either wait or event.  These have been
+already applied into the existing synchronization primitives e.g.
+waitqueue, swait, wait_for_completion(), dma fence and so on.  The basic
+APIs of SDT are:
+
+   /*
+    * After defining 'struct dept_map map', initialize the instance.
+    */
+   sdt_map_init(map);
+
+   /*
+    * Place just before the interesting wait.
+    */
+   sdt_wait(map);
+
+   /*
+    * Place just before the interesting event.
+    */
+   sdt_event(map);
+
+The advanced APIs of SDT are:
+
+   /*
+    * After defining 'struct dept_map map', initialize the instance
+    * using an external key.
+    */
+   sdt_map_init_key(map, key);
+
+   /*
+    * Place just before the interesting timeout wait.
+    */
+   sdt_wait_timeout(map, time);
+
+   /*
+    * Use sdt_might_sleep_start() and sdt_might_sleep_end() in pair.
+    * Place at the start of the interesting section that might enter
+    * schedule() or its family that needs to be woken up by
+    * try_to_wake_up().
+    */
+   sdt_might_sleep_start(map);
+
+   /*
+    * Use sdt_might_sleep_start_timeout() and sdt_might_sleep_end() in
+    * pair.  Place at the start of the interesting section that might
+    * enter schedule_timeout() or its family that needs to be woken up
+    * by try_to_wake_up().
+    */
+   sdt_might_sleep_start_timeout(map, time);
+
+   /*
+    * Use sdt_might_sleep_start() and sdt_might_sleep_end() in pair.
+    * Place at the end of the interesting section that might enter
+    * schedule(), schedule_timeout() or its family that needs to be
+    * woken up by try_to_wake_up().
+    */
+   sdt_might_sleep_end();
+
+   /*
+    * Use sdt_ecxt_enter() and sdt_ecxt_exit() in pair.  Place at the
+    * start of the interesting section where the interesting event might
+    * be triggered.
+    */
+   sdt_ecxt_enter(map);
+
+   /*
+    * Use sdt_ecxt_enter() and sdt_ecxt_exit() in pair.  Place at the
+    * end of the interesting section where the interesting event might
+    * be triggered.
+    */
+   sdt_ecxt_exit(map);
+
+
+LDT(Lock Dependency Tracker) APIs
+---------------------------------
+Do not use these APIs directly.  These are the wrappers for typical
+locks, that have been already applied into major locks internally e.g.
+spin lock, mutex, rwlock and so on.  The APIs of LDT are:
+
+   ldt_init(map, key, sub, name);
+   ldt_lock(map, sub_local, try, nest, ip);
+   ldt_rlock(map, sub_local, try, nest, ip, queued);
+   ldt_wlock(map, sub_local, try, nest, ip);
+   ldt_unlock(map, ip);
+   ldt_downgrade(map, ip);
+   ldt_set_class(map, name, key, sub_local, ip);
+
+
+Raw APIs
+--------
+Do not use these APIs directly.  The raw APIs of dept are:
+
+   dept_free_range(start, size);
+   dept_map_init(map, key, sub, name);
+   dept_map_reinit(map, key, sub, name);
+   dept_ext_wgen_init(ext_wgen);
+   dept_map_copy(map_to, map_from);
+   dept_wait(map, wait_flags, ip, wait_func, sub_local, time);
+   dept_stage_wait(map, key, ip, wait_func, time);
+   dept_request_event_wait_commit();
+   dept_clean_stage();
+   dept_stage_event(task, ip);
+   dept_ecxt_enter(map, evt_flags, ip, ecxt_func, evt_func, sub_local);
+   dept_ecxt_holding(map, evt_flags);
+   dept_request_event(map, ext_wgen);
+   dept_event(map, evt_flags, ip, evt_func, ext_wgen);
+   dept_ecxt_exit(map, evt_flags, ip);
+   dept_ecxt_enter_nokeep(map);
+   dept_key_init(key);
+   dept_key_destroy(key);
+   dept_map_ecxt_modify(map, cur_evt_flags, key, evt_flags, ip, ecxt_func, evt_func, sub_local);
-- 
2.17.1


