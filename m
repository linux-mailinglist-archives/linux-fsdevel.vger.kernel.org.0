Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740AD775F22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 14:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjHIMeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 08:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjHIMd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:33:59 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660541BDA
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 05:33:58 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-269204ae507so3817671a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 05:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691584438; x=1692189238;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkQoAS/IeHCMqEwt3vcuizQc1ovTJnioTwxuhMQA+/w=;
        b=Ftl2xndLIcF8l/pQplSDuPxPVoKkm3rZO9Zb9GFrQ+B2K2/+ZRBEk1oEEzSbIkcYq6
         QHE/L5wGgWDCDFk2J03i0lDWfsDVG1xehVm0IzTQQ3pSeWdcg75p8qjTeydjs6LIGmUA
         GuI9RCHWInhyrVhITmnVQ0rI8ttl8yJkk0pGkFRhLV1i64yXOFE8DF5xb8NohpGj1Rt1
         W4dBNMbAAMRVLXqB3uBn7RmItiWb/xvAZxv74Z/KDNMI4uvTdGjSfkzJZOeiGzsEtOtR
         esAcpEXvlDARn8KQpf7BOC6dw9KNY4djMCde2NqEMGRcTIoXhb2Qo+93L3x6HmhgIygD
         X70w==
X-Gm-Message-State: AOJu0YyHyFkpeD1Ogyyoo2x+RZuel5JP9WZdvGScxVZ0Ad1BzFa0W4/S
        BMdKOcVoGsZUl/qO5sIRpprJY52vC+V42TmePtNIe3Tq3wYm
X-Google-Smtp-Source: AGHT+IFCvgvSGolSRgrguBg5VQ7p0plOFtZYQMuoY66T1SYJTYY6upAFiJSmsl89QifxwbqxJjKBu4U+Cguk+Eo3su1c1rnT0EmI
MIME-Version: 1.0
X-Received: by 2002:a17:90b:203:b0:263:11f8:a12c with SMTP id
 fy3-20020a17090b020300b0026311f8a12cmr137768pjb.2.1691584437881; Wed, 09 Aug
 2023 05:33:57 -0700 (PDT)
Date:   Wed, 09 Aug 2023 05:33:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087141906027cb1ea@google.com>
Subject: [syzbot] Monthly exfat report (Aug 2023)
From:   syzbot <syzbot+listf0f9e1b5bc716d1eb13d@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 0 new issues were detected and 2 were fixed.
In total, 8 issues are still open and 11 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 316     Yes   possible deadlock in exfat_get_block
                  https://syzkaller.appspot.com/bug?extid=247e66a2c3ea756332c7
<2> 235     Yes   possible deadlock in exfat_iterate
                  https://syzkaller.appspot.com/bug?extid=38655f1298fefc58a904
<3> 213     No    INFO: task hung in path_openat (7)
                  https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<4> 46      No    INFO: task hung in exfat_sync_fs
                  https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
<5> 24      Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
