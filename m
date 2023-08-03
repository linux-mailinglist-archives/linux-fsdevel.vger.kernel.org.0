Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF58F76E0C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjHCHDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 03:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjHCHDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:03:11 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF33A87
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 00:02:51 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-187959a901eso804606fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 00:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691046171; x=1691650971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ub/xbfPlZpojg8/OoN0aL5GP8HdKwgPpTd7mwazWUX8=;
        b=ELl3l8dL+3nRrNhr3ZE/DZQvIFz2Hsi+9YRfCoXG18rcrJBQAMwPAYUr1LLUfqdGSe
         5q8ceRPPtxsa5u6wwx3ckagdV8Jt6dB111YRob5SCYOHwImbHyLyUhVIQ9V/zcxn+PoK
         sCfvgvhOv5FFZqoOM/4YYm44obWPRiZ5aaayJvdAIBr2D+ylbJcLqaRFbZeKOGZDRPvV
         lHb3FRlY2WQtHNjaXaXsid4OTTsy+ehq3FLbzBxmFOjvRxgBNlQOJyfN2Qjbix92Idls
         O8veEaZycnVbdnRMMkPQrPJXpQCDCyG9jT7g9dSJEx8FUOszxqflxovv6ddf0LA2GIU+
         /tbg==
X-Gm-Message-State: ABy/qLYIpyovXISosnO1szcSZ8cC01e6QJZIGzzK3qwO5KEVtwAND6G7
        O2qSd3OXukRvehKex5d/0VQJlgUQNfdxeNcQ+3sH3/ADXt6M
X-Google-Smtp-Source: APBJJlHC+53K0z0PJNrt9FGKz8CCrzg+6kRSqTZAuXgL9WmfuW8+o8NjzldBQLmzKrgdJWqmCKM9XIOCbsv0tsMZkMNm9yf2tSH7
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d899:b0:1a6:d518:f72c with SMTP id
 dv25-20020a056870d89900b001a6d518f72cmr18423230oab.11.1691046171028; Thu, 03
 Aug 2023 00:02:51 -0700 (PDT)
Date:   Thu, 03 Aug 2023 00:02:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052b50a0601ff5eb3@google.com>
Subject: [syzbot] Monthly ntfs report (Aug 2023)
From:   syzbot <syzbot+listc96f9b68a1099993c28c@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
<1>  3467    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  2820    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  1153    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  548     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  348     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<6>  294     No    KASAN: use-after-free Read in ntfs_test_inode
                   https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
<7>  184     No    possible deadlock in __ntfs_clear_inode
                   https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<8>  24      Yes   kernel BUG in ntfs_lookup_inode_by_name
                   https://syzkaller.appspot.com/bug?extid=d532380eef771ac0034b
<9>  17      Yes   kernel BUG in ntfs_iget
                   https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
<10> 13      Yes   KASAN: use-after-free Read in ntfs_attr_find (2)
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
