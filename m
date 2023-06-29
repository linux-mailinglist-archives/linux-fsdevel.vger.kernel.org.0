Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FDD742305
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjF2JPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjF2JOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:14:54 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6051FE8
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 02:14:53 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-39cb2a0b57aso653292b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 02:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030093; x=1690622093;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guSeZzio6DeBpUvNz5ZbXE9spb2zWqeyg0XMCRqaFGc=;
        b=Xig/bWj9xmxVrdDpF//+HOHWIw5P4+3WTRdY4P/cmx/MyGLdFIZtIZyK7RmMi4cisY
         DDN+OwmblOxV0mKkHFiwMhpQ/VBxtexx5eLFe4ng4R7O+zV8YvLuGwbI2p8JbFm/otha
         cLNTjcYFTnI4JM4vRpqKzSmzIjHt6EBFNrHQNTuhOWebTJQICEGzmk892VBSGIOQHWVi
         u+cLa7l11SsU9Z6PTz3EfXgNC15rq3+BAFxliGKhBB0BYpMHjqDJRNOeC5goUcqR4Bi/
         +cxdUvIpagr460y56ytaDHdg13JS6AzEz9q5Q7zlPPcYCr3AGCho++Pab1YgtLqvID/E
         0oLA==
X-Gm-Message-State: AC+VfDwm7MGYMbzlu6k8d7+d8WkBLIhRcCenQgQMonnDD39icZtAN+hV
        TSNbvneLqg1n2X4sSnC9lMQmRcuhiuqacZ0HnQdrVh+PFYxQ
X-Google-Smtp-Source: ACHHUZ7zwyea4dRcV572ExkN3Nn0grVzvDPd2A9OfjCiGSWEMaCIxRs4HxY4ZL5YDA/OtjyrmPgBOsTEvSP1Dinya+qErSIKeZvq
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1902:b0:3a1:f2d4:a3bf with SMTP id
 bf2-20020a056808190200b003a1f2d4a3bfmr3898435oib.4.1688030093010; Thu, 29 Jun
 2023 02:14:53 -0700 (PDT)
Date:   Thu, 29 Jun 2023 02:14:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000106e2405ff4122ba@google.com>
Subject: [syzbot] Monthly jfs report (Jun 2023)
From:   syzbot <syzbot+listf4063fb66388de6326a1@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 54 issues are still open and 12 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5157    Yes   UBSAN: shift-out-of-bounds in extAlloc
                   https://syzkaller.appspot.com/bug?extid=5f088f29593e6b4c8db8
<2>  962     Yes   UBSAN: array-index-out-of-bounds in xtInsert
                   https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
<3>  885     Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<4>  610     Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<5>  475     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<6>  307     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<7>  289     Yes   UBSAN: array-index-out-of-bounds in txCommit
                   https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
<8>  202     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<9>  137     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<10> 95      Yes   KASAN: invalid-free in dbUnmount
                   https://syzkaller.appspot.com/bug?extid=6a93efb725385bc4b2e9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
