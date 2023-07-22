Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF675D975
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 05:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGVDnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 23:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGVDnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:43:41 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6D230F1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 20:43:39 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a426e7058cso5829820b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 20:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689997418; x=1690602218;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAMEMAdmbmttw5YPvNXuauoZBE1q9FfZAQHS9dSgDjE=;
        b=haN4ieDUA9UdEc4ifhZo3xXyEtHt8CBhkk2paicNq1qhoj62b2j60xfbHvnMGStlEf
         xiRcmAIyMjrdlp4WyhGRu3p65jpVMYbaKZejMyWESE3kjsh7Hf7kOCJPgieuqGW4ZiIS
         SWGiazA/A3Ju69F+YMcwyuUuQGXzU91AsA2npCA+YoMGMet8X7Le3bZdKDwWXiQC5Y3n
         5NzvETX3Uu/dSGZQjKBsYtmwT+v80IIthSO5HNwicPYBFR8K2rIaV5X40J3mnror6nB+
         x9CbgkvM3L5oeejv/XKgX6rYBaTvQ4mNpcRUhf+VXp+GLP0LQNijA7V4hXmYX9zs29ii
         oXRA==
X-Gm-Message-State: ABy/qLYsrrt/r60zPF8dqpf5M/h5RluM0Kkjb1INK/TpHJ1Hz7pBJMKS
        t+FU/AYtYqKT/hnvpbvY99PAlvs1VbBgwbp+aWdj8L08C9eG2vU=
X-Google-Smtp-Source: APBJJlEy9qyQ148ZIoOWJ4EYZ/oCstSNClRmiVPCL1SHHGNqvxM1pHgpncz3oWi77/QVcFat4l68BAu4nr7IhaTf6yAXnhLT53UB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:180e:b0:3a3:d677:9a8d with SMTP id
 bh14-20020a056808180e00b003a3d6779a8dmr8384853oib.0.1689997418550; Fri, 21
 Jul 2023 20:43:38 -0700 (PDT)
Date:   Fri, 21 Jul 2023 20:43:38 -0700
In-Reply-To: <c0c7247d6a133b188c8e9780f243ae29@disroot.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cddbf806010b2fe9@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_show_options
From:   syzbot <syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sel4@disroot.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com

Tested on:

commit:         aeba4568 Add linux-next specific files for 20230718
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12db078aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ec534f91cfce6c
dashboard link: https://syzkaller.appspot.com/bug?extid=155274e882dcbf9885df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158d50bea80000

Note: testing is done by a robot and is best-effort only.
