Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF71214FC0A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 08:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgBBHFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 02:05:03 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:44032 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgBBHFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 02:05:03 -0500
Received: by mail-io1-f70.google.com with SMTP id t17so7199796ioi.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 23:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Fqcj080fpjW3YleUBFYycrIBXVF2KLfVb8A0MJTatPs=;
        b=IoqY0C77ZSlw7kgBt1EgdtIcm0NjNk9Q3QL9nJDjhdCqvrgkAtfZKmShVXvEDwF14T
         fEld7BybLO+RWNGTRC7jNARjv7dPFT+Ct1JOck3OxFF5HvQHBuo296MPyQgg7+axDfPI
         +3GdexJYMJKN6QP0GpdgKkNNlIuIQeCv7rX1aQechO4rkl+16+a6bVmAvumi10yMal1n
         CQ5RRcec3LxQ5ZZOkGTrhjCtIlk24qCdL1/Vd3tQ+xQaFk3ogzeN3EdiQxMcL2/gta6l
         xO0njhXdNTKPLE286MUkGCWDRuipzTdtk281NxxlyOQi4qn79EUQzRf9WlX4K94RD9qY
         zuqQ==
X-Gm-Message-State: APjAAAUg1DFANn7CIxH+AvujWYRs5lrtJsu8RpwUWw/UrO1rUf4zRA01
        fmEYO3SWlitSsj2XlQCVwyzj9S0fiZzRqrIXp1XnuTMZolKV
X-Google-Smtp-Source: APXvYqxfBgVwZ/hal5pak54Hcteg+t0Fij/8KIMoja/+eLHlPRn9E4SfA6mh3Gdu3ROVJtSS+LFRs6S4yHL4Rd9kab/BnsMwYdze
MIME-Version: 1.0
X-Received: by 2002:a5e:8e4c:: with SMTP id r12mr14311646ioo.119.1580627101442;
 Sat, 01 Feb 2020 23:05:01 -0800 (PST)
Date:   Sat, 01 Feb 2020 23:05:01 -0800
In-Reply-To: <0000000000001a1ef1059b1a27c7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e76ba6059d926c08@google.com>
Subject: Re: INFO: task hung in __generic_file_fsync (2)
From:   syzbot <syzbot+44c32606d8669fb0d45c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, dave@stgolabs.net,
        hch@lst.de, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ming.lei@redhat.com, osandov@fb.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 85a8ce62c2eabe28b9d76ca4eecf37922402df93
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Dec 27 23:05:48 2019 +0000

    block: add bio_truncate to fix guard_bio_eod

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ebe101e00000
start commit:   bf8d1cd4 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=44c32606d8669fb0d45c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137e2615e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11306971e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: block: add bio_truncate to fix guard_bio_eod

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
