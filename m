Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84C4231664
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 01:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgG1Xpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 19:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgG1Xpb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:45:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D9C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 16:45:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so292352pls.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivodmiipEebzh9N6gBP0LpBKmSiUhMd048ygFSldiXM=;
        b=XsMunTJ8EZGQ049aXYT1SmVBQ70JQ4iMjk6RQMHJz2I8Lz3CBPiIXSznrFx2zxs7Un
         381P5JKJE+OhU229hkRGTYUni7zW/Vqd9gQ0crQbD5tk51oigir8ftfb/sYTwN4RcspZ
         1BZttO5rIFv2yTikP4wyyel/oSzZJXVxPGdI9Q9oHbIluAH6oFWz0gK/YRC+EdXy3ScX
         mMoFooEb0AKXaH7hwhur2zG0S7RvBkQDxcsBGUhrSJ+kNTFCynd1FuMOeusdAkT8j7Hr
         R+PwJYGWtvSMOlXrneisOeRQ/mqPi5+IzmynwLRjpS9k5atzDgS4qySPxKkffpKsNBVz
         8WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivodmiipEebzh9N6gBP0LpBKmSiUhMd048ygFSldiXM=;
        b=iQUngWUgsKUFyqsf+y8evQglh6mkh25R5YEjfHDdTEpLPF9omDG6qCSVjZzrQFV8qC
         FL3cUVZ0LNxhzSo3onXgXL2K/H4XTWDMcr82/qZdnts9DZ/x7kq4lm+SC5eQ9coFhCve
         EOqVCDg1kMIAtUN1S2h1CF/JXTqmO0pbj3e4vXjX+Ex85wwrspcY+ZAtYWw7bWkEW7Px
         m3qdy1AUPD8dmK13g+Z4O0gd0rSaeZ/UzOwRylyPlybhNYqdWOSG0KzHi5TICCk/HWcX
         Ibl44F4DcO3ikj+qC29shLdsGISWFO/2Ulc42I4jgAaOD7Q2II3E2wr7QvygVE4P/ltg
         VXOQ==
X-Gm-Message-State: AOAM53226kQKouk9WT8bUS1UjUtZvhTJNviQ/Zfup0Dlny7N7CPbFH9C
        9fQpQ5hJUPVlbhWPZcK4JoN0lpQ9
X-Google-Smtp-Source: ABdhPJxUaz3Ay0tUbAa59HSUPL2xlD9RdDjwvc6THEZOcHvGcFkVZ+obTfCNSN1FPCpG19ZitsiBcw==
X-Received: by 2002:a17:90a:eb18:: with SMTP id j24mr6878388pjz.76.1595979930067;
        Tue, 28 Jul 2020 16:45:30 -0700 (PDT)
Received: from paxos.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe5d:61cb])
        by smtp.gmail.com with ESMTPSA id b185sm158339pfg.71.2020.07.28.16.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:45:29 -0700 (PDT)
From:   Lepton Wu <ytht.net@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     miklos@szeredi.hu, Lepton Wu <ytht.net@gmail.com>
Subject: [PATCH] fuse: Add filesystem attribute in sysfs control dir.
Date:   Tue, 28 Jul 2020 16:45:13 -0700
Message-Id: <20200728234513.1956039-1-ytht.net@gmail.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With this, user space can have more control to just abort some kind of
fuse connections. Currently, in Android, it will write to abort file
to abort all fuse connections while in some cases, we'd like to keep
some fuse connections. This can help that.

Signed-off-by: Lepton Wu <ytht.net@gmail.com>
---
 fs/fuse/control.c | 31 ++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h  |  2 +-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index c23f6f243ad42..85a56d2de50d5 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -64,6 +64,27 @@ static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
 	return simple_read_from_buffer(buf, len, ppos, tmp, size);
 }
 
+static ssize_t fuse_conn_file_system_read(struct file *file, char __user *buf,
+					  size_t len, loff_t *ppos)
+{
+	char tmp[32];
+	size_t size;
+
+	if (!*ppos) {
+		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+
+		if (!fc)
+			return 0;
+		if (fc->sb && fc->sb->s_type)
+			file->private_data = (void *)fc->sb->s_type->name;
+		else
+			file->private_data = "(NULL)";
+		fuse_conn_put(fc);
+	}
+	size = sprintf(tmp, "%.30s\n", (char *)file->private_data);
+	return simple_read_from_buffer(buf, len, ppos, tmp, size);
+}
+
 static ssize_t fuse_conn_limit_read(struct file *file, char __user *buf,
 				    size_t len, loff_t *ppos, unsigned val)
 {
@@ -217,6 +238,12 @@ static const struct file_operations fuse_conn_congestion_threshold_ops = {
 	.llseek = no_llseek,
 };
 
+static const struct file_operations fuse_conn_file_system_ops = {
+	.open = nonseekable_open,
+	.read = fuse_conn_file_system_read,
+	.llseek = no_llseek,
+};
+
 static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 					  struct fuse_conn *fc,
 					  const char *name,
@@ -285,7 +312,9 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
 				 S_IFREG | 0600, 1, NULL,
-				 &fuse_conn_congestion_threshold_ops))
+				 &fuse_conn_congestion_threshold_ops) ||
+	    !fuse_ctl_add_dentry(parent, fc, "filesystem", S_IFREG | 0400, 1,
+				 NULL, &fuse_conn_file_system_ops))
 		goto err;
 
 	return 0;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740a8a7d7ae6f..59390ed37bbad 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -45,7 +45,7 @@
 #define FUSE_NAME_MAX 1024
 
 /** Number of dentries for each connection in the control filesystem */
-#define FUSE_CTL_NUM_DENTRIES 5
+#define FUSE_CTL_NUM_DENTRIES 6
 
 /** List of active connections */
 extern struct list_head fuse_conn_list;
-- 
2.28.0.163.g6104cc2f0b6-goog

