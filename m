Return-Path: <linux-fsdevel+bounces-4685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE6E801DBB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 17:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8917F1F21061
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D71DFC3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 16:31:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2B198
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 06:45:22 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fb0a385ab8so1331976fac.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 06:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701528322; x=1702133122;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJ+HK/57SrNL+umRt6DpFtBi1spX/Qk4kvhA68cafI4=;
        b=DfC+m35uXo49yWCteGuNtdxvQKGAIz4sG9el+YhNEcdpZ2M/LVkWjsmpoB9ow34nPp
         NwU1OLRSn/sS+sNrvIHmEvd5TTJpHHjHbmhrNpOLk7Cw3C11P6gtHz2qM5Q1RRGIOI4I
         1j08v7k13o/CXx1TdQtVFBTcG0DaatqiuN32LRQ0dvOP0/PfvOMl2LPOoFUhpyI+wUz1
         D6hag0XX9HRuurmyqJy7KTXwLqbMFZ8nW18PKRvPUARAnjhWDzLUQ/HMxxinvZp9y04/
         rL/M0xAfrGusO34sbXqrYvkUl+nHtnSGqyAnZ1xPiHnke43CCxfmhPru3y6CjcCH7Z1M
         E9LQ==
X-Gm-Message-State: AOJu0Yxn5QKOaGAL+nnvPBsYKAHZ87iU3nxNzmxHd4bugYEmxSS14HjP
	DUMGgNIZN1H283QCyTnY/HsUgXH2vXmx4mkQ7ezwcmyjN3N6
X-Google-Smtp-Source: AGHT+IGicoq0MmWqtro50KVMIzLkQtw//H6rkSt+wf233vNaE87lUhU/Mp+LljrqWLOGrXr5E4ZBDnDvoDLlzihe3NjPj1F/xWQR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d252:b0:1fa:ee9e:85d5 with SMTP id
 h18-20020a056870d25200b001faee9e85d5mr683657oac.11.1701528322317; Sat, 02 Dec
 2023 06:45:22 -0800 (PST)
Date: Sat, 02 Dec 2023 06:45:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a2370060b87efc3@google.com>
Subject: [syzbot] Monthly ntfs3 report (Dec 2023)
From: syzbot <syzbot+list782c9445342e49a6357c@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 3 new issues were detected and 0 were fixed.
In total, 57 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11352   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  3624    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  2143    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1875    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1451    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<6>  1359    Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<7>  691     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<8>  550     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<9>  527     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<10> 311     Yes   kernel BUG at fs/inode.c:LINE! (2)
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

