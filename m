Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C2958673E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 12:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiHAKMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 06:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiHAKL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:11:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C4713D19
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 03:11:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f5so6606413eje.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 03:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qakRAL0moGy6LC5lZbzi8mYxcyogjmv7jaaHlcPNQPk=;
        b=SWtf6n1ZwjLhTo7KKf4l3lHpJflfRTY4cvvRG+EJ98hb/QLoch18sXRaImb51k9f1g
         INEnOIwBuaQMglubunVidyxUzyQRtOpn9ACYeDtPXQ/XHvjBMqBe/71l/Yn5VMKuecPS
         ZtSibqPoIUAAe8Dc+iWLTdogmIJ2iB7TpCNSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qakRAL0moGy6LC5lZbzi8mYxcyogjmv7jaaHlcPNQPk=;
        b=szjfw+xoBD2IVcD8yOdcSv3KpAAghQPps5Z9ErH8fMs54Tr2FYgC5BJls0k+4DqVSH
         eu1Vl51vb8HreseU8F+ztE6sMBrI/OajgJP7jfwnGeEotK/dVKQ/8euvgWeWz/wqvWDX
         Rc8kn7LbsQJ0oaxgd2Sz/kvZ2qg5t35niEaMVU9MkU+qNmP6MM+dwad4sJ50aLBVN5+L
         2cBj5P3zuj/WK6HMahTs2+PeXOqyASnB/hnsWAxSIMNG87fBJpK24CWynWU1OOo7WRwY
         Zq5/6kovH+kG9yDrA4nObGk4mFyY3XiJsLtbakmaNjTUpZv3hikoPpmPkAHnSYWMItcz
         BOyA==
X-Gm-Message-State: AJIora+4adMqSz8w5npWH6ad5uM0FmthvGOWEa9iXW7JLQgzV7jotkYp
        lOGxvXim5QDAO1fFStlD8rQbun2ptsLD7zGzJft/mw==
X-Google-Smtp-Source: AGRyM1uoMbQGsjwGq1y1Ki6YC7R+vpfL/RygWNOHkZFgSYaOxQ6zd5do+4sz5JCGFx2q6no8HSEU3PciQahU9zbGGIA=
X-Received: by 2002:a17:907:75f1:b0:72b:9e40:c1a9 with SMTP id
 jz17-20020a17090775f100b0072b9e40c1a9mr11612515ejc.523.1659348715959; Mon, 01
 Aug 2022 03:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bdee330594070441@google.com> <000000000000b901a205e51b4f46@google.com>
In-Reply-To: <000000000000b901a205e51b4f46@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 1 Aug 2022 12:11:44 +0200
Message-ID: <CAJfpeguM-DdeAL3cSJB3csD6VcaqQRiSmHvwPicQpKL5Wu6QLQ@mail.gmail.com>
Subject: Re: [syzbot] memory leak in cap_inode_getsecurity
To:     syzbot <syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        marka@mediation.com, phind.uet@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="000000000000c62b3a05e52b3a8a"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000c62b3a05e52b3a8a
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

