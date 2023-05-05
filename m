Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428196F845E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjEENvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjEENvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 09:51:40 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED976A5DE
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 06:51:38 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33117143894so11640355ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 06:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683294698; x=1685886698;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5yJe0ucTNR5LQU+mWFKPT+Eu3Uj6CjrEWiPxsQOsWg=;
        b=Cl10Y5rj0Cyi/+fkEAu4cR61/hcBo0hVbNv5Uo76qnQrf3JeFWMerfBcQKAtrq1mwC
         7UYqRkSKyc0NkOVfcJFa5OPUqpcfCkEveGxM/DVK2l/001N7x9W/qKEuK6E+oqHCP9lt
         8d5ZY43IyRjsmEQdB+f5xmsjme9wEwn0e5QSj/ea1ZfOZ521vKAp3SdkbQZ0rF8Mstd9
         e7MzsuStHlDvOpa9mAVMCs24JvmS+OfR2sjnzjo4krxLgYOF6FN0Ge4USQTushTyOLVH
         604pr82Y+wH4xzi2h5h+055qHW0g8ChxIX6WxbToDhDWyGldSgJTr2Vony2ngKZQ9XU1
         RkHw==
X-Gm-Message-State: AC+VfDxyyyIvQQlCyP+qFCIhSdVORd/7d2/+hWcrwPJXRRq/13yHFStC
        dwdcFjLERwLHW6E7Jmk/hih5HLyOXNPXzgNm7J208OOCJAE2
X-Google-Smtp-Source: ACHHUZ5a3/LH4iKSxtjJ8ieObZ5ct2paMcCyy7nFhY+eLkUCP2q5glbTiVIOXkIQrdY5V8786M98Z8UZN46i0BdsTpG6pnuLVH/7
MIME-Version: 1.0
X-Received: by 2002:a02:a1d3:0:b0:414:39cf:e6b6 with SMTP id
 o19-20020a02a1d3000000b0041439cfe6b6mr693410jah.0.1683294698259; Fri, 05 May
 2023 06:51:38 -0700 (PDT)
Date:   Fri, 05 May 2023 06:51:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008acbdb05faf2961c@google.com>
Subject: [syzbot] Monthly xfs report (May 2023)
From:   syzbot <syzbot+list457a2ec8617806111bfa@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
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

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 3 new issues were detected and 2 were fixed.
In total, 22 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 560     Yes   INFO: task hung in xlog_grant_head_check
                  https://syzkaller.appspot.com/bug?extid=568245b88fbaedcb1959
<2> 501     No    KMSAN: uninit-value in __crc32c_le_base (3)
                  https://syzkaller.appspot.com/bug?extid=a6d6b8fffa294705dbd8
<3> 128     Yes   KASAN: stack-out-of-bounds Read in xfs_buf_lock
                  https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
<4> 110     Yes   INFO: task hung in xfs_buf_item_unpin
                  https://syzkaller.appspot.com/bug?extid=3f083e9e08b726fcfba2
<5> 89      Yes   WARNING in xfs_bmapi_convert_delalloc
                  https://syzkaller.appspot.com/bug?extid=53b443b5c64221ee8bad
<6> 12      Yes   KASAN: null-ptr-deref Write in xfs_filestream_select_ag
                  https://syzkaller.appspot.com/bug?extid=87466712bb342796810a
<7> 11      No    KASAN: use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=f0da51f81ea0b040c803
<8> 7       Yes   KASAN: stack-out-of-bounds Read in xfs_buf_delwri_submit_buffers
                  https://syzkaller.appspot.com/bug?extid=d2cdeba65d32ed1d2c4d
<9> 2       No    WARNING in xfs_bmap_extents_to_btree
                  https://syzkaller.appspot.com/bug?extid=0c383e46e9b4827b01b1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
