Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0569D437
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 20:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjBTTjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 14:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjBTTi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:56 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5CEB6E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:30 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7A4D13F20F
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921905;
        bh=TXvnYBcpsks2j9HUsorAhOJizmKzS+zfkd4wCIIYO2g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=pesenB0Raf23Dj2cB3XTaIl661rZ4cuavoA+j+/X2zv8gw34uqbhbBoRqrdXfu5Wh
         tyR3HgIMRRXeWHMtCW7ApVKBJrX4eNkqooCjZpiuQVdo2aw8Ogad6WFNt1vdFhNe9+
         5HjZ7S0RMj2Ks2cMnBCNdBztB3o18KRJ72XFR+2uIJz1Z5ENdYvGQvUBszQsZUj2/L
         wJGXctyxmSS15NXHajtuEt0lRxj5kuvwhx+oYcIiKLGl4pyWd7fYx8rf/hNxDRDPhv
         Dvv2KI/hoqtCLpmJaKBUCfz4C/UcHsozKPhAU2iAJpi23R37p1uQjB1dfeohxIASy0
         l1iy+T9eXtK1g==
Received: by mail-ed1-f69.google.com with SMTP id ee6-20020a056402290600b004ad51f8fc36so2527615edb.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXvnYBcpsks2j9HUsorAhOJizmKzS+zfkd4wCIIYO2g=;
        b=m8mQA7dRlih5I53ys21HO4z/f5tr51uVRhSPqX9oq5OtoYGZCkRdNazbE3XWSlBPA5
         m9tYZZXT4CpJSfEZqGGXRCvs8f9ra0WQ4zcyspsCr8FRb+gcp4IlldqiEuFrZqt6ZEkd
         b7jOTckqObAyfDlgB40TXDlKvdon2xTb8OmVgPAG0MbgPx6YcmSWjvAKTUb3gE2mfmYT
         FllOd+B2JLAIurbSbcqfel+64fd2m92Cmh2K7VZtSu+jF7Ui5qG93PCuef7zTjz3c0Bb
         c7H+TFPxJZ6RiWDZi9A5A0dmFfj8PZonrDulM1PmLBCWjgxDHyCWv1N8kLWHAEckRI7g
         zFGQ==
X-Gm-Message-State: AO0yUKVcMiKBSfUoUmp00mbTQNTMg7Pn2V20og9zlUBeTcfzZuEJ28yU
        6BQbIsB4Y2YqXW2H61b/tXgzSOtOsVyQYJvzdgDgGGSxGC5TOPJyJmqNxFjkgySJW0xV36uWRRT
        4fmJ7lzuvIkLYtki6J5QmYItx699RTb4qQWzAJMEShf0=
X-Received: by 2002:a17:906:fcd5:b0:8b1:81eb:158f with SMTP id qx21-20020a170906fcd500b008b181eb158fmr13780358ejb.62.1676921904505;
        Mon, 20 Feb 2023 11:38:24 -0800 (PST)
X-Google-Smtp-Source: AK7set+zc9gLLqzwJi8cf9vJZoGnswWczh9rYsXB3je/ww+BatP9c9Egec/MMFNNrEczNQTJZ5/tGw==
X-Received: by 2002:a17:906:fcd5:b0:8b1:81eb:158f with SMTP id qx21-20020a170906fcd500b008b181eb158fmr13780341ejb.62.1676921904319;
        Mon, 20 Feb 2023 11:38:24 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:23 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 8/9] namespace: add sb_revalidate_bindmounts helper
Date:   Mon, 20 Feb 2023 20:37:53 +0100
Message-Id: <20230220193754.470330-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Useful if for some reason bindmounts root dentries get invalidated
but it's needed to revalidate existing bindmounts without remounting.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/namespace.c                | 90 +++++++++++++++++++++++++++++++++++
 include/linux/mnt_namespace.h |  3 ++
 2 files changed, 93 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..88491f9c8bbd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -682,6 +682,96 @@ static int mnt_make_readonly(struct mount *mnt)
 	return ret;
 }
 
+struct bind_mount_list_item {
+	struct list_head list;
+	struct vfsmount *mnt;
+};
+
+/*
+ * sb_revalidate_bindmounts - Relookup/reset bindmounts root dentries
+ *
+ * Useful if for some reason bindmount root dentries get invalidated
+ * but it's needed to revalidate existing bindmounts without remounting.
+ */
+int sb_revalidate_bindmounts(struct super_block *sb)
+{
+	struct mount *mnt;
+	struct bind_mount_list_item *bmnt, *next;
+	int err = 0;
+	struct vfsmount *root_mnt = NULL;
+	LIST_HEAD(mnt_to_update);
+	char *buf;
+
+	buf = (char *) __get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	lock_mount_hash();
+	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
+		/* we only want to touch bindmounts */
+		if (mnt->mnt.mnt_root == sb->s_root) {
+			if (!root_mnt)
+				root_mnt = mntget(&mnt->mnt);
+
+			continue;
+		}
+
+		bmnt = kzalloc(sizeof(struct bind_mount_list_item), GFP_NOWAIT | __GFP_NOWARN);
+		if (!bmnt) {
+			err = -ENOMEM;
+			goto exit;
+		}
+
+		bmnt->mnt = mntget(&mnt->mnt);
+		list_add_tail(&bmnt->list, &mnt_to_update);
+	}
+	unlock_mount_hash();
+
+	/* TODO: get rid of this limitation */
+	if (!root_mnt) {
+		err = -ENOENT;
+		goto exit;
+	}
+
+	list_for_each_entry_safe(bmnt, next, &mnt_to_update, list) {
+		struct vfsmount *cur_mnt = bmnt->mnt;
+		struct path path;
+		struct dentry *old_root;
+		char *p;
+
+		p = dentry_path(cur_mnt->mnt_root, buf, PAGE_SIZE);
+		if (IS_ERR(p))
+			goto exit;
+
+		/* TODO: are these lookup flags fully safe and correct? */
+		err = vfs_path_lookup(root_mnt->mnt_root, root_mnt,
+				p, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT|LOOKUP_REVAL, &path);
+		if (err)
+			goto exit;
+
+		/* replace bindmount root dentry */
+		lock_mount_hash();
+		old_root = cur_mnt->mnt_root;
+		cur_mnt->mnt_root = dget(path.dentry);
+		dput(old_root);
+		unlock_mount_hash();
+
+		path_put(&path);
+	}
+
+exit:
+	free_page((unsigned long) buf);
+	mntput(root_mnt);
+	list_for_each_entry_safe(bmnt, next, &mnt_to_update, list) {
+		list_del(&bmnt->list);
+		mntput(bmnt->mnt);
+		kfree(bmnt);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(sb_revalidate_bindmounts);
+
 int sb_prepare_remount_readonly(struct super_block *sb)
 {
 	struct mount *mnt;
diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
index 8f882f5881e8..20ac29e702f5 100644
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@ -3,6 +3,7 @@
 #define _NAMESPACE_H_
 #ifdef __KERNEL__
 
+struct super_block;
 struct mnt_namespace;
 struct fs_struct;
 struct user_namespace;
@@ -13,6 +14,8 @@ extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
 extern void put_mnt_ns(struct mnt_namespace *ns);
 extern struct ns_common *from_mnt_ns(struct mnt_namespace *);
 
+extern int sb_revalidate_bindmounts(struct super_block *sb);
+
 extern const struct file_operations proc_mounts_operations;
 extern const struct file_operations proc_mountinfo_operations;
 extern const struct file_operations proc_mountstats_operations;
-- 
2.34.1

