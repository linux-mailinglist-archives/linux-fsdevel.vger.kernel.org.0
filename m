Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E986E5B7CB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 23:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIMV2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 17:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIMV2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:28:02 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7165578;
        Tue, 13 Sep 2022 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wscn5dkggvZiZ0wJ3zxOaRBw0qG01+CWesayzXtuhxc=; b=uiiEEkRan/uKyzQz8RRjZ6qsTd
        Skdm5pIGzk82MJ7HYjaNnsLEnY6Clx6DqMnArzsqYvBMHjkucg5HPDfhf/aQchMAAZ0RX1w1Yl36H
        k/peloic/wBt6QsuQa6xB39x2rGetD4azkJJEfGtX+QCd7DI4gPbvX02a3jliBrYDKpmvipcIy/47
        jAIkserencOEgqU8Srlsiqy/SO8hjfvOUh5T5E19tXhjpgNUnGQjw0yD63B4+xTH/XqMm8/VIAN7v
        kO7ugREAhPhUfFs74cx2fwDz7V9C/kVSTRtcsJzHcANGI1EAOQFGncXhB0CVqywMneSXAZzXp4cqq
        xP+B7rRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oYDRm-00Fy5C-2O;
        Tue, 13 Sep 2022 21:27:58 +0000
Date:   Tue, 13 Sep 2022 22:27:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+29dc75ed37be943c610e@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference
 in __d_instantiate
Message-ID: <YyD13iRuhPDJypz8@ZenIV>
References: <0000000000005c2d1f05e8945724@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005c2d1f05e8945724@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:51:42PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=16271d4f080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e79d82586727c5df
> dashboard link: https://syzkaller.appspot.com/bug?extid=29dc75ed37be943c610e
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162474a7080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119b6b78880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/1436897f0dc0/disk-a6b44374.raw.xz
> vmlinux: https://storage.googleapis.com/68c4de151fbb/vmlinux-a6b44374.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+29dc75ed37be943c610e@syzkaller.appspotmail.com
> 
> ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
> ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
> ntfs3: loop0: Failed to load $Extend.
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008

> Call trace:
>  d_flags_for_inode fs/dcache.c:1980 [inline]
>  __d_instantiate+0x2a0/0x2e4 fs/dcache.c:1998
>  d_instantiate fs/dcache.c:2036 [inline]
>  d_make_root+0x64/0xa8 fs/dcache.c:2071
>  ntfs_fill_super+0x1420/0x14a4 fs/ntfs/super.c:180
>  get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
>  ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
>  vfs_get_tree+0x40/0x140 fs/super.c:1530
>  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>  path_mount+0x358/0x914 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
>  el0t_64_sync+0x18c/0x190
> Code: 79000688 52a00417 17ffff83 f9401288 (f9400508) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	79000688 	strh	w8, [x20, #2]
>    4:	52a00417 	mov	w23, #0x200000              	// #2097152
>    8:	17ffff83 	b	0xfffffffffffffe14
>    c:	f9401288 	ldr	x8, [x20, #32]
> * 10:	f9400508 	ldr	x8, [x8, #8] <-- trapping instruction

at a guess - bollocksed inode; NULL ->i_op (should never happen; it takes actively
assigning NULL to it, but apparently ntfs_read_mft() is that dumb), combined with
candidate root inode somehow having S_IFLNK in ->i_mode.

At the very least,
        inode->i_op = NULL;
should *NEVER* be done; there is no legitimate reason to do that, no matter
what.  ->i_op initially points to empty method table; it should never
point to anything that is not an object of type struct inode_operations.
In particular, it should never become NULL.
