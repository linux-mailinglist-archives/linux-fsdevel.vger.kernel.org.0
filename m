Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC10673481
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 10:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjASJfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 04:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjASJfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:35:16 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F55CE5A
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 01:35:16 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id w10-20020a056e021c8a00b0030efad632e0so1204872ill.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 01:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am8GpKWA1BfZfDywTelCI0lV8JSyrH6JH35aW+117pk=;
        b=ewFxRmP+Z5QE065ULPV58MJyRow+AhUQ53XD++izuzAXhz+31igi9Y60EhGlQSAI0M
         d4TzxjsCHMSYAVkv2f8Dxq+WbJkiAlIt+XIhdHncMLrJOb/23ASL+kmlHpnzaWC5HYVN
         WaMLFoEqptdw55OZ0aHNOsbY9TZYM74wpc6MY9YoyuuZT6aDVupngjfbdAPavZAZfv7G
         YIrxW/KxRrM57YSifyrlQHHOimMDzAmELZ9b8LcUenWZNEx5UjOivusEgJV1q2rbAVCa
         9v2zQXddkyk8IHb4+SUYXCBRPuFHhAsH/yE77eokGablcXon44oJuVJbAUTXXbzWGCqi
         kbIA==
X-Gm-Message-State: AFqh2kpdch/N0eP4u15Xyp3dvg6WP0tyR4xruAPlQsxUWsj9lD+hHftv
        Ey8tNlaJzG3eQWrdrHQLJdQF7wE45HwNZkpdHo43pvyCdHvB
X-Google-Smtp-Source: AMrXdXsOAWPE6bSz4Hy3s0I/hLKjZwQxD0yrmoLIlj3p9fBgVOSQZ+UzmiokcTtqSqnCIFMwiC7AwT2r4rkTMOuBnMzWq3EzLcwe
MIME-Version: 1.0
X-Received: by 2002:a92:d241:0:b0:302:fe4d:3b9f with SMTP id
 v1-20020a92d241000000b00302fe4d3b9fmr1103045ilg.54.1674120915492; Thu, 19 Jan
 2023 01:35:15 -0800 (PST)
Date:   Thu, 19 Jan 2023 01:35:15 -0800
In-Reply-To: <000000000000d7eced05f01fa8d0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007aa8fc05f29aa6d7@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in mi_find_attr
From:   syzbot <syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111e2f0e480000
start commit:   e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=131e2f0e480000
console output: https://syzkaller.appspot.com/x/log.txt?x=151e2f0e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6133b41a9a0f500
dashboard link: https://syzkaller.appspot.com/bug?extid=8ebb469b64740648f1c3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb2ad0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164513e0480000

Reported-by: syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
