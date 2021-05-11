Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9A37A035
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 08:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhEKG7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 02:59:12 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50912 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhEKG7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 02:59:11 -0400
Received: by mail-io1-f69.google.com with SMTP id 196-20020a6b01cd0000b029043732390d37so12036435iob.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 23:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WAlEVy0ZMfNVjKlh40M9CEJnUjL9y5ekxYFhQsRtRM8=;
        b=amDaiZuoE4FxdFvrbdPsSW4t27OfTr5oQHIiEfuA47UQIdFtD0fxth0zmya0oBR3Kc
         AzidV0NzEffce2VC+5O0g8CZyRQIwtYZCo68MSuiAKSyuJDBtvRzo9ooRhLOh9EU4y8z
         ueF+g5LQmPkUpY1Fs0FsIDIv8+zkIUWX3D1crCooQ5XH63dQ3T1SQ9jSpem5eEROi65t
         BT0z0pmSljAeqFAZKAPK+dlK5bFGSsg64Km4IrDU8MoviH341cX5W2tlWNthQpj9nPgB
         Ib8MJjqHk68zHZfo0bYRCKa6BhnLbUyjrfQ9bfhVr+2qvBwjMNjiS3y6NOTFDY9p9Z80
         CwsA==
X-Gm-Message-State: AOAM531Gu6FuAOpVOXAXi+0krj4Lo9A+VFKYjUJAruer/muRbc1qwgow
        6KSi9w6jZudBZQRS6vy9BMmixY+mpGx7xCsNC1VhSWuTmrPj
X-Google-Smtp-Source: ABdhPJy1+7M05LR396Fy+WAxn+ZHCqn77sqp5GoH6r5WKwYW5bJvDqONdE4jmh/SCNdH5aovFYTBZFc/A80DtjSEiAYMyZW+NOLF
MIME-Version: 1.0
X-Received: by 2002:a92:de49:: with SMTP id e9mr23983574ilr.132.1620716285105;
 Mon, 10 May 2021 23:58:05 -0700 (PDT)
Date:   Mon, 10 May 2021 23:58:05 -0700
In-Reply-To: <000000000000b304d505bc3e5b3a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000749f0605c2086a95@google.com>
Subject: Re: [syzbot] general protection fault in try_to_wake_up (2)
From:   syzbot <syzbot+b4a81dc8727e513f364d@syzkaller.appspotmail.com>
To:     alaaemadhossney.ae@gmail.com, asml.silence@gmail.com,
        axboe@kernel.dk, christian@brauner.io, gregkh@linuxfoundation.org,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        shankarkoli@quadrogen.com, shuah@kernel.org,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
        valentina.manea.m@gmail.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 363eaa3a450abb4e63bd6e3ad79d1f7a0f717814
Author: Shuah Khan <skhan@linuxfoundation.org>
Date:   Tue Mar 30 01:36:51 2021 +0000

    usbip: synchronize event handler with sysfs code paths

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114c0579d00000
start commit:   d4961772 Merge tag 'clk-fixes-for-linus' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9320464bf47598bd
dashboard link: https://syzkaller.appspot.com/bug?extid=b4a81dc8727e513f364d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126d1de9d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: usbip: synchronize event handler with sysfs code paths

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
