Return-Path: <linux-fsdevel+bounces-2187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F937E30AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 00:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469701C208D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AFC2EB04;
	Mon,  6 Nov 2023 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A532E653
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 23:07:29 +0000 (UTC)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF710E2
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 15:07:28 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e9bc53c828so7043967fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 15:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699312047; x=1699916847;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhZVLAZQhksSFJIL9PHRdF8MAL1sGNKTWA4vRt0GjIQ=;
        b=UkZv6G4jfSYG6bTcgUoCWTPsesJgA1Lpq3KxGZqDrW9l3Cft/Uvm3Zdqq8O8og3gBw
         WG67YHWMIj+eWRj0Wn0iulominyh5bXp64xFAYqfaIi8BehvfZ8TMrudSvee0LWSFNc2
         esbYmePFxBkp300JXwnSc9rTIPHc7sPM62sFlIZW5RaqNqXRS9E1E1qQWYo8aYStRy/9
         owQS8XJfPRteZpSdXotZKyHJnl8iyWg72mE5A/op64hQX4IZn9wK2eunMrfY8tLGtyzp
         LASxh8KkTrRQfjR59g8iQSgccaQaXvMa6edDM6TMXAeMNj/sXQjdwBh62/QD1/lGs7MF
         D31A==
X-Gm-Message-State: AOJu0Yw8i9PfvbTDHvu7yLQu6kbMVLZRATBnKI7JV3Ja8JxATKxCEB9b
	bFIbl50lWlRZQ6tryLnD8XfUSSd1RRNUkdLl8q/vi3pLrJId
X-Google-Smtp-Source: AGHT+IF+vSjl2lp1OxO8cWmpq6xJgr8wwMsMl1ow/EMZO0cwgdvqyHWHzdFS8t6EZSjkdEm5wxYNOMZ08hErFYW6YsyS1DzGVKmQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:7a0:b0:1e9:9202:20c6 with SMTP id
 o32-20020a05687107a000b001e9920220c6mr506069oap.0.1699312047195; Mon, 06 Nov
 2023 15:07:27 -0800 (PST)
Date: Mon, 06 Nov 2023 15:07:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef8d3b060983eae7@google.com>
Subject: [syzbot] Monthly gfs2 report (Nov 2023)
From: syzbot <syzbot+list255c96014713c46a953c@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 22 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4449    Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 3678    Yes   WARNING in folio_account_dirtied
                  https://syzkaller.appspot.com/bug?extid=8d1d62bfb63d6a480be1
<3> 662     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4> 79      Yes   INFO: task hung in gfs2_gl_hash_clear (3)
                  https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
<5> 54      Yes   WARNING in gfs2_check_blk_type
                  https://syzkaller.appspot.com/bug?extid=092b28923eb79e0f3c41
<6> 35      Yes   general protection fault in gfs2_dump_glock (2)
                  https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
<7> 9       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rgrp_dump
                  https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
<8> 4       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rindex_update
                  https://syzkaller.appspot.com/bug?extid=2b32df23ff6b5b307565

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

