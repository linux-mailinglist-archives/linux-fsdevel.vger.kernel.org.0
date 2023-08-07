Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6813771B72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjHGH1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 03:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjHGH1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:27:42 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C953410EC
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 00:27:40 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a36b52afcfso7579174b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 00:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691393260; x=1691998060;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUbPdw/WHixDUwAM+XV8XAAuCE9atwHum3A8M0t6MKI=;
        b=KT/TD51zFlVdXf31PnWrS16/RgkB6biKe3a3HeTq67cvwDabUgHKxOhXCsJGvAm3wS
         B94QzoDNqXjrjenyiMmtb4ubdR202KdW5CIpz8rawtjbisfHOMqLIAXCr3xEFvWtEuxT
         yJRGvGQvkX4BCtcyExD6N/sWZhS9JMXuS362DZ42Ula0bdRkjjJ5By6NL0TwdgyCweYn
         HOE+i+YSlBs/PENM/NYPejZ/xjcGoUrDdeVYuOzS/WfMgJDA+tCKxTp1JfyCQeXnnHWG
         prij+Xkhye55ZEn7bx6lcK/+YdEZn6KZUF07DCl2I+Gyn55nBqBN4En9zAkP9fGoMscE
         Eklw==
X-Gm-Message-State: AOJu0YyUCcLFCjdQumdjWFDiBA1GTIyG0ZiVxp56qAP085baSvZmLIJy
        qiGChs724Qq9GEiUdGznWXq6m7+SIWOeqnZ6Bfvfwh84uKl7
X-Google-Smtp-Source: AGHT+IH6upf6mL7yqbt5+r+BZdRN0uFBdnaPLwk+OE509Y9yiXP3LeaG/gcnHANtvL0K14ODC/NO/n8bp3/opW3RkiDgijYDzzVp
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2087:b0:3a7:61dd:f481 with SMTP id
 s7-20020a056808208700b003a761ddf481mr15939875oiw.11.1691393260188; Mon, 07
 Aug 2023 00:27:40 -0700 (PDT)
Date:   Mon, 07 Aug 2023 00:27:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072fb0f0602502e61@google.com>
Subject: [syzbot] Monthly ext4 report (Aug 2023)
From:   syzbot <syzbot+list92c148f1726ccb5c7913@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 6 new issues were detected and 1 were fixed.
In total, 49 issues are still open and 113 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2159    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  178     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  125     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<4>  85      Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<5>  52      No    INFO: task hung in __writeback_inodes_sb_nr (6)
                   https://syzkaller.appspot.com/bug?extid=38d04642cea49f3a3d2e
<6>  39      Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<7>  26      Yes   kernel BUG in ext4_write_inline_data_end
                   https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
<8>  9       Yes   INFO: task hung in find_inode_fast (2)
                   https://syzkaller.appspot.com/bug?extid=adfd362e7719c02b3015
<9>  6       Yes   KASAN: out-of-bounds Read in ext4_ext_remove_space
                   https://syzkaller.appspot.com/bug?extid=6e5f2db05775244c73b7
<10> 6       Yes   KASAN: slab-use-after-free Read in ext4_convert_inline_data_nolock
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
