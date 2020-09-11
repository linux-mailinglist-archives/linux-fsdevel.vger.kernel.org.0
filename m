Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAAA2668DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 21:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIKTdT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 15:33:19 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:53721 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgIKTdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 15:33:09 -0400
Received: by mail-il1-f205.google.com with SMTP id c8so7903446ila.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 12:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0yUAb84Y2NikNa3auoYNYurMSwqxLYd/elyzvfiKkx4=;
        b=Ae675SA7KGeWHSRwQzZxwg/l+XtGr3uh7VOizsDY2p4h7Oivx1UDFRkOmmPShGloBo
         6TgUZJKAz/peK0xGTX27bwJGcMePJFjz8ZFyDcb9G+kzr2OgKCEb8zCUw1T9RNHcHPoK
         fuBIJNIwkOPUlZ3pq3Lm5WnV1JkmCOy3DZlbJmyuSOtK/SLT8fkco0uCOFw0ZJFFJnID
         o+w9O4qgwpgIGIi1wSOccjvGo1Cn+PRmQ4E9xk44no4KQMkPh4v/23x2xVvGruM/Qz2E
         pPRGVpE/VbX9lzyRai6rB+uuOcmOokvN+hWN8/y/SJuTasjSaHwF0mqqeBCjFT4OOCrY
         38lw==
X-Gm-Message-State: AOAM5302JQ8calilYmYBKkFRJ21eVOtHkO9rW7b5pHCTkna/6HjQUFd7
        u7H8+v75Q7SmrKY2/D4EvceqY+Lqit97BWpNSUluer7z/Hcm
X-Google-Smtp-Source: ABdhPJyfFyXUGfImL5tjN6eAjrxa1lhqm11mUkFnIN5rwrwxtfv/gkcEKJnHEcdMqRpYoKA2Er1FYi1oI3tYPf76pme46eT6XyY+
MIME-Version: 1.0
X-Received: by 2002:a02:9f95:: with SMTP id a21mr3364657jam.50.1599852788689;
 Fri, 11 Sep 2020 12:33:08 -0700 (PDT)
Date:   Fri, 11 Sep 2020 12:33:08 -0700
In-Reply-To: <0000000000009a01370582c6772a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029b48f05af0ec14f@google.com>
Subject: Re: INFO: rcu detected stall in ext4_file_write_iter
From:   syzbot <syzbot+7d19c5fe6a3f1161abb7@syzkaller.appspotmail.com>
To:     acme@kernel.org, adilger.kernel@dilger.ca, axboe@kernel.dk,
        dvyukov@google.com, fweisbec@gmail.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mingo@kernel.org, mingo@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 7e24969022cbd61ddc586f14824fc205661bb124
Author: Ming Lei <ming.lei@redhat.com>
Date:   Mon Aug 17 10:00:55 2020 +0000

    block: allow for_each_bvec to support zero len bvec

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1120f201900000
start commit:   92ed3019 Linux 5.8-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
dashboard link: https://syzkaller.appspot.com/bug?extid=7d19c5fe6a3f1161abb7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170f7cbc900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a25e38900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: allow for_each_bvec to support zero len bvec

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
