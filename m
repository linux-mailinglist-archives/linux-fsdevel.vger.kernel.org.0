Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953B1602AFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiJRMAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJRL7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12CBBE2F9;
        Tue, 18 Oct 2022 04:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8718AB81EB9;
        Tue, 18 Oct 2022 11:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C66C43470;
        Tue, 18 Oct 2022 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094318;
        bh=mhSRdhRtzQACeyZ3OrjS99TbMIk9n2C+qOD5Q4totY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhJrnjSyW6idAJ1z9QSrAvKUxAamBS0XrxTC5/yx/VpSn3smEmcb+cSBF/nqDT3uZ
         BcbJxRQZ87/PkKc4EyoQWbjhb4le34u3HNryvPZrKNkg/g1+Wm8fYeCTJdwhWWVR+W
         AJm/ghonCZrxMMZb4/uMsOdMQgFl5xnFXg6Z7GnIqxaejRuJv1Jz4/H8Od9FArPNUj
         tOeOHBuT2ZxpF8JUPRjVkWn1LfSdiaBeJJaBZ8J6DumBSOvZfrQfdwyQCGC8jhvFTZ
         2FfRAFiYBlwNgxYZgmxYBZiriQuM+cHpqnN/H9XO/gEdwtNdzDf0ryK7qDlfAn04dz
         hhVAPUjQp6JwA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 30/30] acl: remove a slew of now unused helpers
Date:   Tue, 18 Oct 2022 13:57:00 +0200
Message-Id: <20221018115700.166010-31-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19759; i=brauner@kernel.org; h=from:subject; bh=mhSRdhRtzQACeyZ3OrjS99TbMIk9n2C+qOD5Q4totY4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdE6f6+U0Unzfum2ysVCJ/ectxG4bqA8+fhDr6kPT8vN 0fjh1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARH1eG/1knd8kUVzc3Ce019r935K PjYQG3JvYg2cZ7h682Pa8Qa2JkeMgXcb5f95HgG93FR7kE7A87Xg1evKfPzPhYSc6xHJPt7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the posix acl api is active we can remove all the hacky helpers
we had to keep around for all these years and also remove the set and
get posix acl xattr handler methods as they aren't needed anymore.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged
    
    /* v5 */
    unchanged

 fs/posix_acl.c                  | 363 ++------------------------------
 fs/xattr.c                      |   5 +-
 include/linux/posix_acl_xattr.h |  20 --
 3 files changed, 23 insertions(+), 365 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 35e4caaedfd8..b4be7d167882 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -747,118 +747,32 @@ static int posix_acl_fix_xattr_common(const void *value, size_t size)
 	return count;
 }
 
