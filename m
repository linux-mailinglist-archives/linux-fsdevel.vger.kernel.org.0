Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED7D2ECACA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 08:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbhAGHDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 02:03:50 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:34255 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbhAGHDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 02:03:49 -0500
Received: by mail-io1-f69.google.com with SMTP id r16so3952694ioa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 23:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ucf7AyuSHfh9bNDOrZnScHCuoM7E4jcmLmsdWXty8X4=;
        b=Bgu0INK7dgnJFUQAoW8jtAjxnXOnWRsgY9YWj6gGKXNle7D4CUa0mSYnpmiVz8wlvY
         huFzbLZzSMnXNxFFLninLOhu/7q8efVJ5He0/1PjDAK/Us11n1/0qtrUo3TJBaq6tUOH
         FfClimGPIJf7Y5BDvPoXbuADpGFzr37rDODFH6yKpbsQVd+uSXvFiEM6x+cEofNocRgC
         YWRI2GBzjHweWZatt38IyN3HVxi4Dj/38ZgdD95eN1FR/EDyimPk3mn58C2NKkau6DXx
         J+WG57/NSpgLdBvMNe4JZ3BsaNTuZqR+Q2qEhfezbuwocCPsWV8O+Y77ncmo38MPIcsz
         DmCA==
X-Gm-Message-State: AOAM533vAmm/uNGtOTEzJQsB3PLhuny265tcdwLI+Z1x+RbW/6J0ZjJ1
        fuHKfFb0JQ+kQvl3G81v8/YTZLadBZJZYYdeAqnJplP/6qdM
X-Google-Smtp-Source: ABdhPJzgOkTOlqWPD2AGLe7feZpqc5+9HIgYLKJhdyUMDa2mEIf5pnZwLJ95GDYSTEs+PSnnMgoCQgILv3fejmAGALojWIbaQ1VK
MIME-Version: 1.0
X-Received: by 2002:a6b:3b92:: with SMTP id i140mr300092ioa.49.1610002989029;
 Wed, 06 Jan 2021 23:03:09 -0800 (PST)
Date:   Wed, 06 Jan 2021 23:03:09 -0800
In-Reply-To: <000000000000209d7205a7c7ab09@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fa24b05b84a0886@google.com>
Subject: Re: INFO: task hung in do_truncate (2)
From:   syzbot <syzbot+18b2ab4c697021ee8369@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit dfefd226b0bf7c435a58d75a0ce2f9273b9825f6
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Tue Dec 15 03:15:03 2020 +0000

    mm: cleanup kstrto*() usage

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111aa0cf500000
start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=18b2ab4c697021ee8369
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cec296100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153a741e100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: cleanup kstrto*() usage

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
