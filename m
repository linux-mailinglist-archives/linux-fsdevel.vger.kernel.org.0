Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C3A5AFF8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfF3Ny4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:54:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44374 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3Nyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:54:55 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so22645208iob.11;
        Sun, 30 Jun 2019 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PUbroqafNA7LnH2ytfPz3gI5UzOM6WBBM2I/ieEMmQ=;
        b=WdMWvAIaoyuYYCt2Dms0FpgzRxhNHOWbrG9WgPa/M8V2VWJ8HhvxMmoIOF56f2rX6A
         GggasXzcpza9oJEChb5wnL02D9m9sroPo85Na+1X9xzDjpZkPg1J/wr0fdGNSf9wfLR8
         9v2D0ARaC/+4bFLTm38QpfAXkGjDtEOKQwgtNL5XG6B067KYAMV7gLS3RSqWagNpERF+
         VyaA/858WR0C24yuMh7BRFu07s6JVjZLy8h1861b5/tmdMckPIKElIqBoSXgCPj/tNC5
         +O4Ml1svynCE379+H1eYUa20kkLofG2QBaWXPeBz0hv9fx3oBPLt/jpzZenPCG8zjelZ
         DrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PUbroqafNA7LnH2ytfPz3gI5UzOM6WBBM2I/ieEMmQ=;
        b=JRGwc0rSRF/adp8gwGLevt7nXQGkj9FQuNTnhV6ALZYYchUtl8Rl8DSIskUBPaxgV7
         Tghu8RyNYxagaWrj2xxDixsYaSSjYaquRmebp5xxYH2vLcadrrqbRd7+LkFxNsydkQPn
         BXH3kchfw2eaA28zruMGqYqI/QqDb2L4/4a6elMgO+RS6MC6EIvAu/rJi6EOA+n9lm09
         9P4wIG/50rfD51nMmPtZkUPRTjOGM94oKu6FfQyxyFLjMvZKzPJlZ9aw8rWRFd6nohXR
         YWxrR4UwL/WLR+DZOFpPWAsbfSswioK9fZlonhFJxLwdFU+/1LhMAf7BXfd1ghXm5bQd
         hAbA==
X-Gm-Message-State: APjAAAVmmpySDJym8V30uC29r9q6X4eZ6m/AT5yYVHagy0R7JLAcXvu2
        1tFuZSr7eIZA3ktU7X7OplP+T543Wg==
X-Google-Smtp-Source: APXvYqy/DVLuq156Hm9W1kOZs+lRQhT4/L3Nd+DlYZ74ERfbENl2AC0wUhbriMWVzFGfnEA5okfWPA==
X-Received: by 2002:a5d:9ec4:: with SMTP id a4mr17670817ioe.125.1561902893649;
        Sun, 30 Jun 2019 06:54:53 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.54.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:54:52 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/16] notify: export symbols for use by the knfsd file cache
Date:   Sun, 30 Jun 2019 09:52:27 -0400
Message-Id: <20190630135240.7490-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-3-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

The knfsd file cache will need to detect when files are unlinked, so that
it can close the associated cached files. Export a minimal set of notifier
functions to allow it to do so.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/notify/fsnotify.h             | 2 --
 fs/notify/group.c                | 2 ++
 fs/notify/mark.c                 | 6 ++++++
 include/linux/fsnotify_backend.h | 2 ++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 5a00121fb219..f3462828a0e2 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -54,8 +54,6 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
 {
 	fsnotify_destroy_marks(&sb->s_fsnotify_marks);
 }
-/* Wait until all marks queued for destruction are destroyed */
-extern void fsnotify_wait_marks_destroyed(void);
 
 /*
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
diff --git a/fs/notify/group.c b/fs/notify/group.c
index 0391190305cc..133f723aca07 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -108,6 +108,7 @@ void fsnotify_put_group(struct fsnotify_group *group)
 	if (refcount_dec_and_test(&group->refcnt))
 		fsnotify_final_destroy_group(group);
 }
+EXPORT_SYMBOL_GPL(fsnotify_put_group);
 
 /*
  * Create a new fsnotify_group and hold a reference for the group returned.
@@ -137,6 +138,7 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
 
 	return group;
 }
+EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
 
 int fsnotify_fasync(int fd, struct file *file, int on)
 {
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 99ddd126f6f0..1d96216dffd1 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -276,6 +276,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 	queue_delayed_work(system_unbound_wq, &reaper_work,
 			   FSNOTIFY_REAPER_DELAY);
 }
+EXPORT_SYMBOL_GPL(fsnotify_put_mark);
 
 /*
  * Get mark reference when we found the mark via lockless traversal of object
@@ -430,6 +431,7 @@ void fsnotify_destroy_mark(struct fsnotify_mark *mark,
 	mutex_unlock(&group->mark_mutex);
 	fsnotify_free_mark(mark);
 }
+EXPORT_SYMBOL_GPL(fsnotify_destroy_mark);
 
 /*
  * Sorting function for lists of fsnotify marks.
@@ -685,6 +687,7 @@ int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
 	mutex_unlock(&group->mark_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(fsnotify_add_mark);
 
 /*
  * Given a list of marks, find the mark associated with given group. If found
@@ -711,6 +714,7 @@ struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
 	spin_unlock(&conn->lock);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(fsnotify_find_mark);
 
 /* Clear any marks in a group with given type mask */
 void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
@@ -809,6 +813,7 @@ void fsnotify_init_mark(struct fsnotify_mark *mark,
 	mark->group = group;
 	WRITE_ONCE(mark->connector, NULL);
 }
+EXPORT_SYMBOL_GPL(fsnotify_init_mark);
 
 /*
  * Destroy all marks in destroy_list, waits for SRCU period to finish before
@@ -837,3 +842,4 @@ void fsnotify_wait_marks_destroyed(void)
 {
 	flush_delayed_work(&reaper_work);
 }
+EXPORT_SYMBOL_GPL(fsnotify_wait_marks_destroyed);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d4844cad2c2b..7e096f4dd4ce 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -476,6 +476,8 @@ extern void fsnotify_destroy_mark(struct fsnotify_mark *mark,
 extern void fsnotify_detach_mark(struct fsnotify_mark *mark);
 /* free mark */
 extern void fsnotify_free_mark(struct fsnotify_mark *mark);
+/* Wait until all marks queued for destruction are destroyed */
+extern void fsnotify_wait_marks_destroyed(void);
 /* run all the marks in a group, and clear all of the marks attached to given object type */
 extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group, unsigned int type);
 /* run all the marks in a group, and clear all of the vfsmount marks */
-- 
2.21.0

