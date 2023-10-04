Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8A7B8069
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbjJDNN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242598AbjJDNN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:13:58 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F7C9
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 06:13:54 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ae12e140f7so1031647b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 06:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425234; x=1697030034;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrcW4OMT1QMOjaQ9UXk5pKoLRn9s24eN4xvLuRY+D14=;
        b=pmYY0ARNWDbzHsJjTEQFTgn1IXiG8aa+pCDOl45gnwbWK5a1KrA3cT4RuB/Ub4cTOg
         GoxpJ+U3no4QNxIivbH3GzDai6f0V0z8y4hiqjpcQCJVqrydX90dlbsBMcK6fF6Xc1qe
         9exXpZ4sKb/8+/aNu30/m6WZtk/Hyi+M3pK02pmP0iaZyZELMCDngpcNM0+HPKPj5bB0
         Ie2ZqANfA8BCDOjKFUbXNY3prPPDRC9h1+GtlxdKRNnQPEzIKTssacDZD/wVDplKf2Hu
         khyC3GMHkymXgQPPMjFrlaJxQxkY/VhTBbFQ5maPZHC6LQVAY16ZkMkQ3XhPFTV9559m
         zMfg==
X-Gm-Message-State: AOJu0Yw6SMuJLMW5lJdzyjWlcRo2FVcDqpbH1zwDlXiXnDODgfttAGQF
        +04Vw65y51z+D+oYvrSp8q+LbH0H8xwidCXluNXIxSbDRwADufU=
X-Google-Smtp-Source: AGHT+IHfDRUg7LqJhb2wepdOvTrAtQ+X55IqtXgukamAoigNDNBji4oayVC5qOh3f/D4cqZ9GElXomYojFteURQoI/PzFNA0sUfH
MIME-Version: 1.0
X-Received: by 2002:a05:6808:159e:b0:3a8:45f0:b83a with SMTP id
 t30-20020a056808159e00b003a845f0b83amr1015537oiw.5.1696425234065; Wed, 04 Oct
 2023 06:13:54 -0700 (PDT)
Date:   Wed, 04 Oct 2023 06:13:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076edef0606e3c739@google.com>
Subject: [syzbot] Monthly hfs report (Oct 2023)
From:   syzbot <syzbot+listd1c4248b878628705b59@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 12 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5228    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<2>  5043    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<3>  4160    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  2205    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<5>  1178    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<6>  831     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<7>  660     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<8>  637     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<9>  458     Yes   general protection fault in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2
<10> 438     Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
