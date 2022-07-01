Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CEC56341F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiGANKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiGANKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:10:37 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5BF4D15E;
        Fri,  1 Jul 2022 06:10:22 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A853121B4;
        Fri,  1 Jul 2022 13:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656680963;
        bh=QymskdUxmtYvCWPe6xq2ac+1PvUu1V55rQESiccO/D8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ZqFjY48F0MKslwfHNRSope6R4mH8AQ9wXw1K3hddiBLEvDTcsLC0RF2Guktvv6w6j
         oN02yrHz4BXUjS0N4eli1PPYjfpJIZel/lJ7vFJ8rs7gfMgXFHNUpaHp7/7C6M0aTj
         bAPWblzAehTkCBadJ3a0dPTUmtjuHS70QVieUSbY=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 019CD21B8;
        Fri,  1 Jul 2022 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656681021;
        bh=QymskdUxmtYvCWPe6xq2ac+1PvUu1V55rQESiccO/D8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=VO/A+6+0knqMEHIFux3x00SfQeDIfyS8CVbh5RfEV4JESkarCxqILEuZa8bQ80qj0
         Knq5WtI4rVEfsuqAvTrYXaO2Lml4FBG/87sm8YMRo+0focoXjW7Gy48urxLC2Q2K0n
         rx4HGGbM0Ok84fMhQG28ezq4d+3/HJXgZvZapAW0=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Jul 2022 16:10:20 +0300
Message-ID: <d4cee490-2121-28c2-3166-af7824a27529@paragon-software.com>
Date:   Fri, 1 Jul 2022 16:10:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH 2/5] fs/ntfs3: Remove unused mi_mark_free
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
In-Reply-To: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
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

Cleaning up dead code
Fix wrong comments

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/namei.c   |  2 +-
  fs/ntfs3/ntfs_fs.h |  1 -
  fs/ntfs3/record.c  | 22 ----------------------
  fs/ntfs3/super.c   |  2 +-
  4 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index bc741213ad84..1cc700760c7e 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -208,7 +208,7 @@ static int ntfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
  }
  
  /*
- * ntfs_rmdir - inode_operations::rm_dir
+ * ntfs_rmdir - inode_operations::rmdir
   */
  static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
  {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2bc6563601d7..ebe4a8ecc20d 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -734,7 +734,6 @@ static inline struct ATTRIB *rec_find_attr_le(struct mft_inode *rec,
  int mi_write(struct mft_inode *mi, int wait);
  int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
  		  __le16 flags, bool is_mft);
-void mi_mark_free(struct mft_inode *mi);
  struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
  			      const __le16 *name, u8 name_len, u32 asize,
  			      u16 name_off);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 8fe0a876400a..7d2fac5ee215 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -394,28 +394,6 @@ int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
  	return err;
  }
  
-/*
- * mi_mark_free - Mark record as unused and marks it as free in bitmap.
- */
-void mi_mark_free(struct mft_inode *mi)
-{
-	CLST rno = mi->rno;
-	struct ntfs_sb_info *sbi = mi->sbi;
-
-	if (rno >= MFT_REC_RESERVED && rno < MFT_REC_FREE) {
-		ntfs_clear_mft_tail(sbi, rno, rno + 1);
-		mi->dirty = false;
-		return;
-	}
-
-	if (mi->mrec) {
-		clear_rec_inuse(mi->mrec);
-		mi->dirty = true;
-		mi_write(mi, 0);
-	}
-	ntfs_mark_rec_free(sbi, rno);
-}
-
  /*
   * mi_insert_attr - Reserve space for new attribute.
   *
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 4b0dad2ac598..eacea72ff92f 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1377,7 +1377,7 @@ static const struct fs_context_operations ntfs_context_ops = {
  /*
   * ntfs_init_fs_context - Initialize spi and opts
   *
- * This will called when mount/remount. We will first initiliaze
+ * This will called when mount/remount. We will first initialize
   * options so that if remount we can use just that.
   */
  static int ntfs_init_fs_context(struct fs_context *fc)
-- 
2.37.0


