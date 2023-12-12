Return-Path: <linux-fsdevel+bounces-5754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B080F9DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB94A1F2180C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E65964CD8;
	Tue, 12 Dec 2023 22:02:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885ACB9
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 14:02:32 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d87bcf8a15so9396195a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 14:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702418552; x=1703023352;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hdGj1T+YGUCPpxRju91bMft5LMiNJIh6i9fW42p70I=;
        b=EZ5bFRxLr3gcF7YecTOQW2PpQBpE3Cx+lR57AKUoHNw346RRIkU0CgU9YAB8T+jWOr
         2u1iDNRkcy99auI6OHAtVRzXp87lMI6Ca/Y0AjKCHmIhIScv67a63Mf8EnvgoRlCiM/I
         q8vK8buX9xqd7w1pnCOmtXn97bzvAD4LzDpYL1H+eU4tZu1pbyHF/vUgBi6iDI/nm6mo
         +Ua42OK7TD81GOo1XQng+272QO9y9ulnwJSCDbYfsSUvMKHyIUqSHc4gPlXJiaqTm5ot
         BcktHIn/1R6nU2HqX8gF0s3TZ4naMUf6JBopfEYyZSwgBd8ArCf6mUhIUEUGpUsF0Rm1
         +Bng==
X-Gm-Message-State: AOJu0YwKrNGRYLfUZ3uh4ZxjYM0RisyHfiV5QpTnWpGogTf5w8z6ThzD
	GurmZR6ap8t/e6U6ozIZc0vtN5acCclwte2AcYYxP7bjurrgQcw=
X-Google-Smtp-Source: AGHT+IGWzzK2DONy86FSYfM7rroV/aF9VC3y8B3L2PLihakl9b0pbKQ0Uv+y+fuK1z3gK45URHuOvpg2UNqytDQ0aa59k8lpCXHB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4487:b0:6d9:f71c:eaa7 with SMTP id
 r7-20020a056830448700b006d9f71ceaa7mr6107216otv.5.1702418551886; Tue, 12 Dec
 2023 14:02:31 -0800 (PST)
Date: Tue, 12 Dec 2023 14:02:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b58e0060c573578@google.com>
Subject: [syzbot] Monthly fs report (Dec 2023)
From: syzbot <syzbot+list7486a5e050207f65aa7d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 10 new issues were detected and 1 were fixed.
In total, 93 issues are still open and 329 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  400     Yes   BUG: sleeping function called from invalid context in bdev_getblk
                   https://syzkaller.appspot.com/bug?extid=51c61e2b1259fcd64071
<2>  359     Yes   BUG: sleeping function called from invalid context in __bread_gfp
                   https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
<3>  261     No    KASAN: slab-use-after-free Read in __ext4_iget
                   https://syzkaller.appspot.com/bug?extid=5407ecf3112f882d2ef3
<4>  178     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<5>  54      Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<6>  44      Yes   INFO: rcu detected stall in sys_clock_adjtime
                   https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190
<7>  42      Yes   UBSAN: shift-out-of-bounds in minix_statfs
                   https://syzkaller.appspot.com/bug?extid=5ad0824204c7bf9b67f2
<8>  25      Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<9>  11      Yes   KASAN: use-after-free Read in sysv_new_block
                   https://syzkaller.appspot.com/bug?extid=eda782c229b243c648e9
<10> 9       Yes   UBSAN: shift-out-of-bounds in befs_check_sb
                   https://syzkaller.appspot.com/bug?extid=fc26c366038b54261e53

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

