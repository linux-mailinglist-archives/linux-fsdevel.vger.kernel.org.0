Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7210B25B60D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 23:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgIBVlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 17:41:08 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:45402 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBVlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 17:41:07 -0400
Received: by mail-il1-f200.google.com with SMTP id m80so770301ilb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2020 14:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zYHP8UduVrprHqF64bsSb84lGj8UCXHH3vw/WRSp4Lk=;
        b=aHlEoBUqioncGI5t0VXGdXIaH/zbp+roeYk4Dcbuq6Aa/S5Kgnx7oPZbOy+H/gGL0a
         uruBCaFPBrzyJUeauSOXjnatPgoEGK2LkJU7g5QuDmXWI4Cb2EQU06y45kDbG5adgTO1
         WDVLfxrrhcE1azJrMOsKQXC8FSmDt9xPInt1QxIE8RkRSEFJTBvhCn0ZbVdEZF+cZQ38
         5cPwCstQT/HuGgDhagiHkZfyipM00vykzJScpWJks759E4A1sGUdZ5UbqXk9SciglOKI
         NOobiqzXI1V6lvUaDj1WOkAyjn+NIQJWQLPiOYrA9P7MkeXWh/4m7Hdi5QDFF5fCJ984
         6qwQ==
X-Gm-Message-State: AOAM530eXrT4LxwLlEqAVNT5jXqCsrux6+i1apsLjEG/CbMlr2tXR4fN
        2ZggjXInegfAyCVxkKaqAkUmu/bHvNIUhOx5vJy+nu8N2hHQ
X-Google-Smtp-Source: ABdhPJzwb18iZGt0VuWOjCyns2qo393k1g5sM41Eny5nqT6RjGgPAom0iTU28KrEcsdItQWpIqHZ8Qp11pXPX90RStQlQhVETdRf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca3:: with SMTP id 3mr215750ilg.227.1599082866022;
 Wed, 02 Sep 2020 14:41:06 -0700 (PDT)
Date:   Wed, 02 Sep 2020 14:41:06 -0700
In-Reply-To: <0000000000002c6fbf05a8954afe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032273905ae5b7ee1@google.com>
Subject: Re: BUG: sleeping function called from invalid context in do_user_addr_fault
From:   syzbot <syzbot+7748c5375dc20dfdb92f@syzkaller.appspotmail.com>
To:     bp@alien8.de, daniel.vetter@ffwll.ch, ebiggers@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 033724d6864245a11f8e04c066002e6ad22b3fd0
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Wed Jul 15 01:51:02 2020 +0000

    fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156ad38e900000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=7748c5375dc20dfdb92f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1469d28f100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
