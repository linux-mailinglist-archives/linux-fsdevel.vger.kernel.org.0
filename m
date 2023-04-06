Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56CF6D9153
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 10:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjDFIRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 04:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbjDFIRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:17:48 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3F959F9
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 01:17:45 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d12-20020a056e020bec00b00325e125fbe5so25271888ilu.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 01:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769064; x=1683361064;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/g4nzehKA+hwiOXEY+4Ds0o+sycPpAKPzUEO7dFZTY=;
        b=JQw+2x01jO2Ha2lx3OlYj3eS7wq2GV1fyyN87EfQ93mMH7Z+8ufXNEMJNsFJNlYLcQ
         isVZVNvHGNAyu4mwAVZwDAiMJQ3es3FOzh4ABdcHgJZDjlNEN1kBINFCmvSYF0LHgXoi
         0LlkZ0FFeNZnNtOKQrMTroV6v1QcU87F01YEKPXTNwULPcnJ4IHzu1AkP8HA6TdbEIg1
         2dKfFQTmlBJfPN/CdoxgTjHkEhLUlxiCn+ZAV25ajar6XI1bR5Blb2O286zA9pzqk4jz
         cbc43vy/Wsp7fe1XhXWm6wxkvN67hYIS2Nth1Wp0SApSicMX8h/8hOF+rP6Azk874D5W
         KwRg==
X-Gm-Message-State: AAQBX9dHnoEhsZCjixd2e5ZAwhqY4ATzLFchUXwWPxZNlradb+kvd4UR
        ywAJ2Un73QaASGlz5XIL5mRB09IVyylYmc5ybIrhTTdCLfAf
X-Google-Smtp-Source: AKy350YuXMCN3QocCYBM4Ie6yRSB5hDHbkj9MYTwMgoZEdNx8Kce4uWD5ZtPX5sfy0HQ6Wo9POC6ezuVnHRaiLstYhnSBNfs/J1v
MIME-Version: 1.0
X-Received: by 2002:a02:9381:0:b0:3a7:e46f:1016 with SMTP id
 z1-20020a029381000000b003a7e46f1016mr4733802jah.0.1680769064789; Thu, 06 Apr
 2023 01:17:44 -0700 (PDT)
Date:   Thu, 06 Apr 2023 01:17:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e6e2205f8a68bea@google.com>
Subject: [syzbot] Monthly 9p report
From:   syzbot <syzbot+list4520eff69bc900db1eac@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lucho@ionkov.net, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
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

Hello 9p maintainers/developers,

This is a 30-day syzbot report for the 9p subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/9p

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Crashes Repro Title
248     Yes   WARNING in inc_nlink (3)
              https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
124     Yes   BUG: corrupted list in p9_fd_cancelled (2)
              https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6
108     Yes   WARNING in v9fs_fid_get_acl
              https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.
