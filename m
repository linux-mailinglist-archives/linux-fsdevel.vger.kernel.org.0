Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D277D46FBB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhLJHkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:21 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39006 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237729AbhLJHkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8ADEW_1639121794;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8ADEW_1639121794)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:34 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 12/19] erofs: export erofs_map_blocks
Date:   Fri, 10 Dec 2021 15:36:12 +0800
Message-Id: <20211210073619.21667-13-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 4 ++--
 fs/erofs/internal.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0e35ef3f9f3d..477aaff0c832 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -77,8 +77,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return err;
 }
 
-static int erofs_map_blocks(struct inode *inode,
-			    struct erofs_map_blocks *map, int flags)
+int erofs_map_blocks(struct inode *inode,
+		     struct erofs_map_blocks *map, int flags)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_inode *vi = EROFS_I(inode);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3265688af7f9..45fb6f5d11b5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -447,6 +447,8 @@ struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
+int erofs_map_blocks(struct inode *inode,
+		     struct erofs_map_blocks *map, int flags);
 
 /* inode.c */
 static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
-- 
2.27.0

