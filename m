Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24AC6C824A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 17:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjCXQXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 12:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXQXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:23:38 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41175EC68
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 09:23:37 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id c6-20020a056e020bc600b00325da077351so1480184ilu.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 09:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679675016;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXHrGRX5NGZcTIzX4ZLxrBYpQ0VKw+7bdCwOu3akeUM=;
        b=N+yWTOCQU75LSHDSjD5geHs8pCbi3mez0zpe2317dbxha2KRcy/ZAOHoXhbsNiuakD
         c9sQtz4+JJPPYLSIrJvdMx1iXDxvnaMsY1c+vBObsVT5c7Tu85p4/494BLrQIp1y+zrM
         zb3Oc1Y76OWeOFVwYbK9b/q16IdsL6/cmBcaJSG4rOm4qrn2iGgcPCSkf2rXgNbLqtQY
         eLRNGABEcGw7UCxOQ+E/PlpZZUSs6IYKi8K1yFL6GoZnTAFfKQQ6y9EUUoRvGlf66uys
         M6OGC80ihRo8rgFWFZj7dIx6RGDktOB4B6tOiK3VZlRmf6b6Ea2NbYKUn+DQrEsHaPnn
         4FLQ==
X-Gm-Message-State: AO0yUKUl+w6ThD/9EL4MslGMvwn6O7vg/Pf+BmZSKfOYa13zQ23xKFBd
        NYoFhyjj2VfV/KWuGHlByq5C1Ql7N/MGe3TwrQQk56cU3Uio
X-Google-Smtp-Source: AK7set8eJqrk4+wWMshEzizXyZhEy3VwSSdlYU+p1H1qRTbQ7454XY7v0C1VBjNXzHQb7LsypS+Z/S0cLNwR/hLJe3JMKXqC5Zr/
MIME-Version: 1.0
X-Received: by 2002:a5e:9901:0:b0:745:8ffc:8051 with SMTP id
 t1-20020a5e9901000000b007458ffc8051mr1230356ioj.2.1679675016619; Fri, 24 Mar
 2023 09:23:36 -0700 (PDT)
Date:   Fri, 24 Mar 2023 09:23:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4315105f7a7d014@google.com>
Subject: [syzbot] [btrfs] Monthly Report
From:   syzbot <syzbot+list32e5d8c30adcfd4f0ca2@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello btrfs maintainers/developers,

This is a 30-day syzbot report for btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 29 have been fixed so far.

Some of the still happening issues:

Crashes Repro Title
1442    Yes   kernel BUG in close_ctree
              https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
221     Yes   VFS: Busy inodes after unmount (use-after-free)
              https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
197     Yes   WARNING in __kernel_write_iter
              https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
158     Yes   WARNING in btrfs_space_info_update_bytes_may_use
              https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
144     Yes   WARNING in btrfs_chunk_alloc
              https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
143     Yes   WARNING in btrfs_remove_chunk
              https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
84      Yes   WARNING in kernfs_remove_by_name_ns (3)
              https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
71      Yes   kernel BUG in assertfail (2)
              https://syzkaller.appspot.com/bug?extid=c4614eae20a166c25bf0
67      Yes   INFO: task hung in lock_extent
              https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
59      Yes   WARNING in lookup_inline_extent_backref
              https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.
