Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87A51612E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgBQNPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36139 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgBQNPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so18419087wma.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LxZjALu8+JdM1LNMX2SUCsKVBqP/y1yL79+aF6PkR+s=;
        b=dsyHnhC1dEZSEVfdJunhTgYT6RpfFBKlVB8FAqSmut9LvXMU4yLJv1aJsiZy/oj828
         6wASZhFWriGkUlM9HdFvnMHC7UM8HAIbZAZ3MYQUBCUb8jt9tADIRZ10f8cbV7BFI5sy
         6iUBqOJEzS2OMDVZDd3Wfk03bQ4v+Qz4Oxcy3MIYtLXyu10f7/y8WtGu8yq5Wv2ToKPh
         NgWyFp6Kg4RJoM5CpeWQR0dS8ryoCtFKw3hR+pJEy0xaf1/HtbQ4v7tYs+PdaX84/3Tw
         X+SQuGPeZJSwWXrN0dX4r3SZ9d1D3INaD6jSQkNhqUrGatQfyvzRj1SW3aVACLHC0uGV
         tnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LxZjALu8+JdM1LNMX2SUCsKVBqP/y1yL79+aF6PkR+s=;
        b=aD8mZxkCiPd0VJdw18Wyha0QY/D8Bztt75L0rMlFzS5e9CkZLEXcCc/pOgMFupQa7E
         Hrt6l671vpL49w9yqR+lpBPOAgCGCiGCN664+PzsYQZiKzmRaTb7RTJunNEYVYajk7Af
         oy7jX0AVmfJONSyeoXHwAmyS2c3IgiQxyYIH2g0FrSC0NXzzgWvKNxEUWUQMYgSRcPr/
         ewShI3kADbfl1y6mkO+KVSfvmkhoFn80tzSym/pNTezKg9tFRyhJmAa0OCyHlftxgt2D
         bXYzTA8nhkWaSKB6Y0rGg4iafakqjSZcjM6ab+MFddpBCoQNRToieFL1gbSi5L5pgyDt
         KX7w==
X-Gm-Message-State: APjAAAU40Ei3HutZK+3WBN2fYj43QIlHcx0mo3HEY1KO/qaqfqIz8J7Z
        UD5ojL7OnnmGlPcHZex8dCGrnZXT
X-Google-Smtp-Source: APXvYqzxTJWdq8oRIU1Q+saM4dS/HZ5f+IFDG73EYLZD/5bk1x9GrYFOw3oCbYuVv+x5FQhTfKgdCg==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr22977938wmi.51.1581945308365;
        Mon, 17 Feb 2020 05:15:08 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:07 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/16] fsnotify: tidy up FS_ and FAN_ constants
Date:   Mon, 17 Feb 2020 15:14:40 +0200
Message-Id: <20200217131455.31107-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
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

