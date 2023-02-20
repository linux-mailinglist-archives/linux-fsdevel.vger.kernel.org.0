Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFAA69D432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 20:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjBTTip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjBTTie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE641E5F6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:25 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BD1B3F58F
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921901;
        bh=m28hckPpZo//+REnNUe1+xbVCPxVC3DjhU8ZIaojZ10=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=H9e/KZHtsgPnFvSuWVgNi6wyZGjNv34nPA5FccUfpTxKj0rydx5VM4lwl2UOM567e
         HAhpAx78/Hhi79LBXvb1IgyyEXIxD4gW8xo9ox6o1TsJ/SLzrsTBWpl8ZoKz7Nrzij
         p1RHfAXUsx3sst/vJNskgoHyVRVt98tQDKfjHNnN+vKF/aaU5KZzFNeW6Eu5f7NYPH
         hjxCisnpRueqm8iEL7puEglzkjX7mL6NAJiOkEXOpSxVL4aqQyRaMTSVj4fcP1/5P6
         LjEi7yNo60g+zUSgGbvPaIajcI/w9BqbpRuiAEul1oKbpHolxC3wU1IojNzUzuQRWb
         zZiKZXO8dJdVw==
Received: by mail-ed1-f71.google.com with SMTP id r6-20020aa7c146000000b004acd97105ffso3006938edp.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m28hckPpZo//+REnNUe1+xbVCPxVC3DjhU8ZIaojZ10=;
        b=RGR/lko88REe3x0XaPEkZEL2LjVHr8aYWc5/uI7xl09wCoISzg2TlUijWAbV1ZmR0A
         ha6dakXyNLqPnnM41I5KfO/fFHDdOaxKeJ1gkyteqVBavJ2HP5cpiXHdM2ifbD3b/Rn8
         K/OMxOXeT3yNYgjVLt2rZt2y4bbbPzn/Bk5BdEl6chIv6qWsF8/ywe1wOtf60ySJebIr
         JQPM7+PXmjjfNbahve52JMxLqfPOHH9M95oX0eg8txivc1H0dWfVVhgQA0O0mYoDX85q
         zlciNUGxEFzCkXTcUWwaYaTOcTkAo3TKKNZC37zFisDLabTVoNsvcxVeLMjjp6HsKjR9
         DFkQ==
X-Gm-Message-State: AO0yUKWuAjtb6Z2+VM8yrNugrA/StNnD6Std4++Vh0td/UGkH3CXe+WF
        m9NMCRfkxF5G/H3Sg121iKMOt2jt8sxXD/7OtLHolWFwaqKbS5PxO5d3E6O5xz0q+TN4ajeF9Ni
        8n5CmSPvYtvGZq3ndpmafoanN5ifyjjGwqqQwTqq9fh8=
X-Received: by 2002:a17:907:a583:b0:8af:3c9f:6e5d with SMTP id vs3-20020a170907a58300b008af3c9f6e5dmr11208686ejc.12.1676921901349;
        Mon, 20 Feb 2023 11:38:21 -0800 (PST)
X-Google-Smtp-Source: AK7set9n/pWyHQ83M35AP2lHtIuRvbHPWUSk/iRVlxNyJdyms9GDexSOYmrJe+qAMo+8sGCJiQw36A==
X-Received: by 2002:a17:907:a583:b0:8af:3c9f:6e5d with SMTP id vs3-20020a170907a58300b008af3c9f6e5dmr11208670ejc.12.1676921901115;
        Mon, 20 Feb 2023 11:38:21 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:20 -0800 (PST)
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
Subject: [RFC PATCH 6/9] fuse: take fuse connection generation into account
Date:   Mon, 20 Feb 2023 20:37:51 +0100
Message-Id: <20230220193754.470330-7-aleksandr.mikhalitsyn@canonical.com>
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

- modify dentry revalidation algorithm to check inode/connection
generations. If them are not equal then perform revalidation.

remark: during forced dentry revalidation we are sending FUSE_LOOKUP
request to the userspace daemon and if it return the same inode after
lookup then we can "upgrade" inode connection generation without
invalidating it.

- don't send FUSE_FSYNC, FUSE_RELEASE, etc requests to the userspace
daemon about stale inodes (this can confuse libfuse)

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
 fs/fuse/dir.c    | 4 +++-
 fs/fuse/file.c   | 6 ++++--
 fs/fuse/fuse_i.h | 3 ++-
 fs/fuse/inode.c  | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 63625c29d6ef..5ac7d88e5dfc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -213,7 +213,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	inode = d_inode_rcu(entry);
 	if (inode && fuse_is_bad(inode))
 		goto invalid;
-	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
+	else if ((inode && fuse_stale_inode_conn(inode)) ||
+		 time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
 		FUSE_ARGS(args);
@@ -255,6 +256,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			}
 			spin_lock(&fi->lock);
 			fi->nlookup++;
+			fi->conn_gen = READ_ONCE(get_fuse_conn(inode)->conn_gen);
 			spin_unlock(&fi->lock);
 		}
 		kfree(forget);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d5b30faff0b9..be9086a1868d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -110,7 +110,8 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_args *args = &ff->release_args->args;
 
-		if (isdir ? ff->fm->fc->flags.no_opendir : ff->fm->fc->flags.no_open) {
+		if (fuse_stale_ff(ff) ||
+		    (isdir ? ff->fm->fc->flags.no_opendir : ff->fm->fc->flags.no_open)) {
 			/* Do nothing when client does not implement 'open' */
 			fuse_release_end(ff->fm, args, 0);
 		} else if (sync) {
@@ -597,9 +598,10 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct inode *inode = file->f_mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_file *ff = file->private_data;
 	int err;
 
-	if (fuse_is_bad(inode))
+	if (fuse_stale_ff(ff) || fuse_is_bad(inode))
 		return -EIO;
 
 	inode_lock(inode);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4f4a6f912c7c..0643de31674d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -954,7 +954,8 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
 				    struct fuse_attr *attr)
 {
 	return inode->i_generation != generation ||
-		inode_wrong_type(inode, attr->mode);
+		inode_wrong_type(inode, attr->mode) ||
+		fuse_stale_inode_conn(inode);
 }
 
 static inline void fuse_make_bad(struct inode *inode)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c3109e016494..f9dc8971274d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -124,7 +124,7 @@ static void fuse_evict_inode(struct inode *inode)
 			fuse_dax_inode_cleanup(inode);
 		if (fi->nlookup) {
 			fuse_queue_forget(fc, fi->forget, fi->nodeid,
-					  fi->nlookup, false);
+					  fi->nlookup, fuse_stale_inode_conn(inode));
 			fi->forget = NULL;
 		}
 	}
-- 
2.34.1

