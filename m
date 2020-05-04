Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957281C3348
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgEDHFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 03:05:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33732 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgEDHFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 03:05:05 -0400
Received: by mail-il1-f197.google.com with SMTP id l18so12784143ilg.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 00:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=u3a78ZSqYtMPKHHAjJSNj5CtWeDAIi+gNz7+0hYnnWI=;
        b=DRm4a2no+uk1J/W09QbHTXtQaqKp6/qJXhW1354MAHsVyoq5TnXS5dd1WE3acRXzgI
         es3Wfpz3mYYeSESbrNaINM2z9JD8nobY2aIxp2o//l2SIkU8Hcn7Ed8DMun20tlsdrpd
         9P0nhu/JgxhedAAXpDNSQMkwqauXjRPTOgankUbG7it+QLe+ScGE4dsfyI2b1betAo03
         6I+DxB5ryTx4NM3MvANtGO3e19A2SSurX5vqj76T/+RIOwWD+lcj6POfRPNXo9ZvkM1T
         Uiw/+sS7371DT37osz02PFgltDHOX2VIMacSOydBtIuWzuz9kLq5sqobZculQMT8gy4H
         /bhw==
X-Gm-Message-State: AGi0PuYI2R/G9F3sOHtP1yjP3jS0+Gv++W2eBvDMPE4B9GIet/t3kyTS
        tKvGjpFVdDohhc+dJq8sbg9d39I/ut4EQ9reAqZUmNHhhkdI
X-Google-Smtp-Source: APiQypJoS44zQk9wi0Sxu/Y9n64DarEKre69MS+FF88hVeGqZryFDTLDuYB2V3PmvQ9hW8h0OBRfR17f+aByoFxd0BOKIBQz/zJ+
MIME-Version: 1.0
X-Received: by 2002:a92:8515:: with SMTP id f21mr14830968ilh.20.1588575904094;
 Mon, 04 May 2020 00:05:04 -0700 (PDT)
Date:   Mon, 04 May 2020 00:05:04 -0700
In-Reply-To: <000000000000c0bffa0586795098@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076622305a4cd26ae@google.com>
Subject: Re: WARNING: bad unlock balance in rcu_core
From:   syzbot <syzbot+36baa6c2180e959e19b1@syzkaller.appspotmail.com>
To:     aia21@cantab.net, bvanassche@acm.org, dvyukov@google.com,
        gaoxiang25@huawei.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miaoxie@huawei.com, mingo@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 10476e6304222ced7df9b3d5fb0a043b3c2a1ad8
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Mar 13 08:56:38 2020 +0000

    locking/lockdep: Fix bad recursion pattern

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142baee4100000
start commit:   5a1e843c Merge tag 'mips_fixes_5.4_3' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=420126a10fdda0f1
dashboard link: https://syzkaller.appspot.com/bug?extid=36baa6c2180e959e19b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1108239ce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cf40a8e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: locking/lockdep: Fix bad recursion pattern

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
