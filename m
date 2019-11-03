Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DAEED3A1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfKCOzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 09:55:55 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41340 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfKCOzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 09:55:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so10360450lfb.8;
        Sun, 03 Nov 2019 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=hcEBVwLdQ7KFp2y3GqExvxoN2G3Q32x8oD7k9TAOa3Q=;
        b=tVl+SWCqXTBfPwaPD/c9yz/BhYqH5BLokn6etckg6iJzQ+t6qFfyFO56t9oSsmdw3i
         Cd2zIZ7MIGIF7pb6tdc3OwMderKAHHRjzJ97VCta54w6i+jlpMwgAKpOLFt+ul4xPcGX
         r65+uVKiAcP1gOKbpDBlzXRsWd9/SHrbcbaXxRoR6wtCumt8oZxEowpKiSRL97xuMH4b
         OaGQOK3RBxGLUnQm3RQUjGbS1FpqM1QFWpJczfY1mhFH2n1FHdGEWcwBura5dU6ChH7n
         DZmIiy8HrPvQ5k7RFdzbTNtSWzdDz9CK0s8YGgg5DCUfiq9ObrR8eKHFkDzCh8/g7dq6
         yUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=hcEBVwLdQ7KFp2y3GqExvxoN2G3Q32x8oD7k9TAOa3Q=;
        b=KdFlxA9w3pqTSVusqLh1TQKr4sx72/oatWA1ep+t1G1Zdxb54wYe9Ty5uc/OuwbZHo
         oqq/fbZzHbFZDg+eJ25j63FWEtkYj/G7Usx8Eo/rSeDqw6GHwv7v0Hk9XsmBb+Xgu9IT
         /eXV7BCjoUOxXWZmej3rmYNnpdWIeee2Vo/2uCh+v7BaEQHcdcsUZ7mW0lTl8dnKJZPf
         YOCbxvnNvaSZ5ISn1ymitCYumHVwDXUnSARP8xWfKhKCDk4EGoILUwAlYWwfF2+K5Ocs
         oKoTECJLJrBacQHxONp/ORDlaHTGGSJjbN7hhY3puI8QpfEJ7a1v/b9BvXeBJBM3eyFY
         lQGQ==
X-Gm-Message-State: APjAAAUquDbfuzdSJMeikI5hEbukELo0ayXenWC9pN9Ek1g/KS/B2vw1
        IO7R3SSAw1TEQmk/0PH3jJuqB+P6
X-Google-Smtp-Source: APXvYqxh2UEMuAK4eJp+YttAtwqIEOogKlFvou7FwWw32vQtWjZ1l4rX7SBEIXwDp7rxIa1WgVToCQ==
X-Received: by 2002:a19:c6d6:: with SMTP id w205mr12599036lff.17.1572792951003;
        Sun, 03 Nov 2019 06:55:51 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id h14sm4937581ljl.43.2019.11.03.06.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2019 06:55:50 -0800 (PST)
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] Allow restricting permissions in /proc/sys
Message-ID: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
Date:   Sun, 3 Nov 2019 16:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2C999EEEA5A4675594E98B4F"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2C999EEEA5A4675594E98B4F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Several items in /proc/sys need not be accessible to unprivileged
tasks. Let the system administrator change the permissions, but only
to more restrictive modes than what the sysctl tables allow.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
  fs/proc/proc_sysctl.c | 41 +++++++++++++++++++++++++++++++----------
  1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d80989b6c344..88c4ca7d2782 100644
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
@@ -837,9 +841,35 @@ static int proc_sys_setattr(struct dentry *dentry, 
struct iattr *attr)
         struct inode *inode = d_inode(dentry);
         int error;

-       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
+       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
                 return -EPERM;

+       if (attr->ia_valid & ATTR_MODE) {
+               struct ctl_table_header *head = grab_header(inode);
+               struct ctl_table *table = PROC_I(inode)->sysctl_entry;
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
+               sysctl_head_finish(head);
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
@@ -853,17 +883,8 @@ static int proc_sys_getattr(const struct path 
*path, struct kstat *stat,
                             u32 request_mask, unsigned int query_flags)
  {
         struct inode *inode = d_inode(path->dentry);
-       struct ctl_table_header *head = grab_header(inode);
-       struct ctl_table *table = PROC_I(inode)->sysctl_entry;
-
-       if (IS_ERR(head))
-               return PTR_ERR(head);

         generic_fillattr(inode, stat);
-       if (table)
-               stat->mode = (stat->mode & S_IFMT) | table->mode;
-
-       sysctl_head_finish(head);
         return 0;
  }

-- 
2.24.0.rc1


--------------2C999EEEA5A4675594E98B4F
Content-Type: text/x-diff;
 name="0001-Allow-restricting-permissions-in-proc-sys.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Allow-restricting-permissions-in-proc-sys.patch"

From 14ad2d9034ecb43b60f59f6422e597a780c65cd9 Mon Sep 17 00:00:00 2001
From: Topi Miettinen <toiwoton@gmail.com>
Date: Sun, 3 Nov 2019 16:36:43 +0200
Subject: [PATCH] Allow restricting permissions in /proc/sys

Several items in /proc/sys need not be accessible to unprivileged
tasks. Let the system administrator change the permissions, but only
to more restrictive modes than what the sysctl tables allow.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 fs/proc/proc_sysctl.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d80989b6c344..88c4ca7d2782 100644
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
@@ -837,9 +841,35 @@ static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
+	if (attr->ia_valid & (ATTR_UID | ATTR_GID))
 		return -EPERM;
 
+	if (attr->ia_valid & ATTR_MODE) {
+		struct ctl_table_header *head = grab_header(inode);
+		struct ctl_table *table = PROC_I(inode)->sysctl_entry;
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
+		sysctl_head_finish(head);
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
@@ -853,17 +883,8 @@ static int proc_sys_getattr(const struct path *path, struct kstat *stat,
 			    u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	struct ctl_table_header *head = grab_header(inode);
-	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
-
-	if (IS_ERR(head))
-		return PTR_ERR(head);
 
 	generic_fillattr(inode, stat);
-	if (table)
-		stat->mode = (stat->mode & S_IFMT) | table->mode;
-
-	sysctl_head_finish(head);
 	return 0;
 }
 
-- 
2.24.0.rc1


--------------2C999EEEA5A4675594E98B4F--
