Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23B76FB04E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjEHMki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbjEHMkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:40:31 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3237617;
        Mon,  8 May 2023 05:40:08 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B0B3F21C4;
        Mon,  8 May 2023 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549319;
        bh=RFF6P7EkHf1hkymDTWXlt6hRdRdlKehS3PqSyelc73s=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=fUcsF5piYtEjDGuyLyMFDW/QqOGqHhyeGHsh/0+9PX5wKbUqoxcTrNs4k5Ji/KYoP
         iCdSbVJWgklXm7MY7EhQoCLd0Xsowoa3zuJf9688DK0n8nQasEa6C3AtNt7+zTadAn
         J/J21amew2bNGjOwBlYHCx8YMloXkZ3ek9s7BpzE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5C46F2191;
        Mon,  8 May 2023 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549606;
        bh=RFF6P7EkHf1hkymDTWXlt6hRdRdlKehS3PqSyelc73s=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=uZVKbqli9+/XIjR++PSHIkbD1cAzkkdEVeAvvsj604rYOK9vnNGqCbgVQ+yTuwiEh
         bsOeSb7M83X+Yu6i8BvLGDuNeIf2cW3jr8wtyEi/jc2ZK73BIgHXfSWVqaDKn9H1Ui
         H6okkeg7NHGXAVuPRd5QlxxD/+sIzGXZNjkNpDyg=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:40:05 +0300
Message-ID: <6de6e6ca-f5fb-42b1-9447-591f5c81a356@paragon-software.com>
Date:   Mon, 8 May 2023 16:40:05 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 10/10] fs/ntfs3: Add support /proc/fs/ntfs3/<dev>/volinfo and
 /proc/fs/ntfs3/<dev>/label
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
In-Reply-To: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Metafile /proc/fs/ntfs3/<dev>/label allows to read/write current ntfs label.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c  |  58 ++++++++++++++++++++
  fs/ntfs3/ntfs_fs.h |   5 +-
  fs/ntfs3/super.c   | 134 +++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 1c05c088d1c6..33afee0f5559 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -9,6 +9,7 @@
  #include <linux/buffer_head.h>
  #include <linux/fs.h>
  #include <linux/kernel.h>
+#include <linux/nls.h>

  #include "debug.h"
  #include "ntfs.h"
@@ -2619,3 +2620,60 @@ bool valid_windows_name(struct ntfs_sb_info *sbi, 
const struct le_str *fname)
      return !name_has_forbidden_chars(fname) &&
             !is_reserved_name(sbi, fname);
  }
+
+/*
+ * ntfs_set_label - updates current ntfs label.
+ */
+int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
+{
+    int err;
+    struct ATTRIB *attr;
+    struct ntfs_inode *ni = sbi->volume.ni;
+    const u8 max_ulen = 0x80; /* TODO: use attrdef to get maximum length */
+    /* Allocate PATH_MAX bytes. */
+    struct cpu_str *uni = __getname();
+
+    if (!uni)
+        return -ENOMEM;
+
+    err = ntfs_nls_to_utf16(sbi, label, len, uni, (PATH_MAX - 2) / 2,
+                UTF16_LITTLE_ENDIAN);
+    if (err < 0)
+        goto out;
+
+    if (uni->len > max_ulen) {
+        ntfs_warn(sbi->sb, "new label is too long");
+        err = -EFBIG;
+        goto out;
+    }
+
+    ni_lock(ni);
+
+    /* Ignore any errors. */
+    ni_remove_attr(ni, ATTR_LABEL, NULL, 0, false, NULL);
+
+    err = ni_insert_resident(ni, uni->len * sizeof(u16), ATTR_LABEL, NULL,
+                 0, &attr, NULL, NULL);
+    if (err < 0)
+        goto unlock_out;
+
+    /* write new label in on-disk struct. */
+    memcpy(resident_data(attr), uni->name, uni->len * sizeof(u16));
+
+    /* update cached value of current label. */
+    if (len >= ARRAY_SIZE(sbi->volume.label))
+        len = ARRAY_SIZE(sbi->volume.label) - 1;
+    memcpy(sbi->volume.label, label, len);
+    sbi->volume.label[len] = 0;
+    mark_inode_dirty_sync(&ni->vfs_inode);
+
+unlock_out:
+    ni_unlock(ni);
+
+    if (!err)
+        err = _ni_write_inode(&ni->vfs_inode, 0);
+
+out:
+    __putname(uni);
+    return err;
+}
\ No newline at end of file
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 00fa782fcada..629403ede6e5 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -276,7 +276,7 @@ struct ntfs_sb_info {
          __le16 flags; // Cached current VOLUME_INFO::flags, 
VOLUME_FLAG_DIRTY.
          u8 major_ver;
          u8 minor_ver;
-        char label[65];
+        char label[256];
          bool real_dirty; // Real fs state.
      } volume;

