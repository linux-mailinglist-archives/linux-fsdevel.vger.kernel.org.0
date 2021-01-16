Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7F2F8F11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jan 2021 21:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhAPUCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jan 2021 15:02:52 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:52697 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbhAPUCv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jan 2021 15:02:51 -0500
Received: by mail-io1-f70.google.com with SMTP id x17so21520261iov.19
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jan 2021 12:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=25oiULFwsqkFXtl6leOBh1FV4HInwizBo0MX+oG5lrs=;
        b=P9rvZo2Myk4SMQOqei070VctlL3iMbxRtNzhiGeYn0rJWfdQ9esi9qizRwIdR/P+WR
         O6IlZZueQfRPo8MTqmII2UXcCZaFFOg0+fHHuZeCOl9IJpJrbG2AQRibe5jlYjVjYHmr
         DFiOdIX1YrYeYvRUrBFssA7V8pbWi+i6cg179kaRL4u3qw/cQeaCGE/enajFdVspVXUV
         PfqB8zAOILczNrkG/NIgpdtvJIzfr0aSMqD3rstIISnKZyRxNLaNDvlxtxKay6Fg+ExV
         uWSwCQFJT1HWTypHAdnsTUXbULmZSHAgUVms8rKmJMnMqCqBpUpJM5vq1H6T80VkyTkv
         Vz1w==
X-Gm-Message-State: AOAM533TQtMoRhYVCFwBMQEk30URo9YNWHdC9P4RHPuJulz28jase/sC
        GtaMyWdYV/XPZb/cxGkdlBBtHK8Zwh4S0Y7hIrt1GSmmW41m
X-Google-Smtp-Source: ABdhPJwaoTax2werBxr7K+WKwqgG0Pi0z7EcJY/I86x6sWY1uQG8mF69C3pYn7lIXhYyH3B6h9OEwbjPKuxszOOZaMLE9AEd9aSD
MIME-Version: 1.0
X-Received: by 2002:a92:c692:: with SMTP id o18mr16025125ilg.215.1610827330994;
 Sat, 16 Jan 2021 12:02:10 -0800 (PST)
Date:   Sat, 16 Jan 2021 12:02:10 -0800
In-Reply-To: <29e3c654-a1ca-e0ca-2af9-948feb5b00b5@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbc86a05b909f62d@google.com>
Subject: Re: WARNING in io_uring_flush
From:   syzbot <syzbot+a32b546d58dde07875a1@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a32b546d58dde07875a1@syzkaller.appspotmail.com

Tested on:

commit:         4325cb49 io_uring: fix uring_flush in exit_files() warning
git tree:       git://git.kernel.dk/linux-block io_uring-5.11
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6b6b5cccb0f38f2
dashboard link: https://syzkaller.appspot.com/bug?extid=a32b546d58dde07875a1
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
