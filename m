Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0374D1E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 11:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGJJkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjGJJjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:39:24 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE781BE1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 02:37:02 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6826902bc8dso7521532b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 02:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981811; x=1691573811;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGkeIYsGthKQUf2MaWmyoWrTvnEbSMXFNdzeg05GToI=;
        b=Yl0Ths3zhk7e/lyV9I7lYF1sv9aXl+9yI/OdgrbDWUSbamdlL8+FxE5tYTCFPklt8p
         QVLiqdHwd21MG27I1494opyBOEbi6kJznLdqXyKMAi1XZ6tnUs4TC6PG+6NvT3ustj5E
         0CndBRDixOvTpoNT0rv8j73QyzjwiHLJAAaESnJXtXBR7xAQtNXVMFpHgp8WqRsgZ3VI
         AqZ445XBJDuX2jv9Dt5RVD09lg88ybxD55cDxkvybftawzz1cHs2zK4YqBS/8mm6gylU
         oHRz3KJFW9xKs3GfxqXTG565qR5ro/MUB8AbJC9UGk7w6DgF4hpuEe/G7dpy1G6MPUhw
         U6mA==
X-Gm-Message-State: ABy/qLYSS6U24ehyLpKZ4tWCybbpvHhbKF/UWoFjIZJCXF4FiHdtMfht
        O15B3O9GiNPNrEzpVAVGCYyB5NKO5MImS6SicPgxseE1ceBCLHw=
X-Google-Smtp-Source: APBJJlHS+EA59J+trihIPNDVg9SP/uRmojJClqCjtBRYREURwXLwkZUSY1FNt0Ff6nIUki8yNpWV3bkFn4bQIv8v+fzvoTcZGg5+
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3989:b0:67b:8602:aa10 with SMTP id
 fi9-20020a056a00398900b0067b8602aa10mr18148104pfb.0.1688981811466; Mon, 10
 Jul 2023 02:36:51 -0700 (PDT)
Date:   Mon, 10 Jul 2023 02:36:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7972006001eb8ff@google.com>
Subject: [syzbot] Monthly fs report (Jul 2023)
From:   syzbot <syzbot+list9b431a4a48d2fc317ca2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 5 new issues were detected and 1 were fixed.
In total, 55 issues are still open and 324 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2662    Yes   BUG: sleeping function called from invalid context in __getblk_gfp
                   https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
<2>  2001    Yes   WARNING in firmware_fallback_sysfs
                   https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<3>  1195    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<4>  253     Yes   BUG: sleeping function called from invalid context in __bread_gfp
                   https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
<5>  119     Yes   possible deadlock in pipe_write
                   https://syzkaller.appspot.com/bug?extid=011e4ea1da6692cf881c
<6>  75      No    possible deadlock in evdev_pass_values (2)
                   https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<7>  59      Yes   INFO: task hung in eventpoll_release_file
                   https://syzkaller.appspot.com/bug?extid=e6dab35a08df7f7aa260
<8>  40      Yes   UBSAN: shift-out-of-bounds in minix_statfs
                   https://syzkaller.appspot.com/bug?extid=5ad0824204c7bf9b67f2
<9>  20      Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<10> 18      Yes   INFO: rcu detected stall in sys_clock_adjtime
                   https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
