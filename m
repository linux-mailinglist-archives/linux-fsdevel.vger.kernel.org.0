Return-Path: <linux-fsdevel+bounces-5425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BED80BA14
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 11:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FD21F2102C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315E848A;
	Sun, 10 Dec 2023 10:05:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDABB10C
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 02:05:22 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb001218c7so5019246fac.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 02:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702202722; x=1702807522;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKXFc2v7t4kCPe8Iesh8qQND7OzFTIcop0B/KSdXasE=;
        b=SQNxsDU4li0e/sqSLeTGBMgCSlSdLJQwqU2p6c7VBeZUS+z691H+Y3iFGKGJNhxtje
         9d3cGB2Xgj0AgQjzzmeAxMi63pdK3jCgwZWMZYezN9qotxa68pq8Xyju/26JaFirY8uQ
         zRUqYtxtTPeme6y8WzszqyAzI5hYZD4o9/57lxGyVYYXYOqoPyAzCOTEWuZhlAAYgUfi
         KMzLdwBBM1BM03GATVX1xBbMHLyRWmLbpPf7EE5qwDMImNFFuQyokiv1AXv4mVTxhgYw
         xRl0682oP/bOCGfSXOs4AU0Mnkcw6+7xs7N1SYhcnnlfCSkeZTpL8qt/A70fABuKGfiH
         nofw==
X-Gm-Message-State: AOJu0YydhcqsXMQN9urtnSPN3Zu4EMtdfLXW+rHS4Ko8/7kuUD8HhV/S
	Ux1lR8tVlazgQ11DnElbYV08NGMOA3Kr5i4I95TVLgZRxNlr
X-Google-Smtp-Source: AGHT+IF3qDImtqdycyGXN44w/tJpzNdjGEYlzQeJZKDWqiMw1vFKoS5HQnUnTIZ/28zH/2VGVNvWbF/e0jMYVfkJJJfj3oBV+Py7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:96a1:b0:1e1:2ebc:b636 with SMTP id
 o33-20020a05687096a100b001e12ebcb636mr3312255oaq.4.1702202722216; Sun, 10 Dec
 2023 02:05:22 -0800 (PST)
Date: Sun, 10 Dec 2023 02:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097ef5d060c24f422@google.com>
Subject: [syzbot] Monthly ext4 report (Dec 2023)
From: syzbot <syzbot+list52026f6b95687b491ce2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 8 new issues were detected and 0 were fixed.
In total, 61 issues are still open and 115 have been fixed so far.
There are also 2 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  51616   Yes   possible deadlock in console_flush_all (2)
                   https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
<2>  6748    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<3>  546     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<4>  247     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<5>  152     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<6>  115     Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<7>  47      No    KASAN: slab-use-after-free Read in check_igot_inode
                   https://syzkaller.appspot.com/bug?extid=741810aea4ac24243b2f
<8>  32      Yes   kernel BUG in ext4_write_inline_data_end
                   https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
<9>  16      Yes   possible deadlock in ext4_xattr_inode_iget (2)
                   https://syzkaller.appspot.com/bug?extid=352d78bd60c8e9d6ecdc
<10> 13      Yes   kernel BUG in ext4_enable_quotas
                   https://syzkaller.appspot.com/bug?extid=693985588d7a5e439483

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

