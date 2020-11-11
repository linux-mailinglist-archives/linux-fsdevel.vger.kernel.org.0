Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD842AE6D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 04:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgKKDJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 22:09:06 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:56102 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgKKDJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:09:05 -0500
Received: by mail-io1-f70.google.com with SMTP id j10so458336iog.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 19:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wf9hL6Te9sp/yqa+Doc2BxzTapoLp41NMYlihKhsE5U=;
        b=raohmvPXluksjPm5t6NZQS64axguqEpnqId/YnUiqV5XVDmX3d0pgzuyX5iMYtlN0M
         V2AJIgoBw7AEukECmsWKU0Sik2ZMi4qRlduJqP5a2WAEDzYX1FiHa9kEEH8cmN8k4TgU
         JQKfyxDar0JuIlYsbvo/UnxhOESXI23eHLZatgHs6TmuT7TdGD0SxQ57iSSDQgK3rzlk
         +i9Z2UUnISvMWEWZOJNLdeWwZno2Nu96LSaFHlWsNb/7AgNsMvHpqmsvbQB5NIrI95Qr
         BgkLTPeptIlNrx/cTrf/ypK5Fzjuj/6mDPXNc78RmBT1kr5Ozp+5r83zURptt1jIy4TE
         zcBQ==
X-Gm-Message-State: AOAM531kcpojMs8BqfwUOW3YWTIq/Q3OIYdxH51z9KiXU71mfr8IR4xT
        or8Xg0/AzcFX41iJu0V0cllKSNj6SunicD0G0mGFtQcA1fyL
X-Google-Smtp-Source: ABdhPJw322s2MJlVk9+t74N1ScoBaJO4J3N8LABAJKKIIvfejPk/tSGh8Y8hRv9pCYKg3l9qjzobyF5QLxxkTWZVc72IPUvFMa5q
MIME-Version: 1.0
X-Received: by 2002:a92:ba14:: with SMTP id o20mr17040042ili.76.1605064145162;
 Tue, 10 Nov 2020 19:09:05 -0800 (PST)
Date:   Tue, 10 Nov 2020 19:09:05 -0800
In-Reply-To: <000000000000b09d8c059a3240be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036d7e005b3cc1e79@google.com>
Subject: Re: WARNING in percpu_ref_exit (2)
From:   syzbot <syzbot+8c4a14856e657b43487c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, ebiggers@kernel.org, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c1e2148f8ecb26863b899d402a823dab8e26efd1
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Mar 4 14:25:50 2020 +0000

    io_uring: free fixed_file_data after RCU grace period

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161ea46e500000
start commit:   63849c8f Merge tag 'linux-kselftest-5.6-rc5' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4527d1e2fb19fd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=8c4a14856e657b43487c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c30061e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1251b731e00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io_uring: free fixed_file_data after RCU grace period

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
