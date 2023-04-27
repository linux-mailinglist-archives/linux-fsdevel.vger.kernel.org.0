Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B136F0442
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 12:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbjD0KhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 06:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbjD0KhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:37:01 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727494EDC
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 03:36:58 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32a86b6ab85so58951275ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 03:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682591817; x=1685183817;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RnKvJRGuTj19/qeFfCObJ1mKSwbZtyjNqHI5nsZidCI=;
        b=Gi4jpqkZKCrswh9WMvPoiD8cfvUf3RwM5qBs83u4PIOkVyWKyBj7gHUzGL6fAxfS8z
         HM8isa1ePEqzFUo/fw5g84tO3/WggKyDJjUGqdsSOfeuOlJFCcTTe10uz9qY9uZN15js
         7kdS1OVuYl1z8o7W8/ctnTESOEFNLwJr4kUMTvLRa0L2qJ4EZWRjYQQpDodtq/j9PVf8
         7nDKeK4h4bE43XPhHY2wKIYnFf71mBOyZWPMyvLpU1/H0dmwXb/V9mKT6sd9KXbgyC1A
         X4zSA5jB1ZwpOUtH2+BjABdtqyrPm4hNpQmU8RfWFFCXMXLY5cUQwiiclrwXJfTSqnWN
         W84w==
X-Gm-Message-State: AC+VfDxlOxdJsyMdq4HZfV2p6E8sTO3yUpMVO8KfsVvSK41xnuYzxB69
        ALwUpZl44oF3rEVFAPrC5lYt2H3lefXTyC5ob6v1Q6bW1bEi
X-Google-Smtp-Source: ACHHUZ6SwoeQT/XLmwNrFtRoV/YVN3rzG4Cw/+wZIzYcGxb+fsStPZfJnPBiq+lGfhD2+Ahvdv2JuYGT2BXSEPie7N6Dbd3PO8G1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:548:b0:32a:9e86:242f with SMTP id
 i8-20020a056e02054800b0032a9e86242fmr996137ils.6.1682591817801; Thu, 27 Apr
 2023 03:36:57 -0700 (PDT)
Date:   Thu, 27 Apr 2023 03:36:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a2a1b05fa4eef8f@google.com>
Subject: [syzbot] Monthly jfs report (Apr 2023)
From:   syzbot <syzbot+listfa7b6ec26861d7b6f193@syzkaller.appspotmail.com>
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

During the period, 1 new issues were detected and 0 were fixed.
In total, 63 issues are still open and 9 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4032    Yes   UBSAN: shift-out-of-bounds in extAlloc
                   https://syzkaller.appspot.com/bug?extid=5f088f29593e6b4c8db8
<2>  940     Yes   KASAN: slab-out-of-bounds Read in hex_dump_to_buffer
                   https://syzkaller.appspot.com/bug?extid=489783e0c22fbb27d8e9
<3>  871     Yes   UBSAN: array-index-out-of-bounds in xtInsert
                   https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
<4>  594     Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  455     Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<6>  306     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<7>  229     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<8>  221     Yes   UBSAN: array-index-out-of-bounds in dbAllocBits
                   https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
<9>  202     Yes   UBSAN: array-index-out-of-bounds in txCommit
                   https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
<10> 136     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
