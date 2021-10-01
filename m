Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48641E74D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 07:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352120AbhJAFzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 01:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbhJAFzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 01:55:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A0C06176A;
        Thu, 30 Sep 2021 22:53:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d6so13541594wrc.11;
        Thu, 30 Sep 2021 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHWDRdosYeVV9AlWtZ9lTk2isa8Lj/VSUkA/PyFSWdY=;
        b=Ia9x8fG/2Z0PEVDYo2tX8yyfXRXCyOdOduW/TPc0m7ut98Nmn6I5Gt6jnGWGX018b1
         yzqgST06k5i8hazE04cBiuDnHD3t+72Vz92eDetql3YIAyHcdnyyJ/JZG9lbaDBUDaE3
         99syO3k2F1yM5YkOKTMhsCEiO3PAch5JyLLU2e8FATUFzKa9378AJuCTBJQqZOfCkad8
         iT79mJPdq4MlEQ3kY8bzLQ2FgJVXLx+q7P2fVxVubNNMfvTMCX4ccrPkqFqkVnj5teay
         tdqQ9MHLkzUo/rwAl01Igk0sN3qgnyo+BucMOSp76vZeyY6xcuRN76Pmtoyod8k4IFGS
         K/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHWDRdosYeVV9AlWtZ9lTk2isa8Lj/VSUkA/PyFSWdY=;
        b=b8DApQmcpX4MW57uU8X7xNS92ndhQMs9oGZmV4w0IBgBh6QwCVQTqGZ4uG9Y+xPtW5
         z/qovdLgOB4tayx2Xt330PUnsdQyH8SG8Jp6uFKYsAk3RoipyJw7Avj+CKgNUtOdF0Sv
         ZgGP4qOdLWtZaibSYJG+X2PEFL0VclTWc9Eh1AS+X6AoxGVn9u86L8BzO6t2YmQ5xQAc
         tU5SS3ebqcnfF8EZaN7XAX12vI2TRg00ZSq9IG1QkjXn2s2Z6A6PLLShKYV8KApI2TdK
         fQG6CrHaytodf2tUcOwh6vpPcx0Qc0r6coBodDEbI9N7ycWAa233Ukv+48vNpTP50WiK
         cb6w==
X-Gm-Message-State: AOAM533yRs127eK+1p4PkeLsO3AWx69dkSwM0UdBTuUr6mNI+ZyoADne
        Aw0/MKO2H2ROM/3gmaG3MC41EBOIUjIS1Q==
X-Google-Smtp-Source: ABdhPJzqJ/iQ8RwGKBxtgVo6zlF8pyfGeVTpqqLzLNyXIHcHdCIzh4zjtGbq7WMLCHrScI7thCFiAQ==
X-Received: by 2002:adf:bc4f:: with SMTP id a15mr10418114wrh.105.1633067627538;
        Thu, 30 Sep 2021 22:53:47 -0700 (PDT)
Received: from localhost.localdomain ([2c0f:fc89:118:9f36:adab:d3b8:fe1b:acf9])
        by smtp.googlemail.com with ESMTPSA id n15sm4920696wrg.58.2021.09.30.22.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 22:53:47 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/affs/super.c: fix indentations and codestyle
Date:   Fri,  1 Oct 2021 07:53:12 +0200
Message-Id: <20211001055313.89513-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Errors and wornings found by checkpatch.pl

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 fs/affs/super.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index c6c2a513ec92..889565a56578 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -27,7 +27,7 @@
 
 static int affs_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int affs_show_options(struct seq_file *m, struct dentry *root);
-static int affs_remount (struct super_block *sb, int *flags, char *data);
+static int affs_remount(struct super_block *sb, int *flags, char *data);
 
 static void
 affs_commit_super(struct super_block *sb, int wait)