On Sun, 31 Jul 2022 at 17:13, syzbot
<syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    6a010258447d Merge tag 'for-linus' of git://git.armlinux.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15883fee080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2a1dcc1942e30704
> dashboard link: https://syzkaller.appspot.com/bug?extid=942d5390db2d9624ced8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1568846a080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f5e536080000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
>
> executing program
> BUG: memory leak
> unreferenced object 0xffff88810f0ac060 (size 32):
>   comm "syz-executor240", pid 3622, jiffies 4294961303 (age 14.040s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814c6ecd>] __do_krealloc mm/slab_common.c:1185 [inline]
>     [<ffffffff814c6ecd>] krealloc+0x4d/0xb0 mm/slab_common.c:1218
>     [<ffffffff8162625c>] vfs_getxattr_alloc+0x13c/0x1c0 fs/xattr.c:379
>     [<ffffffff822374b2>] cap_inode_getsecurity+0xb2/0x500 security/commoncap.c:400
>     [<ffffffff8223d88c>] security_inode_getsecurity+0x7c/0xb0 security/security.c:1441
>     [<ffffffff81625a0a>] xattr_getsecurity fs/xattr.c:327 [inline]
>     [<ffffffff81625a0a>] vfs_getxattr+0x22a/0x290 fs/xattr.c:423
>     [<ffffffff81c0ab02>] ovl_xattr_get+0x62/0xa0 fs/overlayfs/inode.c:404
>     [<ffffffff81624742>] __vfs_getxattr+0x72/0xa0 fs/xattr.c:401
>     [<ffffffff82236f52>] cap_inode_need_killpriv+0x22/0x40 security/commoncap.c:301
>     [<ffffffff8223d773>] security_inode_need_killpriv+0x23/0x60 security/security.c:1419
>     [<ffffffff8161074e>] dentry_needs_remove_privs fs/inode.c:1992 [inline]
>     [<ffffffff8161074e>] dentry_needs_remove_privs+0x4e/0xa0 fs/inode.c:1982
>     [<ffffffff815cfead>] do_truncate+0x7d/0x130 fs/open.c:57
>     [<ffffffff815d0169>] vfs_truncate+0x209/0x240 fs/open.c:111
>     [<ffffffff815d0268>] do_sys_truncate.part.0+0xc8/0xe0 fs/open.c:134
>     [<ffffffff815d0303>] do_sys_truncate fs/open.c:128 [inline]
>     [<ffffffff815d0303>] __do_sys_truncate fs/open.c:146 [inline]
>     [<ffffffff815d0303>] __se_sys_truncate fs/open.c:144 [inline]
>     [<ffffffff815d0303>] __x64_sys_truncate+0x33/0x50 fs/open.c:144
>     [<ffffffff845b1955>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845b1955>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>

--000000000000c62b3a05e52b3a8a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fix-leak-in-cap_inode_getsecurity.patch"
Content-Disposition: attachment; 
	filename="fix-leak-in-cap_inode_getsecurity.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l6al582o0>
X-Attachment-Id: f_l6al582o0

LS0tCiBzZWN1cml0eS9jb21tb25jYXAuYyB8ICAgMTggKysrKysrKysrKy0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCi0tLSBhL3NlY3Vy
aXR5L2NvbW1vbmNhcC5jCisrKyBiL3NlY3VyaXR5L2NvbW1vbmNhcC5jCkBAIC00MDEsOCArNDAx
LDggQEAgaW50IGNhcF9pbm9kZV9nZXRzZWN1cml0eShzdHJ1Y3QgdXNlcl9uYQogCQkJCSAgICAg
ICZ0bXBidWYsIHNpemUsIEdGUF9OT0ZTKTsKIAlkcHV0KGRlbnRyeSk7CiAKLQlpZiAocmV0IDwg
MCB8fCAhdG1wYnVmKQotCQlyZXR1cm4gcmV0OworCWlmIChyZXQgPCAwKQorCQlnb3RvIG91dF9m
cmVlOwogCiAJZnNfbnMgPSBpbm9kZS0+aV9zYi0+c191c2VyX25zOwogCWNhcCA9IChzdHJ1Y3Qg
dmZzX2NhcF9kYXRhICopIHRtcGJ1ZjsKQEAgLTQxMiw3ICs0MTIsNyBAQCBpbnQgY2FwX2lub2Rl
X2dldHNlY3VyaXR5KHN0cnVjdCB1c2VyX25hCiAJCW5zY2FwID0gKHN0cnVjdCB2ZnNfbnNfY2Fw
X2RhdGEgKikgdG1wYnVmOwogCQlyb290ID0gbGUzMl90b19jcHUobnNjYXAtPnJvb3RpZCk7CiAJ
fSBlbHNlIHsKLQkJc2l6ZSA9IC1FSU5WQUw7CisJCXJldCA9IC1FSU5WQUw7CiAJCWdvdG8gb3V0
X2ZyZWU7CiAJfQogCkBAIC00MzEsNyArNDMxLDcgQEAgaW50IGNhcF9pbm9kZV9nZXRzZWN1cml0
eShzdHJ1Y3QgdXNlcl9uYQogCQkJCS8qIHYyIC0+IHYzIGNvbnZlcnNpb24gKi8KIAkJCQluc2Nh
cCA9IGt6YWxsb2Moc2l6ZSwgR0ZQX0FUT01JQyk7CiAJCQkJaWYgKCFuc2NhcCkgewotCQkJCQlz
aXplID0gLUVOT01FTTsKKwkJCQkJcmV0ID0gLUVOT01FTTsKIAkJCQkJZ290byBvdXRfZnJlZTsK
IAkJCQl9CiAJCQkJbnNtYWdpYyA9IFZGU19DQVBfUkVWSVNJT05fMzsKQEAgLTQ0NywxMSArNDQ3
LDExIEBAIGludCBjYXBfaW5vZGVfZ2V0c2VjdXJpdHkoc3RydWN0IHVzZXJfbmEKIAkJCW5zY2Fw
LT5yb290aWQgPSBjcHVfdG9fbGUzMihtYXBwZWRyb290KTsKIAkJCSpidWZmZXIgPSBuc2NhcDsK
IAkJfQotCQlnb3RvIG91dF9mcmVlOworCQlnb3RvIHN1Y2Nlc3M7CiAJfQogCiAJaWYgKCFyb290
aWRfb3duc19jdXJyZW50bnMoa3Jvb3QpKSB7Ci0JCXNpemUgPSAtRU9WRVJGTE9XOworCQlyZXQg
PSAtRU9WRVJGTE9XOwogCQlnb3RvIG91dF9mcmVlOwogCX0KIApAQCAtNDYyLDcgKzQ2Miw3IEBA
IGludCBjYXBfaW5vZGVfZ2V0c2VjdXJpdHkoc3RydWN0IHVzZXJfbmEKIAkJCS8qIHYzIC0+IHYy
IGNvbnZlcnNpb24gKi8KIAkJCWNhcCA9IGt6YWxsb2Moc2l6ZSwgR0ZQX0FUT01JQyk7CiAJCQlp
ZiAoIWNhcCkgewotCQkJCXNpemUgPSAtRU5PTUVNOworCQkJCXJldCA9IC1FTk9NRU07CiAJCQkJ
Z290byBvdXRfZnJlZTsKIAkJCX0KIAkJCW1hZ2ljID0gVkZTX0NBUF9SRVZJU0lPTl8yOwpAQCAt
NDc3LDkgKzQ3NywxMSBAQCBpbnQgY2FwX2lub2RlX2dldHNlY3VyaXR5KHN0cnVjdCB1c2VyX25h
CiAJCX0KIAkJKmJ1ZmZlciA9IGNhcDsKIAl9CitzdWNjZXNzOgorCXJldCA9IHNpemU7CiBvdXRf
ZnJlZToKIAlrZnJlZSh0bXBidWYpOwotCXJldHVybiBzaXplOworCXJldHVybiByZXQ7CiB9CiAK
IC8qKgo=
--000000000000c62b3a05e52b3a8a--
