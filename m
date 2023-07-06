Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B79749ED4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGFOSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjGFOSu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:18:50 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4171199D
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 07:18:48 -0700 (PDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-682ce1a507bso580111b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 07:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688653128; x=1691245128;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTfB1lUG5uiw0ksctY3dfVoZYVSL9IN/8FwRIlaLhnM=;
        b=JzN0wq+xYfTdVnDoLAcXdaEV3JOm5WievqbVxkhhZL64JjGm8bUCH3Gk9o1e+t7fF2
         MF4Ct14suIy+QYI6GmRqYGHnufmfboYaLayL4x73DWO6wYSwUcLtTK637dTuH5XslNby
         tOLHQ2Stt+scK9N41jr0gNiwiyBllDuIV1Cd0vXy30S0Hm+6qHbblQVGbY+MK9jEDyHT
         DKHgqf9PF1BZH0LNn2nT6bKhqYLv3D+XA/2M7mJZZcBXIYfuDevAqarDZdtf3mRFTf5j
         kDzTDTeO6mon2F6C7TXLkLhmDJsUfGGOfSLJpjE1w/SE4dYp/Yi7J8ZriDNtaADQtVWP
         Ml3w==
X-Gm-Message-State: ABy/qLbRNSZF3KJNQ5Z7k3OxadumZwu6JFR34y5NW0Dd1OZJXc4V3awb
        vsF9fZbxx69tU4/U+YwrOY4snk8YrdYgrV1BBVF3FvJB1Xse
X-Google-Smtp-Source: APBJJlFlgJ2eVDAPM43xPc+LlNo+eDVtqOEUmA72XQmyPdpD27BR6mlztuGnuDsQJBtf0Aef7Jp6sP4DD30PlHg/srydSfqLqEYS
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:9a9:b0:682:69ee:5037 with SMTP id
 u41-20020a056a0009a900b0068269ee5037mr2642548pfg.0.1688653128240; Thu, 06 Jul
 2023 07:18:48 -0700 (PDT)
Date:   Thu, 06 Jul 2023 07:18:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db94d405ffd231f7@google.com>
Subject: [syzbot] Monthly ext4 report (Jul 2023)
From:   syzbot <syzbot+list863fc044988daa3042ea@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 8 new issues were detected and 3 were fixed.
In total, 51 issues are still open and 112 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1186    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  207     No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<3>  147     Yes   WARNING in ext4_file_write_iter
                   https://syzkaller.appspot.com/bug?extid=5050ad0fb47527b1808a
<4>  141     Yes   possible deadlock in quotactl_fd
                   https://syzkaller.appspot.com/bug?extid=cdcd444e4d3a256ada13
<5>  115     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<6>  97      Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<7>  52      Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<8>  24      Yes   kernel BUG in ext4_write_inline_data_end
                   https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
<9>  5       Yes   INFO: task hung in ext4_evict_ea_inode
                   https://syzkaller.appspot.com/bug?extid=38e6635a03c83c76297a
<10> 5       Yes   KASAN: use-after-free Read in ext4_search_dir
                   https://syzkaller.appspot.com/bug?extid=34a0f26f0f61c4888ea4

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
