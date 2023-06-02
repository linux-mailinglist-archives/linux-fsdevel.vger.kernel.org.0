Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ACF71FC3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 10:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjFBIkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBIku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:40:50 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424F418C
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 01:40:49 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7603d830533so49707439f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 01:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695248; x=1688287248;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R21t3yxIGLscTBQIenn82agFv8hkbnPzy8Ffbly2fQc=;
        b=GNxs3BSFuP92cbXY6/QnVpv5KZJqt5EhodiB7DxLIAT90G31lSPoV+dGI2oLX2lRNc
         I6lJohgET8y0gPHeEtR45dy73Tx5pHXPGYw/5/SMpsRS4dOUlNoazUeWLKac8debrLMo
         E1GXXwtA/yLCrq3z82BtfkDDggogxrh6wb96oPogV0aYf4OGbvYg8dD099v4dHJFQjZD
         SRDu4FSSKPqAFcA6kZMFuhoZfEmkAtT2jIHrJWtN9r3ytvrzIAaVCInO39nWoG2IfEE9
         rFoTspt93nsFpaffRyp/AmcPQrQXXUPT1wlL446qrGGRZTmVCG3t4FLMjtU8/mfkFopH
         n3aQ==
X-Gm-Message-State: AC+VfDykHkGbgMzbNENBfT4xDdXVMXBsI4tFOUGfP7P/FU+9TNe8L/h3
        CGsIAcf7+rSrgsWrgQdYyNa5we2pIKVu9rzRLov0QDxSuAGp
X-Google-Smtp-Source: ACHHUZ7tm68wj2kCbhsNKE7zQLZeoOSQO31xd4HxX+TR4+/zTR6v1hDDvUFr/P0SZaxAsbGsTZpyloM/VJpeCl7MW/lUiHMeDEDG
MIME-Version: 1.0
X-Received: by 2002:a5d:9ec5:0:b0:777:127e:6dd5 with SMTP id
 a5-20020a5d9ec5000000b00777127e6dd5mr671109ioe.2.1685695248595; Fri, 02 Jun
 2023 01:40:48 -0700 (PDT)
Date:   Fri, 02 Jun 2023 01:40:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e054605fd218210@google.com>
Subject: [syzbot] Monthly ntfs report (Jun 2023)
From:   syzbot <syzbot+list96ce3166ad941b6ae46b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
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

Hello ntfs maintainers/developers,

This is a 31-day syzbot report for the ntfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 25 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2429    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  2284    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  879     Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<4>  392     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
<5>  285     No    KASAN: use-after-free Read in ntfs_test_inode
                   https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
<6>  30      Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<7>  9       Yes   KASAN: use-after-free Read in ntfs_attr_find (2)
                   https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2
<8>  9       Yes   kernel BUG in ntfs_iget
                   https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
<9>  6       No    possible deadlock in ntfs_sync_mft_mirror
                   https://syzkaller.appspot.com/bug?extid=c9340661f4a0bb3e7e65
<10> 3       Yes   KASAN: use-after-free Read in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=d3cd38158cd7c8d1432c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
