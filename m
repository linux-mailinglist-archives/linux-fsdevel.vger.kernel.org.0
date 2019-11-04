Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C95EDFB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 13:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfKDMHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 07:07:35 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37565 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDMHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:07:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so12058224lfp.4;
        Mon, 04 Nov 2019 04:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version;
        bh=05Qbf73gQ0toA2Xfkw3g/rFSTrBcU4YFjlIz358t1qI=;
        b=A16zq+PrXrda89BpaitoCAiJ+WteWQl99TGeWV42so1ZFlYnWsl5W4MV8qbUETUNuv
         rZFM39REju6O6gSXF01021P0Ed9hgHRSD2iJdp33/1ZbALO4ab8HTgmTsHs7CTpfO+D8
         b55EGTAQHvuNNAWTQrX/JDPUrf9DBSXejPaAhkXZdhgSBaJ5ZVbsYGc5cQoEb9h6p148
         XcBQspTI8WskrGFCkcjPdS01dADeWzoO3wcQjtyNEDWqDiEl5Gpwdsnqg0UNERPbcdFP
         2eDuAmN0ebsqhSt2fqYefgBroSYStZXy4MfA2UU7rZJWX0yQoZ8MGgGPlgXTIZK6vT5c
         rzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version;
        bh=05Qbf73gQ0toA2Xfkw3g/rFSTrBcU4YFjlIz358t1qI=;
        b=BzZoM08hjgKWN9qKiihARWCaBHUCKagQvvpVLw5SEVTd4rz0DvlhAPHFMrsFa8J1wg
         6GAaD2Olcvu5vN36JmWeglMMDHi1OUJrOQooQP8mRPELGv8+GvEEzQjn5U+vIexN6QG2
         6ZIn79mRBawCLDNeZ11twPm/7p1dJbzbCwuvLbkv+GA+9idRe5KxNGUnTsYAj+oN4QW6
         5hoDMaoDE+jPR2qYdFU609/P/Rok2ldiFEtf/uZG5FwNY/k6JaZEdQGVItkIQEBzixeC
         TvDAbsZF9spU41XbFZ+MImcpJCr78BC6ddvPGB+56Uw8H6u5VKU18Tixq5+rE+MZvAsc
         6Qdg==
X-Gm-Message-State: APjAAAXZ8ob/RmRVzMEZ+gZ34/p94d3urF6FWn19uT5vFtaX7rxe8Fge
        e6QxaH3cy9lx3yQvPKRg9S0=
X-Google-Smtp-Source: APXvYqznruvWXCtSEa9Ln41rtJKc7XirsTTQtRkFfDRYNLCgaLogrShxEfDhhCr/FppyZ98Dp2zIcw==
X-Received: by 2002:ac2:5502:: with SMTP id j2mr16057020lfk.174.1572869251864;
        Mon, 04 Nov 2019 04:07:31 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id a8sm7360040ljf.47.2019.11.04.04.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:07:31 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] proc: Allow restricting permissions in /proc/sys
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <ed51f7dd-50a2-fbf5-7ea8-4bab6d48279e@gmail.com>
Date:   Mon, 4 Nov 2019 14:07:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------9A3ED68DF98FEC2274BA081E"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9A3ED68DF98FEC2274BA081E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Several items in /proc/sys need not be accessible to unprivileged
tasks. Let the system administrator change the permissions, but only
to more restrictive modes than what the sysctl tables allow.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
v2: actually keep track of changed permissions instead of relying on 
inode cache
---
  fs/proc/proc_sysctl.c  | 42 ++++++++++++++++++++++++++++++++++++++----
  include/linux/sysctl.h |  1 +
  2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d80989b6c344..1f75382c49fd 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, 
int mask)
         if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
                 return -EACCES;

+       error = generic_permission(inode, mask);
+       if (error)
+               return error;
+
         head = grab_header(inode);
         if (IS_ERR(head))
                 return PTR_ERR(head);
@@ -835,17 +839,46 @@ static int proc_sys_permission(struct inode 
*inode, int mask)
  static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
  {
         struct inode *inode = d_inode(dentry);
+       struct ctl_table_header *head = grab_header(inode);
+       struct ctl_table *table = PROC_I(inode)->sysctl_entry;
         int error;

-       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
+       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
                 return -EPERM;

+       if (attr->ia_valid & ATTR_MODE) {
+               umode_t max_mode = 0777; /* Only these bits may change */
+
+               if (IS_ERR(head))
+                       return PTR_ERR(head);
+
+               if (!table) /* global root - r-xr-xr-x */
+                       max_mode &= ~0222;
+               else /*
+                     * Don't allow permissions to become less
+                     * restrictive than the sysctl table entry
+                     */
+                       max_mode &= table->mode;
+
+               /* Execute bits only allowed for directories */
+               if (!S_ISDIR(inode->i_mode))
+                       max_mode &= ~0111;
+
+               if (attr->ia_mode & ~S_IFMT & ~max_mode)
+                       return -EPERM;
+       }
+
         error = setattr_prepare(dentry, attr);
         if (error)
                 return error;

         setattr_copy(inode, attr);
         mark_inode_dirty(inode);
+
+       if (table)
+               table->current_mode = inode->i_mode;
+       sysctl_head_finish(head);
+
         return 0;
  }

