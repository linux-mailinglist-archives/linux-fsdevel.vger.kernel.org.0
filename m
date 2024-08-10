Return-Path: <linux-fsdevel+bounces-25599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C360994DDB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9E91C20D42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C482616B38E;
	Sat, 10 Aug 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="m2o9tDNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02A1366;
	Sat, 10 Aug 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723309244; cv=none; b=Eq7Pq02IBnsBhKK/nC/wTCBf2AFuerjs2yMJSAQ+BgxgDv2+m0O2NaQTG/yCYI6ugyfHIxaOUbwPvxvLC2gaZcY4DILgug0bXgj4AOOaWkO8RXjWpROgm27H9EOcDz9i1UnZmysRlem/Eq28Ehkdm3tmsadrISMl2Pzhr7Ul9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723309244; c=relaxed/simple;
	bh=Eo3bJfzjjj8svkQqJ5ojDFc5ObyZLNW4pjZdYRkfj+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H//H8Qq61qehZVp91M4xHzxD83I3Y0GVC7hBC4OfrbBBKEqOTM4mrZ/M8p3NlcO0wFgDUeGRlu1t4BgC20Y4G9WqO9PIhszF3BWSK76R3NcUTkke/Bn1h24ZtLd6W/9tzIiUCeyk2sSWXi8B0lcpisHaMlye+ERiLfz562qL8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=m2o9tDNB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723309238;
	bh=Eo3bJfzjjj8svkQqJ5ojDFc5ObyZLNW4pjZdYRkfj+k=;
	h=From:Date:Subject:To:Cc:From;
	b=m2o9tDNBO3wNWg7MWz+8hGHQOQtE6wjex5xYeROMt4Q4jmPHVhy7UCzp1Vx31L4CX
	 lNU2y2KaK1Lp15x/qFlVDjN3P3TGLCh2GPUFCJlYGL4G/uKnsSHmxRoysQj9Vwmxu4
	 CmCYcgcI+3DXPJ3k7IX9x2ILSl4+MY0fnwGBYDW8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 10 Aug 2024 19:00:35 +0200
Subject: [PATCH] sysctl: update comments to new registration APIs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240810-sysctl-procname-null-comment-v1-1-816cd335de1b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALKct2YC/x3M0QqDMAxA0V+RPBtIRYbbrwwfXI0u0KbSqEzEf
 1/x8cDlnmCchQ1e1QmZdzFJWuDqCvx30JlRxmJoqGmpc4R2mF8DLjl5HSKjbiGgTzGyrtiRe9B
 nLOVzgrJYMk/yu/fv/rr+oJN2jG4AAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723309238; l=1780;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Eo3bJfzjjj8svkQqJ5ojDFc5ObyZLNW4pjZdYRkfj+k=;
 b=tl/JXdJ5WUmGKxZbSZpikbqJzmJo8f2vkFA0B6hQx5uk51Jd59PX6Kg4THlOmEs9PiOvvMZ0A
 FGZwf0OtbR+BTWqcwElLYV2sWhw9WOTsLR6vbFjlCOoWLNFs7Mzacwp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysctl registration APIs do not need a terminating table entry
anymore and with commit acc154691fc7 ("sysctl: Warn on an empty procname element")
even emit warnings if such a sentinel entry is supplied.

While at it also remove the mention of "table->de" which was removed in
commit 3fbfa98112fc ("[PATCH] sysctl: remove the proc_dir_entry member for the sysctl tables")
back in 2007.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysctl.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index aa4c6d44aaa0..47ca2536865b 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -90,9 +90,7 @@ int proc_do_static_key(const struct ctl_table *table, int write, void *buffer,
 
 /*
  * Register a set of sysctl names by calling register_sysctl
- * with an initialised array of struct ctl_table's.  An entry with 
- * NULL procname terminates the table.  table->de will be
- * set up by the registration and need not be initialised in advance.
+ * with an initialised array of struct ctl_table's.
  *
  * sysctl names can be mirrored automatically under /proc/sys.  The
  * procname supplied controls /proc naming.
@@ -133,7 +131,7 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 
 /* A sysctl table is an array of struct ctl_table: */
 struct ctl_table {
-	const char *procname;		/* Text ID for /proc/sys, or zero */
+	const char *procname;		/* Text ID for /proc/sys */
 	void *data;
 	int maxlen;
 	umode_t mode;

---
base-commit: 34ac1e82e5a78d5ed7f647766f5b1b51ca4d983a
change-id: 20240810-sysctl-procname-null-comment-80160bd4089f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


