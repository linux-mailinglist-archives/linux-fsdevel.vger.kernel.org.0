Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38872748587
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGENzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 09:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjGENzR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:55:17 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5EA199E;
        Wed,  5 Jul 2023 06:54:58 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78f6a9800c9so2302380241.3;
        Wed, 05 Jul 2023 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688565297; x=1691157297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1OO/4Uu1I21/AwDxGfADZ/RnwtvdVTDBnkrZdnKuG8=;
        b=cqN0/oyDTD+aPmM5wm/6WgKlj0FTg5AzwBGwCWVIU3bWwhIWv8fTILNrUMiHFn6xqf
         qkiyUmWF1OGEZGrOvUD6RIPcQtPAjMQatV/H+ZwvUOSkF1dwRrqsYpL5cZMq26vlDQgP
         HN4SIYi15ehRmrQacvn6W+axWS0bARaJsGn7fSU2u5d73j4pmXGvLw3NTvaETlzeVb2e
         c3XNxtDhwpwUHgTOa+1oPZJ6QKWWrtSvn78M2BXNcDI9FFJu3c8s2pzaY4E9YTWQvpg7
         HHtvNwihfz4r3rtFexf5LPMwjE78grKK6e4pDfE7vxcWcUF5+l52pvCi0SHkKFmBoQRv
         zOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688565297; x=1691157297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1OO/4Uu1I21/AwDxGfADZ/RnwtvdVTDBnkrZdnKuG8=;
        b=E2ntG1YbL90bKVkxPTGVlET3XMAzmzf/z80g0rWyYJKmjZXSsvNgArZDa12xeBO7Xs
         aWmLLxcNr+mOEuHsEEAk0BrOOW/LYPM1hOsKvMWLZZCCdRsj4hit9N24MquTjNoCM3Jv
         36lASAMrZwNNTi6VGd3Xq1KWogNKh67p+V1jw7Nghv5CseFnz/A2iukwzoSeBxcr/Q5o
         DCKIIZlAfGgMqv6qcef10SZ4MOk0D53+ooatcTqRxfD7FkbUpyMprOaUBRnEytuoN+un
         alx7D83SjRIs/BS2VwYfnPsHfKvFZjYrEmBUuVMEcMUOzx0TP9IUZ6G4ZvRQLa4SqTH4
         8pKQ==
X-Gm-Message-State: ABy/qLbiJRIlP/RXhGnX3QATCVWV7WUQJWfR6P/MuDgXmjh15jrSMk/N
        AeNImiYhs1/eqDe32mSnFOhklr+6wqLmND0RPgw=
X-Google-Smtp-Source: APBJJlGgsFn4RmMHdLsPp12Iekj6EefZkZ5rI4y7HiQp9IwUXHNuiHel7bIEKBGZI+CC7q5f3c3D7Eq2rVrShEZg5WE=
X-Received: by 2002:a67:fe94:0:b0:445:13e:d8ec with SMTP id
 b20-20020a67fe94000000b00445013ed8ecmr2241731vsr.3.1688565296806; Wed, 05 Jul
 2023 06:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f34d705ffbc2604@google.com> <20230705-aufgearbeitet-kaffee-44ff4731a7dd@brauner>
 <f966d10e793a9e8e2edb22cf09c25f097e638df9.camel@kernel.org>
In-Reply-To: <f966d10e793a9e8e2edb22cf09c25f097e638df9.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 5 Jul 2023 16:54:45 +0300
Message-ID: <CAOQ4uxgX15F-zAYp0CV2zRLnSx6+m3=ejW2k4q8FdZqri5h8ng@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in d_path
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 5, 2023 at 4:41=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Wed, 2023-07-05 at 15:05 +0200, Christian Brauner wrote:
> > On Wed, Jul 05, 2023 at 05:00:45AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    d528014517f2 Revert ".gitignore: ignore *.cover and *=
.mbx"
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14fad002a=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1085b4238=
c9eb6ba
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da67fc5321ff=
b4b311c98
> > > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for=
 Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/fef94e788067=