@@ -286,7 +286,6 @@ struct ntfs_sb_info {
          struct ntfs_inode *ni;
          u32 next_id;
          u64 next_off;
-
          __le32 def_security_id;
      } security;

@@ -314,6 +313,7 @@ struct ntfs_sb_info {

      struct ntfs_mount_options *options;
      struct ratelimit_state msg_ratelimit;
+    struct proc_dir_entry *procdir;
  };

  /* One MFT record(usually 1024 bytes), consists of attributes. */
@@ -651,6 +651,7 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST 
lcn, CLST len, bool trim);
  int run_deallocate(struct ntfs_sb_info *sbi, const struct runs_tree *run,
             bool trim);
  bool valid_windows_name(struct ntfs_sb_info *sbi, const struct le_str 
*name);
+int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len);

  /* Globals from index.c */
  int indx_used_bit(struct ntfs_index *indx, struct ntfs_inode *ni, 
size_t *bit);
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 7ab0a79c7d84..e36769eac7de 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -57,6 +57,7 @@
  #include <linux/minmax.h>
  #include <linux/module.h>
  #include <linux/nls.h>
+#include <linux/proc_fs.h>
  #include <linux/seq_file.h>
  #include <linux/statfs.h>

@@ -441,6 +442,103 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
      return 0;
  }

+#ifdef CONFIG_PROC_FS
+static struct proc_dir_entry *proc_info_root;
+
+/*
+ * ntfs3_volinfo:
+ *
+ * The content of /proc/fs/ntfs3/<dev>/volinfo
+ *
+ * ntfs3.1
+ * cluster size
+ * number of clusters
+*/
+static int ntfs3_volinfo(struct seq_file *m, void *o)
+{
+    struct super_block *sb = m->private;
+    struct ntfs_sb_info *sbi = sb->s_fs_info;
+
+    seq_printf(m, "ntfs%d.%d\n%u\n%zu\n", sbi->volume.major_ver,
+           sbi->volume.minor_ver, sbi->cluster_size,
+           sbi->used.bitmap.nbits);
+
+    return 0;
+}
+
+static int ntfs3_volinfo_open(struct inode *inode, struct file *file)
+{
+    return single_open(file, ntfs3_volinfo, pde_data(inode));
+}
+
+/* read /proc/fs/ntfs3/<dev>/label */
+static int ntfs3_label_show(struct seq_file *m, void *o)
+{
+    struct super_block *sb = m->private;
+    struct ntfs_sb_info *sbi = sb->s_fs_info;
+
+    seq_printf(m, "%s\n", sbi->volume.label);
+
+    return 0;
+}
+
+/* write /proc/fs/ntfs3/<dev>/label */
+static ssize_t ntfs3_label_write(struct file *file, const char __user 
*buffer,
+                 size_t count, loff_t *ppos)
+{
+    int err;
+    struct super_block *sb = pde_data(file_inode(file));
+    struct ntfs_sb_info *sbi = sb->s_fs_info;
+    ssize_t ret = count;
+    u8 *label = kmalloc(count, GFP_NOFS);
+
+    if (!label)
+        return -ENOMEM;
+
+    if (copy_from_user(label, buffer, ret)) {
+        ret = -EFAULT;
+        goto out;
+    }
+    while (ret > 0 && label[ret - 1] == '\n')
+        ret -= 1;
+
+    err = ntfs_set_label(sbi, label, ret);
+
+    if (err < 0) {
+        ntfs_err(sb, "failed (%d) to write label", err);
+        ret = err;
+        goto out;
+    }
+
+    *ppos += count;
+    ret = count;
+out:
+    kfree(label);
+    return ret;
+}
+
+static int ntfs3_label_open(struct inode *inode, struct file *file)
+{
+    return single_open(file, ntfs3_label_show, pde_data(inode));
+}
+
+static const struct proc_ops ntfs3_volinfo_fops = {
+    .proc_read = seq_read,
+    .proc_lseek = seq_lseek,
+    .proc_release = single_release,
+    .proc_open = ntfs3_volinfo_open,
+};
+
+static const struct proc_ops ntfs3_label_fops = {
+    .proc_read = seq_read,
+    .proc_lseek = seq_lseek,
+    .proc_release = single_release,
+    .proc_open = ntfs3_label_open,
+    .proc_write = ntfs3_label_write,
+};
+
+#endif
+
  static struct kmem_cache *ntfs_inode_cachep;

  static struct inode *ntfs_alloc_inode(struct super_block *sb)