@@ -50,6 +50,7 @@ static void
 affs_put_super(struct super_block *sb)
 {
 	struct affs_sb_info *sbi = AFFS_SB(sb);
+
 	pr_debug("%s()\n", __func__);
 
 	cancel_delayed_work_sync(&sbi->sb_work);
@@ -83,18 +84,18 @@ void affs_mark_sb_dirty(struct super_block *sb)
 	unsigned long delay;
 
 	if (sb_rdonly(sb))
-	       return;
+		return;
 
 	spin_lock(&sbi->work_lock);
 	if (!sbi->work_queued) {
-	       delay = msecs_to_jiffies(dirty_writeback_interval * 10);
-	       queue_delayed_work(system_long_wq, &sbi->sb_work, delay);
-	       sbi->work_queued = 1;
+		delay = msecs_to_jiffies(dirty_writeback_interval * 10);
+		queue_delayed_work(system_long_wq, &sbi->sb_work, delay);
+		sbi->work_queued = 1;
 	}
 	spin_unlock(&sbi->work_lock);
 }
 
-static struct kmem_cache * affs_inode_cachep;
+static struct kmem_cache *affs_inode_cachep;
 
 static struct inode *affs_alloc_inode(struct super_block *sb)
 {
@@ -208,6 +209,7 @@ parse_options(char *options, kuid_t *uid, kgid_t *gid, int *mode, int *reserved,
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token, n, option;
+
 		if (!*p)
 			continue;
 
@@ -274,14 +276,15 @@ parse_options(char *options, kuid_t *uid, kgid_t *gid, int *mode, int *reserved,
 			break;
 		case Opt_volume: {
 			char *vol = match_strdup(&args[0]);
+
 			if (!vol)
 				return 0;
-			strlcpy(volume, vol, 32);
+			strscpy(volume, vol, 32);
 			kfree(vol);
 			break;
 		}
 		case Opt_ignore:
-		 	/* Silently ignore the quota options */
+			/* Silently ignore the quota options */
 			break;
 		default:
 			pr_warn("Unrecognized mount option \"%s\" or missing value\n",
@@ -370,19 +373,19 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 	spin_lock_init(&sbi->work_lock);
 	INIT_DELAYED_WORK(&sbi->sb_work, flush_superblock);
 
-	if (!parse_options(data,&uid,&gid,&i,&reserved,&root_block,
-				&blocksize,&sbi->s_prefix,
+	if (!parse_options(data, &uid, &gid, &i, &reserved, &root_block,
+				&blocksize, &sbi->s_prefix,
 				sbi->s_volume, &mount_flags)) {
 		pr_err("Error parsing options\n");
 		return -EINVAL;
 	}
 	/* N.B. after this point s_prefix must be released */
 
-	sbi->s_flags   = mount_flags;
-	sbi->s_mode    = i;
-	sbi->s_uid     = uid;
-	sbi->s_gid     = gid;
-	sbi->s_reserved= reserved;
+	sbi->s_flags    = mount_flags;
+	sbi->s_mode     = i;
+	sbi->s_uid      = uid;
+	sbi->s_gid      = gid;
+	sbi->s_reserved = reserved;
 
 	/* Get the size of the device in 512-byte blocks.
 	 * If we later see that the partition uses bigger
@@ -421,8 +424,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 		 * block behind the calculated one. So we check this one, too.
 		 */
 		for (num_bm = 0; num_bm < 2; num_bm++) {
-			pr_debug("Dev %s, trying root=%u, bs=%d, "
-				"size=%d, reserved=%d\n",
+			pr_debug("Dev %s, trying root=%u, bs=%d, size= %d, reserved=%d\n",
 				sb->s_id,
 				sbi->s_root_block + num_bm,
 				blocksize, size, reserved);
@@ -509,6 +511,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (affs_test_opt(mount_flags, SF_VERBOSE)) {
 		u8 len = AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0];
+
 		pr_notice("Mounting volume \"%.*s\": Type=%.3s\\%c, Blocksize=%d\n",
 			len > 31 ? 31 : len,
 			AFFS_ROOT_TAIL(sb, root_bh)->disk_name + 1,
@@ -634,6 +637,7 @@ static struct dentry *affs_mount(struct file_system_type *fs_type,
 static void affs_kill_sb(struct super_block *sb)
 {
 	struct affs_sb_info *sbi = AFFS_SB(sb);
+
 	kill_block_super(sb);
 	if (sbi) {
 		affs_free_bitmap(sb);
@@ -656,6 +660,7 @@ MODULE_ALIAS_FS("affs");
 static int __init init_affs_fs(void)
 {
 	int err = init_inodecache();
+
 	if (err)
 		goto out1;
 	err = register_filesystem(&affs_fs_type);
-- 
2.25.1