/disk-d5280145.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/576412ea518b/vm=
linux-d5280145.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/685a0e4be0=
6b/bzImage-d5280145.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> > >
> > > general protection fault, probably for non-canonical address 0xdffffc=
000000000a: 0000 [#1] PREEMPT SMP KASAN
> > > KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057=
]
> > > CPU: 1 PID: 10127 Comm: syz-executor.3 Not tainted 6.4.0-syzkaller-11=
478-gd528014517f2 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 05/27/2023
> > > RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5012
> > > Code: 85 75 18 00 00 83 3d 15 c8 2c 0d 00 48 89 9c 24 10 01 00 00 0f =
84 f8 0f 00 00 83 3d 5c de b3 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 0=
0 00 74 1a 48 89 d7 e8 b4 51 79 00 48 8b 94 24 80 00 00
> > > RSP: 0018:ffffc900169be9e0 EFLAGS: 00010006
> > > RAX: 000000000000000a RBX: 1ffff92002d37d60 RCX: 0000000000000002
> > > RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000050
> > > RBP: ffffc900169beca8 R08: dffffc0000000000 R09: 0000000000000001
> > > R10: dffffc0000000000 R11: fffffbfff1d2fe76 R12: 0000000000000000
> > > R13: 0000000000000001 R14: 0000000000000002 R15: ffff88802091d940
> > > FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007fa22a3fe000 CR3: 000000004b5e1000 CR4: 00000000003506e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
> > >  seqcount_lockdep_reader_access+0x139/0x220 include/linux/seqlock.h:1=
02
> > >  get_fs_root_rcu fs/d_path.c:244 [inline]
> > >  d_path+0x2f0/0x6e0 fs/d_path.c:286
> > >  audit_log_d_path+0xd3/0x310 kernel/audit.c:2139
> > >  dump_common_audit_data security/lsm_audit.c:224 [inline]
> > >  common_lsm_audit+0x7cf/0x1a90 security/lsm_audit.c:458
> > >  smack_log+0x421/0x540 security/smack/smack_access.c:383
> > >  smk_tskacc+0x2ff/0x360 security/smack/smack_access.c:253
> > >  smack_inode_getattr+0x203/0x270 security/smack/smack_lsm.c:1202
> > >  security_inode_getattr+0xd3/0x120 security/security.c:2114
> > >  vfs_getattr+0x25/0x70 fs/stat.c:167
> > >  ovl_getattr+0x1b1/0xf70 fs/overlayfs/inode.c:174
> > >  ima_check_last_writer security/integrity/ima/ima_main.c:171 [inline]
> > >  ima_file_free+0x26e/0x4b0 security/integrity/ima/ima_main.c:203
> >
> > Ugh, I think the root of this might all be the call back into
> > vfs_getattr() that happens on overlayfs:
> >
> > __fput()
> > -> ima_file_free()
> >    -> mutex_lock()
> >    -> vfs_getattr_nosec()
> >       -> i_op->getattr() =3D=3D ovl_getattr()
> >          -> vfs_getattr()
> >           -> security_inode_getattr()
> >    -> mutex_unlock()
> >
> > So either overlayfs needs to call vfs_getattr_nosec() when the request
> > comes from vfs_getattr_nosec() or this needs to use
> > backing_file_real_path() to operate on the real underlying path.
> >
> > Thoughts?
> >
>
> When you say "this needs to use backing_file_real_path()", what do you
> mean by "this"? IMA?
>
> That said, passing some sort of NOSEC flag to vfs_getattr that
> designates the call as kernel-internal seems like the more correct thing
> to do here, and might be useful in other weird stacking cases like this.
>

I don't think that NOSEC is the root cause.

If you ever noticed file_dentry() sprinkled through fs code,
it is only there because if that code were to call use helpers
that rely on file_inode() and d_inode(file->f_path.dentry) being
the same - bad things will happen and NOSEC will not cover
all those bad things.

IMA code also has file_dentry() sprinkled.
But it still accesses file->f_path in a few places and that
can result in bad things.

Thanks,
Amir.
