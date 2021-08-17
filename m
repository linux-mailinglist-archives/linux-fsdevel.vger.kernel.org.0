Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791403EEEA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbhHQOmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbhHQOl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:41:59 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A19C0613C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 07:41:26 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id f25so9096614uam.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQwGdMgVEaQNJoD4ayZe6Ia9R4DXPOPGO8jj9i6jzG8=;
        b=JfkCT5LcQwymPexJ3rri9V1b7/8W7+6cZ2TPDP3G56sIndIly+cv1ITWv06B+29dWp
         nxGKkMsD/54xtZuzkEMxkwZ4Tn8Qf+tYIx8nlB/K1L8r8vjUw0JZymYNwMT+0kKghSr2
         xo5BATHLWEsOgi0mMXsZ0GLawKjfQ0Mx+v4jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQwGdMgVEaQNJoD4ayZe6Ia9R4DXPOPGO8jj9i6jzG8=;
        b=Ti79HNcfi7vgzZPPN7If4fCOnEVknYAviHtGpBk5qNCFDdATppD2fCT3L1GZEHWif9
         vHkpSGAB5L1HSriQ5fqZhwlU2FtlAWDjtaEA6WEg28nIZ0+S/Vp09L2s2s46mQJPvTUY
         4M8ads5MzxLB9aDfiB+/2iFl43axCN1fSTgx6uokpivXaItBaOpb5bdvxfAycwIb2k2S
         MyLKlSzghj4jgoQf3i47n8MnThSLQi2gNiLs4jDB+x4DZL9trS+7alEjoDcMUJKeAHxm
         012X6NTQ0EIF2W9/NM+BQEfIWREdEPLFulMtCcXtGoK/GDPCk2hdFL7GRO8TkSXdG3hM
         gMYQ==
X-Gm-Message-State: AOAM532ru91/Pz0TfIyB9UYi7FOYZgz+FS507FNE63h07BdBNS1nF7Wj
        hXY2h/J69Rn+WyVwa4fnduIQ6RJMPCjGuGKwu0Oi6Q==
X-Google-Smtp-Source: ABdhPJysBWxtPlX5YvPZA91uytNRqo+W86z7uuA4hyfdvyyDciZUbpmwA+HL/8yFzbIW4yxM7a7EfAROBM/g8i8ZZ7U=
X-Received: by 2002:ab0:36ae:: with SMTP id v14mr2593917uat.8.1629211285895;
 Tue, 17 Aug 2021 07:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007fcee205c970a843@google.com>
In-Reply-To: <0000000000007fcee205c970a843@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Aug 2021 16:41:14 +0200
Message-ID: <CAJfpegv1ztaEvrSX622ru-FRX1VJYZDbRWq6_4HhF0tCY+0uHQ@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in fuse_launder_page
To:     syzbot <syzbot+bea44a5189836d956894@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000f5eae105c9c24f80"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000f5eae105c9c24f80
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Aug 2021 at 15:16, syzbot
<syzbot+bea44a5189836d956894@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    36a21d51725a Linux 5.14-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=104b8eaa300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3a20bae04b96ccd
> dashboard link: https://syzkaller.appspot.com/bug?extid=bea44a5189836d956894
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143c0ee9300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158fc9aa300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bea44a5189836d956894@syzkaller.appspotmail.com
>
> INFO: task syz-executor276:8433 blocked for more than 143 seconds.
>       Not tainted 5.14.0-rc5-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor276 state:D stack:27736 pid: 8433 ppid:  8430 flags:0x00004004
> Call Trace:
>  context_switch kernel/sched/core.c:4681 [inline]
>  __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
>  schedule+0xd3/0x270 kernel/sched/core.c:6017
>  fuse_wait_on_page_writeback fs/fuse/file.c:452 [inline]
>  fuse_wait_on_page_writeback+0x120/0x170 fs/fuse/file.c:448
>  fuse_launder_page fs/fuse/file.c:2316 [inline]
>  fuse_launder_page+0xe9/0x130 fs/fuse/file.c:2306
>  do_launder_page mm/truncate.c:595 [inline]
>  invalidate_inode_pages2_range+0x994/0xf80 mm/truncate.c:661
>  fuse_finish_open+0x2d9/0x560 fs/fuse/file.c:202
>  fuse_open_common+0x2f9/0x4c0 fs/fuse/file.c:254
>  do_dentry_open+0x4c8/0x11d0 fs/open.c:826
>  do_open fs/namei.c:3374 [inline]
>  path_openat+0x1c23/0x27f0 fs/namei.c:3507
>  do_filp_open+0x1aa/0x400 fs/namei.c:3534
>  do_sys_openat2+0x16d/0x420 fs/open.c:1204
>  do_sys_open fs/open.c:1220 [inline]
>  __do_sys_creat fs/open.c:1294 [inline]
>  __se_sys_creat fs/open.c:1288 [inline]
>  __x64_sys_creat+0xc9/0x120 fs/open.c:1288
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x446409
> RSP: 002b:00007f0e6a9f92f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 00000000004d34f0 RCX: 0000000000446409
> RDX: 0000000000446409 RSI: 0000000000000000 RDI: 0000000020000280
> RBP: 00000000004a3164 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
> R13: 000000000049f158 R14: 00000000004a1160 R15: 00000000004d34f8

