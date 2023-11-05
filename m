Return-Path: <linux-fsdevel+bounces-1989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC1C7E1388
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 14:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8CF1C20901
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64549BE66;
	Sun,  5 Nov 2023 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CBA95A
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 13:07:29 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58074EE
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 05:07:27 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6cdb4938072so4645235a34.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Nov 2023 05:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699189646; x=1699794446;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vf0m/1w91K7wqWz8i917mDYQ56Coz6Ok3jfzXrbIlps=;
        b=qtnmTQRQZhieY8TlHVznkjE1IyIxkVnSsFfcFzSMGSCb4zc335etFaS58ajOg/GsNH
         vtIYxwm94vxxnMilNn6iIQ+0AuBl0BS4r58GbRlU/6Q3nW6ICFnZ22YSoWQNRVa13FxR
         CXCVx9SZGbrQfZ0VQ6zU3mdV0OrjrOZR0OBu1wPAWUMuJRu/aFaXHDAgOOuEJUjT10k7
         peFnsQETnIHkg2z3jbOgPWBiWXwiIJdPhs1ggtCzsFpkPTtXsckukGKcJ+9f/RFamy3t
         M6EoN60wZ+JH6JwqTht70JOw8DWrCiwf2WIw+sGZWWgpP6lrfOEDVJ1P5FuLG5CB02+2
         jQvQ==
X-Gm-Message-State: AOJu0YwdDyx3+VDCHq+A6+2ZumyMTj2Bqchw+kyJRP85cUBLxoIn/T/D
	2AHmbflgSpEBfBrrDPTfS0sv8wpJVTt1V7A9k6o0aEgEpbie
X-Google-Smtp-Source: AGHT+IHR5chTSEPM/wdeHF2mkoAGBTrl226/EeUv/UNjbvsm/v7U5f4oL/wwKyQYLKuE4X3jp2Rys9DONs95tTcLfXMW4yf/nb4q
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:6f13:0:b0:6d3:1579:bd09 with SMTP id
 n19-20020a9d6f13000000b006d31579bd09mr4012112otq.6.1699189646799; Sun, 05 Nov
 2023 05:07:26 -0800 (PST)
Date: Sun, 05 Nov 2023 05:07:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004db7b60609676b7d@google.com>
Subject: [syzbot] Monthly ntfs report (Nov 2023)
From: syzbot <syzbot+list49093097bc63b09eea22@syzkaller.appspotmail.com>
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
<1>  4415    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  3381    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  1553    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  691     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  408     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<6>  311     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<7>  253     No    possible deadlock in __ntfs_clear_inode
                   https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<8>  81      Yes   INFO: rcu detected stall in sys_mount (6)
                   https://syzkaller.appspot.com/bug?extid=ee7d095f44a683a195f8
<9>  41      Yes   kernel BUG in ntfs_iget
                   https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
<10> 36      Yes   kernel BUG in ntfs_lookup_inode_by_name
                   https://syzkaller.appspot.com/bug?extid=d532380eef771ac0034b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

