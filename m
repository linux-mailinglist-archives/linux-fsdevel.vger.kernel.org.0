Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C249751197
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 22:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjGLUAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjGLUAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:00:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A241FDE
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 13:00:00 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c6e4d4c59bcso1720155276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689192000; x=1691784000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZWsn10ms8/KyUVvyBQaw1fP00pVGmdzjm0GtqTpp8w=;
        b=G9KVBr/xC76jZ0gBOBcTP8kNEVHvgN9xWi85yFTfhLVrIFu6u0sB6iudDAZvFrR2to
         tskuPI3BkJZyJ77e8SfCUomRWoOxTE7f56NN70C4Ws51PtPrZsYyxDxIH4fw+/xchSlf
         uVisrnwJkH7asa+TmzyNAnA098Lz5WGfP5TtpRl55rXrHPOxKjkjfbMHkLrGDxS2F/QW
         0Fvkl7MYCfVafx/Nj7DPhUnBDEfBhn9gHlFMcLqmVw3kg4LQs05UBUGbnA8XYxlpDwc+
         xJA47KsNOc3EFqpS6DME6UoTdFNRuN4Di3N1NJlvTZbFCoR68CHfoSRPzcimjVxXsrpa
         T+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689192000; x=1691784000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZWsn10ms8/KyUVvyBQaw1fP00pVGmdzjm0GtqTpp8w=;
        b=jSvU2nWy8abK3aGeGy2IjI5KayJsRxPtssDwWUmmXsBaPkcCYBWA2jVQvrqRR2BxUs
         Y8Xwzw6b+arsp8/sEBNXfnoUtxEVY2otvgNOGLlo7T1tFUJV/UF7KTN958X66LFm8rjx
         f6BOzfl2TrPYhlA4Lfqs1aKicoItSDEw1wZ+3KG/FQ0NqqnjzvW6Gc9NLzV+CWk2MlVb
         66jzBwTDqckk2tLTXNvu1eamZTOev1SwrN2GiFFtd3emPt4tgFxwlBX0cASv35gIWx3G
         tlarxPMvDJKVCG8vz9GiadH5qqyOPatifKs7OjMmT+pwln8QAbmI62GRO2n2E77T0rn2
         sEbw==
X-Gm-Message-State: ABy/qLZeNNfKqVngV8D3i2uDZ8yi/enRfwPeiCFHjWGb344ivtZhrTJ3
        hwZc3iP8adNJqD5uqnSemY/YOnoRzq8xVjLdO/lrwA==
X-Google-Smtp-Source: APBJJlF9Ojs6VjU+N27lAb9ArLwGqCR0gUGwIq/k2ipwhW0+gkaLA081VvdviLE35rAMEaLJ8VUEE8Aj+StkILNOzGs=
X-Received: by 2002:a25:c541:0:b0:c75:593f:d4ab with SMTP id
 v62-20020a25c541000000b00c75593fd4abmr3790697ybe.22.1689191999748; Wed, 12
 Jul 2023 12:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002db68f05ffb791bc@google.com> <0000000000005b75ce05ffbd34bc@google.com>
 <CAJuCfpFGVvtK61Cgd0pN9GRRaw7kRcEUVSG3kceQxtNtPoeaGA@mail.gmail.com>
