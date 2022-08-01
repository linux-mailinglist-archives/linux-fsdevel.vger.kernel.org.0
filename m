Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1B9586B31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiHAMrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 08:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiHAMqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:46:55 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537BCB495
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 05:37:12 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i8-20020a056e02152800b002de75b135d0so2438355ilu.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 05:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=2brqTd/WAd0gKXo8nmHwD4y8UrUzgWlgdZnzGpae+fo=;
        b=tb3dkOY3071jQjjKCTbDbh9EuwTyVnE3pRArfvmb/h4isKDp1Q2cGEaPdg0g4MEHet
         8DB+RczTeWEYvjIiJLiHktka4nJiQ0YNm0de+V0paqcgRqpuTqkMBrPQFa2+WCvIykRc
         TFMBriUPWcuBD/LyUjEgI/g7sr6dTN0p+97zfbKYIaJvr706MHHfztKndn9cR8P+oMO0
         LfuGvdg0fCy5KAa1HQL8bGsDZNsA+kNR00VbBquXkQ8qDaZKo2kXZKO3LLjBGFSe+VOk
         V0ngt3Yq6Zbu8igXQFOjQY67i4AC9jTIBj4evz/ZUYcNj9n3bVd84JMnc+nOQuELSvcM
         /h/A==
X-Gm-Message-State: AJIora8CCBjSSmTJth2I9yujjvPpcxNSIwMxCs9mk+N8Pd+MLturTJD9
        M30a82qFhP8t1D/Re+mZQn45hZEsBr8Py6emK8XV+ooumGY8
X-Google-Smtp-Source: AGRyM1sluxI2TFpyrKtxpqt9wr+1vyzRxSY+cIBC4ponFvIyVPbZdmzjiP3dXmgH0ID/yndCieMPtV0s9Z8CKR06QkLu0udqHpBO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2149:b0:2dc:7abd:e129 with SMTP id
 d9-20020a056e02214900b002dc7abde129mr5938916ilv.24.1659357431711; Mon, 01 Aug
 2022 05:37:11 -0700 (PDT)
Date:   Mon, 01 Aug 2022 05:37:11 -0700
In-Reply-To: <CAJfpegvAPDA-kqCZ8OAqScwfgSoyh5RNQu3rg=LBh6+dFh0hEw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045cc9405e52d428a@google.com>
Subject: Re: [syzbot] memory leak in cap_inode_getsecurity
From:   syzbot <syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        marka@mediation.com, miklos@szeredi.hu, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com

Tested on:

commit:         3d7cb6b0 Linux 5.19
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14385261080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5466231eb53fa40e
dashboard link: https://syzkaller.appspot.com/bug?extid=942d5390db2d9624ced8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14edd10e080000

Note: testing is done by a robot and is best-effort only.
