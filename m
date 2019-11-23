Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A4107C6C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2019 03:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKWC1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 21:27:01 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44092 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWC1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 21:27:01 -0500
Received: by mail-il1-f200.google.com with SMTP id b12so7926927iln.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2019 18:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AXD7gA5IclP9MlEfBt3hOECjOVr1z7Xrb3xxCpv2mBI=;
        b=LOc94rV6ca8QUsT6kXIspMa1VzagXKHuKffhgE9UeHlJKRU3dSEBXT843vPIHdDo8U
         hxWIDtCFMHelUntJ9WrkeR2d1Xqi2dEoGevzpxRs7qF/i06TQ7p9+vQKwuL9yC44gEKr
         eA3vDI1AcKXq21zFIu/y35S59hokszL2pIdv845K55vNR+d1pYGrL6JT0hYUt8pXD1Qk
         juNUTMsXfNX0HHGVw4u5st0hen/rxEWk63gQsfe2oTEQV9TgeDHOp+hIzlixe24KYgwq
         uDhXinX9spNKpl14VLDX6Q7zoQbE8Qfm3X3bGomrPVdWzxpeNkh3v0ePRecWPjuQYWLw
         p3tA==
X-Gm-Message-State: APjAAAXJx/PuCMnzHS+xVJt90V7bJ80L767KwX1ACxALukgkDX5jExgi
        WZAzOks6YAaNjQckTHfR/etG17hMlEg13/Rjy8d62a6mRPNU
X-Google-Smtp-Source: APXvYqw+zwi8wEAChrZq2ZVReXjmVskvTdckaXjZ2KbBA0nnhxgLvaWwwG2piW1E9CjkkowM30p50xw7NE0F2nHtTiaknnYm/gUD
MIME-Version: 1.0
X-Received: by 2002:a92:bb95:: with SMTP id x21mr20040816ilk.128.1574476020687;
 Fri, 22 Nov 2019 18:27:00 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:27:00 -0800
In-Reply-To: <000000000000d03eea0571adfe83@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebac4d0597fa4340@google.com>
Subject: Re: possible deadlock in mnt_want_write
From:   syzbot <syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, ast@kernel.org, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        mszeredi@redhat.com, rgoldwyn@suse.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 8e54cadab447dae779f80f79c87cbeaea9594f60
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Nov 27 01:05:42 2016 +0000

     fix default_file_splice_read()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15147a36e00000
start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17147a36e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13147a36e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111767b7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1611ab2d200000

Reported-by: syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com
Fixes: 8e54cadab447 ("fix default_file_splice_read()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
