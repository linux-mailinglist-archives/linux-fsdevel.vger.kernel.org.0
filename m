Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EED78DAE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjH3SiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244208AbjH3MpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:45:06 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB79C2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:45:02 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2680f0cc480so5413541a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399502; x=1694004302;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jt3l9FGOI3Y5tt5qjFm1J8GEZChx9Hp7h/Vbc/JsQ3E=;
        b=IitTytlNNzJFe+bxzqfT6+jDpm9nUEkq0HrE/Uo3xr5esyVyzRcmoJqxSvLSA/SsEL
         MhlMQGYqRz5u9NfuuyfnRMRaknkB6Vw3LG8hhq8FoS5h7WZIWi/LqM8+kIdeoBQFTa4A
         uXudlZRvpvBhEX7D7aMDpgT2O4aQFlb2oDF3Sabpd5tQvEOeySEN7/KgLXc6wyGU/Sc3
         kJA8jGcbWCFYc0f87S3/KeKCrCsTFWeNUp2NFN81eQCX3C1wwF1TdR8tltrmw9SUpBU0
         8Pt3XjuBpSDkm7xPdkRu63FktR7eTA5ysYF6t13pPBaOmO36DXKA75u7RQBBqiAASxKp
         CMKA==
X-Gm-Message-State: AOJu0Ywcg4IUszOeZt1RymFUUAjDkNld0axIMntqaYP/dtvz3hRHjKjb
        rETTkEKMrg0Jir6mRDjX7UbYz4Rho2SvigVFboY9LEYnGFvH
X-Google-Smtp-Source: AGHT+IF+BZ7YLC7iad66BUKll9riZuoAtEuwnKIWiTyEBoJRJpmCovwoB1+N8tFGqnTgUi6y3R9KLMCmbW1zGWpjn7BI9GeuhISD
MIME-Version: 1.0
X-Received: by 2002:a17:902:db08:b0:1bb:b74c:88fa with SMTP id
 m8-20020a170902db0800b001bbb74c88famr618138plx.6.1693399502045; Wed, 30 Aug
 2023 05:45:02 -0700 (PDT)
Date:   Wed, 30 Aug 2023 05:45:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c849190604234b66@google.com>
Subject: [syzbot] Monthly ntfs3 report (Aug 2023)
From:   syzbot <syzbot+list2fdacf96ea1991346bcd@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 1 new issues were detected and 0 were fixed.
In total, 57 issues are still open and 24 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5004    Yes   UBSAN: shift-out-of-bounds in ntfs_fill_super (2)
                   https://syzkaller.appspot.com/bug?extid=478c1bf0e6bf4a8f3a04
<2>  3598    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  1912    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1564    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1281    Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<6>  1260    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<7>  780     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<8>  537     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<9>  512     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<10> 455     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
