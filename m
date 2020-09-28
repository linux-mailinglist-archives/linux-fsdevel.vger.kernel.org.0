Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C490D27B4AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI1SmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 14:42:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33695 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1SmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:42:11 -0400
Received: by mail-io1-f71.google.com with SMTP id l22so1282704iol.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2020 11:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=USTitjBt7BhgpNWZwLXk38Ti/vZU2Kr0xZT/wNOO+pU=;
        b=jv1gTYVhafdOF3bAf2Wc9oL71bRrrydHhY5jM1KBVg1eklre3vnwn3oEE+0BOcOccX
         FcWgyU5+ImFmA95m6kiPuhucCD/mN+58LHlj0yxzDb1P9gMLwVvCR2/A6+5sR+noLK/S
         k71SMso0K7Do/iJsxmUgOyJdQM+A39PPFHjHuQtLmup9DJHsPMYpM3AN+eFcTcVO7dKK
         VWh9NXUEAm72zT31N3IpIsZFGuqPKwogq1hxPRulVuFKmCc4ZJnfZVGSkgdrHzUsQrla
         LdZ7NW3zqyZLyOeRPIAT6jLapugGRiSFqyc6oGPYJguxrXFptpAe5qpntXPZh1LhKdy0
         YfQw==
X-Gm-Message-State: AOAM533A5aBKkZpzV78BDXVW7JxDHWqfgqxJXgJhIvrjYE/7kwJc9GOe
        /ijQ7Oyf3PmGhOGyO4RRZ6nly1U+NDsCqL10pIdMUVemncps
X-Google-Smtp-Source: ABdhPJy+jPyOc19HWBq/6EBaZVHRqolvxOK1YlgdhD/ZPfoMxbwmw1fYgbCWxrcCJUEULrfUE4QjhVhXDmX54Bs+w5gJIXnEGp3l
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e0a:: with SMTP id a10mr2461640ilk.113.1601318530184;
 Mon, 28 Sep 2020 11:42:10 -0700 (PDT)
Date:   Mon, 28 Sep 2020 11:42:10 -0700
In-Reply-To: <835b294f-2d2b-082b-04dd-819e12095698@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029fbe305b06406d0@google.com>
Subject: Re: general protection fault in io_poll_double_wake (2)
From:   syzbot <syzbot+81b3883093f772addf6d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+81b3883093f772addf6d@syzkaller.appspotmail.com

Tested on:

commit:         fad8e0de io_uring: fix potential ABBA deadlock in ->show_f..
git tree:       git://git.kernel.dk/linux-block io_uring-5.9
kernel config:  https://syzkaller.appspot.com/x/.config?x=2daac53dfbd493d7
dashboard link: https://syzkaller.appspot.com/bug?extid=81b3883093f772addf6d
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
