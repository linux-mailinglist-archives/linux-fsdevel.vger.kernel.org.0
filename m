Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82BF3985F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 00:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfFGWP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 18:15:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35602 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbfFGWP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:15:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id h11so3035852ljb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2019 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jg1F7lO7uVdQ9tdkXQLyc2uUklR2L0U9AiiLwg+uvg=;
        b=aoO38c3t9rsjPFOteILVcuGQgCSWmQvFmxqe1O+LyeoYe2aN68r4/UJ6/k8U6kDF+9
         k5nu15rfkguUHB69Ug3k1zaCjiMfZbLwrN5OOkDfDyFaGoeL8MWvfl6J09wlT65fi1IT
         7aToDUMiC1CDBV3U4Q7S4ZrpIP6miijco5Te8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jg1F7lO7uVdQ9tdkXQLyc2uUklR2L0U9AiiLwg+uvg=;
        b=l2J3GdS58fQtQIeg3/eBZ91AREUSIJ7VgKPSm0z3cZJKdOGAmvs8G85mY923jSD3od
         OnAIWcWw07NO5lf7PRh/Ugxb3fSY0qnCWOqqPG5iV2Kax9Sl09fJlGdSVeEMDWxIUCTL
         EGMkQkPCqH/gpSgokwgyjPi6AF9fx4TR6JBzipQelU4D7n2mAhXnqx6FawUvagQTapYI
         nYbsUaAaHJBHRgPAyv62aRJ9B7/P2P5dxPB4v8bukz8rU1FLtow67FdesYv4fKFR0rm6
         8jzKKsn8eb4E1Q9JjvwCQkwRVXGpOom4k6XiqqRIjQ1xGc/FPWs0lcvB9ZaPMWsR+cWc
         xpAw==
X-Gm-Message-State: APjAAAUs40yrQmXjtJFMw0WTXhZ9Vz2vz1w0NEN7onOPfosXZuAN5Sxw
        8ErTpWNCH7wuSbEwYsRNLsKLGy4Isq/ihA==
X-Google-Smtp-Source: APXvYqw68OCuiNz6udWoqMWIF8sZoUpkzWAvPtPV2cH0bnLDTC8h1cfHHIeBic0GiCljBdlSeNehdQ==
X-Received: by 2002:a2e:9ed6:: with SMTP id h22mr15381758ljk.29.1559945724135;
        Fri, 07 Jun 2019 15:15:24 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x79sm604380lff.74.2019.06.07.15.15.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 15:15:23 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t28so2995154lje.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2019 15:15:23 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr29323271lja.44.1559945263826;
 Fri, 07 Jun 2019 15:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com> <87ef45axa4.fsf_-_@xmission.com>
In-Reply-To: <87ef45axa4.fsf_-_@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 15:07:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjVnEKSv3pV_dvgmqGDZDcw+N+Bgcorq7uqS86f1gwXA@mail.gmail.com>
Message-ID: <CAHk-=wjjVnEKSv3pV_dvgmqGDZDcw+N+Bgcorq7uqS86f1gwXA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>, Eric Wong <e@80x24.org>,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, omar.kilani@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Laight <David.Laight@aculab.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 7, 2019 at 2:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The sigsuspend system call overrides the signal mask just
> like all of the other users of set_user_sigmask, so convert
> it to use the same helpers.

Me likey.

Whole series looks good to me, but that's just from looking at the
patches. Maybe testing shows problems..

              Linus
