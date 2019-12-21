Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B70128AAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLURtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 12:49:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43914 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLURtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 12:49:03 -0500
Received: by mail-il1-f197.google.com with SMTP id o13so671396ilf.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2019 09:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GshsWrdoEPyx2vd7d7UXajSCgogocC5OTxKPrWDtn2k=;
        b=YRSnIYnFxd8mAfdoFfPfRw4E4k2fHpiBt7GupfsC+5l/Ip9WgjVtpEzkAI7aZN75JZ
         p6PvgH4EJ+8cW8iZHYEdyYjue9T55QrQOz5pB08yo+JzpVVGrCAU47jXEZvV/AEfWlgb
         xl1jw0ZAyT6cbqcHTlSnVs1BHCPTYA6hbUjkqf60FEWp+/VNcphcOGEVUx/13PK34dd1
         Rf2pMWcIwbONu1pCDfHKDTOleNMR29BBLUA04yu6Mql3eDUvg1MeQ09Ptq99BOsWu/Dr
         7mn5gy3e7fLCAIgqgAgtgJdNXMV7RWr32tkwnkRBGF4EMmi+gtU/KAhX4ipqX5WMEdo3
         cu9A==
X-Gm-Message-State: APjAAAU7iUdXFQmf2DNavVL5cN8sPYedKm1ZeiQGNC4tAEuWYdXDtdiV
        ZyFg1yCsCBuL5bUQZuCvW9pWATSRxPj0a1qkDgQi+uGvURPd
X-Google-Smtp-Source: APXvYqyCKPkUw/hvhEZzXqoyo1tTaKHhSZzOInzWI8gOHUFYW5HjZUeSJEoBRod5KvA94zqYvimn+I2NEHvJijo6waweNFndE35n
MIME-Version: 1.0
X-Received: by 2002:a92:d809:: with SMTP id y9mr18895833ilm.261.1576950541498;
 Sat, 21 Dec 2019 09:49:01 -0800 (PST)
Date:   Sat, 21 Dec 2019 09:49:01 -0800
In-Reply-To: <00000000000031376f059a31f9fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dac3b1059a3a684b@google.com>
Subject: Re: WARNING: ODEBUG bug in io_sqe_files_unregister
From:   syzbot <syzbot+6bf913476056cb0f8d13@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit cbb537634780172137459dead490d668d437ef4d
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Dec 9 18:22:50 2019 +0000

     io_uring: avoid ring quiesce for fixed file set unregister and update

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10eadc56e00000
start commit:   7ddd09fc Add linux-next specific files for 20191220
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12eadc56e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14eadc56e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f183b01c3088afc6
dashboard link: https://syzkaller.appspot.com/bug?extid=6bf913476056cb0f8d13
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15653c3ee00000

Reported-by: syzbot+6bf913476056cb0f8d13@syzkaller.appspotmail.com
Fixes: cbb537634780 ("io_uring: avoid ring quiesce for fixed file set  
unregister and update")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
