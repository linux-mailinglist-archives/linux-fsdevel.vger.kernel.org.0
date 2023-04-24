Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01FF6EC70C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 09:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDXH1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 03:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjDXH1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:27:23 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F647E53
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:27:22 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1446471cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682321241; x=1684913241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahdEQL93PRhlUbZy1YrzF2+fsjVJoQaMUbVlOD7o0GU=;
        b=OWHzNKDIh5f/Xv52he3IGOyyQUN9IGcya31DKiyDv/p7ov6b6BETUqTYjlamGM1LMA
         sEfMzsZt51e4g2a3ZenAv5vilSl9Lv1XGLb2k6gOqRGQ/oiLRGQ2pQwvF02wgdX+yJdC
         odjLtL8xXhgb253+qBCHC+Vsg4wzAzjWm1Kg3oeRgrDK+/Pmeff3yXaKYi3o/lsBUu6B
         mLqY1Sbpai89QJKjS8awYi+lwXqV15+vM+giIOiNvTTWPpBZvi+Duql8pZCrq/P1mGgv
         DPyPNwisFFFVZZFzjPCu9f5fArUVKqFtD3hT4FqoyIT4n9SGaooEUiZ7FKCJEIAk6FvP
         mxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682321241; x=1684913241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahdEQL93PRhlUbZy1YrzF2+fsjVJoQaMUbVlOD7o0GU=;
        b=aq0SSakaxQZpSk+9eJq4pXGVhgirkmZfj+/3Yhn1kbTjgZ5eFS5mmhUo2fZ0VXuD3U
         0KKom8prfwX71/Tnk0ashLNHHhdxJ4CozUlAstuSBCmVcUsiLmk6EIVUqJIfEyd4nTT1
         +rhlibGoALd6nUZ+BN19bb1iQ0+qvQhxUDZSRs/yCfy8utF+RzzVJuKeg634d48d2xtt
         1sSf5ch3q/iDofbM4kiSKxYOrAk5R6T5IM/VgL8s06BoDIWgWaSuGKqeglrv6KfzxPM9
         JdBSBQgMBpWK5lNOjmqpFtAcHgb1wBWetSFp0qXHVjrtAUBlusKSPtdUb8x99TxMpeao
         FdiQ==
X-Gm-Message-State: AAQBX9cnKnizHuhAe6lvf7DFr67mpeEXoka2boRfBzHKpjjzu5wzwbTp
        TASwuooWTnBSZMQageq9LaBj1UU90dV1EbRBgyTASw==
X-Google-Smtp-Source: AKy350bWGGOREUaO51p6fbDBec9ga2qR/WR5xh9DJosJU0CekJPlwOYwih39WFr3VRQDASYoi0jizEqSf1Higgp57GU=
X-Received: by 2002:ac8:5c0c:0:b0:3ef:19fe:230d with SMTP id
 i12-20020ac85c0c000000b003ef19fe230dmr423101qti.17.1682321241170; Mon, 24 Apr
 2023 00:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d3b33905fa0fd4a6@google.com>
In-Reply-To: <000000000000d3b33905fa0fd4a6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 09:27:00 +0200
Message-ID: <CACT4Y+a20C5kUHRKbFB08QsLbdia+ELCOcKibJVY_v+xmjMPow@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] KCSAN: data-race in __es_find_extent_range /
 __es_find_extent_range (6)
To:     syzbot <syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Apr 2023 at 09:19, syzbot
<syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    44149752e998 Merge tag 'cgroup-for-6.3-rc6-fixes' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=100db37bc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=710057cbb8def08c
> dashboard link: https://syzkaller.appspot.com/bug?extid=4a03518df1e31b537066
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7bfa303f05cc/disk-44149752.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4e8ea8730409/vmlinux-44149752.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e584bce13ba7/bzImage-44149752.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com

The race is here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/extents_status.c?id=44149752e9987a9eac5ad78e6d3a20934b5e018d#n271

