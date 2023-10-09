Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118167BD6ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbjJIJ0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 05:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbjJIJ0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:26:12 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B802688
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 02:23:54 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1dce4259823so5826803fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 02:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696843433; x=1697448233;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65WZ9YFi5sn+6ZO5ERm1lg5G6uHSE9SWOH1rDCIdyGM=;
        b=X+qAuKYm7HGRsFhkysvGNhl1CA2tdNNehuOXMjXBeP7VmJJZBjWp0W5TFETiQSJrp8
         erkysZ6z12rzmxMJb90TcOL4WvM7DuEb3FAQaodXh5V4IWSD7kFe5QaXsZR49YoD2bVv
         nQpuA+7OhzCiqNKOJhYZWt3A3KTnKt+JDgLugAUUtcBY/T87Rq0oxgs14mlMvsRY2Fhe
         yAXkGDSai+knwWiJKkRNg+TSry2ktwHvhpk0BusUH/Brwz6muuHO55KJqjomvsvLjALf
         EeNLcs8xQpNxcA7dfi1kH3UIhT7sRIGwp7nRsOYktqCRpzxMsj7Lsv+gKYmpz01nY9qw
         qpeg==
X-Gm-Message-State: AOJu0YxlHycy6LjImxX0ZyF1ZyiMCdCjG1lgdlEHdi1H24d0ymG79gLf
        x2yZ3XMLSVvphbbQ06Jr7TifNgzes7rEdul/iXTMTxqc5c5y
X-Google-Smtp-Source: AGHT+IEo7V/AZ60BTZSRjftitTfIZGEo/othg1DNf/jnetxePrPeGLDsA/DxXHk0f5kAfjT9wev6fUz/dWFo2sLhafwDuEEpIQ6H
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c79a:b0:1dc:27f6:7a10 with SMTP id
 dy26-20020a056870c79a00b001dc27f67a10mr6163237oab.10.1696843432914; Mon, 09
 Oct 2023 02:23:52 -0700 (PDT)
Date:   Mon, 09 Oct 2023 02:23:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ef4d706074526cd@google.com>
Subject: [syzbot] Monthly ext4 report (Oct 2023)
From:   syzbot <syzbot+list12247b4500c0d653da52@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 3 new issues were detected and 0 were fixed.
In total, 38 issues are still open and 116 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4113    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  326     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  145     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4>  145     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<5>  83      Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<6>  46      No    KASAN: slab-use-after-free Read in check_igot_inode
                   https://syzkaller.appspot.com/bug?extid=741810aea4ac24243b2f
<7>  12      Yes   possible deadlock in ext4_xattr_inode_iget (2)
                   https://syzkaller.appspot.com/bug?extid=352d78bd60c8e9d6ecdc
<8>  10      Yes   INFO: task hung in find_inode_fast (2)
                   https://syzkaller.appspot.com/bug?extid=adfd362e7719c02b3015
<9>  9       Yes   kernel BUG in ext4_enable_quotas
                   https://syzkaller.appspot.com/bug?extid=693985588d7a5e439483
<10> 7       Yes   KASAN: slab-use-after-free Read in ext4_convert_inline_data_nolock
                   https://syzkaller.appspot.com/bug?extid=db6caad9ebd2c8022b41

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
