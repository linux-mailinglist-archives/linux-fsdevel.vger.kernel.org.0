Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE122389
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfERNTA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 09:19:00 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:33162 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727380AbfERNTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 09:19:00 -0400
Received: from [173.71.191.49] (helo=[192.168.0.98])
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1hRzEp-0001D0-3y; Sat, 18 May 2019 09:18:59 -0400
Date:   Sat, 18 May 2019 09:18:57 -0400
In-Reply-To: <20190518122241.D867120B7C@mail.kernel.org>
References: <0e850c6e59c0b147dc2dcd51a3af004c948c3697.1558117389.git.jaharkes@cs.cmu.edu> <20190518122241.D867120B7C@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Autocrypt: addr=jaharkes@cs.cmu.edu; keydata=
 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
Subject: Re: [PATCH 01/22] coda: pass the host file in vma->vm_file on mmap
To:     Sasha Levin <sashal@kernel.org>
CC:     linux-fsdevel@vger.kernel.org
From:   Jan Harkes <jaharkes@cs.cmu.edu>
Message-ID: <A67240F2-2712-460E-A17F-EB8D24AD76DE@cs.cmu.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

That is actually great, 4 out of 7 patched without any issues, I love this bot.

The remaining 3 probably are all failing because of the missing call_mmap helper.

f74ac01520c9 ("mm: use helper for calling f_op->mmap()")

I can make a separate patch that doesn't use the helper. I will also check if this change is necessary for the older kernels, although right now I assume it probably is.

Jan

On May 18, 2019 8:22:41 AM EDT, Sasha Levin <sashal@kernel.org> wrote:
>Hi,
>
>[This is an automated email]
>
>This commit has been processed because it contains a -stable tag.
>The stable tag indicates that it's relevant for the following trees:
>all
>
>The bot has tested the following trees: v5.1.3, v5.0.17, v4.19.44,
>v4.14.120, v4.9.177, v4.4.180, v3.18.140.
>
>v5.1.3: Build OK!
>v5.0.17: Build OK!
>v4.19.44: Build OK!
>v4.14.120: Build OK!
>v4.9.177: Failed to apply! Possible dependencies:
>0f78d06ac1e9 ("vfs: pass type instead of fn to
>do_{loop,iter}_readv_writev()")
>7687a7a4435f ("vfs: extract common parts of
>{compat_,}do_readv_writev()")
>bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()")
>    f74ac01520c9 ("mm: use helper for calling f_op->mmap()")
>
>v4.4.180: Failed to apply! Possible dependencies:
>0b944d3a4bba ("aio: hold an extra file reference over AIO read/write
>operations")
>    1bd816f12071 ("drm/vgem: Use lockless gem BO free callback")
>    2710fd7e00b4 ("f2fs: introduce dirty list node in inode info")
>2dbf0d90971a ("drm/i915: Use CPU mapping for userspace dma-buf mmap()")
>    4cf185379b75 ("f2fs: add a tracepoint for sync_dirty_inodes")
>    6ad7609a183a ("f2fs: introduce __remove_dirty_inode")
>    6d5a1495eebd ("f2fs: let user being aware of IO error")
>    70fe2f48152e ("aio: fix freeze protection of aio writes")
>    89319d31d2d0 ("fs: remove aio_run_iocb")
>b439b103a6c9 ("f2fs: move dio preallocation into f2fs_file_write_iter")
>bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()")
>    c227f912732f ("f2fs: record dirty status of regular/symlink inode")
>    d323d005ac4a ("f2fs: support file defragment")
>    dde0c2e79848 ("fs: add IOCB_SYNC and IOCB_DSYNC")
>    e6f15b763ab2 ("drm/vgem: Enable dmabuf interface for export")
>   eb7e813cc791 ("f2fs: fix to remove directory inode from dirty list")
>    f74ac01520c9 ("mm: use helper for calling f_op->mmap()")
>
>v3.18.140: Failed to apply! Possible dependencies:
>    1bd816f12071 ("drm/vgem: Use lockless gem BO free callback")
>2dbf0d90971a ("drm/i915: Use CPU mapping for userspace dma-buf mmap()")
>    301120134628 ("block: loop: say goodby to bio")
>    502e95c66785 ("drm/vgem: implement virtual GEM")
>    990ed2720717 ("drm/vgem: drop DRIVER_PRIME (v2)")
>    af65aa8ea78b ("block: loop: don't handle REQ_FUA explicitly")
>    b5dd2f6047ca ("block: loop: improve performance via blk-mq")
>bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()")
>    bc07c10a3603 ("block: loop: support DIO & AIO")
>cf655d953422 ("block: loop: introduce lo_discard() and lo_req_flush()")
>    e6f15b763ab2 ("drm/vgem: Enable dmabuf interface for export")
>    f74ac01520c9 ("mm: use helper for calling f_op->mmap()")
>
>
>How should we proceed with this patch?
>
>--
>Thanks,
>Sasha
