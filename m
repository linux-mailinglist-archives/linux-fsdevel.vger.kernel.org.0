Return-Path: <linux-fsdevel+bounces-4963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24E806C13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72F11F213D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8CB2E650
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF51A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:05:24 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1faf33aa091so9334599fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 02:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857124; x=1702461924;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBFRPreUwMTljyUE1zzowalqFoa0Lex9TFFc13yJQwo=;
        b=kwiyxKC6Px2Bj45hVPHcni5CeuAahYyRJJ3fNu8gN2nzpWU/p74kCl1IBQSkdgAMrX
         1otsFwY8s64cOENiE/mEQVSgMqZ9BG9fvIog/ZLlAJ3epGlmTcMjzN4+Jh60h2U8q8Pm
         r3ojjuTZa+PM67ajUb4nhNHV4qrNoaMy41d9yWB/LqhEdGsRvroWP5vNZ8oQWt8w1uPK
         u3Vhm6a+knZiB1SsJbm3BNNHs1sB7GHI+amKLgYqs3/HSlTsK4tgN4liwK7lnS1PZ462
         YP9msKmHbF4kqUcCAJSaekDKi5V4T9LsHvNFiikZjvjqUgIeAIVGZ/GB8r2KQ/LIXRaF
         WlAQ==
X-Gm-Message-State: AOJu0YxJf8gsnsmwM8mMl08JqG8A6oTSz1Jm6PYBfEYyfAptDaY98xfg
	UnmtFDRudS88iYYtWHjpNCmb2lE0H6cDwtsdBPiMdmHy6FDo
X-Google-Smtp-Source: AGHT+IGSWLFljIvDvOEMbKsUJgYM/g5+b6ijwkBwucrAIBsfqIfwMDBh/3kYSUtW9n1PAeDZFnbLK7qCfSBEQM7Lu0b0A52zv96w
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:158f:b0:1fa:f20e:4c0 with SMTP id
 j15-20020a056870158f00b001faf20e04c0mr778975oab.6.1701857122962; Wed, 06 Dec
 2023 02:05:22 -0800 (PST)
Date: Wed, 06 Dec 2023 02:05:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045d4c4060bd47dc6@google.com>
Subject: [syzbot] Monthly ntfs report (Dec 2023)
From: syzbot <syzbot+list46ee6100e7a589a627ec@syzkaller.appspotmail.com>
To: anton@tuxera.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs maintainers/developers,

This is a 31-day syzbot report for the ntfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 25 issues are still open and 8 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4839    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  3503    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  1691    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  763     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  416     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<6>  312     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<7>  290     No    possible deadlock in __ntfs_clear_inode
                   https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<8>  55      Yes   kernel BUG in ntfs_iget
                   https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
<9>  39      Yes   kernel BUG in ntfs_lookup_inode_by_name
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

