Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9586729618
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbjFIJ63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbjFIJ5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:57:50 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B444A9
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 02:49:47 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EC24C3F372
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303183;
        bh=0VGqwyhzl3JPGUl0HnnxKLIkvQp+JnBUhnrWkIN+oYU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vJToR24oHCldmMTgDBxx8Bi+UuAhM0IyWQ/cOl/HQUgBlGnPtWwiZCTrstI6+qQcr
         YrCb5wc/nUMvxYuWO2hf6d9GiQ8zGgfVexOJWu1Q3MH1TOOld5q0UV+b4pxQl+L0f0
         gHX6HYUEpERBoYAuWS/PHQICh161MQ3WODi/wZf8Eb6Nk/sX0V2tb9R4ClKuSk9dBB
         lc0umkmizIeKxFgeAEr6AcUgzPTyXHPqyKGdYI5j/R/5leyu3xdca4rBk9EeTqnnEP
         TeoSIH12AwjKzKjWVKoa4yHVZdz6oDjOIVGDrxGPKJtUGSKTVXXBjEDQegpldNRC8O
         r7wNQ5EvHTOQA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-97467e06580so199724466b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 02:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303182; x=1688895182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VGqwyhzl3JPGUl0HnnxKLIkvQp+JnBUhnrWkIN+oYU=;
        b=BGvabQMktu9Z4SrXDsRRvBLHqTmjkzdsZA3mhTM/zbu6C0daRg0Ie+T6fqJAnRDXQH
         vNHw0MrGIMEKH01nbaFVG/XeAnswJty+usLqbvkbcU79k8d6D2paPwtbSAHAbTZHueIn
         V2ByUKiI4KRcEicq5PD49rLqad0KgX1nxuX3h1yMZz1t7aRsG3zI7ZWRD8XvnlLx2eDB
         tvpecsfvSpTJuUT/cixZ6ljo5ssZ2UFCpkBJ8zckP955qKJ3sE19/GxgJHRuOhVCJqkg
         ne/A++ZdI35vEZU+ZQIiQC4jBcr6M286XoxSMw9Y0a4BOiJcvraOFHwWd6G/XDf8i3Qb
         Adig==
X-Gm-Message-State: AC+VfDzZpSwmGKx9zn/tcCSLMr0SOskA06H1vGxCR/J8e8r/jBM1urIm
        e9Q5abV8PR/3yTx72cUcWculUFoeccSwuMBLxX/p9ZhDqMTfPOojOD3Jy+IWfH3Rt8zzzqCEmeL
        zUdlbXJFx7WGBnu03tu6ovbYqVIhm9bQp9aUj44mkXR0=
X-Received: by 2002:a17:907:2d91:b0:97a:bd0f:ac74 with SMTP id gt17-20020a1709072d9100b0097abd0fac74mr418763ejc.26.1686303181801;
        Fri, 09 Jun 2023 02:33:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/SqikdsfYSXklqv+/0nMob2hZYelAauenDQH0n/IpiNi8XX3qJPgqriPnk5aDgnpIEG/1FQ==
X-Received: by 2002:a17:907:2d91:b0:97a:bd0f:ac74 with SMTP id gt17-20020a1709072d9100b0097abd0fac74mr418750ejc.26.1686303181608;
        Fri, 09 Jun 2023 02:33:01 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:33:01 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/15] ceph: pass idmap to ceph_do_getattr
Date:   Fri,  9 Jun 2023 11:31:22 +0200
Message-Id: <20230609093125.252186-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just pass down the mount's idmapping to *ceph_do_getattr,
everywhere when possible, because we will need it later.

Here we have two cases:
- filemap_fault/read/write/lseek (when idmap is accessible)
- export_ops/list_xattr/get_xattr (when idmap is not accessible)
in this case we pass &nop_mnt_idmap.

So we can meet permission issue when MDS UID/GID-based path
restriction is used.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: brauner@kernel.org
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v6:
	- fscrypt rebase
---
 fs/ceph/addr.c   |  3 ++-
 fs/ceph/caps.c   |  8 +++++---
 fs/ceph/export.c |  2 +-
 fs/ceph/file.c   |  9 ++++++---
 fs/ceph/inode.c  | 15 +++++++++------
 fs/ceph/ioctl.c  |  6 ++++--
 fs/ceph/quota.c  |  2 +-
 fs/ceph/super.c  |  4 ++--
 fs/ceph/super.h  | 11 +++++++----
 fs/ceph/xattr.c  |  6 +++---
 10 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index de9b82905f18..0a32475ed034 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1630,6 +1630,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		/* does not support inline data > PAGE_SIZE */
 		ret = VM_FAULT_SIGBUS;
 	} else {
+		struct mnt_idmap *idmap = file_mnt_idmap(vma->vm_file);
 		struct address_space *mapping = inode->i_mapping;
 		struct page *page;
 
@@ -1640,7 +1641,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 			ret = VM_FAULT_OOM;
 			goto out_inline;
 		}
