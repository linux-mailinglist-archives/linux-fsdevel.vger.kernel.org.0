Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3AD742322
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjF2JVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 05:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjF2JVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:21:51 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D41FE8
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 02:21:50 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b74a1b87d8so470050a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 02:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030509; x=1690622509;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7l5KtrkfZe3TdZVxNxWTIOc6dkwdkg2w+KCysZHte8=;
        b=GgjrjWf1n35F9k74f7gFfs2XLAlVQqYr5DQPo8bxJ6fsL8pYUr2nralFMZKy/FSUQ+
         Hs4WiBVwti6LF4bcxxpOXmx7fHG19TlWT14vuxqHRkPBi/wquHsTiWRjKSk7E4UlUfa3
         eL/7iXgnolbPttnmRQqeVhqhEIyaJwsaKXMhTOUkfwoMpTe/gE/0jCsrcFGFYonjcRfQ
         D0dzSBRs0/15W/T6yZ0l4VlSRuDwFTelKLA5DKAcGpqXWvWDvI8fO4Rnm31n5nKJvwqZ
         1Ad+advHC3WPQxgB/6ISvc4kM3WgheAu8hW39AAFDFTPV7kaDnJLQEwrIRWdSEqmDySG
         E18w==
X-Gm-Message-State: AC+VfDxO81kyY0mRDP+ohIbDd55AIjkR8E/FZv+Sc0sRWhT2AbJwO5C6
        50xqj4SngTqAxRmiGNBu+U9Il1j5AJgmC/QFoH6VBwyiLxoP
X-Google-Smtp-Source: ACHHUZ7Z/d9RSnZbRgBP/S7yAUd65CwbJGk6eHAkuECvddAjQwlYG/cD2VTc9y2DIw28AuSRpEzbRM4EhnFjT04tZM8VvAihB/fv
MIME-Version: 1.0
X-Received: by 2002:a9d:7389:0:b0:6b7:1590:6d6a with SMTP id
 j9-20020a9d7389000000b006b715906d6amr6765027otk.0.1688030509783; Thu, 29 Jun
 2023 02:21:49 -0700 (PDT)
Date:   Thu, 29 Jun 2023 02:21:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7e1df05ff413a66@google.com>
Subject: [syzbot] Monthly ntfs3 report (Jun 2023)
From:   syzbot <syzbot+list1b14ef0414bc5da68ce7@syzkaller.appspotmail.com>
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

During the period, 3 new issues were detected and 0 were fixed.
In total, 59 issues are still open and 24 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3589    Yes   UBSAN: shift-out-of-bounds in ntfs_fill_super (2)
                   https://syzkaller.appspot.com/bug?extid=478c1bf0e6bf4a8f3a04
<2>  3573    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  1591    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1241    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1108    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<6>  913     Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<7>  479     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<8>  440     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<9>  389     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<10> 62      Yes   WARNING in do_mkdirat
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
