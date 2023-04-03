Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B006D4A7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjDCOro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjDCOrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:47:23 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314A29BE3
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:44 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2B07D3F4B8
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533149;
        bh=CML0MX+E6RHRMEZDuKLkjuHXCZn0KNZeg1m8eYp9u4Q=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=KJU2wC70YTqhIkJ0oKQyOvBT0X6f/kwgBN+qDmjR4/bU0G4U3HE1nJZ77E8t2dP/x
         IuzVQRZMR+pROW0o2q004VdkvBkY4risPmwSag0J39tKHZM/0Z8J9KqlNXnU1/Ir6C
         ry12NDLpB0QRecf0dDwYqb7Ooev7LyBRJmUZdkUt/+80FSagWRdj1ipNMWpeig3rjr
         J1WeE/45oRMUNENwmLu2KsGRY+s6W3kf2hcjHefb6h1o+KEhhFkeWAG1UfFYtyQpc6
         yRPZfZw/S9/CxFJ+rBS3BpdJ+ByNV9Dv9Io9PQGCBAlgrd9WtALrDO8RcNvAD6Mxmr
         s/E4Kpsw7QQTw==
Received: by mail-ed1-f72.google.com with SMTP id t26-20020a50d71a000000b005003c5087caso41189327edi.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CML0MX+E6RHRMEZDuKLkjuHXCZn0KNZeg1m8eYp9u4Q=;
        b=udX92e7aYIf7uRs3D9MfGvGJa4eBEpJy6u3nnCM5Y/281KbJxY/jtzMfi4Dv1WfWUX
         NjoUCXvrxyY8lx9f5dhPTmJhOn4mNa4uknO1j+81Ul4x1Mp2KzKH2tX9BZS3qGFWV8D8
         cHzn5sQlIn7LuxM/HmLCmFtEDrgdKvIrTj44ipU9iG664DA/gtWtP2Sp7KV1ZHaOJqWN
         V+K9Fo2OzqWBObguZCrajV5w/B8z02kcx9+aAKGeKQnEqJoMttg4Hr3IFduSBZvZqfvv
         Vmro97F9iuhKHy++uE8kUixkoeBIQ2VNtwPommCBKeMCv7UQsRlbK46uxIbfeQ9I/Cuv
         SatQ==
X-Gm-Message-State: AAQBX9ckvweqnXSbM2qE8ma6MVaz3fohueaVplQIN6dg5frmT/efrslq
        Pz3wvtwPja97dOUR3XXCsLpwIb2kXlnNOo9dQXyndmSjesPYOmNXLbUv0UXMLXBo/eCqEz9awQm
        TS3lYxa3jsgkBDdclelRygpDqlFG1fhB8VFCeAheIJsc=
X-Received: by 2002:a05:6402:215:b0:502:9c52:447f with SMTP id t21-20020a056402021500b005029c52447fmr4105697edv.17.1680533148977;
        Mon, 03 Apr 2023 07:45:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350btyKXZRMoX7/M0+6dUdIKd3K9ydJ1W9baKVdPNFK7DJGhr7naoKrIONWiKDmdxp0+zXVLfPg==
X-Received: by 2002:a05:6402:215:b0:502:9c52:447f with SMTP id t21-20020a056402021500b005029c52447fmr4105680edv.17.1680533148816;
        Mon, 03 Apr 2023 07:45:48 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:48 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     flyingpeng@tencent.com,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH v2 8/9] namespace: add sb_revalidate_bindmounts helper
Date:   Mon,  3 Apr 2023 16:45:16 +0200
Message-Id: <20230403144517.347517-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/namespace.c                | 90 +++++++++++++++++++++++++++++++++++
 include/linux/mnt_namespace.h |  3 ++
 2 files changed, 93 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index bc0f15257b49..b74d00d6abb0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -568,6 +568,96 @@ static int mnt_make_readonly(struct mount *mnt)
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

