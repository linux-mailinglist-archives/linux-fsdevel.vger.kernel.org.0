Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB75522D518
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 07:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYFLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 01:11:05 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48989 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGYFLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:11:05 -0400
Received: by mail-il1-f198.google.com with SMTP id x7so5091856ilq.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 22:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OxvLZmqjPIgyfFJFD3jU0NCXtLqtMkM6RdMtuDq0MCs=;
        b=lFRcmBMqysjBEV/RXrKNizBnMkPeEdFSBiQnzUX2QQgu62f57MksDtnvRvmg4RxHj4
         9L2akdXskEX/CWeawDdOr0xNG45eQ0a3y7r1oB6e4h08jryt4sYWBQ9SXq0LoR4LjjLY
         jdPiTorwr9evvlhzvKtrxSH6eTgMfoQj8wAVG4xwhRO8NJgU3v33GzoMdAiS8o6BeIob
         eEbfxawzY0PNDd05DDCYSOpv+lViV/LVzFACVD13JjMecOf0iQCr/UpKiY8ZzUI+Q7aA
         5Dtsr3q4jveG4ihTyDDpIMUrxenDUxso6PV0ZHbn4XPhRK4SyMAsmjfvThGS7U72NtR4
         seMg==
X-Gm-Message-State: AOAM5321bWtmawF2DjTUlxF6XqVU2g7ZUg/sBCXkv9MyyikFgXDRntlI
        /tkLjxVHDaDmmxPLPE4PjKbOTAHoZAkmtP7PHNSCdDvi9Q+K
X-Google-Smtp-Source: ABdhPJz7r05qYNwD8iAc+QKC+Tc9C8Eqv0mYlaRsqfEyEpJszHU46Z43bkEBNCZQUn51WRKL3DEvQ3smKEI3RDnTLqC1oTSQ+4/l
MIME-Version: 1.0
X-Received: by 2002:a92:c912:: with SMTP id t18mr10628820ilp.186.1595653864438;
 Fri, 24 Jul 2020 22:11:04 -0700 (PDT)
Date:   Fri, 24 Jul 2020 22:11:04 -0700
In-Reply-To: <000000000000402c5305ab0bd2a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c641a505ab3d1d48@google.com>
Subject: Re: INFO: task hung in synchronize_rcu (3)
From:   syzbot <syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, davem@davemloft.net, jhs@mojatatu.com,
        jiri@resnulli.us, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vinicius.gomes@intel.com, viro@zeniv.linux.org.uk,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149057ef100000
start commit:   4fa640dc Merge tag 'vfio-v5.8-rc7' of git://github.com/awi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=169057ef100000
console output: https://syzkaller.appspot.com/x/log.txt?x=129057ef100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=0c6da80218456f1edc36
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e2a437100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13af00e8900000

Reported-by: syzbot+0c6da80218456f1edc36@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
