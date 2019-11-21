Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA0104A75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUF4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:56:01 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:41759 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUF4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:56:01 -0500
Received: by mail-io1-f69.google.com with SMTP id p2so1420925ioh.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 21:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mfH1KiCJRKrkCk6Xo24N026hP3QeH2tnCMon9TkgaqE=;
        b=UvU+0ARUBdQYMOUafvv6jKL4F9PMYZNcaIdWPwClzTeSuf1hl2Ey2MWdqN5T/7dSPI
         EPmd11MnYliFA8jVCDApi+6fIhJRv5Zd9UVSU1LQdJScQMvJwu4CfUX4Qx8WpzyT9+3W
         WEs7IOBkHri7mnRRjJvbndpsvO12B2uMtHEXpnETspOmT/FGGCM7XPbSkS8IHlvtXkI7
         drAOhzEGE7TZ1lL7C3fmaDLB1BR8NcNY+IRKIn6PUZStwmFTyhGexmkocyRNDLNfPeOx
         aJLbhPcnQYzgTFuSY52C1uUrPWcTjfG18UtpTHVWoIWWNj97S5nHFN+BxHHk5lcXHlGA
         eHPA==
X-Gm-Message-State: APjAAAUUPYqUy4xF+vHiYmjAX4qzueQ3An8vJUcpMEI9JyS947qzCcHA
        hEol6pc7CG0+y5lvRl/svIIZhaCf3r57P9eP4cDGtTLRWIrO
X-Google-Smtp-Source: APXvYqwUKLMPCVsGilywR82DgOMl8S8nXlNM4DAw4/+MPXBC9kph9vWN1fhkX08eEJ5ztd1Hs8pxMXnFldFW3iiHqxZP+FOWzVdW
MIME-Version: 1.0
X-Received: by 2002:a6b:9245:: with SMTP id u66mr5976497iod.98.1574315760516;
 Wed, 20 Nov 2019 21:56:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 21:56:00 -0800
In-Reply-To: <00000000000072cb6c0597635d04@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab834f0597d4f337@google.com>
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted
From:   syzbot <syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyun01@kylinos.cn,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit 206aefde4f886fdeb3b6339aacab3a85fb74cb7e
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Nov 8 01:27:42 2019 +0000

     io_uring: reduce/pack size of io_ring_ctx

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f98af2e00000
start commit:   5d1131b4 Add linux-next specific files for 20191119
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f98af2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f98af2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
dashboard link: https://syzkaller.appspot.com/bug?extid=0d818c0d39399188f393
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b29d2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b3956ae00000

Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com
Fixes: 206aefde4f88 ("io_uring: reduce/pack size of io_ring_ctx")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
