Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14C3E9E0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 07:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhHLFqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 01:46:45 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41538 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230377AbhHLFqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:46:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UilCXZ5_1628747178;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UilCXZ5_1628747178)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 13:46:19 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH 0/2] virtiofs: miscellaneous fixes
Date:   Thu, 12 Aug 2021 13:46:16 +0800
Message-Id: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some fixes or optimization for virtiofs, which are authored by Liu Bo.

Liu Bo (2):
  virtio-fs: disable atomic_o_trunc if no_open is enabled
  virtiofs: reduce lock contention on fpq->lock

 fs/fuse/file.c      | 11 +++++++++--
 fs/fuse/virtio_fs.c |  3 ---
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.27.0

