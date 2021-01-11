Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042292F0C30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 06:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAKFQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 00:16:47 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:50042 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbhAKFQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 00:16:47 -0500
Received: by mail-il1-f199.google.com with SMTP id q3so1036443ilv.16
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jan 2021 21:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TwLtYgNM/VxZnJX9RYzFOAmbDbu3TS829VUYdlrQ6tU=;
        b=TzUmr3oBEWB8EOsemWlgJCS/2yUZAxKFQbvC7YA6GMsIBU+3PlAjFnSsKgHtGZZZ3V
         f8DRbiTyorNlIzuDG9VdTEzacEQx6SvkdGmk3KKo4VA2K9OwP0dmNR558Gw6wThtPIrA
         9AbEaszAeBb+3Zk/Eg/QHzzMFfANlgth0w66pIMZlXpWd+UosM1umuDq10LjF45semHr
         3BrZitwTWb5/QWlv9vnN0+Pn8a6hMj+QsHah8p6TovTZ7KMcqQtZBa55nrsfOA6GCijC
         oCVnn+VIRFi/lEcPFD4104F81xDLibtpPh//bE8o5llRGQgXFxgpsV5tWXz7PEE7hWhT
         aBVQ==
X-Gm-Message-State: AOAM5336gnpewBc6TYPiIE+xaS1vXOoKQS8xOxfD0N2LFBCfWCMdjjZU
        foHcgqnvw90QDfTbFwFdNbjheWi7K9MkZ+n6f413Bl9MYzQ3
X-Google-Smtp-Source: ABdhPJw34d6R73XmCxuksM9133DcvPyLfBOZgm6heuu0BEb6aKdNf+Jt1XOKWGljxWX0oVlLoshF5G4fzBYFc5U+6aYPAdyyumLW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f86:: with SMTP id v6mr14014231ilo.56.1610342166413;
 Sun, 10 Jan 2021 21:16:06 -0800 (PST)
Date:   Sun, 10 Jan 2021 21:16:06 -0800
In-Reply-To: <000000000000f5964705b7d47d8c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbca0705b89900b3@google.com>
Subject: Re: INFO: trying to register non-static key in l2cap_sock_teardown_cb
From:   syzbot <syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, hdanton@sina.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org,
        mareklindner@neomailbox.ch, miklos@szeredi.hu, mszeredi@redhat.com,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 4680a7ee5db27772af40d83393fa0fb955b745b7
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat Oct 1 05:32:33 2016 +0000

    fuse: remove duplicate cs->offset assignment

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fc80e7500000
start commit:   73b7a604 net: dsa: bcm_sf2: support BCM4908's integrated s..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fc80e7500000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc80e7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ce34124da4c882b
dashboard link: https://syzkaller.appspot.com/bug?extid=a41dfef1d2e04910eb2e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166ee4cf500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1337172f500000

Reported-by: syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com
Fixes: 4680a7ee5db2 ("fuse: remove duplicate cs->offset assignment")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
