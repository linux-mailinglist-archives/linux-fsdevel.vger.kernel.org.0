Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E77787D51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 03:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbjHYBrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 21:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbjHYBrd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:47:33 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A4E19A9
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 18:47:31 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68a3cae6e20so516426b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 18:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692928051; x=1693532851;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yL3CxA8tkredETolFyabWDYx09slvthywe8GQXa4Z3o=;
        b=bvI4w2sJVMKquaEeyVszv3/9avXHNsMu5ap6F2x2mjh0wu4YokKVpsUrtGNQ9X+rJE
         zNdeowG1rvbZMlZbgzDgOMfu5hGmOZqTjGMwO75EQAoX8/4OrYOc+Cpy2nK3QFDJB3QG
         nwiFZhzJxuM1lUF2UcL29RXPtTtZh32cCf1wabuYAf1YofT94WrNlvYprThtuj3MO85Z
         F/l1lsRich0wuQiUNk7/uoTVH9r4ZOv4tMKXkZFu74VovDL9Pslyza4t1A+0M9IQuu6y
         PCQSBqTFECz8kS9yCv0mAs1Q07wClOLrRfpBsl5RMad7+ax46JzZhwSxf14LfQtDA8bS
         e4iQ==
X-Gm-Message-State: AOJu0Yz5K7ajB2i/Fey+IQLj2xpud0bcfp7S3vW/WoQ0fyj56BCDN+f8
        6zDd4h/cP8p28FzoDNM9e0nJBdJwYmOYaDItvdsfp/h/nXhL
X-Google-Smtp-Source: AGHT+IHg3bDM5yKFOpPTzd7kkvqQoXbDuznp//mZjuaO1aV0GJPmJQ+Bx0uMRcAb34HUuxUo0oZ6iIfylc09D1Op6ph0vpyQHdTX
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:14c1:b0:68c:585:905e with SMTP id
 w1-20020a056a0014c100b0068c0585905emr205773pfu.3.1692928050960; Thu, 24 Aug
 2023 18:47:30 -0700 (PDT)
Date:   Thu, 24 Aug 2023 18:47:30 -0700
In-Reply-To: <8680b259-528b-32a9-73ee-ce6a6406f13d@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ba17a0603b5871e@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
From:   syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
To:     chao@kernel.org, hdanton@sina.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com

Tested on:

commit:         5c13e238 f2fs: avoid false alarm of circular locking
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev
console output: https://syzkaller.appspot.com/x/log.txt?x=121bdfcfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ff9844b1e911216
dashboard link: https://syzkaller.appspot.com/bug?extid=a4976ce949df66b1ddf1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