@@ -515,6 +613,16 @@ static void ntfs_put_super(struct super_block *sb)
  {
      struct ntfs_sb_info *sbi = sb->s_fs_info;

+#ifdef CONFIG_PROC_FS
+    // Remove /proc/fs/ntfs3/..
+    if (sbi->procdir) {
+        remove_proc_entry("label", sbi->procdir);
+        remove_proc_entry("volinfo", sbi->procdir);
+        remove_proc_entry(sb->s_id, proc_info_root);
+        sbi->procdir = NULL;
+    }
+#endif
+
      /* Mark rw ntfs as clear, if possible. */
      ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);

@@ -1436,6 +1544,20 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
          kfree(boot2);
      }

+#ifdef CONFIG_PROC_FS
+    /* Create /proc/fs/ntfs3/.. */
+    if (proc_info_root) {
+        struct proc_dir_entry *e = proc_mkdir(sb->s_id, proc_info_root);
+        if (e) {
+            proc_create_data("volinfo", S_IFREG | S_IRUGO, e,
+                     &ntfs3_volinfo_fops, sb);
+            proc_create_data("label", S_IFREG | S_IRUGO | S_IWUGO,
+                     e, &ntfs3_label_fops, sb);
+            sbi->procdir = e;
+        }
+    }
+#endif
+
      return 0;

  put_inode_out:
@@ -1630,6 +1752,12 @@ static int __init init_ntfs_fs(void)
      if (IS_ENABLED(CONFIG_NTFS3_LZX_XPRESS))
          pr_info("ntfs3: Read-only LZX/Xpress compression included\n");

+
+#ifdef CONFIG_PROC_FS
+    /* Create "/proc/fs/ntfs3" */
+    proc_info_root = proc_mkdir("fs/ntfs3", NULL);
+#endif
+
      err = ntfs3_init_bitmap();
      if (err)
          return err;
@@ -1661,6 +1789,12 @@ static void __exit exit_ntfs_fs(void)
      kmem_cache_destroy(ntfs_inode_cachep);
      unregister_filesystem(&ntfs_fs_type);
      ntfs3_exit_bitmap();
+
+#ifdef CONFIG_PROC_FS
+    if (proc_info_root)
+        remove_proc_entry("fs/ntfs3", NULL);
+#endif
+
  }

  MODULE_LICENSE("GPL");
-- 
2.34.1

