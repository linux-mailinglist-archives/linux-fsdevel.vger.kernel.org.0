Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB34A71468F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 10:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjE2IsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 04:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjE2IsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 04:48:12 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44EC4
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 01:47:56 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-33b27ff696eso9061835ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 01:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685350075; x=1687942075;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnTVL9U7w3OOuFsS48xppNwD0ZB4eLygMiJgfpYLfH8=;
        b=e6ZwLXGdyJE6e3VWPSZrRHhltC9aWL+GXIZPKCuBjfnMDb0Rn2dkaj6VSs6CBRJb22
         l62hS/nGz6dZoHjFuT0JoWmB6ZwJ0QZ0CTnwMU4ekdmDVfpKJ0dPKxVgvoV77aF0Za55
         81gLMTurAx3MYCBOH1Pvg62mPoN2m4hLZV7/V2/BAhy2Xu264969u1btFz8HTXe07vdx
         rJ1jdp3VF4uVtjyE1+/nEMfPk7/T7sEqm9+/1k7oztDlGtH2TZk9MhwkeH7aRiSS/odV
         2suVUn1k2MTBspMn7SDsqRaN/ZDwjt494WavJFnzoIqmYgueY1y6zRhjuOZaa5fnlU2/
         6L1Q==
X-Gm-Message-State: AC+VfDyr9g5eaJEfxeMMo5IQEKLaHCibiIJ8IweLnxJ1F+waPUghxaW8
        w/KozV9LrsloZpKWBiFfPe8v7NJ5FLgCcG7Q7egzObgQhlmh
X-Google-Smtp-Source: ACHHUZ7IxAvaObznXnMrgZgtX15bUMBgnYnKGIvF77bGXOOdrjy4l9yVtOZYDPGh02iwjg/Ik5XX8aC9HbWnhziALyXToOLHE5VH
MIME-Version: 1.0
X-Received: by 2002:a92:c708:0:b0:33a:54b1:5506 with SMTP id
 a8-20020a92c708000000b0033a54b15506mr2685176ilp.2.1685350075610; Mon, 29 May
 2023 01:47:55 -0700 (PDT)
Date:   Mon, 29 May 2023 01:47:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000943c3c05fcd1243f@google.com>
Subject: [syzbot] Monthly ntfs3 report (May 2023)
From:   syzbot <syzbot+list2081dffd0319a3bb8057@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
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

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 4 new issues were detected and 0 were fixed.
In total, 57 issues are still open and 23 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3558    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<2>  2648    Yes   UBSAN: shift-out-of-bounds in ntfs_fill_super (2)
                   https://syzkaller.appspot.com/bug?extid=478c1bf0e6bf4a8f3a04
<3>  1371    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1104    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  942     Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<6>  656     Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<7>  425     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<8>  334     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<9>  310     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<10> 58      Yes   KASAN: vmalloc-out-of-bounds Write in find_lock_entries
                   https://syzkaller.appspot.com/bug?extid=e498ebacfd2fd78cf7b2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
