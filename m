Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7213A9A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 13:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgANMri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 07:47:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34247 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgANMri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:47:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so2993285plq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 04:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JrumK/ECPU6a1ytTx+5qrFJa3RX4jsyA9xttpY0r7I=;
        b=Z6qVal04W6NGAx+lYyAdjnEWBEtNf1ApRQhYHf/0lXOscFvFYUyq9lqP5N5MU3Msbc
         1oqLhYdVq2IFYb6miDDRSw8Wyh6FPZ+yEGrHBmPHmVCVCzzYWsUJ7SYQArbdIu2WunIq
         QjyBwavf5zGHK1EBaiqPlCPMx6z8MCq0ovRuCMEMzs8tHR4dIRlrEYE/VlNxrKaPKKlx
         S8DDPanjYzemPBWTUIboIuiW2YI6eLvVjjcHr3QuvtpcOe/JXTCYFHwHxe0rQQDoo71b
         3LBwcoCp0fQdWmxXPZCJNbLyRH3H1gWTTIfVt1IkSTVOADOqYvR6nvoecBF1uMNEv4rc
         K1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JrumK/ECPU6a1ytTx+5qrFJa3RX4jsyA9xttpY0r7I=;
        b=DKVbpAuvKHSMnil8FEsXQi46x0JJv3yTZ/fXUz+8oq3hv2SvvZU6aQFicfJkIdJzPb
         oK5Q7a/7PhtdPoBtcY6+VIGL3bnRZ/bqp3QHC6gbYSBTJxId9djZxCn2K9Fm79n7eqTb
         vPs/NOttOpJIPSRw0uf2SzWN5Op1Ej2Zzj7IWs+WIXJqgZWxbBSRfQud/f6QxcyhENCF
         6Sz77q+PwPZcu7jZB5/c3GmrooB+3lzn3L2xIIEk2rMK9dMCu+dLiqu1ff9sl/kuI9Gm
         FdhhFKnXqLKbSKmNa9XJeNryh2S2MeXwyYR+J5nSu1VzKOxKIwgC+IhGThAg1J1nSk0M
         A1rQ==
X-Gm-Message-State: APjAAAVSZ8qOhltNb9Sv2CudyPRQ1JiDEqBjs9oL8BjcqHvt6GlJOYEW
        WgVBYKhSxn8lsBoWpJqIATyo7kZKX8TXKrzQePMGwA==
X-Google-Smtp-Source: APXvYqwOoZeD3//OK/UpkwfRS+hgKDcn9lKUlqGXIsSWDFIvhx6ylhQr9w5Nn+MAebeDxAzwnu2Z2MoPtMjTrEmGX8c=
X-Received: by 2002:a17:902:8d8c:: with SMTP id v12mr25249001plo.336.1579006057309;
 Tue, 14 Jan 2020 04:47:37 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008dcde00590922713@google.com> <000000000000d80d1a059c0af28a@google.com>
In-Reply-To: <000000000000d80d1a059c0af28a@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 14 Jan 2020 13:47:26 +0100
Message-ID: <CAAeHK+y2u21FB1HYvEZLPWVP11CkurALx0wORooXs6aAVje8XA@mail.gmail.com>
Subject: Re: WARNING: refcount bug in chrdev_open
To:     syzbot <syzbot+1c85a21f1c6bc88eb388@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 9:02 PM syzbot
<syzbot+1c85a21f1c6bc88eb388@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit 68faa679b8be1a74e6663c21c3a9d25d32f1c079
> Author: Will Deacon <will@kernel.org>
> Date:   Thu Dec 19 12:02:03 2019 +0000
>
>      chardev: Avoid potential use-after-free in 'chrdev_open()'
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14412659e00000
> start commit:   81b6b964 Merge branch 'master' of git://git.kernel.org/pub..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d98e4bd76baeb821
> dashboard link: https://syzkaller.appspot.com/bug?extid=1c85a21f1c6bc88eb388
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147ad0a6e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15483312e00000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: chardev: Avoid potential use-after-free in 'chrdev_open()'

#syz fix: chardev: Avoid potential use-after-free in 'chrdev_open()'

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d80d1a059c0af28a%40google.com.
