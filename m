Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2BF2A1B5C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 01:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKAAVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 20:21:13 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:56206 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgKAAVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 20:21:13 -0400
Received: by mail-il1-f198.google.com with SMTP id d9so7452688iln.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 17:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+t+XR/wTDNVTtYlWW7f3zi6b97xo3W0UmbwmNVGd3Gc=;
        b=qkv2SJtTwVs2PHobfEi+MVSV5YoE3AB9JPM6FW7UGIywhEKYL8g2LLBFJ2WZV0dNdb
         H0CbuUH9bgslbmn5V8xmUpc86A7RgucpN1Y1IwEE8zO5C3DmB8TAB5bYOESOLMA5sUU4
         /mYDCZGHbIqqBJbnEHX55KOuIjRLNO6dwoHuyU5hD1mfLHxVLQ5Bp/dLFard4em7YQbu
         cD/57w8AEw8Et/8ExCHAMv88xAxFgUSVwk/T3j7908o7YiETW2SFiN7QCSQEUOP3h0Lv
         tS56XZC/IgI6Q9Zq4NynSrwFt47wVE9HXJWA0ooJIuxRSWSwERVxUMpx+IvdSEKzWBNR
         WL5A==
X-Gm-Message-State: AOAM5308XJRCzSfVJCHsVzSVYIoUVkJq9hINr6YGBSNO7LByu9/HnetW
        iQBRprRvawg7ZUSh/m/uTGJRbNMO8Eug70/1loQ4gfEJq28X
X-Google-Smtp-Source: ABdhPJx9/DjV+k8sOmvzPjKK32S16JsI+YZVDjMqaLkwalHTfuft4cgC7Y7++4NcGry+VOZXzhj0btnaP4vps+OdMzSL0drKKzEG
MIME-Version: 1.0
X-Received: by 2002:a92:ad03:: with SMTP id w3mr5686873ilh.53.1604190072610;
 Sat, 31 Oct 2020 17:21:12 -0700 (PDT)
Date:   Sat, 31 Oct 2020 17:21:12 -0700
In-Reply-To: <0000000000005b4a3805b05a75f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e29ed05b3009b04@google.com>
Subject: Re: possible deadlock in do_fcntl
From:   syzbot <syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, boqun.feng@gmail.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit e918188611f073063415f40fae568fa4d86d9044
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Fri Aug 7 07:42:20 2020 +0000

    locking: More accurate annotations for read_lock()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1292881a500000
start commit:   4e78c578 Add linux-next specific files for 20201030
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1192881a500000
console output: https://syzkaller.appspot.com/x/log.txt?x=1692881a500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
dashboard link: https://syzkaller.appspot.com/bug?extid=e6d5398a02c516ce5e70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b24ecc500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c01512500000

Reported-by: syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
