Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891C1728402
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbjFHPpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjFHPog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:44:36 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2A30D5
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:44:04 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 331C43F36F
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239031;
        bh=2SBMId8uucXXsmkpO9XvsuxzyfuN3DNew61ExZTJFDc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nxJw72xQlyzZLWNibUYvv4UHFRUglQhF9+tWix7Ut+1bPPs9mDVY57o9XLIIBoFLs
         RsdxmjDWSl2zgsjQzKYKHVXFxbnsrNm3sJgptkeT5kOee0JZ24vcOoI0Ceqpnf+BDg
         k1JDJ7WBRydwreL0GSdPk3v/htaQvCbmj/WNXg0n/KWY0mpBH3UbETzsZFeBJm4zpn
         Za2SodNMZlLPNCiTkoBvmGsmaH2G/jiavqxUIhC9LQo/7wacq/a/intrxzGNTfTtIj
         ne9BA9PWti2k1EwZ1c+qcHTSuODGHNI0R/l4UP7kiBn8ose6edVD/5Y7rQuDoQcQ3O
         k6jy33uTqR/Mw==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30ae9958ff6so353267f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239030; x=1688831030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SBMId8uucXXsmkpO9XvsuxzyfuN3DNew61ExZTJFDc=;
        b=gGuiwTYadkqhGR45JVgaMTSlK5pVlQrOT9JKKYLYzOSXiRA5ZddLM7klh402xXTnyD
         shSVdjpoSNlr9Rf8y0EhX+l4LRZSLEofLv5/Pd02mmIAuie4EK9WHfU4G4Tlf0OriemO
         widnYNZyx4kSoqKHetUC30ed9X+7Fh/LLqoy//WO9ijNfqjO2fcmea6c7nYzOfyirtXR
         zNKhrFNc5diM374wvqrxXxECdn08BEjmbfv+0SAVmhnXj8f24opr4XHVdbUAEkio1iSM
         Eq+FSHKXatziv6mA0GeyjLATdr6DgyoS2wS81loflCN3/XtEhh7PRpLRvbDSoCwFMNYq
         6Bzw==
X-Gm-Message-State: AC+VfDwpmTxjQXC9R0j1ObcRWsVw9W4BoMRhG1YEiH4Tc/386M9Eci/g
        X/vP605yjB0fGTSGgOUNMYtstQilohvROk+mLYBqlhmuEQM3cKhMZRrz1uObLD+01C5IrTHURop
        22/tiKheQ/ChosPeim6rH8gQ0cHZ+NR1oZ4kCmV1O/Gw=
X-Received: by 2002:adf:e5c6:0:b0:30e:5380:5eb3 with SMTP id a6-20020adfe5c6000000b0030e53805eb3mr5859727wrn.33.1686239030041;
        Thu, 08 Jun 2023 08:43:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6CnFwNtGDWr2OK/EAx3WMAMTXiL6rTtLft1GHY7iGNq7Fq8yKZ5L3UVTQTUEfrAGR5aQWg7Q==
X-Received: by 2002:adf:e5c6:0:b0:30e:5380:5eb3 with SMTP id a6-20020adfe5c6000000b0030e53805eb3mr5859717wrn.33.1686239029789;
        Thu, 08 Jun 2023 08:43:49 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:49 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/14] ceph: pass idmap to ceph_do_getattr
Date:   Thu,  8 Jun 2023 17:42:52 +0200
Message-Id: <20230608154256.562906-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/ceph/addr.c   | 3 ++-
 fs/ceph/caps.c   | 3 ++-
 fs/ceph/export.c | 2 +-
 fs/ceph/file.c   | 9 ++++++---
 fs/ceph/inode.c  | 8 +++++---
 fs/ceph/ioctl.c  | 6 ++++--
 fs/ceph/quota.c  | 2 +-
 fs/ceph/super.c  | 4 ++--
 fs/ceph/super.h  | 8 +++++---
 fs/ceph/xattr.c  | 6 +++---
 10 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6bb251a4d613..757e8e170c48 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1471,6 +1471,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		/* does not support inline data > PAGE_SIZE */
 		ret = VM_FAULT_SIGBUS;
 	} else {
+		struct mnt_idmap *idmap = file_mnt_idmap(vma->vm_file);
 		struct address_space *mapping = inode->i_mapping;
 		struct page *page;
 
@@ -1481,7 +1482,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 			ret = VM_FAULT_OOM;
 			goto out_inline;
 		}
