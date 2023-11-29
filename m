Return-Path: <linux-fsdevel+bounces-4203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5537FD998
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D860F28272B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FE832C74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S70NsF+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD76200C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 14:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71893C433CB;
	Wed, 29 Nov 2023 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701266996;
	bh=EDjusMs1DYoal+gcKiDBBMs5RwqSkiX1BaWanw29mek=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=S70NsF+lAeEKDe9aRjxDyN4QIpnKFQCfHQHTV3jMcfr09ENsZNDoH2MIz0QT3GZJB
	 cvA1513h1hM0UwYjuCrtascIqOwYYeuQpTao0DOeuvepTAwNLmx/elQssrnl0qnX6R
	 Bo7Wy9/gajPr+Y7aSWU2HMjLpJF68aBwFyuJmkqGboXpISwa+pUdtQaiX8n3ZF3P0I
	 x6Eh8919OGWBcw3Cv7uVNqIuhWf3q9xA+SuxaBjYMxazf6IoBkBFJGSlmuhCm+/1AE
	 h0mTLB9lfPA1Y13S4UzhrUSTIVFPO9ns8ZOvgjPBumG3RAp5cCtNJZlJG/G13T/Hqt
	 H2ookyDKu+opA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58dd6d9ae96so168775eaf.1;
        Wed, 29 Nov 2023 06:09:56 -0800 (PST)
X-Gm-Message-State: AOJu0YzPxW679nRKSEB3EdNIzzz1dm/fKudwJsLrhTIq6rtTip8+dsrx
	sKQQhnLyL1+ZatrJWKSpGIMpTV0BvNIJMZ0z41o=
X-Google-Smtp-Source: AGHT+IH8UvJdRPohiGCK0IAkKoQtYgYCFbUsrpA81a095NPNU2VfFFGotqSU8/GlMaQqJugBatWABvX0vMmPgues8NM=
X-Received: by 2002:a05:6820:1c99:b0:58d:d938:26ac with SMTP id
 ct25-20020a0568201c9900b0058dd93826acmr857952oob.8.1701266995541; Wed, 29 Nov
 2023 06:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5bce:0:b0:507:5de0:116e with HTTP; Wed, 29 Nov 2023
 06:09:54 -0800 (PST)
In-Reply-To: <0000000000009401fb060b28a2e1@google.com>
References: <0000000000009401fb060b28a2e1@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 29 Nov 2023 23:09:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-WLUQcyMAWd_R4PKRcciRh=faNnixv38abWmj7V=To9Q@mail.gmail.com>
Message-ID: <CAKYAXd-WLUQcyMAWd_R4PKRcciRh=faNnixv38abWmj7V=To9Q@mail.gmail.com>
Subject: Re: [syzbot] Monthly exfat report (Nov 2023)
To: syzbot <syzbot+listb51f932ee38ecac1b05d@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

2023-11-28 6:03 GMT+09:00, syzbot
<syzbot+listb51f932ee38ecac1b05d@syzkaller.appspotmail.com>:
> Hello exfat maintainers/developers,
Hi,
>
> This is a 31-day syzbot report for the exfat subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/exfat
>
> During the period, 1 new issues were detected and 0 were fixed.
> In total, 7 issues are still open and 12 have been fixed so far.
>
> Some of the still happening issues:
>
> Ref Crashes Repro Title
> <1> 225     No    INFO: task hung in path_openat (7)
There is no reproducer and I couldn't find where it is connected to exfat.
>
> https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
> <2> 150     No    INFO: task hung in exfat_sync_fs
There is no reproducer... Let me know how to reproduce it.
This can happen when disk speed is very low and a lot of writes occur.
Is that so?

>
> https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
> <3> 119     Yes   WARNING in drop_nlink (2)
I'm curious how this issue was classified as an exfat issue.
When looking at the backtrace, this issue appears to be an hfsplus issue.

 hfsplus_unlink+0x3fe/0x790 fs/hfsplus/dir.c:381
 hfsplus_rename+0xc8/0x1c0 fs/hfsplus/dir.c:547
 vfs_rename+0xaba/0xde0 fs/namei.c:4844
>
> https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
> <4> 38      Yes   INFO: task hung in exfat_write_inode
I could not reproduce this by using C reproducer provided by you.
Can you confirm that this really cannot be reproduced using it?

>
> https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
> <5> 1       No    UBSAN: shift-out-of-bounds in exfat_fill_super (2)
This is false alarm. ->sect_size_bits could not be greater than 12 by
the check below.

        /*
         * sect_size_bits could be at least 9 and at most 12.
         */
        if (p_boot->sect_size_bits < EXFAT_MIN_SECT_SIZE_BITS ||
            p_boot->sect_size_bits > EXFAT_MAX_SECT_SIZE_BITS) {
                exfat_err(sb, "bogus sector size bits : %u",
                                p_boot->sect_size_bits);
                return -EINVAL;
        }
>
> https://syzkaller.appspot.com/bug?extid=d33808a177641a02213e
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> To disable reminders for individual bugs, reply with the following command:
> #syz set <Ref> no-reminders
>
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>
> You may send multiple commands in a single email message.
>

