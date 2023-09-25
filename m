Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE07AD96B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjIYNn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIYNnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:43:25 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55C6E8
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:43:16 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1dcf9fda747so8664882fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649396; x=1696254196;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VF68zkfKFnG1LgMixZRaqdDmbqccd5ovmXesnmna+Hw=;
        b=QfVslsBb0ynPhrbxKbj0S1Zn0PGrMMj4c+QjITNH9i9Gd2HKzcx0dJIifv3hfSN4/D
         Zu8DDRv5bLEmOoYY1NdGA7boHRuJ5xKwuT7PNisbN4gfaa7diYCcI0GY1cD/o6gBi4kA
         NMUs5P8L1Z8IiDZJKtMg6i8N1/cE5yZ0EJIs5brDUGhOFkrgtXdYLxUmzi5xitJriNm8
         YFlBBJWbJLZc4Ol4G1i4lGypOoPxO35dx9a3BshcmQobpS2GeuCowt5iUuB1RMP8pvqn
         X9xADRkMtybkX6jPc9+o8deWX10jt7fb0/MCSyT3RvyNXsorIYACND/H9f9ZY6YqLBFe
         ZQMA==
X-Gm-Message-State: AOJu0YzVRQ1z4MVgNLFqY4WfKfObf2ulZ6WpAz7r34csb5b5F2dTn38N
        sRFR9/uv+yeK7W1DEw8NddZ3rGiVfHY/ErJlmR6WyuxNYcsg
X-Google-Smtp-Source: AGHT+IH0gZAmpaZ1qZbrt0tpkkEfhIsEo+C5auJfqutx56kdHSyN7W98CPA4+w0Qa8eUCvdlIErilRyMMEjPale+9HIQijRDA5sl
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a89d:b0:1c0:350a:92d5 with SMTP id
 eb29-20020a056870a89d00b001c0350a92d5mr3078159oab.4.1695649396125; Mon, 25
 Sep 2023 06:43:16 -0700 (PDT)
Date:   Mon, 25 Sep 2023 06:43:16 -0700
In-Reply-To: <20230925-mitangeklagt-kranz-992ed028ecdf@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb76ea06062f23aa@google.com>
Subject: Re: [syzbot] [ntfs?] KASAN: use-after-free Read in ntfs_test_inode
From:   syzbot <syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, brauner@kernel.org, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux@roeck-us.net,
        phil@philpotter.co.uk, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
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

Reported-and-tested-by: syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com

Tested on:

commit:         493c7192 ntfs3: put resources during ntfs_fill_super()
git tree:       https://gitlab.com/brauner/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=121d3e1e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
