Return-Path: <linux-fsdevel+bounces-4076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAF87FC382
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 19:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796E21F20F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4A39AD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRQGyjIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622CD10CB
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 10:09:17 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfaf05db73so6785ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 10:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701194957; x=1701799757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQvuv2JfnqPC0nISqv1MKzRBjtZt6Fr5vvW6D+u2sYo=;
        b=yRQGyjIpFnOqNPq0J7ppDZTOl1PKgcHfudhnkpcqFhY6u9SkgKrdgHGsLzUsOd5aE6
         vEvtXbo5eFrXPzke7J/ItXuiYtphd9EnNLe2Xp3ErgZrAVSt6mdqQmlBo60dU0ZIP9Ai
         GLZU8z+aMNP6y+qfsmRUvlHGI6jg2fO0m9h8WqfVOFWRPRcJsAr0IMktScLqubsnzLgr
         JwbpRoYuWdDGJhes7eUdsdtQDlgLXzZ8ADoZaBjDofgEDFd3O1UVDQmuKHgNwfmQtEe2
         f0nMcDql4AJtfHWIM9c2AJLN3ZX/Lq+SGWNPLZ8OQ9ETR9UyCu/qFD0ADI9hzZKUevsX
         tAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194957; x=1701799757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQvuv2JfnqPC0nISqv1MKzRBjtZt6Fr5vvW6D+u2sYo=;
        b=FctCZ2WTTtY4/uoxmbRmiStWsw1uq2/4QwYVH9N7pwMeAm63kHPRfhtIbeJmOARrVO
         2L8x14M3igYub50j2xH20gkqeTFzMdIbKhCcvHW6Ya93vXoUXCdtzKK39XqS9QySdEbf
         thEJqBknFu9LLyVApAIMNxqRC/mpd60PTAm9vR4IPydULBG9RrCmLROyK0uLAOfXsZ14
         rvLkGOZb6P9fXrDNr9dUuMbwm196aEIEXZ0INlyIxn9PXR72nw4n4wXByp56XmFPTWSD
         VGYZf/eCEJrTFvDtLz1MqzKoyZ7a/cIerQldeUvKxYLJxn5384/gnTr4uhlOgoo90vQv
         +/CQ==
X-Gm-Message-State: AOJu0YwXGlygY2OWge+oeU4vmrZfkwS0KNHCExMIGEpr57GRlYCErDsJ
	EXCJVuoQjtF3wqocV8FmNuip7V5lLZIPmmdK5VTnTA==
X-Google-Smtp-Source: AGHT+IE0FwALcdX8pnrX+yALhUMoW3xZrkn+IfPTInEJx2IVGf4heUBuVQtHOccJ+o79A7IKFGGowSlLiChnKJbkSag=
X-Received: by 2002:a17:902:c1d5:b0:1cf:9a44:1516 with SMTP id
 c21-20020a170902c1d500b001cf9a441516mr977174plc.3.1701194956477; Tue, 28 Nov
 2023 10:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004d4716060af08a45@google.com> <531f8f07-6c4c-66bb-1d8e-7637222154af@oracle.com>
 <20231128164010.GM18929@twin.jikos.cz>
In-Reply-To: <20231128164010.GM18929@twin.jikos.cz>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 28 Nov 2023 19:09:04 +0100
Message-ID: <CANp29Y5_VmffK_miK7uqLAn-1--8ZJAYs7V8F+2uDVQJLqKkNA@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_use_block_rsv
To: dsterba@suse.cz
Cc: Anand Jain <anand.jain@oracle.com>, 
	syzbot <syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com>, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 5:47=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Sun, Nov 26, 2023 at 06:59:41AM +0800, Anand Jain wrote:
