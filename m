Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B676339C137
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 22:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFDUYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 16:24:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41715 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhFDUYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:24:03 -0400
Received: by mail-io1-f71.google.com with SMTP id y26-20020a6be51a0000b02904b200a26422so1607224ioc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jun 2021 13:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+xxvngmMWP3gbuJ8xYiXibZlDPYJsW3VK9hdC7qe+a8=;
        b=GRMdnbx+6QZFOgaKSk6ZnnnTBWDmjufF3Ok4YtdJROmFhLcCxVixZ91r9Mkq7JUIA+
         zWxhdT4D5hybcq3FMU475TvtFPNHtysoVaX2ugVgTU1c1TWkeQYUcEV10idh2kwThaS+
         Pv9B1jqMAa1MICHrbiTTQzi8sSOadKdkUp952MeDVZiMve1N8IB1gniT/1AdugL4W9AV
         vzSKB4gsRnrZOzhxpLD/ax2rGkOpJMlySM13XGmZ8V2Uq1Ro8uvNxobwEucBDj+4OisO
         ucd2vk7I2OvI7XaXyo0gg/KoWAtcYocd0QdJ9nLk7c5nazqwwgGrrXtuHotdAgVtFAff
         Neaw==
X-Gm-Message-State: AOAM531s3KAf22VfyCcQPTq1Sr8KoajR3f6CdBhRwUY4HWT5jO05J7+W
        m8rGijW6j1abPy315v3Ly8DFKI6WD9iHHDN2+w+ZGl6Xo1me
X-Google-Smtp-Source: ABdhPJzyMx6V7bTfOpHbF5j6qSQ3NurRK7PzKo/y6Yn1W5AIf3T3nQk5uStxE5Nc5MADreRIYv94FRDp13ary7gUcGxeVNo0AMwp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:: with SMTP id a13mr5252482ilv.49.1622838126303;
 Fri, 04 Jun 2021 13:22:06 -0700 (PDT)
Date:   Fri, 04 Jun 2021 13:22:06 -0700
In-Reply-To: <0000000000006e1be105c3ed13fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bdfa905c3f6720f@google.com>
Subject: Re: [syzbot] WARNING in io_wqe_enqueue
From:   syzbot <syzbot+ea2f1484cffe5109dc10@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 24369c2e3bb06d8c4e71fd6ceaf4f8a01ae79b7c
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Tue Jan 28 00:15:48 2020 +0000

    io_uring: add io-wq workqueue sharing

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17934777d00000
start commit:   f88cd3fb Merge tag 'vfio-v5.13-rc5' of git://github.com/aw..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14534777d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10534777d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82d85e75046e5e64
dashboard link: https://syzkaller.appspot.com/bug?extid=ea2f1484cffe5109dc10
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d5772fd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10525947d00000

Reported-by: syzbot+ea2f1484cffe5109dc10@syzkaller.appspotmail.com
Fixes: 24369c2e3bb0 ("io_uring: add io-wq workqueue sharing")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
