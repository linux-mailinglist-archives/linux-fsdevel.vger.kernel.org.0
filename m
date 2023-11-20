Return-Path: <linux-fsdevel+bounces-3250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6217F1B17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7F91C2165E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D3F224F9;
	Mon, 20 Nov 2023 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F7711A;
	Mon, 20 Nov 2023 09:41:23 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SYvbR5ggkz9yBkQ;
	Tue, 21 Nov 2023 01:27:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXBXXxmVtlIZIKAQ--.7181S5;
	Mon, 20 Nov 2023 18:40:55 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 23/25] evm: Remove dependency on 'integrity' LSM
Date: Mon, 20 Nov 2023 18:33:16 +0100
Message-Id: <20231120173318.1132868-24-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXBXXxmVtlIZIKAQ--.7181S5
X-Coremail-Antispam: 1UD129KBjvJXoW3CF13Gw4UtF48Jr13KFWUtwb_yoWDtr1UpF
	s8Kay8Jr1rAFZrGFZYyF1Duw1fKrW8WrWxW3yYkwn2yFnFqw40qry8tryj9ryrKrW8Gwn2
	qF1a9rs8Za1Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W0oVCq3wA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_GcCE3s1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r
	4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07jxUUUU
	UUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apggADsN
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Similarly to IMA, introduce EVM own integrity metadata (evm_iint_cache,
with EVM-specific fields from integrity_iint_cache), and reserve them from
the 'evm' LSM.

First, replace the integrity_iint_cache structure with evm_iint_cache in
various places of the EVM code.

Then, reserve space in the security blob for the evm_iint_cache structure,
so that retrieval always succeeds. Replace integrity_inode_get() and
integrity_iint_find() with evm_inode_get_iint(), to retrieve the
evm_iint_cache structure.

Initialize the new evm_iint_cache structure by registering
evm_inode_alloc_security() as implementation of the inode_alloc_security
LSM hook.

Since now IMA and EVM integrity metadata are disjoint, and always
available, remove the iint parameter from evm_verifyxattr() and always
retrieve the evm_iint_cache structure in evm_verify_hmac(), called by
evm_verifyxattr() and evm_verify_current_integrity().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/evm.h                   |  8 +---
 security/integrity/evm/evm.h          | 17 ++++++++
 security/integrity/evm/evm_crypto.c   |  5 +--
 security/integrity/evm/evm_main.c     | 63 ++++++++++++++-------------
 security/integrity/ima/ima_appraise.c |  2 +-
 5 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index cb481eccc967..d48d6da32315 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -12,15 +12,12 @@
 #include <linux/integrity.h>
 #include <linux/xattr.h>
 
-struct integrity_iint_cache;
-
 #ifdef CONFIG_EVM
 extern int evm_set_key(void *key, size_t keylen);
 extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     const char *xattr_name,
 					     void *xattr_value,
-					     size_t xattr_value_len,
-					     struct integrity_iint_cache *iint);
+					     size_t xattr_value_len);
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    const struct qstr *qstr, struct xattr *xattrs,
 			    int *xattr_count);
@@ -48,8 +45,7 @@ static inline int evm_set_key(void *key, size_t keylen)
 static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
 						    const char *xattr_name,
 						    void *xattr_value,
-						    size_t xattr_value_len,
-					struct integrity_iint_cache *iint)
+						    size_t xattr_value_len)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 53bd7fec93fa..478b6fbca699 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -32,6 +32,23 @@ struct xattr_list {
 	bool enabled;
 };
 
