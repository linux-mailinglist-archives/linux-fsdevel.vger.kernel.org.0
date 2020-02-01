Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06414F914
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 18:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBARIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 12:08:04 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36266 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgBARIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 12:08:04 -0500
Received: by mail-il1-f197.google.com with SMTP id d22so8146715ild.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 09:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tymJqtHu6iGLng33McHVxrI0IJhfSzLoBxSmgMc7RDs=;
        b=QOcyimo8+lujx7CYl/st6pOXy0zRv+jVtY3wNp4gC157pLMAAwZnOF+vfnsPZbicTV
         ZKmEic1/evGDZkws8gWRaTOx+E5qXHZIw4OwJZgoXzF+cRxZ0DPS+q92d8HeXd6IBU4c
         hoetdNBlnWswLnEXNmVTYKzZ9Clm1v3+vO5O09gnKVIJQo+geQSI1x0qjG5xm2wLeuhE
         ysOUZjC6Muno8FKdeZU2vFH37E1KMF/asTp7x89v+HQEqrFypV9hzuh/gfLRmjNcZNQt
         Pt+RrsQM38GSfhJfCw02KW1jPizS9eGuKgO2LPx36/fJtnj7agEDiFWoxYBMBkH7ffYe
         NS7Q==
X-Gm-Message-State: APjAAAWh7D/3cnl4VIsQ2QDxBSRYhqM6fY9e/I88zctyi+P2TnB5eaRk
        Lf+HaQ0Th/41TekqKc12+qQsNEmMlVHtkw1OosC0gjAWPkyO
X-Google-Smtp-Source: APXvYqwepjCYJGI2J8ce5amIo8ruFAk8py8FuCjyu9SckBqGRIYGuJ+otdYXZhBwXMfqF4VWM3BgDWyoXjY1iNw3hTcQzL5vQlyt
MIME-Version: 1.0
X-Received: by 2002:a6b:b8c1:: with SMTP id i184mr9146827iof.68.1580576882237;
 Sat, 01 Feb 2020 09:08:02 -0800 (PST)
Date:   Sat, 01 Feb 2020 09:08:02 -0800
In-Reply-To: <000000000000b926cf059d7c6552@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b26dc059d86bb54@google.com>
Subject: Re: general protection fault in path_openat
From:   syzbot <syzbot+190005201ced78a74ad6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit d0cb50185ae942b03c4327be322055d622dc79f6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jan 26 14:29:34 2020 +0000

    do_last(): fetch directory ->i_mode and ->i_uid before it's too late

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a8d8b5e00000
start commit:   ccaaaf6f Merge tag 'mpx-for-linus' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15a8d8b5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a8d8b5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=879390c6b09ccf66
dashboard link: https://syzkaller.appspot.com/bug?extid=190005201ced78a74ad6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1674c776e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1565e101e00000

Reported-by: syzbot+190005201ced78a74ad6@syzkaller.appspotmail.com
Fixes: d0cb50185ae9 ("do_last(): fetch directory ->i_mode and ->i_uid before it's too late")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
