Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49EDF68CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 12:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfKJLtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 06:49:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:54750 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfKJLtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 06:49:01 -0500
Received: by mail-io1-f69.google.com with SMTP id i15so10731907ion.21
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2019 03:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=muS40/M+U7unS7Nwdhba7+0opY/I2Z2pZGBBgPUq8C0=;
        b=HFhXUGEGGYjANbNNIT6MRP9xXSu2RGQWCXcixtFUthF4Uf1g/Q5SVu+pg5nWzPoFhZ
         ZV3PNOCuZHqGnchShNKmONXfZpku1GfpsZwXfMHlGjT7w6z5d2PErmhctpSZ+TG+Aj2q
         Ssh6iuB8997nV9pYbQDbo3IvXzqh1Xsu0JLOdnEo6C7peBwGizV8e5Bfh3dm1e1CN9Sh
         DPk5Xca1gS71O6TGsb1lo8NNy+gl7DBvaGvRag/R1AHBfwl8pevPW8dPzwJ92GLJMYu5
         3Zbsg0MxnwQdE9yHnVta1oTGEzk5uPjbOu8dgTdFNs3shV6LmJJB0yx+lHTcmsdFwRxd
         2wPw==
X-Gm-Message-State: APjAAAXX39++hKK1VTc8PscLU2zpGwwQpZKoxsxlly3YNxNUkHxS2C2+
        hzFvzRjMkOCiuybpbB7UjTPz0L2NkIeDO2PJFcTD9Um5vA43
X-Google-Smtp-Source: APXvYqwG7iOuXUzrPn9C7IQw34I7LSwhAIRpMFyONIfQ9Z8ZWhdhx/QqVwYg/S2UFNW58oOzV3uQTeJdrwTJ/Pza/72hGbJAuyfE
MIME-Version: 1.0
X-Received: by 2002:a92:16d4:: with SMTP id 81mr24840022ilw.198.1573386541143;
 Sun, 10 Nov 2019 03:49:01 -0800 (PST)
Date:   Sun, 10 Nov 2019 03:49:01 -0800
In-Reply-To: <0000000000003659ef0596fa4cae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e11df90596fc9955@google.com>
Subject: Re: KASAN: invalid-free in io_sqe_files_unregister
From:   syzbot <syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com>
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

commit 65e19f54d29cd8559ce60cfd0d751bef7afbdc5c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Oct 26 13:20:21 2019 +0000

     io_uring: support for larger fixed file sets

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f483ce00000
start commit:   5591cf00 Add linux-next specific files for 20191108
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=174f483ce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=134f483ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
dashboard link: https://syzkaller.appspot.com/bug?extid=3254bc44113ae1e331ee
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116bb33ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173f133ae00000

Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
