Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA224A205
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHSOvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 10:51:11 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:50162 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgHSOvG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:51:06 -0400
Received: by mail-il1-f197.google.com with SMTP id b18so16895521ilh.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2020 07:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=L7T0UptgHYmri7SaCGXWygzaLJh2phRnY0wB5fixdgI=;
        b=CBiVK+JI1LBSSRD5CcS4Wc44SJeD9EF8bVffyqemPIMw01aC8bH66Lj92m7ZzlZi9X
         80EpcBn6GM+ZEOtuL5bOwsDt+yBV18qCDu9eWl8Q4YHqfdLtLG640I37/3vERKJQO01E
         A0rQ8NDmZA+Ei6v9bYi36WmIjVvYN/lr2WZOWxwz0y18K3t8OpwkvMfIa287WkHRx19j
         pEtwlSW7XyIfoP6uerdUik1Jn+8svTPfE1WMk03uQu0K2kQ1Cgr01aZeN7azlzPvviQm
         5F+DapKnEWy1+c5e6JAiFm/a0E20gSE7By8SvYJYPEisO5qQ506DmgqW6v2WRQbTafOU
         HvOg==
X-Gm-Message-State: AOAM531s5mU+nWhnEOwNME0qSpBV4meRuPt7ZzIGNY4Rnwy/IEPz/44P
        9GFhFo3c9Sn11NmDdjc54ngl5blXjS7tYl0l27oaiqY8uyhT
X-Google-Smtp-Source: ABdhPJw8Eul5BA7PMHLOe+q9UZT4RyJM5c/bIGJstDY4zpBDZ19RM9Uzxo9blXQp3uPwrJTIFVk3E4JNQ3rznpSbNdvNHR3LHUnk
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2417:: with SMTP id s23mr19902065ioa.94.1597848665416;
 Wed, 19 Aug 2020 07:51:05 -0700 (PDT)
Date:   Wed, 19 Aug 2020 07:51:05 -0700
In-Reply-To: <000000000000568fc005ad3b57c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b6bb205ad3c222b@google.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free (4)
From:   syzbot <syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 449325b52b7a6208f65ed67d3484fd7b7184477b
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Tue May 22 02:22:29 2018 +0000

    umh: introduce fork_usermode_blob() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f86186900000
start commit:   18445bf4 Merge tag 'spi-fix-v5.9-rc1' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13f86186900000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f86186900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
dashboard link: https://syzkaller.appspot.com/bug?extid=df400f2f24a1677cd7e0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15859986900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1228fea1900000

Reported-by: syzbot+df400f2f24a1677cd7e0@syzkaller.appspotmail.com
Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
