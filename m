Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95C2F9B00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 09:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbhARIKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 03:10:01 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:56164 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbhARIJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:09:54 -0500
Received: by mail-io1-f71.google.com with SMTP id j25so27997332iog.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 00:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wEiWUD1KoU2kz++HYBOdztSbeG+sfsDlGM9Lh98rKKM=;
        b=LGLcQMnhpp+DPGop89Xv2n5YETcxyYLZdxRs9o5f5gHFGh6KGRmTIe9CZ78hudccCS
         b7jNosAEB8NjHWzlg2VvJCnPIZJr+IFwUNRJlj/1lL3eFn7KtauNLqV/1FPF6gipsou4
         Is9583tBp+enw/0e4oRjbJyOoJTc3A1AJmJbUSUrdU6ozzdur7D7KA6qPyMXqznkTr9o
         /98Ynz/ITxJtHbxZ6uUfKtQMQDWNcK0fAyqN8bYghZQzLM2ejgDNphkTKPVbgdcIetqg
         Vut9wb9rqKkSChnO+O0bHW2NV4wlbnShL9bGC1JFimmfWDwnVioVRjw41ElCdgEKX3Fx
         Gnkw==
X-Gm-Message-State: AOAM532cNsDEpu0awfJQyIJECPVYx6vuuULVsK50LE7nFuVnpWajOLX8
        WiVLv3w9ZeRQ+rzqv3ewmz0f236a4n1C1+Z//0aYRrbM9QAw
X-Google-Smtp-Source: ABdhPJy3DgoWHLFvzuYDkJzDwwA1JaPpvsFtlorUiuid/k905n8sJMZK4Xd3jj5HaJiA1RUHc/Jk2/sDAy2KQkj3cP16ie+7PFKI
MIME-Version: 1.0
X-Received: by 2002:a92:cccd:: with SMTP id u13mr20286819ilq.273.1610957353923;
 Mon, 18 Jan 2021 00:09:13 -0800 (PST)
Date:   Mon, 18 Jan 2021 00:09:13 -0800
In-Reply-To: <000000000000f054d005b8f87274@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d43c1305b9283c0a@google.com>
Subject: Re: WARNING in io_disable_sqo_submit
From:   syzbot <syzbot+2f5d1785dc624932da78@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, davem@davemloft.net,
        hdanton@sina.com, io-uring@vger.kernel.org,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit dcd479e10a0510522a5d88b29b8f79ea3467d501
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Oct 9 12:17:11 2020 +0000

    mac80211: always wind down STA state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b8b83b500000
start commit:   a1339d63 Merge tag 'powerpc-5.11-4' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1078b83b500000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b8b83b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c60c9ff9cc916cbc
dashboard link: https://syzkaller.appspot.com/bug?extid=2f5d1785dc624932da78
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f207c7500000

Reported-by: syzbot+2f5d1785dc624932da78@syzkaller.appspotmail.com
Fixes: dcd479e10a05 ("mac80211: always wind down STA state")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
