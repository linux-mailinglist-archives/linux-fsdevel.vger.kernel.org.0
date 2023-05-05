Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF26F8B52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 23:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjEEVlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjEEVlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 17:41:21 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A84215
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 14:40:41 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7638744ba8cso145896439f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 14:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322840; x=1685914840;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6r1fpOCe4Fv1EAxhDcJy4IoI32U0TyXXfS1pn3Vn3eM=;
        b=lng/3wGwh7BnFD/VgojInhzusH/i3FJJddQJUh0epgxJSTQ4uKNlAlSXDzZCIltuzx
         mZFg8aIj5Vko1JqJ4HVrvZJZeExvwSs9OjcoTG3iQiNAHxPiU+tuoMhBr4Vya8DQ4PE0
         0qKM84AC/ubt6m03TdsV5joku2uQoGwxubFF1AwH7mrg0GR9rekQbR7qr3+8j7LxxjUB
         gAV/A4MYkK1xjco8hhVNacCQmItKK3RB8Mw1qKmEeM/IjmpGB5IMEcObYYm3o4XTwT+j
         drungcS0YuZk5srwh1i0IfjO87SbunwyjGus6IAI/AspARS9ETFHwGhv8wyI972euKXl
         1yvA==
X-Gm-Message-State: AC+VfDx3vaJHkma1icpmICdbNntKBm0yc4EN+nmA3izgJr04e3XhcfVf
        z2w1SFcWLVHqTgbpz2sayjR3SMeZDeMxwAIZEnzAfGHLNE8m
X-Google-Smtp-Source: ACHHUZ4+W5iAMTzlHsI1iNuw3ugVX93iXPox7IbLl9VrL3MAAawXiPp4lY9sMEiE9DjeZp8P3C8leyIKIlMbCyYfumOH3/6InX69
MIME-Version: 1.0
X-Received: by 2002:a92:d4ce:0:b0:32a:9e86:242f with SMTP id
 o14-20020a92d4ce000000b0032a9e86242fmr1369094ilm.6.1683322840521; Fri, 05 May
 2023 14:40:40 -0700 (PDT)
Date:   Fri, 05 May 2023 14:40:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3a4ee05faf923fa@google.com>
Subject: [syzbot] Monthly f2fs report (May 2023)
From:   syzbot <syzbot+list4594bdd613fc4b2a114c@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 3 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 173     Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 49      Yes   kernel BUG in f2fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=e1246909d526a9d470fa
<3> 7       No    general protection fault in __replace_atomic_write_block
                  https://syzkaller.appspot.com/bug?extid=4420fa19a8667ff0b057

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