If I am reading this correctly, it can lead to returning a wrong
extent if tree->cache_es is re-read after the range check.
I think tree->cache_es read/write should use READ/WRITE_ONCE.

> ==================================================================
> BUG: KCSAN: data-race in __es_find_extent_range / __es_find_extent_range
>
> write to 0xffff88810a5a98a8 of 8 bytes by task 10666 on cpu 0:
>  __es_find_extent_range+0x212/0x300 fs/ext4/extents_status.c:296
>  ext4_es_find_extent_range+0x91/0x260 fs/ext4/extents_status.c:318
>  ext4_ext_put_gap_in_cache fs/ext4/extents.c:2284 [inline]
>  ext4_ext_map_blocks+0x120d/0x36c0 fs/ext4/extents.c:4191
>  ext4_map_blocks+0x2a0/0x1050 fs/ext4/inode.c:576
>  ext4_mpage_readpages+0x699/0x1440 fs/ext4/readpage.c:300
>  ext4_read_folio+0xc5/0x1a0 fs/ext4/inode.c:3308
>  filemap_read_folio+0x2c/0x100 mm/filemap.c:2424
>  filemap_fault+0x66f/0xb20 mm/filemap.c:3367
>  __do_fault mm/memory.c:4155 [inline]
>  do_read_fault mm/memory.c:4506 [inline]
>  do_fault mm/memory.c:4635 [inline]
>  handle_pte_fault mm/memory.c:4923 [inline]
>  __handle_mm_fault mm/memory.c:5065 [inline]
>  handle_mm_fault+0x115d/0x21d0 mm/memory.c:5211
>  faultin_page mm/gup.c:925 [inline]
>  __get_user_pages+0x363/0xc30 mm/gup.c:1147
>  populate_vma_page_range mm/gup.c:1543 [inline]
>  __mm_populate+0x23a/0x360 mm/gup.c:1652
>  mm_populate include/linux/mm.h:3026 [inline]
>  vm_mmap_pgoff+0x174/0x210 mm/util.c:547
>  ksys_mmap_pgoff+0x2ac/0x320 mm/mmap.c:1410
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff88810a5a98a8 of 8 bytes by task 10630 on cpu 1:
>  __es_find_extent_range+0x79/0x300 fs/ext4/extents_status.c:270
>  __es_scan_range fs/ext4/extents_status.c:345 [inline]
>  __es_scan_clu fs/ext4/extents_status.c:399 [inline]
>  ext4_es_scan_clu+0xe4/0x190 fs/ext4/extents_status.c:415
>  ext4_insert_delayed_block fs/ext4/inode.c:1694 [inline]
>  ext4_da_map_blocks fs/ext4/inode.c:1806 [inline]
>  ext4_da_get_block_prep+0x575/0xa70 fs/ext4/inode.c:1870
>  __block_write_begin_int+0x349/0xe50 fs/buffer.c:2034
>  __block_write_begin+0x5e/0x110 fs/buffer.c:2084
>  ext4_da_write_begin+0x2fa/0x610 fs/ext4/inode.c:3084
>  generic_perform_write+0x1c3/0x3d0 mm/filemap.c:3926
>  ext4_buffered_write_iter+0x234/0x3e0 fs/ext4/file.c:289
>  ext4_file_write_iter+0xd7/0x10e0
>  call_write_iter include/linux/fs.h:1851 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x463/0x760 fs/read_write.c:584
>  ksys_write+0xeb/0x1a0 fs/read_write.c:637
>  __do_sys_write fs/read_write.c:649 [inline]
>  __se_sys_write fs/read_write.c:646 [inline]
>  __x64_sys_write+0x42/0x50 fs/read_write.c:646
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0xffff88810a653dc0 -> 0xffff8881067334d8
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 10630 Comm: syz-executor.0 Not tainted 6.3.0-rc6-syzkaller-00138-g44149752e998 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
