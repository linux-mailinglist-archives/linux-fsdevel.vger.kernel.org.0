Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB440361218
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 20:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhDOS2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 14:28:39 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36675 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhDOS2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:28:39 -0400
Received: by mail-io1-f72.google.com with SMTP id n4-20020a6b72040000b02903e09873919eso2370838ioc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QcBQJFJwd2aEtIteetaGG/NNxY6JLsPcvgrNpo8jHbk=;
        b=XtAZTAMCgxedztU0+Wf1PQrA/Oa+2B3npT+1ygueb1G7XGaGeiZOwViVHaAchzARFU
         H79Q/PujQ1CJ9keJyCO2AqiU+foYJiTj6BGL2YVoBrJJaivrTaA5rQV+JjQQVZrXvjG4
         NC+1Ig7dbcT6iwGf9rkq2YEuNPP9o18sICUBuBjGx9N7Mgydj/RUTUbD/HI+kvgnyW2D
         nxViWl0gRoRAAtvwAn2XUcBD9UiZ71Awc7mlAV4cEHmsWdui8OJ3R7mg0lloJawMbIxq
         aPw3pO1E5cxwUW9Qae/0nzEnsNrbZcTCmRFWOzmOujfHnJNh+dh4Nd275hkB5KKgFXs7
         F3aA==
X-Gm-Message-State: AOAM532dCZ5emmbMvv/QgLpaH48XK6w4BXw+X/vvzkADa2gVnBK82EY/
        2V4LLWELjlnk+Aja8R3ufti4M/zdJlMwnbhakQ5yAsjmZgDc
X-Google-Smtp-Source: ABdhPJzR7sLHcpumy/6kCx1qc15PEYlD0neZyz+Ah1Ca4KfHJ6bce2sBktWLqLWHsbeivK+sCNtzs8AsWnq00gxoLBZplqdQ5jdZ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca7:: with SMTP id x7mr4050791ill.10.1618511295436;
 Thu, 15 Apr 2021 11:28:15 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:28:15 -0700
In-Reply-To: <000000000000ca835605b0e8a723@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d45f8005c00706a1@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in idr_for_each (2)
From:   syzbot <syzbot+12056a09a0311d758e60@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk,
        egiptomarmol@loucastone.com, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mail@anirudhrb.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 61cf93700fe6359552848ed5e3becba6cd760efa
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Mar 8 14:16:16 2021 +0000

    io_uring: Convert personality_idr to XArray

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f91b9ad00000
start commit:   dd86e7fa Merge tag 'pci-v5.11-fixes-2' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e83e68d0a6aba5f6
dashboard link: https://syzkaller.appspot.com/bug?extid=12056a09a0311d758e60
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174b80ef500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165522d4d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io_uring: Convert personality_idr to XArray

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
