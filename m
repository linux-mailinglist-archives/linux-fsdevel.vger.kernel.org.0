Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0455B53DDA3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 20:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346848AbiFES3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346813AbiFES3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:29:10 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5792312626
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jun 2022 11:29:09 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i16-20020a056e021d1000b002d3bbe39232so10395185ila.20
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jun 2022 11:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cOxqeJ/JYbi6sFMPo1alnVEMhCg5I3K/OxKpxuWXTYI=;
        b=ITGHyDgs1f4WpfgjHR7r09MUAiEHpANozcS8De/8LTuaznGnYbye4l+gMAhhO+jb99
         cbQw7jWp5AdIMks35ommZfovmXI1zOgNOzqTw9/QdytVNGaOdvui1W70r1ZMt6GM9CHf
         Cv46AsYszN/wn+p3msgEvlDgs9bp/zXyWuFHFYANQQyEgViwK1G1BpEqrQwtbghqusvZ
         h4EbEM9N33mX5mGtsqRzVhLBpNO1ERLGcCZhg1sgmr8f4seQd4WuqUAFhRUcVMAFZgwB
         P/GQsBoTvzlN6hUPKH3GW+xksxt+2qPHCo6gIGteoHGREMhyfvpWtooK+FbKdPo3UPw8
         XI8g==
X-Gm-Message-State: AOAM532rlih+rI+ZNN8rGy3oYMXKEHLsZMDt2QSxaY124K/Z6kdOPbkd
        LKQRwGcAr6UfPp0GpGp4h0BSKGBJ5yAj/sy8gA6zdn7YPI5e
X-Google-Smtp-Source: ABdhPJyq9YrZ+fId6i8Q08L+Nm7sWYRLuY83ASTXFEaAfmlxLjokGP1QyIr4HShjlItpecypP1C3Nd3mZ90/8AIoQlqzT3E5roFs
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3792:b0:331:884c:d9af with SMTP id
 w18-20020a056638379200b00331884cd9afmr5005004jal.257.1654453748639; Sun, 05
 Jun 2022 11:29:08 -0700 (PDT)
Date:   Sun, 05 Jun 2022 11:29:08 -0700
In-Reply-To: <YpzxhRLKyETOtUeH@zeniv-ca.linux.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc2dfb05e0b7873b@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in filp_close
From:   syzbot <syzbot+47dd250f527cb7bebf24@syzkaller.appspotmail.com>
To:     arve@android.com, asml.silence@gmail.com, axboe@kernel.dk,
        brauner@kernel.org, gregkh@linuxfoundation.org, hdanton@sina.com,
        hridya@google.com, io-uring@vger.kernel.org,
        joel@joelfernandes.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        viro@zeniv.linux.org.uk
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

Reported-and-tested-by: syzbot+47dd250f527cb7bebf24@syzkaller.appspotmail.com

Tested on:

commit:         6dda6985 fix the breakage in close_fd_get_file() calli..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4042ecb71632a26
dashboard link: https://syzkaller.appspot.com/bug?extid=47dd250f527cb7bebf24
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
