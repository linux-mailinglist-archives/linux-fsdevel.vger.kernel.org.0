Return-Path: <linux-fsdevel+bounces-1988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A917E1387
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 14:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A16B20E4E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ADEBE58;
	Sun,  5 Nov 2023 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A83C21
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 13:07:28 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F7DE
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 05:07:27 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6ce29652abaso3723728a34.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Nov 2023 05:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699189646; x=1699794446;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17+OiAdjnksb54atTiSO83QAo/t+7eezn3BKvlonFgc=;
        b=HeQ0dWqfFAQytFt9wc0RdlBnKsfea3yL/MmmTUkRygVKtHP3+CpRJseRopBD4mF5zw
         hCzC0vAH4nYveKOyB486j78P9C6tV9Jgdk6hQm/NNzgQ//h5Ev+R89j/ZTkjaboQ2zGQ
         XpVLUiTSV732KP1o1qC4jOzHGgCStCHwseTQy7CS+djeol89yA0w9LFy98YMz00xDRjF
         L5dW0DIM7SsJrMd532ZLXDgZGlAPqEN8izIls2E4TD7XHWXUnwCtlE5K0gdngn7Yl+/8
         1iTY7xG/HQmFm1nDO+/Of6MyDdO9wE3WdM+7uzWftHQGNG66Js77NYZzDJaHTkwp1Va2
         pM9w==
X-Gm-Message-State: AOJu0YwE/vvYtEUjl6Q7Yb2W4Sl9C3tNYTs7Sy36O9n1f7mHbpeAgZlN
	1UtMs8W7AmQWayU6kvl5GGFyrl/2qa/dLp9ynhpx70OKPYNk
X-Google-Smtp-Source: AGHT+IFviFkSwvEhccN8YdDBniWK/osExJFWr3CT0VV7FYAEW4sdmB6lTIUGTtVIUtX5KSyiFnLqK7wi6Qw+zwPl3XZ1M+dOT/ap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:3d09:b0:6bc:af19:1d22 with SMTP id
 eu9-20020a0568303d0900b006bcaf191d22mr7671000otb.7.1699189646504; Sun, 05 Nov
 2023 05:07:26 -0800 (PST)
Date: Sun, 05 Nov 2023 05:07:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000493bc20609676b0a@google.com>
Subject: [syzbot] Monthly btrfs report (Nov 2023)
From: syzbot <syzbot+list60f60686fc15f64ee667@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5549    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  1540    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  1026    Yes   WARNING in __kernel_write_iter
                   https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
<4>  373     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<5>  288     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<6>  212     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  206     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<8>  205     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<9>  109     Yes   general protection fault in btrfs_orphan_cleanup
                   https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
<10> 91      Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

