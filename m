Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F057457EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjGCJED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjGCJDy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:03:54 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9076E43
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 02:03:52 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b7ffab949fso57251845ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jul 2023 02:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688375032; x=1690967032;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RE8LSychG4k/uRGiRu7xh8BUIXkRlq01gkyPncQ19GI=;
        b=YhRU87gpuIXjRzH5+6eafMXssVagFT/oD3RfJIWcQ5XiNfzgx1QmuOXcby+wqAUE0Y
         4BAvQgse8YN1YHsfzyaY7Ih/+6Qi2s6L3gKX5KvG0NHdBfg4ymTNM9az2wLyKhH6a4U/
         +4ZTLZDiFcgzdBLmGeqbYY0jyS43uZkCluvUNG+cJuTJ0ZtPReHYyGz8LdEjt5DZjrSb
         NqIqBhT6TQQLpseA2XDcilaKh5a3mmuojSr+9fYD2pfSmXtEO3Mjkahxibsz4koLiFEV
         s625V0nOtNnn/LCURL+np136EipA7WuDZFCl68VsSWm/0qDWcLqCvzpfwq73SUILEJgd
         bbBA==
X-Gm-Message-State: ABy/qLZX0iCjqPwgFchvRcbcve0NLauwvB52dz/W2TQf6+ONlIGXnal5
        6qwpFMQm+4E8vr71YiTj7NzPkRWEBTcZLZOtGEga6TBoed2o
X-Google-Smtp-Source: APBJJlGgiSo7l8Xu2RlauE3GVDBEzAPKvzzZBhSGghuhfclcyczoWXKXtBcxWNc3wYwNrMIGADO75h6BHTlwLi9bv+Z940+0zzSb
MIME-Version: 1.0
X-Received: by 2002:a17:902:e5c5:b0:1b3:e4f1:1b3f with SMTP id
 u5-20020a170902e5c500b001b3e4f11b3fmr8323989plf.2.1688375032438; Mon, 03 Jul
 2023 02:03:52 -0700 (PDT)
Date:   Mon, 03 Jul 2023 02:03:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e649505ff917257@google.com>
Subject: [syzbot] Monthly ntfs report (Jul 2023)
From:   syzbot <syzbot+listbbc971fb2ba71e0cdf0c@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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

During the period, 0 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3110    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  2554    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  1043    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  488     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  289     No    KASAN: use-after-free Read in ntfs_test_inode
                   https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
<6>  157     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<7>  156     No    possible deadlock in __ntfs_clear_inode
                   https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
<8>  78      Yes   INFO: rcu detected stall in sys_mount (6)
                   https://syzkaller.appspot.com/bug?extid=ee7d095f44a683a195f8
<9>  15      Yes   kernel BUG in ntfs_iget
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
