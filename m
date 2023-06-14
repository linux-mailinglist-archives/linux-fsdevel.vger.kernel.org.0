Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0478072F9F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbjFNKCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbjFNKCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:02:50 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC00195
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 03:02:46 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-766655c2cc7so684939339f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 03:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686736965; x=1689328965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tbry3CeL1KYS7HLNoeY59keftn8OoKLWsLCuyU0Tezc=;
        b=fCA9hC3OG5DqMebB1a7VdBA2f/pCTZz3S0pnI/v+RuejvaWFxM0lBBe+18KPZotR7z
         rMcHAia18N7O5v9s5WAsIbhxAwcjiZlInCsliGPXF+X1CTmxBuFKs3505A7gLuGd9M5m
         FiO/Wp+mStrX2surL6yKLhv+XOuIj28mBOlWVDUoDUVTcfM5EC2cQ6t5gdXBayW2KEP6
         yr6ei8hI+KKSqcsBZTheXaB+1tN8K+rM8HS9tsruoKtpCeqgi3DPXZ76Jans4rbn2hws
         rMbnt5xgd3ehkJ41eD/S+w4O0XsYod4f0BhLyTIGM6TfrRWVvjSgcTbIyGZCPgydov0l
         igUg==
X-Gm-Message-State: AC+VfDytjtp9mWQHTh0/dvTMFLnKPtJUyOjLqvISYymGsnwLwCkj53jO
        Iv4GrDMMYf++s1ba++Gy5PWxDVNQsHdgRUq6PXgejih2J71X
X-Google-Smtp-Source: ACHHUZ5Cw2CSNno0VjcZXjl9srSP0mRFQ395P6uRj7Vr62OPy1ip/51NqUWt88NtV6lhr1nJJCp3EN/Z1xAkIeeMORU86TioNMQK
MIME-Version: 1.0
X-Received: by 2002:a6b:a18:0:b0:77a:e8e3:2c02 with SMTP id
 z24-20020a6b0a18000000b0077ae8e32c02mr5113965ioi.2.1686736965646; Wed, 14 Jun
 2023 03:02:45 -0700 (PDT)
Date:   Wed, 14 Jun 2023 03:02:45 -0700
In-Reply-To: <1423848.1686733230@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aac23605fe140d6b@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in splice_to_socket
From:   syzbot <syzbot+f9e28a23426ac3b24f20@syzkaller.appspotmail.com>
To:     brauner@kernel.org, dhowells@redhat.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f9e28a23426ac3b24f20@syzkaller.appspotmail.com

Tested on:

commit:         2bddad9e ethtool: ioctl: account for sopass diff in se..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=12d9c93b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=f9e28a23426ac3b24f20
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c4f0d9280000

Note: testing is done by a robot and is best-effort only.
