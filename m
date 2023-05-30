Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E9715832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 10:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjE3ITC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 04:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjE3ITA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 04:19:00 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4BFA1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 01:18:59 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-33b529bc230so26409405ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 01:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434739; x=1688026739;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzJGOmbVf2vGWXZAk1CwMi/eEw2fCRF424dJDluVOBA=;
        b=bY6B4XROProZkQj5ES20ELvztqsCYvB+Se2OiYhVnrrSrplWrdmdKoXVu4sZsSFMcs
         U11WqngX6SyYkEJRLnc9XBn7D6MI4EDNGFAMyZ0yQvd6RGG7KMrnwgN8y+zH4Waasw3Q
         LqutzeaH452I4bzBXdoqMyCEiTSVYsyDkK6qN6SS7DxtwykXn29EYkRK+J9aMGCSlbfy
         dmttkeFBs6kaPa1TTOKk9jj7Xq+gQd+prcwpXF5B1iNOBIZ9Mxbu0xjIX96G3n93GiKD
         Ll0xrg3V11CjHb1eqYUdpQnAf4peVutuKLuT8gQBnaZZj8yMQbuWharbLxH+ziwZOXcY
         kmmg==
X-Gm-Message-State: AC+VfDzVEimz0kERQmE1v7Ny3tquUTj3clcaKHX6F95PwurC+IK5b6+k
        yrvDtqkw/opY5L35Ei0wMU4XTkMCCzdlMqfCJB138zp/yAMBpf4=
X-Google-Smtp-Source: ACHHUZ4Ygm7vxaf56lJal08JWTNusMW1mjN2PfD+Mw4dtZGXk9xPfS73Uc6IZh81XkuVCxmdrzt9W+KXt/YXbYmeQ727l3K6zOKx
MIME-Version: 1.0
X-Received: by 2002:a92:d8ca:0:b0:333:760c:8650 with SMTP id
 l10-20020a92d8ca000000b00333760c8650mr748733ilo.6.1685434739250; Tue, 30 May
 2023 01:18:59 -0700 (PDT)
Date:   Tue, 30 May 2023 01:18:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecdff405fce4dade@google.com>
Subject: [syzbot] Monthly hfs report (May 2023)
From:   syzbot <syzbot+list847d0bf1e8217efa87ab@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
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

During the period, 3 new issues were detected and 0 were fixed.
In total, 46 issues are still open and 12 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3125    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<2>  2749    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<3>  2495    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  1339    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<5>  658     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<6>  565     Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<7>  541     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<8>  452     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<9>  291     Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 233     Yes   general protection fault in hfs_find_init
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
