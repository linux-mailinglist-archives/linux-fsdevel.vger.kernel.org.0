Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3811C6D2363
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjCaPBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCaPAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:00:55 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2723CD527
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 08:00:46 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id i189-20020a6b3bc6000000b00758a1ed99c2so13534990ioa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 08:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274845; x=1682866845;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXJeCN66PsTRTpcJxolDc689G/RLppmQwQj5w4uhgxs=;
        b=jXWAM9tUXBbtC7p2S93YuFpWEviguMBfvYCEiOhTtXxDIu64dUxLRFZTxP3fE3X2PF
         uskNNAAtwj5wcotS/pNiKwrXuXKvWnjMpkjcQQkI8V+qqY712MjqqIMjIoWDz6PlX4Gf
         k3NRyMTr/1vVYzaP31B5qx1YbJJRH8Sfoltizy6Z0jJoVcLt3xjLRFxwOvqVfm0qgUCE
         hMWGDYqzBtsi5TVFILzuPfMguWgq522UzirMblMZ6epG4C8c87I7udAdLpj4OGYxDbOR
         hFzMtDJgjzooMlFL3ZSpshibhsra50K33gmLL+yZTvRjJMnt256L3kEP0u/+b5nIs3yI
         hXTw==
X-Gm-Message-State: AAQBX9dXEsM9WLIa3IEC+nAIfYKKXYk2CFXkVEVN2bVBgxpVGHOzecUn
        due0J913e1pLnBbVafjJsWXARvpH+7LLObLi0XGja10dCQwJ
X-Google-Smtp-Source: AKy350ZX/pvMQTmLXUtbAKlExwmzb2czsedhAzyocEligNmGlu56sU1PUdvDN7qEP3HNKw6brs1mPomqbsL0ucNreL8RaX2VMmoG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c47:b0:326:2900:f494 with SMTP id
 d7-20020a056e021c4700b003262900f494mr5214354ilg.4.1680274845143; Fri, 31 Mar
 2023 08:00:45 -0700 (PDT)
Date:   Fri, 31 Mar 2023 08:00:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045192105f8337955@google.com>
Subject: [syzbot] Monthly ntfs report
From:   syzbot <syzbot+list699b83da9318c0cd04e4@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello ntfs maintainers/developers,

This is a 30-day syzbot report for the ntfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 22 issues are still open and 6 have been fixed so far.

Some of the still happening issues:

Crashes Repro Title
935     Yes   possible deadlock in ntfs_read_folio
              https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
581     Yes   kernel BUG in __ntfs_grab_cache_pages
              https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
261     No    KASAN: use-after-free Read in ntfs_test_inode
              https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
171     Yes   possible deadlock in map_mft_record
              https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
112     No    possible deadlock in __ntfs_clear_inode
              https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
77      Yes   INFO: rcu detected stall in sys_mount (6)
              https://syzkaller.appspot.com/bug?extid=ee7d095f44a683a195f8
4       Yes   KASAN: use-after-free Read in ntfs_attr_find (2)
              https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2
4       Yes   kernel BUG in ntfs_lookup_inode_by_name
              https://syzkaller.appspot.com/bug?extid=d532380eef771ac0034b
2       Yes   KASAN: use-after-free Read in ntfs_lookup_inode_by_name
              https://syzkaller.appspot.com/bug?extid=3625b78845a725e80f61

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.
