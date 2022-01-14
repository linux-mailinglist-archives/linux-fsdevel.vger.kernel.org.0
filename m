Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3480448E265
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 03:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiANCJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 21:09:08 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:38439 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbiANCJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:09:08 -0500
Received: by mail-il1-f200.google.com with SMTP id h11-20020a92c26b000000b002b4a32c0ee3so5190503ild.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jan 2022 18:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=l+R7nWMxKcU084x0V/7GNQbj65lf2ts3dJyo3gy3f6s=;
        b=Ji5MNXzPL1QyM0SXqCEs5GEZxKWswNNvY2FQnvj1E/Hp7FRUokfcNZNJwo4PgShz0Z
         qGKsPIvkV35v4cyPRUL6U8g1PrldPGc6jxogMutjwCp8LA3wVxogYeOyH0tMwx6hFXoq
         UYrdl6d5kFJUufZ5uhZShO6UQA6RnbZpQa9+tgSiYKVc23q1iPs+DztRGOC00NqQeC+b
         M7o8ak5NWz9XfY8FOV3PASEY5fLvp6sysmoW9yxYTIZmMpl0noetziJX12bEXlK0NFPp
         oj42vi56qNej0pAlqOGC1BEO4i5B6UDCwDOjqTSTXzVAiPZXE+M9SCYjY+kOtTra825z
         Rtyw==
X-Gm-Message-State: AOAM532/MbcSP9SaNuexBZtP8fv+4BIbToP0Ek1z3WLaY0Bzy/6j1enD
        6WGj+S88hbNpIh2UTpP7a48W9+4n5Me/IWusLoDSnZbmEL+M
X-Google-Smtp-Source: ABdhPJybKJOsrE+8Vo8gzVZrp2mTACAvXMUTRVRTzELPcrK9to/GJshkwEJEUMZmSYSGqFeYj8NqLtMD/0Cl7x2d2cUB4f5x7AlY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:: with SMTP id s14mr4007528ilu.0.1642126147538;
 Thu, 13 Jan 2022 18:09:07 -0800 (PST)
Date:   Thu, 13 Jan 2022 18:09:07 -0800
In-Reply-To: <998e645c-b300-9e58-eb02-3005667dcfe2@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b355a205d58149fd@google.com>
Subject: Re: [syzbot] WARNING in signalfd_cleanup
From:   syzbot <syzbot+5426c7ed6868c705ca14@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, changbin.du@intel.com,
        daniel@iogearbox.net, davem@davemloft.net, ebiggers@kernel.org,
        edumazet@google.com, hkallweit1@gmail.com,
        io-uring@vger.kernel.org, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, yajun.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5426c7ed6868c705ca14@syzkaller.appspotmail.com

Tested on:

commit:         59fb37ef io_uring: pollfree
git tree:       https://github.com/isilence/linux.git pollfree_test1
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aaa2946b030309
dashboard link: https://syzkaller.appspot.com/bug?extid=5426c7ed6868c705ca14
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
