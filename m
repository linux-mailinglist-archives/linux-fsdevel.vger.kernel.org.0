Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63507A97D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjIUR17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjIUR1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:27:37 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621983A84;
        Thu, 21 Sep 2023 10:03:22 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c0e8345c1eso745284a34.0;
        Thu, 21 Sep 2023 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315723; x=1695920523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8ytC2Vx8V4hY5L7L1LwRsWASzOp+ojwQfBsnLXq0YM=;
        b=l5QzyV+ZqQuKzfemPSYYwvu7dt+4JRif8MuacOzjdTk4mlP49cYuy628S/WkdGou4X
         58lG1ftpU2l+GN7ULlGzhtmYvFPu1UdO9Fu7nAiHgbBOl5cbBGWwA99KiQXo8EuF9ciJ
         NUARDsiXdkErn2/yfePFozhemKDV8KcmVJgG/NDeM0VZpBkeP9l437t/o9KgSD7Jhq27
         XcfM1JVrWrts7IWY58CNAD71lTJNTJvw7bOfp25V7O5IMU3L9c0BnAKpLCraYSKl9We9
         tMaWna60HhViz/aE1JwpWd+zXMFQ7MbG9QX4cZQrZPEBzSySIomarF8gPNl5Fde+TlcO
         Iu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315723; x=1695920523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8ytC2Vx8V4hY5L7L1LwRsWASzOp+ojwQfBsnLXq0YM=;
        b=evT+p+TodCONfMP/nFEsezLscFCW+Dl263hON7H5tUDRPyKh/rPGGAadhY/ay1ouw5
         FSXIJVR+hsSRILmATGyuTPfVcOWPRiqPUAtaXj8vXao5h9HZ4xbOeGZQ/8/f9LUJhVZI
         xXyE3QSdqNfp2r3IvBkKaIjCkZRNlk3SYTd6I355tyP8QVAsiU0MmfVaUyusMQRKLFSl
         JjPsIbBscItwCGNjitOMprf0oIaW7Berk5yD+syJF/0Gmce+L7O3qkxcfR1W7Ahqln2N
         yqjMecTkpBoo1hrYXdOj6NJvJg0jsek5s2fLX5hLOxCwguWBmgyjiF+Ch5QrDvsrPDLV
         1lVg==
X-Gm-Message-State: AOJu0YwZcTVAGNk1WX6YcSAHsebArEsyf07FrHq7g4JE5eYovFfbphod
        fN1kG/WtCEu42VIVlQh35ZViWcE2nk5TqAEfONHmqLL4ux0=
X-Google-Smtp-Source: AGHT+IEpcUK3qhSvCqrsWDAjAKnrtyhVN1hUtPBpR5zBICBwStaC+kGUxubx/OrGAtJrcTJGTvbzk4QhEyGvFw4dK10=
X-Received: by 2002:a05:6358:6f12:b0:139:cdc2:e618 with SMTP id
 r18-20020a0563586f1200b00139cdc2e618mr5628425rwn.8.1695315722933; Thu, 21 Sep
 2023 10:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000259bd8060596e33f@google.com> <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
 <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com> <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
 <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com> <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
 <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com> <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
 <7caa3aa06cc2d7f8d075306b92b259dab3e9bc21.camel@linux.ibm.com>
 <20230921-gedanken-salzwasser-40d25b921162@brauner> <7ef00ceb49abbb29c49a39287a7c3f28e00cf82a.camel@linux.ibm.com>
 <028eefb0207e8cb163617ef28b8104e98d00ca2e.camel@kernel.org>
 <7e211a0e0ccf335143abe8e8b6366bbbfada36f8.camel@linux.ibm.com>
 <e5a8196fbd3ed73b777df557633d1bfddf7cfd76.camel@kernel.org> <b9f8eb5c7e2e120bee908ab39a5ffc5d818d4cc2.camel@linux.ibm.com>
