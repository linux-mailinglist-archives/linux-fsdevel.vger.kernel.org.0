Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723EF6F3E50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 09:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjEBHSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 03:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjEBHSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 03:18:04 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D44F199C
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 00:18:03 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32b5ec09cffso21225385ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 00:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683011882; x=1685603882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bGDIlkDxxFqSuivhjP+N46X1p0czCiK1PSmGIY0DZuY=;
        b=MaxilJLgz4wY4tSDrhEtMi2vbL6LkwRDTOZgCdTQUf4dNqIN3cr6AoWx/TeXIqP4QA
         x0usWZtrh3Z8t0gHEwa7UvHJBKUZKnzDNMcuqsvh7sXsakCfRMA71D/MB7Q55hBtEY+2
         kbqIPEjyw/PQM02NMtqanLxAoemzqB1K8pPJC1JpGRacCnh9Obn42cM85XFaj2LQBl3z
         CeOAhmhOcZWmH/LRS8epgKFc+TdPWCXC5al71wPfcn9c/TTqEnnv4cjWGqn9Dca+xcvt
         E/tD16KEAEd6yxDIP7GGezmE2hxgFn4OKWwI9Hk4qnVKGH17L7UPvcOfBt0BEZmnopdm
         2uFw==
X-Gm-Message-State: AC+VfDyJrdwbA1JFhG8oOfGzCOYX7r/fzLfi+BJN0zkzpYeGaqnd6Nkq
        z1RRjJdBXo9ToduR6H6ssBsnnV8+Y4WlS4GE4batLCfvufWD
X-Google-Smtp-Source: ACHHUZ5WdXTPrltbDa9DEpV9Woa+A1fHqQv3s/WzHfp08bhmG4pdlcoMjcCRsUqw1JKwjYmAajbeaffbFalVoe4jQFBYU2fsAq4h
MIME-Version: 1.0
X-Received: by 2002:a92:d983:0:b0:331:339b:c3e1 with SMTP id
 r3-20020a92d983000000b00331339bc3e1mr185576iln.3.1683011882590; Tue, 02 May
 2023 00:18:02 -0700 (PDT)
Date:   Tue, 02 May 2023 00:18:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a2b9a05fab0bdfa@google.com>
Subject: [syzbot] Monthly ntfs report (May 2023)
From:   syzbot <syzbot+listf90b51a0db1f57e4ab2b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello ntfs maintainers/developers,

This is a 31-day syzbot report for the ntfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1983    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                  https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<2> 1317    Yes   possible deadlock in ntfs_read_folio
                  https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<3> 763     Yes   kernel BUG in __ntfs_grab_cache_pages
                  https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4> 281     No    KASAN: use-after-free Read in ntfs_test_inode
                  https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
<5> 238     Yes   possible deadlock in map_mft_record
                  https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<6> 134     No    possible deadlock in __ntfs_clear_inode
                  https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<7> 24      Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                  https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<8> 6       Yes   KASAN: use-after-free Read in ntfs_attr_find (2)
                  https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2
<9> 4       Yes   KASAN: use-after-free Read in ntfs_lookup_inode_by_name
                  https://syzkaller.appspot.com/bug?extid=3625b78845a725e80f61

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
