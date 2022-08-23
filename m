Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE959EA4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiHWRxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiHWRwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:52:45 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3385FC7
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 08:54:12 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id x7-20020a056e021ca700b002ea01be6018so1953294ill.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 08:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=YORKRMrGh1zHmTJn3Q8vpb+7xewfCJwmWBrDZuO9Hvk=;
        b=SwVbUR5MW1hYkUvOfV2HAsvz0BshD6ov5hNkIcjtaNcg1znX8zofSD/qTX0Mvilv7L
         kUfeGW68/jvzxaydoARW+gunpGjAjJxa3DFpphQen1kSz/gd5MWbfxz9Fjrl5++KFivP
         o3UitOKiw0kzyxhk0lFi43FP7G4b3Xk8Qex3ufnTqUh/NDBWy4ltF453mokxVm6iI1zl
         4zb09ZOi0lDZtxL1CqAz7P8pKvcUTq04NLXUN9zQYUInDBTOVbTfLDn3FI4h+44O7kss
         f8C91oA+MIawudqjJOXtWMlWBmbwtT4QnwH5zeYuoRfAMNS/L83dRuF4r8Nc1LlrAOkt
         M+/Q==
X-Gm-Message-State: ACgBeo2JaenfGWwhz7mr2+o0bcKjKbuuSb5ROgFpWdUkDTu0hVN2AE0O
        NH2By73IfP2U6EX81zHOQoIafBuPisy+aHHC1pPHKhvyoC8f
X-Google-Smtp-Source: AA6agR7DlJVunae3GLR7JIa5CdMoF6d825J9cnKYadOmoeVZl/kMpo9A6rnXBwiLn6b23Z3kvfFODw1snEpilyS3FSBFHKm/eGjF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4197:b0:349:fc58:d66a with SMTP id
 az23-20020a056638419700b00349fc58d66amr873003jab.101.1661270052061; Tue, 23
 Aug 2022 08:54:12 -0700 (PDT)
Date:   Tue, 23 Aug 2022 08:54:11 -0700
In-Reply-To: <20220823153542.177799-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054488105e6ea93c8@google.com>
Subject: Re: [syzbot] WARNING in iomap_iter
From:   syzbot <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>
To:     code@siddh.me, david@fromorbit.com, djwong@kernel.org,
        fgheet255t@gmail.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com

Tested on:

commit:         072e5135 Merge tag 'nfs-for-5.20-2' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=123599b5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f885f57a0f25c38
dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160ef0a3080000

Note: testing is done by a robot and is best-effort only.
