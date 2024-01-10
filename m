Return-Path: <linux-fsdevel+bounces-7686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636682960E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56EF1F21494
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4283EA80;
	Wed, 10 Jan 2024 09:16:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341D3E496
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3607ad143c2so32044815ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 01:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878182; x=1705482982;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUGvX4y4QaiPINbAkyOx4k6jpyVEymh+2uUyfbZrWPE=;
        b=VRZcs8kBtm4p5EVWaHWFy+thWc4YxB09NXI22QYigyEh3+EzeznWoJWQkpvG5flyat
         j95ad2LewdfZtJFeTjaloBUfREBC4c18yUHwUM9LvZntuKCHoKf3LfFZeAbdcwpbv06w
         bnX4TQ4YCzTiOUVI5f+r+4jKJ1tX5quhg03UeQtjPiKG62r2VtNlpgU8f/0Q1HoUygl9
         nVjQGmQe5G50Pk7fAUHuJ+smg8RmiyLuO4xJEDIFYRLW69xnn5xgEjTNStVhNLmyk2ca
         cVTITexRtaXjt9LIy9FsGUyDLM0Xh4Xow/y4whZJTp81TPtx5rAsANiVvqdXBFtgEM5G
         hnDg==
X-Gm-Message-State: AOJu0YwruDF93X8IMGX0XxiUHfXcXgJ6jDX8bpUNyt9x9kuNPUvIAPg3
	uVFIKZfzzzyJ7linKLcrivbWmIUZDfv4hmtKR8umaIVH4ZRH
X-Google-Smtp-Source: AGHT+IEmn7036tW7IKagIJWOf7Detbx4DDOLXRpQMqx/jh0GnLApfpN2TCZSsFY2MF97G9WjF8zEGtc9hygcn8GMvH+Ko2xxneHJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219b:b0:35f:bea3:c041 with SMTP id
 j27-20020a056e02219b00b0035fbea3c041mr83282ila.4.1704878182759; Wed, 10 Jan
 2024 01:16:22 -0800 (PST)
Date: Wed, 10 Jan 2024 01:16:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000780734060e93e23b@google.com>
Subject: [syzbot] Monthly btrfs report (Jan 2024)
From: syzbot <syzbot+list87fc906bbb52a6f7d64f@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 47 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5777    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  2315    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  373     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<4>  299     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<5>  241     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<6>  230     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<7>  223     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<8>  117     Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<9>  109     Yes   general protection fault in btrfs_orphan_cleanup
                   https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
<10> 95      Yes   kernel BUG in btrfs_free_tree_block
                   https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