-		err = __ceph_do_getattr(inode, page,
+		err = __ceph_do_getattr(idmap, inode, page,
 					 CEPH_STAT_CAP_INLINE_DATA, true);
 		if (err < 0 || off >= i_size_read(inode)) {
 			unlock_page(page);
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 5498bc36c1e7..b432f29e80dd 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2958,7 +2958,8 @@ int ceph_try_get_caps(struct inode *inode, int need, int want,
  * due to a small max_size, make sure we check_max_size (and possibly
  * ask the mds) so we don't get hung up indefinitely.
  */
-int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
+int __ceph_get_caps(struct mnt_idmap *idmap, struct inode *inode,
+		    struct ceph_file_info *fi, int need,
 		    int want, loff_t endoff, int *got)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -3072,7 +3073,7 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 			 * getattr request will bring inline data into
 			 * page cache
 			 */
-			ret = __ceph_do_getattr(inode, NULL,
+			ret = __ceph_do_getattr(idmap, inode, NULL,
 						CEPH_STAT_CAP_INLINE_DATA,
 						true);
 			if (ret < 0)
@@ -3089,8 +3090,9 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 {
 	struct ceph_file_info *fi = filp->private_data;
 	struct inode *inode = file_inode(filp);
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 
-	return __ceph_get_caps(inode, fi, need, want, endoff, got);
+	return __ceph_get_caps(idmap, inode, fi, need, want, endoff, got);
 }
 
 /*
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 8559990a59a5..4b422070ca2b 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -188,7 +188,7 @@ static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	/* We need LINK caps to reliably check i_nlink */
-	err = ceph_do_getattr(inode, CEPH_CAP_LINK_SHARED, false);
+	err = ceph_do_getattr(&nop_mnt_idmap, inode, CEPH_CAP_LINK_SHARED, false);
 	if (err) {
 		iput(inode);
 		return ERR_PTR(err);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7be172f29c0b..c2bb8f5fd345 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2009,6 +2009,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	size_t len = iov_iter_count(to);
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	bool direct_lock = iocb->ki_flags & IOCB_DIRECT;
 	ssize_t ret;
 	int want = 0, got = 0;
@@ -2091,7 +2092,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				return -ENOMEM;
 		}
 
-		statret = __ceph_do_getattr(inode, page,
+		statret = __ceph_do_getattr(idmap, inode, page,
 					    CEPH_STAT_CAP_INLINE_DATA, !!page);
 		if (statret < 0) {
 			if (page)
@@ -2166,6 +2167,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written = 0;
@@ -2199,7 +2201,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	current->backing_dev_info = inode_to_bdi(inode);
 
 	if (iocb->ki_flags & IOCB_APPEND) {
-		err = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
+		err = ceph_do_getattr(idmap, inode, CEPH_STAT_CAP_SIZE, false);
 		if (err < 0)
 			goto out;
 	}
@@ -2355,9 +2357,10 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 {
 	if (whence == SEEK_END || whence == SEEK_DATA || whence == SEEK_HOLE) {
 		struct inode *inode = file_inode(file);
+		struct mnt_idmap *idmap = file_mnt_idmap(file);
 		int ret;
 
-		ret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
+		ret = ceph_do_getattr(idmap, inode, CEPH_STAT_CAP_SIZE, false);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 6a8aeb4b8fb8..49ca13c5b9d8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2292,7 +2292,8 @@ static const struct inode_operations ceph_encrypted_symlink_iops = {
  * We don't support a PAGE_SIZE that is smaller than the
  * CEPH_FSCRYPT_BLOCK_SIZE.
  */
-static int fill_fscrypt_truncate(struct inode *inode,
+static int fill_fscrypt_truncate(struct mnt_idmap *idmap,
+				 struct inode *inode,
 				 struct ceph_mds_request *req,
 				 struct iattr *attr)
 {
@@ -2311,7 +2312,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	int got, ret, issued;
 	u64 objver;
 
-	ret = __ceph_get_caps(inode, NULL, CEPH_CAP_FILE_RD, 0, -1, &got);
+	ret = __ceph_get_caps(idmap, inode, NULL, CEPH_CAP_FILE_RD, 0, -1, &got);
 	if (ret < 0)
 		return ret;
 
@@ -2706,7 +2707,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		req->r_num_caps = 1;
 		req->r_stamp = attr->ia_ctime;
 		if (fill_fscrypt) {
-			err = fill_fscrypt_truncate(inode, req, attr);
+			err = fill_fscrypt_truncate(idmap, inode, req, attr);
 			if (err)
 				goto out;
 		}
@@ -2814,7 +2815,8 @@ int ceph_try_to_choose_auth_mds(struct inode *inode, int mask)
  * Verify that we have a lease on the given mask.  If not,
  * do a getattr against an mds.
  */
-int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
+int __ceph_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
+		      struct page *locked_page,
 		      int mask, bool force)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
@@ -2839,6 +2841,7 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		return PTR_ERR(req);
 	req->r_inode = inode;
 	ihold(inode);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_num_caps = 1;
 	req->r_args.getattr.mask = cpu_to_le32(mask);
 	req->r_locked_page = locked_page;
@@ -2925,7 +2928,7 @@ int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
-	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
+	err = ceph_do_getattr(idmap, inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
 		err = generic_permission(idmap, inode, mask);
@@ -2978,7 +2981,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	/* Skip the getattr altogether if we're asked not to sync */
 	if ((flags & AT_STATX_SYNC_TYPE) != AT_STATX_DONT_SYNC) {
-		err = ceph_do_getattr(inode,
+		err = ceph_do_getattr(idmap, inode,
 				statx_to_caps(request_mask, inode->i_mode),
 				flags & AT_STATX_FORCE_SYNC);
 		if (err)
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 679402bd80ba..6fa021b973e5 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -18,10 +18,11 @@
 static long ceph_ioctl_get_layout(struct file *file, void __user *arg)
 {
 	struct ceph_inode_info *ci = ceph_inode(file_inode(file));
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_ioctl_layout l;
 	int err;
 
-	err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT, false);
+	err = ceph_do_getattr(idmap, file_inode(file), CEPH_STAT_CAP_LAYOUT, false);
 	if (!err) {
 		l.stripe_unit = ci->i_layout.stripe_unit;
 		l.stripe_count = ci->i_layout.stripe_count;
@@ -65,6 +66,7 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
 static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
@@ -76,7 +78,7 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 		return -EFAULT;
 
 	/* validate changed params against current layout */
-	err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT, false);
+	err = ceph_do_getattr(idmap, file_inode(file), CEPH_STAT_CAP_LAYOUT, false);
 	if (err)
 		return err;
 
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index f7fcf7f08ec6..515423b3ddea 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -150,7 +150,7 @@ static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
 	}
 	if (qri->inode) {
 		/* get caps */
-		int ret = __ceph_do_getattr(qri->inode, NULL,
+		int ret = __ceph_do_getattr(&nop_mnt_idmap, qri->inode, NULL,
 					    CEPH_STAT_CAP_INODE, true);
 		if (ret >= 0)
 			in = qri->inode;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 070b3150d267..3d6d0010d638 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1607,8 +1607,8 @@ int ceph_force_reconnect(struct super_block *sb)
 	fsc->mount_state = CEPH_MOUNT_MOUNTED;
 
 	if (sb->s_root) {
-		err = __ceph_do_getattr(d_inode(sb->s_root), NULL,
-					CEPH_STAT_CAP_INODE, true);
+		err = __ceph_do_getattr(&nop_mnt_idmap, d_inode(sb->s_root),
+					NULL, CEPH_STAT_CAP_INODE, true);
 	}
 	return err;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 8516ac571da9..57cbb69a17c8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1082,11 +1082,13 @@ static inline void ceph_queue_flush_snaps(struct inode *inode)
 }
 
 extern int ceph_try_to_choose_auth_mds(struct inode *inode, int mask);
-extern int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
+extern int __ceph_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
+			     struct page *locked_page,
 			     int mask, bool force);
-static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
+static inline int ceph_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
+				  int mask, bool force)
 {
-	return __ceph_do_getattr(inode, NULL, mask, force);
+	return __ceph_do_getattr(idmap, inode, NULL, mask, force);
 }
 extern int ceph_permission(struct mnt_idmap *idmap,
 			   struct inode *inode, int mask);
@@ -1271,7 +1273,8 @@ extern int ceph_encode_dentry_release(void **p, struct dentry *dn,
 				      struct inode *dir,
 				      int mds, int drop, int unless);
 
-extern int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi,
+extern int __ceph_get_caps(struct mnt_idmap *idmap, struct inode *inode,
+			   struct ceph_file_info *fi,
 			   int need, int want, loff_t endoff, int *got);
 extern int ceph_get_caps(struct file *filp, int need, int want,
 			 loff_t endoff, int *got);
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 76680e5c2f82..d11295e0a115 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -978,7 +978,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 			mask |= CEPH_STAT_RSTAT;
 		if (vxattr->flags & VXATTR_FLAG_DIRSTAT)
 			mask |= CEPH_CAP_FILE_SHARED;
-		err = ceph_do_getattr(inode, mask, true);
+		err = ceph_do_getattr(&nop_mnt_idmap, inode, mask, true);
 		if (err)
 			return err;
 		err = -ENODATA;
@@ -1015,7 +1015,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		}
 
 		/* get xattrs from mds (if we don't already have them) */
-		err = ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR, true);
+		err = ceph_do_getattr(&nop_mnt_idmap, inode, CEPH_STAT_CAP_XATTR, true);
 		if (err)
 			return err;
 		spin_lock(&ci->i_ceph_lock);
@@ -1064,7 +1064,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	if (ci->i_xattrs.version == 0 ||
 	    !__ceph_caps_issued_mask_metric(ci, CEPH_CAP_XATTR_SHARED, 1)) {
 		spin_unlock(&ci->i_ceph_lock);
-		err = ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR, true);
+		err = ceph_do_getattr(&nop_mnt_idmap, inode, CEPH_STAT_CAP_XATTR, true);
 		if (err)
 			return err;
 		spin_lock(&ci->i_ceph_lock);
-- 
2.34.1

