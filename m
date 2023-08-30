Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE24578DBBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbjH3Shd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbjH3Jyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:54:52 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137AB1B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 02:54:50 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26b10a6da80so4931605a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 02:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693389289; x=1693994089;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dOnceopneHFIwGJjPr+ZbkIEpTrg3pEXAn0bK5utkU=;
        b=ZnKPrnU0GqoQuRYudsnBNbjEMl9rCP9YR/BplgYWJvDNmYQwLxQCX/TS8u4QBb40zR
         7EGsN8cl/2OlWCrISEqEiIT+5EV9dKA8b1f0HUp1SJ/bLeDBN+leJ0kQWtWv631SK5db
         KUisHSRifv/A7fbGZ9u0eXt7I9bPwcVa+KDJS05w6+RU4CMTt0dytNz4OL8dpr9O/060
         Bht7796h5WrDHBPuTtGuG4O5mhIEvEuG6iQqoINROGISYzopjsnZs/1NhTQ/f5DwS7GN
         APK4NWlhVo0GGt2RdTYXYwlIjANLsr198yF0mZwgZYZZrAUYTjBzqOkzCjDrwlJh0Bk6
         jVhA==
X-Gm-Message-State: AOJu0Yy1oP7jYeUgt2KNeokvGMP4rlBL+R6CMUPAgabN4chFTMjcfJsV
        Fg7pLq9Cu8s4D+IXO6rErubMDREVdvgquXB4/Yik9vnpYlPz
X-Google-Smtp-Source: AGHT+IHE+85JmPsj7CXySs2bvJEktSQoEz/ARlemBnkgj1ziRCIw4KCxlNzjzGCoOWMvtjg+n6+IMzBASXi68eZPJ0QSHVnNW3o2
MIME-Version: 1.0
X-Received: by 2002:a17:90b:314:b0:262:da02:8a27 with SMTP id
 ay20-20020a17090b031400b00262da028a27mr426994pjb.6.1693389289674; Wed, 30 Aug
 2023 02:54:49 -0700 (PDT)
Date:   Wed, 30 Aug 2023 02:54:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013deeb060420eb13@google.com>
Subject: [syzbot] Monthly jfs report (Aug 2023)
From:   syzbot <syzbot+list2602cd20bb7c69a5a167@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 52 issues are still open and 14 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1086    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  759     Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<3>  629     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<4>  362     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<5>  352     Yes   UBSAN: array-index-out-of-bounds in txCommit
                   https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
<6>  236     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<7>  162     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<8>  102     Yes   UBSAN: array-index-out-of-bounds in xtSearch
                   https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70
<9>  96      Yes   KASAN: use-after-free Read in diFree
                   https://syzkaller.appspot.com/bug?extid=1964c915c8c3913b3d7a
<10> 87      Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
