Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F4FB8D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 20:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKMT3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 14:29:01 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:51903 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfKMT3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:29:01 -0500
Received: by mail-io1-f69.google.com with SMTP id v14so2303000iob.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 11:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Vq9AmQFAWjANpkLSXn1UHJxF9GMEPoT07hbuuO8TH2k=;
        b=KjqY+gRb4KEtz5Pvv0XF/oMs3Lj59M2/mXyMhzOvo7r4y3Y2UjwUVgKUHgJUGuQQQy
         lk6WZm1T2JDCSjeUrJQmXJcj6Sk8waOjHE47BkwA987vXMcB9XQ2d2VtlfeVP3gceN00
         6g4tenrATzaSKm5XIa9YTJXddwaq5IJW9vf+jRS21KYLOUUlG44iEUCMeANcAK0X1ZQf
         cAgyrKVRfSru9ICUMQvWjqitLBHCWS94WzwPn0OXzJp7NyLrbPA1L5W3GkSYN2gBm4Q4
         d18oVqicHJ+71nxjzDHf1kkyReqP93VSvjD/1C6gk64DIh0u0byruJ9GUu+jeeGmGzI6
         /mag==
X-Gm-Message-State: APjAAAXwfq4oeBE8v2jtZCfH6TVnALYzwRDIWXWuLw1vUcpwbzePp7Ik
        ogkz0ZA2J5P9c4QvRV+8QV6xaYOpF0ypKupFGUWsBB1U2a9C
X-Google-Smtp-Source: APXvYqxYJ6dFAWRGXWIFkalwkp6O7/N3QafXX2n/eN0sV1s7imfVqRwzdni678vR3BjKeJq+wc64m4DR6PP6wl4S1UDWQ9YBHiIf
MIME-Version: 1.0
X-Received: by 2002:a02:58c8:: with SMTP id f191mr4260216jab.94.1573673340590;
 Wed, 13 Nov 2019 11:29:00 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:29:00 -0800
In-Reply-To: <000000000000af7e9805973c6356@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075646805973f60b5@google.com>
Subject: Re: general protection fault in io_commit_cqring
From:   syzbot <syzbot+21147d79607d724bd6f3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 1d7bb1d50fb4dc141c7431cc21fdd24ffcc83c76
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Nov 6 18:31:17 2019 +0000

     io_uring: add support for backlogged CQ ring

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a49802e00000
start commit:   4e8f108c Add linux-next specific files for 20191113
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15a49802e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a49802e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ace1bcdd76242fd2
dashboard link: https://syzkaller.appspot.com/bug?extid=21147d79607d724bd6f3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1649e706e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11397f72e00000

Reported-by: syzbot+21147d79607d724bd6f3@syzkaller.appspotmail.com
Fixes: 1d7bb1d50fb4 ("io_uring: add support for backlogged CQ ring")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
