Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652DA6EE25F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjDYNB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjDYNB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:01:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C913C05;
        Tue, 25 Apr 2023 06:01:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3023a56048bso4930821f8f.3;
        Tue, 25 Apr 2023 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682427677; x=1685019677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3aCy9dMf9D3o3EUSrkUbK/p5ec0D1Jn7fna+lLcoQQ=;
        b=Uzi9kyHcvUfeohRfbzFS6j3SyKqBUVSStrt0JfNo4DFBMbrwm4OVfuzZ6CBHq/6acO
         dnNuoONGvjUwFkFB7Qp8YU/7clcRAOYqoeY7DJd0xf1w3P4Sms1WsvFwI23kwXCVSsyU
         JXipoEV1CSA/OZmeOxB4B5kaKbqish1u25QPVZwz3tQHs7Vlee7XyBR0kT0XBWKAU3ey
         pc7EOTHw6ctM20CTMHInlCUp3jbNgGpMOeekldcscHiKainjjX4p5VaHFBmTZghtU86u
         /aCcgwNJ8IdcKDQe4QsToTYyikYkd/cPE+r3STMM4eoWwRnGTaG+oP/Ln62DN4syp/2E
         1m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427677; x=1685019677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3aCy9dMf9D3o3EUSrkUbK/p5ec0D1Jn7fna+lLcoQQ=;
        b=XZX1D0aL4BNzm2Xc6dSQl5EKkA4DvBplBvYJfHIZSK220W6Admv4iqjsfJxbVhZhI9
         zprrtmtoDV6PNtZFQ1saw7PpsUGQYxEdN7L0e6IHLaMsGD6eBpA49WSRMvGuPvLeE27F
         /EPmwBP2UKhA2Aydwq9HIpkjbYn0qRC5NB6kAhXEPvkwbcAs8quwjS2hOEAQstiy7VsL
         gS1/hdYUHrEGtkR+JnDBli21XgU4mDZvZdzlsxJhprQSf+m27Ccur2MfDbwcjGPoH4yy
         FIr1MokLFwjY5xgn2TeSKt66hjw9O51Godp7Iu1+69pvvt6BSbPwlyCoDbjNgSwWt8/X
         bF1g==
X-Gm-Message-State: AAQBX9ePJxrBzI2izGdE2QuBtOD6s4+WPO9vNIUTO7LmNB7Wk3FxAlDh
        fdJTXXHD7ooGjtiLCKHYIns=
X-Google-Smtp-Source: AKy350YK0d9X3+KVdrg5vymnCXFF65tslolfvYk/fpaSb/l6WX7hbUoFoZ7jRflOXqDB8E5Ycr/oJg==
X-Received: by 2002:a05:6000:10c8:b0:2f5:b1aa:679c with SMTP id b8-20020a05600010c800b002f5b1aa679cmr11126611wrx.39.1682427677035;
        Tue, 25 Apr 2023 06:01:17 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm13103447wrp.20.2023.04.25.06.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:01:16 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC][PATCH 2/4] exportfs: add explicit flag to request non-decodeable file handles
Date:   Tue, 25 Apr 2023 16:01:03 +0300
Message-Id: <20230425130105.2606684-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425130105.2606684-1-amir73il@gmail.com>
References: <20230425130105.2606684-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So far, all callers of exportfs_encode_inode_fh(), except for fsnotify's
show_mark_fhandle(), check that filesystem can decode file handles, but
we would like to add more callers that do not require a file handle that
can be decoded.

Introduce a flag to explicitly request a file handle that may not to be
decoded later and a wrapper exportfs_encode_fid() that sets this flag
and convert show_mark_fhandle() to use the new wrapper.

This will be used to allow adding fanotify support to filesystems that
do not support NFS export.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/nfs/exporting.rst |  4 ++--
 fs/exportfs/expfs.c                         | 18 ++++++++++++++++--
 fs/notify/fanotify/fanotify.c               |  4 ++--
 fs/notify/fdinfo.c                          |  2 +-
 include/linux/exportfs.h                    | 12 +++++++++++-
 5 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 0e98edd353b5..3d97b8d8f735 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -122,8 +122,8 @@ are exportable by setting the s_export_op field in the struct
 super_block.  This field must point to a "struct export_operations"
 struct which has the following members:
 
- encode_fh  (optional)
-    Takes a dentry and creates a filehandle fragment which can later be used
+  encode_fh (optional)
+    Takes a dentry and creates a filehandle fragment which may later be used
     to find or create a dentry for the same object.  The default
     implementation creates a filehandle fragment that encodes a 32bit inode
     and generation number for the inode encoded, and if necessary the
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index bf1b4925fedd..1b35dda5bdda 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -381,11 +381,25 @@ static int export_encode_fh(struct inode *inode, struct fid *fid,
 	return type;
 }
 
+/**
+ * exportfs_encode_inode_fh - encode a file handle from inode
+ * @inode:   the object to encode
+ * @fid:     where to store the file handle fragment
+ * @max_len: maximum length to store there
+ * @flags:   properties of the requrested file handle
+ */
 int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
-			     int *max_len, struct inode *parent)
+			     int *max_len, struct inode *parent, int flags)
 {
 	const struct export_operations *nop = inode->i_sb->s_export_op;
 
+	/*
+	 * If a decodeable file handle was requested, we need to make sure that
+	 * filesystem can decode file handles.
+	 */
+	if (nop && !(flags & EXPORT_FH_FID) && !nop->fh_to_dentry)
+		return -EOPNOTSUPP;
+
 	if (nop && nop->encode_fh)
 		return nop->encode_fh(inode, fid->raw, max_len, parent);
 
@@ -416,7 +430,7 @@ int exportfs_encode_fh(struct dentry *dentry, struct fid *fid, int *max_len,
 		parent = p->d_inode;
 	}
 
-	error = exportfs_encode_inode_fh(inode, fid, max_len, parent);
+	error = exportfs_encode_inode_fh(inode, fid, max_len, parent, flags);
 	dput(p);
 
 	return error;
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 29bdd99b29fa..d1a49f5b6e6d 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -380,7 +380,7 @@ static int fanotify_encode_fh_len(struct inode *inode)
 	if (!inode)
 		return 0;
 
-	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
+	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL, 0);
 	fh_len = dwords << 2;
 
 	/*
@@ -443,7 +443,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	}
 
 	dwords = fh_len >> 2;
-	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
+	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL, 0);
 	err = -EINVAL;
 	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 55081ae3a6ec..5c430736ec12 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	f.handle.handle_bytes = sizeof(f.pad);
 	size = f.handle.handle_bytes >> 2;
 
-	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
+	ret = exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &size);
 	if ((ret == FILEID_INVALID) || (ret < 0)) {
 		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
 		return;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 2b1048238170..635e89e1dae7 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -136,6 +136,7 @@ struct fid {
 };
 
 #define EXPORT_FH_CONNECTABLE	0x1
+#define EXPORT_FH_FID		0x2
 
 /**
  * struct export_operations - for nfsd to communicate with file systems
@@ -226,9 +227,18 @@ struct export_operations {
 };
 
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
-				    int *max_len, struct inode *parent);
+				    int *max_len, struct inode *parent,
+				    int flags);
 extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 			      int *max_len, int flags);
+
+static inline int exportfs_encode_fid(struct inode *inode, struct fid *fid,
+				      int *max_len)
+{
+	return exportfs_encode_inode_fh(inode, fid, max_len, NULL,
+					EXPORT_FH_FID);
+}
+
 extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
 					     struct fid *fid, int fh_len,
 					     int fileid_type,
-- 
2.34.1

