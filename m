Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347987B4F40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjJBJmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbjJBJmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:42:46 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4518E1
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 02:42:42 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ae2a37595dso33153761b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 02:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696239762; x=1696844562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9lzjmnDECsVuxR0eNzta65jB9ijAT2ximrGaddwS2I=;
        b=eH2j+8i3JeujxAUCTbZ159YXYdy6yEE7Z/TEjq711qR23QlCl4XFDyem+h6FDTZhcN
         xOqkd0PvDoCOmwZc0u0+NLYAGKDJKidbHFs3AoTHSFqRnOZIDBgmaWQK7kSobGwSsGg0
         aVfe0Tp1cM8e+fjFYo9245f7eo0qNwi5HzbaXAUu39+AxOwUQwLm8wiMVE/SOKiBxWJ1
         dU4y3Y31P6G1tu+arQMushpGR78Klp/hCgoxW24I/+jwJydBzUTKNcqRdrV5eWCDpf6k
         sjjtjGbIkOYhZ8frQ0OCais01TE+AAgrME6ptzWsOlEpjXNqg7gcvva6vDCbrmkYdIVs
         CuHQ==
X-Gm-Message-State: AOJu0YxfCZjNQO/aiD9W3HvDmogyqZA7EB7kaVPu35uLEFYeqOmJiDYE
        6JNNtZnvI2vJvT1FMtEcedmRAXgspQ7JkEMKeXZ6ZGzyNgpB
X-Google-Smtp-Source: AGHT+IHDr8g0fYd77L3NAUGwkycaSCjD7T8S/tveWn1eMYSuIRy7T9dAT8Jci+Uwc4bBLNt82onHkPUcYlqGph4IDmIORLQbhKJi
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a19:b0:3ae:532c:e93a with SMTP id
 bk25-20020a0568081a1900b003ae532ce93amr5192770oib.11.1696239762001; Mon, 02
 Oct 2023 02:42:42 -0700 (PDT)
Date:   Mon, 02 Oct 2023 02:42:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077d7230606b89884@google.com>
Subject: [syzbot] Monthly ntfs3 report (Sep 2023)
From:   syzbot <syzbot+list76acd067f542279b62d7@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 4 new issues were detected and 1 were fixed.
In total, 56 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11288   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  3606    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  1931    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1662    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1311    Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<6>  1277    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<7>  790     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<8>  591     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<9>  514     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<10> 457     Yes   possible deadlock in ntfs_fiemap
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
