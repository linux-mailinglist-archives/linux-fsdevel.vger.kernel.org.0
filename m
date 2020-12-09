Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB62D4E73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 00:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgLIXCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 18:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgLIXCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:02:37 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D1C061794
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 15:01:56 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so5483831lfg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 15:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tO6QTx9ivJWqaU4jY3KDla5iRh3fh54qnIM0WU/aIeM=;
        b=d60+wHGKwpCHvhWiGOJCq5pRT8O4l0n0m6HYjXGV5/JzhtXlVudcixsvvPasFX7PAa
         /wT5KJEGrynWoMlnz0IfpICXejZ9t24I5WTZGvZOxUMJshXyXPbCaBcrDllQCDGSFDzz
         /UVftEnScZPALpc46g4EiD0zyGLdqLT98ft18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tO6QTx9ivJWqaU4jY3KDla5iRh3fh54qnIM0WU/aIeM=;
        b=l6AtzZcZN1SDMD373z6k3vi6k0lY0ltu78fp4N3z3tIHyfoAOPUAIHrHYQNzbGB+Oe
         JPfBhEggWm9nm29VZZKLHdx9qC/GULJe67KLDyGq8F14C2I+C2x1brgL7Zm4Sg5Pp78N
         mduS5wZK+YDZlqhPwDu2Cv6NzWMXibVtq4uLfOQvMXvlj0TeyoZiW3EpTZjxWYjqIz9I
         Tt/Eu0wrxxuTcpBJQcdPM23ub9DnUbPhviYVJWM9+KyoXQxIfQ4FEaPrCjuctqRhIT1m
         yjaTT7en2EWVEBIwsooHGgIJ7ksh99iURA7bAoNC/8NXsim8wRC8q3Uu8y+zwvr1+4HK
         Ra2Q==
X-Gm-Message-State: AOAM531+OLX3xEOxD9PXfrN2lGza2rGsjlle3WBsHr6fn5805Bbf+iw9
        A5/e9LYJ3aTYXLv+bW9rjqZFaOn9FFZfUw==
X-Google-Smtp-Source: ABdhPJz8lErXZbWi+cFcT9Yds0HigZCV9gWNerkeDCKFxfvXc+ba08jMZC4Xu1bz/j7MMeRanL2IKQ==
X-Received: by 2002:a05:6512:330d:: with SMTP id k13mr1649960lfe.173.1607554914642;
        Wed, 09 Dec 2020 15:01:54 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g25sm396504ljj.36.2020.12.09.15.01.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 15:01:53 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id y19so5398007lfa.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 15:01:53 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr1682309lfc.253.1607554912598;
 Wed, 09 Dec 2020 15:01:52 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk> <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk> <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk> <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <20201209194938.GS7338@casper.infradead.org> <20201209225828.GR3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201209225828.GR3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 15:01:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
Message-ID: <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
Subject: Re: [PATCH] files: rcu free files_struct
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 2:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Dec 09, 2020 at 07:49:38PM +0000, Matthew Wilcox wrote:
> >
> > Assuming this is safe, you can use RCU_INIT_POINTER() here because you're
> > storing NULL, so you don't need the wmb() before storing the pointer.
>
> fs/file.c:pick_file() would make more interesting target for the same treatment...

Actually, don't.

rcu_assign_pointer() itself already does the optimization for the case
of a constant NULL pointer assignment.

So there's no need to manually change things to RCU_INIT_POINTER().

           Linus
