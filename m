Return-Path: <linux-fsdevel+bounces-7117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9329821CDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 14:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB77A1C22168
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9008914A8A;
	Tue,  2 Jan 2024 13:36:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857512E63
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7fdc371f7so1081966339f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 05:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704202588; x=1704807388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xq+9JpQRqUPWRsi8LPCu9kv4AtckUKGAz3Nf0QkOMJM=;
        b=Sgr2FjBrqm0+L0clVWgCEDixWcI9Gy45yqdGWVVVF78SyLfYfUNOavznRstyaz7qgi
         V6ZN2DSxeslCSF8aO2F2INw5gVhBNPh9sfDDzcYPN5anoV5AN5i1jcEoDC9xWJTu8RjX
         wgM1FA6wcKoJqg0HKzXd3B84rIqHripRFzSAe0T8vN5Bpvm4x3Xknhlg/VNiZ0En14A6
         9IuhxkCyUcVM5uBt6K4743de2lHjca8t/IEMZINF0Lf+uoY104+j3Jekb4/ZzCFLTESv
         RpmxgsSmce+cRbkdwfNbhL5o23cf1jJN0e9XgWDyUE++Okw4iP1uG2wJ0YNQXBbs/RnQ
         lJbw==
X-Gm-Message-State: AOJu0YzdlnLtw0JORvIdbLRZDa0lEow+O9lCXCAdNsp3pFhLnazRCdOH
	jn7YixmUJqwsBAQ3+oJ5Wpm6ii5hzaU1py2LRYns1tOnL6c/
X-Google-Smtp-Source: AGHT+IGTvLM/soxJTtptngRbvo7c8EtklHcLe01Sh43enMqIUNyziXdQ72rwM8Pc4KX9om/QFroNsPp+89Hx9PGGyBBQnc7xKrWY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3586:b0:46b:6ffc:cb79 with SMTP id
 v6-20020a056638358600b0046b6ffccb79mr514449jal.3.1704202588101; Tue, 02 Jan
 2024 05:36:28 -0800 (PST)
Date: Tue, 02 Jan 2024 05:36:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3a1c3060df6956c@google.com>
Subject: [syzbot] Monthly ntfs3 report (Jan 2024)
From: syzbot <syzbot+listb24c70845ff6f3242c14@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 2 new issues were detected and 0 were fixed.
In total, 47 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11376   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  3629    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  2282    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1943    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1575    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<6>  826     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<7>  775     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<8>  583     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<9>  570     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<10> 312     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

