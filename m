Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC18454038
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 06:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhKQFfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 00:35:08 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:35692 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhKQFfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:35:08 -0500
Received: by mail-io1-f72.google.com with SMTP id x11-20020a0566022c4b00b005e702603028so751330iov.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 21:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=U6kTvO9Oiv+XnDndGB5oJ6WC1Ug39q+jw5GcZf9PM5o=;
        b=Zwb50GXBOfqaZukPD7VSdTUHpSF2dsJzFsssN8LEm/NigI2FsvM3p8ER/YihXq+HTn
         OsqunWY0V3mLHJbNOaDSJ04dVecjefbW+luKDoSZysAyxrIkpy1EJ8ACGNbCkaoIjAXV
         MLFSUsqdocd+YXriHBTmJyMJeODZvvI1ckVrMgDX1Rl5XvZJdwYmNa2+sm3ftITAT3e5
         ARd2wHOVNRP6zoa6YjKL26IxEYq/zJ7L6VBoqpBi3+CBpUEur3WnM4uxUNFuIu1Yn0ip
         R1t3rgBJHblbFFulQfJ+mPeMMDUBkJ07ukRetzTXsRwrUGfI2lvnbx2hw8qTuS0iqudk
         iL+g==
X-Gm-Message-State: AOAM531ALxgAZ2VhaGVweq3kCspA7ULSFqgl6lf952AbKrYtV0SDa+qO
        5bDnrnVwLbAqhiVpe4tUxkCU3MiaqoONTUwCKBZ92ueP6DoX
X-Google-Smtp-Source: ABdhPJzNTw5YFfZ2o6POW9r7JpKSV/vb4VbOqP26VotgSBS9PYUKclMMIt7aM0nI2J0pC7i+O6r7kqBY+dZvlXu0kzD32nLvQmVL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2f:: with SMTP id e15mr6505013ilu.167.1637127129837;
 Tue, 16 Nov 2021 21:32:09 -0800 (PST)
Date:   Tue, 16 Nov 2021 21:32:09 -0800
In-Reply-To: <000000000000c93bd505bf3646ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006b5b205d0f55d49@google.com>
Subject: Re: [syzbot] WARNING in inc_nlink (2)
From:   syzbot <syzbot+1c8034b9f0e640f9ba45@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 97f044f690bac2b094bfb7fb2d177ef946c85880
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri Oct 22 15:03:02 2021 +0000

    fuse: don't increment nlink in link()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10563ac9b00000
start commit:   1da38549dd64 Merge tag 'nfsd-5.15-3' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2ffb281e6323643
dashboard link: https://syzkaller.appspot.com/bug?extid=1c8034b9f0e640f9ba45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f16d57300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15758d57300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fuse: don't increment nlink in link()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
