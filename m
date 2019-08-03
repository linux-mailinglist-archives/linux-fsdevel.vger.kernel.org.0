Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A3080518
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 09:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbfHCHnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 03:43:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56604 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbfHCHnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 03:43:01 -0400
Received: by mail-io1-f70.google.com with SMTP id u25so85244781iol.23
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2019 00:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yMorIrW4ay3tdK2qTcsDnVE/Pjijxze3b99wXe/WPcY=;
        b=hsRVGJygSK42j5QltmFiMtMeO7G9kMk9Vc++gvD2NomtKMd4Fd4gtnBZINxyq29ckd
         NGXA/+niTiTgEqqNhodMN/qL0T8nkrKG5DCNactbFqrn2etOSYAgqP5rOHZPy3l8lUPO
         cL+qOtJMF69B04NXMpzPD/zIw2SH4sQkPNbcrlmvaLGUY0uzmJiFGM7A8sTwgwX/eaVQ
         5eVlx8h7oEDwoFqFiyLnopGF5Tt0yfulRKv0vDeXnhhMDhlHQabYfdbv3UwCvT8tTfyf
         tOoTcQRg25PfdYteL0xxtYVT1V7YQU4jmVemsCR64ZLOaqLriw0Qj0BxCfrVxnrOa82C
         6dqg==
X-Gm-Message-State: APjAAAX4yOdl3L30etb0i91UKSQ2VWDQsr44du9oVtDS13wzcjBO+zwv
        l3i8harnig80RAZdsJ7QaHSyej8tB3FCOXP+ZmDCPRcSDD8m
X-Google-Smtp-Source: APXvYqyODxVlDnjmRqYXt2tj0Z1xEFiKx4T/bWkQb1PzdLwDQuMC91pWxkePCa7Pu2aTkOoYz58Kc11H06whknBe3wOWUzTFH6uy
MIME-Version: 1.0
X-Received: by 2002:a6b:b804:: with SMTP id i4mr5520996iof.119.1564818180769;
 Sat, 03 Aug 2019 00:43:00 -0700 (PDT)
Date:   Sat, 03 Aug 2019 00:43:00 -0700
In-Reply-To: <000000000000a2db16058f2514fa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd8e92058f319f8c@google.com>
Subject: Re: KASAN: use-after-free Read in blkdev_direct_IO
From:   syzbot <syzbot+0a0e5f37746013dc7476@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, davem@davemloft.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit b9a1e627405d68d475a3c1f35e685ccfb5bbe668
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jul 4 00:21:13 2019 +0000

     hsr: implement dellink to clean up resources

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1589f3e8600000
start commit:   1e78030e Merge tag 'mmc-v5.3-rc1' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1789f3e8600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1389f3e8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7b914a2680c9c6
dashboard link: https://syzkaller.appspot.com/bug?extid=0a0e5f37746013dc7476
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fa7830600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f31c8a600000

Reported-by: syzbot+0a0e5f37746013dc7476@syzkaller.appspotmail.com
Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
