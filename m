Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C0913AD50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 16:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgANPRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 10:17:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANPRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:17:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so12546513wrn.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LxZjALu8+JdM1LNMX2SUCsKVBqP/y1yL79+aF6PkR+s=;
        b=QGN82Wcugzm4KOV7mdzrd2Y1nkklF+f8yQYPgDNMoOdpX+rW4TP/CStsKMqCbDlTaW
         hZcPmMBtEO7C9Xxg/ydEi+b+YgEK1NCo9WPTlibc/+QgEJJVRCWZ78gEmDQGyByW+KIZ
         EJaCRnsRymiQjqT+jPUl0cItfEv3T8mDuKWN/R8lXUppuzm5kH7tGaqlqYd0D0c9Y5+i
         Ngc7+tXNqYP4Ig1+twdI7bob7Zzcl9FTLJGtHFtxQxdWyJmNfkN4SQjKHiGgHD80NVqV
         1YBZBtSn0gtu/A/egLY3Yp7T/g+D4VNzg5q2gha4BlNdq7K8A5NOtNHO7AMSpLSZuOFc
         cl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LxZjALu8+JdM1LNMX2SUCsKVBqP/y1yL79+aF6PkR+s=;
        b=c3+N8nJzDDSMcWAejcluGnZz8yfJQ34RjFfa8h7voLFxxgStcDS6GPhyC2/a8wfwNc
         L5CtPWdO3m/tcflUz7q3e4YCQ1mMVUP3DLuXd9GG8669Ni3sR23hUGZuLxmuRVZ7e5Ry
         DWd0y82nU0wlX7ESGd0eR0VTx9YSDSHJn/DWGp8KfNj/XlRY7OFPjBmyAjQIjfkj/sOl
         tSw3Y+LNntpNEjNaG7BTeJbJpuuVe7uJjr0PPUkmTJ/49Zr5LZgTw3SkHsgqVH7FdI7r
         JX3P8PXHXpKfD2PPwMmn5ga1NizdVKT2KaJN+7yQnXCP9bbn4XkE/8JwcrUDxpU00/PU
         KrqA==
X-Gm-Message-State: APjAAAXEEx3VMgKf6IudWIJvCab0buTBA40Paejg2NAZWRHmARdexq5s
        42IR5fS3cpYUiWq7BJRuSr0=
X-Google-Smtp-Source: APXvYqyM6mBR/xxcLJ+1wNSVE+c/dI7jN/himFdGC58ugdDeykc5LitqL+PsuclVJlJF/cx+uRybOQ==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr25822874wrs.184.1579015023141;
        Tue, 14 Jan 2020 07:17:03 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s19sm18276993wmj.33.2020.01.14.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:17:02 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/6] fsnotify: tidy up FS_ and FAN_ constants
Date:   Tue, 14 Jan 2020 17:16:50 +0200
Message-Id: <20200114151655.29473-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114151655.29473-1-amir73il@gmail.com>
References: <20200114151655.29473-1-amir73il@gmail.com>
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