Attached patch should fix this.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

--000000000000f5eae105c9c24f80
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-truncate-pagecache-on-atomic_o_trunc.patch"
Content-Disposition: attachment; 
	filename="fuse-truncate-pagecache-on-atomic_o_trunc.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ksg69glp0>
X-Attachment-Id: f_ksg69glp0

LS0tCiBmcy9mdXNlL2ZpbGUuYyB8ICAgIDcgKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCi0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2Zz
L2Z1c2UvZmlsZS5jCkBAIC0xOTgsMTIgKzE5OCwxMSBAQCB2b2lkIGZ1c2VfZmluaXNoX29wZW4o
c3RydWN0IGlub2RlICppbm9kCiAJc3RydWN0IGZ1c2VfZmlsZSAqZmYgPSBmaWxlLT5wcml2YXRl
X2RhdGE7CiAJc3RydWN0IGZ1c2VfY29ubiAqZmMgPSBnZXRfZnVzZV9jb25uKGlub2RlKTsKIAot
CWlmICghKGZmLT5vcGVuX2ZsYWdzICYgRk9QRU5fS0VFUF9DQUNIRSkpCi0JCWludmFsaWRhdGVf
aW5vZGVfcGFnZXMyKGlub2RlLT5pX21hcHBpbmcpOwogCWlmIChmZi0+b3Blbl9mbGFncyAmIEZP
UEVOX1NUUkVBTSkKIAkJc3RyZWFtX29wZW4oaW5vZGUsIGZpbGUpOwogCWVsc2UgaWYgKGZmLT5v
cGVuX2ZsYWdzICYgRk9QRU5fTk9OU0VFS0FCTEUpCiAJCW5vbnNlZWthYmxlX29wZW4oaW5vZGUs
IGZpbGUpOworCiAJaWYgKGZjLT5hdG9taWNfb190cnVuYyAmJiAoZmlsZS0+Zl9mbGFncyAmIE9f
VFJVTkMpKSB7CiAJCXN0cnVjdCBmdXNlX2lub2RlICpmaSA9IGdldF9mdXNlX2lub2RlKGlub2Rl
KTsKIApAQCAtMjExLDEwICsyMTAsMTQgQEAgdm9pZCBmdXNlX2ZpbmlzaF9vcGVuKHN0cnVjdCBp
bm9kZSAqaW5vZAogCQlmaS0+YXR0cl92ZXJzaW9uID0gYXRvbWljNjRfaW5jX3JldHVybigmZmMt
PmF0dHJfdmVyc2lvbik7CiAJCWlfc2l6ZV93cml0ZShpbm9kZSwgMCk7CiAJCXNwaW5fdW5sb2Nr
KCZmaS0+bG9jayk7CisJCXRydW5jYXRlX3BhZ2VjYWNoZShpbm9kZSwgMCk7CiAJCWZ1c2VfaW52
YWxpZGF0ZV9hdHRyKGlub2RlKTsKIAkJaWYgKGZjLT53cml0ZWJhY2tfY2FjaGUpCiAJCQlmaWxl
X3VwZGF0ZV90aW1lKGZpbGUpOworCX0gZWxzZSBpZiAoIShmZi0+b3Blbl9mbGFncyAmIEZPUEVO
X0tFRVBfQ0FDSEUpKSB7CisJCWludmFsaWRhdGVfaW5vZGVfcGFnZXMyKGlub2RlLT5pX21hcHBp
bmcpOwogCX0KKwogCWlmICgoZmlsZS0+Zl9tb2RlICYgRk1PREVfV1JJVEUpICYmIGZjLT53cml0
ZWJhY2tfY2FjaGUpCiAJCWZ1c2VfbGlua193cml0ZV9maWxlKGZpbGUpOwogfQo=
--000000000000f5eae105c9c24f80--
