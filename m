Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C547A262F0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgIINTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 09:19:42 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:48305 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgIINTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:19:07 -0400
Received: by mail-io1-f79.google.com with SMTP id u3so1914032iow.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 06:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=E3DC8oOc5Wv1kvi7EPmKvvKbe0T5xVJz7MHLJ6IZAsg=;
        b=O+esYX7N10K78YPw2GSzXfHfqFXuBFHJkC2MFZ2gbkYYwoNIWPDywDPzb0O4a4D+3Z
         NJwpqM52MKmbUhp3UP+aVuK8cbkMuFO1bsoM13ugTwzPpNpjxTXLVFIeSB4LwzDn9wbC
         DW1OvetHx4emHZTu6ytf4Fnu0p4+c1qx6OcfkGfY/TAU6aR3WMZC2hfl3SIBhS6jrmK8
         SYkcEwrz2smz6G04SBoLRYc/8VhA5XkpTQYvJrY9/NgkTbxrlv8XA0VDgn2P5DVUnEMH
         0ipx83eTgAM6vFwTcBE0CUdJUYScjUn2LMboGMB1G7jfW/kQCFNuB4+LI6iomhHa3kig
         ol0Q==
X-Gm-Message-State: AOAM533SC8wzOB3E+YEep3qZ6gxYzBz2uzmYGEtkLe0dgACD5tceviED
        kmvFdSpNVCNG7WJ+alZHyf/orvJNZk7dSrnZbgUAY7c3XaXF
X-Google-Smtp-Source: ABdhPJxcQGxT5cF6oLXv72p5cpZNhvBHKbh1UCXK1nE51/J5GhQOYBlu+S/ZZWIBLCIbFJoMJf4qNwXxdUWZdLn5fycpFuyANkem
MIME-Version: 1.0
X-Received: by 2002:a92:906:: with SMTP id y6mr3753912ilg.106.1599657546811;
 Wed, 09 Sep 2020 06:19:06 -0700 (PDT)
Date:   Wed, 09 Sep 2020 06:19:06 -0700
In-Reply-To: <0000000000002cdf7305aedd838d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7136005aee14bf9@google.com>
Subject: Re: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected (2)
From:   syzbot <syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, boqun.feng@gmail.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit f08e3888574d490b31481eef6d84c61bedba7a47
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Fri Aug 7 07:42:30 2020 +0000

    lockdep: Fix recursive read lock related safe->unsafe detection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13034be1900000
start commit:   dff9f829 Add linux-next specific files for 20200908
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10834be1900000
console output: https://syzkaller.appspot.com/x/log.txt?x=17034be1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
dashboard link: https://syzkaller.appspot.com/bug?extid=22e87cdf94021b984aa6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108b740d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12daa9ed900000

Reported-by: syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com
Fixes: f08e3888574d ("lockdep: Fix recursive read lock related safe->unsafe detection")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
