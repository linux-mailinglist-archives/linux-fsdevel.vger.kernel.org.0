Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74372870E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgJHIoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 04:44:08 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:52888 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHIoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:44:08 -0400
Received: by mail-il1-f206.google.com with SMTP id m1so3561785iln.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 01:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6MwKd6ECqXO02glRpdlbEwUDApjYJYWG4NqQdqBh3uA=;
        b=eOoMPuX1yC9QzhsSxw8ivwFCBv2FXpyjc1of7tqDM8MpBtE7R4qc7Q30Db7XiAyoXp
         n9my08oAYYlk5ShnQFuhYpGHPoeCJDXC2aPNbU3gFGIgqF5aLLVKIhlo97D4aJBXsRqb
         fPhYg1LhfYRc/qp5/6DDybcMRHjajM3wzNu45UpRXLDZc/DHYbLa+UiJx57IsgMVcOyy
         0wOtS2VCKt/UHO1a8nFZu7WQVlnbX0AOQo9SG38CRUZXbgJ2Zl/XzV27eAttfSFNURfv
         TMbnUyLxfuHO3KcuOkBrFkClCXZvGc4b0p8Hk+M77APqvpzgWhnq2EUFvrBdj7oKXrMz
         ZWaQ==
X-Gm-Message-State: AOAM5331TfrZvXIK11DbzT9KUYJRg/pL8feQpwg52bXTW3NK6DH4FbVV
        ILzvaaNv4Br2ywYRUn/zN/cDzJH/9sfB9xivrnMwgptDYy/Q
X-Google-Smtp-Source: ABdhPJwe9yGzWtEyp2QVuKoHI7i5uX++AtNA/6JCwRa0wbYTKjpni0vLIZXpzGGh3imciRcuugLUvK3o2lB6t1c1Z1qEMdkQi8ka
MIME-Version: 1.0
X-Received: by 2002:a02:a10f:: with SMTP id f15mr5972131jag.62.1602146647376;
 Thu, 08 Oct 2020 01:44:07 -0700 (PDT)
Date:   Thu, 08 Oct 2020 01:44:07 -0700
In-Reply-To: <0000000000006226c805adf16cb8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb8c0605b124d53c@google.com>
Subject: Re: WARNING: ODEBUG bug in exit_to_user_mode_prepare
From:   syzbot <syzbot+fbd7ba7207767ed15165@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bfoster@redhat.com, darrick.wong@oracle.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 9c516e0e4554e8f26ab73d46cbc789d7d8db664d
Author: Brian Foster <bfoster@redhat.com>
Date:   Tue Aug 18 15:05:58 2020 +0000

    xfs: finish dfops on every insert range shift iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157f71e0500000
start commit:   dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=fbd7ba7207767ed15165
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1447c115900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1344f9fe900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: finish dfops on every insert range shift iteration

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
