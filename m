Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F37F3037
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 14:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbfKGNnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 08:43:32 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:40656 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389009AbfKGNmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:07 -0500
Received: by mail-il1-f200.google.com with SMTP id x17so2655316ill.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gvUkH9WtkGdbkvkGEgBQ+scD8gdIfAilVOE5agk0pc8=;
        b=XU4tw6T6hOcchaEN/8hMUdE1oi6auuwz5shU4PWq7jOEc5p0WW4OJOA10LmsrG3vKM
         BkaqZPDlV+Gmbm+uQ6wT45K9Cx7irHRTACsQA/3tU6hkgp1vHCO2iEZhgWE+GSsOUS/v
         Iw/c14bGWUMRPCdH0rTpKjxT+o9KM4hohnbPQfDp++q92xJ8aVLNlFV4IcTJGoNkfffq
         jk9gG/b1Yx8M+7vI9l3vrYLt89SrhVLG0MKyKNujHuYzuHeDJuWigOMxikOjrdQtfTa0
         E7qFrKUm5UA2+2ft6frB06TEg5mO0Upz/tTjabYRNz/ZWGefcyIMYrsegOUu28B8RAG6
         Ejeg==
X-Gm-Message-State: APjAAAXLK0ZlI9aYf3s4Y40OGljdBy+RlF6DTAHz8FPtj5zz9kQHDiAF
        pnvczF3PDVyfXvOCbEEWnSnWhmSj/ivgWQsCW0dooZHnO6If
X-Google-Smtp-Source: APXvYqyA7RhiUvzMWSWZWI0ZIzVE9r/zHAJ0MtS5719wr8hUNsn3YgfguE5aJGhDksrtNHgLkCcvbS9hR4ypG3I2APwuBGeGv9Ux
MIME-Version: 1.0
X-Received: by 2002:a5e:9617:: with SMTP id a23mr3354786ioq.191.1573134125143;
 Thu, 07 Nov 2019 05:42:05 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:05 -0800
In-Reply-To: <000000000000d0429205723824d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6a0aa0596c1d4df@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in end_requests
From:   syzbot <syzbot+cd4b9b3648c78dbd7fca@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 45ff350bbd9d0f0977ff270a0d427c71520c0c37
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu Jul 26 14:13:11 2018 +0000

     fuse: fix unlocked access to processing queue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1494e3ec600000
start commit:   dd63bf22 Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4428fdc82f93b
dashboard link: https://syzkaller.appspot.com/bug?extid=cd4b9b3648c78dbd7fca
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b9732c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c469a4400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: fuse: fix unlocked access to processing queue

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
