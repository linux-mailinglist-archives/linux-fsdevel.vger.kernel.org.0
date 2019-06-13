Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144B2446C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfFMQyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:54:16 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41902 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbfFMCxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:53:01 -0400
Received: by mail-io1-f72.google.com with SMTP id x17so13572516iog.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 19:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Np5gXReZhEQY+f0111rtDnwU/KIuuZ02Fmiq9/XZl1M=;
        b=uP1ekeF+FFb989tI5zeMwc1CXP4EB7jmUFsPUhPmkphPQk76QpswC1nkI8Lr2JheXO
         fjC1EDTZU0748BEwoBlCgxpUbI3w+qRk+T831UaZtW5tj0kzwMSIueMea2kxKZlgJ3mx
         zu6QDCEQbLSG4ykz1TnK9lvIFLwE1g+3QM3l1yzfPIS6cA1RHSFxbFRsXHfrmvDmXz1A
         h3PJLl5jdM1u7tsZklRwGbjApdu5hTWZXTo+UyRx4NCkbogVEFnoqznu+EDL2mxsA6Q+
         U2A40FWqTxpnQfz1xNEwTQePi1vk7PDLaujcjmNTR1aOly8Vb3TLthUVW25P5sHv4Bn3
         vgWQ==
X-Gm-Message-State: APjAAAWmISdTQ3BCfkz7kWi/BrXel0xxmpCBbamSlPEodb7ZWVXxU5VU
        kRJXxD0+oQ5E1UHTp1xRh29pjHOaPe/3TJIX7XotPisWMMOg
X-Google-Smtp-Source: APXvYqx5IsSM2NAOI/iAdm4c3z4Q0KMokZxWs1UI+Ut9ao7lxnz24tDe4bNCdFgQ1DgRpytXrLHrXA/sEafV/s9VWjsSAD+q/q20
MIME-Version: 1.0
X-Received: by 2002:a24:9d15:: with SMTP id f21mr1753140itd.13.1560394380348;
 Wed, 12 Jun 2019 19:53:00 -0700 (PDT)
Date:   Wed, 12 Jun 2019 19:53:00 -0700
In-Reply-To: <000000000000a861f6058b2699e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0103a058b2ba0ec@google.com>
Subject: Re: INFO: task syz-executor can't die for more than 143 seconds.
From:   syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
To:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 4ddc1b28aac57a90c6426d55e0dea3c1b5eb4782
Author: Chao Yu <yuchao0@huawei.com>
Date:   Wed Jul 25 23:19:48 2018 +0000

     f2fs: fix to restrict mount condition when without CONFIG_QUOTA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142f4e49a00000
start commit:   81a72c79 Add linux-next specific files for 20190612
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=122f4e49a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa46bbce201b8b6
dashboard link: https://syzkaller.appspot.com/bug?extid=8ab2d0f39fb79fe6ca40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1250ae3ea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1568557aa00000

Reported-by: syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com
Fixes: 4ddc1b28aac5 ("f2fs: fix to restrict mount condition when without  
CONFIG_QUOTA")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
