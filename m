Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3518510EC36
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLBPWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 10:22:04 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:37093 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfLBPWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:22:02 -0500
Received: by mail-il1-f197.google.com with SMTP id t19so7358426ila.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 07:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yoaw0PwFg2A6gDglB5LznPWl+Lud/RfolRLMztLbYOM=;
        b=MslMpYGovEgebtjEx6E3BLz5vzy9wYB1FQCRI3amf/bEJiq3gUVipuzKaof85Ma8Qw
         SjNVZ2Qhin325AFbuIVUr39ulf115g4/zjWKmzCjxe77CCW2t/NgERejsemiquNU+DZ1
         Ss+iIIieEyuObhf1HEzvfKVVqsjhAqq2t4ozgCfAXRfoy1i+InvarjXnOuMWmFVww6Dq
         pE5nbxpBI4QVPyQWxPtXY/DGXPvJAHSwkXPMBH+n9/yeZRKXGlpTPzLyELTfpF4G8PBq
         ivufNzREj+1p/nFPaRRi7x+YrjVi/EOft1DGpP1iNH/rJ2n01WLVhUUC6l+2Cn/cX7PD
         s6nA==
X-Gm-Message-State: APjAAAWWEGZqF5hONythdgX6ENiBDmmMTZBKc4/YDX0bab8hSfOd4VkQ
        qbt0OD/RB3nvQcenC/G9x+xP7iYgDAWBoKQbft5Ct7BcxgrQ
X-Google-Smtp-Source: APXvYqygl3XRg/RBFqVukkdgwZRNVl2uCNOuiX78gKyVxsKxIvwL0CTDPj2IidIQmxtbhRnxA50TBWTRjZbP0m4y1guFs+uD5e2O
MIME-Version: 1.0
X-Received: by 2002:a02:962c:: with SMTP id c41mr29142298jai.74.1575300120660;
 Mon, 02 Dec 2019 07:22:00 -0800 (PST)
Date:   Mon, 02 Dec 2019 07:22:00 -0800
In-Reply-To: <000000000000da160a0598b2c704@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b5b540598ba2498@google.com>
Subject: Re: general protection fault in override_creds
From:   syzbot <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com>
To:     Anna.Schumaker@Netapp.com, Anna.Schumaker@netapp.com,
        axboe@kernel.dk, casey@schaufler-ca.com, dhowells@redhat.com,
        dvyukov@google.com, io-uring@vger.kernel.org, jannh@google.com,
        keescook@chromium.org, kstewart@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, neilb@suse.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 181e448d8709e517c9c7b523fcd209f24eb38ca7
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Nov 25 15:52:30 2019 +0000

     io_uring: async workers should inherit the user creds

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10424ceae00000
start commit:   b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12424ceae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14424ceae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=5320383e16029ba057ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd682ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16290abce00000

Reported-by: syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com
Fixes: 181e448d8709 ("io_uring: async workers should inherit the user  
creds")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