> >
> >
> > On 25/11/2023 10:08, syzbot wrote:
> > > syzbot has bisected this issue to:
> > >
> > > commit a5b8a5f9f8355d27a4f8d0afa93427f16d2f3c1e
> > > Author: Anand Jain <anand.jain@oracle.com>
> > > Date:   Thu Sep 28 01:09:47 2023 +0000
> > >
> > >      btrfs: support cloned-device mount capability
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1446d3=
44e80000
> > > start commit:   d3fa86b1a7b4 Merge tag 'net-6.7-rc3' of git://git.ker=
nel.o..
> > > git tree:       upstream
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1646d3=
44e80000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1246d344e=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6ae1a4ee9=
71a7305
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D10d5b62a8d7=
046b86d22
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1431040=
ce80000
> > >
> > > Reported-by: syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com
> > > Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bi=
section
> >
> >
> > It is completely strange that this issue bisects to the commit
> > a5b8a5f9f835 ('btrfs: support cloned-device mount capability').
> > I am unable to reproduce this as well.
>
> I think it's because of changed timing or it can be an inconclusive
> bisect. Things around space handling depend on timing, the test would
> need to be run a few times to be sure.
>
> The report provides an image so it may be good to analyze if it's scaled
> properly or if the reproducer does something strange.

Bisection log itself looks reasonable.

One other case to consider is that "btrfs: support cloned-device mount
capability" just helped surface the problem. Syzbot can only bisect
for the revision at which the reproducer started/stopped working and,
even though we try to minimize the reproducer (*), it may still rely
on some functionality that's not related to the actual bug. One of the
possibilities here is that the slightly changed validation rules in
btrfs_validate_super() allowed syzkaller to trigger a problem
somewhere else.

(*) We don't do it for filesystem images themselves as it does not
make very much sense -- in almost all cases by zeroing/dropping bytes
syzkaller just breaks the image and the reproducer stops working.
Without knowing the underlying fs image structure in detail it just
doesn't work as intended.

--=20
Aleksandr
>
> > -------------------
> > WARNING: CPU: 1 PID: 58 at fs/btrfs/block-rsv.c:523
> > btrfs_use_block_rsv+0x60d/0x860 fs/btrfs/block-rsv.c:523
> > <snap>
> > Call Trace:
> >   <TASK>
> >   btrfs_alloc_tree_block+0x1e0/0x12c0 fs/btrfs/extent-tree.c:5114
> >   btrfs_force_cow_block+0x3e5/0x19e0 fs/btrfs/ctree.c:563
> >   btrfs_cow_block+0x2b6/0xb30 fs/btrfs/ctree.c:741
> >   push_leaf_left+0x315/0x4d0 fs/btrfs/ctree.c:3485
> >   split_leaf+0x9c3/0x13b0 fs/btrfs/ctree.c:3681
> >   search_leaf fs/btrfs/ctree.c:1944 [inline]
> >   btrfs_search_slot+0x24ba/0x2fd0 fs/btrfs/ctree.c:2131
> >   btrfs_insert_empty_items+0xb6/0x1b0 fs/btrfs/ctree.c:4285
> >   btrfs_insert_empty_item fs/btrfs/ctree.h:657 [inline]
> >   insert_reserved_file_extent+0x7aa/0x950 fs/btrfs/inode.c:2907
> >   insert_ordered_extent_file_extent fs/btrfs/inode.c:3005 [inline]
> >   btrfs_finish_one_ordered+0x12dc/0x20d0 fs/btrfs/inode.c:3113
> >   btrfs_work_helper+0x210/0xbf0 fs/btrfs/async-thread.c:315
> >   process_one_work+0x886/0x15d0 kernel/workqueue.c:2630
> >   process_scheduled_works kernel/workqueue.c:2703 [inline]
> >   worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
> >   kthread+0x2c6/0x3a0 kernel/kthread.c:388
> >   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> > -----------------
> >
> > btrfs_use_block_rsv()
> > <snap>
> >          /*
> >           * The global reserve still exists to save us from ourselves,
> > so don't
> >           * warn_on if we are short on our delayed refs reserve.
> >           */
> >          if (block_rsv->type !=3D BTRFS_BLOCK_RSV_DELREFS &&
> >              btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
> >                  static DEFINE_RATELIMIT_STATE(_rs,
> >                                  DEFAULT_RATELIMIT_INTERVAL * 10,
> >                                  /*DEFAULT_RATELIMIT_BURST*/ 1);
> >                  if (__ratelimit(&_rs))
> >                          WARN(1, KERN_DEBUG
> >                                  "BTRFS: block rsv %d returned %d\n",
> >                                  block_rsv->type, ret);
> >          }
> > ----------
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20231128164010.GM18929%40twin.jikos.cz.

