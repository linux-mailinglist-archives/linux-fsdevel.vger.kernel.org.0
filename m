Return-Path: <linux-fsdevel+bounces-2453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F87E6129
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 00:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B72281364
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BBB38DE9;
	Wed,  8 Nov 2023 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D8374EB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 23:44:23 +0000 (UTC)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7042127
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 15:44:22 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b3eba1fc32so362013b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 15:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699487062; x=1700091862;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omOPkzFOgHujhTqR136cEFG8vnTdihPbkd8WFXv4dFg=;
        b=RZHjQJoo6C/2No2ZUrOCHKUoh6YGgUmJpJhMvtPTPFAw6vbW59gfk+VHp0L2KnCubR
         6yfxQY/kUiq61Jqk0e3lTwHjqV6kUAO1drrivrCLMRZGYHH1LgiFmQletwFQDUkbkYcN
         kZ0pcWTPWEAE29BYODPU2qZgGdq+CL5829hdhBNZPY9AysF/oUjvBCxWl5BJ8yHox5U/
         r2vs8770hFZ1Uu+W61hRoTlW9jyfnKOW3DFirRrJjd126ZPtXZBQjPUDh6sDLa3FLmFM
         RWwq3oP1b1WiWeBE8wkgCiXUjHlV4ZkjtbGsf3SuEt+3kFnDe3HZPXKx/pNupKyebz3n
         OFNA==
X-Gm-Message-State: AOJu0YzM5nhRgMbJval/Fs1T12eI77aAUlwQxetPA7s1mCrWgJnjchj0
	p+qZlrL+ffvOft/dSGaKu1/cCUGGnZV+UXUuLKthgtKCyAOd
X-Google-Smtp-Source: AGHT+IH8aLmqQLsGNTdroA2ZGENBSlGH3Kfq7L6wzTA2W0YLF3ESChu2j6nowvN6/kmPNHZrupMI9zOhidOYKsqo5KfV8j2kLNYH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1799:b0:3b2:e45a:7475 with SMTP id
 bg25-20020a056808179900b003b2e45a7475mr10745oib.11.1699487061898; Wed, 08 Nov
 2023 15:44:21 -0800 (PST)
Date: Wed, 08 Nov 2023 15:44:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ffc470609acaa3a@google.com>
Subject: [syzbot] Monthly ext4 report (Nov 2023)
From: syzbot <syzbot+list07d69efc5e1d32eac754@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 2 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 118 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  51606   Yes   possible deadlock in console_flush_all (2)
                   https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
<2>  10182   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<3>  5928    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<4>  470     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<5>  207     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<6>  150     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<7>  101     Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<8>  30      Yes   kernel BUG in ext4_write_inline_data_end
                   https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
<9>  16      No    possible deadlock in start_this_handle (4)
                   https://syzkaller.appspot.com/bug?extid=cf0b4280f19be4031cf2
<10> 13      Yes   INFO: rcu detected stall in sys_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

