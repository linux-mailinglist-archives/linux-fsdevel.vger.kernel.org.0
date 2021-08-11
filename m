Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52783E8AA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhHKG4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 02:56:48 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47752 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235053AbhHKG4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 02:56:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UifBT9v_1628664982;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UifBT9v_1628664982)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Aug 2021 14:56:22 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [virtiofsd PATCH v2 2/4] virtiofsd: expand fuse protocol to support per-file DAX
Date:   Wed, 11 Aug 2021 14:56:19 +0800
Message-Id: <20210811065621.12737-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210811065621.12737-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
 <20210811065621.12737-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/standard-headers/linux/fuse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index 950d7edb7e..7bd006ffcb 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -356,6 +356,7 @@ struct fuse_file_lock {
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
+#define FUSE_PERFILE_DAX	(1 << 30)
 
 /**
  * CUSE INIT request/reply flags
@@ -440,6 +441,7 @@ struct fuse_file_lock {
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
+#define FUSE_ATTR_DAX		(1 << 1)
 
 /**
  * Open flags
-- 
2.27.0

