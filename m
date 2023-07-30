Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B85768573
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 15:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjG3NQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 09:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjG3NQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:16:52 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B95B1AE
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 06:16:51 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6bc4dfb93cbso7096016a34.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 06:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690723011; x=1691327811;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGVUirxVTDZ7vJHx7E2WkvsFtu2tIh0g/z5nRixG5LQ=;
        b=jbEQAcYl2c7IDx8KWluLVgci4oPpdlR9OhPtyzE/yxeRLQwuzWuTkjTFC/hKR6mns5
         Wmdvs0RShDwqzbyF4AthPsM+Hip/ZJrVprpeidGIAzSUywURV9SHUIL+Ec4kZC9I3ic6
         zb7JVGbaGM5sABkrO8wup7aI/4EpTjALuRZtnOuWaMUu0rP79GErN4gssgbHMBh3NAwY
         mXsM1RBMAlYkfUXL1UXqELWEawJSQ6AWVkN0rcqpJr83o6mJ/6eb4gaJzFTt28ZuLRQC
         M20VNr95oyz5FnTlm7ZBW/miy9wK4yY6ba5M9NJcGpHhoBoyOo1oTFxNrnSDAg4omdnp
         EmDQ==
X-Gm-Message-State: ABy/qLb3RtIAm/EMZHpRIdA0p/FBmhIj31ZOut8PWSWvZ4G3Ia17r3Cs
        is29yHnvqQt7zi6OJsqS0T59ZsHLOgablTQGg3EnWiynz4pC
X-Google-Smtp-Source: APBJJlELZvKOcEMzlyL5FN02V7iwD/Wiz1fiY/pl6RhA5Z/G4zWxNMQ1IKl1Kngkm7uBKI1zTQfgrnzcsrHqxLvCLOctEzlZdobJ
MIME-Version: 1.0
X-Received: by 2002:a9d:4e9a:0:b0:6bb:2244:cb72 with SMTP id
 v26-20020a9d4e9a000000b006bb2244cb72mr8840045otk.2.1690723010882; Sun, 30 Jul
 2023 06:16:50 -0700 (PDT)
Date:   Sun, 30 Jul 2023 06:16:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a34010601b420d6@google.com>
Subject: [syzbot] Monthly jfs report (Jul 2023)
From:   syzbot <syzbot+listd87de47c524d3cfa086b@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 50 issues are still open and 13 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1009    Yes   UBSAN: array-index-out-of-bounds in xtInsert
                   https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
<2>  992     Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<3>  686     Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<4>  560     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<5>  343     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<6>  312     Yes   UBSAN: array-index-out-of-bounds in txCommit
                   https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
<7>  215     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<8>  150     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<9>  93      Yes   KASAN: use-after-free Read in diFree
                   https://syzkaller.appspot.com/bug?extid=1964c915c8c3913b3d7a
<10> 90      Yes   UBSAN: array-index-out-of-bounds in xtSearch
                   https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
