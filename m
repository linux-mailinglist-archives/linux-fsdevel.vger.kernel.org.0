Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79078DAE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjH3SiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbjH3JxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:53:14 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2487CCF
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 02:53:09 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c0cfc2b995so60105705ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 02:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693389189; x=1693993989;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8oA+37JCMv8f315VpTn3fZR5Yd47+q297lZ55yMlOY=;
        b=KlO9Dm76pU1yOsY5v54QB2ZdH74wbfRjkRzFSFfRq3mK6EntOH8wxODzeN2oNECMvC
         fC8XPBAKwJVE8BJ1mCYCKgQLGgAdfIoITmXUE19L5Gc5+666UiRzaBxFUaKl82hDgfSM
         4bpKDqETmsROuN2ipozRYALjomaghQd/1mat+5Kkb+ecTeWpHO0qeYEKEfY0NT8/mj+Q
         DKa2nPLgnptWrJ+i0kK2uu2HXdBD9Q3SwmqYeli3ZEhs7EZicMMz15MI68+HcHpesppQ
         ByrX6jPRNZhdWdqd75HTPssAkFFPi86G3Af5/SPibeFRJR/0Rrv1njdscpl3vp1qVSk+
         TkjQ==
X-Gm-Message-State: AOJu0Yw0YrnsScFYnSDRnXw9C2Ax5Hrjp831C8181+2+FAjqUeEldBml
        VzHtwCqGdx82SEFXjAcimsqnoG/yMYs6IPirO0iltrU0vCXLidk=
X-Google-Smtp-Source: AGHT+IEuEfb6FTNI21OTNjSbZGx2u+8it4g188GpM39nlhHaN0XEtRl2LWvw6Gl2mOiebEy/sMwUNBXMx1TzNzecp47bNPCRvWd9
MIME-Version: 1.0
X-Received: by 2002:a17:902:f68f:b0:1b5:2871:cd1 with SMTP id
 l15-20020a170902f68f00b001b528710cd1mr575322plg.0.1693389189503; Wed, 30 Aug
 2023 02:53:09 -0700 (PDT)
Date:   Wed, 30 Aug 2023 02:53:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b6032060420e5a9@google.com>
Subject: [syzbot] Monthly hfs report (Aug 2023)
From:   syzbot <syzbot+list116a8a577418be09ca84@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 12 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4838    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<2>  4554    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<3>  4005    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  2022    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<5>  1002    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<6>  825     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<7>  651     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<8>  594     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<9>  386     Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 380     Yes   general protection fault in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