+/* EVM integrity metadata associated with an inode */
+struct evm_iint_cache {
+	unsigned long flags;
+	enum integrity_status evm_status:4;
+};
+
+extern struct lsm_blob_sizes evm_blob_sizes;
+
+static inline struct evm_iint_cache *
+evm_inode_get_iint(const struct inode *inode)
+{
+	struct evm_iint_cache *evm_iint_sec;
+
+	evm_iint_sec = inode->i_security + evm_blob_sizes.lbs_inode;
+	return evm_iint_sec;
+}
+
 extern int evm_initialized;
 
 #define EVM_ATTR_FSUUID		0x0001
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b1ffd4cc0b44..c69422cc4a52 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -322,11 +322,10 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
 {
 	const struct evm_ima_xattr_data *xattr_data = NULL;
-	struct integrity_iint_cache *iint;
+	struct evm_iint_cache *iint = evm_inode_get_iint(inode);
 	int rc = 0;
 
-	iint = integrity_iint_find(inode);
-	if (iint && (iint->flags & EVM_IMMUTABLE_DIGSIG))
+	if (iint->flags & EVM_IMMUTABLE_DIGSIG)
 		return 1;
 
 	/* Do this the hard way */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 1e59a985b845..5aa5207a75e1 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -167,18 +167,20 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					     const char *xattr_name,
 					     char *xattr_value,
-					     size_t xattr_value_len,
-					     struct integrity_iint_cache *iint)
+					     size_t xattr_value_len)
 {
 	struct evm_ima_xattr_data *xattr_data = NULL;
 	struct signature_v2_hdr *hdr;
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	struct evm_digest digest;
 	struct inode *inode;
+	struct evm_iint_cache *iint;
 	int rc, xattr_len, evm_immutable = 0;
 
-	if (iint && (iint->evm_status == INTEGRITY_PASS ||
-		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
+	iint = evm_inode_get_iint(d_backing_inode(dentry));
+
+	if ((iint->evm_status == INTEGRITY_PASS ||
+	     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
 		return iint->evm_status;
 
 	/* if status is not PASS, try to check again - against -ENOMEM */
@@ -243,8 +245,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			inode = d_backing_inode(dentry);
 
 			if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
-				if (iint)
-					iint->flags |= EVM_IMMUTABLE_DIGSIG;
+				iint->flags |= EVM_IMMUTABLE_DIGSIG;
 				evm_status = INTEGRITY_PASS_IMMUTABLE;
 			} else if (!IS_RDONLY(inode) &&
 				   !(inode->i_sb->s_readonly_remount) &&
@@ -271,8 +272,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	pr_debug("digest: (%d) [%*phN]\n", digest.hdr.length, digest.hdr.length,
 		  digest.digest);
 out:
-	if (iint)
-		iint->evm_status = evm_status;
+	iint->evm_status = evm_status;
 	kfree(xattr_data);
 	return evm_status;
 }
@@ -389,7 +389,6 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
  * @xattr_name: requested xattr
  * @xattr_value: requested xattr value
  * @xattr_value_len: requested xattr value length
- * @iint: inode integrity metadata
  *
  * Calculate the HMAC for the given dentry and verify it against the stored
  * security.evm xattr. For performance, use the xattr value and length
@@ -402,19 +401,13 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
  */
 enum integrity_status evm_verifyxattr(struct dentry *dentry,
 				      const char *xattr_name,
-				      void *xattr_value, size_t xattr_value_len,
-				      struct integrity_iint_cache *iint)
+				      void *xattr_value, size_t xattr_value_len)
 {
 	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
 		return INTEGRITY_UNKNOWN;
 
-	if (!iint) {
-		iint = integrity_inode_get(d_backing_inode(dentry));
-		if (!iint)
-			return INTEGRITY_UNKNOWN;
-	}
 	return evm_verify_hmac(dentry, xattr_name, xattr_value,
-				 xattr_value_len, iint);
+				 xattr_value_len);
 }
 EXPORT_SYMBOL_GPL(evm_verifyxattr);
 
@@ -431,7 +424,7 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 
 	if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_fixmode)
 		return INTEGRITY_PASS;
-	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
+	return evm_verify_hmac(dentry, NULL, NULL, 0);
 }
 
 /*
@@ -503,14 +496,14 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 
 	evm_status = evm_verify_current_integrity(dentry);
 	if (evm_status == INTEGRITY_NOXATTRS) {
-		struct integrity_iint_cache *iint;
+		struct evm_iint_cache *iint;
 
 		/* Exception if the HMAC is not going to be calculated. */
 		if (evm_hmac_disabled())
 			return 0;
 
-		iint = integrity_iint_find(d_backing_inode(dentry));
-		if (iint && (iint->flags & IMA_NEW_FILE))
+		iint = evm_inode_get_iint(d_backing_inode(dentry));
+		if ((iint->flags & IMA_NEW_FILE))
 			return 0;
 
 		/* exception for pseudo filesystems */
@@ -712,11 +705,9 @@ static int evm_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 
 static void evm_reset_status(struct inode *inode)
 {
-	struct integrity_iint_cache *iint;
+	struct evm_iint_cache *iint = evm_inode_get_iint(inode);
 
-	iint = integrity_iint_find(inode);
-	if (iint)
-		iint->evm_status = INTEGRITY_UNKNOWN;
+	iint->evm_status = INTEGRITY_UNKNOWN;
 }
 
 /**
@@ -982,12 +973,11 @@ EXPORT_SYMBOL_GPL(evm_inode_init_security);
 static void __maybe_unused
 evm_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
-	struct integrity_iint_cache *iint;
+	struct evm_iint_cache *iint;
 
-	iint = integrity_inode_get(d_backing_inode(dentry));
-	if (iint)
-		/* needed for successful verification of empty files */
-		iint->flags |= IMA_NEW_FILE;
+	iint = evm_inode_get_iint(d_backing_inode(dentry));
+	/* needed for successful verification of empty files */
+	iint->flags |= IMA_NEW_FILE;
 }
 
 #ifdef CONFIG_EVM_LOAD_X509
@@ -1029,6 +1019,15 @@ static int __init init_evm(void)
 	return error;
 }
 
+static int evm_inode_alloc_security(struct inode *inode)
+{
+	struct evm_iint_cache *evm_iint = evm_inode_get_iint(inode);
+
+	evm_iint->flags = 0UL;
+	evm_iint->evm_status = INTEGRITY_UNKNOWN;
+	return 0;
+}
+
 static struct security_hook_list evm_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_setattr, evm_inode_setattr),
 	LSM_HOOK_INIT(inode_post_setattr, evm_inode_post_setattr),
@@ -1041,6 +1040,7 @@ static struct security_hook_list evm_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_removexattr, evm_inode_removexattr),
 	LSM_HOOK_INIT(inode_post_removexattr, evm_inode_post_removexattr),
 	LSM_HOOK_INIT(inode_init_security, evm_inode_init_security),
+	LSM_HOOK_INIT(inode_alloc_security, evm_inode_alloc_security),
 #ifdef CONFIG_SECURITY_PATH
 	LSM_HOOK_INIT(path_post_mknod, evm_post_path_mknod),
 #endif
@@ -1064,7 +1064,8 @@ int __init init_evm_lsm(void)
 	return 0;
 }
 
-static struct lsm_blob_sizes evm_blob_sizes __ro_after_init = {
+struct lsm_blob_sizes evm_blob_sizes __ro_after_init = {
+	.lbs_inode = sizeof(struct evm_iint_cache),
 	.lbs_xattr_count = 1,
 };
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index b0b96c263961..89125efb7e06 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -519,7 +519,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value,
-				 rc < 0 ? 0 : rc, NULL);
+				 rc < 0 ? 0 : rc);
 	switch (status) {
 	case INTEGRITY_PASS:
 	case INTEGRITY_PASS_IMMUTABLE:
-- 
2.34.1


