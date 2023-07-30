Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D428F76857B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 15:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjG3NR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 09:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjG3NR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:17:56 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4910D9
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 06:17:54 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9ef9cd887so6320132a34.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 06:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690723074; x=1691327874;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DN/NwMQSSmEyeXUy/JqySJAwzeOWiKQPt8XalGWlj14=;
        b=QywOHG+Ee74wiaeLMZEYHr/8PA3aKqCfMoYj2DtJPLG5aoaozgcCoDkmowDxcx3v4D
         ZJCMgZoMYRnH/qeujAsTueporW/1a5ee/F5No0zSDjwL7s6wiFlT+DCC4IOgVrZez7t3
         vbFdY6dJQL4IlPu38ruPq6DqGtBgB+yS4ZKSeMiUtcUnNjnZqBKSHLHd+nVJhI50iYhL
         g4OjRL85rEyhOVPXrH6TZuTk+FQICXR3V3Pswcn4eFkRX+dpKOS6OrfTcKrbOR0GEx18
         DSwf51PXgiuYNfe4+RPzYKF/DNWFuxSUAcTsTlw779wloCdrgZLpyDDzxJDjVvWQ3YIS
         6b/g==
X-Gm-Message-State: ABy/qLZMLvddXnkn6FaXt8hk1JoPW1sMGUJjABH3TZAslBslmlkFmT0o
        SMi7jOpCXhhDefhHUAuB3kLuPsrijLYHgAIhiGJDnT3rKPtDhnE=
X-Google-Smtp-Source: APBJJlGrLFCPBcZhZZpFbvilOCZqY47DmMjQnh6+9HgFXVZEgA/fppqfROUi66OylB8Z0xycVDFJ3VaR6sAS9MEfRS22RFqhPoW4
MIME-Version: 1.0
X-Received: by 2002:a05:6830:26c4:b0:6bc:6658:2d3f with SMTP id
 m4-20020a05683026c400b006bc66582d3fmr17346839otu.1.1690723074355; Sun, 30 Jul
 2023 06:17:54 -0700 (PDT)
Date:   Sun, 30 Jul 2023 06:17:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042b7580601b42493@google.com>
Subject: [syzbot] Monthly hfs report (Jul 2023)
From:   syzbot <syzbot+list8eb6f1b0cfe8cc6fe9c0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 50 issues are still open and 12 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4292    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<2>  4190    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<3>  3573    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  1748    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<5>  847     Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<6>  813     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<7>  602     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<8>  549     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<9>  363     Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 328     Yes   general protection fault in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
