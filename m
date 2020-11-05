Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034572A7793
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKEGvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 01:51:06 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:39728 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEGvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 01:51:05 -0500
Received: by mail-il1-f198.google.com with SMTP id b6so394883ilm.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2020 22:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cXlxyzXPCK3wA1UZI4F1ruEs+BxcdjEXWDq+US8nJxI=;
        b=TSj6KbJPfKy7ZW+9katbKRR54ljtupW/ES14EG+kAuD2lPTu7CQCRIB4mvBn0NZn8+
         9paAcFMBnYnkigA3AipgTHq0Swmp62oN2YTFAx3TxBmX3JZ9EbcGQ8NVIQGPi8STXp2r
         alNvHMzNetr4V1q9dzZJk2A0wu2AR351BiPT1B1RCM64byHJgofbdd4JNxSv/Ef9dwIL
         neRg7sPYOlrT2oNnwlnQF+NOIhvKF2Ig1wV9UYa2M++9KSQ2qDcwepk79OonbQ+eVEtn
         k/lNxflaedG4i8FD65WAd8et/98dnPLnZRdv6Suv15MjzDNf0LtRJx5SpxqGOcqFAj2l
         J8ww==
X-Gm-Message-State: AOAM532vr2xMT7r9zT15gjFHIbjTmnQJIEyXnAYPFzusvP00zkW095FU
        s2OqdXVyudM5xJ21uRHKM2hevbnl6vID16KPHxt62G22+97Q
X-Google-Smtp-Source: ABdhPJxALS0DVWV2QPJFuJm3+R8Z1Pqd1o8qG2Gy4qDOedXlM+a1rm/mTTysetbaTarPtI7AYlyvqZUddW0Ed+55nWGqf7JBV6jN
MIME-Version: 1.0
X-Received: by 2002:a92:690f:: with SMTP id e15mr817269ilc.269.1604559064881;
 Wed, 04 Nov 2020 22:51:04 -0800 (PST)
Date:   Wed, 04 Nov 2020 22:51:04 -0800
In-Reply-To: <000000000000d4b96a05aedda7e2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001560ee05b3568521@google.com>
Subject: Re: possible deadlock in send_sigio (2)
From:   syzbot <syzbot+907b8537e3b0e55151fc@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fbef32500000
start commit:   4ef8451b Merge tag 'perf-tools-for-v5.10-2020-11-03' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17fbef32500000
console output: https://syzkaller.appspot.com/x/log.txt?x=13fbef32500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e93228e2f17fb12
dashboard link: https://syzkaller.appspot.com/bug?extid=907b8537e3b0e55151fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160ab4b2500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cb8e2a500000

Reported-by: syzbot+907b8537e3b0e55151fc@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
