Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5E768574
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjG3NQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 09:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjG3NQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:16:54 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C397D10C7
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 06:16:51 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6bc4dfb93cbso7096027a34.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 06:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690723011; x=1691327811;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9dj6/lAKaW7GGrTXIaj0DpOh57UC6d0adFmPDAuxes=;
        b=YCEroP12mZEDLIHjFS00JFOK1XpL+PCeOkkSVAXXle8UZTqjD3c/b+9ki/qvEPHt9f
         46rG8HH3QewDPniCfBePeJGAFLLAzP1pZqjpRDhwQgpIpA5srJ7ofo2Jt8NbWGi/5rSF
         +aZoSR9RKEB7tp1iDdbyPCEw2P7QrEE77/GdmqfquBHxRJfmwv8SaR7hvlFgo7Flbl//
         jSmWKQp1lsu5nXdHs7PvbgRvAxKFE9HpsQfMvMGj2cSpHbgRz/K9KbxTGwcxfRh9ILRE
         ig+NFjodaQFPeouxwjOfanC2pMcOctDXranFGSgGWxAtWnV4t9w3G7gAK5mHuNXISdcl
         ENjg==
X-Gm-Message-State: ABy/qLYfJZxmgoF9eznzKtI2baEKT30xSXHmgwDamloJoSfAYwaMa09G
        6TTqt3mE5Z1z/rO2HmArDcmWKfgk3XJ+EMzAXmxlTZAdZWMt
X-Google-Smtp-Source: APBJJlHpcOCZP0IFDoUOY33ez3X+TGQHNRABxm66oNBgly7kzFWnsqskmbEbz5GivcZV95hOR9nmWsIf929BUTTsHBjdDLKiGoBw
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1e4d:b0:6b9:e272:d192 with SMTP id
 e13-20020a0568301e4d00b006b9e272d192mr8794396otj.7.1690723011116; Sun, 30 Jul
 2023 06:16:51 -0700 (PDT)
Date:   Sun, 30 Jul 2023 06:16:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dc6d60601b4207b@google.com>
Subject: [syzbot] Monthly ntfs3 report (Jul 2023)
From:   syzbot <syzbot+list34537c28a13cbdf0663a@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 7 new issues were detected and 0 were fixed.
In total, 63 issues are still open and 24 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4288    Yes   UBSAN: shift-out-of-bounds in ntfs_fill_super (2)
                   https://syzkaller.appspot.com/bug?extid=478c1bf0e6bf4a8f3a04
<2>  3585    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  1748    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1380    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1187    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<6>  1077    Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<7>  576     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<8>  507     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<9>  421     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<10> 68      Yes   WARNING in do_mkdirat
                   https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
