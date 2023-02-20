Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496B469D433
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 20:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjBTTir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjBTTie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:34 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E461D93B
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:24 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 62FF23F721
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921901;
        bh=beo/X2fz11pJ2bRdyUmq50n5LTyxWqPc40OR5Kr3NC8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=rFPOy5pnq5WhPFPRgYTpHPxtUW8nQUSAnQ8KSS8OtKWXkMkC1ZI5nDLwrcVUTGXmX
         M9PFP5IPOjAd4PWMUM/yqFcXvOstofG2/IVWy7UuPM9X4gR+weFOkom0Qy1Zi4JzOK
         gDQtJQPXbrT8SRhGzUpoGCeCn4rn07mUi2CTHne1kMUg2W88XD4bCiOognqFGOP5t4
         XZ3OJSPTlxFQfV5Ake+X88/4KuXabwKkrOEz7MNBVRB1KZhj3ms9HP+Kck6fmONhFx
         +H4ACgnbelR9M3tkwuaoqoMD6wAWOBDwX6eA5Iv29o/7VBiFIprfH6NBERNEO4mYdR
         Txy+Q9usBBuzA==
Received: by mail-ed1-f70.google.com with SMTP id dk16-20020a0564021d9000b004aaa054d189so2597578edb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beo/X2fz11pJ2bRdyUmq50n5LTyxWqPc40OR5Kr3NC8=;
        b=lrEZ2YvenR27T3to76kIpVfFph7wwQX+td+Xtlb2b1ThYCE7mMfdWAQqlKS2+ACwSG
         9LxReKi8p0aOfMVGuc88pu8a0HR2PzL/O4FZqoIsb6/wJl7nPcExdAe3M0HJOt0AGIfZ
         AA9LNEAG3arLqy2pEpWemIFsIknpN+mVeOaUQSARMwgDDvkWwNaqsNez8PNa43bQ6CSe
         9nuhLELt0+FH1t7REOTDYZwNi1Op1+Y8HEZclTUDHxjFhrtpFzT5Ws+Gn8Oja70tKph5
         PSLukEMcLVP70bPYSLJl0yOBCUbEE2uXKU/e7sONlEVKjYP0mazG0kKDKuhkLPjADGbq
         KYdg==
X-Gm-Message-State: AO0yUKVT7Yu8FUZNqoD7T+f1KSkAFCStXKOAvPREHdaFZflLsFLaX2vX
        bQsdjyPnIOYvmVjAQ66ofzoQ1xJvmLg4Zk20XNVMLYwo4Epqi8DDFbLwmgIKWwTrI6VOl8i/okZ
        dVki+eiZ+rRoXes0xcLLff8YLt+YybTSm7C/xWLf+AEY=
X-Received: by 2002:a17:907:7206:b0:8b2:e93:3f59 with SMTP id dr6-20020a170907720600b008b20e933f59mr14113988ejc.31.1676921898107;
        Mon, 20 Feb 2023 11:38:18 -0800 (PST)
X-Google-Smtp-Source: AK7set94lpetJCYjttymkUIDv5boEy6xjxLsVjKM1rFBCySB5S4ehDjioM0ZnWUTTowOPsR6vaw2pg==
X-Received: by 2002:a17:907:7206:b0:8b2:e93:3f59 with SMTP id dr6-20020a170907720600b008b20e933f59mr14113979ejc.31.1676921897964;
        Mon, 20 Feb 2023 11:38:17 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:17 -0800 (PST)
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
Subject: [RFC PATCH 4/9] fuse: handle stale inode connection in fuse_queue_forget
Date:   Mon, 20 Feb 2023 20:37:49 +0100
Message-Id: <20230220193754.470330-5-aleksandr.mikhalitsyn@canonical.com>
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

We don't want to send FUSE_FORGET request to the new
fuse daemon if inode was lookuped by the old fuse daemon
because it can confuse and break userspace (libfuse).

For now, just add a new argument to fuse_queue_forget and
handle it. Adjust all callers to match the old behaviour.

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
 fs/fuse/dev.c    | 4 ++--
 fs/fuse/dir.c    | 8 ++++----
 fs/fuse/fuse_i.h | 2 +-
 fs/fuse/inode.c  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index eb4f88e3dc97..85f69629f34d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -234,7 +234,7 @@ __releases(fiq->lock)
 }
 
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
-		       u64 nodeid, u64 nlookup)
+		       u64 nodeid, u64 nlookup, bool stale_inode_conn)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
@@ -242,7 +242,7 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 	forget->forget_one.nlookup = nlookup;
 
 	spin_lock(&fiq->lock);
-	if (fiq->connected) {
+	if (fiq->connected && !stale_inode_conn) {
 		fiq->forget_list_tail->next = forget;
 		fiq->forget_list_tail = forget;
 		fiq->ops->wake_forget_and_unlock(fiq);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7f4b29aa7c79..49d91add08bc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -250,7 +250,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			if (outarg.nodeid != get_node_id(inode) ||
 			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
 				fuse_queue_forget(fm->fc, forget,
-						  outarg.nodeid, 1);
+						  outarg.nodeid, 1, false);
 				goto invalid;
 			}
 			spin_lock(&fi->lock);
@@ -405,7 +405,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 			   attr_version);
 	err = -ENOMEM;
 	if (!*inode) {
-		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1, false);
 		goto out;
 	}
 	err = 0;
@@ -692,7 +692,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
-		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1, false);
 		err = -ENOMEM;
 		goto out_err;
 	}
@@ -817,7 +817,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr, entry_attr_timeout(&outarg), 0);
 	if (!inode) {
-		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1, false);
 		return -ENOMEM;
 	}
 	kfree(forget);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ccd7c145de94..ce154e7ab715 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1008,7 +1008,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
  * Send FORGET command
  */
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
-		       u64 nodeid, u64 nlookup);
+		       u64 nodeid, u64 nlookup, bool stale_inode_conn);
 
 struct fuse_forget_link *fuse_alloc_forget(void);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c604434611d9..33a108cfcefe 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -124,7 +124,7 @@ static void fuse_evict_inode(struct inode *inode)
 			fuse_dax_inode_cleanup(inode);
 		if (fi->nlookup) {
 			fuse_queue_forget(fc, fi->forget, fi->nodeid,
-					  fi->nlookup);
+					  fi->nlookup, false);
 			fi->forget = NULL;
 		}
 	}
-- 
2.34.1

