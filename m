Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F577455F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 09:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGCHZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 03:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjGCHZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:25:48 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FEAE6C;
        Mon,  3 Jul 2023 00:25:34 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1F2C31D74;
        Mon,  3 Jul 2023 07:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688368821;
        bh=idQe/8I4/xtf47MoCwShCKiDMRqvp0LjVacaYr6AkWU=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=jqwwrq8B8R664q9ffRJjmOoR2X8CkRNU4rlXglrlwAsRvgRunVJuYY9Nzd/Serb3x
         wZNXxN6TabamoZsxq4gvnA44ipNC5KLs/YzKRjXVD6bnZ+qF++zZ+TN646VFIW2Hp8
         g+7ng2XewnogU8vU+K6qNydqFDKkhcl9brgaeiik=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:25:32 +0300
Message-ID: <d402810a-3f1a-4e9c-eb05-4445d80569bc@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:25:31 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 3/8] fs/ntfs3: Minor code refactoring and formatting
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
In-Reply-To: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.138]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trim spaces and clang-format.
Add comment for mi_enum_attr.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/namei.c  | 2 +-
  fs/ntfs3/ntfs.h   | 2 +-
  fs/ntfs3/record.c | 6 ++++++
  fs/ntfs3/super.c  | 3 +--
  fs/ntfs3/xattr.c  | 3 ++-
  5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 70f8c859e0ad..dd38dbf30add 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -376,7 +376,7 @@ static int ntfs_atomic_open(struct inode *dir, 
struct dentry *dentry,

  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
      if (IS_POSIXACL(dir)) {
-        /*
+        /*
           * Load in cache current acl to avoid ni_lock(dir):
           * ntfs_create_inode -> ntfs_init_acl -> posix_acl_create ->
           * ntfs_get_acl -> ntfs_get_acl_ex -> ni_lock
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 98b76d1b09e7..86aecbb01a92 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -847,7 +847,7 @@ struct OBJECT_ID {
      // Birth Volume Id is the Object Id of the Volume on.
      // which the Object Id was allocated. It never changes.
      struct GUID BirthVolumeId; //0x10:
-
+
      // Birth Object Id is the first Object Id that was
      // ever assigned to this MFT Record. I.e. If the Object Id
      // is changed for some reason, this field will reflect the
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index c12ebffc94da..cae939cb42cf 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -189,6 +189,12 @@ int mi_read(struct mft_inode *mi, bool is_mft)
      return err;
  }

+/*
+ * mi_enum_attr - start/continue attributes enumeration in record.
+ *
+ * NOTE: mi->mrec - memory of size sbi->record_size
+ * here we sure that mi->mrec->total == sbi->record_size (see mi_read)
+ */
  struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
  {
      const struct MFT_REC *rec = mi->mrec;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 1a02072b6b0e..d24f2da36bb2 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -488,7 +488,6 @@ static ssize_t ntfs3_label_write(struct file *file, 
const char __user *buffer,
  {
      int err;
      struct super_block *sb = pde_data(file_inode(file));
-    struct ntfs_sb_info *sbi = sb->s_fs_info;
      ssize_t ret = count;
      u8 *label = kmalloc(count, GFP_NOFS);

@@ -502,7 +501,7 @@ static ssize_t ntfs3_label_write(struct file *file, 
const char __user *buffer,
      while (ret > 0 && label[ret - 1] == '\n')
          ret -= 1;

-    err = ntfs_set_label(sbi, label, ret);
+    err = ntfs_set_label(sb->s_fs_info, label, ret);

      if (err < 0) {
          ntfs_err(sb, "failed (%d) to write label", err);
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 1a518550c317..c59d6f5a725a 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -211,7 +211,8 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, 
char *buffer,
      size = le32_to_cpu(info->size);

      /* Enumerate all xattrs. */
-    for (ret = 0, off = 0; off + sizeof(struct EA_FULL) < size; off += 
ea_size) {
+    ret = 0;
+    for (off = 0; off + sizeof(struct EA_FULL) < size; off += ea_size) {
          ea = Add2Ptr(ea_all, off);
          ea_size = unpacked_ea_size(ea);

-- 
2.34.1


