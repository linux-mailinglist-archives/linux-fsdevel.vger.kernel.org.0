Return-Path: <linux-fsdevel+bounces-72511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44422CF8DFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14A5F3026A4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACA2334681;
	Tue,  6 Jan 2026 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b="QmEBLGhg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CC29ACF6;
	Tue,  6 Jan 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711095; cv=pass; b=p9rdrk8fahaoFEFjTn2c0PJtOK/3eQB8L6bawf5avaaWFLyyUQHA/uCwoedcfg5r6jM1C0R5/Ucnkw3i1BN6IbZgf1yEpNlTYBhsZWWVe9J/aQ1gyAkytEQ+TvdYLUTf6dZWewMYHLHjVZ/CpBMLmXwR/MOFqGoMuy60VRvT6HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711095; c=relaxed/simple;
	bh=Eo0EJE/LF1xjC0fVLOMX2P9OvYRvbIZMAFP3mwJYsUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAR7ZXeV9VqjyQvcZ75CSMiDjbCTZw188e/JeaNKNl3DezjyA5VQgPUvhzROIVMJ/Bvn3sa6Rrleqj65MQI/m38WdAJr61iS9V/fRmyYP8hOtuOunWXBsWWRPq2WK943o94lGpqGVqFql7CYEPUlmWxqi1agWdDZBxDOEDum54I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com; spf=pass smtp.mailfrom=laveeshbansal.com; dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b=QmEBLGhg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
ARC-Seal: i=1; a=rsa-sha256; t=1767711063; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nu9vc8RljohLk9WPhWatEM3bhLjB0m3Qmficd/qgpo4z1zRsYHlw3mEh57Js0N1Po0F7k4XcOaINekf8wlQn/QJ4BYLNT2Nrnrk8WtSDxb+CrXHO0iy9Xit0P52srqeXTK1o68YIIk/r/YB9IfGcPpH83KwKC5Ca7MGGlWEvns0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767711063; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DIpj/EBgJMwfolwWut1Ncns92Qc4McVeghOLl56rZzo=; 
	b=bTQqNV/WHFeWOFo1YGwY/at2/BQrXwj+eGVZMb6q+IbaWNZcXjSVMRst5jLajUH0XNPjFid1txl6vj0hN5ZcHPYo6bbXrmUeu4GRl3F4MJyOhipVxNOYZFrvIR3hqjK45APv9WjztgYz5XlDhh04RmdOnzsNlMw3kwNqA1HM/ik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767711063;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DIpj/EBgJMwfolwWut1Ncns92Qc4McVeghOLl56rZzo=;
	b=QmEBLGhgYHs6IfwUyU34D6l8/fx0l+cp3GkXt0R5x2gcwYwyWjoobLAXr/eMwTe7
	3gC+pqlWTwRMl2SoGOMw1si7mtAjAfZ84CXNZuVcTJpSSCVYWxS/+mBPaHPozHoziL7
	ff4tkmOTgiwC3LEe69L/1qwRhGpuME4jvUbhDArg=
Received: by mx.zohomail.com with SMTPS id 1767711060521524.7786465199429;
	Tue, 6 Jan 2026 06:51:00 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Laveesh Bansal <laveeshb@laveeshbansal.com>
Subject: [PATCH v2 1/2] writeback: fix 100% CPU usage when dirtytime_expire_interval is 0
Date: Tue,  6 Jan 2026 14:50:58 +0000
Message-ID: <20260106145059.543282-2-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106145059.543282-1-laveeshb@laveeshbansal.com>
References: <20260106145059.543282-1-laveeshb@laveeshbansal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When vm.dirtytime_expire_seconds is set to 0, wakeup_dirtytime_writeback()
schedules delayed work with a delay of 0, causing immediate execution.
The function then reschedules itself with 0 delay again, creating an
infinite busy loop that causes 100% kworker CPU usage.

Fix by:
- Only scheduling delayed work in wakeup_dirtytime_writeback() when
  dirtytime_expire_interval is non-zero
- Cancelling the delayed work in dirtytime_interval_handler() when
  the interval is set to 0
- Adding a guard in start_dirtytime_writeback() for defensive coding

Tested by booting kernel in QEMU with virtme-ng:
- Before fix: kworker CPU spikes to ~73%
- After fix: CPU remains at normal levels
- Setting interval back to non-zero correctly resumes writeback

Fixes: a2f4870697a5 ("fs: make sure the timestamps for lazytime inodes eventually get written")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220227
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6800886c4d10..cd21c74cd0e5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2492,7 +2492,8 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
 				wb_wakeup(wb);
 	}
 	rcu_read_unlock();
-	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+	if (dirtytime_expire_interval)
+		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
 }
 
 static int dirtytime_interval_handler(const struct ctl_table *table, int write,
@@ -2501,8 +2502,12 @@ static int dirtytime_interval_handler(const struct ctl_table *table, int write,
 	int ret;
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret == 0 && write)
-		mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
+	if (ret == 0 && write) {
+		if (dirtytime_expire_interval)
+			mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
+		else
+			cancel_delayed_work_sync(&dirtytime_work);
+	}
 	return ret;
 }
 
@@ -2519,7 +2524,8 @@ static const struct ctl_table vm_fs_writeback_table[] = {
 
 static int __init start_dirtytime_writeback(void)
 {
-	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+	if (dirtytime_expire_interval)
+		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
 	register_sysctl_init("vm", vm_fs_writeback_table);
 	return 0;
 }
-- 
2.43.0


