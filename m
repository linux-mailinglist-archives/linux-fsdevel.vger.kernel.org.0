Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F5B415B0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 11:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbhIWJhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 05:37:22 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:48522 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240199AbhIWJhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:37:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UpK7n-z_1632389746;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UpK7n-z_1632389746)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Sep 2021 17:35:46 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [virtiofsd PATCH v5 1/2] virtiofsd: add FUSE_ATTR_DAX to fuse protocol
Date:   Thu, 23 Sep 2021 17:35:44 +0800
Message-Id: <20210923093545.81512-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923093545.81512-1-jefflexu@linux.alibaba.com>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <20210923093545.81512-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... in prep for the following support for per-file DAX feature.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/standard-headers/linux/fuse.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index 950d7edb7e..a2c73f1469 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -440,6 +440,7 @@ struct fuse_file_lock {
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
+#define FUSE_ATTR_DAX		(1 << 1)
 
 /**
  * Open flags
-- 
2.27.0

