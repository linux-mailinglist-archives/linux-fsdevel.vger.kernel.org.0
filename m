Return-Path: <linux-fsdevel+bounces-15672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD53E89172D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 11:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0351C22301
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A407D088;
	Fri, 29 Mar 2024 10:56:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055B6A347;
	Fri, 29 Mar 2024 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709808; cv=none; b=c00wy0XMaSNOxa7gO6jb4/GUio+kk0Z/cD9nd6wbPTuY5Opkk0eFFwXJWNBI8AHvgqU7RaORrb/wK7y/SaGiOdJW1kOXBPPzEGvmvr9de4ozCNO3oOVCdnSCYO/Xno7+tsckXynHZtq2N99vm57VXroiPojo1sVzj36kFQ5Jntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709808; c=relaxed/simple;
	bh=JczRvhAxp0oCK7GkF7t5XGDG+V3gmMYtZapyAPDTA+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nu99oGNa6aorOYW03eAse7dQV6Ou5BEzb6aG7CInHntNpEqGALY/FgPWyGU7kJlQB9YEruqI8a8NMyJhrQiiHsfnXb2CgirRL7bD81gvn1XeAnuqCay9UOgC2dCQPUfeHbghoGBgmDeCZelNwKqlVb1bMMr+zyL1BE0ZnHCRr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4V5cPT0MfBz9xqwd;
	Fri, 29 Mar 2024 18:40:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8E05A14068E;
	Fri, 29 Mar 2024 18:56:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDnISZMngZmVsAqBQ--.12203S3;
	Fri, 29 Mar 2024 11:56:31 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	pc@manguebit.com,
	christian@brauner.io,
	Roberto Sassu <roberto.sassu@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ima: evm: Rename *_post_path_mknod() to *_path_post_mknod()
Date: Fri, 29 Mar 2024 11:56:09 +0100
Message-Id: <20240329105609.1566309-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDnISZMngZmVsAqBQ--.12203S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF18Gr1ktr15Aw45GFW5trb_yoW5urykpa
	n5t3WUGrn8JFy5Wr1kAFy7ZFyFg34rXFWUWan5Kw1SyF9xtr1qqFn29a4Y9FZ8tFW0gryI
	v3WUtrn8Zw4Utw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0GY
	LDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj5vtpQACs0

From: Roberto Sassu <roberto.sassu@huawei.com>

Rename ima_post_path_mknod() and evm_post_path_mknod() respectively to
ima_path_post_mknod() and evm_path_post_mknod(), to facilitate finding
users of the path_post_mknod LSM hook.

Cc: stable@vger.kernel.org # 6.8.x
Reported-by: Christian Brauner <christian@brauner.io>
Closes: https://lore.kernel.org/linux-kernel/20240328-raushalten-krass-cb040068bde9@brauner/
Fixes: 05d1a717ec04 ("ima: add support for creating files using the mknodat syscall")
Fixes: cd3cec0a02c7 ("ima: Move to LSM infrastructure")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_main.c | 4 ++--
 security/integrity/ima/ima_main.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ec1659273fcf..b4dd6e960203 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1034,7 +1034,7 @@ static void evm_file_release(struct file *file)
 		iint->flags &= ~EVM_NEW_FILE;
 }
 
-static void evm_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
+static void evm_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct evm_iint_cache *iint;
@@ -1102,7 +1102,7 @@ static struct security_hook_list evm_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_init_security, evm_inode_init_security),
 	LSM_HOOK_INIT(inode_alloc_security, evm_inode_alloc_security),
 	LSM_HOOK_INIT(file_release, evm_file_release),
-	LSM_HOOK_INIT(path_post_mknod, evm_post_path_mknod),
+	LSM_HOOK_INIT(path_post_mknod, evm_path_post_mknod),
 };
 
 static const struct lsm_id evm_lsmid = {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index afc883e60cf3..f33124ceece3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -709,14 +709,14 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 }
 
 /**
- * ima_post_path_mknod - mark as a new inode
+ * ima_path_post_mknod - mark as a new inode
  * @idmap: idmap of the mount the inode was found from
  * @dentry: newly created dentry
  *
  * Mark files created via the mknodat syscall as new, so that the
  * file data can be written later.
  */
-static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
+static void ima_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	struct ima_iint_cache *iint;
 	struct inode *inode = d_backing_inode(dentry);
@@ -1165,7 +1165,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
 	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
 	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
-	LSM_HOOK_INIT(path_post_mknod, ima_post_path_mknod),
+	LSM_HOOK_INIT(path_post_mknod, ima_path_post_mknod),
 #ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
 	LSM_HOOK_INIT(key_post_create_or_update, ima_post_key_create_or_update),
 #endif
-- 
2.34.1


