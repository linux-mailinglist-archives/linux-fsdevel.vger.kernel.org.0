Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BED11C222
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLLB3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:29:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36343 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLLB3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:29:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so336421ljg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngCvhdELOgIQ69MigGwbslj0BoCyrEIfDMRe9lAU84c=;
        b=cwlWLXDtChisQx3BOxoqKRoI8l2aIzApJkZH0knnGXeRBkYyrjatj3Iqvq+pEYo8vz
         YB1Q6eIQ7M8Kp9xDL8IMabELBNs7kQEMnQVpm9+RvgFUWRjKay6CY/YEtmqENuN8NEJe
         SpgsA+0oAnSTBgoiasPVoSFTQm5OXTTIsNyTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngCvhdELOgIQ69MigGwbslj0BoCyrEIfDMRe9lAU84c=;
        b=RHD+YVJTdLH3emfD8vbl6j7kzzAmhvVuoTI7Cc1r+hJNpM9GkQ8/nvvK4F36Xtule4
         t4VG+NN0HCiKVcwbPf6FLbB+bCtkz0VHVObiZm3KraKw1UyNkZDReqpfJUGDwbF3qo3s
         Tss/nOAdPbHAcENouEUBobqfoq9sZYT68E78XUANif255rxtNe4oZNqPu0B38QiUQOzu
         7tgkwgvseBjZgG7Euo56u+8FCp30qCkixWntP89bwQOjFI7QCwZed7nSHg3rQvm0ZHQj
         YuWOu1OzljxoQHj4FvcPxOqhUJ/8oTtSd5wjQqg2TObfybtq744fuKdLjX8GvzdsCOmc
         mTXA==
X-Gm-Message-State: APjAAAWHw+HAhdyTzcD/Sh5IQsi9/572dZqXWLVBiOkPVpzTWGEfnnfz
        CnUqOLBzKMRXYHAB9nxpqO9+8Ytw+6A=
X-Google-Smtp-Source: APXvYqzji42fffO6NWOk11H+fJCu2f8o6PXhKhXRhQ58QcFhJyVmTRmuPmLReNjEEnNOFwk4koa3oA==
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr4048286ljj.97.1576114138204;
        Wed, 11 Dec 2019 17:28:58 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u7sm2008615lfn.31.2019.12.11.17.28.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:28:57 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id e10so323131ljj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:28:56 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr4218712ljn.48.1576114136551;
 Wed, 11 Dec 2019 17:28:56 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com> <9417.1576097731@warthog.procyon.org.uk>
In-Reply-To: <9417.1576097731@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:28:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVpV-O4zeO+xOMcOUyKZi+1kg+6Kmi-P7SUx-ydZm5Og@mail.gmail.com>
Message-ID: <CAHk-=wgVpV-O4zeO+xOMcOUyKZi+1kg+6Kmi-P7SUx-ydZm5Og@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>, Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:55 PM David Howells <dhowells@redhat.com> wrote:
>
> Is it worth reverting:
>
>         commit f94df9890e98f2090c6a8d70c795134863b70201
>         Add wake_up_interruptible_sync_poll_locked()
>
> since you changed the code that was calling that new function and so it's no
> longer called?

You are sure you won't want that for the notification queue cases? I
guess they'll never want to "sync" part..

Looking at the regular pipe read/write code, maybe we'll want to try
it again - do the wakeup while we already have the spinlock, rather
than later. But I have this suspicion that that might just then push
things into mutex contention, so who knows..

Regardless, it's not going to happen for 5.5, so I guess we could
revert it and if we ever end up trying it again we can resurrect it.

              Linus
