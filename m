Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D885F9FA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJJNxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJJNxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:53:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4F5509F;
        Mon, 10 Oct 2022 06:53:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so25040011ejc.4;
        Mon, 10 Oct 2022 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G/dWkZH/lcZFThQ5CYaiL4o71iPPfb4HHLZtOwpAOpQ=;
        b=IyMDWqzBFEoqxjiqXo5pp1MSzPOPqbHsmHStcHIiPmMyRhKznQf8IQoQHsfQtRYbjk
         S+qbQRqjxGyN8jkqoQVAGmNvmEl+6dCdRxE0lud4UuDeZdd5ycNSvs7Meh4zagm839WE
         Gwy+ZLuogHQsSN3NBQ242raRFay3NSwmJp/67TV1PKbHKzf4/GN7fhzV1imv94IbsAjm
         ZYop5MOjXahfBX+utKLglhQKtkAnhAAh3fGHDd74dVEptZX2WunlXWVGH4DUwZBOAFYz
         0WUlHA9w18JT8fb7dU/WyiiSgS/Hstk3lzcK19P6IDQxOF8dSzbTw3WcZzxXJwt3L72n
         ZAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/dWkZH/lcZFThQ5CYaiL4o71iPPfb4HHLZtOwpAOpQ=;
        b=FYdi4V+4YxNWYPeMKkxBDUREx5QRm/FD/3fJIIk7z+swEsByTeIx2sk0PP4HkA/CZw
         t2oZ1SYxXmTKZtRsKq0+NCSViqlZHWscNwnmqwfUsv3Sj4zdyGEPUL0eckgeSk3jOBET
         C2RcIZ+Op5lyVwSgLxB++n6cQs/lVBI9VkSMDTVh9yVnBN7brgnMqERnn/kiHsCVmtBX
         zrNWQWcSOYX3ie1YBhLy04Q9mmpA/LNx6anQo04RNPeW8UYefNA7q6gltdSinewdqYVz
         ygiApsy4C1U9x2w2HTvO4a8ZmtAZHa+uYNlV0K5L0RkgnylMo1JbR0l8mVrSgKMGNTF8
         iGaA==
X-Gm-Message-State: ACrzQf0fehWk3KPVgjN+LtPCDOrh/UMowIOaBPAiqe5zbg2/EZnwL0LK
        5O6VTOh58RNl+V2XuynZtb84AUbTb9qyMe+xpuY/gXDJE8yjwQ==
X-Google-Smtp-Source: AMsMyM5Obm79nPTvVozOOwA1HntH8OU44ldvrUCW7EjQd9Idov8c+JaplIuTV4+O5Qt338v1RR/ZEgAKz61SQfHCGgs=
X-Received: by 2002:a17:907:75ed:b0:78d:97ed:2894 with SMTP id
 jz13-20020a17090775ed00b0078d97ed2894mr8992282ejc.739.1665410023250; Mon, 10
 Oct 2022 06:53:43 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 10 Oct 2022 21:53:07 +0800
Message-ID: <CAO4mrfcEivHWx3Ch3VA4tMWC3nVi7Nv1XR4WZ5XLxyKS9mZxYQ@mail.gmail.com>
Subject: general protection fault in fuse_test_super
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1EV0R2yutxfhDNK7k-qzCsfy0Y7cRjSxK/view?usp=sharing
kernel config: https://drive.google.com/file/d/1lNwvovjLNrcuyFGrg05IoSmgO5jaKBBJ/view?usp=sharing

Unfortunately, I don't have any reproducer for this crash yet.

general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 580 Comm: syz-executor Not tainted 5.15.0-rc5 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:get_fuse_conn_super fs/fuse/fuse_i.h:844 [inline]
RIP: 0010:fuse_test_super+0x68/0xa0 fs/fuse/inode.c:1633
Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 3a 48 8b 9b
78 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c
02 00 75 12 31 c0 48 39 2b 5b 5d 0f 94 c0 c3 e8 b2 0d 0a ff
RSP: 0018:ffffc90008bdfca0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000040000
RDX: 0000000000000000 RSI: ffff88802329a380 RDI: ffff88800ec68678
RBP: ffff88802a2fc800 R08: ffffffff82b3dfbd R09: fffff5200117bf8a
R10: 0000000000000003 R11: fffff5200117bf89 R12: dffffc0000000000
R13: ffffffff82b3dfb0 R14: 0000000000000000 R15: 0000000000000002
FS:  00007ff8f37f0700(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d548d9cbf0 CR3: 000000004d5c6000 CR4: 0000000000752ef0
DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 sget_fc+0x1ff/0x7e0 fs/super.c:525
 fuse_get_tree+0x201/0x3f0 fs/fuse/inode.c:1664
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1228/0x1cb0 fs/namespace.c:3318
 do_mount+0xf3/0x110 fs/namespace.c:3331
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff8f62cc5de
Code: 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff8f37efa68 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff8f62cc5de
RDX: 00000000200075c0 RSI: 0000000020007600 RDI: 0000000000000000
RBP: 00007ff8f37efb00 R08: 00007ff8f37efb00 R09: 00000000200075c0
R10: 0000000000000004 R11: 0000000000000202 R12: 00000000200075c0
R13: 0000000020007600 R14: 00007ff8f37efac0 R15: 0000000020007600
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 361dd1df065c6dad ]---
RIP: 0010:get_fuse_conn_super fs/fuse/fuse_i.h:844 [inline]
RIP: 0010:fuse_test_super+0x68/0xa0 fs/fuse/inode.c:1633
Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 3a 48 8b 9b
78 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c
02 00 75 12 31 c0 48 39 2b 5b 5d 0f 94 c0 c3 e8 b2 0d 0a ff
RSP: 0018:ffffc90008bdfca0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000040000
RDX: 0000000000000000 RSI: ffff88802329a380 RDI: ffff88800ec68678
RBP: ffff88802a2fc800 R08: ffffffff82b3dfbd R09: fffff5200117bf8a
R10: 0000000000000003 R11: fffff5200117bf89 R12: dffffc0000000000
R13: ffffffff82b3dfb0 R14: 0000000000000000 R15: 0000000000000002
FS:  00007ff8f37f0700(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d548d9cbf0 CR3: 000000004d5c6000 CR4: 0000000000752ef0
DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess), 4 bytes skipped:
   0: df 48 89              fisttps -0x77(%rax)
   3: fa                    cli
   4: 48 c1 ea 03          shr    $0x3,%rdx
   8: 80 3c 02 00          cmpb   $0x0,(%rdx,%rax,1)
   c: 75 3a                jne    0x48
   e: 48 8b 9b 78 06 00 00 mov    0x678(%rbx),%rbx
  15: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  1c: fc ff df
  1f: 48 89 da              mov    %rbx,%rdx
  22: 48 c1 ea 03          shr    $0x3,%rdx
* 26: 80 3c 02 00          cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2a: 75 12                jne    0x3e
  2c: 31 c0                xor    %eax,%eax
  2e: 48 39 2b              cmp    %rbp,(%rbx)
  31: 5b                    pop    %rbx
  32: 5d                    pop    %rbp
  33: 0f 94 c0              sete   %al
  36: c3                    retq
  37: e8 b2 0d 0a ff        callq  0xff0a0dee

Best,
Wei
