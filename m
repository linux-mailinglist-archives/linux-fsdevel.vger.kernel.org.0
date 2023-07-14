Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92A7532BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 09:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjGNHO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 03:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjGNHO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:14:27 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F3230CA
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 00:14:21 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2N562c9FzBJYck
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 15:14:18 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689318858; x=1691910859; bh=mJPR05Mlq6vXjU6nrDOaLf7AC+G
        NK0Y1HzU7kJUXxcM=; b=wCuTZ2mi/h1LcH91SShJ/XTjrx/o6sYPkFFr7ls3I1n
        X2Ga08YCzvz5HeaZDG9xANtOg3NvlELvysmzR/98KfW6teDkjrXRTiruV9S1vECA
        NyFtMN1cO898xsmOWBKv9FlfZx8wsUp9y0y0xR7ndDFN13KN/8jZv40Z5Dq8WmJ5
        WBAzIb/1vkVu42rqj57qSouC0nGBRLZULR7LG/B/NWBTDlqPV1EzAVwAGHEKxqBv
        G0dqv71Ikyshe/77bevzzElOzRJjPNTELcKyFv/kxEkPFIANGWgLJ5Hcjjnn5NCx
        JRgXfVSPjq/+9/alypuWx05J6iki3QvE0vps/K0naiA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3VZDOqymDiOY for <linux-fsdevel@vger.kernel.org>;
        Fri, 14 Jul 2023 15:14:18 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2N560RHwzBHXhl;
        Fri, 14 Jul 2023 15:14:18 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 15:14:18 +0800
From:   huzhi001@208suo.com
To:     dsterba@suse.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] VFS: Fix seven errors in bitmap.c
In-Reply-To: <tencent_CE461BFFDACFEA943A778650FB672D9E3207@qq.com>
References: <tencent_CE461BFFDACFEA943A778650FB672D9E3207@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <80ff0222e0fc0b8e25ae4837b76bce2d@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following checkpatch errors are removed:
ERROR: space required after that ',' (ctx:VxV)
ERROR: space required after that ',' (ctx:VxV)
ERROR: space required after that ',' (ctx:VxV)
ERROR: space required after that ',' (ctx:VxV)
ERROR: space required after that ',' (ctx:VxV)
ERROR: space required after that ',' (ctx:VxV)
ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  fs/affs/bitmap.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
index 5ba9ef2742f6..b1620b6ff8a9 100644
--- a/fs/affs/bitmap.c
+++ b/fs/affs/bitmap.c
@@ -87,19 +87,19 @@ affs_free_block(struct super_block *sb, u32 block)
      return;

  err_free:
-    affs_warning(sb,"affs_free_block","Trying to free block %u which is 
already free", block);
+    affs_warning(sb, "affs_free_block", "Trying to free block %u which 
is already free", block);
      mutex_unlock(&sbi->s_bmlock);
      return;

  err_bh_read:
-    affs_error(sb,"affs_free_block","Cannot read bitmap block %u", 
bm->bm_key);
+    affs_error(sb, "affs_free_block", "Cannot read bitmap block %u", 
bm->bm_key);
      sbi->s_bmap_bh = NULL;
      sbi->s_last_bmap = ~0;
      mutex_unlock(&sbi->s_bmlock);
      return;

  err_range:
-    affs_error(sb, "affs_free_block","Block %u outside partition", 
block);
+    affs_error(sb, "affs_free_block", "Block %u outside partition", 
block);
  }

  /*
@@ -232,7 +232,7 @@ affs_alloc_block(struct inode *inode, u32 goal)
      return blk;

  err_bh_read:
-    affs_error(sb,"affs_read_block","Cannot read bitmap block %u", 
bm->bm_key);
+    affs_error(sb, "affs_read_block", "Cannot read bitmap block %u", 
bm->bm_key);
      sbi->s_bmap_bh = NULL;
      sbi->s_last_bmap = ~0;
  err_full:
