Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36998F3038
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbfKGNnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:43:33 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:34268 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389008AbfKGNmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:07 -0500
Received: by mail-il1-f199.google.com with SMTP id s17so2683154ili.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e/bybNTyffzCSeOhQgOXo0fbtRLBZtaNhLVDBNJSTz0=;
        b=UTJL0oB2m2U2joMjgMeVnh0qmmJLVssjQqCDKVPyuLqz3C0GR+MNVaW62Ry+B46snE
         p06blRP7fItR6FtklSb8VofqEPbDh1hOke85/CtMGScpHN/2eml4hD64jTt0gi7QaYmE
         poCT/LplxFYKLQ9W8hhYrH3ujV5iTV04ZIMiM4ph4mBcpmsT4sLlfhO3vCtNsFaBbamg
         e7wX9LUC1tcXaS2uYpqWZo4jXJq0gjXgmGfB01ZRy5EeNv9yztt2SAfyl+kiOtTOnOnV
         pgIOa6PTAS+euVCd06qsWgBwgD2u9U4oiBDYM/y3hBvgXeZ5XW3P0zR3CtpZYSo1HCYH
         XE+A==
X-Gm-Message-State: APjAAAWAEzTbMt1rZvq7jiqIYAhYXG5zsltjWWu4rqQRoR+At0Tp4A4b
        8zFkBnE37xEBbrxPYXfveZETgpzhwyr94ev22zlYvVli+E01
X-Google-Smtp-Source: APXvYqzWljQaJsrZ+AqWGAmWCefLJmmLOH1MlaUPlzVjJXSJlkdhW5pXAl9sPFgHpbd2qO0w4m10rxgCexPmWcK7myr9dWVLOdcX
MIME-Version: 1.0
X-Received: by 2002:a6b:8e8a:: with SMTP id q132mr3481485iod.94.1573134125252;
 Thu, 07 Nov 2019 05:42:05 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:05 -0800
In-Reply-To: <000000000000bc17b60571a60434@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8443c0596c1d480@google.com>
Subject: Re: INFO: task hung in fuse_reverse_inval_entry
From:   syzbot <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com>
To:     dvyukov@google.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit c59fd85e4fd07fdf0ab523a5e9734f5338d6aa19
Author: Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Tue Sep 11 10:11:56 2018 +0000

     fuse: change interrupt requests allocation algorithm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15518db2600000
start commit:   d72e90f3 Linux 4.18-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
dashboard link: https://syzkaller.appspot.com/bug?extid=bb6d800770577a083f8c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11564d1c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc570c400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: fuse: change interrupt requests allocation algorithm

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
