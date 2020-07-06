Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7AF215262
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 08:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgGFGIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 02:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgGFGIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 02:08:23 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD7EC061794;
        Sun,  5 Jul 2020 23:08:23 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id a9so91494oof.12;
        Sun, 05 Jul 2020 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1BjitBb0woJ/AqYDROx+THUx8rqaPKmjtehNi6j/8Q=;
        b=ga5k5Fm94tsxJPmvN5Qz7vnzhTrXfjjHXZPRCJk4df64cFFiydOPVyTPH0ugyCSmBv
         xWRchB3G2ib8qiIIc/u+kxh12gDUiatbOIKDJc3FPtvSMJadpa7v/WSUZyEauK6u2tOu
         FpaK1eFRuAC1ZlM5KhuqPgkHurDYWgY/Avrf5zUvwjHzIb7vgOc7AK6SNdpXhly8Kh3x
         ATbUHXPs2V1SeaUyTp1NUrhUNmtK/3BIP/MZU5OdftvpglEYIEw6JH5T+5GFM1A4E5/b
         jS5JfUrnuYKcLihWEv4AZR4g/l7sSbrZ3PAIO6P4giOKs+iSNEId1+CevqpFav0wkviq
         OJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1BjitBb0woJ/AqYDROx+THUx8rqaPKmjtehNi6j/8Q=;
        b=t11LlXrz0ini0Z3HNeMh/YaNder+20JR2vYZy1DCHZDE4tbWrIyp359i6tijlTVwtr
         lGALpRQ5+QMtJgLmMFwxnnxsSYOj3hpzXAmhFx/oYpGpSgC+O25/+shOWcAaDd7XS5nV
         S5Y9qqvGlLosKCrI8tj2eAasEBTK+27Vi2qsaw0scC/rP7gKj3+Lqf6km6a2snvrisVf
         Rcrb88R45cGzHkj14ojuN8ma9w359R2ZJnQKV2YnssDAyWziFlUpA1UZqCGmWZS5IFy5
         g/xzTC+D7GJP+SF+uf6bc2ospZHs6ivdDh1c/oh/wv/GxiaSBE+yPn07dL844v3YUtSh
         qK0Q==
X-Gm-Message-State: AOAM530zpA7hxvH14/TF0qxRSesPzxj//pvdzVugN/by1N0KTpsL8hU0
        bn0Q1nrGWEVTerJWQLuyPQiXjPhcdeDm3+HmAmxOitn6
X-Google-Smtp-Source: ABdhPJz/HAbhyuLArVmNsg/6kUXsngMITW3h2wuAxja2UJS9ppi60bItfwaYPKCzrBJBa4IuDePWvHpWPMn7amISmiE=
X-Received: by 2002:a4a:dfb5:: with SMTP id k21mr32478997ook.27.1594015702379;
 Sun, 05 Jul 2020 23:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org> <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <20200705031208.GS25523@casper.infradead.org> <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
 <20200705032732.GT25523@casper.infradead.org> <CAODFU0rSqQsO9rSiA8Ke=+mk_NgEdFDHPMfmXGSmzmkqQh1KYw@mail.gmail.com>
 <20200705115851.GB1227929@kroah.com>
In-Reply-To: <20200705115851.GB1227929@kroah.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Mon, 6 Jul 2020 08:07:46 +0200
Message-ID: <CAODFU0ovM-i=4fNKSzp9SgO_FjPcAOZ0R8S4iRXyGm+QL53C1A@mail.gmail.com>
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 5, 2020 at 1:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 05, 2020 at 06:09:03AM +0200, Jan Ziak wrote:
> > On Sun, Jul 5, 2020 at 5:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sun, Jul 05, 2020 at 05:18:58AM +0200, Jan Ziak wrote:
> > > > On Sun, Jul 5, 2020 at 5:12 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > You should probably take a look at io_uring.  That has the level of
> > > > > complexity of this proposal and supports open/read/close along with many
> > > > > other opcodes.
> > > >
> > > > Then glibc can implement readfile using io_uring and there is no need
> > > > for a new single-file readfile syscall.
> > >
> > > It could, sure.  But there's also a value in having a simple interface
> > > to accomplish a simple task.  Your proposed API added a very complex
> > > interface to satisfy needs that clearly aren't part of the problem space
> > > that Greg is looking to address.
> >
> > I believe that we should look at the single-file readfile syscall from
> > a performance viewpoint. If an application is expecting to read a
> > couple of small/medium-size files per second, then neither readfile
> > nor readfiles makes sense in terms of improving performance. The
> > benefits start to show up only in case an application is expecting to
> > read at least a hundred of files per second. The "per second" part is
> > important, it cannot be left out. Because readfile only improves
> > performance for many-file reads, the syscall that applications
> > performing many-file reads actually want is the multi-file version,
> > not the single-file version.
>
> It also is a measurable increase over reading just a single file.
> Here's my really really fast AMD system doing just one call to readfile
> vs. one call sequence to open/read/close:
>
>         $ ./readfile_speed -l 1
>         Running readfile test on file /sys/devices/system/cpu/vulnerabilities/meltdown for 1 loops...
>         Took 3410 ns
>         Running open/read/close test on file /sys/devices/system/cpu/vulnerabilities/meltdown for 1 loops...
>         Took 3780 ns
>
> 370ns isn't all that much, yes, but it is 370ns that could have been
> used for something else :)

I am curious as to how you amortized or accounted for the fact that
readfile() first needs to open the dirfd and then close it later.

From performance viewpoint, only codes where readfile() is called
multiple times from within a loop make sense:

dirfd = open();
for(...) {
  readfile(dirfd, ...);
}
close(dirfd);

> Look at the overhead these days of a syscall using something like perf
> to see just how bad things have gotten on Intel-based systems (above was
> AMD which doesn't suffer all the syscall slowdowns, only some).
>
> I'm going to have to now dig up my old rpi to get the stats on that
> thing, as well as some Intel boxes to show the problem I'm trying to
> help out with here.  I'll post that for the next round of this patch
> series.
>
> > I am not sure I understand why you think that a pointer to an array of
> > readfile_t structures is very complex. If it was very complex then it
> > would be a deep tree or a large graph.
>
> Of course you can make it more complex if you want, but look at the
> existing tools that currently do many open/read/close sequences.  The
> apis there don't lend themselves very well to knowing the larger list of
> files ahead of time.  But I could be looking at the wrong thing, what
> userspace programs are you thinking of that could be easily converted
> into using something like this?

Perhaps, passing multiple filenames to tools via the command-line is a
valid and quite general use case where it is known ahead of time that
multiple files are going to be read, such as "gcc *.o" which is
commonly used to link shared libraries and executables. Although, in
case of "gcc *.o" some of the object files are likely to be cached in
memory and thus unlikely to be required to be fetched from HDD/SSD, so
the valid use case where we could see a speedup (if gcc was to use the
multi-file readfiles() syscall) is when the programmer/Makefile
invokes "gcc *.o" after rebuilding a small subset of the object files
and the objects files which did not have to be rebuilt are stored on
HDD/SSD, so basically this means 1st-time use of a project's Makefile
in a particular day.
