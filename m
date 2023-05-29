Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF95714690
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjE2IsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjE2IsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 04:48:13 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BEADA
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 01:47:56 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33b27ff696eso9061875ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 01:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685350076; x=1687942076;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbHpzrqgBAsJqGDHS3MPrS3ZW+nNib8fMwdVh4fuRHA=;
        b=GfdwW65M8B/w2g/SC9HeZkC4b6dF6wI7NbIlnjp3Sm1IvG8grGOkiru/zxbecIVcyZ
         VjXdkvbhuoxScKoUpo24Wg2cAoHsM/b2fUUkPTyqaX9ulbQUHyGzn7jr09FiTkoloHQc
         oF5D8gYzXO0O7vf8KEMSDx/VVAivnz/r5QWsbzwDOBTJiaAymzlew+db/FIj7ZkFEFke
         PkdN+7bSBB+e7Nw/FDSVHWz4wuMbL6RbZHCDLmI048yksddtVeyq/vl6H90rAOOHsIcw
         flCEHhnLyb/HycshVt1W+98c0RuI7ozTjzbIC863j+R2p9OsIh4BjjrvqtjPySVtXezA
         vLuw==
X-Gm-Message-State: AC+VfDxLTKBkEFo87+S2/5gLhm6UpqZb12b12OhL4orItxaZltS67QfE
        bbe6EL3wJeZUK0e50rBb3T2rJmToTpO2E3l2LeVtPYYmpV9a2/c=
X-Google-Smtp-Source: ACHHUZ6zeFwwZP5TLdA7JZzbIJ5uSjQ/t4rKCf707qsAPscDziQNun43ikPCoHPixjkvPKICSgW4HBGJzglIEhVwfw4BXf4yHDkM
MIME-Version: 1.0
X-Received: by 2002:a92:d392:0:b0:33a:4f71:b9c5 with SMTP id
 o18-20020a92d392000000b0033a4f71b9c5mr2708975ilo.1.1685350075862; Mon, 29 May
 2023 01:47:55 -0700 (PDT)
Date:   Mon, 29 May 2023 01:47:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098177b05fcd124f6@google.com>
Subject: [syzbot] Monthly reiserfs report (May 2023)
From:   syzbot <syzbot+listc7e3fffb336c714441aa@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Hello reiserfs maintainers/developers,

This is a 31-day syzbot report for the reiserfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/reiserfs

During the period, 2 new issues were detected and 1 were fixed.
In total, 71 issues are still open and 16 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1958    Yes   possible deadlock in open_xa_dir
                   https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
<2>  1597    No    KASAN: slab-out-of-bounds Read in search_by_key (2)
                   https://syzkaller.appspot.com/bug?extid=b3b14fb9f8a14c5d0267
<3>  1455    Yes   kernel BUG in do_journal_begin_r
                   https://syzkaller.appspot.com/bug?extid=2da5e132dd0268a9c0e4
<4>  1315    Yes   kernel BUG at fs/reiserfs/journal.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6820505ae5978f4f8f2f
<5>  1184    Yes   WARNING in reiserfs_lookup
                   https://syzkaller.appspot.com/bug?extid=392ac209604cc18792e5
<6>  597     Yes   possible deadlock in mnt_want_write_file
                   https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
<7>  242     Yes   possible deadlock in reiserfs_ioctl
                   https://syzkaller.appspot.com/bug?extid=79c303ad05f4041e0dad
<8>  218     Yes   possible deadlock in do_journal_begin_r
                   https://syzkaller.appspot.com/bug?extid=5e385bfa7d505b075d9f
<9>  187     Yes   KASAN: out-of-bounds Read in leaf_paste_entries (2)
                   https://syzkaller.appspot.com/bug?extid=38b79774b6c990637f95
<10> 159     Yes   WARNING in journal_end
                   https://syzkaller.appspot.com/bug?extid=d43f346675e449548021

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
