Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058EA3D9723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 22:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhG1U5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 16:57:09 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38439 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhG1U5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:57:09 -0400
Received: by mail-io1-f69.google.com with SMTP id z17-20020a0566022051b0290528db19d5b3so2468584iod.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jul 2021 13:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=k7avy/HerkLzVt2TDE6cKZ9UT96PiKh/Pc16LGwaHOo=;
        b=ijSqKL9xaXENql83U1SjsAc5fgiVNchjyAVkPRP+0PHObCj+5KoKRmNSNEEe+IxmAy
         YrgJQPi3eDYqSKmO6OlSzQ7qwHzJ/lhJW86il4ISELuqvHuBNALOJ1UfFIvRIF1A8jM7
         j5cNcPlvR54kaS+AhmdqaS/l56J1PDyPQxYMBK1+fgiirVjw1aJ8ntKCJGJ3viuVd23V
         W2VOW2OMLE49CGc8NsSHkYBpAgYOqz7fFMISGl4Co5OtyyTrAybS3DngrAArvoUj4pEA
         PA/vRxML7EUDneTqKGnPnrSbPYufpg4RyS+qRSbTt81ZZWb8OO+c4NoXBVYsCrsM0qJH
         GlmA==
X-Gm-Message-State: AOAM531yAYrUWX5JGx4A8ubFIea0wsfH/5KkRTJbI/BfXD4u7cdnXc3m
        qSQjbkwmel3ygiUDeCV/K3BUH373M/aqjNzsmNm0JZ6gUHyL
X-Google-Smtp-Source: ABdhPJyZnAPPwgmg7uF5y/Cxw8Xv6DuGKAwZPuLqUazVOHeSKjzDmsa4PIvTWSOdsoD6wYrDR8P75M72ExNJce5udu9KdgSwzi/G
MIME-Version: 1.0
X-Received: by 2002:a02:cf0e:: with SMTP id q14mr1461977jar.86.1627505827360;
 Wed, 28 Jul 2021 13:57:07 -0700 (PDT)
Date:   Wed, 28 Jul 2021 13:57:07 -0700
In-Reply-To: <CAJfpeguXWAJRyRn=8tLRq41kqjuSnX9VNqNT_V2+jhuttC0nEw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5b15305c8353a74@google.com>
Subject: Re: [syzbot] possible deadlock in iter_file_splice_write (2)
From:   syzbot <syzbot+4bdbcaa79e8ee36fe6af@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4bdbcaa79e8ee36fe6af@syzkaller.appspotmail.com

Tested on:

commit:         cdaddca6 ovl: fix deadlock in splice write
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aa932b5eaeee9ef
dashboard link: https://syzkaller.appspot.com/bug?extid=4bdbcaa79e8ee36fe6af
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
