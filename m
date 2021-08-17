Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75E13EF5B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 00:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhHQWVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 18:21:44 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47823 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhHQWVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:21:43 -0400
Received: by mail-io1-f72.google.com with SMTP id f1-20020a5edf01000000b005b85593f933so24011ioq.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 15:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=umDmu+4hB/JDNHdbTJk5sLucv5/bOLVHY7bndijJFTA=;
        b=rA7zhztq5th3RYbIOpzR/ZGqFVLwRdyf3dYwA3Zj44f09/fBp916JUSA9ZtmwI/3qM
         ttfZsrjhES/1yrhVdSs4Xo8yemnwWMzb2ih5PrE2I0N8FwhuG2iG8n0S8RAtqAU+L8QG
         NqjzSYbFtnFx/2Ww9zENDO1gdDp1w7OTAkhmNSm271UbusUmoeV4IQ2P0juf/9bOEh3m
         /TgERJ7jr61R7mhwR+12O38ElzdL4513aqi1tYwJ4eM8V2lSX2wB4eX4wU3SPthsuyGU
         S2w0N3Cbok+7TXx+njrNqlubxiq7AbH5mxS/6FxlOB/T2kLMkpNWP/p2XTzpZ8rv7g0O
         xwhg==
X-Gm-Message-State: AOAM533mxUDEvWfl5pGDaG+RoeV7nzmYET5pGzRSUM+rdXCaLisHhTWG
        wkZrW9UrY8hK+uNYC/wdwWs6bH21a+WnPX/v7yDd21NtmnSD
X-Google-Smtp-Source: ABdhPJzaDcwt4eaiB4ndqrwZbsMFOJdKO3Yu0KMKfK1Kr5midZbCbjKzgjJY5yO6zqRjKZKrk/3nxoTRvoMMG4XwWaB7JHSI/tXL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr3835170ils.102.1629238869490;
 Tue, 17 Aug 2021 15:21:09 -0700 (PDT)
Date:   Tue, 17 Aug 2021 15:21:09 -0700
In-Reply-To: <00000000000080486305c9a8f818@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012030e05c9c8bc85@google.com>
Subject: Re: [syzbot] KFENCE: use-after-free in kvm_fastop_exception
From:   syzbot <syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, mathew.j.martineau@linux.intel.com,
        matthieu.baerts@tessares.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit c4512c63b1193c73b3f09c598a6d0a7f88da1dd8
Author: Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri Jun 25 21:25:22 2021 +0000

    mptcp: fix 'masking a bool' warning

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122b0655300000
start commit:   b9011c7e671d Add linux-next specific files for 20210816
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112b0655300000
console output: https://syzkaller.appspot.com/x/log.txt?x=162b0655300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a245d1aa4f055cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=7b938780d5deeaaf938f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157a41ee300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f78ff9300000

Reported-by: syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com
Fixes: c4512c63b119 ("mptcp: fix 'masking a bool' warning")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
