Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA56A77ED65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 00:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347034AbjHPWtL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 18:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347028AbjHPWsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:48:52 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14D2110
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 15:48:49 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-68876bbed07so2782015b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 15:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692226129; x=1692830929;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzwLqv7bpZfAyR4e420CE/PzPemUg67hgqEHw1UBtUk=;
        b=j33BPR0jYp9RXvRdeiCLm1KUKzZ1QM/8Xf255BImHz/bYKct3BicDpzr/36s/qHwED
         8d0yM7ICIyLYXO3wyin3AwGfLNsQ2v5YMoW+B0BbH5iVguIN2rdnQrdXrvoHOawvCCkk
         WJolk6AmR4hbTWpIxKFbdCfXrRlwQ+ZjjmekX6q3ydtHlhkCYVrXpsCge5dOKPS3oNjy
         9AcJfAIzfV6o+2YHXkCfWy5Pg9Yh9OiRyWhvQWwLOuP31REIDJQRVy/5cL/g8gIy86yL
         HRay9h7dUk4m0T6Szu9LxTw+NeLIydrTRmYc+KXbus3v5OGBPVMpuzVEi3itekt2ymVP
         brCQ==
X-Gm-Message-State: AOJu0YwvUM+2e1iY6fs0MVW46aMO4d/y7i/SvaMIG5aH0GpA09s7tAOI
        v15sZsglz1VonGX3/Otb+KZDGs7VTZ3y17OG7daUVQFBtkoj
X-Google-Smtp-Source: AGHT+IEM5vv31TNAebpUiR/YN2gpOjhloP5qqKkJbGjKKOYYmnqiKn2w2j/7j/lEokgs3OVKVRbD1UgxlbwBBBXGl87AP/PWAadM
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1a16:b0:668:7143:50ea with SMTP id
 g22-20020a056a001a1600b00668714350eamr1450790pfv.4.1692226129430; Wed, 16 Aug
 2023 15:48:49 -0700 (PDT)
Date:   Wed, 16 Aug 2023 15:48:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000530e0d060312199e@google.com>
Subject: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic forced
 after error (3)
From:   syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ae545c3283dc Merge tag 'gpio-fixes-for-v6.5-rc6' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e5d553a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
dashboard link: https://syzkaller.appspot.com/bug?extid=27eece6916b914a49ce7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13433207a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109cd837a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b9bad020898/disk-ae545c32.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4073566d0a4b/vmlinux-ae545c32.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b163e2a2c47c/bzImage-ae545c32.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/004395fabe81/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12890d53a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11890d53a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16890d53a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
ext2: Unknown parameter '����'
EXT4-fs (loop0): feature flags set on rev 0 fs, running e2fsck is recommended
EXT4-fs (loop0): warning: checktime reached, running e2fsck is recommended
EXT4-fs warning (device loop0): ext4_update_dynamic_rev:1084: updating to rev 1 because of new feature flag, running e2fsck is recommended
EXT4-fs error (device loop0): ext4_validate_block_bitmap:430: comm syz-executor211: bg 0: block 46: invalid block bitmap
Kernel panic - not syncing: EXT4-fs (device loop0): panic forced after error
CPU: 1 PID: 5061 Comm: syz-executor211 Not tainted 6.5.0-rc5-syzkaller-00353-gae545c3283dc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 panic+0x30f/0x770 kernel/panic.c:340
 ext4_handle_error+0x84e/0x8b0 fs/ext4/super.c:685
 __ext4_error+0x277/0x3b0 fs/ext4/super.c:776
 ext4_validate_block_bitmap+0xdf5/0x1200 fs/ext4/balloc.c:429
 ext4_read_block_bitmap+0x40/0x80 fs/ext4/balloc.c:595
 ext4_mb_clear_bb fs/ext4/mballoc.c:6503 [inline]
 ext4_free_blocks+0xfd3/0x2e20 fs/ext4/mballoc.c:6748
 ext4_remove_blocks fs/ext4/extents.c:2545 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2710 [inline]
 ext4_ext_remove_space+0x216e/0x4d90 fs/ext4/extents.c:2958
 ext4_ext_truncate+0x164/0x1f0 fs/ext4/extents.c:4408
 ext4_truncate+0xa0a/0x1150 fs/ext4/inode.c:4127
 ext4_process_orphan+0x1aa/0x2d0 fs/ext4/orphan.c:339
 ext4_orphan_cleanup+0xb71/0x1400 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5577 [inline]
 ext4_fill_super+0x63ef/0x6ce0 fs/ext4/super.c:5696
 get_tree_bdev+0x468/0x6c0 fs/super.c:1318
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f86c9eb1a99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2eecbce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f86c9eb1a99
RDX: 00000000200001c0 RSI: 00000000200006c0 RDI: 0000000020000640
RBP: 000000000000ec37 R08: 0000000000000000 R09: 00005555562044c0
R10: 000000003f000000 R11: 0000000000000246 R12: 00007ffc2eecbd10
R13: 00007ffc2eecbcfc R14: 431bde82d7b634db R15: 00007f86c9efa03b
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
