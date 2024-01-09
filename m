Return-Path: <linux-fsdevel+bounces-7648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8010828C73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F4628D866
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B83D553;
	Tue,  9 Jan 2024 18:20:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D83C47E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ff20816f7so30348575ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 10:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824432; x=1705429232;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhRQfuRoLIkuw/ytyqzS8UAwRWBfjYwu1CGl08N+psc=;
        b=AKhQV5YeFE5wIuoBzuPicyeC992E/hjo9HGqFjweduerHr/CyQ/iu2ScL2LVoqsIRB
         hpD9QDqyRd8p6+8EtRpU0euGGZZaVEahTC9fZRJUGrayCaBkkYeN/FW8utk0LcbWMqMd
         KpHz0QPfZzSztwhR3tjhl8RbIdnmfxr5gb2B8JSWRc55oCMidpQU3T88ZaRnAUWThMq3
         yNVPYCIdVZJ+zzDCZx+oUdyfisbTVwRhydoi61H87ChFN6RlbR941xu0bW6vMEA4fIrF
         ayq5VYx3JP/3pXip2NbEbLqcuXkz9HVo4urZicanF0fVaeUVd1VL/sHQp2f0ERhYtYZk
         HQBw==
X-Gm-Message-State: AOJu0YzE5vENMMHXXSjyFBH7Hww12BFFvkx0rhpi4t4RVn2vGhS/Ie0h
	WDosHVNFo4zx5u9t7bUUef161kn1E8kEt2H7O4Q9+MA85rAA
X-Google-Smtp-Source: AGHT+IFG3oxyOsal6bz4MJsODPsV80WJ4ajFXFo5ng67mZbhECFV+neQfEYC3xYaZWMs0V+M9Ja3Rev1JRTM7jMv/W0MFFWmNsiw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:35f:8652:5ce8 with SMTP id
 j15-20020a056e02218f00b0035f86525ce8mr935711ila.4.1704824432056; Tue, 09 Jan
 2024 10:20:32 -0800 (PST)
Date: Tue, 09 Jan 2024 10:20:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad615e060e875e78@google.com>
Subject: [syzbot] Monthly ntfs report (Jan 2024)
From: syzbot <syzbot+list9d8c4273b58598092f07@syzkaller.appspotmail.com>
To: anton@tuxera.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs maintainers/developers,

This is a 31-day syzbot report for the ntfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 26 issues are still open and 8 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5250    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  3663    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  1828    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  814     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  436     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<6>  324     No    possible deadlock in __ntfs_clear_inode
                   https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<7>  112     Yes   KMSAN: uninit-value in post_read_mst_fixup (2)
                   https://syzkaller.appspot.com/bug?extid=82248056430fd49210e9
<8>  72      Yes   kernel BUG in ntfs_iget
                   https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
<9>  41      Yes   kernel BUG in ntfs_lookup_inode_by_name
                   https://syzkaller.appspot.com/bug?extid=d532380eef771ac0034b
<10> 19      Yes   KASAN: use-after-free Read in ntfs_attr_find (2)
                   https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

