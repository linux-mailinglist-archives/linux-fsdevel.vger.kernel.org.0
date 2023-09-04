Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB0A791374
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbjIDIb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 04:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjIDIbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:31:55 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2B94
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 01:31:51 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bf60f85d78so18041705ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 01:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693816310; x=1694421110;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2OmTOCFNK30sKwAH23PKfFifyHLUed/0eso+ICjivA=;
        b=cc/8kMAX3rlzWJS7coasz8BvI/nPwYyn2TrHGMwqpQrw5uezdQEUgsLUOtGlqLrWRu
         nvlxbY4JVqTozVJPDFdQ+VTBdIdjy2qswFkkcap374p6Gmv623ndXGsf2Luk6/+1IW+Z
         mLQmgQq7dwS/LRsoqUFQtgXJY80zxJrKV8A48OMBgpzHzpQrWdlsDpBrTSv3HShMN/fo
         spjDwP8PiRUt0OxFypz6icWwrRYMkWsioVTjENZu8l73C8klCLctJTHhxiS1/tRIQDWA
         HDbt41SlFcPhBK96dKae5BJuvbN3JyNyrs9jpPUB1+yhI6+IEAQOzVSAKYwa0cfeX/fQ
         T5XA==
X-Gm-Message-State: AOJu0YyjMdsJuxClNc8PJg3XSZvjz4g7fxvJ85a9OxZ/TYdMUrmMZYSV
        QJV/jGztJsVO4pY0IjsIsVQJcnUYYuWyYOT0+pmDlNhvMwEN
X-Google-Smtp-Source: AGHT+IGpt2ftf95l/L/nnDQ6ee2mdYHv2fp0o/2P7wmxTTVnU3kxj0nn6GNWriZkj427vEzU0WNk8O3FJ074X+K9J6bLpneNwz1b
MIME-Version: 1.0
X-Received: by 2002:a17:902:da86:b0:1c3:2af5:19e5 with SMTP id
 j6-20020a170902da8600b001c32af519e5mr1985746plx.4.1693816310722; Mon, 04 Sep
 2023 01:31:50 -0700 (PDT)
Date:   Mon, 04 Sep 2023 01:31:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083fba206048457b2@google.com>
Subject: [syzbot] Monthly ntfs report (Sep 2023)
From:   syzbot <syzbot+liste99d2b62937cf3368a1d@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
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

During the period, 1 new issues were detected and 0 were fixed.
In total, 25 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3784    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  3075    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  1303    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  604     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  388     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<6>  297     No    KASAN: use-after-free Read in ntfs_test_inode
                   https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
<7>  211     No    possible deadlock in __ntfs_clear_inode
                   https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<8>  33      Yes   kernel BUG in ntfs_lookup_inode_by_name
                   https://syzkaller.appspot.com/bug?extid=d532380eef771ac0034b
<9>  28      Yes   kernel BUG in ntfs_iget
                   https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
<10> 12      Yes   KASAN: use-after-free Read in ntfs_lookup_inode_by_name
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
