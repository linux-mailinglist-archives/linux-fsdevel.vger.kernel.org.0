Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526D7423C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjF2KPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjF2KOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:14:49 -0400
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0419F3591
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 03:14:03 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-558c1394636so647584eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 03:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688033642; x=1690625642;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbTDt8O8YnKp6qSkf23f21/gUgnuCkFPdBbsf+Eovdg=;
        b=JuMnH6glAeLYnGbfz/5TcH0rsNDNZzkKRlmB0g8ImHoXvPdI/NQOsjzMtxwrV1Kwdv
         rSx0FW/Ld7/rvz+SYx/4ERnT3gbRm1KgX0inuvZZOF0mILaYdGS7PulG5Nt2sl4hMk8L
         WWLkNuHWGJRYsRmXWcTm2MgokU2x4PSI5+cChGY9e/2nzYaVewhsxpraEY+GoR5FxSAr
         LP/i3jO7TYBoKknnv1Z/SS0327xsa1HY3quAT5+Fcs60B3NTh722soJJUEAveMIB+Axm
         qdooZhzaj6iglPLaLqRItEDNakJWgyWMnR0vdH5rJWQRf97MVotP7sybF7Xc40LjzMRD
         MB5A==
X-Gm-Message-State: AC+VfDwyTBhoF7YOmaGO1oFYhihzQ0zhakBuEhrsWLG1n8EOoXARC9cn
        fg4N7lD4haM2WfcYnOHsRj227t1VGpMgElaa6aagRJiGdry+
X-Google-Smtp-Source: ACHHUZ4TDuu4wLKEbVkIRWqidc5fW5oERyi9bovBtN9/nZFZ60TWvJocbnPLlZyHmb74xnJB42DcXz+4Db0kZUQihT94vE/CYU/x
MIME-Version: 1.0
X-Received: by 2002:a4a:d028:0:b0:563:47e5:d5a4 with SMTP id
 w8-20020a4ad028000000b0056347e5d5a4mr2227835oor.0.1688033642417; Thu, 29 Jun
 2023 03:14:02 -0700 (PDT)
Date:   Thu, 29 Jun 2023 03:14:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a015e205ff41f54a@google.com>
Subject: [syzbot] Monthly btrfs report (Jun 2023)
From:   syzbot <syzbot+list8679aaba80d87386e95e@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 5 new issues were detected and 2 were fixed.
In total, 52 issues are still open and 30 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3774    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  898     Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<3>  573     Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<4>  550     Yes   WARNING in __kernel_write_iter
                   https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
<5>  273     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<6>  223     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<7>  208     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<8>  197     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<9>  187     Yes   possible deadlock in btrfs_search_slot
                   https://syzkaller.appspot.com/bug?extid=c06034aecf9f5eab1ac1
<10> 162     Yes   kernel BUG in assertfail (2)
                   https://syzkaller.appspot.com/bug?extid=c4614eae20a166c25bf0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
