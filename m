Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF33FB4A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhH3LfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 07:35:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52096 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbhH3LfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:35:06 -0400
Received: by mail-io1-f69.google.com with SMTP id i11-20020a056602134b00b005be82e3028bso3172706iov.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 04:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8yu2qDi/W61ruhvfPtnck6J11ryx5e7EXsUOpCFvzG4=;
        b=Vgx4F5mkMeqPTwbnCj+Bi6LDlJraGbNL/28S6n0sxHDI7f4wXle1wJcQZcUBpjW6aV
         ymWdroIQbco3as5a3nqcD6Mmvblsm8LCjqMy9/4jt/aAAVi62gEESeci/hkHWe5TjCYL
         HP7yGR/76MEoBtPhH+2LogVuN8OQqxRTHQTIcLc6xwit3N8hpP9Cm+L91MkI1PWeKUkF
         dMx7XpIQKjpZD6+djzhXrk6x4o4xAEtjyCBCI7YNGsmz1hc3y9toiXwvFThoc588hqLC
         1Zj/uR7RMAiuCoFhgaPvBF8W8CKE7pKFM7G33y3TnBz/OpyF/YI04sddnGRYiCNED2TE
         UUDg==
X-Gm-Message-State: AOAM530Ay0kpRkTD245K1l5prVmbW7dQ7dGqMVs8XyY9vJmH7Gif/gMS
        jxwwPyV3My26/GP+5F4AvsqjseXUfAd7uoY0q+Fplk8Hcg4G
X-Google-Smtp-Source: ABdhPJw8R8S4wtILrC6Pgi4rcp0GnFmahcRcIzqC11+AgCnvk1l/mVz8zSjhYlwRKul0FOFQlHJqw0U8ywdoT7sMIsTAZe4Odi3M
MIME-Version: 1.0
X-Received: by 2002:a6b:5911:: with SMTP id n17mr17250394iob.180.1630323252380;
 Mon, 30 Aug 2021 04:34:12 -0700 (PDT)
Date:   Mon, 30 Aug 2021 04:34:12 -0700
In-Reply-To: <00000000000022acbf05c06d9f0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053c98205cac53625@google.com>
Subject: Re: [syzbot] WARNING in io_poll_double_wake
From:   syzbot <syzbot+f2aca089e6f77e5acd46@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, haoxu@linux.alibaba.com,
        hdanton@sina.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a890d01e4ee016978776e45340e521b3bbbdf41f
Author: Hao Xu <haoxu@linux.alibaba.com>
Date:   Wed Jul 28 03:03:22 2021 +0000

    io_uring: fix poll requests leaking second poll entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d8819d300000
start commit:   98f7fdced2e0 Merge tag 'irq-urgent-2021-07-11' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=139b08f9b7481d26
dashboard link: https://syzkaller.appspot.com/bug?extid=f2aca089e6f77e5acd46
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11650180300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1510c6b0300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io_uring: fix poll requests leaking second poll entries

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
