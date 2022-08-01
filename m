Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1053B586B02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 14:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiHAMmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 08:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiHAMmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:42:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B376359
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 05:20:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sz17so19973156ejc.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKODFjWKz18z//+0bYIp+DNibtoqLeqcY5uwUnn/wX8=;
        b=O9qyvyo1A15bIG2D4Q6YtOGekPzpr15IaV7tjs8+IuxT5Fb1erc4U3WXQnbwIm6guW
         3JBREcLr3QxGSAGL/M5WZxQ/joqw/dnpZOyKjgf+dnb+yUiS3H/01H2C94ZQzItpeW5g
         vL8QBmcRtcdvTBmHM/wu0YaXeP65LvQSVjjbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKODFjWKz18z//+0bYIp+DNibtoqLeqcY5uwUnn/wX8=;
        b=6tyN75V1KQACTZqogRyGuIFsz5l6inNak0q8583hFamk71/vFO0fkaYu3anUUyAGhb
         GpqpCpsYRyUrwT2QQFqMaX062z1xMxr3nq2HfSDwtY0hTP/wuPB6DzyjO945EuJ6/aGa
         jCdiBQ+Gtp33exHd5bFNmLAxrxmorRz8yn5Srl3g5h6JS5yGdkqG6UsXfhjAzIquVS/h
         rFeC6XKsj4iJOSE6+9ijULwumUYwSn3AtZx3jYObGocTB510Dw0X9mPIefiS4kE61T3d
         Jq7rp1t/xwCA9GsNj8igKabyUzd2mus8lkXkL0xt28sbU4hWH8Hbol5keNIVuUYxZ3x/
         go7A==
X-Gm-Message-State: AJIora9hipgSPLfzYJ2ef6VINXO028CrkzMvaarJ76yOyfzwcpX6QdVT
        RYP5ajYEOW2dpVrXiFJkzguvNG5RMxEbk3MGr1mEFw==
X-Google-Smtp-Source: AGRyM1u5heZFAPEHD8eBUI8/c302XJxQSVoi2SW0DyFizv5U/QC+DVZDbgBZl8aylVPe5gaJudxteft3RHjrHSebHWY=
X-Received: by 2002:a17:907:2855:b0:72b:700e:21eb with SMTP id
 el21-20020a170907285500b0072b700e21ebmr12643849ejc.270.1659356440144; Mon, 01
 Aug 2022 05:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bdee330594070441@google.com> <000000000000b901a205e51b4f46@google.com>
In-Reply-To: <000000000000b901a205e51b4f46@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 1 Aug 2022 14:20:29 +0200
Message-ID: <CAJfpegvAPDA-kqCZ8OAqScwfgSoyh5RNQu3rg=LBh6+dFh0hEw@mail.gmail.com>
Subject: Re: [syzbot] memory leak in cap_inode_getsecurity
To:     syzbot <syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        marka@mediation.com, phind.uet@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="0000000000002beb1f05e52d073f"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000002beb1f05e52d073f
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

--0000000000002beb1f05e52d073f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="vfs_getxattr_alloc-dont-allocate-buf-on-failure.patch"
Content-Disposition: attachment; 
	filename="vfs_getxattr_alloc-dont-allocate-buf-on-failure.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l6apyd3r0>
X-Attachment-Id: f_l6apyd3r0

LS0tCiBmcy94YXR0ci5jIHwgICAgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKLS0tIGEvZnMveGF0dHIuYworKysgYi9mcy94YXR0ci5jCkBA
IC0zODMsNyArMzgzLDEwIEBAIHZmc19nZXR4YXR0cl9hbGxvYyhzdHJ1Y3QgdXNlcl9uYW1lc3Bh
Y2UKIAl9CiAKIAllcnJvciA9IGhhbmRsZXItPmdldChoYW5kbGVyLCBkZW50cnksIGlub2RlLCBu
YW1lLCB2YWx1ZSwgZXJyb3IpOwotCSp4YXR0cl92YWx1ZSA9IHZhbHVlOworCWlmIChlcnJvciA8
IDAgJiYgdmFsdWUgIT0gKnhhdHRyX3ZhbHVlKQorCQlrZnJlZSh2YWx1ZSk7CisJZWxzZQorCQkq
eGF0dHJfdmFsdWUgPSB2YWx1ZTsKIAlyZXR1cm4gZXJyb3I7CiB9CiAK
--0000000000002beb1f05e52d073f--
