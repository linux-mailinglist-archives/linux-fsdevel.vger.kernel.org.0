Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AECE18BA9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgCSPKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44272 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgCSPKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id o12so2940864wrh.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LxZjALu8+JdM1LNMX2SUCsKVBqP/y1yL79+aF6PkR+s=;
        b=JyD0Snx9IXb2NLcZnN4uGj42Qo/xJRV9BkgrIc9VfFNramHwlDvYDCwIYrIJOLjSte
         kcAKrgbnguxduU5EOXzBvUDnFDe5zeE0JEDS0uY54urAXhRXG/tGEQEmgDZbkTxra9aY
         hol8qLYZHU0jRf7ni7jR3C3QBVsoT72qty5e8GBRo+Pjt8m/YBkEvL9nMxH1OcwFMZEc
         sHQOqLYb0IPxvgJUoIbuQJMePB6q/4Sr7GFqRxH2SJn3AjgkQIWdHn+u2cShko/Kuh0L
         dTJXw+Vwqkk82sC1zIw+NCC3Etm5NebLPyP+cnfgqaYOrhaweNaItznydtSCLiA1jz4T
         M1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LxZjALu8+JdM1LNMX2SUCsKVBqP/y1yL79+aF6PkR+s=;
        b=RdAk4KH74jz+GRI53WcgDGgfrp6maZ4PJFcMOezrNkCeyftBfM+jbZdTC65K9KregC
         OnqIB9wHcMrG6Q5uUtbX+5RW3UE/XE4l2Wfqk1XDuCm821kLnDuEWmuirLdXLzHD9dg2
         HxqMaMmQiopIqTJhbBSo4jxjGUA7Jz9yM664/+mu+SDkLcfh/5S/jAKTh8g2cNyFM/Ia
         nHGm4TywEMmMk3CbTqbrJzLBqJ/Fzde4+VUlR94U6mT3+JdhtJy1UXqM1iENGo72mA9m
         kjSjqDI19X1AgMrOv7//20VLJGtqpByrE8vePSqlWwv8yg6mQ4UjhQjv73v39A5TXyx9
         Onmg==
X-Gm-Message-State: ANhLgQ2sxFgZX/xId/ICCUAD1i9QbiNweOGOYRxBfS9iHBMJajvHRsHL
        RJLdxF9U+1uc9QmrtWYTmgR4OFkt
X-Google-Smtp-Source: ADFU+vuDHuUoikmY5Gr7o1HJyRaU9kwYkUmRc3X73092JQrFbi28nPB6UyPTDH+i21FjoyyRtYVr1g==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr4756064wrw.236.1584630635262;
        Thu, 19 Mar 2020 08:10:35 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:34 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 01/14] fsnotify: tidy up FS_ and FAN_ constants
Date:   Thu, 19 Mar 2020 17:10:09 +0200
Message-Id: <20200319151022.31456-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Order by value, so the free value ranges are easier to find.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify_backend.h | 11 +++++------
 include/uapi/linux/fanotify.h    |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1915bdba2fad..db3cabb4600e 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -49,16 +49,15 @@
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 
 #define FS_EXCL_UNLINK		0x04000000	/* do not send events if object is unlinked */
-#define FS_ISDIR		0x40000000	/* event occurred against dir */
-#define FS_IN_ONESHOT		0x80000000	/* only send event once */
-
-#define FS_DN_RENAME		0x10000000	/* file renamed */
-#define FS_DN_MULTISHOT		0x20000000	/* dnotify multishot */
-
 /* This inode cares about things that happen to its children.  Always set for
  * dnotify and inotify. */
 #define FS_EVENT_ON_CHILD	0x08000000
 
+#define FS_DN_RENAME		0x10000000	/* file renamed */
+#define FS_DN_MULTISHOT		0x20000000	/* dnotify multishot */
+#define FS_ISDIR		0x40000000	/* event occurred against dir */
+#define FS_IN_ONESHOT		0x80000000	/* only send event once */
+
 #define FS_MOVE			(FS_MOVED_FROM | FS_MOVED_TO)
 
 /*
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index b9effa6f8503..2a1844edda47 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -25,9 +25,9 @@
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 
-#define FAN_ONDIR		0x40000000	/* event occurred against dir */
+#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-#define FAN_EVENT_ON_CHILD	0x08000000	/* interested in child events */
+#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
 
 /* helper events */
 #define FAN_CLOSE		(FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE) /* close */
-- 
2.17.1

