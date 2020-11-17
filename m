Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6451C2B7215
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 00:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKQXTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 18:19:11 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:53142 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKQXTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:19:11 -0500
Received: by mail-il1-f198.google.com with SMTP id o18so133802ilg.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 15:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sCJOc52f+ykN2k2Nsk4q5GEkZUdIbCHBG3TzWEYybVs=;
        b=ix4Nop9vBBIO97zOBZIRCJxMr9MjT1bt1KzX+7689Vcn3vfSYv1sCu1VADSSJlTSEP
         is3vG/eJpX4Pe4KiL1bxlO30d3uh1aASZDVBmkRWEn2FyCQWmWHFaiQBkAFn571a3xHv
         ccsMorjzYg+jFPRsze/rzm60UzbtmMPnZHTchgvmSGN0bqk4DDH/h7sylartfUDeAMhw
         LXO2Qb6nMcvgEzEImSStMhG4GvAG96GtG0Uin3Q4TK2jbXKLUMjb2Y2NY8ZXpFfISGu8
         kUY4yUjBI7tXeBmKXe8e9RBFaEf05VT0RFMgqV9bF3CFgxRzmyXe8LRf7rtKjOSVaEMr
         cwPQ==
X-Gm-Message-State: AOAM530EW/l2WRjI+uhRuL3MH2RcXmO7WWCc6QEG1mPe5BPz1yAkfPJS
        /n8w0gNOjpt7Ul1DDngMarLhRoHsc9ukMNgfQuy9JV8rzd7s
X-Google-Smtp-Source: ABdhPJxChT34/B8KR5M9iyDfeWrPy5FLGPrzPfIfrP0j6CGCmLNUnK5X6P3va84cfBm0fFQ6ORDCOH2TTHVDnJZpXsuI7FTYs+Ub
MIME-Version: 1.0
X-Received: by 2002:a92:c70b:: with SMTP id a11mr5696524ilp.151.1605655150607;
 Tue, 17 Nov 2020 15:19:10 -0800 (PST)
Date:   Tue, 17 Nov 2020 15:19:10 -0800
In-Reply-To: <0000000000009c775805b0c1b811@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2437705b455b8bb@google.com>
Subject: Re: possible deadlock in kill_fasync
From:   syzbot <syzbot+3e12e14ee01b675e1af2@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b46429500000
start commit:   7c8ca812 Add linux-next specific files for 20201117
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b46429500000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b46429500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff4bc71371dc5b13
dashboard link: https://syzkaller.appspot.com/bug?extid=3e12e14ee01b675e1af2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b1dba6500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12de8636500000

Reported-by: syzbot+3e12e14ee01b675e1af2@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
