Return-Path: <linux-fsdevel+bounces-7650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C38828C84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92A928ED3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421C3C471;
	Tue,  9 Jan 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ3xZdvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290833C468
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d88fff7faso34152595e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704824569; x=1705429369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDd+ccWIIelgE8IajN/62kCRVvl6T4LN1716OuQcjMw=;
        b=eZ3xZdvz/Z4H+VoXsMpGjkQQG+khPq/1zT8wrwMOFvhlbs70yEZpJz7Smv4yjVBdli
         JiibHRIUSaQof3vQptmCxGuPQTaIi2CjQlQUQcqiX8/kioO0GQCYOI2kWvD9xNwKg1Ts
         3ysZc8GPIySbT0Qxxv9D2I6BJ4r0o9islctIsBK5mQ/1fCMtzrB4qi6Zmla0e2Q/32jt
         jnCjUFNYPD2llNS1t/MB/deO+8CuSLDkfh7xw34/bO0fMRqtusii8Kn2ZIhZS/IZmeZ6
         1vhpRGqy1+5x1itG2Yy1WiKkuhB+b3jt9W96F0Nj0sxlLghBjxKJ1Or0/iLTBuoiVo1c
         uOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824569; x=1705429369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDd+ccWIIelgE8IajN/62kCRVvl6T4LN1716OuQcjMw=;
        b=cNnFAvLioQDQeWERBji+PvM6AN3yHPiGXpqbIgrAiMARFQ+xzFLGRA6rUketRaOg6H
         w0y6NjxCrU4o/ClC1UAQskbNhmwKgI7TP3RM3XKSm42JW9CPksglgLsa+K4ePsbZwQz4
         KPCpJg1xKPPaTqVt8MM+ao2b1bB0TvQ0Kppr4+XRfDxDtcobhEpHros4yKvtbrxQ1Wc2
         fZmp3HR73x7PIUnSRe8AT+9mD1i+J6XgJG8USgnlloOwRxfgATvGSvOsSf9zhF3P9dVa
         3yufHTOUKw9LLdb/ytqa07Xn0CINg6J9vwIHDnYk0ibN+KuNQWPsQ4M1yE1Jvo0Nc/2B
         HCkg==
X-Gm-Message-State: AOJu0Yybmow5+vSoBz6f6oz6LqLRc4YcO3wjbAWb2HxDjxXp6RO5/kC7
	JC0A/yqjgK/gYTq55SqbZuM=
X-Google-Smtp-Source: AGHT+IHzA63213J6trN2ut9NWka7Mg4YQ5bSzeSZduRwD7xDFaFg3NnYI/Ap+6wUsoODD+oPMfi9Eg==
X-Received: by 2002:a05:600c:a084:b0:40e:417d:7d1b with SMTP id jh4-20020a05600ca08400b0040e417d7d1bmr1499218wmb.82.1704824569117;
        Tue, 09 Jan 2024 10:22:49 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b003368d2e729bsm3007700wrm.43.2024.01.09.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:22:48 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fsnotify: compile out fsnotify permission hooks if !FANOTIFY_ACCESS_PERMISSIONS
Date: Tue,  9 Jan 2024 20:22:45 +0200
Message-Id: <20240109182245.38884-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The depency of FANOTIFY_ACCESS_PERMISSIONS on SECURITY made sure that
the fsnotify permission hooks were never called when SECURITY was
disabled.

Moving the fsnotify permission hook out of the secutiy hook broke that
optimisation.

Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
Closes: https://lore.kernel.org/linux-fsdevel/53682ece-f0e7-48de-9a1c-879ee34b0449@kernel.dk/
Fixes: d9e5d31084b0 ("fsnotify: optionally pass access range in file permission hooks")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 11e6434b8e71..8300a5286988 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -100,6 +100,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
 /*
  * fsnotify_file_area_perm - permission hook before access to file range
  */
@@ -145,6 +146,24 @@ static inline int fsnotify_open_perm(struct file *file)
 	return fsnotify_file(file, FS_OPEN_PERM);
 }
 
+#else
+static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
+					  const loff_t *ppos, size_t count)
+{
+	return 0;
+}
+
+static inline int fsnotify_file_perm(struct file *file, int perm_mask)
+{
+	return 0;
+}
+
+static inline int fsnotify_open_perm(struct file *file)
+{
+	return 0;
+}
+#endif
+
 /*
  * fsnotify_link_count - inode's link count changed
  */
-- 
2.34.1


