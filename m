Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F147D7BA060
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjJEOiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjJEOgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:36:14 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F093B2B1
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 06:59:56 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1dcf6a4378bso1253204fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 06:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514332; x=1697119132;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZ3jIZcjuy9IwEEUZGsMTuLaII8wkn3ebRcwccGBLh8=;
        b=DxhLmjfAtGGOKmBls4eUuO6H+8BtB39162tlhrV1Kfz+kGUd0n43G9/CKu8rOB3GTr
         WMJ0PEevybOTGpJirTDudKx0TTyDfoOpBAJmpVFjiaGo9jS5+y8iJCJGMMMDBgnjpDpw
         j8PHunKhC3HqeWwXYQjKtw0wyzvsN+h0cH6nQyAl5u/xF+N/82FABAlYHfcYWmfaOdXV
         6N+ZjF5M03zHZFPgwfyzRL7qO7RMKbxDbYErIYWhuIxzBWuk485RI41IRhn3Q9qd79F1
         DJ1fXSKieCePrKNfsioJGJB6XQmRMGq4Oy3qBcDKPuTWKyv6s70lbHgBhepBw6F3EdLp
         /lAg==
X-Gm-Message-State: AOJu0YwyanjL0NvOTzM/U5b79vFcwJ1PTnkX3u1OwrsYHozgZM7H0nNS
        b2Ug2/SJcoNdqAMafmbR+mRr7XRu+/PJrMugwMTR08pfFqmo
X-Google-Smtp-Source: AGHT+IE4974EMbqpFAyLxpSqlzR2TgeX6fQDuPmOEUx8diqTerPcA55b3fFgWBLWTp9PEikjUHL+6vz7vTGrER2417wsfxJAPfYw
MIME-Version: 1.0
X-Received: by 2002:a05:6870:6289:b0:1dd:39ce:e25c with SMTP id
 s9-20020a056870628900b001dd39cee25cmr1897300oan.3.1696514332010; Thu, 05 Oct
 2023 06:58:52 -0700 (PDT)
Date:   Thu, 05 Oct 2023 06:58:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001db0110606f886f0@google.com>
Subject: [syzbot] Monthly gfs2 report (Oct 2023)
From:   syzbot <syzbot+listfaee261bcd9ab8e92c18@syzkaller.appspotmail.com>
To:     gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 4 new issues were detected and 0 were fixed.
In total, 23 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4115    Yes   WARNING in __folio_mark_dirty (2)
                   https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2>  3678    Yes   WARNING in folio_account_dirtied
                   https://syzkaller.appspot.com/bug?extid=8d1d62bfb63d6a480be1
<3>  652     Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4>  182     Yes   BUG: sleeping function called from invalid context in gfs2_withdraw
                   https://syzkaller.appspot.com/bug?extid=577d06779fa95206ba66
<5>  79      Yes   INFO: task hung in gfs2_gl_hash_clear (3)
                   https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
<6>  54      Yes   WARNING in gfs2_check_blk_type
                   https://syzkaller.appspot.com/bug?extid=092b28923eb79e0f3c41
<7>  35      Yes   general protection fault in gfs2_dump_glock (2)
                   https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
<8>  9       Yes   KASAN: slab-use-after-free Write in gfs2_qd_dealloc
                   https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
<9>  8       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rgrp_dump
                   https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
<10> 4       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rindex_update
                   https://syzkaller.appspot.com/bug?extid=2b32df23ff6b5b307565

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