@@ -861,7 +894,7 @@ static int proc_sys_getattr(const struct path *path, 
struct kstat *stat,

         generic_fillattr(inode, stat);
         if (table)
-               stat->mode = (stat->mode & S_IFMT) | table->mode;
+               stat->mode = (stat->mode & S_IFMT) | table->current_mode;

         sysctl_head_finish(head);
         return 0;
@@ -981,7 +1014,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set 
*set,
         memcpy(new_name, name, namelen);
         new_name[namelen] = '\0';
         table[0].procname = new_name;
-       table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
+       table[0].current_mode = table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
         init_header(&new->header, set->dir.header.root, set, node, table);

         return new;
@@ -1155,6 +1188,7 @@ static int sysctl_check_table(const char *path, 
struct ctl_table *table)
                 if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
                         err |= sysctl_err(path, table, "bogus .mode 0%o",
                                 table->mode);
+               table->current_mode = table->mode;
         }
         return err;
  }
@@ -1192,7 +1226,7 @@ static struct ctl_table_header *new_links(struct 
ctl_dir *dir, struct ctl_table
                 int len = strlen(entry->procname) + 1;
                 memcpy(link_name, entry->procname, len);
                 link->procname = link_name;
-               link->mode = S_IFLNK|S_IRWXUGO;
+               link->current_mode = link->mode = S_IFLNK|S_IRWXUGO;
                 link->data = link_root;
                 link_name += len;
         }
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6df477329b76..7c519c35bf9c 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -126,6 +126,7 @@ struct ctl_table
         void *data;
         int maxlen;
         umode_t mode;
+       umode_t current_mode;
         struct ctl_table *child;        /* Deprecated */
         proc_handler *proc_handler;     /* Callback for text formatting */
         struct ctl_table_poll *poll;
-- 
2.24.0.rc1


--------------9A3ED68DF98FEC2274BA081E
Content-Type: text/x-diff;
 name="0001-proc-Allow-restricting-permissions-in-proc-sys.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-proc-Allow-restricting-permissions-in-proc-sys.patch"

From 3cde64e0aa2734c335355ee6d0d9f12c1f1e8a87 Mon Sep 17 00:00:00 2001
From: Topi Miettinen <toiwoton@gmail.com>
Date: Sun, 3 Nov 2019 16:36:43 +0200
Subject: [PATCH] proc: Allow restricting permissions in /proc/sys

Several items in /proc/sys need not be accessible to unprivileged
tasks. Let the system administrator change the permissions, but only
to more restrictive modes than what the sysctl tables allow.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 fs/proc/proc_sysctl.c  | 42 ++++++++++++++++++++++++++++++++++++++----
 include/linux/sysctl.h |  1 +
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d80989b6c344..1f75382c49fd 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int mask)
 	if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
 		return -EACCES;
 
+	error = generic_permission(inode, mask);
+	if (error)
+		return error;
+
 	head = grab_header(inode);
 	if (IS_ERR(head))
 		return PTR_ERR(head);
@@ -835,17 +839,46 @@ static int proc_sys_permission(struct inode *inode, int mask)
 static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
+	struct ctl_table_header *head = grab_header(inode);
+	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 	int error;
 
-	if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
+	if (attr->ia_valid & (ATTR_UID | ATTR_GID))
 		return -EPERM;
 
+	if (attr->ia_valid & ATTR_MODE) {
+		umode_t max_mode = 0777; /* Only these bits may change */
+
+		if (IS_ERR(head))
+			return PTR_ERR(head);
+
+		if (!table) /* global root - r-xr-xr-x */
+			max_mode &= ~0222;
+		else /*
+		      * Don't allow permissions to become less
+		      * restrictive than the sysctl table entry
+		      */
+			max_mode &= table->mode;
+
+		/* Execute bits only allowed for directories */
+		if (!S_ISDIR(inode->i_mode))
+			max_mode &= ~0111;
+
+		if (attr->ia_mode & ~S_IFMT & ~max_mode)
+			return -EPERM;
+	}
+
 	error = setattr_prepare(dentry, attr);
 	if (error)
 		return error;
 
 	setattr_copy(inode, attr);
 	mark_inode_dirty(inode);
+
+	if (table)
+		table->current_mode = inode->i_mode;
+	sysctl_head_finish(head);
+
 	return 0;
 }
 
@@ -861,7 +894,7 @@ static int proc_sys_getattr(const struct path *path, struct kstat *stat,
 
 	generic_fillattr(inode, stat);
 	if (table)
-		stat->mode = (stat->mode & S_IFMT) | table->mode;
+		stat->mode = (stat->mode & S_IFMT) | table->current_mode;
 
 	sysctl_head_finish(head);
 	return 0;
@@ -981,7 +1014,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	memcpy(new_name, name, namelen);
 	new_name[namelen] = '\0';
 	table[0].procname = new_name;
-	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	table[0].current_mode = table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	init_header(&new->header, set->dir.header.root, set, node, table);
 
 	return new;
@@ -1155,6 +1188,7 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
 			err |= sysctl_err(path, table, "bogus .mode 0%o",
 				table->mode);
+		table->current_mode = table->mode;
 	}
 	return err;
 }
@@ -1192,7 +1226,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 		int len = strlen(entry->procname) + 1;
 		memcpy(link_name, entry->procname, len);
 		link->procname = link_name;
-		link->mode = S_IFLNK|S_IRWXUGO;
+		link->current_mode = link->mode = S_IFLNK|S_IRWXUGO;
 		link->data = link_root;
 		link_name += len;
 	}
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6df477329b76..7c519c35bf9c 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -126,6 +126,7 @@ struct ctl_table
 	void *data;
 	int maxlen;
 	umode_t mode;
+	umode_t current_mode;
 	struct ctl_table *child;	/* Deprecated */
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
-- 
2.24.0.rc1


--------------9A3ED68DF98FEC2274BA081E--
