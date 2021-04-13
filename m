Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE37035DB01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhDMJWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 05:22:52 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39401 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229641AbhDMJWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:22:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVRVokM_1618305748;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVRVokM_1618305748)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Apr 2021 17:22:31 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     vgoyal@redhat.com
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] virtiofs: remove useless function
Date:   Tue, 13 Apr 2021 17:22:23 +0800
Message-Id: <1618305743-42003-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following clang warning:

fs/fuse/virtio_fs.c:130:35: warning: unused function 'vq_to_fpq'
[-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/fuse/virtio_fs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4ee6f73..630da49 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -127,11 +127,6 @@ static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
 	return &fs->vqs[vq->index];
 }
 
-static inline struct fuse_pqueue *vq_to_fpq(struct virtqueue *vq)
-{
-	return &vq_to_fsvq(vq)->fud->pq;
-}
-
 /* Should be called with fsvq->lock held. */
 static inline void inc_in_flight_req(struct virtio_fs_vq *fsvq)
 {
-- 
1.8.3.1

