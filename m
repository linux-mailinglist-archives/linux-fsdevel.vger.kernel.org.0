Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59D773D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjHHQO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjHHQNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:13:22 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE167EED
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 08:47:31 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-686db2bb3eeso4257133b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 08:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509651; x=1692114451;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8YDGf6Dm5bfzl8CozS5WyC56nf5MVDnOuABuB/Ukn4=;
        b=TB3TTlyaWbQ2tAONO8uumV0JPxpHauCGKV0KSF80XZS9LxI+Ci6ee2cssWmjwP3xzz
         qForCuZ5OjoFrYPFvBcVe5TE1xeSZqF/QWeCmgFllN53A5kXqgr9W8YfqR1qHcK9Y1x3
         qprvDND7YDtTQKkOgMa5y4skCyLdferyGHnIvVV8rIPudVzopFoXbaSZNbOYxdD+RM1b
         GJlOBHEneHjE9XFnvYI90EWP5/EvVQkBPH9PVYNh7yqqYWxXoH9JQOS03B+bZT3LHe1F
         YOEPzCn/aK2D62UdH2N13apDmqkBtD2RB6PF9fitMQGosLHsz60YpsqacuqSH1sNIGJp
         FguA==
X-Gm-Message-State: AOJu0YztfWE9XcpzhwHPKW+A1v50DyWOiG2cqXKgO1rB8yadNrlbFLcR
        zyCFIYrygsklYIclxmSCiVrgun91nZiBCYNwd+PkbDzqpqX7ySQ=
X-Google-Smtp-Source: AGHT+IFixi+1yc1yTH4mx4Xf5OrmPTh9KOmPjprukSt7oe6VTsQMsbzV/ZEEuKRqevAJ8XOFwrqB8msvNghHsdIBCpnXvQ+YzyJo
MIME-Version: 1.0
X-Received: by 2002:a9d:63d7:0:b0:6bc:fb26:499e with SMTP id
 e23-20020a9d63d7000000b006bcfb26499emr6695466otl.2.1691499322068; Tue, 08 Aug
 2023 05:55:22 -0700 (PDT)
Date:   Tue, 08 Aug 2023 05:55:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ad2bd060268e001@google.com>
Subject: [syzbot] Monthly fs report (Aug 2023)
From:   syzbot <syzbot+lista41a75f5a209d3d79bf1@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 9 new issues were detected and 1 were fixed.
In total, 55 issues are still open and 327 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2854    Yes   BUG: sleeping function called from invalid context in __getblk_gfp
                  https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
<2> 2535    Yes   general protection fault in iommu_deinit_device
                  https://syzkaller.appspot.com/bug?extid=a8bd07230391c0c577c2
<3> 2178    Yes   WARNING in firmware_fallback_sysfs
                  https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<4> 1279    Yes   possible deadlock in input_event (2)
                  https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<5> 267     Yes   BUG: sleeping function called from invalid context in __bread_gfp
                  https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
<6> 140     No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<7> 37      No    KASAN: slab-use-after-free Read in __ext4_iget
                  https://syzkaller.appspot.com/bug?extid=5407ecf3112f882d2ef3
<8> 21      Yes   INFO: task hung in synchronize_rcu (4)
                  https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<9> 20      Yes   INFO: rcu detected stall in sys_clock_adjtime
                  https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
