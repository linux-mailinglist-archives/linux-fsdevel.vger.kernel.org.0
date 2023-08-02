Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAEC76CB9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjHBLTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjHBLTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:19:00 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D57F211E
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 04:18:59 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a7292a2a72so6440841b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 04:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690975138; x=1691579938;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tG/9RhsoOpqUYPDbY3A2SCrWREUkDCcVSurVLIMXES0=;
        b=FWIgGxMZPVT9+QgrO2+X0nNyqAkGvAMKtEX9vYsUCGjCnViAH40wVN/NGkhTAEZ6FO
         xeJbsTqpxxeCDLLtUpfAeA6XYoBHLB5GxcbPPc50LdcOUj5xtKyVT27tWAM4N1s9gW6p
         yvfTPjrGIKh1RAiJsKTDKeAWw6aVKzRZ29Bn0/UXuIjBGBECRXffwlEdximufhU1n2UH
         RPmpwFJYx3iOxpUgGHaH8ZFQfDdqUzYPaJMLc+KvgZkIkZXUwO3LpAOqxaSHOq63J8v+
         3d/TRkv30+X8918dPcFBCBfPmcqIljSpsqq0BQyyoYGs0ObkX8kNa4I9TMW84KcsbAwj
         tRLQ==
X-Gm-Message-State: ABy/qLac0q0fnFXvLCgJojmGXb3znIu5XCWXjotfn9ss7krdLuxqvCww
        4Hig6h0nF/NAMfqRW1cUhb/kW+VnUlRju+GQUMEDtrtvHeys
X-Google-Smtp-Source: APBJJlFDaYXeuroNY34COc/l3laqrnv+Mv8wxy0p7P5oKzctisDOWKPhrtk27+nmEF2HhuHOaNFi3xaXqEHYz3SboaUPv0kmCzcW
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13c2:b0:3a4:24bc:125f with SMTP id
 d2-20020a05680813c200b003a424bc125fmr26661106oiw.1.1690975138443; Wed, 02 Aug
 2023 04:18:58 -0700 (PDT)
Date:   Wed, 02 Aug 2023 04:18:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073777d0601eed428@google.com>
Subject: [syzbot] Monthly gfs2 report (Aug 2023)
From:   syzbot <syzbot+list07452ddeb3cf4800d090@syzkaller.appspotmail.com>
To:     cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
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

During the period, 3 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3678    Yes   WARNING in folio_account_dirtied
                  https://syzkaller.appspot.com/bug?extid=8d1d62bfb63d6a480be1
<2> 2371    Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<3> 501     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4> 71      Yes   INFO: task hung in gfs2_gl_hash_clear (3)
                  https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
<5> 52      Yes   WARNING in gfs2_check_blk_type
                  https://syzkaller.appspot.com/bug?extid=092b28923eb79e0f3c41
<6> 3       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rgrp_dump
                  https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
<7> 3       Yes   BUG: unable to handle kernel NULL pointer dereference in gfs2_rindex_update
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
