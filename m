Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E931B28BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 15:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgDUN6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 09:58:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729015AbgDUN57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587477477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPnP4qV6sDaGZ2bSbejYPzydlvKfgMg0o/pB9q3go8E=;
        b=flnIJNRYhz6k5uf28deeJaZr1AZzKWUshWdx0GvoCS61yZzs24C5VrhHB8WOUUBPY+mIC/
        ucoMZCWcKvmgMb7d4sOPunzkenploPDxFxQq4/tItR/HSAWZjkVkB7CjFrtNHCg0vFwC9P
        cxEChLSAZCCrPhqp+bIqXGFQgzU4bV8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-Usm0YEd1Nvi9k6VyNc_JJw-1; Tue, 21 Apr 2020 09:57:56 -0400
X-MC-Unique: Usm0YEd1Nvi9k6VyNc_JJw-1
Received: by mail-wr1-f71.google.com with SMTP id v9so4837644wrt.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 06:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPnP4qV6sDaGZ2bSbejYPzydlvKfgMg0o/pB9q3go8E=;
        b=Kwa2XFujWs/mwfP/iTjSKFZYiagrF0kx6FnEbEIjwAx/j6awwAGuTfH3MY8oxCrhHU
         256NPqI45Tkje1xPILIqECH/ijk3MtOJsIL2IjJSYsvrV0KACcVExisH6z9m7M49goTM
         IiCD5XTCVwsP24eJZ77VDVZA1Jn+KNtBBws7bSbf1x+ItGxfIOUeFBv/NkVwtgVT/BvG
         NCEqAoXFbTWHsm+ulE4RTBytx34MtjcJS+eCdwdPoZoVA25zmZsP5tL2VNwL0w0WpEJ5
         f6qAaukjCd/umk8yWAs1WY8GjQANYYd2p0ZLr00zM3HmI6Mwbex4HGAoxzV/9CDi0Xoe
         9/JQ==
X-Gm-Message-State: AGi0Puang8X1JhNx7jvKppLZ3EE1MVNXz7ewj3iIDY7XR2gyO7aZnMSo
        J67kbHGcKGYD2KDh7JoGqsmWUxw1YqlwxYjrerd7GIggSJmiN1oFaKEumuYX07FazZKzhHVDaOi
        GjrGQQftiYhA9N8hLQwwcmYl0cg==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr5188191wmm.48.1587477474540;
        Tue, 21 Apr 2020 06:57:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypImms4WydeI5+8l3z5lWKRrEMa+0XfWFGcGeKI2hzBQZu8YXbxqfuv1YC/rok2n8KUUpE7+Vg==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr5188144wmm.48.1587477474268;
        Tue, 21 Apr 2020 06:57:54 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.194])
        by smtp.gmail.com with ESMTPSA id f23sm3562989wml.4.2020.04.21.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:57:53 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 7/7] tracefs: switch to simplefs inode creation API
Date:   Tue, 21 Apr 2020 15:57:41 +0200
Message-Id: <20200421135741.30657-5-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200421135119.30007-1-eesposit@redhat.com>
References: <20200421135119.30007-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no semantic change intended; the code in the libfs.c
functions in fact was derived from debugfs and tracefs code.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/tracefs/inode.c | 86 ++++------------------------------------------
 1 file changed, 7 insertions(+), 79 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 370eb38ff1ad..bceaa4f45da2 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -308,57 +308,6 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
-{
-	struct dentry *dentry;
-	int error;
-
-	pr_debug("tracefs: creating file '%s'\n",name);
-
-	error = simple_pin_fs(&tracefs, &trace_fs_type);
-	if (error)
-		return ERR_PTR(error);
-
-	/* If the parent is not specified, we create it in the root.
-	 * We need the root dentry to do this, which is in the super
-	 * block. A pointer to that is in the struct vfsmount that we
-	 * have around.
-	 */
-	if (!parent)
-		parent = tracefs.mount->mnt_root;
-
-	inode_lock(parent->d_inode);
-	if (unlikely(IS_DEADDIR(parent->d_inode)))
-		dentry = ERR_PTR(-ENOENT);
-	else
-		dentry = lookup_one_len(name, parent, strlen(name));
-	if (!IS_ERR(dentry) && dentry->d_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-EEXIST);
-	}
-
-	if (IS_ERR(dentry)) {
-		inode_unlock(parent->d_inode);
-		simple_release_fs(&tracefs);
-	}
-
-	return dentry;
-}
-
-static struct dentry *failed_creating(struct dentry *dentry)
-{
-	inode_unlock(dentry->d_parent->d_inode);
-	dput(dentry);
-	simple_release_fs(&tracefs);
-	return NULL;
-}
-
-static struct dentry *end_creating(struct dentry *dentry)
-{
-	inode_unlock(dentry->d_parent->d_inode);
-	return dentry;
-}
-
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
@@ -395,49 +344,28 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (security_locked_down(LOCKDOWN_TRACEFS))
 		return NULL;
 
-	if (!(mode & S_IFMT))
-		mode |= S_IFREG;
-	BUG_ON(!S_ISREG(mode));
-	dentry = start_creating(name, parent);
-
+	dentry = simplefs_create_file(&tracefs, &trace_fs_type,
+				      name, mode, parent, data, &inode);
 	if (IS_ERR(dentry))
 		return NULL;
 
-	inode = tracefs_get_inode(dentry->d_sb);
-	if (unlikely(!inode))
-		return failed_creating(dentry);
-
-	inode->i_mode = mode;
 	inode->i_fop = fops ? fops : &tracefs_file_operations;
-	inode->i_private = data;
-	d_instantiate(dentry, inode);
-	fsnotify_create(dentry->d_parent->d_inode, dentry);
-	return end_creating(dentry);
+	return simplefs_finish_dentry(dentry, inode);
 }
 
 static struct dentry *__create_dir(const char *name, struct dentry *parent,
 				   const struct inode_operations *ops)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry;
 	struct inode *inode;
 
+	dentry = simplefs_create_dir(&tracefs, &trace_fs_type,
+				     name, 0755, parent, &inode);
 	if (IS_ERR(dentry))
 		return NULL;
 
-	inode = tracefs_get_inode(dentry->d_sb);
-	if (unlikely(!inode))
-		return failed_creating(dentry);
-
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_op = ops;
-	inode->i_fop = &simple_dir_operations;
-
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inc_nlink(inode);
-	d_instantiate(dentry, inode);
-	inc_nlink(dentry->d_parent->d_inode);
-	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
-	return end_creating(dentry);
+	return simplefs_finish_dentry(dentry, inode);
 }
 
 /**
-- 
2.25.2

