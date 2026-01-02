Return-Path: <linux-fsdevel+bounces-72332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0738ACEF4B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 21:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA3B33024E51
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 20:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A602D3EC7;
	Fri,  2 Jan 2026 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b="Njjt1WuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79ED450F2;
	Fri,  2 Jan 2026 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385056; cv=pass; b=tKdTWVl7yVfENaklYCdBqfHdOJsNlUwHlT0BHie50lCuCKnHbI65TLhnOJSOfBC4D2wNAMpa1+Hml8W1szuWFX1c50N4izop0Cqfj8RVuPnoBBVclXuyW4xEY1Mk4KWIqOMvVOeLN1x23w1CsenQ9uJExSZcPNESUJGx8LaFLl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385056; c=relaxed/simple;
	bh=kxh0OrnRnqoUaYvpC7u7+R0INUU2hfe0RK/RgiwN1IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My7+6Aweh122yVCP9ZRha9esvPpnkdsM2OAk10mb8mkXlgXw379AJjmPoGeneRetewvz8lOlLml+xV+jFSnv0pweCpHT62jzlZSVXTYZOkWNkq1qXsS7LNQyOMEs0SQ+wjmpvuVxvBs0dYbpRK1fvJYHkw3j68ae7qSaPt3aP/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com; spf=pass smtp.mailfrom=laveeshbansal.com; dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b=Njjt1WuU; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
ARC-Seal: i=1; a=rsa-sha256; t=1767385024; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QboYqUHjyHEodyFeOSGyC+3Lq8CHcaIDexOaGq3iVABHmzPBYK83Cm/7eaBIvgp2zGHXiJtQR+FFuvGa6u89KR6fFhwkKoPOceJ3zTib4SrhRl3nxEww1qGIY2ryt8cdSFtsLx+2m7DE2e9qVt4Lko/BPYvxhRJoMOGL4+3vI5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767385024; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mF5dJbmMYGWxTl3OhQSnSrdKT7f5/kxVszfkuAjPvvo=; 
	b=eW5sMfe0NsdvdMEOQ+PNAAYlKFFIOm2+XWMqs3ZT2SEkhP1xXZbMo8Ghe1cWfvbt1kJiBKXyoVIifPlqYWl9KpmvpcSeMaFpLdyIE8RI+qcJPMrZC2NnlEj8c+o4++LOi3c39m5lU4PbVaD1p1ckDK13/yHced4X6HaIf3HDLn4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767385024;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mF5dJbmMYGWxTl3OhQSnSrdKT7f5/kxVszfkuAjPvvo=;
	b=Njjt1WuUcJhUajocBRAVEopmd2tD4KJfMl7MVxeLIkPaVrEJv/A00Hm0Q5YN+tOS
	Qe+RnFDV/oRoIX+gKj8B0tD2mKUSqyRCnwC7sJeq/Min9dVio2iYuYxbo8BaJoqi7SL
	xd9a6faeTmWEoEA3sDsMg9tKz2zTFE8KDocVc/oI=
Received: by mx.zohomail.com with SMTPS id 1767385022473845.864596684939;
	Fri, 2 Jan 2026 12:17:02 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laveesh Bansal <laveeshb@laveeshbansal.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] writeback: fix 100% CPU usage when dirtytime_expire_interval is 0
Date: Fri,  2 Jan 2026 20:16:56 +0000
Message-ID: <20260102201657.305094-2-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102201657.305094-1-laveeshb@laveeshbansal.com>
References: <20260102201657.305094-1-laveeshb@laveeshbansal.com>
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


