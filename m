Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5F62C8E00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 20:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbgK3TX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 14:23:56 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:43734 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388323AbgK3TXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:23:54 -0500
Received: by mail-io1-f70.google.com with SMTP id q8so8249547ioh.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 11:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uf/aZgeXPqEFjXuJZzr2FsvsM6z9f8DkBMhU/AhY4B4=;
        b=ZfKiT3LBguMXObvJJ06YeyqQmZx0C2Vqa9xGEdpCbmunXg0hMMXpXrENkFs3Q8cUWK
         f88w9Mm/K5PyCwiL4ha2mzXOz6CZcataYlJQDdkin2m72OoH996Fblpoi5m9WLdHya61
         G91fwc1hKNxmjAxgyrHzo/iLpPXxTKXsV9xCM3VxdzrTksDda01bcxMeWgatBybxTKV3
         zQ7lIo/UV8ePTcOAv2+Qgao7zRnOA1e5CyNg5qzupcInf2En+jXfwW7ZkNbtxHJebMeJ
         J8zAtH4I+gNm/SeFu8UPWqB+Xh+ZmhB0ouXO0dgx4xVTUnb3MKxxtm8mhPGQGXCcZvfI
         91xg==
X-Gm-Message-State: AOAM531hpjtFcmAupm2atmOdEd8vNoFCH+MsfjMkGfxF61zjXU/8sWFl
        W71ydAcxudwL7dMqwR497I0FYv3jt1XKLdiAO6HXM5YyxBTF
X-Google-Smtp-Source: ABdhPJy1LqIVueVQnUzmecAD0qfntY0qn6d19XP+O81iSfXCPD0VyAXXg8u9XiqkW0yIcc0/lYI943TSZMavOE7gVSbCOgl3XBP5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a3:: with SMTP id h3mr20119593ilo.164.1606764187097;
 Mon, 30 Nov 2020 11:23:07 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:23:07 -0800
In-Reply-To: <000000000000bf710a05b05ae3f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c212f05b557f00a@google.com>
Subject: Re: possible deadlock in f_getown
From:   syzbot <syzbot+8073030e235a5a84dd31@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122fe51d500000
start commit:   b6505459 Linux 5.10-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112fe51d500000
console output: https://syzkaller.appspot.com/x/log.txt?x=162fe51d500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3a044ccf5b03ac4
dashboard link: https://syzkaller.appspot.com/bug?extid=8073030e235a5a84dd31
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b43d79500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f2ed79500000

Reported-by: syzbot+8073030e235a5a84dd31@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
