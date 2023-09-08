Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26253798851
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 16:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbjIHOMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjIHOMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:12:02 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A12C1BEA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 07:11:57 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-56c3a952aaeso2581328a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 07:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694182316; x=1694787116;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnzCKZJczahJy+S/JArtFdOPkapnJg+gfjTcqGqp3sU=;
        b=COtMvRkHIpdzN/R6m7w9E/3P5iyhhlnqz2n6PNdDk05JH5jbDyWTVpTdAdFbAL7mt/
         mjaN+DvJ3msQInfmOwfpQdEiA+fQgvmAwFQp7yjyrrYByqcButgERGQKSY+7IVwV9BAq
         EbIi34uuCCVusjMmuiFvYx765pv2pfiVhAnSEmxF9wpSXCxoBpmvAGLw0SPdMz8/nUFF
         z1mhjw8X1F/NswEOy4xhxunky1ZJ/N1+voJrb6eX3EmGtob8HgfKvbRqQ52eS3568Q4F
         Ny7vEl841+UqAwZ9v0eOujsyl9jBR/pAGl2OyJjUqPN5zpEQPhNe5A7rqMMaWasQ1lfw
         okDg==
X-Gm-Message-State: AOJu0YwvCibogSukcNm1N8s9QKOeqSpIGcLo30i6O1baaSrkQ+kStdAa
        g20Om9ZhKysYW1nsMy6xJOnYBZVURHq1IQ2YSVyBBn3J29K/
X-Google-Smtp-Source: AGHT+IGSgdA4DWeLu66y6OI1b/B+AM6Taex0QSz7cVrPl8pF5e4doG9DA8+Y2RRxWeh7/Pp8DyNc+XgOQ6i0tm8gTJRNl6Jc8CfP
MIME-Version: 1.0
X-Received: by 2002:a65:6e03:0:b0:566:8b4:4f18 with SMTP id
 bd3-20020a656e03000000b0056608b44f18mr486498pgb.5.1694182316684; Fri, 08 Sep
 2023 07:11:56 -0700 (PDT)
Date:   Fri, 08 Sep 2023 07:11:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bc0110604d98f19@google.com>
Subject: [syzbot] Monthly udf report (Sep 2023)
From:   syzbot <syzbot+listde33a415ffbafe5a4f45@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
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

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1372    Yes   WARNING in udf_truncate_extents
                   https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2>  82      Yes   KASAN: use-after-free Write in udf_close_lvid
                   https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
<3>  22      No    WARNING in udf_new_block
                   https://syzkaller.appspot.com/bug?extid=cc717c6c5fee9ed6e41d
<4>  16      Yes   KASAN: use-after-free Read in udf_finalize_lvid
                   https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
<5>  9       Yes   KASAN: use-after-free Read in udf_sync_fs
                   https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
<6>  6       Yes   WARNING in udf_setsize (2)
                   https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<7>  5       Yes   WARNING in __udf_add_aext (2)
                   https://syzkaller.appspot.com/bug?extid=e381e4c52ca8a53c3af7
<8>  4       Yes   KASAN: slab-out-of-bounds Write in udf_adinicb_writepage
                   https://syzkaller.appspot.com/bug?extid=a3db10baf0c0ee459854
<9>  3       Yes   UBSAN: array-index-out-of-bounds in udf_process_sequence
                   https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
<10> 2       Yes   KASAN: slab-use-after-free Read in udf_free_blocks
                   https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
