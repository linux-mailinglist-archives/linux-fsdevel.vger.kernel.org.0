Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDABB607CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJUQwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiJUQwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:52:39 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E328C31E;
        Fri, 21 Oct 2022 09:52:34 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BACA52201;
        Fri, 21 Oct 2022 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666370998;
        bh=ruk+lQ8qKBUjR2PcFFn3GTmQ4eFByEiHHGss+6fUTZ8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=RYcHTwaYadig9g3dq3DE/EsAuj8ufRfIUeOp9DmUzmeisYwyaDIZeYeS8cjEWXfMp
         cnwgQFaFyUo8OzUwZI5dhaUfAbzs4o3dW5pVmTZO0f1QTO5h581+Dd5sRwOpcJHbK0
         huOHLkKGmHrHW/4abEtAM6FVOaFbAnqxFFy8btzE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C17262138;
        Fri, 21 Oct 2022 16:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666371151;
        bh=ruk+lQ8qKBUjR2PcFFn3GTmQ4eFByEiHHGss+6fUTZ8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Xnxxfd7dZjye45gfV7Eow7bKYgGbxFUQimrS7c1L53CnajVIauM7nsi/yMzxiWO7Y
         6Li0EzTF7CVc/hq4AXbxV4ttSLsud9MRCydq3dFbYaCeB7xUhk9RQwYuyhvZzu8rk8
         jFsofz73zfGWwYXHKmlrGBPUl+0zg4l3OhO0G0fw=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Oct 2022 19:52:31 +0300
Message-ID: <53145791-effe-ed2a-09f0-db042a6a9f5e@paragon-software.com>
Date:   Fri, 21 Oct 2022 19:52:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 3/4] fs/ntfs3: Remove unused functions
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <9a7d08c2-e503-ac1d-1621-20369c073530@paragon-software.com>
In-Reply-To: <9a7d08c2-e503-ac1d-1621-20369c073530@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Removed attr_must_be_resident and ntfs_query_def.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 27 ---------------------------
  fs/ntfs3/fsntfs.c  | 29 -----------------------------
  fs/ntfs3/ntfs_fs.h |  2 --
  3 files changed, 58 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index b2f54fab4001..7c00656151fb 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -54,33 +54,6 @@ static inline u64 get_pre_allocated(u64 size)
  	return ret;
  }
  
-/*
- * attr_must_be_resident
- *
- * Return: True if attribute must be resident.
- */
-static inline bool attr_must_be_resident(struct ntfs_sb_info *sbi,
-					 enum ATTR_TYPE type)
-{
-	const struct ATTR_DEF_ENTRY *de;
-
-	switch (type) {
-	case ATTR_STD:
-	case ATTR_NAME:
-	case ATTR_ID:
-	case ATTR_LABEL:
-	case ATTR_VOL_INFO:
-	case ATTR_ROOT:
-	case ATTR_EA_INFO:
-		return true;
-	default:
-		de = ntfs_query_def(sbi, type);
-		if (de && (de->flags & NTFS_ATTR_MUST_BE_RESIDENT))
-			return true;
-		return false;
-	}
-}
-
  /*
   * attr_load_runs - Load all runs stored in @attr.
   */
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 29e55fddf4e0..99dc2a287eab 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -321,35 +321,6 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
  	return err;
  }
  
-/*
- * ntfs_query_def
- *
- * Return: Current ATTR_DEF_ENTRY for given attribute type.
- */
-const struct ATTR_DEF_ENTRY *ntfs_query_def(struct ntfs_sb_info *sbi,
-					    enum ATTR_TYPE type)
-{
-	int type_in = le32_to_cpu(type);
-	size_t min_idx = 0;
-	size_t max_idx = sbi->def_entries - 1;
-
-	while (min_idx <= max_idx) {
-		size_t i = min_idx + ((max_idx - min_idx) >> 1);
-		const struct ATTR_DEF_ENTRY *entry = sbi->def_table + i;
-		int diff = le32_to_cpu(entry->type) - type_in;
-
-		if (!diff)
-			return entry;
-		if (diff < 0)
-			min_idx = i + 1;
-		else if (i)
-			max_idx = i - 1;
-		else
-			return NULL;
-	}
-	return NULL;
-}
-
  /*
   * ntfs_look_for_free_space - Look for a free space in bitmap.
   */
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2f6fb6ceaeca..e9f6898ec924 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -584,8 +584,6 @@ int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
  		       bool simple);
  int ntfs_extend_init(struct ntfs_sb_info *sbi);
  int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi);
-const struct ATTR_DEF_ENTRY *ntfs_query_def(struct ntfs_sb_info *sbi,
-					    enum ATTR_TYPE Type);
  int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
  			     CLST *new_lcn, CLST *new_len,
  			     enum ALLOCATE_OPT opt);
-- 
2.37.0


