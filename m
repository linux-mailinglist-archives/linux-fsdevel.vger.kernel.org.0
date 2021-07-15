Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCC83C9BD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhGOJd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 05:33:26 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60680 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231395AbhGOJdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:33:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UfrwCzP_1626341431;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UfrwCzP_1626341431)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Jul 2021 17:30:31 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bo.liu@linux.alibaba.com
Subject: [RFC PATCH 0/3] virtiofs,fuse: support per-file DAX
Date:   Thu, 15 Jul 2021 17:30:28 +0800
Message-Id: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds support of per-file DAX for virtiofs, which is
inspired by Ira Weiny's work on ext4[1] and xfs[2].

Currently virtiofs (in guest kernel) accepts per-file DAX flag from FUSE
server (in host). 

Currently it is not implemented yet to change per-file DAX flag inside
guest kernel, e.g., by chattr(1).

Any comment is welcome. :)


[1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
[2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")

Jeffle Xu (3):
  fuse: add fuse_should_enable_dax() helper
  fuse: Make DAX mount option a tri-state
  fuse: add per-file DAX flag

 fs/fuse/dax.c             | 43 +++++++++++++++++++++++++++++++++++++--
 fs/fuse/file.c            |  4 ++--
 fs/fuse/fuse_i.h          | 16 +++++++++++----
 fs/fuse/inode.c           |  6 ++++--
 fs/fuse/virtio_fs.c       | 16 +++++++++++++--
 include/uapi/linux/fuse.h |  5 +++++
 6 files changed, 78 insertions(+), 12 deletions(-)

-- 
2.27.0

