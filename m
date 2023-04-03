Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA16D4A64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjDCOqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjDCOqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:46:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC932C9F5
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:16 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7BF863F466
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533140;
        bh=mIRd3G7EmqzBYzec9Xklmi0CbHz6DDwl1OuXrzwAvTA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=LD8Nador3qU+xSd9cAkAo8ptLaJxNMIjqaXM0bx1qfypx/nYKKElRZJ9Lrc/Rq45q
         C+oheFz3hZXcJTn94Q/QSTj2L4SEjNN9J6UceCZgcZ0SIglCsUeZRJs4aXevLj/sfV
         6vH1Lckm+LYOxo4+dSrOIrmanAjDwqD1wmzuXnomY7/X088z6w46sbHn1QFczG4xYr
         zXvB9dWEp54prs9LRFJ8ZmfH7eLQxcwneNc/KLyI/HgZW+iv1ZAO6Ph/ZZb1kxYqiJ
         HFl6kfKkxZeZZieZRI0PbOHcTPn+Uzs2w0ALTLEytb+84cG1rKmxcrhe3rLksNrsm6
         GPI5+ojsD6wQQ==
Received: by mail-ed1-f70.google.com with SMTP id m18-20020a50d7d2000000b00501dfd867a4so41939744edj.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIRd3G7EmqzBYzec9Xklmi0CbHz6DDwl1OuXrzwAvTA=;
        b=1Hiis4dVi9pOp3V4odq5Gys0Ua3oXAeip9WZhd5qCqZBD5pWzjAzJ0OORRSoDhq/LE
         j150AG4NwAM5J7iytanajGkkttvS7bBxeBxxReNyKbLvjTFWyTZiSmYl77uHkhMEnPhD
         ILV2/bUfO0ODjoS8Dd5tmZbRfO4PPazr2LUcDAa7jz60aTDLsd7YP+pNKbRqAFfi0WYh
         AqASZUzGC8XWgjPc3NEJvf1JL3Q2zSGFXCKBzKDl/utVKQJXLr9PcZRZCp/T6rYV13Jt
         qP0Kxbe+bNqwBVn5zSRzUcNJvkQnSxUmP6Jmug6ggf5v+XJKfXuF+Qp46jM6IOS7pXHV
         9UvQ==
X-Gm-Message-State: AAQBX9dI9CMmAL1Qkd1xoDizOhWkaArCBpiWilQffeI2ouaF693WAVEA
        saUw9m6F/uKnnew8oraD8P/buRSmMck+iqLyG8+9PRm8KWXZgeNos1Z2NtFsptflurbx5QDo9YX
        YXw+rnk5gOtea5bugzPLYUi10yFtB1hkt0p93bYL9n7U=
X-Received: by 2002:a17:906:8a41:b0:930:18f5:d016 with SMTP id gx1-20020a1709068a4100b0093018f5d016mr35370797ejc.15.1680533140352;
        Mon, 03 Apr 2023 07:45:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350bW1EY67CnMn+SBmXdtOOQwiMe+PQQAcAXChGCQUsD08TkK73YGtH/fhfZKhNQS0qprBkqadA==
X-Received: by 2002:a17:906:8a41:b0:930:18f5:d016 with SMTP id gx1-20020a1709068a4100b0093018f5d016mr35370775ejc.15.1680533140205;
        Mon, 03 Apr 2023 07:45:40 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:39 -0700 (PDT)
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
Subject: [RFC PATCH v2 3/9] fuse: add fuse connection generation
Date:   Mon,  3 Apr 2023 16:45:11 +0200
Message-Id: <20230403144517.347517-4-aleksandr.mikhalitsyn@canonical.com>
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

We will use connection generation to detect stale inodes
from the "old" fuse daemon and invalidate/revalidate them.

There is no functional changes.

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
 fs/fuse/file.c   |  1 +
 fs/fuse/fuse_i.h | 29 +++++++++++++++++++++++++++++
 fs/fuse/inode.c  |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index de37a3a06a71..1e36cd9490c6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -79,6 +79,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
 	init_waitqueue_head(&ff->poll_wait);
 
 	ff->kh = atomic64_inc_return(&fm->fc->khctr);
+	ff->conn_gen = READ_ONCE(fm->fc->conn_gen);
 
 	return ff;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6d3d3ca4f136..8d4276d7ab1e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -161,6 +161,9 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+
+	/** Fuse connection (fuse_conn) generation when inode was allocated */
+	u32 conn_gen;
 };
 
 /** FUSE inode state bits */
@@ -232,6 +235,9 @@ struct fuse_file {
 
 	/** Has flock been performed on this file? */
 	bool flock:1;
+
+	/** Fuse connection (fuse_conn) generation when file was allocated */
+	u32 conn_gen;
 };
 
 /** One input argument of a request */
@@ -847,6 +853,18 @@ struct fuse_conn {
 
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
+
+	/**
+	 * Connection generation.
+	 * Used to determine if inodes/files were created with an "old"
+	 * fuse connection and have to be invalidated. So, all requests
+	 * related to these inodes should fail with -EIO.
+	 *
+	 * CHECKME: do we really need conn_gen for struct fuse_file?
+	 * Right now it's only needed for fuse_file_put(), where we have
+	 * no access to the inode in some cases.
+	 */
+	u32 conn_gen;
 };
 
 /*
@@ -910,6 +928,17 @@ static inline u64 fuse_get_attr_version(const struct fuse_conn *fc)
 	return atomic64_read(&fc->attr_version);
 }
 
+static inline bool fuse_stale_ff(const struct fuse_file *ff)
+{
+	return unlikely(READ_ONCE(ff->fm->fc->conn_gen) != ff->conn_gen);
+}
+
+static inline bool fuse_stale_inode_conn(const struct inode *inode)
+{
+	return unlikely(READ_ONCE(get_fuse_conn(inode)->conn_gen) !=
+			get_fuse_inode(inode)->conn_gen);
+}
+
 static inline bool fuse_stale_inode(const struct inode *inode, int generation,
 				    struct fuse_attr *attr)
 {
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3de950104f15..009fe5bbb855 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -77,6 +77,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->attr_version = 0;
 	fi->orig_ino = 0;
 	fi->state = 0;
+	fi->conn_gen = READ_ONCE(get_fuse_conn_super(sb)->conn_gen);
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
@@ -848,6 +849,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
+	fc->conn_gen = 1;
 
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
-- 
2.34.1

