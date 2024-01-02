Return-Path: <linux-fsdevel+bounces-7116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2312821CD7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 14:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530D61F22BEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2598113ACC;
	Tue,  2 Jan 2024 13:36:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074812E69
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fe9fa7f4fso89691595ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 05:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704202587; x=1704807387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGViDqpHpM/PgMAM6SCNiKxlip1nc59Qmx/Gy1A7u2s=;
        b=wFC6PWcGVuE9sOHsrgdHOAXDQrs24G0uhXchO0PpjM4hmb2SdnPJ/2Chdi+1mrVbcD
         AaWSQeHerVqZpiX3WYNLalEjMtsZwmUQ+u9Me6kb2BQFvrmhk5iOiYWCy4Wl/HBg+kAu
         Wn0tsy0a/bTe1R/30icSssby+hLb/wwSNV7aQtWnGDUsmkQPBkSgJiilL6VbC/o22URY
         oE3dvlBfZSnvO6O0hWSWoyWWBv3nw+JG3Ouw4kMwzfqOKMCQmp9Opj4U8f/CdWQIHFIs
         v0G2YeKvzpucHSe2QOhO203kr92e1IGDTiYQzS88mcEq5ATnIahsS2nZLY/nwC9t6fki
         rlvA==
X-Gm-Message-State: AOJu0Yz7sXu+kU3mZAkc13WVtT5A1NeWQoVrqN1y7/+4i+g8iD5a8ZM2
	GXO2v+myO16DkGWgTNIuBtvfQwwRXbJfQjAXbawmq+e1pzMA
X-Google-Smtp-Source: AGHT+IGO5cZ49DcsJTUMBX/0mmakCAVYPbZh16J2Cupgyu97CAh2ZeWEzifLqxwh03tXNJ5lL+PspKorGPR+blyQZ/5Ct7CJmfJf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa6:b0:35f:535a:9c64 with SMTP id
 l6-20020a056e021aa600b0035f535a9c64mr2057692ilv.3.1704202587794; Tue, 02 Jan
 2024 05:36:27 -0800 (PST)
Date: Tue, 02 Jan 2024 05:36:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000def411060df69549@google.com>
Subject: [syzbot] Monthly kernfs report (Jan 2024)
From: syzbot <syzbot+list417f71c53317b3ba7ddd@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1669    Yes   possible deadlock in input_event (2)
                  https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<2> 212     Yes   WARNING in kernfs_remove_by_name_ns (3)
                  https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3> 50      Yes   KASAN: use-after-free Read in kernfs_next_descendant_post (2)
                  https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
<4> 37      Yes   KASAN: use-after-free Read in kernfs_add_one
                  https://syzkaller.appspot.com/bug?extid=ef17b5b364116518fd65
<5> 31      No    possible deadlock in lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<6> 3       Yes   stack segment fault in __stack_depot_save
                  https://syzkaller.appspot.com/bug?extid=1f564413055af2023f17

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

