Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D720199529
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgCaLOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 07:14:04 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33859 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgCaLOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:14:04 -0400
Received: by mail-il1-f197.google.com with SMTP id b14so19452525ilb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 04:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VDzK7SMPTn5+1NJ0X+ZSAYeFxCx7H6x/5RbxADZ4d6E=;
        b=ijxEwnqpxxg/VV/Wb1hVBrroYvBg8hiii61cl4oIPmNVXPUOVsP6tq9Jxp09VMkQd+
         Y+1eFmN/OwXKpid3g4dFxsWrKi/fxjrTD04K9KF4NX2zqQgCxZMi3LCqkQukCwF7Ykun
         DcoGeRtGuJlrCRMNym9Q2I1xMh8N04Gt+kY2SIQktxda0pMdL+MdzPxe7TcuAr6GuByS
         QRnTkSFEoznidZ8Km3Au4JexJivJoWXnnMQa56VXD5wEA4MugnozuWShvpsrUOnL3lDT
         SCEtP7d7vmKUsNFTo7iIp27LWlS6WU0HOMy0hBCGGIZY7Qcm4cHR7R9Xrp/+zgxSXGKT
         XWIg==
X-Gm-Message-State: ANhLgQ2oqH+1tv41YJhLbbe3uoI/HS/ufTEJSzP6rY9XZINmKsUawMdO
        m2K6hK5sN2hNg2qDAQKGkeescJ4BMxZrMPga+3R5x9sFL6mz
X-Google-Smtp-Source: ADFU+vvsMmk+9AB6KhfsUlDFCpZCCk2oL4klTi/WKgJzTCgTsfyMEXJagR3lLTbUr0mSEfKTgEbpdznTLp2fsXhW7dvop7Eq42Q3
MIME-Version: 1.0
X-Received: by 2002:a5d:950e:: with SMTP id d14mr14672462iom.77.1585653243655;
 Tue, 31 Mar 2020 04:14:03 -0700 (PDT)
Date:   Tue, 31 Mar 2020 04:14:03 -0700
In-Reply-To: <0000000000002efe6505a221d5be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000533b4505a224aa8b@google.com>
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted (2)
From:   syzbot <syzbot+0c3370f235b74b3cfd97@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hdanton@sina.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit b41e98524e424d104aa7851d54fd65820759875a
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Feb 17 16:52:41 2020 +0000

    io_uring: add per-task callback handler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115adadbe00000
start commit:   673b41e0 staging/octeon: fix up merge error
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=135adadbe00000
console output: https://syzkaller.appspot.com/x/log.txt?x=155adadbe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acf766c0e3d3f8c6
dashboard link: https://syzkaller.appspot.com/bug?extid=0c3370f235b74b3cfd97
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ac1b9de00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10449493e00000

Reported-by: syzbot+0c3370f235b74b3cfd97@syzkaller.appspotmail.com
Fixes: b41e98524e42 ("io_uring: add per-task callback handler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
