Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586B31BF016
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 08:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgD3GPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 02:15:03 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:39020 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgD3GPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:15:03 -0400
Received: by mail-io1-f70.google.com with SMTP id m67so303742ioa.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 23:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LGPQXr9UFNG0Da8I+jNxRs0HPIkBIqCGuS7p+9YCeGg=;
        b=dv1tmN29fG5QRgTA8LrzHzmyQBILU6TsOrpxuapb+v8xMUoxTOzK06C+E4g/dq/zxJ
         HToI1Twdsn3irj0MzRsLB17V/+36E+7hjecGf78VKAMgzjkk0I6MFauLvUHt+0XSEp6C
         xhRC30uLIqf6/aOUVneVQ6SAhLTLs1GFxP0XqZa1eb8JMV9GrP8MTsPWmEwBdGKqHX1/
         ++Hl6QKc0r6LiTdR/Oy6U1Hvq6E83Cn2ZxU4iMHHWF8ei2t8d/5PHMJt7KeTqthazm+/
         Hka4WU1xMuzIk+2udoVd30usj9131f2Edwa8lI0vZLkXrtQxGNyqag5LwdHyPfb1jTHE
         QWOg==
X-Gm-Message-State: AGi0PubuvcT1gF0VNQc0Fqr4gl0FpLJ2fiq5+6AU1CZGy/0ZPvnWRNEZ
        K1A513MKFz1EeMaT/J2+OSCPJkfiYnmaSL3gNe5YvDO1jvDb
X-Google-Smtp-Source: APiQypItWPCp/4iJfpJma41I1BKksbOFHTczxvYLYhN4aAIprmWe1R4Xi8W7XMYKiyqSv2IHXeW1rAQ1iMyE1Dy0TaNFKC2pTaCU
MIME-Version: 1.0
X-Received: by 2002:a92:c004:: with SMTP id q4mr380269ild.93.1588227302698;
 Wed, 29 Apr 2020 23:15:02 -0700 (PDT)
Date:   Wed, 29 Apr 2020 23:15:02 -0700
In-Reply-To: <000000000000fdd3f3058bfcf369@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033365905a47bfcd4@google.com>
Subject: Re: WARNING: bad unlock balance in rcu_lock_release
From:   syzbot <syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com>
To:     ebiggers@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 10476e6304222ced7df9b3d5fb0a043b3c2a1ad8
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Mar 13 08:56:38 2020 +0000

    locking/lockdep: Fix bad recursion pattern

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d64bac100000
start commit:   7d194c21 Linux 5.4-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c03e4d33fa96d51
dashboard link: https://syzkaller.appspot.com/bug?extid=f9545ab3e9f85cd43a3a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a0a8c0e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dd2dd8e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: locking/lockdep: Fix bad recursion pattern

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
