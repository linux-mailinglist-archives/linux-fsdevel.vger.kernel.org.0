Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971213A344C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 21:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFJTxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 15:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJTxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:53:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18750C061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 12:51:10 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x14so6530661ljp.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7gUGOzETMzYFAG4seIz29zubSDkdiXjPsIc9hK01xE=;
        b=aBsNBHP0NpRBvB46PeLY9+arShvd1498r3GSD0O2n4SRYflDcL42dQNQtcGknUePat
         3nywBCNe6xd+GcU1Vx9TJ6128jk5YFNdIWWwxAVHawjXXU8e4kV4pi9X+M42A+gU72FM
         jdWC7EmtUd4URMrXwAJ1eo4czRMFqiB5EI9nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7gUGOzETMzYFAG4seIz29zubSDkdiXjPsIc9hK01xE=;
        b=SURNkg4pr4LsTW3bLBWUHvOKu4xGuXI8J4sJ+7xBZzzxlr20kLD9ZdmiTDVTi12DNe
         mHVGw5UsR1Gzoe+bK5nDNgzjrk3Xc+K03oYmS58ZLITOc+4crAK1J/32H4Q2VQmkb2Ly
         hVKpGMx4fYdjUwOdNemb+hpqIR6xqQf6dzUP6XaO8YbopARARRE1uM4RMNppdHj3uo32
         itJmC3G5UrOwh+wvAHBsTXZBsW0NiyITW8ST1++LH2Cn+kE+2gH8/trDERzYbQzE9CIj
         kLc5bCJl0CgBWHW4d9TMhwFchBKsfX8+jM8BoUcM16hxlxX1Qxkqzkyz6c3wb8fe06cd
         DSWQ==
X-Gm-Message-State: AOAM532BFnTkJS+SQ3AHBAy11qphc9OGnmsxow7SoE5PX0pmlUIVfZdl
        nNYHDUwmvHmZRCO6d8y+WN6TJhkwLSY3xz4Qvf0=
X-Google-Smtp-Source: ABdhPJwBze3ZZWq+zy9DeztlvS3wxuBSzw7Z0D7ubZn1QpznzfyaYoL7NgTtNR+yVyX+xwpKX15VtQ==
X-Received: by 2002:a05:651c:90:: with SMTP id 16mr162113ljq.473.1623354666488;
        Thu, 10 Jun 2021 12:51:06 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id a18sm419808lfb.200.2021.06.10.12.51.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 12:51:04 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id n12so5025701lft.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 12:51:04 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr266721lfa.421.1623354664442;
 Thu, 10 Jun 2021 12:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
 <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
 <87h7i694ij.fsf_-_@disp2133> <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
 <198e912402486f66214146d4eabad8cb3f010a8e.camel@trillion01.com>
 <87eeda7nqe.fsf@disp2133> <b8434a8987672ab16f9fb755c1fc4d51e0f4004a.camel@trillion01.com>
 <87pmwt6biw.fsf@disp2133> <87czst5yxh.fsf_-_@disp2133> <CAHk-=wiax83WoS0p5nWvPhU_O+hcjXwv6q3DXV8Ejb62BfynhQ@mail.gmail.com>
 <87y2bh4jg5.fsf@disp2133>
In-Reply-To: <87y2bh4jg5.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jun 2021 12:50:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPiEaXjUp6PTcLZFjT8RrYX+ExtD-RY3NjFWDN7mKLbw@mail.gmail.com>
Message-ID: <CAHk-=wjPiEaXjUp6PTcLZFjT8RrYX+ExtD-RY3NjFWDN7mKLbw@mail.gmail.com>
Subject: Re: [CFT}[PATCH] coredump: Limit what can interrupt coredumps
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Olivier Langlois <olivier@trillion01.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:18 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I just didn't want those two lines hiding any other issues we might
> have in the coredumps.
>
> That is probably better development thinking than minimal fix thinking.

Well, I think we should first do the minimal targeted fix (the part in
fs/coredump.c).

Then we should look at whether we could do cleanups as a result of that fix.

And I suspect the cleanups might bigger than the two-liner removal.
The whole SIGNAL_GROUP_COREDUMP flag was introduced for this issue,

See commit 403bad72b67d ("coredump: only SIGKILL should interrupt the
coredumping task") which introduced this all.

Now, we have since grown other users of SIGNAL_GROUP_COREDUMP - OOM
hanmdling and the clear_child_tid thing in mm_release(). So maybe we
should keep SIGNAL_GROUP_COREDUMP around.

So maybe only those two lines end up being the ones to remove, but I'd
really like to think of it as a separate thing from the fix itself.

                Linus
