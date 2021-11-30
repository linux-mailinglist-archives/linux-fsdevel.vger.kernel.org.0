Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE0463B92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 17:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbhK3QWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 11:22:31 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:41979 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbhK3QWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:22:30 -0500
Received: by mail-io1-f69.google.com with SMTP id k6-20020a0566022d8600b005e6ff1b6bbaso24120965iow.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 08:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=82PcJsGJmWA9J7EfSsaBo8R7BvPCcHNRldX54MbqtUk=;
        b=aRY+gbFDPEpTFaLqyau3TOaaW+JXDh4Cwqa74DDVtPEUlONh7Y7B7uF2NZA4VRyAZI
         YY7wwLpC9pL5U6vFUyWAZZw9V9Eht+pCUeuTZYuAvw0OskQWmqHuf6prPpf0QLXHV96L
         Y8Qi+2lZuGrh5AlSDLSQKH/YBqrE9X0pAUdpl0wlAXTLK7hLrsSiHBwCQKTI9uFtFQpE
         VcvnOZEedTfolioK6IXDI2pY7ul+NVelEFLRAH0e1Z7vopEoMuYsXS2ZQ0Gm0pSyGOBH
         LwS+K94+YcTqadG/VeKWG+hv8K2h0SvVqqik/knbm+0NR9fn3u6djm1C2nCQZFhYjikQ
         Yb6Q==
X-Gm-Message-State: AOAM532Si5yQ22MKQpnTg6MSn3XKMnQOh/PEFtVsSrFjMd4UAtLOJo9/
        Ghe595+qdY/jepIhDM8fz5sbq5ycEUsT6aGLLmk+OFJI+Vbz
X-Google-Smtp-Source: ABdhPJyxuzWxbXXQxXt/uLUyAQu5gmBfd3on9w/gXZzhkfqblOPzJkm/nRXJfXP2GwX0YVZSMLpgNz44tT0MMcAsVMq1dotg6xoH
MIME-Version: 1.0
X-Received: by 2002:a92:d8cf:: with SMTP id l15mr1635ilo.59.1638289150573;
 Tue, 30 Nov 2021 08:19:10 -0800 (PST)
Date:   Tue, 30 Nov 2021 08:19:10 -0800
In-Reply-To: <000000000000f5964705b7d47d8c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc091705d203eac6@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in l2cap_sock_teardown_cb
From:   syzbot <syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        bobo.shaobowang@huawei.com, davem@davemloft.net, hdanton@sina.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        mareklindner@neomailbox.ch, miklos@szeredi.hu, mszeredi@redhat.com,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1bff51ea59a9afb67d2dd78518ab0582a54a472c
Author: Wang ShaoBo <bobo.shaobowang@huawei.com>
Date:   Wed Sep 1 00:35:37 2021 +0000

    Bluetooth: fix use-after-free error in lock_sock_nested()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134c881eb00000
start commit:   73b7a6047971 net: dsa: bcm_sf2: support BCM4908's integrat..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ce34124da4c882b
dashboard link: https://syzkaller.appspot.com/bug?extid=a41dfef1d2e04910eb2e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166ee4cf500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1337172f500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: fix use-after-free error in lock_sock_nested()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
