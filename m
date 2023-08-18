Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B629781483
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 23:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjHRVCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 17:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjHRVCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:02:36 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6AD4214
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 14:02:35 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bf39e73558so16122015ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 14:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692392554; x=1692997354;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWW738wflJMJQYkrTGuTeXh48bPLNcNnl4v0SBsNOIk=;
        b=X/D4QZFBFE0n+i3sOiJtKndTSVp85nS7p5WeKPJTrgWLJhVP1i3gzoOqh8W7agyoCS
         qGUPfstfzPcGDjVBIhrpxQUo8cng8nl+lduFBI9UTPQZAWRql4gTV5nOjxlXU6FcYujn
         YhMpk54vixHSxIv6NRl5p6OjkEn9lCxwNP/d6ouGBU5H1DO8Jxxaaa4IIrK+6WX+qLYQ
         3EcEvcBR9ie62k/KKyDw80ktK6pDfJOiLJL73ijaI6WjpzdSTHv7GJEETS2X5at97hvO
         hS0F/erOPZtxyyh9eg4p9hTNhBSGpu98ZbFWfGiraN46sk05m3db4j5YwYY7sUiA2Ry2
         KOiA==
X-Gm-Message-State: AOJu0YyVRYK8ISYJqzRh08P5RplqoDZl/+11Seh2fIh8PSqQ3xzkWDcY
        tyU/Yw+0I6Qw6BnnbGpcjwaalC/LEuHXeWAWd2AEdycR4JcZ
X-Google-Smtp-Source: AGHT+IHk0yW+EK5vHIwTnuAVqCAY+wJiyUxOLlBYD4Hlfjx5UFV9syogBVOAY8hPuQW7qBhKAa1vptZ/vYoigV2PuSU/8wo1lLoU
MIME-Version: 1.0
X-Received: by 2002:a17:902:e809:b0:1bf:1a9e:85f6 with SMTP id
 u9-20020a170902e80900b001bf1a9e85f6mr175690plg.7.1692392554387; Fri, 18 Aug
 2023 14:02:34 -0700 (PDT)
Date:   Fri, 18 Aug 2023 14:02:34 -0700
In-Reply-To: <ZN/RRbknKhqeH8vj@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000066175060338d99f@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_getxattr
From:   syzbot <syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com

Tested on:

commit:         261546ae f2fs: avoid false alarm of circular locking
git tree:       https://github.com/jaegeuk/f2fs.git g-dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=16c22b3ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=e5600587fa9cbf8e3826
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