In-Reply-To: <b9f8eb5c7e2e120bee908ab39a5ffc5d818d4cc2.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 20:01:51 +0300
Message-ID: <CAOQ4uxhNCar7jSeocjrH5RtccSJUO6jyqjnhj0U4Y+hQXL1X8Q@mail.gmail.com>
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in d_path
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 7:31=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Thu, 2023-09-21 at 11:39 -0400, Jeff Layton wrote:
> > On Thu, 2023-09-21 at 11:19 -0400, Mimi Zohar wrote:
> > > On Thu, 2023-09-21 at 11:10 -0400, Jeff Layton wrote:
> > > > On Thu, 2023-09-21 at 10:52 -0400, Mimi Zohar wrote:
> > > > > On Thu, 2023-09-21 at 13:48 +0200, Christian Brauner wrote:
> > > > > > On Thu, Sep 21, 2023 at 07:24:23AM -0400, Mimi Zohar wrote:
> > > > > > > On Thu, 2023-09-21 at 06:32 -0400, Jeff Layton wrote:
> > > > > > > > On Wed, 2023-09-20 at 17:52 -0700, Casey Schaufler wrote:
> > > > > > > > > On 9/20/2023 5:10 PM, Stefan Berger wrote:
> > > > > > > > > >
> > > > > > > > > > On 9/20/23 18:09, Stefan Berger wrote:
> > > > > > > > > > >
> > > > > > > > > > > On 9/20/23 17:16, Jeff Layton wrote:
> > > > > > > > > > > > On Wed, 2023-09-20 at 16:37 -0400, Stefan Berger wr=
ote:
> > > > > > > > > > > > > On 9/20/23 13:01, Stefan Berger wrote:
> > > > > > > > > > > > > > On 9/17/23 20:04, syzbot wrote:
> > > > > > > > > > > > > > > syzbot has bisected this issue to:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > commit db1d1e8b9867aae5c3e61ad7859abfcc4a6fd6=
c7
> > > > > > > > > > > > > > > Author: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > > > > > > Date:   Mon Apr 17 16:55:51 2023 +0000
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >       IMA: use vfs_getattr_nosec to get the i=
_version
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > bisection log:
> > > > > > > > > > > > > > > https://syzkaller.appspot.com/x/bisect.txt?x=
=3D106f7e54680000
> > > > > > > > > > > > > > > start commit:   a747acc0b752 Merge tag
> > > > > > > > > > > > > > > 'linux-kselftest-next-6.6-rc2'
> > > > > > > > > > > > > > > of g..
> > > > > > > > > > > > > > > git tree:       upstream
> > > > > > > > > > > > > > > final oops:
> > > > > > > > > > > > > > > https://syzkaller.appspot.com/x/report.txt?x=
=3D126f7e54680000
> > > > > > > > > > > > > > > console output:
> > > > > > > > > > > > > > > https://syzkaller.appspot.com/x/log.txt?x=3D1=
46f7e54680000
> > > > > > > > > > > > > > > kernel config:
> > > > > > > > > > > > > > > https://syzkaller.appspot.com/x/.config?x=3Dd=
f91a3034fe3f122
> > > > > > > > > > > > > > > dashboard link:
> > > > > > > > > > > > > > > https://syzkaller.appspot.com/bug?extid=3Da67=
fc5321ffb4b311c98
> > > > > > > > > > > > > > > syz repro:
> > > > > > > > > > > > > > > https://syzkaller.appspot.com/x/repro.syz?x=
=3D1671b694680000
> > > > > > > > > > > > > > > C reproducer:
> > > > > > > > > > > > > > > https://syzkaller.appspot.com/x/repro.c?x=3D1=
4ec94d8680000
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Reported-by: syzbot+a67fc5321ffb4b311c98@syzk=
aller.appspotmail.com
> > > > > > > > > > > > > > > Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_no=
sec to get the
> > > > > > > > > > > > > > > i_version")
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > For information about bisection process see:
> > > > > > > > > > > > > > > https://goo.gl/tpsmEJ#bisection
> > > > > > > > > > > > > > The final oops shows this here:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > BUG: kernel NULL pointer dereference, address: =
0000000000000058
> > > > > > > > > > > > > > #PF: supervisor read access in kernel mode
> > > > > > > > > > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > > > > > > > > > PGD 0 P4D 0
> > > > > > > > > > > > > > Oops: 0000 [#1] PREEMPT SMP
> > > > > > > > > > > > > > CPU: 0 PID: 3192 Comm: syz-executor.0 Not taint=
ed
> > > > > > > > > > > > > > 6.4.0-rc2-syzkaller #0
> > > > > > > > > > > > > > Hardware name: Google Google Compute Engine/Goo=
gle Compute Engine,
> > > > > > > > > > > > > > BIOS Google 08/04/2023
> > > > > > > > > > > > > > RIP: 0010:__lock_acquire+0x35/0x490 kernel/lock=
ing/lockdep.c:4946
> > > > > > > > > > > > > > Code: 83 ec 18 65 4c 8b 35 aa 60 f4 7e 83 3d b7=
 11 e4 02 00 0f 84 05
> > > > > > > > > > > > > > 02 00 00 4c 89 cb 89 cd 41 89 d5 49 89 ff 83 fe=
 01 77 0c 89 f0
> > > > > > > > > > > > > > <49> 8b
> > > > > > > > > > > > > > 44 c7 08 48 85 c0 75 1b 4c 89 ff 31 d2 45 89 c4=
 e8 74 f6 ff
> > > > > > > > > > > > > > RSP: 0018:ffffc90002edb840 EFLAGS: 00010097
> > > > > > > > > > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX=
: 0000000000000002
> > > > > > > > > > > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI=
: 0000000000000050
> > > > > > > > > > > > > > RBP: 0000000000000002 R08: 0000000000000001 R09=
: 0000000000000000
> > > > > > > > > > > > > > R10: 0000000000000000 R11: 0000000000000000 R12=
: 0000000000000000
> > > > > > > > > > > > > > R13: 0000000000000000 R14: ffff888102ea5340 R15=
: 0000000000000050
> > > > > > > > > > > > > > FS:  0000000000000000(0000) GS:ffff88813bc00000=
(0000)
> > > > > > > > > > > > > > knlGS:0000000000000000
> > > > > > > > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> > > > > > > > > > > > > > CR2: 0000000000000058 CR3: 0000000003aa8000 CR4=
: 00000000003506f0
> > > > > > > > > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2=
: 0000000000000000
> > > > > > > > > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7=
: 0000000000000400
> > > > > > > > > > > > > > Call Trace:
> > > > > > > > > > > > > >   <TASK>
> > > > > > > > > > > > > >   lock_acquire+0xd8/0x1f0 kernel/locking/lockde=
p.c:5691
> > > > > > > > > > > > > >   seqcount_lockdep_reader_access include/linux/=
seqlock.h:102 [inline]
> > > > > > > > > > > > > >   get_fs_root_rcu fs/d_path.c:243 [inline]
> > > > > > > > > > > > > >   d_path+0xd1/0x1f0 fs/d_path.c:285
> > > > > > > > > > > > > >   audit_log_d_path+0x65/0x130 kernel/audit.c:21=
39
> > > > > > > > > > > > > >   dump_common_audit_data security/lsm_audit.c:2=
24 [inline]
> > > > > > > > > > > > > >   common_lsm_audit+0x3b3/0x840 security/lsm_aud=
it.c:458
> > > > > > > > > > > > > >   smack_log+0xad/0x130 security/smack/smack_acc=
ess.c:383
> > > > > > > > > > > > > >   smk_tskacc+0xb1/0xd0 security/smack/smack_acc=
ess.c:253
> > > > > > > > > > > > > >   smack_inode_getattr+0x8a/0xb0 security/smack/=
smack_lsm.c:1187
> > > > > > > > > > > > > >   security_inode_getattr+0x32/0x50 security/sec=
urity.c:2114
> > > > > > > > > > > > > >   vfs_getattr+0x1b/0x40 fs/stat.c:167
> > > > > > > > > > > > > >   ovl_getattr+0xa6/0x3e0 fs/overlayfs/inode.c:1=
73
> > > > > > > > > > > > > >   ima_check_last_writer security/integrity/ima/=
ima_main.c:171
> > > > > > > > > > > > > > [inline]
> > > > > > > > > > > > > >   ima_file_free+0xbd/0x130 security/integrity/i=
ma/ima_main.c:203
> > > > > > > > > > > > > >   __fput+0xc7/0x220 fs/file_table.c:315
> > > > > > > > > > > > > >   task_work_run+0x7d/0xa0 kernel/task_work.c:17=
9
> > > > > > > > > > > > > >   exit_task_work include/linux/task_work.h:38 [=
inline]
> > > > > > > > > > > > > >   do_exit+0x2c7/0xa80 kernel/exit.c:871 <------=
-----------------
> > > > > > > > > > > > > >   do_group_exit+0x85/0xa0 kernel/exit.c:1021
> > > > > > > > > > > > > >   get_signal+0x73c/0x7f0 kernel/signal.c:2874
> > > > > > > > > > > > > >   arch_do_signal_or_restart+0x89/0x290 arch/x86=
/kernel/signal.c:306
> > > > > > > > > > > > > >   exit_to_user_mode_loop+0x61/0xb0 kernel/entry=
/common.c:168
> > > > > > > > > > > > > >   exit_to_user_mode_prepare+0x64/0xb0 kernel/en=
try/common.c:204
> > > > > > > > > > > > > >   __syscall_exit_to_user_mode_work kernel/entry=
/common.c:286 [inline]
> > > > > > > > > > > > > >   syscall_exit_to_user_mode+0x2b/0x1d0 kernel/e=
ntry/common.c:297
> > > > > > > > > > > > > >   do_syscall_64+0x4d/0x90 arch/x86/entry/common=
.c:86
> > > > > > > > > > > > > >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > do_exit has called exit_fs(tsk) [
> > > > > > > > > > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/sourc=
e/kernel/exit.c#L867 ]
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > exit_fs(tsk) has set tsk->fs =3D NULL [
> > > > > > > > > > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/sourc=
e/fs/fs_struct.c#L103
> > > > > > > > > > > > > > ]
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think this then bites in d_path() where it ca=
lls:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >      get_fs_root_rcu(current->fs, &root);   [
> > > > > > > > > > > > > > https://elixir.bootlin.com/linux/v6.4-rc2/sourc=
e/fs/d_path.c#L285 ]
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > current->fs is likely NULL here.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > If this was correct it would have nothing to do=
 with the actual
> > > > > > > > > > > > > > patch,
> > > > > > > > > > > > > > though, but rather with the fact that smack log=
s on process
> > > > > > > > > > > > > > termination. I am not sure what the solution wo=
uld be other than
> > > > > > > > > > > > > > testing for current->fs =3D=3D NULL in d_path b=
efore using it and
> > > > > > > > > > > > > > returning an error that is not normally returne=
d or trying to
> > > > > > > > > > > > > > intercept this case in smack.
> > > > > > > > > > > > > I have now been able to recreate the syzbot issue=
 with the test
> > > > > > > > > > > > > program
> > > > > > > > > > > > > and the issue is exactly the one described here, =
current->fs =3D=3D NULL.
> > > > > > > > > > > > >
> > > > > > > > > > > > Earlier in this thread, Amir had a diagnosis that I=
MA is
> > > > > > > > > > > > inappropriately
> > > > > > > > > > > > trying to use f_path directly instead of using the =
helpers that are
> > > > > > > > > > > > friendly for stacking filesystems.
> > > > > > > > > > > >
> > > > > > > > > > > > https://lore.kernel.org/linux-fsdevel/CAOQ4uxgjnYye=
QL-LbS5kQ7+C0d6sjzKqMDWAtZW8cAkPaed6=3DQ@mail.gmail.com/
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > I'm not an IMA hacker so I'm not planning to roll a=
 fix here. Perhaps
> > > > > > > > > > > > someone on the IMA team could try this approach?
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I have applied this patch here from Amir now and it d=
oes NOT resolve
> > > > > > > > > > > the issue:
> > > > > > > > > > >
> > > > > > > > > > > https://lore.kernel.org/linux-integrity/296dae962a2a4=
88bde682d3def074db91686e1c3.camel@linux.ibm.com/T/#m4ebdb780bf6952e7f210c55=
e87950d0cfa1d5eb0
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > This seems to resolve the issue:
> > > > > > > > > >
> > > > > > > > > > diff --git a/security/smack/smack_access.c
> > > > > > > > > > b/security/smack/smack_access.c
> > > > > > > > > > index 585e5e35710b..57afcea1e39b 100644
> > > > > > > > > > --- a/security/smack/smack_access.c
> > > > > > > > > > +++ b/security/smack/smack_access.c
> > > > > > > > > > @@ -347,6 +347,9 @@ void smack_log(char *subject_label,=
 char
> > > > > > > > > > *object_label, int request,
> > > > > > > > > >         struct smack_audit_data *sad;
> > > > > > > > > >         struct common_audit_data *a =3D &ad->a;
> > > > > > > > > >
> > > > > > > > > > +       if (current->flags & PF_EXITING)
> > > > > > > > > > +               return;
> > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > Based on what I see here I can understand that this preve=
nts the panic,
> > > > > > > > > but it isn't so clear what changed that introduced the pr=
oblem.
> > > > > > > > >
> > > > > > > > > >         /* check if we have to log the current event */
> > > > > > > > > >         if (result < 0 && (log_policy & SMACK_AUDIT_DEN=
IED) =3D=3D 0)
> > > > > > > > > >                 return;
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > >
> > > > > > > > Apparently, it's this patch:
> > > > > > > >
> > > > > > > >     db1d1e8b9867 IMA: use vfs_getattr_nosec to get the i_ve=
rsion
> > > > > > >
> > > > > > > Yes, the syzbot was updated with that info.
> > > > > > >
> > > > > > > > At one time, IMA would reach directly into the inode to get=
 the
> > > > > > > > i_version and ctime. That was fine for certain filesystems,=
 but with
> > > > > > > > more recent changes it needs to go through ->getattr instea=
d. Evidently,
> > > > > > > > it's selecting the wrong inode to query when dealing with o=
verlayfs and
> > > > > > > > that's causing panics at times.
> > > > > > > >
> > > > > > > > As to why the above patch helps, I'm not sure, but given th=
at it doesn't
> > > > > > > > seem to change which inode is being queried via getattr, it=
 seems like
> > > > > > > > this is probably papering over the real bug. That said, IMA=
 and
> > > > > > > > overlayfs are not really in my wheelhouse, so I could be ve=
ry wrong
> > > > > > > > here.
> > > > > > >
> > > > > > > The call to vfs_getattr_nosec() somehow triggers a call to
> > > > > > > security_inode_getattr().  Without the call neither ovl_getat=
tr() nor
> > > > > > > smack_inode_getattr() would be called.
> > > > > >
> > > > > > ima_file_free()
> > > > > > -> ima_check_last_writer()
> > > > > >    -> vfs_getattr_nosec()
> > > > > >       -> i_op->getattr() =3D=3D ovl_getattr()
> > > > > >          -> vfs_getattr()
> > > > > >             -> security_inode_getattr()
> > > > > >           -> real_i_op->getattr()
> > > > > >
> > > > > > is the callchain that triggers this.
> > > > >
> > > > > Thank you for the explanation as to why ovl_getattr() and subsequ=
ently
> > > > > smack_inode_getattr() is being called.
> > > > >
> > > > > >
> > > > > > ima_file_free() is called in a very sensitive location: __fput(=
) that
> > > > > > can be called from task work when the process is already PF_EXI=
TING.
> > > > > >
> > > > > > The ideal solution would be for ima to stop calling back into t=
he
> > > > > > filesystems in this location at all but that's probably not goi=
ng to
> > > > > > happen because I now realize you also set extended attributes f=
rom
> > > > > > __fput():
> > > > > >
> > > > > >
> > > > > > ima_check_last_writer()
> > > > > > -> ima_update_xatt()
> > > > > >    -> ima_fix_xattr()
> > > > > >       -> __vfs_setxattr_noperm()
> > > > > >
> > > > > > The __vfs_setxattr_noperm() codepath can itself trigger
> > > > > > security_inode_post_setxattr() and security_inode_setsecurity()=
. So
> > > > > > those hooks are hopefully safe to be called with PF_EXITING tas=
ks as
> > > > > > well...
> > > > > >
> > > > > > Imho, this is all very wild but I'm not judging.
> > > > >
> > > > > Measuring and verifying immutable files is straight forward.
> > > > > Measuring, verifiying, and updating mutable file hashes is a lot =
more
> > > > > complicated.  Re-calculating the file hash everytime the file cha=
nges
> > > > > would impact performance.  The file hash is currently updated as =
the
> > > > > last writer closes the file (__fput).  One of the reasons for the=
 wq
> > > > > was for IMA to safely calculate the file hash and and take the i_=
mutex
> > > > > to write the xattr.
> > > > >
> > > > > IMA support for mutable files makes IMA a lot more complicated.  =
Any
> > > > > improvement suggestions would be appreciated.
> > > > >
> > > > > >
> > > > > > Two solutions imho:
> > > > > > (1) teach stacking filesystems like overlayfs and ecryptfs to u=
se
> > > > > >     vfs_getattr_nosec() in their ->getattr() implementation whe=
n they
> > > > > >     are themselves called via vfs_getattr_nosec(). This will fi=
x this by
> > > > > >     not triggering another LSM hook.
> > > > > > (2) make all ->getattr() LSM hooks PF_EXITING safe ideally don'=
t do
> > > > > >     anything
> > > > >
> > > > > The original problem was detecting i_version change on overlayfs.
> > > > >
> > > > > Amir's proposed patch might resolve it without commit db1d1e8b986=
7
> > > > > ("IMA: use vfs_getattr_nosec to get the i_version").  However, as=
 Amir
> > > > > said, it does not address the new problem introduced by it.   Ass=
uming
> > > > > Amir's proposed patch resolves the original problem, an alternati=
ve
> > > > > solution would be to revert commit db1d1e8b9867.
> > > > >
> > > >
> > > > If you're going to revert that commit, then I'm wondering what you
> > > > intend to do instead. Reaching directly into the inode to get this
> > > > information is really no bueno.
> > >
> > > IMA detecting file change based on i_version has been there since IMA
> > > was upstreamed.   Please explain why this is not a good idea.
> > >
> >
> > Not all i_version values are managed in the same way. Network
> > filesystems need to pass through the value from the server, whereas wit=
h
> > a local filesystems the kernel needs to manage the increment.
> >
> > IMA is mostly interested in local filesystems at the moment. The main
> > kernel-managed versions in the kernel are in btrfs, ext4 and xfs and
> > tmpfs. Until recently, only btrfs had one that functioned properly. Bot=
h
> > ext4 and xfs would also increment their values on atime updates. In
> > practical terms, this means that IMA ends up doing unnecessary
> > remeasurements after read events in some cases.
> >
> > ext4 recently had its i_version value fixed to not do this, but the XFS
> > developers are unable to fix theirs to avoid incrementing on atime
> > updates. For that, I'm working on the multigrain ctime patches which
> > should allow XFS to fake up a STATX_CHANGE_COOKIE in its getattr
> > routine.
> >
> > IMA has no practical way to tell what the filesystem can do if it's
> > groveling around inside struct inode, which is why I recommended using
> > vfs_getattr_nosec to grab this info. If that's problematic then by all
> > means, back out that patch, but you'll need to come up with some way to
> > deal with the different nuances of the different i_version counters in
> > across different filesystems.
>
> Got it.  This is basically a performance issue, because i_version is
> being updated too frequently on some filesystems.  It's not an issue of
> missing measurements or not re-evaluting the file's integrity when
> needed.
>
> Let's see if Amir's patch actually fixes the original problem before
> making any decisions.  (Wishing for a reproducer of the original
> problem.)
>

Confused. What is the "original problem"?
I never claimed that my patch fixes the "original problem".
I claimed [1] that my patch fixes a problem that existed before
db1d1e8b9867, but db1d1e8b9867 added two more instances
of that bug (wrong dereference of file->f_path).
Apparently, db1d1e8b9867 introduced another bug.

It looks like you should revert db1d1e8b9867, but regardless,
I recommend that you apply my patch. My patch conflicts
with the revert but the conflict is trivial - the two hunks that
fix the new vfs_getattr_nosec() calls are irrelevant - the rest are.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20230913073755.3489676-1-amir73il=
@gmail.com/
