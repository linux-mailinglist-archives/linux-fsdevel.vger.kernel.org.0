Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B971584C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjE3IWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 04:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjE3IWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 04:22:01 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CEAF0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 01:21:56 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7749ceb342fso605957039f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 01:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434915; x=1688026915;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0PjtfHgEkkTfBjwGwBOt6JzxiRldvCH/yMO3ajZeos=;
        b=iZMYg5D2+wFhCqHC3LYrwb4H18fqISYoXtRGH1cidliE0xr4wVk46wYXHTAuEtgGl2
         AouldA9I0vu7ikvF+TPfMoOcmFDrGA3RQj21sVCnSUMY3kDOCUAQBZaA2N0zSXTKfz2S
         otWfRTZbfYdVjsVVlYwtCWmrRDYjpTnayqN10IbIbBaErhX8ekLEf4yfFenM7aBtOEo1
         9X8S+hjnEwJ1ReFHJLGLfOQ1ZDC0tV4HXgBnSIo97o9d1Js8T+KPIHz719VE23MGCemK
         rkICuDsOGC4UTkvNbGR3N1FPCZkqXgDfkau7OdlZQDILjCPgCdskBYblUdlXglIVsd4J
         1A0A==
X-Gm-Message-State: AC+VfDyNXi+NoTneW6VaZYW9ZgzTjUj8qXW1HIudV8a0k/o2z0dF7sOa
        7nwOUs7VMB1bfeJnnkHvAX0vw/80MXIzC1hw9TneGOR50FWU
X-Google-Smtp-Source: ACHHUZ523Nj7XJucoxcSG183lHb6UxLEmuDyK5jix5/bojPX6Kye3v5XAcW4PsK+YYQHIn3cwDhIjvbzc+E9MMj6421BV1wT0zGX
MIME-Version: 1.0
X-Received: by 2002:a02:298b:0:b0:40b:d54d:e5bf with SMTP id
 p133-20020a02298b000000b0040bd54de5bfmr778529jap.1.1685434915708; Tue, 30 May
 2023 01:21:55 -0700 (PDT)
Date:   Tue, 30 May 2023 01:21:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000716a8005fce4e592@google.com>
Subject: [syzbot] Monthly btrfs report (May 2023)
From:   syzbot <syzbot+list3e0431ddab075345f512@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 5 new issues were detected and 1 were fixed.
In total, 52 issues are still open and 26 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2986    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  677     Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<3>  424     Yes   WARNING in __kernel_write_iter
                   https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
<4>  381     Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<5>  370     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<6>  193     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  191     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<8>  189     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<9>  184     Yes   possible deadlock in btrfs_search_slot
                   https://syzkaller.appspot.com/bug?extid=c06034aecf9f5eab1ac1
<10> 151     Yes   kernel BUG in assertfail (2)
                   https://syzkaller.appspot.com/bug?extid=c4614eae20a166c25bf0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
