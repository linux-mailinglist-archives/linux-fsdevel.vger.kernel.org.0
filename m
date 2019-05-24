Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317EF295C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbfEXK2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 06:28:05 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37529 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389616AbfEXK2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 06:28:05 -0400
Received: by mail-it1-f193.google.com with SMTP id m140so13060498itg.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lQOFmVbb9NS+iTEPlWwBX0kt6HHZdRsOcnWjM/3njwc=;
        b=AY0ya/6qCoCKbbiDDvO8+/wWIH6ZztkkxdM0TElnygz8SyZWmaxI+wrxoxh3BteKH5
         rHrFPHoSXiF6l8Q3mQWdcuFfb5RiQmnw/D4Y/JWCQNk2g3YCQ8a5iVIofknT9r8qPFBm
         RRiCr8yiYjUNzi+d7o1UyE0cXRoYx5reqlVO2qDUYosU/e+1wx2YJ1ddwDHW2tnHADAF
         rZbSCnA/ZRUAoQZ/CRlEl8a6IfT9BbmVCR23R9XlmNKC+Kg4WFseuJIjaV5cZv/Xs85G
         /wxayT1xut3WTT3270zlG0oh8wgP8pkw57Z2/hfOBiusZTlyVfyLjh4TAEVM54IEDqO3
         lV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQOFmVbb9NS+iTEPlWwBX0kt6HHZdRsOcnWjM/3njwc=;
        b=YnIXw3zNqvjtTQhaX2hiS/gqcYXH+7Agf8c13oouGly0o835p2kxISaEg+nesIBu+e
         dLbvG9neqwa8oXQGNP/6UONy+2iv7GcQc8reDZSBlk0mPv4P9iqmeDxGgyyszOAJbs5U
         +q6qrsdCms/hyPHxY5u2pLN9yydtjiTZ6glyAaL6WmN0wIEOypRB4my1XyIhKPSxLsfU
         m1mbk4BIqKySrh2daP7JI3ytoF5wOAbBSWSkZWfgxYmlxzA8vY8a14lndigCLhElMPk4
         yKLBpwv2xjw2bRwhvqMlBZHDhKdXfgo8I+oEnpS0Q1z9dq23U0i7A1dtLF34335/SB29
         ugww==
X-Gm-Message-State: APjAAAVtkKs1G2IbmkodAkW+RMJTwpMNYewQImh7LEonbmGyPCcOyYse
        01heUBmBZzIzinuugZxhVsjQ9A==
X-Google-Smtp-Source: APXvYqy5UzWHJOTniUeCgLuuQNOys0enhqT6SdnrXYCeWiW2VWY/4D4BoL/FC9IekDzSeZqn2H3UYA==
X-Received: by 2002:a24:3d08:: with SMTP id n8mr17306791itn.56.1558693684484;
        Fri, 24 May 2019 03:28:04 -0700 (PDT)
Received: from brauner.io ([172.56.12.37])
        by smtp.gmail.com with ESMTPSA id g124sm1024044itg.12.2019.05.24.03.28.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 03:28:03 -0700 (PDT)
Date:   Fri, 24 May 2019 12:27:58 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, fweimer@redhat.com,
        oleg@redhat.com, arnd@arndb.de, viro@zeniv.linux.org.uk,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] close_range()
Message-ID: <20190524102756.qjsjxukuq2f4t6bo@brauner.io>
References: <20190523182152.GA6875@avx2>
 <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 02:34:31PM -0700, Linus Torvalds wrote:
> On Thu, May 23, 2019 at 11:22 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > > This is v2 of this patchset.
> >
> > We've sent fdmap(2) back in the day:
> 
> Well, if the main point of the exercise is performance, then fdmap()
> is clearly inferior.
> 
> Sadly, with all the HW security mitigation, system calls are no longer cheap.
> 
> Would there ever be any other reason to traverse unknown open files
> than to close them?

I have had lively discussions and interestingly worded mails on account
of all of this. But noone has brought up this scenario. Florian also
said that it's not needed [1].

If we really want something like that we don't really need a new syscall
I think. We can just do a prctl() command or fcntl() command that will
give you back the next open fd.

There's imho crazy ideas out there what people expect a multi-close file
descriptor solution to look like. Service manager people apparently
think it would be a great idea to have a syscall that takes an array of
fds which the kernel is supposed to leave open and close all others,
basically "close all of the fds only leave out those I tell you".
I think for such a use-cases they can push for a prctl(PR_GET_NEXTFD, 2)
or a fcntl(2, F_GET_NEXTFD) and implement that in userspace.

I really only care about having a performant solution to closing a range
of fds that's a little more flexible than closefrom() without going all
crazy generic and copying (possibly) large bits of data between kernel-
and userspace.

close_range() is really something I've picked up on the side because the
current state has bothered me (and others) a long time whenever I have
to have my userspace hat on. With Al being in favor of it this seemed
like we should do it.
I actually wanted to have Jann's and my clone6() version on the table by
now since that would unblock larger things like the time namespace
patchset.

In any case I'll send v3 with my max()/min() braino fixed that Oleg
thankfully spotted and the split into two patches that Arnd suggested.

[1]: https://lkml.org/lkml/2019/5/21/516
