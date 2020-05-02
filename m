Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172961C246E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEBKHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 May 2020 06:07:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:43976 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgEBKHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 May 2020 06:07:05 -0400
Received: by mail-il1-f199.google.com with SMTP id c15so7585887ilj.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 May 2020 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=m1hRXR9BMt4ToPnusTADtXKnayxV/ZH6J13/KcH/RN8=;
        b=DGBZwUfwPh76t/yUiY9wR6E/Lr512Gdu+gIoewWWMI6DdiRnUpTXAuf2RCdDXKWo9d
         QY3OjNJ0CABctO6kJwaUT4g83b2Yy9xk/MuFE8wTvGktaqZIaSSvkLKSlPARBwOywuz3
         7pkxPWKp9rxnXdgCQ4jzyE2guY/YFDM72u/APdV9AzLVyy532CXss6aDEsicu14rY9pw
         73KXZs+kZDIeeZv0Z8idJfhBfaCKe/aGWOuJo6DGq5IyDCayYVrpPDA1EEyM9frSimDN
         Rz7nL0CwkmgNet/9vywln7QAF7uxdL3/bq7qWkkbRx1Q8XCsnyhhlOKG3E0HTowSZwhC
         xJSA==
X-Gm-Message-State: AGi0PubAdGMrM0vfS2oIPCeXGLMkJf0muYuEqoad0OjZAVqAN40cqaQL
        RR3zPArXitPR+458Qo89W3CmDvYa3z+KBI1d8ceZ5PO64mxX
X-Google-Smtp-Source: APiQypLKoorYfxGAxfQDfwHAhcqeI9HJWjEq5A0H7WxkYG55YC8uqJYuqoZzZKQbbAF6862mCDXEKO9b6SOkLeJkNTcni5YPyrpl
MIME-Version: 1.0
X-Received: by 2002:a6b:f20f:: with SMTP id q15mr7704601ioh.48.1588414023349;
 Sat, 02 May 2020 03:07:03 -0700 (PDT)
Date:   Sat, 02 May 2020 03:07:03 -0700
In-Reply-To: <0000000000002ef1120597b1bc92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e3eb505a4a7759e@google.com>
Subject: Re: possible deadlock in lock_trace (3)
From:   syzbot <syzbot+985c8a3c7f3668d31a49@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        bernd.edlinger@hotmail.de, casey@schaufler-ca.com,
        christian@brauner.io, ebiederm@xmission.com, guro@fb.com,
        kent.overstreet@gmail.com, khlebnikov@yandex-team.ru,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 2db9dbf71bf98d02a0bf33e798e5bfd2a9944696
Author: Bernd Edlinger <bernd.edlinger@hotmail.de>
Date:   Fri Mar 20 20:27:24 2020 +0000

    proc: Use new infrastructure to fix deadlocks in execve

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17222ec4100000
start commit:   a42a7bb6 Merge tag 'irq-urgent-2020-03-15' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=985c8a3c7f3668d31a49
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1185f753e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: proc: Use new infrastructure to fix deadlocks in execve

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
