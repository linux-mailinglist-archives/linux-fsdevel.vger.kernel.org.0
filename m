Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CC02EFE3F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 08:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbhAIHUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 02:20:49 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:39607 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbhAIHUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:20:49 -0500
Received: by mail-il1-f197.google.com with SMTP id f2so12450228ils.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 23:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pwlzMsvPhHWdCYhkogMUXxJRp4tYIVlfkKGPQ7+nxL0=;
        b=PpFUFSsM+5gOiI5iRtLV2+Q+VbX09LRkcM2H1vRn+0dr9zYDBkdpzy6Tm9NIfcARGy
         f01AxApZbo66nfWeY0B8YuODq0kF3y0GXmxu3+F+xzIMX5OlLHgw+HmYRhC27QRUAo9L
         /xibOu8OYleaPpRgB1zQdz52y2VTmNf+x1POhhBDbTfOUklldrTnzaFt7IFlld2kAzgk
         yGodd7sa1OKKeZKG6qGbBEqBgxjanudV3skMPBEGhBNcZiqsmeAMJrglkl6J8iAkrRue
         7kFm9h2y+WsmLTSxDuL+jYB5++5xLndmoai+1WhJel3WA1S1KDBMHmhYf08/gyZbZLBV
         53TA==
X-Gm-Message-State: AOAM533mHjmsO/YhJCsORahKM3V2xambEp6ZUG69xrEtq6i+yJGzd7o4
        yVl6Z3yChwGZ2C+kt58qtBK+pr95nRLKBHvUVCthnESaew76
X-Google-Smtp-Source: ABdhPJwA+Mc5PFaC0yCPB3v9+L1044sATU8eG2faM5z6IFbIQfEP8SliAOyimFLXQ8J471KSRH0b3iip2QE9qZrE/Flj+Aslg+9g
MIME-Version: 1.0
X-Received: by 2002:a05:6602:93:: with SMTP id h19mr8312686iob.59.1610176808615;
 Fri, 08 Jan 2021 23:20:08 -0800 (PST)
Date:   Fri, 08 Jan 2021 23:20:08 -0800
In-Reply-To: <000000000000b0bbc905b05ab8d5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4098905b872801e@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in __lookup_slow
From:   syzbot <syzbot+3db80bbf66b88d68af9d@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rkovhaev@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d24396c5290ba8ab04ba505176874c4e04a2d53c
Author: Rustam Kovhaev <rkovhaev@gmail.com>
Date:   Sun Nov 1 14:09:58 2020 +0000

    reiserfs: add check for an invalid ih_entry_count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111480e7500000
start commit:   a68a0262 mm/madvise: remove racy mm ownership check
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e597c2b53c984cd8
dashboard link: https://syzkaller.appspot.com/bug?extid=3db80bbf66b88d68af9d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1737b8a7500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1697246b500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: reiserfs: add check for an invalid ih_entry_count

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