In-Reply-To: <CAJuCfpFGVvtK61Cgd0pN9GRRaw7kRcEUVSG3kceQxtNtPoeaGA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 12 Jul 2023 12:59:48 -0700
Message-ID: <CAJuCfpHPdA8RpBb5sFFnX7uiZO72cp3VqmaHmhSZCFX0GjO4oQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] WARNING in handle_userfault
To:     syzbot <syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 8:17=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jul 5, 2023 at 6:16=E2=80=AFAM syzbot
> <syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    e1f6a8eaf1c2 Add linux-next specific files for 20230705
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13ec5228a80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D347a3e7e531=
c1809
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D339b02f826caa=
fd5f7a8
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1716aeaca=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12e882e2a80=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/2d0435d8ff5d/d=
isk-e1f6a8ea.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/d28b2df82094/vmli=
nux-e1f6a8ea.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/fb4e5bfa0a0f=
/bzImage-e1f6a8ea.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com
> >
> > kvm_intel: L1TF CPU bug present and SMT on, data leak possible. See CVE=
-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l=
1tf.html for details.
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 mmap_assert_w=
rite_locked include/linux/mmap_lock.h:71 [inline]
> > WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 __is_vma_writ=
e_locked include/linux/mm.h:712 [inline]
> > WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 vma_assert_lo=
cked include/linux/mm.h:753 [inline]
> > WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 assert_fault_=
locked include/linux/mm.h:786 [inline]
> > WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 handle_userfa=
ult+0x149b/0x27a0 fs/userfaultfd.c:440
> > Modules linked in:
> > CPU: 0 PID: 5028 Comm: syz-executor359 Not tainted 6.4.0-next-20230705-=
syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 05/27/2023
> > RIP: 0010:mmap_assert_write_locked include/linux/mmap_lock.h:71 [inline=
]
> > RIP: 0010:__is_vma_write_locked include/linux/mm.h:712 [inline]
> > RIP: 0010:vma_assert_locked include/linux/mm.h:753 [inline]
> > RIP: 0010:assert_fault_locked include/linux/mm.h:786 [inline]
> > RIP: 0010:handle_userfault+0x149b/0x27a0 fs/userfaultfd.c:440
> > Code: ff 49 8d bc 24 a0 01 00 00 31 f6 e8 2f b9 23 08 31 ff 41 89 c5 89=
 c6 e8 c3 a2 87 ff 45 85 ed 0f 85 83 ed ff ff e8 95 a6 87 ff <0f> 0b e9 77 =
ed ff ff e8 89 a6 87 ff 49 8d bc 24 a0 01 00 00 be ff
> > RSP: 0000:ffffc90003a4fb68 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffc90003a4fd88 RCX: 0000000000000000
> > RDX: ffff8880133bbb80 RSI: ffffffff81fd6ddb RDI: 0000000000000005
> > RBP: 0000000000000200 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807d8e4280
> > R13: 0000000000000000 R14: ffff888021cb9110 R15: ffff888021cb9100
> > FS:  000055555738f300(0000) GS:ffff8880b9800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020b7d800 CR3: 0000000029d0e000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  do_anonymous_page mm/memory.c:4151 [inline]
> >  do_pte_missing mm/memory.c:3671 [inline]
> >  handle_pte_fault mm/memory.c:4949 [inline]
> >  __handle_mm_fault+0x35ff/0x3cc0 mm/memory.c:5089
> >  handle_mm_fault+0x3c2/0xa20 mm/memory.c:5254
> >  do_user_addr_fault+0x2ed/0x13a0 arch/x86/mm/fault.c:1365
> >  handle_page_fault arch/x86/mm/fault.c:1509 [inline]
> >  exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1565
> >  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> > RIP: 0033:0x7faa694e34d5
> > Code: 52 89 c2 01 f6 29 f2 83 fa 05 0f 87 0a 02 00 00 48 63 14 97 48 01=
 fa ff e2 0f 1f 40 00 4c 89 d2 66 c1 e9 03 83 c0 01 0f b7 c9 <48> 89 14 cd =
00 d8 b7 20 83 f8 20 75 b6 48 8b 84 24 f0 00 00 00 f3
> > RSP: 002b:00007ffefcb0d8e0 EFLAGS: 00010202
> > RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: 0000860000109120 RSI: 0000000000000000 RDI: 00007faa69564020
> > RBP: 0000000000000006 R08: 0000830000789120 R09: 00000000aaaaaaab
> > R10: 0000870000109120 R11: 00008f0000309120 R12: 00008b0000889120
> > R13: 0000000000000000 R14: 00008e0000309120 R15: 00007ffefcb0de40
> >  </TASK>
> >
>
> Sorry, this is my code. Missed that __is_vma_write_locked() generates
> assertion. Will post a fix shortly.

Fix is posted at
https://lore.kernel.org/all/20230712195652.969194-1-surenb@google.com/

>
> >
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