-void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
-				     const struct inode *inode,
-				     void *value, size_t size)
-{
-	struct posix_acl_xattr_header *header = value;
-	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
-	struct user_namespace *fs_userns = i_user_ns(inode);
-	int count;
-	vfsuid_t vfsuid;
-	vfsgid_t vfsgid;
-	kuid_t uid;
-	kgid_t gid;
-
-	if (no_idmapping(mnt_userns, i_user_ns(inode)))
-		return;
-
-	count = posix_acl_fix_xattr_common(value, size);
-	if (count <= 0)
-		return;
-
-	for (end = entry + count; entry != end; entry++) {
-		switch (le16_to_cpu(entry->e_tag)) {
-		case ACL_USER:
-			uid = make_kuid(&init_user_ns, le32_to_cpu(entry->e_id));
-			vfsuid = make_vfsuid(mnt_userns, fs_userns, uid);
-			entry->e_id = cpu_to_le32(from_kuid(&init_user_ns,
-						vfsuid_into_kuid(vfsuid)));
-			break;
-		case ACL_GROUP:
-			gid = make_kgid(&init_user_ns, le32_to_cpu(entry->e_id));
-			vfsgid = make_vfsgid(mnt_userns, fs_userns, gid);
-			entry->e_id = cpu_to_le32(from_kgid(&init_user_ns,
-						vfsgid_into_kgid(vfsgid)));
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-static void posix_acl_fix_xattr_userns(
-	struct user_namespace *to, struct user_namespace *from,
-	void *value, size_t size)
-{
-	struct posix_acl_xattr_header *header = value;
-	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
-	int count;
-	kuid_t uid;
-	kgid_t gid;
-
-	count = posix_acl_fix_xattr_common(value, size);
-	if (count <= 0)
-		return;
-
-	for (end = entry + count; entry != end; entry++) {
-		switch(le16_to_cpu(entry->e_tag)) {
-		case ACL_USER:
-			uid = make_kuid(from, le32_to_cpu(entry->e_id));
-			entry->e_id = cpu_to_le32(from_kuid(to, uid));
-			break;
-		case ACL_GROUP:
-			gid = make_kgid(from, le32_to_cpu(entry->e_id));
-			entry->e_id = cpu_to_le32(from_kgid(to, gid));
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-void posix_acl_fix_xattr_from_user(void *value, size_t size)
-{
-	struct user_namespace *user_ns = current_user_ns();
-	if (user_ns == &init_user_ns)
-		return;
-	posix_acl_fix_xattr_userns(&init_user_ns, user_ns, value, size);
-}
-
-void posix_acl_fix_xattr_to_user(void *value, size_t size)
-{
-	struct user_namespace *user_ns = current_user_ns();
-	if (user_ns == &init_user_ns)
-		return;
-	posix_acl_fix_xattr_userns(user_ns, &init_user_ns, value, size);
-}
-
 /**
- * make_posix_acl - convert POSIX ACLs from uapi to VFS format using the
- *                  provided callbacks to map ACL_{GROUP,USER} entries into the
- *                  appropriate format
- * @mnt_userns: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
+ * posix_acl_from_xattr - convert POSIX ACLs from backing store to VFS format
+ * @userns: the filesystem's idmapping
  * @value: the uapi representation of POSIX ACLs
  * @size: the size of @void
- * @uid_cb: callback to use for mapping the uid stored in ACL_USER entries
- * @gid_cb: callback to use for mapping the gid stored in ACL_GROUP entries
  *
- * The make_posix_acl() helper is an abstraction to translate from uapi format
- * into the VFS format allowing the caller to specific callbacks to map
- * ACL_{GROUP,USER} entries into the expected format. This is used in
- * posix_acl_from_xattr() and vfs_set_acl_prepare() and avoids pointless code
- * duplication.
+ * Filesystems that store POSIX ACLs in the unaltered uapi format should use
+ * posix_acl_from_xattr() when reading them from the backing store and
+ * converting them into the struct posix_acl VFS format. The helper is
+ * specifically intended to be called from the acl inode operation.
+ *
+ * The posix_acl_from_xattr() function will map the raw {g,u}id values stored
+ * in ACL_{GROUP,USER} entries into idmapping in @userns.
+ *
+ * Note that posix_acl_from_xattr() does not take idmapped mounts into account.
+ * If it did it calling it from the get acl inode operation would return POSIX
+ * ACLs mapped according to an idmapped mount which would mean that the value
+ * couldn't be cached for the filesystem. Idmapped mounts are taken into
+ * account on the fly during permission checking or right at the VFS -
+ * userspace boundary before reporting them to the user.
  *
  * Return: Allocated struct posix_acl on success, NULL for a valid header but
  *         without actual POSIX ACL entries, or ERR_PTR() encoded error code.
  */
-static struct posix_acl *make_posix_acl(struct user_namespace *mnt_userns,
-	struct user_namespace *fs_userns, const void *value, size_t size,
-	kuid_t (*uid_cb)(struct user_namespace *, struct user_namespace *,
-			 const struct posix_acl_xattr_entry *),
-	kgid_t (*gid_cb)(struct user_namespace *, struct user_namespace *,
-			 const struct posix_acl_xattr_entry *))
+struct posix_acl *posix_acl_from_xattr(struct user_namespace *userns,
+				       const void *value, size_t size)
 {
 	const struct posix_acl_xattr_header *header = value;
 	const struct posix_acl_xattr_entry *entry = (const void *)(header + 1), *end;
@@ -889,12 +803,14 @@ static struct posix_acl *make_posix_acl(struct user_namespace *mnt_userns,
 				break;
 
 			case ACL_USER:
-				acl_e->e_uid = uid_cb(mnt_userns, fs_userns, entry);
+				acl_e->e_uid = make_kuid(userns,
+						le32_to_cpu(entry->e_id));
 				if (!uid_valid(acl_e->e_uid))
 					goto fail;
 				break;
 			case ACL_GROUP:
-				acl_e->e_gid = gid_cb(mnt_userns, fs_userns, entry);
+				acl_e->e_gid = make_kgid(userns,
+						le32_to_cpu(entry->e_id));
 				if (!gid_valid(acl_e->e_gid))
 					goto fail;
 				break;
@@ -909,182 +825,6 @@ static struct posix_acl *make_posix_acl(struct user_namespace *mnt_userns,
 	posix_acl_release(acl);
 	return ERR_PTR(-EINVAL);
 }
-
-/**
- * vfs_set_acl_prepare_kuid - map ACL_USER uid according to mount- and
- *                            filesystem idmapping
- * @mnt_userns: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @e: a ACL_USER entry in POSIX ACL uapi format
- *
- * The uid stored as ACL_USER entry in @e is a kuid_t stored as a raw {g,u}id
- * value. The vfs_set_acl_prepare_kuid() will recover the kuid_t through
- * KUIDT_INIT() and then map it according to the idmapped mount. The resulting
- * kuid_t is the value which the filesystem can map up into a raw backing store
- * id in the filesystem's idmapping.
- *
- * This is used in vfs_set_acl_prepare() to generate the proper VFS
- * representation of POSIX ACLs with ACL_USER entries during setxattr().
- *
- * Return: A kuid in @fs_userns for the uid stored in @e.
- */
-static inline kuid_t
-vfs_set_acl_prepare_kuid(struct user_namespace *mnt_userns,
-			 struct user_namespace *fs_userns,
-			 const struct posix_acl_xattr_entry *e)
-{
-	kuid_t kuid = KUIDT_INIT(le32_to_cpu(e->e_id));
-	return from_vfsuid(mnt_userns, fs_userns, VFSUIDT_INIT(kuid));
-}
-
-/**
- * vfs_set_acl_prepare_kgid - map ACL_GROUP gid according to mount- and
- *                            filesystem idmapping
- * @mnt_userns: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @e: a ACL_GROUP entry in POSIX ACL uapi format
- *
- * The gid stored as ACL_GROUP entry in @e is a kgid_t stored as a raw {g,u}id
- * value. The vfs_set_acl_prepare_kgid() will recover the kgid_t through
- * KGIDT_INIT() and then map it according to the idmapped mount. The resulting
- * kgid_t is the value which the filesystem can map up into a raw backing store
- * id in the filesystem's idmapping.
- *
- * This is used in vfs_set_acl_prepare() to generate the proper VFS
- * representation of POSIX ACLs with ACL_GROUP entries during setxattr().
- *
- * Return: A kgid in @fs_userns for the gid stored in @e.
- */
-static inline kgid_t
-vfs_set_acl_prepare_kgid(struct user_namespace *mnt_userns,
-			 struct user_namespace *fs_userns,
-			 const struct posix_acl_xattr_entry *e)
-{
-	kgid_t kgid = KGIDT_INIT(le32_to_cpu(e->e_id));
-	return from_vfsgid(mnt_userns, fs_userns, VFSGIDT_INIT(kgid));
-}
-
-/**
- * vfs_set_acl_prepare - convert POSIX ACLs from uapi to VFS format taking
- *                       mount and filesystem idmappings into account
- * @mnt_userns: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @value: the uapi representation of POSIX ACLs
- * @size: the size of @void
- *
- * When setting POSIX ACLs with ACL_{GROUP,USER} entries they need to be
- * mapped according to the relevant mount- and filesystem idmapping. It is
- * important that the ACL_{GROUP,USER} entries in struct posix_acl will be
- * mapped into k{g,u}id_t that are supposed to be mapped up in the filesystem
- * idmapping. This is crucial since the resulting struct posix_acl might be
- * cached filesystem wide. The vfs_set_acl_prepare() function will take care to
- * perform all necessary idmappings.
- *
- * Note, that since basically forever the {g,u}id values encoded as
- * ACL_{GROUP,USER} entries in the uapi POSIX ACLs passed via @value contain
- * values that have been mapped according to the caller's idmapping. In other
- * words, POSIX ACLs passed in uapi format as @value during setxattr() contain
- * {g,u}id values in their ACL_{GROUP,USER} entries that should actually have
- * been stored as k{g,u}id_t.
- *
- * This means, vfs_set_acl_prepare() needs to first recover the k{g,u}id_t by
- * calling K{G,U}IDT_INIT(). Afterwards they can be interpreted as vfs{g,u}id_t
- * through from_vfs{g,u}id() to account for any idmapped mounts. The
- * vfs_set_acl_prepare_k{g,u}id() helpers will take care to generate the
- * correct k{g,u}id_t.
- *
- * The filesystem will then receive the POSIX ACLs ready to be cached
- * filesystem wide and ready to be written to the backing store taking the
- * filesystem's idmapping into account.
- *
- * Return: Allocated struct posix_acl on success, NULL for a valid header but
- *         without actual POSIX ACL entries, or ERR_PTR() encoded error code.
- */
-struct posix_acl *vfs_set_acl_prepare(struct user_namespace *mnt_userns,
-				      struct user_namespace *fs_userns,
-				      const void *value, size_t size)
-{
-	return make_posix_acl(mnt_userns, fs_userns, value, size,
-			      vfs_set_acl_prepare_kuid,
-			      vfs_set_acl_prepare_kgid);
-}
-EXPORT_SYMBOL(vfs_set_acl_prepare);
-
-/**
- * posix_acl_from_xattr_kuid - map ACL_USER uid into filesystem idmapping
- * @mnt_userns: unused
- * @fs_userns: the filesystem's idmapping
- * @e: a ACL_USER entry in POSIX ACL uapi format
- *
- * Map the uid stored as ACL_USER entry in @e into the filesystem's idmapping.
- * This is used in posix_acl_from_xattr() to generate the proper VFS
- * representation of POSIX ACLs with ACL_USER entries.
- *
- * Return: A kuid in @fs_userns for the uid stored in @e.
- */
-static inline kuid_t
-posix_acl_from_xattr_kuid(struct user_namespace *mnt_userns,
-			  struct user_namespace *fs_userns,
-			  const struct posix_acl_xattr_entry *e)
-{
-	return make_kuid(fs_userns, le32_to_cpu(e->e_id));
-}
-
-/**
- * posix_acl_from_xattr_kgid - map ACL_GROUP gid into filesystem idmapping
- * @mnt_userns: unused
- * @fs_userns: the filesystem's idmapping
- * @e: a ACL_GROUP entry in POSIX ACL uapi format
- *
- * Map the gid stored as ACL_GROUP entry in @e into the filesystem's idmapping.
- * This is used in posix_acl_from_xattr() to generate the proper VFS
- * representation of POSIX ACLs with ACL_GROUP entries.
- *
- * Return: A kgid in @fs_userns for the gid stored in @e.
- */
-static inline kgid_t
-posix_acl_from_xattr_kgid(struct user_namespace *mnt_userns,
-			  struct user_namespace *fs_userns,
-			  const struct posix_acl_xattr_entry *e)
-{
-	return make_kgid(fs_userns, le32_to_cpu(e->e_id));
-}
-
-/**
- * posix_acl_from_xattr - convert POSIX ACLs from backing store to VFS format
- * @fs_userns: the filesystem's idmapping
- * @value: the uapi representation of POSIX ACLs
- * @size: the size of @void
- *
- * Filesystems that store POSIX ACLs in the unaltered uapi format should use
- * posix_acl_from_xattr() when reading them from the backing store and
- * converting them into the struct posix_acl VFS format. The helper is
- * specifically intended to be called from the ->get_inode_acl() inode
- * operation.
- *
- * The posix_acl_from_xattr() function will map the raw {g,u}id values stored
- * in ACL_{GROUP,USER} entries into the filesystem idmapping in @fs_userns. The
- * posix_acl_from_xattr_k{g,u}id() helpers will take care to generate the
- * correct k{g,u}id_t. The returned struct posix_acl can be cached.
- *
- * Note that posix_acl_from_xattr() does not take idmapped mounts into account.
- * If it did it calling is from the ->get_inode_acl() inode operation would
- * return POSIX ACLs mapped according to an idmapped mount which would mean
- * that the value couldn't be cached for the filesystem. Idmapped mounts are
- * taken into account on the fly during permission checking or right at the VFS
- * - userspace boundary before reporting them to the user.
- *
- * Return: Allocated struct posix_acl on success, NULL for a valid header but
- *         without actual POSIX ACL entries, or ERR_PTR() encoded error code.
- */
-struct posix_acl *
-posix_acl_from_xattr(struct user_namespace *fs_userns,
-		     const void *value, size_t size)
-{
-	return make_posix_acl(&init_user_ns, fs_userns, value, size,
-			      posix_acl_from_xattr_kuid,
-			      posix_acl_from_xattr_kgid);
-}
 EXPORT_SYMBOL (posix_acl_from_xattr);
 
 /*
@@ -1190,31 +930,6 @@ ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
 	return real_size;
 }
 
-static int
-posix_acl_xattr_get(const struct xattr_handler *handler,
-		    struct dentry *unused, struct inode *inode,
-		    const char *name, void *value, size_t size)
-{
-	struct posix_acl *acl;
-	int error;
-
-	if (!IS_POSIXACL(inode))
-		return -EOPNOTSUPP;
-	if (S_ISLNK(inode->i_mode))
-		return -EOPNOTSUPP;
-
-	acl = get_inode_acl(inode, handler->flags);
-	if (IS_ERR(acl))
-		return PTR_ERR(acl);
-	if (acl == NULL)
-		return -ENODATA;
-
-	error = posix_acl_to_xattr(&init_user_ns, acl, value, size);
-	posix_acl_release(acl);
-
-	return error;
-}
-
 int
 set_posix_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	      int type, struct posix_acl *acl)
@@ -1240,36 +955,6 @@ set_posix_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL(set_posix_acl);
 
-static int
-posix_acl_xattr_set(const struct xattr_handler *handler,
-			   struct user_namespace *mnt_userns,
-			   struct dentry *dentry, struct inode *inode,
-			   const char *name, const void *value, size_t size,
-			   int flags)
-{
-	struct posix_acl *acl = NULL;
-	int ret;
-
-	if (value) {
-		/*
-		 * By the time we end up here the {g,u}ids stored in
-		 * ACL_{GROUP,USER} have already been mapped according to the
-		 * caller's idmapping. The vfs_set_acl_prepare() helper will
-		 * recover them and take idmapped mounts into account. The
-		 * filesystem will receive the POSIX ACLs in the correct
-		 * format ready to be cached or written to the backing store
-		 * taking the filesystem idmapping into account.
-		 */
-		acl = vfs_set_acl_prepare(mnt_userns, i_user_ns(inode),
-					  value, size);
-		if (IS_ERR(acl))
-			return PTR_ERR(acl);
-	}
-	ret = set_posix_acl(mnt_userns, dentry, handler->flags, acl);
-	posix_acl_release(acl);
-	return ret;
-}
-
 static bool
 posix_acl_xattr_list(struct dentry *dentry)
 {
@@ -1280,8 +965,6 @@ const struct xattr_handler posix_acl_access_xattr_handler = {
 	.name = XATTR_NAME_POSIX_ACL_ACCESS,
 	.flags = ACL_TYPE_ACCESS,
 	.list = posix_acl_xattr_list,
-	.get = posix_acl_xattr_get,
-	.set = posix_acl_xattr_set,
 };
 EXPORT_SYMBOL_GPL(posix_acl_access_xattr_handler);
 
@@ -1289,8 +972,6 @@ const struct xattr_handler posix_acl_default_xattr_handler = {
 	.name = XATTR_NAME_POSIX_ACL_DEFAULT,
 	.flags = ACL_TYPE_DEFAULT,
 	.list = posix_acl_xattr_list,
-	.get = posix_acl_xattr_get,
-	.set = posix_acl_xattr_set,
 };
 EXPORT_SYMBOL_GPL(posix_acl_default_xattr_handler);
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 77db5aa26d13..df3af9fa8c77 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -454,10 +454,7 @@ vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return ret;
 	}
 nolsm:
-	error = __vfs_getxattr(dentry, inode, name, value, size);
-	if (error > 0 && is_posix_acl_xattr(name))
-		posix_acl_getxattr_idmapped_mnt(mnt_userns, inode, value, size);
-	return error;
+	return __vfs_getxattr(dentry, inode, name, value, size);
 }
 EXPORT_SYMBOL_GPL(vfs_getxattr);
 
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index c5d5fbc348dc..8daac3c5b583 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -35,11 +35,6 @@ posix_acl_xattr_count(size_t size)
 #ifdef CONFIG_FS_POSIX_ACL
 struct posix_acl *posix_acl_from_xattr(struct user_namespace *user_ns,
 				       const void *value, size_t size);
-void posix_acl_fix_xattr_from_user(void *value, size_t size);
-void posix_acl_fix_xattr_to_user(void *value, size_t size);
-void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
-				     const struct inode *inode,
-				     void *value, size_t size);
 ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
 			       struct inode *inode, const struct posix_acl *acl,
 			       void *buffer, size_t size);
@@ -50,18 +45,6 @@ posix_acl_from_xattr(struct user_namespace *user_ns, const void *value,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
-{
-}
-static inline void posix_acl_fix_xattr_to_user(void *value, size_t size)
-{
-}
-static inline void
-posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
-				const struct inode *inode, void *value,
-				size_t size)
-{
-}
 static inline ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
 					     struct inode *inode,
 					     const struct posix_acl *acl,
@@ -73,9 +56,6 @@ static inline ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
 
 int posix_acl_to_xattr(struct user_namespace *user_ns,
 		       const struct posix_acl *acl, void *buffer, size_t size);
-struct posix_acl *vfs_set_acl_prepare(struct user_namespace *mnt_userns,
-				      struct user_namespace *fs_userns,
-				      const void *value, size_t size);
 static inline const char *posix_acl_xattr_name(int type)
 {
 	switch (type) {
-- 
2.34.1

