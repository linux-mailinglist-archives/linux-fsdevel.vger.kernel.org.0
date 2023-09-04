Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD479137F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349741AbjIDIdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 04:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351432AbjIDIdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:33:23 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E61013D
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 01:33:18 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-68bec4380edso1451386b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 01:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693816398; x=1694421198;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrGFGOU2JHGHY3uenWpbxy9f+g1nyoQzetE2yd9LSVo=;
        b=e5AyCXUAyfFrEiBf3XQTtVpj+9u0N+82hGu6TO5HJ/GovZz5D748QrfIJkGguyxV3U
         YbwoEFX/kFBObY4HUTZMzg2Bk1HOK/ys489zqHLRnZLZK0hEcJw+x71E+SDy3uGcixtj
         vg8emi9bWY86ElSGbS3CHr/DS/Ebw4r05GVC6uidvg67Kqlaotrs1Lk1y/jNNRaL2NtF
         qxEOScARvWRl6OS6JTNu83mf9d/P00tvG8RJA9grM2EcY28qJTZXapH27m/aW69G2HqG
         7e8X0nnKy9m+8cITbvHMQhVQAXdR4EcTmKw0v7f+fdrgALYBSPkxSf5jVnRdzUeg5clL
         Oa/A==
X-Gm-Message-State: AOJu0YxtCODBBe8ogbvcT4hNRFaihDgHXVmMwkA7ZAlCV/urhBQfDFbI
        yrkD9shYkzJm3+MJ4qmStAaVtB3DB0u4yfRtfLE5XWfIo430
X-Google-Smtp-Source: AGHT+IHDoUNA6dwekWEKHoI4XenoIYPrSAlWMWZ/w4ctM2R+WneLeJWGFR0m8FcLMu7s0rUFMZGrUymlu0Ny03CDBu0dvLMsUbVG
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:98e:b0:68a:5cf8:daf3 with SMTP id
 u14-20020a056a00098e00b0068a5cf8daf3mr3722004pfg.2.1693816397905; Mon, 04 Sep
 2023 01:33:17 -0700 (PDT)
Date:   Mon, 04 Sep 2023 01:33:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b644840604845c46@google.com>
Subject: [syzbot] Monthly gfs2 report (Sep 2023)
From:   syzbot <syzbot+list4cf369d7337ac966cd70@syzkaller.appspotmail.com>
To:     cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
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

During the period, 0 new issues were detected and 0 were fixed.
In total, 17 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2679    Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 577     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 77      Yes   INFO: task hung in gfs2_gl_hash_clear (3)
                  https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
<4> 54      Yes   WARNING in gfs2_check_blk_type
                  https://syzkaller.appspot.com/bug?extid=092b28923eb79e0f3c41
<5> 35      Yes   general protection fault in gfs2_dump_glock (2)
                  https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
<6> 7       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rgrp_dump
                  https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
<7> 4       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rindex_update
                  https://syzkaller.appspot.com/bug?extid=2b32df23ff6b5b307565
<8> 1       Yes   BUG: sleeping function called from invalid context in gfs2_make_fs_ro
                  https://syzkaller.appspot.com/bug?extid=60369f4775c014dd1804

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