-		err = __ceph_do_getattr(inode, page,
+		err = __ceph_do_getattr(idmap, inode, page,
 					 CEPH_STAT_CAP_INLINE_DATA, true);
 		if (err < 0 || off >= i_size_read(inode)) {
 			unlock_page(page);
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 2321e5ddb664..d083ec5fda36 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2906,6 +2906,7 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret, _got, flags;
 
 	ret = ceph_pool_perm_check(inode, need);
@@ -3015,7 +3016,7 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 			 * getattr request will bring inline data into
 			 * page cache
 			 */
-			ret = __ceph_do_getattr(inode, NULL,
+			ret = __ceph_do_getattr(idmap, inode, NULL,
 						CEPH_STAT_CAP_INLINE_DATA,
 						true);
 			if (ret < 0)
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index f780e4e0d062..9f3c6e911ae6 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -187,7 +187,7 @@ static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	/* We need LINK caps to reliably check i_nlink */
-	err = ceph_do_getattr(inode, CEPH_CAP_LINK_SHARED, false);
+	err = ceph_do_getattr(&nop_mnt_idmap, inode, CEPH_CAP_LINK_SHARED, false);
 	if (err) {
 		iput(inode);
 		return ERR_PTR(err);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d46b6b8b5fcb..0019d5b4ae3c 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1613,6 +1613,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	size_t len = iov_iter_count(to);
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	bool direct_lock = iocb->ki_flags & IOCB_DIRECT;
 	ssize_t ret;
 	int want = 0, got = 0;
@@ -1693,7 +1694,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				return -ENOMEM;
 		}
 
-		statret = __ceph_do_getattr(inode, page,
+		statret = __ceph_do_getattr(idmap, inode, page,
 					    CEPH_STAT_CAP_INLINE_DATA, !!page);
 		if (statret < 0) {
 			if (page)
@@ -1768,6 +1769,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written = 0;
@@ -1801,7 +1803,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	current->backing_dev_info = inode_to_bdi(inode);
 
 	if (iocb->ki_flags & IOCB_APPEND) {
-		err = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
+		err = ceph_do_getattr(idmap, inode, CEPH_STAT_CAP_SIZE, false);
 		if (err < 0)
 			goto out;
 	}
@@ -1957,9 +1959,10 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
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
index 58ec603a55af..3838d7dd7cd7 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2300,7 +2300,8 @@ int ceph_try_to_choose_auth_mds(struct inode *inode, int mask)
  * Verify that we have a lease on the given mask.  If not,
  * do a getattr against an mds.
  */
-int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
+int __ceph_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
+		      struct page *locked_page,
 		      int mask, bool force)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
@@ -2325,6 +2326,7 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		return PTR_ERR(req);
 	req->r_inode = inode;
 	ihold(inode);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_num_caps = 1;
 	req->r_args.getattr.mask = cpu_to_le32(mask);
 	req->r_locked_page = locked_page;
@@ -2411,7 +2413,7 @@ int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
-	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
+	err = ceph_do_getattr(idmap, inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
 		err = generic_permission(idmap, inode, mask);
@@ -2464,7 +2466,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	/* Skip the getattr altogether if we're asked not to sync */
 	if ((flags & AT_STATX_SYNC_TYPE) != AT_STATX_DONT_SYNC) {
-		err = ceph_do_getattr(inode,
+		err = ceph_do_getattr(idmap, inode,
 				statx_to_caps(request_mask, inode->i_mode),
 				flags & AT_STATX_FORCE_SYNC);
 		if (err)
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index deac817647eb..07be54ecc94d 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -17,10 +17,11 @@
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
@@ -64,6 +65,7 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
 static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
@@ -75,7 +77,7 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 		return -EFAULT;
 
 	/* validate changed params against current layout */
-	err = ceph_do_getattr(file_inode(file), CEPH_STAT_CAP_LAYOUT, false);
+	err = ceph_do_getattr(idmap, file_inode(file), CEPH_STAT_CAP_LAYOUT, false);
 	if (err)
 		return err;
 
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 64592adfe48f..aea122ac3cbe 100644
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
index 3fc48b43cab0..797a6cb3733c 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1415,8 +1415,8 @@ int ceph_force_reconnect(struct super_block *sb)
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
index d9cc27307cb7..ccef4a6bac52 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1044,11 +1044,13 @@ static inline void ceph_queue_flush_snaps(struct inode *inode)
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
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 806183959c47..d3ac854bc11f 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -952,7 +952,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 			mask |= CEPH_STAT_RSTAT;
 		if (vxattr->flags & VXATTR_FLAG_DIRSTAT)
 			mask |= CEPH_CAP_FILE_SHARED;
-		err = ceph_do_getattr(inode, mask, true);
+		err = ceph_do_getattr(&nop_mnt_idmap, inode, mask, true);
 		if (err)
 			return err;
 		err = -ENODATA;
@@ -989,7 +989,7 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		}
 
 		/* get xattrs from mds (if we don't already have them) */
-		err = ceph_do_getattr(inode, CEPH_STAT_CAP_XATTR, true);
+		err = ceph_do_getattr(&nop_mnt_idmap, inode, CEPH_STAT_CAP_XATTR, true);
 		if (err)
 			return err;
 		spin_lock(&ci->i_ceph_lock);
@@ -1038,7 +1038,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
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

