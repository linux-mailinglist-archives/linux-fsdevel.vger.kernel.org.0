Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA93E9CBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 04:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhHLCxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 22:53:21 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35529 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233510AbhHLCxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 22:53:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UikSqoN_1628736774;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UikSqoN_1628736774)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 10:52:54 +0800
Subject: Re: [PATCH v3 0/8] fuse,virtiofs: support per-file DAX
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
Message-ID: <db04d1c4-2801-1182-f246-90692e796660@linux.alibaba.com>
Date:   Thu, 12 Aug 2021 10:52:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping? Corresponding patches for virtiofsd are also included in this
patch set.

On 8/4/21 3:06 PM, Jeffle Xu wrote:
> changes since v2:
> - modify fuse_show_options() accordingly to make it compatible with
>   new tri-state mount option (patch 2)
> - extract FUSE protocol changes into one seperate patch (patch 3)
> - FUSE server/client need to negotiate if they support per-file DAX
>   (patch 4)
> - extract DONT_CACHE logic into patch 6/7
> 
> 
> This patchset adds support of per-file DAX for virtiofs, which is
> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> 
> Any comment is welcome.
> 
> [1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
> [2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")
> 
> v2: https://www.spinics.net/lists/linux-fsdevel/msg199584.html
> v1: https://www.spinics.net/lists/linux-virtualization/msg51008.html
> 
> Jeffle Xu (8):
>   fuse: add fuse_should_enable_dax() helper
>   fuse: Make DAX mount option a tri-state
>   fuse: support per-file DAX
>   fuse: negotiate if server/client supports per-file DAX
>   fuse: enable per-file DAX
>   fuse: mark inode DONT_CACHE when per-file DAX indication changes
>   fuse: support changing per-file DAX flag inside guest
>   fuse: show '-o dax=inode' option only when FUSE server supports
> 
>  fs/fuse/dax.c             | 32 ++++++++++++++++++++++++++++++--
>  fs/fuse/file.c            |  4 ++--
>  fs/fuse/fuse_i.h          | 22 ++++++++++++++++++----
>  fs/fuse/inode.c           | 27 ++++++++++++++++++---------
>  fs/fuse/ioctl.c           | 15 +++++++++++++--
>  fs/fuse/virtio_fs.c       | 16 ++++++++++++++--
>  include/uapi/linux/fuse.h |  9 ++++++++-
>  7 files changed, 103 insertions(+), 22 deletions(-)
> 

-- 
Thanks,
Jeffle
