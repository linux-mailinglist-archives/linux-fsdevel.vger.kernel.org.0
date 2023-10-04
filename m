Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694607B82A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjJDOtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjJDOtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:49:00 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3BC1
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 07:48:56 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c4e6affec4so1188729a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 07:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696430936; x=1697035736;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeudAUg1PL3Ae8uuSCoe099NJjdoyrevycEdUvNC7F4=;
        b=X0JT3uAaJ5WsbRe1lY6ynb/PHmOPaVX0f1djtoXczBjRG8zgkxc8W9oaABkstEko4w
         mYA7xfH8nOzb6WI/0xxn4bsl+PVEul2IK6/avbQqpmfW0w553/5d07sBn8NJ/7pQPD97
         UsOahANhM93mg+XDRgVoQZ0uZkpSobfJ8wVFq2mjaANRWjAhuL/WGikynCDCHBu0YKef
         yEqXAgZJGHoiWbUwVOPvM58+rLyKSkbhltN1G0ILaPeqDq/QrDpyQEJW7MNmeWNjKUCM
         6/n12yOCK3FYMrBgV4wTzKKX6lUqdbv4HjjFhIaMPnhFhq74slRZ91GQfiaHvYPLFDXK
         kCSg==
X-Gm-Message-State: AOJu0Yz6DnHLBMmvuCW85b2uQt5lEn/cEw/ECBVfaG3ZNIkoce6zL9ZG
        UAnOB3jC8Zw2XLc1H8gRvfPp82QcPhZ1H9Uq80jWqY6PJIjU
X-Google-Smtp-Source: AGHT+IFWrdkfMsj0EPEOxO8DfbLjpBCXc/nCp8OB9LssTNor0mqglRpp1WhRU3JtTVJCpN12nkyqSmpZom52rJSdnqgRRRYMZqFg
MIME-Version: 1.0
X-Received: by 2002:a9d:4b0d:0:b0:6b9:2c07:8849 with SMTP id
 q13-20020a9d4b0d000000b006b92c078849mr892370otf.0.1696430936229; Wed, 04 Oct
 2023 07:48:56 -0700 (PDT)
Date:   Wed, 04 Oct 2023 07:48:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000570bcd0606e51be4@google.com>
Subject: [syzbot] Monthly btrfs report (Oct 2023)
From:   syzbot <syzbot+lista2d2b54c9dae22be8843@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 5 new issues were detected and 1 were fixed.
In total, 54 issues are still open and 41 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5413    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  1301    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  905     Yes   WARNING in __kernel_write_iter
                   https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
<4>  373     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<5>  311     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<6>  283     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<7>  177     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<8>  109     Yes   general protection fault in btrfs_orphan_cleanup
                   https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
<9>  84      Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<10> 71      Yes   WARNING in btrfs_put_transaction
                   https://syzkaller.appspot.com/bug?extid=3706b1df47f2464f0c1e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
