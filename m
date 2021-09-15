Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885E540C2F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 11:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhIOJw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 05:52:28 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55075 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbhIOJwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:52:25 -0400
Received: by mail-io1-f69.google.com with SMTP id e2-20020a056602044200b005c23c701e26so1331682iov.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 02:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OaUs54KYE2dDB55GtbB/YxbBBPa+RBaXGRBRYMoLDKU=;
        b=mfDZ6IJAQtxIBBhTFpN3upYYfwLgLuQsed+5NjPB9DgEVFqEDKje+LTLosOi8zN8os
         Pk/hen+72HXGcXRCYarV4iKjwfg0lT5B7iedLmQfc5jk+QZ8o+KpoDfwuKKcAHwPPbYh
         Vso3kF19B7XNFowJ8JZinDZS8qKfDd6Qo2tUosHjpqIBpUHpgslVhqVi8MQ99EF6MeWQ
         yLOZm/EjcbvuHf5kGmYZ2ba2oeYVNqBvnA9vXJtqH1l0fWs3FQEtnFv2eNHw0Oq7BQgh
         62qtUnLLZ/+J7UTtaiVRXSH/Qi7e8+Y/OtkNvzDPyn/in2W8jYSn64MsIuIsX9x15Ap2
         fjNg==
X-Gm-Message-State: AOAM530Rik5578FTYi9Z7ANgdyCYWjXtY4eAp5UOHWtukYOV+yZJymS1
        Lo5MkuGjZZhoDmZYB0viEkcdKu2O+Lt88rU5QwMqhGCrptfK
X-Google-Smtp-Source: ABdhPJxjyFHohDbIEXYdADd0QU860qw30kCuDJ3L5SMpqY/Ye8pmCqxqNT1+TDyRuqO1aqUby62HwN40PgfqFyKNbZdzfBLlMBT7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dce:: with SMTP id l14mr10147510ilj.272.1631699466084;
 Wed, 15 Sep 2021 02:51:06 -0700 (PDT)
Date:   Wed, 15 Sep 2021 02:51:06 -0700
In-Reply-To: <000000000000a5339205c9e53883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e753105cc05a31d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in h4_recv_buf
From:   syzbot <syzbot+a06c3db558cbb33d7ff9@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org,
        stephen.s.brennan@oracle.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0766ec82e5fb26fc5dc6d592bc61865608bdc651
Author: Stephen Brennan <stephen.s.brennan@oracle.com>
Date:   Wed Sep 1 17:51:41 2021 +0000

    namei: Fix use after free in kern_path_locked

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b29973300000
start commit:   7c60610d4767 Linux 5.14-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
dashboard link: https://syzkaller.appspot.com/bug?extid=a06c3db558cbb33d7ff9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147f96ee300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112b3629300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: namei: Fix use after free in kern_path_locked

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
