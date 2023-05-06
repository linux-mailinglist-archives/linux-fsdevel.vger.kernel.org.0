Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E406F9260
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 16:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjEFOCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjEFOCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 10:02:55 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4764A7EF5
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 07:02:54 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-331663d8509so41230895ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 07:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683381773; x=1685973773;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjR+zB20hfPaM34wxDG6cz5i7+lLGlLgpjJu8mR5MAU=;
        b=NeM9Ndmxn0SoIJbloMGVj4A0wlHrGHH/5JbdPJ2ns5UhZwxG82UgL5ZbCEhtwx7ccL
         JnYlS53MPlIX+W3dCsH7bd3Shydn5XQiPHsXdVV0sVSJtPegY/G9t1xFQ7vcqdrp61hi
         cqjEs2hM9QKNE/acCRWSA84cmQ2IEs0qfA4R/TcmLFf9LWjn8waDf044xsU2DToyhnQW
         UxBRR2/zVxiTntgc/lHK+mYivAKIwa9GEUDFcS/fhAxevAEyy+8PmPGUWcMlu+LcnDOj
         nKVwWzggl+T6I5YNt8E9vNkVfWiALS+zl1wIv+iYwl/rdNoDoi6zBOsEL+9r0888bN9g
         nJDQ==
X-Gm-Message-State: AC+VfDwjQSVoIG2b2gGkGL5YdwizspvfhauVOXU8uf3Gj3+z/rOMJfyT
        DLl4uAc3B/cORYTGdFhfExjxEwArBBlyD0gvTTC4lChpDXEGUBU=
X-Google-Smtp-Source: ACHHUZ5jfxcWYqqQMHpfyqsPt9wwjskRJH7dSGTNTCJ4Hdd8e/52t9WxQ+iDLNmwvIatK5QsEXggl3CU/JNYhKV7ybj0whJDKfb1
MIME-Version: 1.0
X-Received: by 2002:a92:d7c5:0:b0:310:9fc1:a92b with SMTP id
 g5-20020a92d7c5000000b003109fc1a92bmr2382461ilq.0.1683381773594; Sat, 06 May
 2023 07:02:53 -0700 (PDT)
Date:   Sat, 06 May 2023 07:02:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2feae05fb06dcee@google.com>
Subject: [syzbot] Monthly fs report (May 2023)
From:   syzbot <syzbot+liste501264b47eec817042f@syzkaller.appspotmail.com>
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

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 7 new issues were detected and 0 were fixed.
In total, 66 issues are still open and 321 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1895    Yes   BUG: sleeping function called from invalid context in __getblk_gfp
                  https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
<2> 1768    Yes   WARNING in firmware_fallback_sysfs
                  https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<3> 179     Yes   BUG: sleeping function called from invalid context in __bread_gfp
                  https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
<4> 80      No    possible deadlock in quotactl_fd
                  https://syzkaller.appspot.com/bug?extid=cdcd444e4d3a256ada13
<5> 37      Yes   INFO: task hung in filename_create (4)
                  https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<6> 13      Yes   INFO: rcu detected stall in sys_clock_adjtime
                  https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190
<7> 5       No    BUG: unable to handle kernel NULL pointer dereference in filemap_read_folio (2)
                  https://syzkaller.appspot.com/bug?extid=41ee2d2dcc4fc2f2f60c
<8> 5       No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<9> 1       Yes   INFO: rcu detected stall in sys_newfstatat (4)
                  https://syzkaller.appspot.com/bug?extid=1c02a56102605204445c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
