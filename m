Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31A12200F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 01:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgGNXPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 19:15:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41804 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGNXPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:15:09 -0400
Received: by mail-io1-f70.google.com with SMTP id n3so224866iob.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 16:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y4iEWtfU0KeH/HIu2aGf4JNxF8z33lh3eOzOWOGJp8c=;
        b=LfgfZd4/9EJXtzmFAh/Ir3XHYrZhgiGUO9TukVTNCt1xvrgat2wP71UJj0UrdPe9OC
         iKDkTttxDs25UDgYDc4DmPZvqs8xH7h7BB+aDZokd1Dbq9GFRBONQS9aYd7NpURfx/zb
         e5Gw/+dDA7Lu7aoAZ5yoPOaPvhgGHlw0V8crn2j/lMJvyUbFsXQGNoGpba4gEcTdwOSs
         piAHJ+ZN1iM4b8VYI72jJGvQaWE6utDzZN4Sj7emBZ4Of4WoYvQbz7pK7nF8W9US4EsV
         HVJaiVGLu+gGeoYkaEiUTzw9oHKgICMNhGSpvMRZmP6mH4eAJjPjfofpvPIEC96F9cAe
         vDwA==
X-Gm-Message-State: AOAM532RIOOwaHGDTIvLkfKKVe9dyttsMkJ5Gx6Nq2MkAs5aIwB+V3zz
        B2mLKt1fobKTsjEYkEvZ6pcwkgkzw/N/DIFTeK+bOUFaXMg4
X-Google-Smtp-Source: ABdhPJzfIFFcizVg12hR+hNQck2LRndW+7B2KWWZoAqBVlSMjhnFcb+cKydgja6nAeyP//6r0JVKHznfXB7ulbcFhzayU6bf3/s6
MIME-Version: 1.0
X-Received: by 2002:a6b:d301:: with SMTP id s1mr7292773iob.146.1594768508659;
 Tue, 14 Jul 2020 16:15:08 -0700 (PDT)
Date:   Tue, 14 Jul 2020 16:15:08 -0700
In-Reply-To: <0000000000005f350105aa0af108@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000752cbc05aa6efa98@google.com>
Subject: Re: WARNING in __kernel_write
From:   syzbot <syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com, hch@infradead.org,
        hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lucho@ionkov.net, nazard@nazar.ca,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 81238b2cff1469ff5b94390d026cd075105d6dcd
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu May 7 17:33:03 2020 +0000

    fs: implement kernel_write using __kernel_write

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d829bf100000
start commit:   be978f8f Add linux-next specific files for 20200713
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12d829bf100000
console output: https://syzkaller.appspot.com/x/log.txt?x=14d829bf100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe4fccb94cbc1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=e6f77e16ff68b2434a2c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fe004f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d35f33100000

Reported-by: syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com
Fixes: 81238b2cff14 ("fs: implement kernel_write using __kernel_write")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
