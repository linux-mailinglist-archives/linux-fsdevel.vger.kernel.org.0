Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8EC6F06A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbjD0NcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjD0NcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:32:01 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFAAE48
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 06:32:00 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32f23e2018fso31685095ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 06:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682602320; x=1685194320;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYNDkNlssYeEvJ/nZkTIpRa6vWKXHqLzLEeL2il8mag=;
        b=QLsiAGFvNcxI5aIwmiwvkp8WQ/v8KTfH620JhiALOgUSmjmUSdMFwp8Y+Vi3KREeX/
         4a6uXzFuukMttM0fW9D9jCLo4UTU/Y+6VVrTBs4TUd/L7J2pZajOFh2cs/DGOXsXwTEU
         as84bMikVerM94UUamApCL/7LV64WjoCNmG/llsf3yHWoSQqCLf8hP4lnp+rYtgchik3
         UqWyik9IcM9s90R3+4NVJsoU5ocCGP4FoGP99Kypny9V6qmpQhTuetoocxsMUNf9H+xa
         6FB5cP1TIgcuAG5eimAQIvap0VeDgFmeRcvwdOQvI2XSKjE77dl4pv0aUw5kNtgsNBUL
         7ueg==
X-Gm-Message-State: AC+VfDyP4GZAVXv8+uzsnAhCl2TtKr1p/ydlGz11F9I47WZ4RVZrV7Kq
        /19XPl2nkx3g7MHwMWLASHQ8z8y8RiWDEfArjM3GjdN0yM/EsF0=
X-Google-Smtp-Source: ACHHUZ7esXps7Py0UcgkwpWuy4MH3u19lAcFOhGa6rQvnORb9swol5LQffTpND8nK5FaUh+nOm5EFIrTlwnAkTkAWBLPAcI6432w
MIME-Version: 1.0
X-Received: by 2002:a92:da42:0:b0:326:534c:9d47 with SMTP id
 p2-20020a92da42000000b00326534c9d47mr1386776ilq.0.1682602320160; Thu, 27 Apr
 2023 06:32:00 -0700 (PDT)
Date:   Thu, 27 Apr 2023 06:32:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097715305fa51613f@google.com>
Subject: [syzbot] Monthly hfs report (Apr 2023)
From:   syzbot <syzbot+list9a789e30a426b947eb30@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 6 new issues were detected and 2 were fixed.
In total, 44 issues are still open and 12 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2412    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<2>  2196    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  2098    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<4>  1084    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<5>  511     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<6>  408     Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<7>  401     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<8>  222     Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<9>  205     Yes   general protection fault in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2
<10> 146     Yes   possible deadlock in hfsplus_find_init
                   https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
