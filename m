Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8576D06F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjHBOqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjHBOqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:46:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168831FC6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 07:46:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so75875e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690987590; x=1691592390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQEBxGKtSk58z+0MjuXwFB9gXKkCzQHhRWqk9TNbNqY=;
        b=J9MwT/Xna/NJQqygoWM2Nj2plQseg0B08J95nmpHY2BJ78EhbQQCqoSzFIkDPk+QX1
         EeB4n/zjiKpnjNYuHjsHbk9OzOK+RQD04MA6v6HvGxW9M7zGmV5kuvuvPXFChLyAfl+S
         tRiMW9PMd2iqUgEIbqsGhZXmrMCsfpfbsxCYKB+WZnW/yyUW9Ksg5Ps4we9vI0II0Y0Z
         tdPt9Tavi3JfZFAtfhsmPEGLujuPMY0NtYci1JHAfn1U0kQ3ufGWG2Z3/tkXcIiugBJe
         Zj9IPMNvlfHsDaJoojMDOYQK79Pfrr7i2lr54cDDcbd6uqA8s1AX+9NoHPm+l3+pngCo
         w97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987590; x=1691592390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQEBxGKtSk58z+0MjuXwFB9gXKkCzQHhRWqk9TNbNqY=;
        b=Q2j4wOOH+pu6qy1YEFfKrGmnbSNBbkxgys4O+6Jht1UirvW1P0WrMnAgl2iuJx8L0w
         xfIbWNbDR7kCHzWd1tPjnqoFAYAbR2F+sfx3qEGkKuVR6WMwCEc5RZN+hmlYsOZrsJLi
         i/Rozv0Uynya0rBx/sRNZY2dqDRg0T63W59H8G6/0BB0i1nO8jBhhIRV6G29k9BxAPQR
         LaeRH6WvIGbYNdIYBZRbzHDxV20NjDo38h0DeEWN7eAZ/YAcaHsW7BLy8gkRerYu5Ek8
         C+u5z3FgVfXiAfYrLOUqZRjAUMlH48sT4xCzhDRr2vCntWq0i8FSu0XipJ3lUToZfy2J
         JcAg==
X-Gm-Message-State: ABy/qLYcKAeVVnX+WKE3uMzdYNYst8TzKRrTaBhWHRUHudZGxRk2gcpr
        foH3w+BiEuZ3T63+BOWZc95r5pMrIt4Ah/3m0j+btA==
X-Google-Smtp-Source: APBJJlGdXWirO502Ltmd6OHrZfzw9V2WLhk5Dj8XByT7AeyjZk00Xh/8Qh6rrUlV9NsNsXpuQCBLYInp8sN5Qc0E+SE=
X-Received: by 2002:a05:600c:860f:b0:3f4:2736:b5eb with SMTP id
 ha15-20020a05600c860f00b003f42736b5ebmr351010wmb.1.1690987590553; Wed, 02 Aug
 2023 07:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000091164305fe966bdd@google.com> <000000000000be8b800601a71d81@google.com>
In-Reply-To: <000000000000be8b800601a71d81@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 2 Aug 2023 16:46:18 +0200
Message-ID: <CANp29Y7uMKggecMZo20KyB4XBWhXOtNr09XH3yox6LrW18H05w@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] WARNING in emit_fiemap_extent
To:     syzbot <syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, brauner@kernel.org, clm@fb.com,
        dhowells@redhat.com, dsterba@suse.com, dsterba@suse.cz, hch@lst.de,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 29, 2023 at 11:45=E2=80=AFPM syzbot
<syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit aa3dbde878961dd333cdd3c326b93e6c84a23ed4
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon May 22 13:49:54 2023 +0000
>
>     splice: Make splice from an O_DIRECT fd use copy_splice_read()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14dc6319a8=
0000
> start commit:   40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.=
o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7ff8f87c7ab0e=
04e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9992306148b0627=
2f3bb
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10c65e87280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1094a78b28000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: splice: Make splice from an O_DIRECT fd use copy_splice_read()

Hmm, no. It looks like this change indeed stopped that particular
reproducer from triggering the bug (the commit changed the kernel code
that is executed by sendfile(r0, r0, 0x0, 0x8800d00)), but the bug
itself is still present.

Today syzbot has found a new reproducer, see
https://syzkaller.appspot.com/bug?extid=3D9992306148b06272f3bb

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
